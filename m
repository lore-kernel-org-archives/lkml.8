Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDCFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A782193E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vczFrOgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgIHCo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgIHCo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:44:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED2CC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 19:44:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so9742812pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0P27m9R7gToJuIq48PNYPlUAE0qvbBGpOoq6ApSizFo=;
        b=vczFrOgDy05uM4dJXuUq5Ps3zZiABg17INaardSitIE3ye5d3062684fRNHn84NPC9
         7YZJpHJUvukhiT+N01yyjPlmdCCHtOfLbqVfuUfkSZ/Bfz9n/UeC1kccWmBHpOR3B4DW
         H+43iY6EDTPUHzhyoWDs2O7K0DoaJKvS2Un9pl+yf+cHb4uCvdz9Fa4f9xwYlH2yEdws
         7w2NOEi9EYC+m6Xo390jyqtvGlSeGmIjJzwfizfnpVybkJo8c0HHD2gXFZPXO5zg2AGW
         VW34NRe4qmQoxkQnhd7EFGwDy+z2XhZpQRgbEKUS0NfEg/t3UwJua7qfFVrAtf1kuslB
         4ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0P27m9R7gToJuIq48PNYPlUAE0qvbBGpOoq6ApSizFo=;
        b=iIV6XHwRn5MiCylDX/mXoqnD2YYq2tbrsGjuXIjonqqS9Z7017psFRYtTFl+YwgKZM
         xvRq73oyq1h7pKUhWWodSErfslQHYHJQn7lMno5VlPQwp//uSMC0kAAlSDE4u0rNE9Zs
         BxIYwfBiBcM1OeEYSFvRtvf0VFodlLsjOW68bE19SAOUP6bGdPay07ae+TFBAY4JgEgZ
         a6cebkrRfbHHAffD5LtKuh8k6rTpVcWDS0cvDkB4ePd+q75lzzeVH1zaTc0AZz9XRBga
         PXoSxcZ9Kc76uAtzOmie8cNaHJWJ1VnzipqhgPq6emh8cbXGfOSMNqHTU8BEIM2lIaEg
         uPxw==
X-Gm-Message-State: AOAM533D908NX/kxXzl8+GE03I9A7O7xdoi4rC3ivwTxneHXCFJOpVL2
        HW3wc/DixVlaNA2smNn8dLzwRtOd6+g=
X-Google-Smtp-Source: ABdhPJwo/IKdZRdBXmJEAvfC/PKHjgUztBwGXwrKS+jA+PxL8ucfBWllRCUgMeb8MmTeDmOVSjWhaQ==
X-Received: by 2002:a63:4451:: with SMTP id t17mr17916980pgk.92.1599533067267;
        Mon, 07 Sep 2020 19:44:27 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id k24sm16237390pfg.148.2020.09.07.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 19:44:26 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3 2/2] f2fs: change return value of f2fs_disable_compressed_file to bool
Date:   Tue,  8 Sep 2020 11:44:11 +0900
Message-Id: <20200908024411.2692388-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200908024411.2692388-1-daeho43@gmail.com>
References: <20200908024411.2692388-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

The returned integer is not required anywhere. So we need to change
the return value to bool type.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c |  2 +-
 fs/f2fs/f2fs.h | 17 ++++++-----------
 fs/f2fs/file.c |  4 ++--
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 48cab85205e2..f30348063017 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3936,7 +3936,7 @@ static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		return ret;
 
-	if (f2fs_disable_compressed_file(inode))
+	if (!f2fs_disable_compressed_file(inode))
 		return -EINVAL;
 
 	ret = check_swap_activate(sis, file, span);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c615e75c82fd..a33c837e833a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3930,26 +3930,21 @@ static inline void set_compress_context(struct inode *inode)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
-static inline u32 f2fs_disable_compressed_file(struct inode *inode)
+static inline bool f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 i_compr_blocks;
 
 	if (!f2fs_compressed_file(inode))
-		return 0;
-	if (S_ISREG(inode->i_mode)) {
-		if (get_dirty_pages(inode))
-			return 1;
-		i_compr_blocks = atomic_read(&fi->i_compr_blocks);
-		if (i_compr_blocks)
-			return i_compr_blocks;
-	}
+		return true;
+	if (S_ISREG(inode->i_mode) &&
+		(get_dirty_pages(inode) || atomic_read(&fi->i_compr_blocks)))
+		return false;
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
-	return 0;
+	return true;
 }
 
 #define F2FS_FEATURE_FUNCS(name, flagname) \
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index adc4acad488a..d69def08e25e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1828,7 +1828,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 
 	if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
 		if (masked_flags & F2FS_COMPR_FL) {
-			if (f2fs_disable_compressed_file(inode))
+			if (!f2fs_disable_compressed_file(inode))
 				return -EINVAL;
 		}
 		if (iflags & F2FS_NOCOMP_FL)
@@ -3258,7 +3258,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	if (f2fs_disable_compressed_file(inode)) {
+	if (!f2fs_disable_compressed_file(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.28.0.526.ge36021eeef-goog

