Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D8C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F6520A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4l5km+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgEFPV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgEFPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:49 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22FC0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:49 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so617963plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8mOPg/WJbpwFq17aNXqVhrLVAgEDXC59soVlAVNO7M=;
        b=E4l5km+thT0FJN99T1qK6r+jZ/T1hE87pBpi1b0c57RVkyyrYY8hypmTzqsM9e1sQy
         dtGW9l83v1OHSz1rMVx4Oo67ORv+sI7FXVxG6lnvHhTmBLuSosSemsGxVEMjV4mgJoyq
         UX4wr1DxrKnVg/tYeIsPYBaQMjqJ0v4zQ1af4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8mOPg/WJbpwFq17aNXqVhrLVAgEDXC59soVlAVNO7M=;
        b=Lahz5HB/azPGPqUVR6B9misKeTKQVj4OpVRdd/rL4Uf8FPtmhVpKomdiqZFEffjvST
         4YuaZelgyuaFSMMa6cyWMKtrvRBLfH6odY7SihMGVRArv02uHwz5iejKmA0AUJ7qPUbV
         MDXwrP0o/dOW5WYQDNJ6YFdY7cPFaFUrW1ccfI6qMheYjg1As1TyGqYFDC9SUncXSXqf
         udM0VLENrNPJV5b87pRSb+iwr0V99bF22xyAWm35Zu+4WC/ocrzu9NIHmhlfEHfS5mFG
         Nkzp0jJpBy3OAR7iGnoOYxHdMnEmX60G7Gv60I39p12JSDyq3LjDjyU1D1ebHT6oXEoB
         8HbA==
X-Gm-Message-State: AGi0PuaZxE/ah/6YKrTJy32DpWlnenBtWppmNhykugn/KsEt2VySM8yv
        PzvXjrOg5bZuNVPzpHBbKDEghQ==
X-Google-Smtp-Source: APiQypImz2oOSfSE3NNLgEnKlJ1DyO7DE2gnMXI8IWGlXIr31bRhCeiiTy+8pWm2DPD63Dz7bYJfbw==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr582793plo.57.1588778508927;
        Wed, 06 May 2020 08:21:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r21sm4921156pjo.2.2020.05.06.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 08/10] pstore: Add locking around superblock changes
Date:   Wed,  6 May 2020 08:21:12 -0700
Message-Id: <20200506152114.50375-9-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506152114.50375-1-keescook@chromium.org>
References: <20200506152114.50375-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing was protecting changes to the pstorefs superblock. Add locking
and refactor away is_pstore_mounted(), instead using a helper to add a
way to safely lock the pstorefs root inode during filesystem changes.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c    | 65 +++++++++++++++++++++++++++++---------------
 fs/pstore/internal.h |  1 -
 fs/pstore/platform.c |  5 ++--
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5f08b21b7a46..e13482c8e180 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -31,6 +31,9 @@
 static DEFINE_MUTEX(records_list_lock);
 static LIST_HEAD(records_list);
 
+static DEFINE_MUTEX(pstore_sb_lock);
+static struct super_block *pstore_sb;
+
 struct pstore_private {
 	struct list_head list;
 	struct pstore_record *record;
@@ -282,11 +285,25 @@ static const struct super_operations pstore_ops = {
 	.show_options	= pstore_show_options,
 };
 
-static struct super_block *pstore_sb;
-
-bool pstore_is_mounted(void)
+struct dentry *psinfo_lock_root(void)
 {
-	return pstore_sb != NULL;
+	struct dentry *root;
+
+	mutex_lock(&pstore_sb_lock);
+	/*
+	 * Having no backend is fine -- no records appear.
+	 * Not being mounted is fine -- nothing to do.
+	 */
+	if (!psinfo || !pstore_sb) {
+		mutex_unlock(&pstore_sb_lock);
+		return NULL;
+	}
+
+	root = pstore_sb->s_root;
+	inode_lock(d_inode(root));
+	mutex_unlock(&pstore_sb_lock);
+
+	return root;
 }
 
 /*
@@ -303,20 +320,18 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	struct pstore_private	*private, *pos;
 	size_t			size = record->size + record->ecc_notice_size;
 
-	WARN_ON(!inode_is_locked(d_inode(root)));
+	if (WARN_ON(!inode_is_locked(d_inode(root))))
+		return -EINVAL;
 
+	rc = -EEXIST;
+	/* Skip records that are already present in the filesystem. */
 	mutex_lock(&records_list_lock);
 	list_for_each_entry(pos, &records_list, list) {
 		if (pos->record->type == record->type &&
 		    pos->record->id == record->id &&
-		    pos->record->psi == record->psi) {
-			rc = -EEXIST;
-			break;
-		}
+		    pos->record->psi == record->psi)
+			goto fail;
 	}
