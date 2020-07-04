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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC47C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4772520870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLw6z/lP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGDKZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGDKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB11C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:25:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so35333978wrn.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PPcg5UlBRq0w4LR6ro2v8Q7Hq7d6jVFUN9WJytznf0=;
        b=LLw6z/lPBPk9eRudhoD2GhCQN2yf6/vRH7B9bzbbvt2rZyBFg8i4afsacJl2VCxxyc
         MU0WnqLFBci4J72OOA4qlyc0wdPBMIWoIZ9ReADOe4aljTU0XwPrvP8EC8hqKHZCDzgU
         C2K/kDDkHUVzv91aW+wkI2ttYeiEox+KJyE1GtTxCjFXZI8K4FhT0hgP1X5aSi/YapAq
         2uwI6rtvxeqQT0mXOj0Nqc1+Igpxur2KwJVPbvxg1ATtPzz2yWaM1M9kTm+CoP9c9f6n
         m92vefWCiZ4APg7m/P4884EKsdpJoSfnZ5EAY9SQyjyovpc0FR3mol9XeEm2PfAhyxs/
         cbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PPcg5UlBRq0w4LR6ro2v8Q7Hq7d6jVFUN9WJytznf0=;
        b=ufZ/15IhAY17pdAocyHKP5FHfWIPmlMg/299LmVQFwABcud+Xi9tpdtkZS3tuU4zwN
         ClCw4ORhdoUbqNqtB9cIFVbmhiAsTl++w5XRY1nZrwVU3g9jk9Z2RSlFRITXH5G3k0XM
         yjApIVh2gsa0Dj2JDyqp8T5awWb21jUuiBi7qrb2gZG8mT5UWj+s/36z9Q9FdAWVXOJU
         EFy20Ia2JLD/Qw3GKMHfXIQsz5lrPpMang+Isac+sZk26DvG/v4oojUJ2jLwH3Iylojh
         3xffW+IW1hPirb97X1887fqztfnRObMI74F2WpMD/VwTYgMZhdIbLw3drv0lK6K/mua3
         OItQ==
X-Gm-Message-State: AOAM5308JTSuGePXikkozBLQUYAVeji2IVJkIpQcVgWePIl7mwb6CS4y
        4nCQdlotAC//9AgtMOhtP2I=
X-Google-Smtp-Source: ABdhPJwgyjK4HfdOdlAHjlrwJp3kauA7Q5SEnSmInR4v0bMUWpQskG8gyIQp4x8u4GgxMvdShnulTQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr40632842wrs.228.1593858343437;
        Sat, 04 Jul 2020 03:25:43 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id g14sm16421428wrm.93.2020.07.04.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 03:25:42 -0700 (PDT)
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
Subject: [PATCH v2 01/14] drm/panfrost: avoid static declaration
Date:   Sat,  4 Jul 2020 12:25:22 +0200
Message-Id: <20200704102535.189647-2-peron.clem@gmail.com>
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

This declaration can be avoided so change it.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>
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

