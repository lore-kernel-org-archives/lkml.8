Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17167C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94BD207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVeOx7bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgFZH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgFZH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:59:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34895C08C5DC;
        Fri, 26 Jun 2020 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Tf3n/nAccIE+s6qWSUTEFb74RSxLQMp+OwHpsijS1gA=; b=PVeOx7bXiI9U+5/1XV/UP+xUkj
        8g8k1a0ybBtZg7UaqDJBsxUJn9GKNWcOWj3pVktYqdmTKPpYVFV358uSrKuA5WrLV2W1dkftY/qsD
        ejg4OKy70DcvTj5KXmkS9BbnFXGrUitC0IANKHXjVkxLsNG2NBUW9ZT+DMj2tbAZ5qzDUBEqRDMOX
        nCGwga7UsFl0MPbSMhX7wsAuMSxn4Y4ObiNvtR+r8eyOUKpiyQ0kv9YXbKUvc8DESql8aXrHpXKXV
        kc1l6phRSPtJ47htPV0Wi+aaHt9ejKxvTJswMcnr/v+0giWnnrh8ID0JCVQPOFjlR3lpI2NgHzHu2
        aDbzVE4A==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojG2-00070O-7k; Fri, 26 Jun 2020 07:58:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] sysctl: Call sysctl_head_finish on error
Date:   Fri, 26 Jun 2020 09:58:33 +0200
Message-Id: <20200626075836.1998185-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626075836.1998185-1-hch@lst.de>
References: <20200626075836.1998185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This error path returned directly instead of calling sysctl_head_finish().

Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/proc/proc_sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 42c5128c7d1c76..6c1166ccdaea57 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -566,8 +566,9 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	/* don't even try if the size is too large */
-	if (count > KMALLOC_MAX_SIZE)
-		return -ENOMEM;
+	error = -ENOMEM;
+	if (count >= KMALLOC_MAX_SIZE)
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
2.26.2

