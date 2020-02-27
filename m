Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B39C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D8F24698
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqt0uVTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgB0MDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50777 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3258221wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FF1NrpSPuilvGFuBlDAjCo1EkW/20qE/sk6srnRxdwk=;
        b=hqt0uVTKwEJgrrFViTZSdoN5IyrDGa0MnWpSVpKfzAJ/q4CYucez5Y9GL9cyO3mkIX
         uPhquZ+n6+onWBaMCPga9B+8QCHT5lbST/AIoFCjP/z9QjtWBRQwCNFykzvp+giIIxHx
         ftcx33fAul6ms0T/zjnHYprjSfmeXBZ6+Zf3xUPDcfzQYs4saNULJTigGrxmo+Zt4VWb
         n5F9x6L3itJsG4d9F4cotAAY35c3wH6JIb3TN1Zi5s5loMOSTEw0XMGVtQFlu+HfXvpt
         Hep3CCkcw9XCJxyArNAUaSfdnFIqgdAY//zqMW3nDOggIgF5Bnjhu41nBBSm7noCtzFP
         Xh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FF1NrpSPuilvGFuBlDAjCo1EkW/20qE/sk6srnRxdwk=;
        b=sEKKGrK8FBNrRoXX/sh9dc6RTFaWGkMtsd5y3JVDcoUg+x2VbzDY9H+973H3q2FEv9
         u8gz04C2OwG+g1SslZTPU9bcLheApU1DLjI3qFf1C2yb3N4Ov3rbD8FdYxf6q4GoUM+L
         9JoZvO6W11Cu3PcG8pNE+kciWgTspRk5biXeZo364rG1mFqNOwRmnw0tNx3BU2QmIMhZ
         5eWxaJ7OoyRDSVpgRhhJuc7W8K6rRVwSLLOJRsBYWo6BGgpje/CkVjrRtfTYeCY17d96
         XDezwDX7GFbuapYIFbDDIB50eF+uX56xT6pH1VKaCi7/TSBg/skQHRTkd9y/IhonLV5+
         /moQ==
X-Gm-Message-State: APjAAAV8x5QaYUfRuKmHpHJFY6EeC7v21DoD3YxUO7wNszx9496lKcQs
        FZU041hnY7t2qHIrDFESzOs=
X-Google-Smtp-Source: APXvYqxaNmMPo4uh3u7cD404NdTjAHMYEUcbV9NVopmZg+bCAqm3J+SaBK6YQlOOsAh9UdiCZSuDXg==
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr5110294wme.102.1582804998319;
        Thu, 27 Feb 2020 04:03:18 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:17 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, bskeggs@redhat.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 09/21] drm/nouveau: remove checks for return value of debugfs functions
Date:   Thu, 27 Feb 2020 15:02:20 +0300
Message-Id: <20200227120232.19413-10-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227120232.19413-1-wambui.karugax@gmail.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 987d65d01356 (drm: debugfs: make
drm_debugfs_create_files() never fail), there is no need to ever check
for the the return value of debugfs_create_file() and
drm_debugfs_create_files(). Therefore, remove unnecessary checks and
error handling in nouveau_drm_debugfs_init.

These changes also enable nouveau_drm_debugfs_init() to be declared
as void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 26 +++++++++--------------
 drivers/gpu/drm/nouveau/nouveau_debugfs.h |  5 ++---
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 7dfbbbc1beea..63cb5e432f8a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -217,39 +217,33 @@ static const struct nouveau_debugfs_files {
 	{"pstate", &nouveau_pstate_fops},
 };
 
-int
+void
 nouveau_drm_debugfs_init(struct drm_minor *minor)
 {
 	struct nouveau_drm *drm = nouveau_drm(minor->dev);
 	struct dentry *dentry;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nouveau_debugfs_files); i++) {
-		dentry = debugfs_create_file(nouveau_debugfs_files[i].name,
-					     S_IRUGO | S_IWUSR,
-					     minor->debugfs_root, minor->dev,
-					     nouveau_debugfs_files[i].fops);
-		if (!dentry)
-			return -ENOMEM;
+		debugfs_create_file(nouveau_debugfs_files[i].name,
+				    S_IRUGO | S_IWUSR,
+				    minor->debugfs_root, minor->dev,
+				    nouveau_debugfs_files[i].fops);
 	}
 
-	ret = drm_debugfs_create_files(nouveau_debugfs_list,
-				       NOUVEAU_DEBUGFS_ENTRIES,
-				       minor->debugfs_root, minor);
-	if (ret)
-		return ret;
+	drm_debugfs_create_files(nouveau_debugfs_list,
+				 NOUVEAU_DEBUGFS_ENTRIES,
+				 minor->debugfs_root, minor);
 
 	/* Set the size of the vbios since we know it, and it's confusing to
 	 * userspace if it wants to seek() but the file has a length of 0
 	 */
 	dentry = debugfs_lookup("vbios.rom", minor->debugfs_root);
 	if (!dentry)
-		return 0;
+		return;
 
 	d_inode(dentry)->i_size = drm->vbios.length;
 	dput(dentry);
-
-	return 0;
 }
 
 int
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.h b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
index 8909c010e8ea..ccb842d9da87 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.h
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.h
@@ -18,14 +18,13 @@ nouveau_debugfs(struct drm_device *dev)
 	return nouveau_drm(dev)->debugfs;
 }
 
-extern int  nouveau_drm_debugfs_init(struct drm_minor *);
+extern void nouveau_drm_debugfs_init(struct drm_minor *);
 extern int  nouveau_debugfs_init(struct nouveau_drm *);
 extern void nouveau_debugfs_fini(struct nouveau_drm *);
 #else
-static inline int
+static inline void
 nouveau_drm_debugfs_init(struct drm_minor *minor)
 {
-       return 0;
 }
 
 static inline int
-- 
2.25.0

