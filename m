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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C33C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D37120775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Sw/HtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGJJzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGJJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so5293988wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztEfvDOenwmzhW91KrXpwCBICtYWbElja0rQb72V3Pc=;
        b=g2Sw/HtRWWNJ5encQ3nPzyJELqRZMCj5wm71m7O+SPkz1nmaO46NZsXat+Z8/XgW/L
         igZoeYAytqCjnVdz96EzvYEsJ7IsKnmxHZrqTYW2wQv+XEylqdz5q5jGeJpZ7hrNYYTF
         in5i4GW03rPLwBd80LItpC6LwoR3/Ta+osSktb5bjR2B+rKz15l+GkmrLZjtoL76QWWZ
         issqIjbbSocExDwwcamif8oOvMpYu+VhDW1ur+D0QUpXdEXnDAxATZHqB9ApguNsnVAq
         ieYgqcl0SZPKv9vlR+xVgokJAi5QJzwucw7NIXJ8i21XTB8YayKstmwxIqUH3JAjxdF1
         kBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztEfvDOenwmzhW91KrXpwCBICtYWbElja0rQb72V3Pc=;
        b=o1l+U++bNY2tnDEaVvDildg3czTse9obN7HRGNdC6FYqBL2AFTrxTmF4EyXYshWeDd
         Q5mXPqRaO7bbGXtZkk2oQ9SkPkuKQldViNXhDbmZeK++9ah21NK662l9k0DmeJPv0fC+
         F1w0qeGDkHQ6cGjgN0atnppZgDVUcA8mJVqSmLILjeYSHEnYWk7X2FJtKel5YKDYNvw+
         4PjiRZF1V0GunN1q554kLRu1/dmGA+cZ6NFRkIRSDOJozdC54rO8KIoE5tq7YJpss3J/
         KuyI3hxmf5+VPODW+GS27mo2eNYQTWXI5JNrVpzW3GtNjCY90AhTVeF+t9bGA++YcWGV
         qNdw==
X-Gm-Message-State: AOAM53156f8lD9Hor5CkaNYRWfY6sxMdAYEzVMNck0+X+vP9XpboDi27
        +cG7sYtk+vmWlUsh1pcKtfQ=
X-Google-Smtp-Source: ABdhPJwzCuVZOhYt/qbcLHI1t2KZzcXMm7lxjQOjcyDF+zp22T7tp6c5A+pU+XH8wU1rId7MRkLtcw==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr72601276wrp.198.1594374858621;
        Fri, 10 Jul 2020 02:54:18 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:17 -0700 (PDT)
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
Subject: [PATCH v5 05/14] drm/panfrost: use spinlock instead of atomic
Date:   Fri, 10 Jul 2020 11:54:00 +0200
Message-Id: <20200710095409.407087-6-peron.clem@gmail.com>
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

Convert busy_count to a simple int protected by spinlock.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
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

