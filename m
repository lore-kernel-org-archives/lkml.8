Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E399C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808120675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ7ysWTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgCJNcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:32:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33993 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgCJNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id z15so15914802wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrDtyK6FLnqHTMEHua3mmqEWGNJQ4n8j8Ssk1MYnbIk=;
        b=vJ7ysWTIYyPXmgp0Sp+bajnIIMsLa1JcTuH4HM4R7lYAuGaxUzw+Hv+5snwkeTWThT
         rt/QTjHajnsC+DOoRWSCvA6UribCXRqIiCAGb2lifsVzKHjZ2e6vNpf3g6GNFgM0HOH7
         BlQlO5MkoOc3kCj9bJGTz4UCX+bUIMvU5iCdnZyAahYaQ/H/QCgjGNpEvvdjtbTFLr0c
         Ah+uAOr8KcyxvQIRvYoKjo+NZwmoCZ6il5+YY0/zRnP8RUptwmZLxjbjSNNxIPRKKOv9
         CjBMyz23jMszNzsypr0VILUfJjisT8oN8X1Q2JWs8utMd9OkfHK+GyCrthXrFjenEeQe
         o/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrDtyK6FLnqHTMEHua3mmqEWGNJQ4n8j8Ssk1MYnbIk=;
        b=EJn+OHIFPRD3ss7k5FZEVbKylCXSesjCEWjWHkLVU4cpV9v3ImbljZWmpl8CDvxTAF
         bxeYFy7D+nQ6O+/m6B1DsFot4VvkQ4JzyqOIW6NxlEgsHmZy3yjIVsN2CxdrNuEdWD8p
         69qG2mQYq1zepW1k7MLlQRzxqJQUG+FssOfmrp4ZCONA6IFaT6mJIVEv6wNj0R+AXPLL
         v32hT8YGpqmRvsYq3XYFixysk67DKA6nnSa85gwX+kTa2EhocjxqfmbqydKDd8HFc98n
         WkdX7LSneTo3ymFyHw9qTVMdKMdFH5W7+oVvudvSJNjOS6JVx44Vs5Ba1aN+Uwfe89+p
         FNlQ==
X-Gm-Message-State: ANhLgQ3F3eyBux3bWi7qye3dD/fr0nN5SMvUqvCdEDm+twUMRZRE09M3
        4dNXsLOAby1j4Nk6rMm1Jls=
X-Google-Smtp-Source: ADFU+vvEOWPQJw/FEbRudxX6QTWpQe8WMthu0+XVTUd0fFBVZkcDCWxjgdY2UI0zM0Ef4xHLUNZqKw==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr14498933wrn.105.1583847116123;
        Tue, 10 Mar 2020 06:31:56 -0700 (PDT)
Received: from localhost.localdomain ([197.248.222.210])
        by smtp.googlemail.com with ESMTPSA id o7sm14047141wrx.60.2020.03.10.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:31:55 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, Ben Skeggs <bskeggs@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, nouveau@lists.freedesktop.org
Subject: [PATCH v2 11/17] drm/nouveau: make nouveau_drm_debugfs_init() return 0
Date:   Tue, 10 Mar 2020 16:31:15 +0300
Message-Id: <20200310133121.27913-12-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310133121.27913-1-wambui.karugax@gmail.com>
References: <20200310133121.27913-1-wambui.karugax@gmail.com>
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
error handling in nouveau_drm_debugfs_init() and have the function
return 0 directly.

v2: have nouveau_drm_debugfs_init() return 0 instead of void so as not
to introduce any build warnings to enable individual patch compilation.

References: https://lists.freedesktop.org/archives/dri-devel/2020-February/257183.html
Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 7dfbbbc1beea..15a3d40edf02 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -222,22 +222,18 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
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
-- 
2.25.1

