Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC2CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13A320675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mFGEGHx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGGRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgGGRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DACC061755;
        Tue,  7 Jul 2020 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rF/h+g2aRvM7O684xTgcwq5WjNPNPSLZJBoCztHySj0=; b=mFGEGHx2eqHf2GAe5IHSpAddv6
        AbSrUPzSK75vbu/Zf7WkR6KQ1V4imkhSYcjovGcKVS8O07Yz3yjudqmrdLUJ21wAFNmjLcw0hEO3N
        VMSRsA61DPftGVp/9S9C0EaTIKdwfsv1kMbr8iJiEB02gFiU3jVeVimem1xvDUJmjc1j+I2AmoWzC
        H6Yq+UfIr+T0Pms73rNbaQiL50zuj1mp1Iig3W/+4ZWiQWlH4O6s7Ixz5vaSRN2gBPe1ez8xLJZSl
        MTCfQNc/igRpR1qvppp/9dHeCy5Kn6o/NWJ/xeKRhQH0UakZouzv3kF48NfaYcKsvKCplzRqMIrUO
        72NIfuxw==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhY-0003Iq-Ee; Tue, 07 Jul 2020 17:48:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/23] fs: implement kernel_read using __kernel_read
Date:   Tue,  7 Jul 2020 19:47:49 +0200
Message-Id: <20200707174801.4162712-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the two in-kernel read helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_read, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index cc8e0b4f3cd697..a0a0b5d1d9249c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -455,15 +455,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t result;
+	ssize_t ret;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	result = vfs_read(file, (void __user *)buf, count, pos);
-	set_fs(old_fs);
-	return result;
+	ret = rw_verify_area(READ, file, pos, count);
+	if (ret)
+		return ret;
+	return __kernel_read(file, buf, count, pos);
 }
 EXPORT_SYMBOL(kernel_read);
 
-- 
2.26.2

