Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6E6C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C255206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKgoh20y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKEpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgIKEpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:45:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C801C061573;
        Thu, 10 Sep 2020 21:45:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so5744251pgl.4;
        Thu, 10 Sep 2020 21:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQXurXm25NcMdooLPinVDFaLX3POiP/2UA+AXolV4yc=;
        b=UKgoh20yKZuTLAUbo6VldhPrQS2MUUY/nZO1Asco/BpA9BEemrd2k/rIMjdoa5jcln
         M1cmb4XzqPAzwFFZX9+ls7TbrO21FGcWe1aoXkU72mIXhHRvUJzzeuBojwEFFWuznMEi
         dYUxoPAU2oXBjssctog8vGnqIHNl7sDVe9a+cmNYmTbsJCXQLueLnZ0/qmTMYrfCLZwK
         XqgUviSApk6faA6BgOnEn+HWI7Cd9TmeXvjSNbd93wcgFKFXJL91rBP1pFWHoGGzTYU0
         Fe37kPqLkicnLHzlKxeh5gCR/Y9aGB2QfJHoJgUWCEHoSD8imdrI8vSDlC1JRFUnQZBF
         8c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQXurXm25NcMdooLPinVDFaLX3POiP/2UA+AXolV4yc=;
        b=arqSivd6D3+Mp1rh5XgDG7HLqoG+TCT6Qap7saszydH5TPN5IEDguqe3TGfyEgJqKr
         Ma4CHj/SjxsZrnB49Bi7Ovs+dmv/s2G0hijZLyCQ7T/jfHRDgE3r7TM9VKFXjhTlOmX2
         lhzB5mMPT4i0E+3pRpQPF3Y+6ynERcEB/QLKMwynMNSndtvpwzLGu5xAx4GCsiLrQL/L
         irHXMXpsvzN+KNywA53EX/UhYJkQhegvvPGYIZWB+4LOs6xkkvTVP4+vDkzKNXVaVGpy
         GEtmke6xFQ3ekG6LfEy55YrauL/jqrVsIyLwwc0LXZL1fF29oqWlsXKC4rzpviCwKvqU
         KGnQ==
X-Gm-Message-State: AOAM530ZlC3AJlcPbIVZwuMAOAoI3EM/HdoWqD5R4P32ovmHZOmKzEQj
        7upz17EdzhFFN4V42T6EveA=
X-Google-Smtp-Source: ABdhPJzzV5lffR+vPrMujphlYhlkb9LBp2YGU+ySLGarl897dMDenR5zsbyZ8mjJayf/fRLMukQWIQ==
X-Received: by 2002:a17:902:7049:b029:d0:cbe1:e778 with SMTP id h9-20020a1709027049b02900d0cbe1e778mr542008plt.31.1599799522111;
        Thu, 10 Sep 2020 21:45:22 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id z1sm572764pjn.34.2020.09.10.21.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:45:21 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] exfat: replace memcpy with structure assignment
Date:   Fri, 11 Sep 2020 13:45:19 +0900
Message-Id: <20200911044519.13981-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use structure assignment instead of memcpy.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/dir.c   |  7 ++-----
 fs/exfat/inode.c |  2 +-
 fs/exfat/namei.c | 15 +++++++--------
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index fa5bb72aa295..8520decd120c 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -974,11 +974,8 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					if (ei->hint_femp.eidx ==
 							EXFAT_HINT_NONE ||
 						candi_empty.eidx <=
-							 ei->hint_femp.eidx) {
-						memcpy(&ei->hint_femp,
-							&candi_empty,
-							sizeof(candi_empty));
-					}
+							 ei->hint_femp.eidx)
+						ei->hint_femp = candi_empty;
 				}
 
 				brelse(bh);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 70a33d4807c3..687f77653187 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -554,7 +554,7 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	loff_t size = info->size;
 
-	memcpy(&ei->dir, &info->dir, sizeof(struct exfat_chain));
+	ei->dir = info->dir;
 	ei->entry = info->entry;
 	ei->attr = info->attr;
 	ei->start_clu = info->start_clu;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1c433491f771..2932b23a3b6c 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -318,8 +318,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 	hint_femp.eidx = EXFAT_HINT_NONE;
 
 	if (ei->hint_femp.eidx != EXFAT_HINT_NONE) {
-		memcpy(&hint_femp, &ei->hint_femp,
-				sizeof(struct exfat_hint_femp));
+		hint_femp = ei->hint_femp;
 		ei->hint_femp.eidx = EXFAT_HINT_NONE;
 	}
 
@@ -519,7 +518,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	if (ret)
 		goto out;
 
-	memcpy(&info->dir, p_dir, sizeof(struct exfat_chain));
+	info->dir = *p_dir;
 	info->entry = dentry;
 	info->flags = ALLOC_NO_FAT_CHAIN;
 	info->type = type;
@@ -625,7 +624,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	if (dentry < 0)
 		return dentry; /* -error value */
 
-	memcpy(&info->dir, &cdir.dir, sizeof(struct exfat_chain));
+	info->dir = cdir;
 	info->entry = dentry;
 	info->num_subdirs = 0;
 
@@ -1030,7 +1029,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 		if (!epnew)
 			return -EIO;
 
-		memcpy(epnew, epold, DENTRY_SIZE);
+		*epnew = *epold;
 		if (exfat_get_entry_type(epnew) == TYPE_FILE) {
 			epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 			ei->attr |= ATTR_ARCHIVE;
@@ -1050,7 +1049,7 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 			return -EIO;
 		}
 
-		memcpy(epnew, epold, DENTRY_SIZE);
+		*epnew = *epold;
 		exfat_update_bh(new_bh, sync);
 		brelse(old_bh);
 		brelse(new_bh);
@@ -1113,7 +1112,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 	if (!epnew)
 		return -EIO;
 
-	memcpy(epnew, epmov, DENTRY_SIZE);
+	*epnew = *epmov;
 	if (exfat_get_entry_type(epnew) == TYPE_FILE) {
 		epnew->dentry.file.attr |= cpu_to_le16(ATTR_ARCHIVE);
 		ei->attr |= ATTR_ARCHIVE;
@@ -1133,7 +1132,7 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 		return -EIO;
 	}
 
-	memcpy(epnew, epmov, DENTRY_SIZE);
+	*epnew = *epmov;
 	exfat_update_bh(new_bh, IS_DIRSYNC(inode));
 	brelse(mov_bh);
 	brelse(new_bh);
-- 
2.25.1

