Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F30C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5042137B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrjRuhiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgDKUG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:06:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53119 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDKUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:06:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id o81so132004wmo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoldyKJXtADkuzgLMxvc+aHQ8la7JVhSLGXOECKmOcc=;
        b=hrjRuhiQBhcZ1WdJ1Gq9N8RInWD2+8L6tzMXKTt9nRC+YJSlhe8o2apD1lBuGHue63
         Gz72gk10Zomzi4uGEfF3sk1XpJPCLdmSGvztUeSx3G8GrSFxCKwtL4OLh4Nou5ySW1HH
         NbtcXX3XCTFKitlpLdHotw/U0MXkWnNWhIVU3/EH+tzgY6BG/FM9cIY0Ztba2yNOkKew
         1S14PgZe1f14Nigk4Q+Vmhmidu2QglqQ4QBLWgKPeGfdufLgIGe2YLL8yxP41aLV/BNw
         1EcNjmXLluI3nk18jkOu3nxiT0sq/SymW2ZYG0wT+LqRc+fjijZuJ1wXbP/V0I1yzIJy
         bxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoldyKJXtADkuzgLMxvc+aHQ8la7JVhSLGXOECKmOcc=;
        b=tzInJrwyrpZmnlopqcmSTKJTpZ4EAopz1GEVclsp8j9nJMzVOTcktPePimwtE1MDRk
         4VVHNThIBuAwkdzKhtts45LpsEknjARDu0Y/D1ZWGc05lj0u6iENkOHuH6kF64bj2DAP
         wNZJHuFJTBbx15nWys0eFvsRh/6yT7N4/VMHGaTJz5dgiG6Je9jlV3c6wDQmkouXtL58
         lbhVTeuiZ1TkB9dQn+XelX3CjbEewbpXra5ALqobMWwWxm75gN+EPTAmHZaaJ9Ps8Pvk
         YxwxYmrWOMAT64twqoYfC0kT391NwfJvqvXwvHhm5v+zStxnKZNwZ/QpkJkF54PA+D3u
         C8ug==
X-Gm-Message-State: AGi0PubMwBKMleuYbmId0pKJzZo6D76keDEbAt0Bo9830aEaAzxx1aSZ
        SwuXawlqitgMH880xRz6Jwk=
X-Google-Smtp-Source: APiQypLbsvsk9zLeeFB8Obt5V3v8jpdg3Qf2EvxxzUQlswj5qD7Vw52StvIIPRQTWSewjjjJ1SYvAg==
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr10824862wme.38.1586635606681;
        Sat, 11 Apr 2020 13:06:46 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id y5sm8712670wru.15.2020.04.11.13.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 13:06:45 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] drm/panfrost: add devfreq regulator support
Date:   Sat, 11 Apr 2020 22:06:32 +0200
Message-Id: <20200411200632.4045-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411200632.4045-1-peron.clem@gmail.com>
References: <20200411200632.4045-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPP table can defined both frequency and voltage.

Register the mali regulator if it exist.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 62541f4edd81..2dc8e2355358 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct device *dev = &pfdev->pdev->dev;
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
+	const char *mali = "mali";
+	struct opp_table *opp_table = NULL;
+
+	/* Regulator is optional */
+	opp_table = dev_pm_opp_set_regulators(dev, &mali, 1);
+	if (IS_ERR(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		if (ret != -ENODEV) {
+			DRM_DEV_ERROR(dev, "Failed to set regulator: %d\n", ret);
+			return ret;
+		}
+	}
+	pfdev->devfreq.opp_table = opp_table;
 
 	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
-		return 0;
-	else if (ret)
-		return ret;
+	if (ret) {
+		if (ret == -ENODEV) /* Optional, continue without devfreq */
+			ret = 0;
+		goto err_opp_reg;
+	}
 
 	panfrost_devfreq_reset(pfdev);
 
@@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
 
+err_opp_reg:
+	if (pfdev->devfreq.opp_table) {
+		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
+		pfdev->devfreq.opp_table = NULL;
+	}
+
 	return ret;
 }
 
@@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_device *pfdev)
 {
 	if (pfdev->devfreq.cooling)
 		devfreq_cooling_unregister(pfdev->devfreq.cooling);
+
 	dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
+
+	if (pfdev->devfreq.opp_table) {
+		dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
+		pfdev->devfreq.opp_table = NULL;
+	}
 }
 
 void panfrost_devfreq_resume(struct panfrost_device *pfdev)
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 06713811b92c..f6b0c779dfe5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -86,6 +86,7 @@ struct panfrost_device {
 	struct {
 		struct devfreq *devfreq;
 		struct thermal_cooling_device *cooling;
+		struct opp_table *opp_table;
 		ktime_t busy_time;
 		ktime_t idle_time;
 		ktime_t time_last_update;
-- 
2.20.1

