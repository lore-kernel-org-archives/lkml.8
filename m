Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01264C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCECC20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623753;
	bh=OfYbMBkupsr+l/Y1Wzrt2o7/s6MDZG7EK6hEUMeaq34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PKL7DwKrEPW7qctLIZ9rrvy2+wksvGRfIf7tO4WgmyPPYK3QJaC9RTFOcxfofBjUz
	 YQOx3RjdpWiS6H2avpIGENtB71whdVer5oHx4lCpU48SIu2dNgHBGRm2u+8elf60w2
	 U/iUw0KmGY1cIWyUOUfRTHqvO6EeEK8WgLfow2oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgCSNPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbgCSNPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0FA20724;
        Thu, 19 Mar 2020 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623748;
        bh=OfYbMBkupsr+l/Y1Wzrt2o7/s6MDZG7EK6hEUMeaq34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6XV2aF88oAosIB0ZYJStweq5FQ8i/X2eqonv5rE8GKvZLdlmqTKMMWaU/18xb/TJ
         2wiO5mtNlif8hp+PIHQ9XDXvbqsI16lUji44l0QEywgjUYSr4IZ0JKYxA31Yz2GAuQ
         5gzBAP7pGt1hLzpscYHyo5VKfJd5EO2G3iAzg66U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/99] netlink: Use netlink header as base to calculate bad attribute offset
Date:   Thu, 19 Mar 2020 14:02:46 +0100
Message-Id: <20200319123944.011605516@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 84b3268027641401bb8ad4427a90a3cce2eb86f5 ]

Userspace might send a batch that is composed of several netlink
messages. The netlink_ack() function must use the pointer to the netlink
header as base to calculate the bad attribute offset.

Fixes: 2d4bc93368f5 ("netlink: extended ACK reporting")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2389,7 +2389,7 @@ void netlink_ack(struct sk_buff *in_skb,
 							       in_skb->len))
 				WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
 						    (u8 *)extack->bad_attr -
-						    in_skb->data));
+						    (u8 *)nlh));
 		} else {
 			if (extack->cookie_len)
 				WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,


