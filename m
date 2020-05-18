Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA11C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9320674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823945;
	bh=xy+Y9XI0kG1f8Pu63JShmxH5Fg/KC5WG2EGzsp6SV2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rD7F3DbKbG6MROccMvCJ1XgtA9PjPAq6y9rnLY0DYTruq0fufb2meSPXY7Yvn2vd0
	 eu5tEpvbZ9Rt4EopKua5ogKAQlD4QpPWst88CaA9rSaplbDV/mZ2hbyuIw6XjtGNTo
	 V/CtwbQcolGG4Xkt6LzpnKELavsiTR/4gcLPw9p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgERRpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgERRpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789D420657;
        Mon, 18 May 2020 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823934;
        bh=xy+Y9XI0kG1f8Pu63JShmxH5Fg/KC5WG2EGzsp6SV2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vvFrZMopJlMo5z4Ts/3KqW+akAFIDz/wAbQ6fpi15HBrdQezwsydaa5eiTTu5fnpL
         eYORbCR3rdy9MPNtAZC2z7V3UPCL85Hkiu87RoKytE2COLpZsAAbys5ZZNeJjhaHlw
         55z+V9OMTzpaCsTIcmwOsifNLyVskmVWDWQSa8PU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 70/90] Revert "ipv6: add mtu lock check in __ip6_rt_update_pmtu"
Date:   Mon, 18 May 2020 19:36:48 +0200
Message-Id: <20200518173505.463294723@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej Żenczykowski" <maze@google.com>

[ Upstream commit 09454fd0a4ce23cb3d8af65066c91a1bf27120dd ]

This reverts commit 19bda36c4299ce3d7e5bce10bebe01764a655a6d:

| ipv6: add mtu lock check in __ip6_rt_update_pmtu
|
| Prior to this patch, ipv6 didn't do mtu lock check in ip6_update_pmtu.
| It leaded to that mtu lock doesn't really work when receiving the pkt
| of ICMPV6_PKT_TOOBIG.
|
| This patch is to add mtu lock check in __ip6_rt_update_pmtu just as ipv4
| did in __ip_rt_update_pmtu.

The above reasoning is incorrect.  IPv6 *requires* icmp based pmtu to work.
There's already a comment to this effect elsewhere in the kernel:

  $ git grep -p -B1 -A3 'RTAX_MTU lock'
  net/ipv6/route.c=4813=

  static int rt6_mtu_change_route(struct fib6_info *f6i, void *p_arg)
  ...
    /* In IPv6 pmtu discovery is not optional,
       so that RTAX_MTU lock cannot disable it.
       We still use this lock to block changes
       caused by addrconf/ndisc.
    */

This reverts to the pre-4.9 behaviour.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Fixes: 19bda36c4299 ("ipv6: add mtu lock check in __ip6_rt_update_pmtu")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1373,8 +1373,10 @@ static void __ip6_rt_update_pmtu(struct
 {
 	struct rt6_info *rt6 = (struct rt6_info *)dst;
 
-	if (dst_metric_locked(dst, RTAX_MTU))
-		return;
+	/* Note: do *NOT* check dst_metric_locked(dst, RTAX_MTU)
+	 * IPv6 pmtu discovery isn't optional, so 'mtu lock' cannot disable it.
+	 * [see also comment in rt6_mtu_change_route()]
+	 */
 
 	dst_confirm(dst);
 	mtu = max_t(u32, mtu, IPV6_MIN_MTU);


