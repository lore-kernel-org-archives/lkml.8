Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9B920870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HydICvJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGDK0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgGDKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B24C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so35334289wrv.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkGU7R40AthO2TACaX1LtXYqx5KDs3cB/We4L7vR8bk=;
        b=HydICvJUK/LGVZcnkEFXBnqKLswqIa68JJEBXkvuz8f9/2vj5+AjOrUgOOWT1clw4R
         I8/tz84KmvQnIGzuBr2JUX10kPAiueZiDbfxuD/oCcvVVlvKaaKHuT+mqEUxv7CAIiHc
         ZhwtxNvbwnJDR2NL10gkuTxwbs7gFpGncr+l8/wWThJTL8mZJw9aALNLoZLsZgQsH5TZ
         W45z95tCgP6wl/ilBJmscu/8oMrtOfPbbbWrkPrV0XASnuwrd0gZ5H6++RmvW04KfMW3
         Tv5q+63//1komVkpqPbFCKTeXPlbkG9agUx9+OqsZS60RFYM1/6l0lcX+Eb4SNr7dHbH
         E6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkGU7R40AthO2TACaX1LtXYqx5KDs3cB/We4L7vR8bk=;
        b=Pyymrrxc07nyOOGxJQQ7Yyfshx5l7NTehrrey6W4UUvT/0uBSAmhJ2ZKvLpXZ1k/my
         v2arqqUkXAbZOSj8OhVmp8x3uzqJB4AXwq3OWLswIgQSNczkKJyRegC+6O6cbCNFln6e
         Q7iUjQSsCfqUAfSvAIZh5fz2ZSnDiWWCXO+RlgPONN8ccZZcyXjdBAx4CHO+jyIaPCpF
         1vJhUIUKZtPK8dt0zPKgk+qRb0BBZhXNkBmLtwa5LfOg4rz/Y+NqS1UBub8CilYorUCS
         NuvfTcd4zuq3TqRGJe1HHfUUkrKleWT5ka19POHfykDjtQ2PP1AVCJEwQpyyV9qbsPha
         SaWw==
X-Gm-Message-State: AOAM531rNeCAXmqIGULf735Y9cpxHnBr3q3dg4Ehh9ieR+fWS1G8dU9S
        wKbAA0oegDh8ZQy3Cw2ThPU=
X-Google-Smtp-Source: ABdhPJx6MzIcCKDpWG3DM2Je7NIa+Lu0rqLChPAdo146B9pr6L4ywTlTrfs95aBCFwbtJpfnPzR6jA==
X-Received: by 2002:adf:82b8:: with SMTP id 53mr43772293wrc.172.1593858347670;
        Sat, 04 Jul 2020 03:25:47 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:46 -0700 (PDT)
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
Subject: [PATCH v2 05/14] drm/panfrost: use spinlock instead of atomic
Date:   Sat,  4 Jul 2020 12:25:26 +0200
Message-Id: <20200704102535.189647-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert busy_count to a simple int protected by spinlock.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 43 +++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  9 ++++-
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 962550363391..78753cfb59fb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -12,16 +12,12 @@
 
 static void panfrost_devfreq_update_utilization(struct panfrost_devfreq *pfdevfreq)
 {
-	ktime_t now;
-	ktime_t last;
-
-	if (!pfdevfreq->devfreq)
-		return;
+	ktime_t now, last;
 
 	now = ktime_get();
 	last = pfdevfreq->time_last_update;
 
-	if (atomic_read(&pfdevfreq->busy_count) > 0)
+	if (pfdevfreq->busy_count > 0)
 		pfdevfreq->busy_time += ktime_sub(now, last);
 	else
 		pfdevfreq->idle_time += ktime_sub(now, last);
@@ -59,10 +55,14 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
+	unsigned long irqflags;
+
+	status->current_frequency = clk_get_rate(pfdev->clock);
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
 
 	panfrost_devfreq_update_utilization(pfdevfreq);
 
-	status->current_frequency = clk_get_rate(pfdev->clock);
 	status->total_time = ktime_to_ns(ktime_add(pfdevfreq->busy_time,
 						   pfdevfreq->idle_time));
 
@@ -70,6 +70,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	panfrost_devfreq_reset(pfdevfreq);
 
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
+
 	dev_dbg(pfdev->dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
 		status->busy_time / (status->total_time / 100),
@@ -100,6 +102,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	else if (ret)
 		return ret;
 
+	spin_lock_init(&pfdevfreq->lock);
+
 	panfrost_devfreq_reset(pfdevfreq);
 
 	cur_freq = clk_get_rate(pfdev->clock);
@@ -162,15 +166,32 @@ void panfrost_devfreq_suspend(struct panfrost_device *pfdev)
 
 void panfrost_devfreq_record_busy(struct panfrost_devfreq *pfdevfreq)
 {
+	unsigned long irqflags;
+
+	if (!pfdevfreq->devfreq)
+		return;
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
+
 	panfrost_devfreq_update_utilization(pfdevfreq);
-	atomic_inc(&pfdevfreq->busy_count);
+
+	pfdevfreq->busy_count++;
+
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
 }
 
 void panfrost_devfreq_record_idle(struct panfrost_devfreq *pfdevfreq)
 {
-	int count;
+	unsigned long irqflags;
+
+	if (!pfdevfreq->devfreq)
+		return;
+
+	spin_lock_irqsave(&pfdevfreq->lock, irqflags);
 
 	panfrost_devfreq_update_utilization(pfdevfreq);
-	count = atomic_dec_if_positive(&pfdevfreq->busy_count);
-	WARN_ON(count < 0);
+
+	WARN_ON(--pfdevfreq->busy_count < 0);
+
+	spin_unlock_irqrestore(&pfdevfreq->lock, irqflags);
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 0697f8d5aa34..3392df1020be 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_DEVFREQ_H__
 #define __PANFROST_DEVFREQ_H__
 
+#include <linux/spinlock.h>
 #include <linux/ktime.h>
 
 struct devfreq;
@@ -14,10 +15,16 @@ struct panfrost_device;
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+
 	ktime_t busy_time;
 	ktime_t idle_time;
 	ktime_t time_last_update;
-	atomic_t busy_count;
+	int busy_count;
+	/*
+	 * Protect busy_time, idle_time, time_last_update and busy_count
+	 * because these can be updated concurrently between multiple jobs.
+	 */
+	spinlock_t lock;
 };
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev);
-- 
2.25.1

