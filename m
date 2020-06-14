Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3693C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC96206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETKnsbcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgFNGg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:36:27 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45448C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:36:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i1so12417168ils.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bKaN8g4E8r9fQxgvVd0mPWT0d8FcyExRTIB0iopHs20=;
        b=ETKnsbcxF82ikBJ4PWFBq2K917ciwh8HDIPEUR4jCqP85AgzV6s4WH/RHAXPfC1P6G
         GrYS3YXBuHzLraLGZbqMGqepIdDByQ9///wyrDR4VLOImj9yE22338jOugJpTHxx5LON
         5QhkLv+fvqf01Y0qYHwNyFP/N2XqAGcLeU8+Zrwsi2vee32VuF7RNdzrpaGoWnyjedlX
         NKih70rnvhskUERAyOCiD5OOhJRK+2Eup8tVUNmWenlUSpI+S0gcqh25j5O2VBkzY7AS
         XnFJU9CCHlzW9k/vYFF0J24lMN9544HKguJtSQywjfUet3Gc89ugtPebwC08VSdPZI/E
         upiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bKaN8g4E8r9fQxgvVd0mPWT0d8FcyExRTIB0iopHs20=;
        b=F7CPee/15cDRkW4NElddeN9GYZtM54zG0a8n5zs6l+yB34NiwrZZSGu8yxjy1ztAHe
         ZSbkAb10TWqzv3gSbQOogq+j/u/j5DIx1enNxla24jJgSQp+pa7ZAmV1NmLyTZ5YIxTd
         FqKkmZayn5i5HYKz/ipuoE1jQzZr6eF9oSohBC9t8JlfPDgd32FA9X88S09WPX3NJud7
         0iLA+caX+6MHcSQtMo4JkNWafVuH/lGcq9Ob13cc+kHdUbI3rPN8CIO123EAEdixkWXm
         ZvOhqg6DojLxpfw/xub8A4wssiqnOwTwakSl8JowZrJ8gj5kc/92mPq3BRu0GAl/nBBL
         iEZw==
X-Gm-Message-State: AOAM533flBUr7MDv8pq1qWbRmIyp0WzRTPlWSHHk0mo4gmK/qDkI1VMY
        lacwGhqGShs3pHueagCf120=
X-Google-Smtp-Source: ABdhPJx3O1I9dQFPkUoziq65XacrHWidrhZbvxbQYl4JhhKuWOxucU720iAh0UOkCFThmVQiGZKiww==
X-Received: by 2002:a92:aa13:: with SMTP id j19mr20877607ili.193.1592116586536;
        Sat, 13 Jun 2020 23:36:26 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id r17sm5957131ilc.33.2020.06.13.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 23:36:26 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu,
        mccamant@cs.umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/panfrost: perfcnt: fix ref count leak in panfrost_perfcnt_enable_locked
Date:   Sun, 14 Jun 2020 01:36:19 -0500
Message-Id: <20200614063619.44944-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in panfrost_perfcnt_enable_locked, pm_runtime_get_sync is called which
increments the counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 6913578d5aa7..92c64b20eb29 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -83,11 +83,13 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 
 	ret = pm_runtime_get_sync(pfdev->dev);
 	if (ret < 0)
-		return ret;
+		goto err_put_pm;
 
 	bo = drm_gem_shmem_create(pfdev->ddev, perfcnt->bosize);
-	if (IS_ERR(bo))
-		return PTR_ERR(bo);
+	if (IS_ERR(bo)) {
+		ret = PTR_ERR(bo);
+		goto err_put_pm;
+	}
 
 	/* Map the perfcnt buf in the address space attached to file_priv. */
 	ret = panfrost_gem_open(&bo->base, file_priv);
@@ -168,6 +170,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	panfrost_gem_close(&bo->base, file_priv);
 err_put_bo:
 	drm_gem_object_put_unlocked(&bo->base);
+err_put_pm:
+	pm_runtime_put(pfdev->dev);
 	return ret;
 }
 
-- 
2.17.1

