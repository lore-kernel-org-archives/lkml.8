Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF95C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C14C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpJ2AfDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGJJZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:25:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC19C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so5222050wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=GpJ2AfDtbHXLCQycXNMvxZwPIi7rXnk/8jSaA9ZZnkKHlUMiNkJvw7EPslgFRbJWgw
         hav701awxzqvtwNTqjqpHpx8qrNmYkRyx0UvXWW6FY2+NL+rP1GtqwGgC//+uWeEog/+
         QSjF/hd+QXKY7Db5KROhJVUhiAqQ2N0m6TLD+jQvrM/puMlAZk+WQHaP+IKDYTWljLfK
         5dGWELhdr4++i6PRcD/7+tWe1YiVyXRwgZOY0nWpaGbwdPqdMq+WRy9aZtttYM7yq3OC
         W23+679XuTQ89ZWtmyWVI0ZQnT8Fgv0og07FCMN58p+CuVXGbv+Gk0WNPc4z7Vy5li+G
         B8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=JUQQdxgi6znkzLPYv6xwyyoPXXPv0VubJeP9EsFwjigpGlboPA+Z4AisisoiNy1zBe
         lQcMRDcvP8X9CCzULlV5M1wMwVWOl/pyqevpfcHFM/2kZj78atlI+4RIfUbyfW+2NOr4
         ddJSJzPUGVr5QX0bEwNazbcB/FXFYRMdZNT094/NEk9nj+Z6yfgrf9zpb2Ifha82VlME
         IRu8HvZtRd+3TS8Ysk+qwwUEvU3pdGQu1JzsiafxwsS9/UGSBW6k2jJSeXFzn9p+MVEc
         EepOm8LpszkTbwmQCo6HjK/iWKkg4oBiB5+kMzAwRK9WZw1m0gERxfdK6wfAA798C0ch
         svyg==
X-Gm-Message-State: AOAM532feNO0Su8YCtgbojRsg9BCqWj41zNap23LPP1KXKi5mjzhNRPU
        EMMUnsH2+ezkRoA9SnhEZd4=
X-Google-Smtp-Source: ABdhPJztkpwv2u/X8d+I0+14kZgyoIQ8x8qEsfOqO60cJPVWz5ZpmAG7Xk4kWn3hX2rMNDlm4waVTA==
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr71160399wrx.178.1594373153543;
        Fri, 10 Jul 2020 02:25:53 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h23sm8179559wmb.3.2020.07.10.02.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:25:52 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 01/14] drm/panfrost: avoid static declaration
Date:   Fri, 10 Jul 2020 11:25:35 +0200
Message-Id: <20200710092548.316054-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710092548.316054-1-peron.clem@gmail.com>
References: <20200710092548.316054-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declaration can be avoided so change it.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 38 ++++++++++-----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..1b560b903ea6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -14,7 +14,24 @@
 #include "panfrost_gpu.h"
 #include "panfrost_regs.h"
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev);
+static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
+{
+	ktime_t now;
+	ktime_t last;
+
+	if (!pfdev->devfreq.devfreq)
+		return;
+
+	now = ktime_get();
+	last = pfdev->devfreq.time_last_update;
+
+	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
+		pfdev->devfreq.busy_time += ktime_sub(now, last);
+	else
+		pfdev->devfreq.idle_time += ktime_sub(now, last);
+
+	pfdev->devfreq.time_last_update = now;
+}
 
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
@@ -139,25 +156,6 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 	devfreq_suspend_device(pfdev->devfreq.devfreq);
 }
 
-static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev)
-{
-	ktime_t now;
-	ktime_t last;
-
-	if (!pfdev->devfreq.devfreq)
-		return;
-
-	now = ktime_get();
-	last = pfdev->devfreq.time_last_update;
-
-	if (atomic_read(&pfdev->devfreq.busy_count) > 0)
-		pfdev->devfreq.busy_time += ktime_sub(now, last);
-	else
-		pfdev->devfreq.idle_time += ktime_sub(now, last);
-
-	pfdev->devfreq.time_last_update = now;
-}
-
 void panfrost_devfreq_record_busy(struct panfrost_device *pfdev)
 {
 	panfrost_devfreq_update_utilization(pfdev);
-- 
2.25.1

