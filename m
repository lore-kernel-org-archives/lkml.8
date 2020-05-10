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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B3C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B91E20731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLvzjf9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgEJQzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729113AbgEJQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 12:55:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2753C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so15402709wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bippylaynVEVx7ObrNiT6Ic+rvbOlStPyxBgQ4ebR4=;
        b=mLvzjf9tyqQOA4JT25otf9u7qVKUd1UcbrKeHtJApUClHF7AEI7Btsb3RJ4GVO/2sk
         ktyl18CUMbEGy9VaD/qGgN2wHFrY34/q7rClkTx7Pa+7/eprkylosBV8BioMtELEhfOv
         lJ6qv7+IjYVDYaMcOTzrrdGijHMojoZY2hM2BWRDc2Do+dSOwOKL64ro1c/3ZvmXj/Sb
         D3FmGkt5MAAZPRJuc0nHiTx9DKbiBeqW/D6qdzHy3wsX9Q6fPB0V2kZdf9gurNii+aCF
         BOutcFU5kmDCshJ92TLZBRTCU5ny3S0nr591ba9a+BBjkBT7co8mCNftzjNhXIFlaP76
         gLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bippylaynVEVx7ObrNiT6Ic+rvbOlStPyxBgQ4ebR4=;
        b=HKeU0c0Y7YsVvoylDdzn0SGEfpRC47fmSMiIUelaQwEUBEF6xwqyEHNQcigMwthV/Z
         FK1J6oxKnTXjEGdR0friRtsvWaSn8VvWqWNMaaj44U0+MlZihxs7eU4AbP3lO5ad2/tt
         6VuIjCe6vbINkecS87rJdeNd6p7eUiWkoZrU7TKcjHhDqLR8NtSeSxCsO79srmz1mxe0
         d19B2TBEHm3dcynqyfLNuA3gkSlG8002Rw2QRfkELp/epVZkrjp3uWZBpoFBgIoEISH+
         jbMdxsTgizpofoXDGLYE0b1BXPGg8dedOeUZ3y+7mi+TpcfoWGjvXGDZbSotCyHEv7hY
         xn6A==
X-Gm-Message-State: AGi0Pub8NDJg98Y34NGPA7A8DNs5Qd/+2EevXPBDdJIxZQ/tN5ht50XL
        vYlc8uFD0xLQH2CrqK78ZSg=
X-Google-Smtp-Source: APiQypK1sVn497y747i37PmqhIarjI1oQjofRU/MP5nQq4b9qjEU+Ptfl9Qu65MLYywulAZddB4xNw==
X-Received: by 2002:a05:600c:243:: with SMTP id 3mr22975979wmj.73.1589129747378;
        Sun, 10 May 2020 09:55:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:1cc8:b1f1:a2b8:a1ee])
        by smtp.gmail.com with ESMTPSA id g15sm13637670wrp.96.2020.05.10.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 09:55:46 -0700 (PDT)
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
Subject: [PATCH 05/15] drm/panfrost: use spinlock instead of atomic
Date:   Sun, 10 May 2020 18:55:28 +0200
Message-Id: <20200510165538.19720-6-peron.clem@gmail.com>
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

Convert busy_count to a simple int protected by spinlock.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 43 +++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_devfreq.h | 10 ++++-
 2 files changed, 41 insertions(+), 12 deletions(-)

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
index 0697f8d5aa34..e6629900a618 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_DEVFREQ_H__
 #define __PANFROST_DEVFREQ_H__
 
+#include <linux/spinlock.h>
 #include <linux/ktime.h>
 
 struct devfreq;
@@ -14,10 +15,17 @@ struct panfrost_device;
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
+	 * because these can be updated concurrently, for example by the GP
+	 * and PP interrupts.
+	 */
+	spinlock_t lock;
 };
 
 int panfrost_devfreq_init(struct panfrost_device *pfdev);
-- 
2.20.1

