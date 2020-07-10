Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC5920748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax9JFe+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGJCPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:15:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 19:15:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so1828172pgn.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=;
        b=Ax9JFe+xCSrnS5iZU07rdj4BMegbKRHByEA8KIB170r2p1prZMYiQAksTM9eePOgkC
         KARvN11mXFlZAJDSrxVeHL1H6nMIPbDpWBOuv4n43DtfSn7p9IvAScA6o20QG66Y7R4W
         jxn2azc1m+a04Ntx+D8JD+Eczob/PWHJnVxQ6SDWIGNzbPMzrsL/h6aQ0H6zqyC7smwM
         Tg8GNZFODhVFkwp0XnLWkGl9aTqy/89dr29vGrZmftswi8hiOYYAKOMEnQbDCVlHM78v
         llSDRikRevxxx8UoFfKBhrPXZrOvsV9oHK9MGC0mid+jFw7AbHue6UZvt3viR06NewKZ
         QORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkQSECiHHKjY2wMf5WdW+4+ngmPLR5hshwDsZDOZ0qY=;
        b=XITLGbE0M3SGW8zBThGvsY21MUVjNzoSXOrarFzsLM7ZyKHdVn77nm1q/BKe9wxV6K
         uNKbE7GBcomcG/sjtA20zNGCRkryfWHRkMkp6MaQbexWNq5p+zUmdqjRxvWei+MBpeV6
         PZwCgT9327ND4ahSuYEIa23yxO/3OEvpUz+GZQ5wK3XvubRgZDKt7dpfHWHHHzCMvI0S
         aI8UEptTgB9ohmDpapXIGD/7MHeOwif2j9TONlMCjVumPbueOG3d61O1WlKMatRIOllc
         R1RxkItfKuTfHu6BxJeUm0SQNH+vv1mi0heYb4pTEu6GBju1BVw1G26AdjgqjQwCeCRI
         tRig==
X-Gm-Message-State: AOAM5327s/2F+Z2uW76dx+yrQhHL2quCWstfNxFyhmH036nR9uhQNo5I
        i6EDlCwsi93cKTTkYiN9ZKqReou3D+U=
X-Google-Smtp-Source: ABdhPJwpYkmZ/KMKHhtbV3Hu1nYb4/nC7sN7C42DNAWlijZqn0K49dgejQ93gXTEHUhacz5lDin4Lg==
X-Received: by 2002:a62:e206:: with SMTP id a6mr53727039pfi.24.1594347312716;
        Thu, 09 Jul 2020 19:15:12 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([172.30.115.29])
        by smtp.gmail.com with ESMTPSA id y18sm4190687pff.10.2020.07.09.19.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 19:15:11 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change the way of handling range.len in F2FS_IOC_SEC_TRIM_FILE
Date:   Fri, 10 Jul 2020 11:15:05 +0900
Message-Id: <20200710021505.2405872-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
 1. Added -1 value support for range.len to signify the end of file.
 2. If the end of the range passes over the end of file, it means until
    the end of file.
 3. ignored the case of that range.len is zero to prevent the function
    from making end_addr zero and triggering different behaviour of
    the function.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 368c80f8e2a1..1c4601f99326 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	file_start_write(filp);
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
+			range.start >= inode->i_size) {
 		ret = -EINVAL;
 		goto err;
 	}
 
-	if (range.start >= inode->i_size) {
-		ret = -EINVAL;
+	if (range.len == 0)
 		goto err;
-	}
 
-	if (inode->i_size - range.start < range.len) {
-		ret = -E2BIG;
-		goto err;
-	}
-	end_addr = range.start + range.len;
+	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
+		end_addr = inode->i_size;
+	else
+		end_addr = range.start + range.len;
 
 	to_end = (end_addr == inode->i_size);
 	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
-- 
2.27.0.383.g050319c2ae-goog

