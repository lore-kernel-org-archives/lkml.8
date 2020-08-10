Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623E722CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073305;
	bh=u/EJEC7fwlnjfYmjRVebmZuNlug14uzNDm4KhwNNuzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vupM3XI0iP6RXs17RYHuTzUUkcA+Q9ydfkXZlYVASYSrBJCf/VC9cBjGeCa2+2XcX
	 wDc6gTi0hRgTprJ2RNwUTxeyS4qS4ayw78l8wqx+nUDIDzW1IOkmr/bmCfDNgJ80+p
	 KdKwX+W6a3DhZemg/2YmsiohhZM2se7oz931Fj2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgHJP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgHJP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:28:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650A122B47;
        Mon, 10 Aug 2020 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073292;
        bh=u/EJEC7fwlnjfYmjRVebmZuNlug14uzNDm4KhwNNuzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=US/L+ZmnemVgUoYp4LsbREieE1xEYHXjA3DXwFfRcegljFdTQEzH91myUhnL0Nidm
         H8j3QX9s0jjFCyqGD+q1NENBXmbiJXw1Ub2DtbcIiSZuI/CGFMbVn/5I/BTOoLluGw
         0osEb7hnvAgKNESRDCfDWxqPcObyricZbFIjwpgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 52/67] ipv6: Fix nexthop refcnt leak when creating ipv6 route info
Date:   Mon, 10 Aug 2020 17:21:39 +0200
Message-Id: <20200810151812.040621550@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 706ec919164622ff5ce822065472d0f30a9e9dd2 ]

ip6_route_info_create() invokes nexthop_get(), which increases the
refcount of the "nh".

When ip6_route_info_create() returns, local variable "nh" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one exception handling path of
ip6_route_info_create(). When nexthops can not be used with source
routing, the function forgets to decrease the refcnt increased by
nexthop_get(), causing a refcnt leak.

Fix this issue by pulling up the error source routing handling when
nexthops can not be used with source routing.

Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_info")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3686,14 +3686,14 @@ static struct fib6_info *ip6_route_info_
 	rt->fib6_src.plen = cfg->fc_src_len;
 #endif
 	if (nh) {
-		if (!nexthop_get(nh)) {
-			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
-			goto out;
-		}
 		if (rt->fib6_src.plen) {
 			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
 			goto out;
 		}
+		if (!nexthop_get(nh)) {
+			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			goto out;
+		}
 		rt->nh = nh;
 		fib6_nh = nexthop_fib6_nh(rt->nh);
 	} else {


