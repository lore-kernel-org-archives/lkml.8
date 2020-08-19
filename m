Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B92C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DE02078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ElW0HqjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHSFT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgHSFT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:19:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C507C061389;
        Tue, 18 Aug 2020 22:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0xtII03aY1sMWDNlNgJtnoIL3vhRsrk36uree1jHzx4=; b=ElW0HqjJ7mt+amGMbev8PXlKvD
        R/VRen2NGsysJ+N1f6hWPh0lF5skZHdNhgphqwtEJUrFYti1UOGHcKtn2VKTFugFqYwyWv06i5DfA
        qTROS7b4Wlp5OoXtNUQAuS/ZGZK+mOdqYgMy1y1KLMXsFtO1CAXmkZpFshVME8GfdLQpgiXrWjyLG
        84NGNCq4x0ZESkm5LkYdhAOTRLjYc8IqTAXLDF/bA+bTL7p9i/v0mWXpBshv8DMcbxEKw+23TaSdx
        /GW+2xPb8VrirmzOBy+zXh2ydoKX1UAWJa4cBX9LrNPG5pYQGF4GZ+cJP+cc0/GaLibcODjUXonHm
        lvonc9tQ==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8GVn-0002aC-4V; Wed, 19 Aug 2020 05:19:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     colyli@suse.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: bypass ->sendpage for slab pages
Date:   Wed, 19 Aug 2020 07:19:45 +0200
Message-Id: <20200819051945.1797088-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending Slab or tail pages into ->sendpage will cause really strange
delayed oops.  Prevent it right in the networking code instead of
requiring drivers to guess the exact conditions where sendpage works.

Based on a patch from Coly Li <colyli@suse.de>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index dbbe8ea7d395da..b4e65688915fe3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3638,7 +3638,11 @@ EXPORT_SYMBOL(kernel_getpeername);
 int kernel_sendpage(struct socket *sock, struct page *page, int offset,
 		    size_t size, int flags)
 {
-	if (sock->ops->sendpage)
+	/* sendpage does manipulates the refcount of the sent in page, which
+	 * does not work for Slab pages, or for tails of non-__GFP_COMP
+	 * high order pages.
+	 */
+	if (sock->ops->sendpage && !PageSlab(page) && page_count(page) > 0)
 		return sock->ops->sendpage(sock, page, offset, size, flags);
 
 	return sock_no_sendpage(sock, page, offset, size, flags);
-- 
2.28.0

