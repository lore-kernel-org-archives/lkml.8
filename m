Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C36320738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nKrCgSI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406051AbgFXSRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405757AbgFXSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:17:24 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861EEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y6ePOy+s2OgReiLHVyBFKRJm25zmCB05tBdu9UNqvHM=; b=nKrCgSI3jE49GN/qGTpeNKYFRJ
        bLlyi7nfV75vMHXSJbN71K1YDwrI+81e+T/PTLWzeeyKs8O09EaeEQYeyOdflJmhIVGVb2q0T3hZE
        h4dokYQkyz1pzRE6mgVifuVuNZ/ZXogoqkrWc0gsXeFfgvdHNiPGbSECbFWqecxjwhDCYnd/vCQbb
        pmjcEUJdX2R3Yzm9BAdTopvkUc7S4WAiwV/xEIqRVoxDHDfUJujm1fSQzbyT2kqWWB2bzUwTxEHli
        5A/+pvPtBYOGVB3/fSXqwG4QKMzUDmFuRy/GTvxVfYA1YyaDjoWPYo4frY7BQGN3GN9Ad223uhbFX
        2wq0EpfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo9xL-0003qO-Ec; Wed, 24 Jun 2020 18:17:07 +0000
Date:   Wed, 24 Jun 2020 19:17:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: Call sysctl_head_finish on error
Message-ID: <20200624181707.GS21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This error path returned directly instead of calling sysctl_head_finish().

Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c..c02f94b52892 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -566,8 +566,9 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
+	error = -ENOMEM;
 	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+		goto out;
 
 	if (write) {
 		kbuf = memdup_user_nul(ubuf, count);
@@ -576,7 +577,6 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 			goto out;
 		}
 	} else {
-		error = -ENOMEM;
 		kbuf = kzalloc(count, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
-- 
2.27.0

