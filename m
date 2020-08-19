Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDC4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B920208C7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597837670;
	bh=O4vgNwTHiXZS7BW6/Yll/k5o8U1mTh8w04hTRoj11Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ezbmnnEj/eV2NZpqSSu+wtV9H43wuliD5/ibypsy27c7ZGX6OMVy5mhTq9hjoFaiu
	 6X4NOh3xbTzVmXBp+ciNoUFoeIGMVLz5oamHu/HbqqKM/izPhs+HwQCSpEZS4uhHIh
	 9XJP9g/0KyAJa5LnHAek4Ne+Q7I2uGB2lOPlvT/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHSLrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgHSLqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:46:31 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2120214F1;
        Wed, 19 Aug 2020 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=O4vgNwTHiXZS7BW6/Yll/k5o8U1mTh8w04hTRoj11Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDL3E2nDEAeo4qo4yLkxmGZyWDf//57rJI44KuYGZ1N7FbeelvAAINu0jG0VE4Bqn
         thndG0aLa+okPvdbGCCorhre2sBNKpqQGnPGHCdFEIM+/Obkpn8xpMYawiT3pBKHs3
         Ep6U3sFAJDOAkfguVjobKjV+63PiuWdZhU9zaI0A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXr-00EuaM-NY; Wed, 19 Aug 2020 13:46:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Rob Clark <robdclark@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/49] staging: hikey9xx/gpu: add debug prints for this driver
Date:   Wed, 19 Aug 2020 13:45:38 +0200
Message-Id: <71e74aa8ff84a2f0b879c46a63d5f51f6d808348.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubin Zhang <zhangxiubin1@huawei.com>

Add some debug prints on adv7535 and kirin_drm_drv.

Signed-off-by: Xiubin Zhang <zhangxiubin1@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/hdmi/adv7535.c  | 40 ++++++++++++++++++--
 drivers/staging/hikey9xx/gpu/kirin_drm_drv.c |  2 +-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c b/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
index a21a8f8b917e..04c1e7b9ca8e 100644
--- a/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
+++ b/drivers/staging/hikey9xx/gpu/hdmi/adv7535.c
@@ -28,7 +28,8 @@
 
 #include "adv7535.h"
 
-#define HPD_ENABLE	1
+//#define HPD_ENABLE	1
+#define HPD_ENABLE	0
 //#define TEST_COLORBAR_DISPLAY
 #ifdef CONFIG_HDMI_ADV7511_AUDIO
 extern int adv7511_audio_init(struct device *dev);
@@ -785,19 +786,25 @@ adv7511_detect(struct adv7511 *adv7511,
 {
 	enum drm_connector_status status;
 	unsigned int val;
+	unsigned int time = 0;
 #if HPD_ENABLE
 	bool hpd;
 #endif
 	int ret;
 
 	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
-	if (ret < 0)
+	if (ret < 0) {
+		DRM_ERROR("regmap_read fail, ret = %d \n", ret);
 		return connector_status_disconnected;
+	}
 
-	if (val & ADV7511_STATUS_HPD)
+	if (val & ADV7511_STATUS_HPD) {
+		DRM_INFO("connected : regmap_read val = 0x%x \n", val);
 		status = connector_status_connected;
-	else
+	} else {
+		DRM_INFO("disconnected : regmap_read val = 0x%x \n", val);
 		status = connector_status_disconnected;
+	}
 
 #if HPD_ENABLE
 	hpd = adv7511_hpd(adv7511);
@@ -820,7 +827,32 @@ adv7511_detect(struct adv7511 *adv7511,
 	}
 #endif
 
+	if (status == connector_status_disconnected) {
+		do {
+			ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
+			if (ret < 0) {
+				DRM_ERROR("regmap_read fail, ret = %d \n", ret);
+				return connector_status_disconnected;
+			}
+
+			if (val & ADV7511_STATUS_HPD) {
+				DRM_INFO("connected : regmap_read val = 0x%x \n", val);
+				status = connector_status_connected;
+			} else {
+				DRM_INFO("disconnected : regmap_read val = 0x%x \n", val);
+				status = connector_status_disconnected;
+			}
+			time ++;
+			mdelay(20);
+		} while (status == connector_status_disconnected && time < 10);
+	}
+
+	if (time >= 10)
+		DRM_ERROR("Read connector status timout, time = %d \n", time);
+
 	adv7511->status = status;
+
+	DRM_INFO("hdmi connector status = %d \n", status);
 	return status;
 }
 
diff --git a/drivers/staging/hikey9xx/gpu/kirin_drm_drv.c b/drivers/staging/hikey9xx/gpu/kirin_drm_drv.c
index 958aafa1a09c..ec1f668f2d21 100644
--- a/drivers/staging/hikey9xx/gpu/kirin_drm_drv.c
+++ b/drivers/staging/hikey9xx/gpu/kirin_drm_drv.c
@@ -144,7 +144,7 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(dev);
 
-#if 0
+#if 1
 	/* force detection after connectors init */
 	(void)drm_helper_hpd_irq_event(dev);
 #endif
-- 
2.26.2

