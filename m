Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340BD206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034276;
	bh=G628uByIFbUUwJ4W0M0r+ZOPZttaSm3OuTllI/xueRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kxRTyqCGc0mccacDWGHLexVpVyWjHv9oQTUzpUD1/pB9ArA5EdLlLpJHbiTY41an2
	 qS1oKBoUZBo2Ga09JR5DeHru9crTNMJpKnxAap1IRuo8x1e+hF+DJKgfa5X+NKZzqU
	 6cwWDdFUu2LrB4iju2Dus+YUmyIsUstGceRQPjcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgFAR5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgFAR5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:57:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E832207BB;
        Mon,  1 Jun 2020 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034272;
        bh=G628uByIFbUUwJ4W0M0r+ZOPZttaSm3OuTllI/xueRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lefkeq82DFVVjsiY5Jg7AwfIfWc4+8Kq8rtgUQg31S0Ior+F1tm17i9KyCp6j8Xty
         ylrfqycDWL5fQPkACGQy65lvbRKaHTZvc58Fihn5svUa3wjkFlkwN16b5xQMzmxNzL
         6pL2A4+X+sobXsrc1pd1jDgA7o8Rb/qO1+pkUysg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/61] net: ipip: fix wrong address family in init error path
Date:   Mon,  1 Jun 2020 19:53:09 +0200
Message-Id: <20200601174011.237613162@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Fedorenko <vfedorenko@novek.ru>

[ Upstream commit 57ebc8f08504f176eb0f25b3e0fde517dec61a4f ]

In case of error with MPLS support the code is misusing AF_INET
instead of AF_MPLS.

Fixes: 1b69e7e6c4da ("ipip: support MPLS over IPv4")
Signed-off-by: Vadim Fedorenko <vfedorenko@novek.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -689,7 +689,7 @@ out:
 
 rtnl_link_failed:
 #if IS_ENABLED(CONFIG_MPLS)
-	xfrm4_tunnel_deregister(&mplsip_handler, AF_INET);
+	xfrm4_tunnel_deregister(&mplsip_handler, AF_MPLS);
 xfrm_tunnel_mplsip_failed:
 
 #endif


