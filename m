Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A8C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7C02464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhrSjxZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBRR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41892 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so24978627wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWLVAjVqPSSmv6Lyrg6I9TSWLedwmPZ7BTiNRFjBZfs=;
        b=YhrSjxZLtGfvAutwn8YXFwmbIyBZmPMAei0Fyr8NP5P4i3Gp8eZgzHpsb9eo8Pa+Es
         +LH6mOifsUsSk06cf9tYGHTcT7/yjMT2jJd/EqCGxhTfPJPA6MlUzgXg5LQk18yrc+6W
         bpSlX2Xzi1WMNnd0F7fBEGop0CFOcPjhbtIddN7U11+HPL5Ae1IqGwUyt4Af3A09EwaY
         jYyVAKbqA0t46R5hjSlRg8q9JXobzCge1yIKGbRQRqC2k02bQOq96g+vhLJc8n/0hGby
         qsxO1TmWs7fAEXZwEDma4hCS8ucziSvs38CEOwATpGoC4oiQ37tnaBU3gds1+jTGoubu
         Ow5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWLVAjVqPSSmv6Lyrg6I9TSWLedwmPZ7BTiNRFjBZfs=;
        b=a0zwWsyNUTAPzpTlt9e2YwQmVsnRM2TXxuiItfa6IYHSk2oz8AxqNWhakHzDqB/qd0
         AwbtTbUsZw3vNxkw6xipBxghzgxlqMTOd8GshgtgCoH+n8Go65UgTfapQXiYp7IOjC9i
         gO0A1FnLjkO9X51rykd7pFQKNrHmCIuSxG+3SCx/bWYaWtWGLOaEwYgpoFz0zNjcRP/e
         KbrAfe/FdGuXvYkzxjFujmjeNV0zllDQt+78pD/zxqr2JVArhz1npgfy0Oq+zJZ0FQJ8
         SvtySZ63uTmYqTbSV04Fh1rlOGO/GW6GaHub1uqosgpwX7gWCD3Lu5axQjRcpYV3TIHR
         ek5w==
X-Gm-Message-State: APjAAAUN9matqZOlmVjcXi+cWGHgNLC9yGFzuuwY4iDm9hs+HqyBNHka
        wnN7aVnSShT3az9ojEOorQthNSDJbV9wyQ==
X-Google-Smtp-Source: APXvYqxVyMWdovrtq8J/U94Gcj1SY1oH479AJsJq/mJ7oIUVe9sqlGwCh57Lgm6O1a5ZmnbwhpjkRg==
X-Received: by 2002:a5d:4f0f:: with SMTP id c15mr31665038wru.251.1582046932730;
        Tue, 18 Feb 2020 09:28:52 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:52 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] drm/nouveau: remove checks for return value of debugfs functions
Date:   Tue, 18 Feb 2020 20:28:17 +0300
Message-Id: <20200218172821.18378-6-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to check for the return value of debugfs_create_file
and drm_debugfs_create_files, remove unnecessary checks and error
handling in nouveau_drm_debugfs_init.

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
2.25.0

