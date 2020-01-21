Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785F7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A88F24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:41:27 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8632 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:41:27 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L8Yrhl010719;
        Tue, 21 Jan 2020 03:40:51 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbeyv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 03:40:51 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00L8ennv050293
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 21 Jan 2020 03:40:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 21 Jan
 2020 03:40:48 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 21 Jan 2020 03:40:48 -0500
Received: from btogorean-pc.ad.analog.com ([10.48.65.146])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00L8Sm9b001010;
        Tue, 21 Jan 2020 03:40:44 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <matt.redfearn@thinci.com>, <robdclark@chromium.org>,
        <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v4 2/3] drm: bridge: adv7511: Add support for ADV7535
Date:   Tue, 21 Jan 2020 10:27:22 +0200
Message-ID: <20200121082719.27972-3-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121082719.27972-1-bogdan.togorean@analog.com>
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001210073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADV7535 is a DSI to HDMI bridge chip like ADV7533 but it allows
1080p@60Hz. v1p2 is fixed to 1.8V on ADV7535.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/gpu/drm/bridge/adv7511/Kconfig       |  4 ++--
 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 16 +++++++++-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig b/drivers/gpu/drm/bridge/adv7511/Kconfig
index a7fe07117345..47d4eb9e845d 100644
--- a/drivers/gpu/drm/bridge/adv7511/Kconfig
+++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
@@ -6,7 +6,7 @@ config DRM_I2C_ADV7511
 	select REGMAP_I2C
 	select DRM_MIPI_DSI
 	help
-	  Support for the Analog Device ADV7511(W)/13/33 HDMI encoders.
+	  Support for the Analog Device ADV7511(W)/13/33/35 HDMI encoders.
 
 config DRM_I2C_ADV7511_AUDIO
 	bool "ADV7511 HDMI Audio driver"
@@ -17,7 +17,7 @@ config DRM_I2C_ADV7511_AUDIO
 	  conjunction with the AV7511  HDMI driver.
 
 config DRM_I2C_ADV7511_CEC
-	bool "ADV7511/33 HDMI CEC driver"
+	bool "ADV7511/33/35 HDMI CEC driver"
 	depends on DRM_I2C_ADV7511
 	select CEC_CORE
 	default y
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 12552d54931b..a9bb734366ae 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -320,6 +320,7 @@ struct adv7511_video_config {
 enum adv7511_type {
 	ADV7511,
 	ADV7533,
+	ADV7535,
 };
 
 #define ADV7511_MAX_ADDRS 3
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 34df29d79e2b..a275e6c91bd7 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -367,7 +367,7 @@ static void adv7511_power_on(struct adv7511 *adv7511)
 	 */
 	regcache_sync(adv7511->regmap);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_dsi_power_on(adv7511);
 	adv7511->powered = true;
 }
@@ -387,7 +387,7 @@ static void __adv7511_power_off(struct adv7511 *adv7511)
 static void adv7511_power_off(struct adv7511 *adv7511)
 {
 	__adv7511_power_off(adv7511);
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_dsi_power_off(adv7511);
 	adv7511->powered = false;
 }
@@ -761,7 +761,7 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_mode_set(adv7511, adj_mode);
 
 	drm_mode_copy(&adv7511->curr_mode, adj_mode);
@@ -874,7 +874,7 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
 				 &adv7511_connector_helper_funcs);
 	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
 
-	if (adv->type == ADV7533)
+	if (adv->type == ADV7533 || adv->type == ADV7535)
 		ret = adv7533_attach_dsi(adv);
 
 	if (adv->i2c_main->irq)
@@ -952,7 +952,7 @@ static bool adv7511_cec_register_volatile(struct device *dev, unsigned int reg)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		reg -= ADV7533_REG_CEC_OFFSET;
 
 	switch (reg) {
@@ -994,7 +994,7 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
 		goto err;
 	}
 
-	if (adv->type == ADV7533) {
+	if (adv->type == ADV7533 || adv->type == ADV7535) {
 		ret = adv7533_patch_cec_registers(adv);
 		if (ret)
 			goto err;
@@ -1242,7 +1242,7 @@ static int adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	if (adv7511->type == ADV7533)
+	if (adv7511->type == ADV7533 || adv7511->type == ADV7535)
 		adv7533_detach_dsi(adv7511);
 	i2c_unregister_device(adv7511->i2c_cec);
 	if (adv7511->cec_clk)
@@ -1267,6 +1267,7 @@ static const struct i2c_device_id adv7511_i2c_ids[] = {
 	{ "adv7511w", ADV7511 },
 	{ "adv7513", ADV7511 },
 	{ "adv7533", ADV7533 },
+	{ "adv7535", ADV7535 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adv7511_i2c_ids);
@@ -1276,6 +1277,7 @@ static const struct of_device_id adv7511_of_ids[] = {
 	{ .compatible = "adi,adv7511w", .data = (void *)ADV7511 },
 	{ .compatible = "adi,adv7513", .data = (void *)ADV7511 },
 	{ .compatible = "adi,adv7533", .data = (void *)ADV7533 },
+	{ .compatible = "adi,adv7535", .data = (void *)ADV7535 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adv7511_of_ids);
-- 
2.24.1

