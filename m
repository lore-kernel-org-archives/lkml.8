Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929FC20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5L2rRMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGAUXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgGAUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA1C08C5C1;
        Wed,  1 Jul 2020 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ruv3QkeH3yf1ddYt00bBWdUvSXa4YUB7wJ/k+J42Rps=; b=K5L2rRMJRCFryNVAeoPi8yhxSg
        hIaTQtu2RdfQHH3dGsBrnTv7PUQTpvAQG9I5DrdPn6TTSUQXtYrc4LCvavU9l670HZqSZg1G76zvq
        8yyQta3013T1/XABbclufebPJLH8HI2E5hcQMrEPwquacKHlUEaxdFTFWLz/hfehOJc4iY5ikhUCj
        KxD95fwF5+nPcVRke2uw1Y+fnfGDRzc0rhUccoSW5V24KUCmI4Ur+MVloC7S+cumwJjoivUHXOjcR
        GMFXpjnNrr9YSgAe53CNUjG1inJe3pgxtC59GZsmYPYaD5F1VwaqBQ2QniVlZIp/JPGJDT3VdTOql
        aOcCgfiQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjG4-0002P7-0I; Wed, 01 Jul 2020 20:23:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/23] fs: check FMODE_WRITE in __kernel_write
Date:   Wed,  1 Jul 2020 22:09:33 +0200
Message-Id: <20200701200951.3603160-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a WARN_ON_ONCE if the file isn't actually open for write.  This
matches the check done in vfs_write, but actually warn warns as a
kernel user calling write on a file not opened for writing is a pretty
obvious programming error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 2c601d853ff3d8..8f9fc05990ae8b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -505,6 +505,8 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	const char __user *p;
 	ssize_t ret;
 
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_WRITE)))
+		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
-- 
2.26.2

