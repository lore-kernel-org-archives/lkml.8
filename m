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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B69AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2355120775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1hRnstX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGJJyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgGJJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:54:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so5312541wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsZBAmiYMMWM033wa5CbybhLIp9AyDubE3t8XcgJYF0=;
        b=g1hRnstX0KAA0TEe9/LBKmiZM8SnwW3Ceq5pVmpcs25HNQO/3ej99pCNvyqYt9j5W5
         BnHtTUV4a1UfYIyJsWlI1RLY8+VpUPLjtPl2uW6kJkIvtDHbhX9we55hF2s/L/Z4HXni
         cQO7MKG5cElwT9GZwHwXfN/Nb8J5wAxPUQETl+cch+0S21SCwPdhap5mlUIVsxtYy7Kd
         ElmKMGeF8ksXT6wqm8XYeFdDcmY0dCIddPbp1c8KGYL7Jn8nSHIFC4X6DVY9u4cL1Hdg
         vuPlOE5x+8bb+GbiZMd+KCj3AWPIB+uLaVucHL2BtlDErsyejLy+WJwI8sbM6TvYv32p
         Hm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsZBAmiYMMWM033wa5CbybhLIp9AyDubE3t8XcgJYF0=;
        b=IQKDXcgJ8UlyR02teATfVPL5d4TGNksh/Ut670P1GNpRAjhd2zoUyx7Dzda7+iDYt2
         Xp7hkGDPR3A4ueYuzhhLy2AwFAVu9Y6T/OyxgqyIVf2cIME4SthN/grwb3nd9laFtW0K
         9yJZhgk6XTIlLecTkTOv2IohK1EPMBeJ8E+hTk9sp6g0IkPnS1gyl5PGiXuBb35NkD94
         dtk5yBkujVv49+rzPY8OiEG3YxFiCizp5rbU9litDuwhDNgNVBfqyURD4fFE9pQFzWap
         X/uvyDljTwBkYAKVTk+Hn8wTviGMGb1KzGz+Ld4NTfnEF2g6Cp8lPwq6Z/NSF5OKlGKM
         ynRw==
X-Gm-Message-State: AOAM530++RPrNjhpzvDiS5dBAsz54bleI4+/So1YHmXbwsiwFiPrijJK
        /W4o6svtmFNXJ/jTSUdN218=
X-Google-Smtp-Source: ABdhPJz9k8Or14CAxaDV8DN7nBAuiwb7jAMVEFo51CP2oS1LoNtXzRoWio14pCQ9P+FFEcgAgM5v6A==
X-Received: by 2002:adf:e811:: with SMTP id o17mr71819931wrm.53.1594374864451;
        Fri, 10 Jul 2020 02:54:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id u23sm10176092wru.94.2020.07.10.02.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:54:23 -0700 (PDT)
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
Subject: [PATCH v5 10/14] drm/panfrost: add regulators to devfreq
Date:   Fri, 10 Jul 2020 11:54:05 +0200
Message-Id: <20200710095409.407087-11-peron.clem@gmail.com>
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

Some OPP tables specify voltage for each frequency. Devfreq can
handle these regulators but they should be get only 1 time to avoid
issue and know who is in charge.

If OPP table is probe don't init regulator.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 29 ++++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  2 ++
 drivers/gpu/drm/panfrost/panfrost_device.c  |  9 ++++---
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index d9007f44b772..8ab025d0035f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -93,14 +93,30 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	unsigned long cur_freq;
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
+	struct opp_table *opp_table;
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
+	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
+					      pfdev->comp->num_supplies);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		/* Continue if the optional regulator is missing */
+		if (ret != -ENODEV) {
+			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
+			goto err_fini;
+		}
+	} else {
+		pfdevfreq->regulators_opp_table = opp_table;
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
-		return 0;
-	else if (ret)
-		return ret;
+	if (ret) {
+		/* Optional, continue without devfreq */
+		if (ret == -ENODEV)
+			ret = 0;
+		goto err_fini;
+	}
 	pfdevfreq->opp_of_table_added = true;
 
 	spin_lock_init(&pfdevfreq->lock);
@@ -153,6 +169,11 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 		dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
 		pfdevfreq->opp_of_table_added = false;
 	}
+
+	if (pfdevfreq->regulators_opp_table) {
+		dev_pm_opp_put_regulators(pfdevfreq->regulators_opp_table);
+		pfdevfreq->regulators_opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.h b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
index 210269944687..db6ea48e21f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.h
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.h
@@ -8,12 +8,14 @@
 #include <linux/ktime.h>
 
 struct devfreq;
+struct opp_table;
 struct thermal_cooling_device;
 
 struct panfrost_device;
 
 struct panfrost_devfreq {
 	struct devfreq *devfreq;
+	struct opp_table *regulators_opp_table;
 	struct thermal_cooling_device *cooling;
 	bool opp_of_table_added;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index f1474b961def..e6896733838a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -225,9 +225,12 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 		goto out_clk;
 	}
 
-	err = panfrost_regulator_init(pfdev);
-	if (err)
-		goto out_devfreq;
+	/* OPP will handle regulators */
+	if (!pfdev->pfdevfreq.opp_of_table_added) {
+		err = panfrost_regulator_init(pfdev);
+		if (err)
+			goto out_devfreq;
+	}
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
-- 
2.25.1

