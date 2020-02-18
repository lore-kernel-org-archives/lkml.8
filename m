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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48574C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFE4207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOBFhU6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBRPzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:55:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:55:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3280736wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4NYexLpILY60srgmqxAi1etdq+Fbf5QvLbzOYjNBh+0=;
        b=SOBFhU6/pvpE7kBsqMeV/5sQVqvTArYbQxBjoeelE4rU7JNrFx+nsLzvbgg1ksk4fK
         K74P+40eBi906A13+OlVyXs7CkOeChtPVjFHd9VHbiVJJ9kSsTciQv6t7COYuDrEovwR
         hjDw+BUyOqLSaKBFIeR04q/vXQYZVEN+Z3JrrcUXI+Xw7cNkMogyfggomLw/F8wMIIcC
         GN952fQlBB2mIsI4f+Fdu9JP437qPSp8o7a8VJA77Rsrk8kdF6qqwwafHQtvIaXolVOH
         On8tswMWpb11k/23/5VZNq/1Q+BAjyhN3LB6fhv+/QoXnWv7d2ejgvcH+XvH9ZUidvdw
         MAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4NYexLpILY60srgmqxAi1etdq+Fbf5QvLbzOYjNBh+0=;
        b=nAB81p5mtjc1OoYQXwyn6ksWmqVAL+UJk9ury7DdTT9STg8xkiSIjr9BI/HHrx9wYh
         ifYYg/BVN6Ftw1nlDXY3H8O5drcr6AWzdAeSo4SaKrSmowBMVBUmW0DwZ1+q3btR66Ru
         1rEoShYgMR9PgC00X+U5jj6LRCidlxPiUsEtwRVZXs1vZ8ITbifqtxijkxN3vWSifgAg
         KZB0geq+J9024I0gN5lCZia587n8CY7ew8oBmau5vbFGB266fYSRAovl7+44zSKq6ZPB
         +a1ZWBwsrtUS5I435aMycLMOTJr82A5WjgFEPDoTyclacBPAW1DccewUO5/jM9nwC+K8
         cfzg==
X-Gm-Message-State: APjAAAUEQpzj245GbIk9s8W30hJFkORa0rfCc5qCp1ILJEzsUg0TCgv0
        ddWvbm8fSICSuhFd//Nb58U=
X-Google-Smtp-Source: APXvYqzQeydbmzF1uzVvMGaqc4U1nEmFluo014BUKIvhvft/nbFeUljZSSqEAq9NErdKn9IHVccSog==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr3942001wmh.174.1582041342065;
        Tue, 18 Feb 2020 07:55:42 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id a9sm6767758wrn.3.2020.02.18.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 07:55:41 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jsarha@ti.com, tomi.valkeinen@ti.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] drm/tilcdc: remove check for return value of debugfs functions.
Date:   Tue, 18 Feb 2020 18:55:34 +0300
Message-Id: <20200218155534.15504-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218155534.15504-1-wambui.karugax@gmail.com>
References: <20200218155534.15504-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the check and error handling of the return value of
drm_debugfs_create_files as it is not needed in tilcdc_debugfs_init.
Also remove local variables that are not used after the changes.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0791a0200cc3..3f7071eb9c78 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -480,24 +480,17 @@ static struct drm_info_list tilcdc_debugfs_list[] = {
 
 static int tilcdc_debugfs_init(struct drm_minor *minor)
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
 
-	if (ret) {
-		dev_err(dev->dev, "could not install tilcdc_debugfs_list\n");
-		return ret;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.17.1