-	mutex_unlock(&records_list_lock);
-	if (rc)
-		return rc;
 
 	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
@@ -346,7 +361,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	d_add(dentry, inode);
 
-	mutex_lock(&records_list_lock);
 	list_add(&private->list, &records_list);
 	mutex_unlock(&records_list_lock);
 
@@ -356,8 +370,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	free_pstore_private(private);
 fail_inode:
 	iput(inode);
-
 fail:
+	mutex_unlock(&records_list_lock);
 	return rc;
 }
 
@@ -369,16 +383,13 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
  */
 void pstore_get_records(int quiet)
 {
-	struct pstore_info *psi = psinfo;
 	struct dentry *root;
 
-	if (!psi || !pstore_sb)
+	root = psinfo_lock_root();
+	if (!root)
 		return;
 
-	root = pstore_sb->s_root;
-
-	inode_lock(d_inode(root));
-	pstore_get_backend_records(psi, root, quiet);
+	pstore_get_backend_records(psinfo, root, quiet);
 	inode_unlock(d_inode(root));
 }
 
@@ -386,8 +397,6 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
 
-	pstore_sb = sb;
-
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
@@ -408,6 +417,10 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sb->s_root)
 		return -ENOMEM;
 
+	mutex_lock(&pstore_sb_lock);
+	pstore_sb = sb;
+	mutex_unlock(&pstore_sb_lock);
+
 	pstore_get_records(0);
 
 	return 0;
@@ -421,9 +434,17 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
 static void pstore_kill_sb(struct super_block *sb)
 {
+	mutex_lock(&pstore_sb_lock);
+	WARN_ON(pstore_sb != sb);
+
 	kill_litter_super(sb);
 	pstore_sb = NULL;
+
+	mutex_lock(&records_list_lock);
 	INIT_LIST_HEAD(&records_list);
+	mutex_unlock(&records_list_lock);
+
+	mutex_unlock(&pstore_sb_lock);
 }
 
 static struct file_system_type pstore_fs_type = {
diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
index 7062ea4bc57c..fe5f7ef7323f 100644
--- a/fs/pstore/internal.h
+++ b/fs/pstore/internal.h
@@ -33,7 +33,6 @@ extern void	pstore_get_backend_records(struct pstore_info *psi,
 					   struct dentry *root, int quiet);
 extern int	pstore_mkfile(struct dentry *root,
 			      struct pstore_record *record);
-extern bool	pstore_is_mounted(void);
 extern void	pstore_record_init(struct pstore_record *record,
 				   struct pstore_info *psi);
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03bc847a6951..55f46837a7f4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -460,7 +460,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		}
 
 		ret = psinfo->write(&record);
-		if (ret == 0 && reason == KMSG_DUMP_OOPS && pstore_is_mounted())
+		if (ret == 0 && reason == KMSG_DUMP_OOPS)
 			pstore_new_entry = 1;
 
 		total += record.size;
@@ -594,8 +594,7 @@ int pstore_register(struct pstore_info *psi)
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		allocate_buf_for_compression();
 
-	if (pstore_is_mounted())
-		pstore_get_records(0);
+	pstore_get_records(0);
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		pstore_register_kmsg();
-- 
2.20.1

