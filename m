Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FDA20678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+nVziuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFADDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgFADDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:03:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94978C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:03:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so3403005pje.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HadkBgfXSvOfA9Fsm3GngQ/GKJaEcnZZDK/WEOwrtLQ=;
        b=E+nVziuPYFDx9OPuREfXXWQ3zM3OZkXI7nyBKlK2dCE83jGCQ6GM9qdl9YCy6hkQme
         VKD9VQFLWtaG0H98z3XMEnsunY32HRSyHk1vTuWd07zz/8XIZgbkGTbJZOYIELO1PQlq
         v7Iy+E4/LPQN5AM2F81SFoDbieOULD0hbLQHKHQ26Cj0Qx7nysTZJAm8esDTIfhbWFqC
         YuVYE1yGiPEjE/kME1raCRwcxcPoDdmft/9Lia9J4DheGLuJxpDpGRem/0KHR2Kss8GA
         mFu5iufKaxRW8EmtdofajikX+qtPyQsHykLO0NghYpsmrX5D1ee+dddcjBQCV0ODp0Hc
         MHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HadkBgfXSvOfA9Fsm3GngQ/GKJaEcnZZDK/WEOwrtLQ=;
        b=sZVGjOMVClzz9IXRrBsaEk63qtSpmtGoD4XFTuQfzKIR5dsYyz1teJVgagIpoyBueB
         XfJMM4gWdbZpKNjEQZ7CAL9lSKrbWNNLcaIqMj4JyFWukiVUV7iQGSlg5cCjN7g0Hjfj
         8tpKaTkSxX0IC9DDVpJ/3IXEFrrfPbLwHl49xMAch0CDP7H8iQf1px/t0sN+vDW39KK0
         wD8Wg1RKGByn4wZPmEiRxXLlMlFsx/J+y/3TSMUvowtgZuHNWstZbVy5u5rdKcxtX3PG
         iXtFtsUAdZz94MA7T4eTuxsKRizUMsjXNhrmu+NlrjdLlGdBaeyV0AIopV8i0/JnWewC
         HIhA==
X-Gm-Message-State: AOAM532iBGeeVyhIXPvPiNBXTNL3k7tHrCDyIjQdlGn2OpjWcBEsDepn
        Mrw9B8dRBbStMyZPRTETgt/mn6tz8kephQ==
X-Google-Smtp-Source: ABdhPJwxtN/vAjXXA+l8/UtASUXUx/s/K35KFUO3vjZQcIlpVB5qCr6eFRZboIt3GPFfWb5G9bysYg==
X-Received: by 2002:a17:90a:64ce:: with SMTP id i14mr20986083pjm.48.1590980633691;
        Sun, 31 May 2020 20:03:53 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
        by smtp.gmail.com with ESMTPSA id l23sm12589084pff.80.2020.05.31.20.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 20:03:53 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: protect new segment allocation in expand_inode_data
Date:   Mon,  1 Jun 2020 12:03:47 +0900
Message-Id: <20200601030347.112984-1-daeho43@gmail.com>
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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
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

