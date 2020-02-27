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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3222C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D224695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjF8bSXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgB0MDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:03:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35544 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so3119200wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/F7RIx+9SUwwtWwjcWvQf8uTf1pG7IKUNhe5nQ/dsk=;
        b=DjF8bSXaPpeF2aqQW2zM7PDB8yZEaM3Omcoznwdy+f9o7qu5S8yJHsMua/+2do8sDC
         H1My8KuIBQwkcwdY+fUS11dDsMdZlxhvYWjHO/yOgJxQXq37jItgmOjFQVy9v4ZToabc
         EMMUjf8FeAb8o8sdlyJTyPmYm+quXJ+AJtoajWX9gIebljiftnUIjG+MNHld1zGGkbBj
         W828gAnoDWOCqwF8OH4ts3bPhGIsShQmLxCMbbzYdIpYVWteH2zVYF6i5CJ+Z8vsDl5E
         eB7GUUUP9l4btMnTrTCrh3LJzE8SLunOCi/0K0EdbiyTmELdt1I9pSRdMRo+3D7vavM+
         9qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/F7RIx+9SUwwtWwjcWvQf8uTf1pG7IKUNhe5nQ/dsk=;
        b=lneGKCYjZfmRLKeYKt9s1V+Eqo1Bd6aOeXk4Yx5JoaLbWSllXmzcXhfZkkc6o72DrH
         +lnodSq+hzQbtWxQZXYN+7Pld5lX4kPVzdDNtdR6/KIkJ3A3ngaRh43y6JDPTfcQpGyf
         Q3dqjFQ4Md4pgHjaseB0vcLFDEb3inNI/gtdhMBTicx9k8l+k7gBELcmep2atkA8ycPc
         p7iFtFQVUHOP+SzwiTSCEHzatatb6Fn75oOjDEIKM/Rk0cHP6ycwyWTIpTrFFsc8zWN+
         7ggdZA9lGDrTLTlCUeOg5r5u7LnMJGsN6OmA9DLFR1crab9Foee/EJL/QCx3BO+0lahZ
         El0g==
X-Gm-Message-State: APjAAAX2RRFr0BMiLs/ZU6c8KEzVdSqTKKYxuMzL4V1jfgwdfGfNzmuB
        zH9QvFDFgrL0wn3ZVTZAdXc=
X-Google-Smtp-Source: APXvYqw2m6lnhgwdcVIy5+XBGvgEz0kXIyQsiTFpaxOh0RoL419orS6n6MJ5JhIrZMuOETmKv+1A/Q==
X-Received: by 2002:a1c:25c6:: with SMTP id l189mr5018868wml.104.1582805029054;
        Thu, 27 Feb 2020 04:03:49 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id t10sm7655017wru.59.2020.02.27.04.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:03:48 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     daniel@ffwll.ch, airlied@linux.ie, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/21] drm/tilcdc: remove check for return value of debugfs functions.
Date:   Thu, 27 Feb 2020 15:02:28 +0300
Message-Id: <20200227120232.19413-18-wambui.karugax@gmail.com>
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
drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
fails. Therefore, remove the check and error handling of the return
value of drm_debugfs_create_files() as it is not needed in
tilcdc_debugfs_init().

Also remove local variables that are not used after the changes, and
declare tilcdc_debugfs_init() as void.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0791a0200cc3..78c1877d13a8 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -478,26 +478,17 @@ static struct drm_info_list tilcdc_debugfs_list[] = {
 		{ "mm",   tilcdc_mm_show,   0 },
 };
 
-static int tilcdc_debugfs_init(struct drm_minor *minor)
+static void tilcdc_debugfs_init(struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
 	struct tilcdc_module *mod;
-	int ret;
 
-	ret = drm_debugfs_create_files(tilcdc_debugfs_list,
-			ARRAY_SIZE(tilcdc_debugfs_list),
-			minor->debugfs_root, minor);
+	drm_debugfs_create_files(tilcdc_debugfs_list,
+				 ARRAY_SIZE(tilcdc_debugfs_list),
+				 minor->debugfs_root, minor);
 
 	list_for_each_entry(mod, &module_list, list)
 		if (mod->funcs->debugfs_init)
 			mod->funcs->debugfs_init(mod, minor);
-
-	if (ret) {
-		dev_err(dev->dev, "could not install tilcdc_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
 }
 #endif
 
-- 
2.25.0

