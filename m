Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F7C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4F8206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aABRaRva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgD0RcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgD0RcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:32:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617DEC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:32:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so9331082pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OrLCHkzL2gJTdJrmotwx6Cbq6uQGETXhmriGsKvQFuw=;
        b=aABRaRvabeVCPsu/TbCen+fJoR7wEbpF8xgtEunzuFi1xz7Fj0jvi1Gnmp4rBDuYVO
         243gdBF8G3ACaqiTsk6bMVk6xMvyTnXyCb0YBBJQV1jV/5ojtyR5/js6aMlmtg6orCge
         K+Rro5tFuny78Mdwigtzc3JViEc1o0UfMmBh5M3OL7zasOWgT96c5ZV9NLOo5ysIN0g1
         toZNT4KVOQx7g4YRP0s1XmmisOjdko/xd/ZA/+XBm07i/uh9wb10L3dAn1ULMKb27diH
         BSJB6ced/1WGRIyatArdL5JmScvawR2wWg9F6Um/yimstuMsY/Nddk+3NMPeTyc/hYWV
         be5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OrLCHkzL2gJTdJrmotwx6Cbq6uQGETXhmriGsKvQFuw=;
        b=DgUYD0shYRPRpmHp2i8dA+GVfMEKd3H+F+PmQ1t+pRsBXvrDPY+3tVXrlZBtau7pP2
         6BOt8mc9uMWl8d0k5xA9K3aFspXhYhZ1hz9sryQSkt2vw9gsFcm2a26uheBspEtNSkBo
         1Nmsz1hrEzjOdhjtQCURDFEEBEt19St8VmZBer2ZCfQaUz7n5YIJNOJkw+60Y4Z3b506
         /3+uuF+UM6PQk9g8hy98ysUiOp5J2D4sGG+ZoCB7fpYC4sg7QP7NNebTGYkiF/Ik0h/A
         AHA7juTHoqTqpT7uT+PrJHn2FC4B6YJ+0itGIt/lQUuAB3vFdwPhGANANi5qE8ZeyZ2D
         Ggjw==
X-Gm-Message-State: AGi0PubIFTf/lsSdkw+szjI4Byvo5620FjO+JDalP4GsUaInQ6NnyOYc
        btU5tIsGXc8la6jBvhEnD2U=
X-Google-Smtp-Source: APiQypK8I4P+5CrdIoHKcffeaJ8uNw9qpbtYnb4UU1P6IvelHjFDYf0rP/szspUIUz+VsE7TdN/Edw==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr26497714pfr.80.1588008730946;
        Mon, 27 Apr 2020 10:32:10 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id 189sm6090729pfd.55.2020.04.27.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:32:10 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] kernfs: fix possibility of NULL pointer dereference. (mount.c)
Date:   Mon, 27 Apr 2020 10:32:02 -0700
Message-Id: <20200427173202.49626-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mount.c also uses "kernfs_dentry_node".
When dentry is negative, "kernfs_dentry_node" returns NULL.
In this case, "kernfs_root" dereferences NULL pointer.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/kernfs/mount.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..cd49cb936681 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -23,19 +23,33 @@ struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
 static int kernfs_sop_show_options(struct seq_file *sf, struct dentry *dentry)
 {
-	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(dentry));
-	struct kernfs_syscall_ops *scops = root->syscall_ops;
+	struct kernfs_node *node = kernfs_dentry_node(dentry);
+	struct kernfs_root *root;
+	struct kernfs_syscall_ops *scops;
+
+	if (node) {
+		root = kernfs_root(node);
+		scops = root->syscall_ops;
+	} else
+		return 0;
 
 	if (scops && scops->show_options)
 		return scops->show_options(sf, root);
+
 	return 0;
 }
 
 static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 {
 	struct kernfs_node *node = kernfs_dentry_node(dentry);
-	struct kernfs_root *root = kernfs_root(node);
-	struct kernfs_syscall_ops *scops = root->syscall_ops;
+	struct kernfs_root *root;
+	struct kernfs_syscall_ops *scops;
+
+	if (node) {
+		root = kernfs_root(node);
+		scops = root->syscall_ops;
+	} else
+		return 0;
 
 	if (scops && scops->show_path)
 		return scops->show_path(sf, node, root);
@@ -138,6 +152,9 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(child);
 
+	if (!kn)
+		return NULL;
+
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
 
-- 
2.17.1

