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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13FC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BEC2464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEPrmeX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBRR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:28:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41900 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:28:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so24978932wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNI2AWl9XZZdPLhTH38nobJrQAEGZo6b2lzQ8OJ+Zy0=;
        b=BEPrmeX7IGavrgcl5UFYDjCya7DY+d7v1Ci8xLDnvdkACVurKxN6CFEydbhEwjRiII
         YczNSQ57KGsu2VIxf/pxiEMquZhQ38BjFf7hNc4dr0JjUKcBoEFsnT4LuxgkMRrTGS7f
         H82k0lkZCEefvhcyq15DvtuzxNHwt1P3B4f+s1zHCCSVasUa3lX/DZb80SuIZLDFTdjG
         6ZNcm/DmTrABviB1r0hPR0RSh71QspJbZV05UGcHLELrEakRQ3xh1OqH6WHXwgkF3eLL
         45xksEbrUYI3PPucQ14bzjjc6CizoX84Wx5D+a7nGoIBIEvm9zl+LlW4tvFnvmjTAnO8
         xdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNI2AWl9XZZdPLhTH38nobJrQAEGZo6b2lzQ8OJ+Zy0=;
        b=h+2kH9pOWqCmkRFkFdsRgoZi+dCg7ubtySOl9TaQkD+FO9+y8UEpcMZNs9q8BWHqwk
         uYaACFm9guhsvn2eUlankbF/PBLcjuin43PgsVAVo6w4AuFw4tmBLvwQ9yfUgG3KR6vz
         Vn7qJtqsNGyfTkCd/anlpUlJUF2OOIsY7hEAXIwUfqxfwCJqqJg+EGGM/6KkQh+wYs9a
         CxukxHRBWRcOcGy5vA6y3EQml1iePDhm84axEd3IgfsDZSsfszHD27wRxT/UO+DDGRTi
         Mlu2a0HvIhFd8UeNeiMf/XWoVMNuq7X/8rUzL5bsSpCxkyV/shF9RuBO5kpAZrLyGGeG
         RoMg==
X-Gm-Message-State: APjAAAVkuMZM/kN1ZreTqxid04OaICI+7bagF+3U5awYNpmzyg/pLgno
        JmCAzNmLCqWEktBv70g2L0E=
X-Google-Smtp-Source: APXvYqzZVlKqI1X3heHQTWa9mpr/flMwMWrInKVpi99QI4k1Mspdh8QmywKzulmfFLgBb+sinvS2gQ==
X-Received: by 2002:adf:e641:: with SMTP id b1mr30115473wrn.34.1582046937280;
        Tue, 18 Feb 2020 09:28:57 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t13sm6998757wrw.19.2020.02.18.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:28:56 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     eric@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/v3d: make v3d_debugfs_init return 0
Date:   Tue, 18 Feb 2020 20:28:18 +0300
Message-Id: <20200218172821.18378-7-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_debugfs_create_files should return void, remove its use as the
return value of v3d_debugfs_init and have the function return 0
directly.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index 9e953ce64ef7..57dded6a3957 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -261,7 +261,8 @@ static const struct drm_info_list v3d_debugfs_list[] = {
 int
 v3d_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(v3d_debugfs_list,
-					ARRAY_SIZE(v3d_debugfs_list),
-					minor->debugfs_root, minor);
+	drm_debugfs_create_files(v3d_debugfs_list,
+				 ARRAY_SIZE(v3d_debugfs_list),
+				 minor->debugfs_root, minor);
+	return 0;
 }
-- 
2.25.0

