Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE22C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A432E20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea5b/yOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgE0ECo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgE0ECn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:02:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:02:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cx22so930163pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=;
        b=Ea5b/yOr0ZEjDMlwSBwK+l5ZsIJ+PqMFEO5MA6TfdyDCcSENA+WOIflT3B1Cw10fPh
         5sYGtgm8uMBE1czEC+5Q6RLS0zaBKiqdE9iidYWuF5MzBuNa/zGyLan6r6Yj7JOAul0o
         8oxwT7bfUiv3s6hXNHqdx5Ww8LPIN2YGVVH1uF/Gcdf55Yl7252/xsI9umtSJKpEQVYF
         ur+ZElsaZjcmPCG9nvmfFaIsBCOoo1mhZjc+RxnXlWXAb2ojz/40Kn7cb2Jfe1RI9VPG
         UHwdBSuDqL3qhWbxHm9NMp3VZaSxzFJps7F/tY/jhPTW6pSWbxUw9m1Zu4Nw2QmiFX2n
         6GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=;
        b=DhpYpJcoUU/HVIKNew2qPdrJu6hDi5GDCksxiTvIG5VX2fA5dntND0R0jG3WxOqA3J
         HU3Z1XbZn6lR2EsLze45YWTghEperFM5sei2YrwQFCXQvtWAXoGT49Raky4mwjJO5nYa
         tKdmJ6MXNic2GAJ0EaPlIgOuSKHtnA4XftFhHVrPOzYJv5/6bv0vR0llmUfGzxqo7FxK
         6lEtFlmK4FRzZ8ocZTX2Z03NucvCbmwSeUK2bbW+nDvGqQbZAPhY4s7WKyyBOGGDmM+y
         CXuycggbmKENGDKzhyV0roOPNRKufArTxU2YPLr8MN4WJZyi8AOVOvsLYvUmc9TnW1as
         0XkA==
X-Gm-Message-State: AOAM532R0Ja/0DGxhBwkWjda3tz3KRfzb+8GoDHS6HAB6ZOASvkDh9DJ
        B3H5qYIX64QtR6WqzCfbU46VjJ7fil+yVFRX
X-Google-Smtp-Source: ABdhPJysSqvqnQ/9Ue5bcz7zpgWjHw34v7o+0V7YTkhJb2z749Hqtu/41w7UlNOK9ngfynNsYL22Dw==
X-Received: by 2002:a17:902:7c16:: with SMTP id x22mr4072964pll.244.1590552162218;
        Tue, 26 May 2020 21:02:42 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id e5sm797494pfe.121.2020.05.26.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 21:02:41 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: protect new segment allocation in expand_inode_data
Date:   Wed, 27 May 2020 13:02:31 +0900
Message-Id: <20200527040231.70891-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Found a new segemnt allocation without f2fs_lock_op() in
expand_inode_data(). So, when we do fallocate() for a pinned file
and trigger checkpoint very frequently and simultaneously. F2FS gets
stuck in the below code of do_checkpoint() forever.

  f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
  /* Wait for all dirty meta pages to be submitted for IO */
                                                <= if fallocate() here,
  f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META); <= it'll wait forever.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f7de2a1da528..14ace885baa9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1660,7 +1660,11 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		down_write(&sbi->pin_sem);
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
+
+		f2fs_lock_op(sbi);
 		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
+		f2fs_unlock_op(sbi);
+
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
 		up_write(&sbi->pin_sem);
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

