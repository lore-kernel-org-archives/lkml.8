Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E0C33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620602187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WcPRp+7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgANHQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:16:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41751 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgANHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:16:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so4868162plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSlwbkk1pzyLFKga0+D5pkXbBE5RP0e6plgOO4eYBJQ=;
        b=WcPRp+7Mdnpj9rMQS/ieZ3gIzSidtcpvoi1VWauuCFrsi4euYkjOGWlPabSCB8OsXn
         fY+YYvvLPmrGfP7dqyY3bXJOdPSwTJ5H54BELtP27PkE73ZBk5FuadDchNDNSvGGv0S4
         eY1/zvVBMuRO/wV9+mzojLylgHcwdzX5frKms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSlwbkk1pzyLFKga0+D5pkXbBE5RP0e6plgOO4eYBJQ=;
        b=HyeJ5RMltuBO/r79qMflzOYSGqkSm44QUmEsaa5EvOL+lxH0unRs4AcGcCbNE+PWxw
         uU+Oywgodo9a2O8obmkWWrs+sjqN1IHn2DMPAPnhATQTpxsO8aMR1RXDpgvJJnOSTO/R
         Kgo/EJ/RzPCma4wVtnTRff7M1YrfW5H4N938SmRs6BvG+FDV4xZTHx8Yo4I36LUflOcz
         dS+ru7Sn6PKdci8yYbAEhqUAb6cNe46NKRThYyWQd8du4UtRfIC1fxwWm972uDeGImrr
         xEXgcvDhnH58IyfIGENkEbwf+r9JNsxNIr7rqkVx/xHaPAGTQtKIvfZD8rSf3bT8b7vN
         OU1A==
X-Gm-Message-State: APjAAAV93olCfzU1Wt55qFMjVQqJhrMxP326E+YbeXuc98cMoD65W7s/
        NjTZFx3KR/jndAGofGYx4I02/w==
X-Google-Smtp-Source: APXvYqxAVfz0yEjQZNh09tBVmqQhNTSo4PFJ0addejqjhSdLfGflyqf0R2L9U0djUMmD4gnScDcTBQ==
X-Received: by 2002:a17:90a:bf92:: with SMTP id d18mr20309660pjs.21.1578986189911;
        Mon, 13 Jan 2020 23:16:29 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id b4sm17092976pfd.18.2020.01.13.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:16:29 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v3 7/7, RFC] drm/panfrost: devfreq: Add support for 2 regulators
Date:   Tue, 14 Jan 2020 15:16:02 +0800
Message-Id: <20200114071602.47627-8-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200114071602.47627-1-drinkcat@chromium.org>
References: <20200114071602.47627-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
devfreq, and provides OPP table with 2 sets of voltages.

TODO: This is incomplete as we'll need add support for setting
a pair of voltages as well.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 17 +++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbfccb..9c0987a3d71c597 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -79,6 +79,21 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 
+	/* If we have 2 regulator, we need an OPP table with 2 voltages. */
+	if (pfdev->comp->num_supplies > 1) {
+		pfdev->devfreq.dev_opp_table =
+			dev_pm_opp_set_regulators(dev,
+					pfdev->comp->supply_names,
+					pfdev->comp->num_supplies);
+		if (IS_ERR(pfdev->devfreq.dev_opp_table)) {
+			ret = PTR_ERR(pfdev->devfreq.dev_opp_table);
+			pfdev->devfreq.dev_opp_table = NULL;
+			dev_err(dev,
+				"Failed to init devfreq opp table: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret == -ENODEV) /* Optional, continue without devfreq */
 		return 0;
@@ -119,6 +134,8 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+	if (pfdev->devfreq.dev_opp_table)
+		dev_pm_opp_put_regulators(pfdev->devfreq.dev_opp_table);
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 143eab57180a2e1..30ba11cbf600847 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -108,6 +108,7 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
+		struct opp_table *dev_opp_table;
 		ktime_t busy_time;
 		ktime_t idle_time;
 		ktime_t time_last_update;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

