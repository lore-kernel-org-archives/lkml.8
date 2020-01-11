Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E5C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB6E2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737192;
	bh=FKtjPjpbJUTRIEuCuS8N8QyyKbF/721xh1pmYRGZG20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AEVcmQp7vX4Rjs9HcWXhT++puzlrHZLU6tKdhG1UbosTAr296wLuXAXDHQom1VfPX
	 fL03hm9tCOfShGKYB8UOLS1UZdVRDpL5UvGOZZLkAmH27GDyXFYCBeBDzyFEuWBe8H
	 a2Na80qjZYvnLkMWpxJuTLaePhD7LBd8nxJI3HkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgAKKGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgAKKG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:06:29 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F782084D;
        Sat, 11 Jan 2020 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737188;
        bh=FKtjPjpbJUTRIEuCuS8N8QyyKbF/721xh1pmYRGZG20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KerqzRkBxdQnOSMseDFjat4M6jC0GpF2W7vl4bT5WnBMeOWTaerlBnbtb9ciSrc1l
         /VtIwktp6v/IpFWPci2bGXmCTpmvhqQu7bm1eMdqjwJ/MDyWz2b9Vo9BziQY95n6Al
         DxyKiVpek7b4RDVYnqsyccMM4tlHF+7q3xI3ZVtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 86/91] vxlan: fix tos value before xmit
Date:   Sat, 11 Jan 2020 10:50:19 +0100
Message-Id: <20200111094912.922519274@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 71130f29979c7c7956b040673e6b9d5643003176 ]

Before ip_tunnel_ecn_encap() and udp_tunnel_xmit_skb() we should filter
tos value by RT_TOS() instead of using config tos directly.

vxlan_get_route() would filter the tos to fl4.flowi4_tos but we didn't
return it back, as geneve_get_v4_rt() did. So we have to use RT_TOS()
directly in function ip_tunnel_ecn_encap().

Fixes: 206aaafcd279 ("VXLAN: Use IP Tunnels tunnel ENC encap API")
Fixes: 1400615d64cf ("vxlan: allow setting ipv6 traffic class")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2104,7 +2104,7 @@ static void vxlan_xmit_one(struct sk_buf
 		else if (info->key.tun_flags & TUNNEL_DONT_FRAGMENT)
 			df = htons(IP_DF);
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(RT_TOS(tos), old_iph, skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, &rt->dst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
@@ -2163,7 +2163,7 @@ static void vxlan_xmit_one(struct sk_buf
 		if (!info)
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(RT_TOS(tos), old_iph, skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),


