Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0481D2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVqLVrvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRBeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHRBeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:34:36 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AA4C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:34:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m13so13294545qth.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ss4gQmNtASnD0qcw1Pmz+ZNnWye3v+ksEFLJ5TwdRrI=;
        b=YVqLVrvJz32CNYN0SavVT01fuNmXLnBixkX/3WKpjuXu8B3agog0DgkMQn7aAPaxej
         4sUSHnuBDI7IkD3MSPhbg1xSBO0eRBFjH97QHYmDSaMUvagzXaTtWXRLB1EkW9bNoYZH
         0Jh2nfWzTAIyYd1Z9iobO4II5nj/3bk9BMbpbp740YIyptzuOtPM4Cx7DXMOlTh+F3oE
         NkggkPVAznSsMubg7Az00UBOw+mxj9TnugEKPHRnkE3JBUoTKwfE4HrGlT4lEcxGfzlo
         FNu3rOjsHQZiY7VWBrwj024lN79j9Va+++go8SB0SdPS3KDaRSZOjhIMTvA/QY7UtG5W
         C7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ss4gQmNtASnD0qcw1Pmz+ZNnWye3v+ksEFLJ5TwdRrI=;
        b=cpJjPcf6eFgW+UytThsaZ0g2btdqj+CAYId7myR4hk8uHUZac0/BVpdUL9HRnycSud
         tZPD+WSft6QV/gsYSeeoglSPsND9Aw9BKrb36x576QT1yPmaHdfcUpClrx7ZKcbVi2KA
         JWR/nfwa9vWKwpRgnZcyVkicpMkn1DpQoAiPo1/j96kIuBcxDyi0JW6CmDyTZxeEe3fv
         3G8EtiXsDKCHgCAC5jWDLwEO4nzFU3StpYhcar7z99I94bhBzDRXLd9UO7++T4qJKt35
         CLldhiIB2e+4nlZ/gKEfOtAL2wFcs+7UaI8bV1LO40YPkAzuAAx+wozuK4YM/AzHCSb4
         sdDA==
X-Gm-Message-State: AOAM532yPKgzrSscqX6dHT0D2O2Cog8O4fn2l2M4F/WtHTHEQiVvg0dT
        gfmmUNfsevIyhkkfyi196J5nOvGPbw==
X-Google-Smtp-Source: ABdhPJynUKx2HlC9oJurYUYQuIls1blQtJeGLLyLCJERo9pctXPpATWySbks8CFq4G13MuOdA3uCL6ibCA==
X-Received: by 2002:ad4:52e3:: with SMTP id p3mr17194355qvu.70.1597714474854;
 Mon, 17 Aug 2020 18:34:34 -0700 (PDT)
Date:   Tue, 18 Aug 2020 03:32:02 +0200
Message-Id: <20200818013202.2246365-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] romfs: Fix uninitialized memory leak in romfs_dev_read()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

romfs has a superblock field that limits the size of the filesystem;
data beyond that limit is never accessed.

romfs_dev_read() fetches a caller-supplied number of bytes from the
backing device. It returns 0 on success or an error code on failure;
therefore, its API can't represent short reads, it's all-or-nothing.

However, when romfs_dev_read() detects that the requested operation
would cross the filesystem size limit, it currently silently truncates
the requested number of bytes. This e.g. means that when the content
of a file with size 0x1000 starts one byte before the filesystem size
limit, ->readpage() will only fill a single byte of the supplied page
while leaving the rest uninitialized, leaking that uninitialized memory
to userspace.

Fix it by returning an error code instead of truncating the read when
the requested read operation would go beyond the end of the filesystem.

Cc: stable@vger.kernel.org
Fixes: da4458bda237 ("NOMMU: Make it possible for RomFS to use MTD devices directly")
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/romfs/storage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/romfs/storage.c b/fs/romfs/storage.c
index 6b2b4362089e..b57b3ffcbc32 100644
--- a/fs/romfs/storage.c
+++ b/fs/romfs/storage.c
@@ -217,10 +217,8 @@ int romfs_dev_read(struct super_block *sb, unsigned long pos,
 	size_t limit;
 
 	limit = romfs_maxsize(sb);
-	if (pos >= limit)
+	if (pos >= limit || buflen > limit - pos)
 		return -EIO;
-	if (buflen > limit - pos)
-		buflen = limit - pos;
 
 #ifdef CONFIG_ROMFS_ON_MTD
 	if (sb->s_mtd)

base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
-- 
2.28.0.220.ged08abb693-goog

