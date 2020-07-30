Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C78B2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdyooRrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgG3FJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3FJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:09:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A1C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 22:09:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so37919plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=;
        b=fdyooRrCV2FclnceL3/Yy52L/nRYSE9ERsZFzzFuLa3JmRzvQwUDzkKA7/vTPmKPJ9
         Caeb7dcjTkKReY5z4JeUlDtndhMDeNlHdqSVIhtH3otK8TY1/2N6EUsLwv2eFSbw/C4R
         OwsdfK2BJMI25F1/ytu4jlRYHSyR1eAlbOZiWVO2x9DTyNEOBqS12k7Zlx12Bbv89L5u
         r2DWb2jJ3w6AMa35/wrUiSSuB5n8ewiT40jWARpeXMLeh66v/y/DNDzRS+yC5x2iDLYi
         RfMuO1bo1wAtts0VaskgEoIhQcbSgUrglP1bbuzoTQK38R9sQOVCFIm1P5kE3bv6Bgj9
         2GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRoZs4D1CNYfrOlS/aIbzgfYQ1SktXdRegTngPqrg14=;
        b=sUn8pnYRhmPlhJjFtGdD4ybn/4yFDQ4c2AqHCFOuDrDIgw5EHy6vaicpcYUQp7Ta4F
         XZ1jrS6a955GVX9Yn1inF+jHql461lYTokMOjQCSEnpR9GiccsRI8D06VUGfNKoWAJ7F
         r6DdFFkMrEkBhyCDXGcDVIcPiEi4Mu8M7s6qZdfYf8uV8pzDNYotEbdQy7cRlAa96fI2
         lkt+1wAKiBQwf/PPCME1HCfuilBH+bJFwuTCw22RDjjAEG8p2UhQw20EnoJIjbuKYv8C
         Kk2Fju5IUgrJ9R3Y0AOtSRgY7l8VkjOYHWc4jFkYpxrJO30HBpmN1DkZGFSmgmvfd89h
         YSGQ==
X-Gm-Message-State: AOAM532r2eKcrWgwFEn+knDAgs2cc4Gtv6vWNkPoXSCgF7qLaO32jBhI
        ONlI+B4nyUFilXuaXyEq+Yf1CGqqeWg=
X-Google-Smtp-Source: ABdhPJzhloODSlqZ3SGmchjbJDqStVbAQ+Gk407WqgbI1VfbjtKH+UMNMIzktYU3EmXJczDNA+Tfng==
X-Received: by 2002:a17:902:7d90:: with SMTP id a16mr29784015plm.226.1596085776116;
        Wed, 29 Jul 2020 22:09:36 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id q3sm3690057pjo.16.2020.07.29.22.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 22:09:35 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: make file immutable even if releasing zero compression block
Date:   Thu, 30 Jul 2020 14:09:28 +0900
Message-Id: <20200730050928.356916-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

When we use F2FS_IOC_RELEASE_COMPRESS_BLOCKS ioctl, if we can't find
any compressed blocks in the file even with large file size, the
ioctl just ends up without changing the file's status as immutable.
It makes the user, who expects that the file is immutable when it
returns successfully, confused.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc7f5670390f..8a422400e824 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3535,14 +3535,14 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	if (!F2FS_I(inode)->i_compr_blocks)
-		goto out;
-
 	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
 	f2fs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

