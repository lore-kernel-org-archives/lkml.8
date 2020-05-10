Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE13C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D2D208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgVoPKRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEJQzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729113AbgEJQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F8C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so7410901wrc.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCZR0RDMG3XJhGAGRvblpDgemNbadL77Ape7/cMT2Jk=;
        b=LgVoPKRXtKyWOqYktFWRpIfKlpXdA950wCd2yJkk1y6mRWG9CgvwhxCh+VLXpXYi8G
         isZlsRVnB2AJfLgDpBf5IwLL+F+xLLm+vLe5V8dfFZ1lZ5XxiQN1M+euNM0cjj8s6dxT
         4y3jVmrE0FzRMojZ1yZZw1dT+gmZ7jPBZFO7tFnCMJhrHGQSd9XmAV4gGs0aLissqb98
         UiLnV2bb5HGcSGff55PmCb2b9neSqsPsctfKOJWOLJBxeLc0n/RMBYmAzW2bxvzZ1o7G
         ca7cOJPGz/1a4XLT6HD1Y0EKIZy2oDbA8DL6NGUCyrNQm5rMurIRCp1EksMFjVRmDR1V
         77tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCZR0RDMG3XJhGAGRvblpDgemNbadL77Ape7/cMT2Jk=;
        b=uk9tnlu67CTw/gsgGhylyf66tx04rUO6ZyCwhSDzkO0kms1gExd4w6J/1JI4wRM1Fm
         rGqZfYzZEiFIIFyZsLOCmFpo5IfjQCS3zmFXi00V8N+4rj5T/s3fxck1Vm+YC3WgZVFT
         4uAL+MuRSbU5O/vhCnY0zVHi8KcYKR/SDZR3Cbkr7dZgupInDXi3aNRFjaHhGR03TnfT
         XarzjI6CLYMpOO/mpxdhG4uDOA/e/rRJsaVbn39+8+pcjdhL0I20XcFgs4rbgiHkjPTf
         qeADnapUjp/7hfczofkVazVwWNa8RQAnoRIEqFhnkdD9DhCbms0VRzLJ1vdA7JbehAvn
         zpIQ==
X-Gm-Message-State: AGi0PuY2cp2it5b/qDYxDyDxZAjWcg/X1UmeJaSdFj/gUyXQnwjJb9zi
        KFEcqIQ0w/GU5cg7eY1Jcuc=
X-Google-Smtp-Source: APiQypKtLpPlZkPTEpuhPfSdLDXG2WtCWVp/p+U2lL9gCsx/HvonVK58WW19yileLXj8XmEnrOCQcQ==
X-Received: by 2002:adf:afd6:: with SMTP id y22mr13959393wrd.417.1589129743009;
        Sun, 10 May 2020 09:55:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:42 -0700 (PDT)
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
Subject: [PATCH 01/15] drm/panfrost: avoid static declaration
Date:   Sun, 10 May 2020 18:55:24 +0200
Message-Id: <20200510165538.19720-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
References: <20200510165538.19720-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This declaration can be avoided so change it.

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
2.20.1

