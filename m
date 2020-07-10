Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA64AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E7C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apjndRlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGJJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGJJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454BC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so8107636wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=apjndRlzBADzjx/tKuL/n6DCF1QhTME/JWIr6K5Qr5g2IRZGeLMo/t/MyBZdlS4Wv7
         k5bf8mqevDciEgy3gqH2+aIkTYToN0Zy1EZxDhoBehAtKeI+1tgSgDLhN7+/ne4RbQMk
         nxMUmPsxsj19A86Y1Jx+mlVe3Gs5ZYfyYGWBMdubz+qz+moVhkUKvftySUIQHimrukhE
         +aVrPiZYuvS5yHfxTERpS4FDfJUCshHX1JhRkOxz5K9hfiAbzgZpu6uNa3rSJHVUC9jU
         js5CnMsPWyGmIwH7i7TB16ow/aTQ6jsyl6DplG+JVru9fzexAymN2Hv0CciWGaQx/q70
         UooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WimOihJEoGFrQflh5MG/QpMyDue9zSaiyBZVUVInhdA=;
        b=EJ12kjFzeT1LIveneVz6fZ0/4KKZBO6X7lJiAm1JbJpUAj+qNKe3LByztIRyZwFks1
         JLfzK2oyKgY2sraEhXvdl0pbsZV0BuRwqe1J2R4oufYdConoeBKjEi2946RvfZ4/svbc
         p1szZvQj+C462S9AFjQIshz3WNALeWlqPhB/NMCPpDMUic0Qcto3kdi0KnmjELAJoeou
         CQXDypnG6iHXfzG3BX/wALwOzryLVxBAAtmjTQB1MJ+6/cBOmOg7MdbaPMfSjRYZ0BxH
         UTFLhGm562un8e6WOPsFaWCBESLI8ojSiC2C8365vBAmVrC7xM9Yd6/HIFHOIcPXaatU
         Eg8w==
X-Gm-Message-State: AOAM5307gdIOvRiOpZXXDEdp7/u+xlAVxRo6TKvYl2N/lAXGOKXzQIpN
        wgt5tK7/Jw+U4q+JgXM4+cFcH/rIXFY=
X-Google-Smtp-Source: ABdhPJxxIn8oYAxTV1peSwC8T66wTnW21RfMcb22cRnGtDFyLhEPQ7Ua941ytDhox3rI2N/NIlkm0A==
X-Received: by 2002:a1c:48:: with SMTP id 69mr4576752wma.32.1594374853553;
        Fri, 10 Jul 2020 02:54:13 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:12 -0700 (PDT)
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
Subject: [PATCH v5 01/14] drm/panfrost: avoid static declaration
Date:   Fri, 10 Jul 2020 11:53:56 +0200
Message-Id: <20200710095409.407087-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710095409.407087-1-peron.clem@gmail.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
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

