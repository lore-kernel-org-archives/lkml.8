Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F212072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838220;
	bh=iJOXixXaNW1y67dvEZfw3N7o4tVVZvYLeVuoX4eQ0iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jmwsk/yf4J+p+ox1f4Zigp9JLJovqV5meoMHZfHpoUe2kgIw/jlW/8MGJ0GOD8ckv
	 FBzGA8NFbgNM19bRYgOMOY3zTrz7v34f/jnkNrBSj4t9OEAUuLnfuZK47fdHYQeqKf
	 wtUbp8tlfqglojOskSQWfjQ/QMGlHsnEJm2lrtZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHSL45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgHSLti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:49:38 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE79222D03;
        Wed, 19 Aug 2020 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837584;
        bh=iJOXixXaNW1y67dvEZfw3N7o4tVVZvYLeVuoX4eQ0iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZBYyU781SJ2KSf0hdLwwD5VltioZUde/d62dhfkr+USOmSSk6z0jrI6ubEdhW6cZ
         RxGTpFdSnrmeos3BrCtbY6WRogdMOeNlGj2t3GEj+osfb11CvoH+9lezNWLBRFomRv
         iOUElw3GuivJ8ooUL7sCEwDf5RH1wm5c8R/tCcYA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXt-00EucE-ON; Wed, 19 Aug 2020 13:46:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 48/49] staging: hikey9xx/gpu: drop kirin9xx_pwm
Date:   Wed, 19 Aug 2020 13:46:16 +0200
Message-Id: <119ae70a01d925f918705817fe185301e89edbda.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of support for a panel display. Those don't come
with the Hikey 960 or 970 boards. As I don't have any of
those for tests, and we didn't port another required driver
for this to work, for now, let's drop it.

This patch can be reversed later, if one would be adding
support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../boot/dts/hisilicon/hikey970-drm.dtsi      |  37 --
 drivers/staging/hikey9xx/gpu/Makefile         |   2 +-
 drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c   | 404 ------------------
 3 files changed, 1 insertion(+), 442 deletions(-)
 delete mode 100644 drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-drm.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-drm.dtsi
index 3bd744b061ed..503c7c9425c8 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-drm.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-drm.dtsi
@@ -87,44 +87,7 @@ dsi_out0: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&adv7533_in>;
 				};
-
-				dsi_out1: endpoint@1 {
-					reg = <1>;
-					remote-endpoint = <&panel0_in>;
-				};
 			};
 		};
-
-		panel@1 {
-			compatible = "hisilicon,mipi-hikey";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			reg = <1>;
-			panel-width-mm = <94>;
-			panel-height-mm = <151>;
-			vdd-supply = <&ldo3>;
-			pwr-en-gpio = <&gpio21 3 0>;//GPIO_171
-			bl-en-gpio = <&gpio6 4 0>;//GPIO_052
-			pwm-gpio = <&gpio23 1 0>;//GPIO_185
-
-			port {
-				panel0_in: endpoint {
-					remote-endpoint = <&dsi_out1>;
-				};
-			};
-		};
-	};
-
-	panel_pwm {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "hisilicon,hisipwm";
-		reg = <0 0xE8A04000 0 0x1000>,
-			<0 0xFFF35000 0 0x1000>;
-		clocks = <&crg_ctrl HI3670_CLK_GATE_PWM>;
-		clock-names = "clk_pwm";
-		pinctrl-names = "default","idle";
-		pinctrl-0 = <&gpio185_pmx_func &gpio185_cfg_func>;
-		pinctrl-1 = <&gpio185_pmx_idle &gpio185_cfg_idle>;
 	};
 };
diff --git a/drivers/staging/hikey9xx/gpu/Makefile b/drivers/staging/hikey9xx/gpu/Makefile
index 9177c3006b14..16a708d7faec 100644
--- a/drivers/staging/hikey9xx/gpu/Makefile
+++ b/drivers/staging/hikey9xx/gpu/Makefile
@@ -5,5 +5,5 @@ kirin9xx-drm-y := kirin9xx_drm_drv.o \
 		  kirin970_defs.o kirin960_defs.o \
 		  kirin9xx_drm_overlay_utils.o
 
-obj-$(CONFIG_DRM_HISI_KIRIN9XX) += kirin9xx-drm.o kirin9xx_pwm.o
+obj-$(CONFIG_DRM_HISI_KIRIN9XX) += kirin9xx-drm.o
 obj-$(CONFIG_DRM_HISI_KIRIN9XX_DSI) += kirin9xx_dw_drm_dsi.o
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c b/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c
deleted file mode 100644
index d686664b8627..000000000000
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c
+++ /dev/null
@@ -1,404 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
- * GNU General Public License for more details.
- *
- */
-#include <drm/drm_drv.h>
-#include <drm/drm_mipi_dsi.h>
-
-#include <linux/clk.h>
-#include <linux/regmap.h>
-#include <linux/reset.h>
-#include <linux/of_address.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/pinctrl/consumer.h>
-
-#include "kirin9xx_drm_dpe_utils.h"
-#include "kirin9xx_fb_panel.h"
-#include "kirin9xx_dw_dsi_reg.h"
-
-#include "kirin9xx_dpe.h"
-
-/* default pwm clk */
-#define DEFAULT_PWM_CLK_RATE	(80 * 1000000L)
-
-static char __iomem *hisifd_pwm_base;
-static char __iomem *hisi_peri_crg_base;
-static struct clk *g_pwm_clk;
-static struct platform_device *g_pwm_pdev;
-static int g_pwm_on;
-
-static struct pinctrl_data pwmpctrl;
-
-static struct pinctrl_cmd_desc pwm_pinctrl_init_cmds[] = {
-	{DTYPE_PINCTRL_GET, &pwmpctrl, 0},
-	{DTYPE_PINCTRL_STATE_GET, &pwmpctrl, DTYPE_PINCTRL_STATE_DEFAULT},
-	{DTYPE_PINCTRL_STATE_GET, &pwmpctrl, DTYPE_PINCTRL_STATE_IDLE},
-};
-
-static struct pinctrl_cmd_desc pwm_pinctrl_normal_cmds[] = {
-	{DTYPE_PINCTRL_SET, &pwmpctrl, DTYPE_PINCTRL_STATE_DEFAULT},
-};
-
-static struct pinctrl_cmd_desc pwm_pinctrl_lowpower_cmds[] = {
-	{DTYPE_PINCTRL_SET, &pwmpctrl, DTYPE_PINCTRL_STATE_IDLE},
-};
-
-static struct pinctrl_cmd_desc pwm_pinctrl_finit_cmds[] = {
-	{DTYPE_PINCTRL_PUT, &pwmpctrl, 0},
-};
-
-#define PWM_LOCK_OFFSET	(0x0000)
-#define PWM_CTL_OFFSET	(0X0004)
-#define PWM_CFG_OFFSET	(0x0008)
-#define PWM_PR0_OFFSET	(0x0100)
-#define PWM_PR1_OFFSET	(0x0104)
-#define PWM_C0_MR_OFFSET	(0x0300)
-#define PWM_C0_MR0_OFFSET	(0x0304)
-
-#define PWM_OUT_PRECISION	(800)
-
-int pinctrl_cmds_tx(struct platform_device *pdev, struct pinctrl_cmd_desc *cmds, int cnt)
-{
-	int ret = 0;
-
-	int i = 0;
-	struct pinctrl_cmd_desc *cm = NULL;
-
-	cm = cmds;
-
-	for (i = 0; i < cnt; i++) {
-		if (!cm) {
-			DRM_ERROR("cm is null! index=%d\n", i);
-			continue;
-		}
-
-		if (cm->dtype == DTYPE_PINCTRL_GET) {
-			if (!pdev) {
-				DRM_ERROR("pdev is NULL");
-				return -EINVAL;
-			}
-			cm->pctrl_data->p = devm_pinctrl_get(&pdev->dev);
-			if (IS_ERR(cm->pctrl_data->p)) {
-				ret = -1;
-				DRM_ERROR("failed to get p, index=%d!\n", i);
-				goto err;
-			}
-		} else if (cm->dtype == DTYPE_PINCTRL_STATE_GET) {
-			if (cm->mode == DTYPE_PINCTRL_STATE_DEFAULT) {
-				cm->pctrl_data->pinctrl_def = pinctrl_lookup_state(cm->pctrl_data->p, PINCTRL_STATE_DEFAULT);
-				if (IS_ERR(cm->pctrl_data->pinctrl_def)) {
-					ret = -1;
-					DRM_ERROR("failed to get pinctrl_def, index=%d!\n", i);
-					goto err;
-				}
-			} else if (cm->mode == DTYPE_PINCTRL_STATE_IDLE) {
-				cm->pctrl_data->pinctrl_idle = pinctrl_lookup_state(cm->pctrl_data->p, PINCTRL_STATE_IDLE);
-				if (IS_ERR(cm->pctrl_data->pinctrl_idle)) {
-					ret = -1;
-					DRM_ERROR("failed to get pinctrl_idle, index=%d!\n", i);
-					goto err;
-				}
-			} else {
-				ret = -1;
-				DRM_ERROR("unknown pinctrl type to get!\n");
-				goto err;
-			}
-		} else if (cm->dtype == DTYPE_PINCTRL_SET) {
-			if (cm->mode == DTYPE_PINCTRL_STATE_DEFAULT) {
-				if (cm->pctrl_data->p && cm->pctrl_data->pinctrl_def) {
-					ret = pinctrl_select_state(cm->pctrl_data->p, cm->pctrl_data->pinctrl_def);
-					if (ret) {
-						DRM_ERROR("could not set this pin to default state!\n");
-						ret = -1;
-						goto err;
-					}
-				}
-			} else if (cm->mode == DTYPE_PINCTRL_STATE_IDLE) {
-				if (cm->pctrl_data->p && cm->pctrl_data->pinctrl_idle) {
-					ret = pinctrl_select_state(cm->pctrl_data->p, cm->pctrl_data->pinctrl_idle);
-					if (ret) {
-						DRM_ERROR("could not set this pin to idle state!\n");
-						ret = -1;
-						goto err;
-					}
-				}
-			} else {
-				ret = -1;
-				DRM_ERROR("unknown pinctrl type to set!\n");
-				goto err;
-			}
-		} else if (cm->dtype == DTYPE_PINCTRL_PUT) {
-			if (cm->pctrl_data->p)
-				pinctrl_put(cm->pctrl_data->p);
-		} else {
-			DRM_ERROR("not supported command type!\n");
-			ret = -1;
-			goto err;
-		}
-
-		cm++;
-	}
-
-	return 0;
-
-err:
-	return ret;
-}
-
-int hisi_pwm_set_backlight(struct backlight_device *bl, uint32_t bl_level)
-{
-	char __iomem *pwm_base = NULL;
-	u32 bl_max = bl->props.max_brightness;
-
-	pwm_base = hisifd_pwm_base;
-	if (!pwm_base) {
-		DRM_ERROR("pwm_base is null!\n");
-		return -EINVAL;
-	}
-
-	DRM_INFO("bl_level=%d.\n", bl_level);
-
-	if (bl_max < 1) {
-		DRM_ERROR("bl_max(%d) is out of range!!", bl_max);
-		return -EINVAL;
-	}
-
-	if (bl_level > bl_max)
-		bl_level = bl_max;
-
-	bl_level = (bl_level * PWM_OUT_PRECISION) / bl_max;
-
-	writel(0x1acce551, pwm_base + PWM_LOCK_OFFSET);
-	writel(0x0, pwm_base + PWM_CTL_OFFSET);
-	writel(0x2, pwm_base + PWM_CFG_OFFSET);
-	writel(0x1, pwm_base + PWM_PR0_OFFSET);
-	writel(0x2, pwm_base + PWM_PR1_OFFSET);
-	writel(0x1, pwm_base + PWM_CTL_OFFSET);
-	writel((PWM_OUT_PRECISION - 1), pwm_base + PWM_C0_MR_OFFSET);
-	writel(bl_level, pwm_base + PWM_C0_MR0_OFFSET);
-
-	return 0;
-}
-
-int hisi_pwm_on(void)
-{
-	struct clk *clk_tmp = NULL;
-	char __iomem *pwm_base = NULL;
-	char __iomem *peri_crg_base = NULL;
-	int ret = 0;
-
-	DRM_INFO(" +.\n");
-
-	peri_crg_base = hisi_peri_crg_base;
-	if (!peri_crg_base) {
-		DRM_ERROR("peri_crg_base is NULL");
-		return -EINVAL;
-	}
-
-	pwm_base = hisifd_pwm_base;
-	if (!pwm_base) {
-		DRM_ERROR("pwm_base is null!\n");
-		return -EINVAL;
-	}
-
-	if (g_pwm_on == 1)
-		return 0;
-
-	// dis-reset pwm
-	writel(0x1, peri_crg_base + PERRSTDIS2);
-
-	clk_tmp = g_pwm_clk;
-	if (clk_tmp) {
-		ret = clk_prepare(clk_tmp);
-		if (ret) {
-			DRM_ERROR("dss_pwm_clk clk_prepare failed, error=%d!\n", ret);
-			return -EINVAL;
-		}
-
-		ret = clk_enable(clk_tmp);
-		if (ret) {
-			DRM_ERROR("dss_pwm_clk clk_enable failed, error=%d!\n", ret);
-			return -EINVAL;
-		}
-
-		DRM_INFO("dss_pwm_clk clk_enable succeeded, ret=%d!\n", ret);
-	}
-
-	ret = pinctrl_cmds_tx(g_pwm_pdev, pwm_pinctrl_normal_cmds,
-			      ARRAY_SIZE(pwm_pinctrl_normal_cmds));
-
-	//if enable PWM, please set IOMG_004 in IOC_AO module
-	//set IOMG_004: select PWM_OUT0
-
-	g_pwm_on = 1;
-
-	return ret;
-}
-
-int hisi_pwm_off(void)
-{
-	struct clk *clk_tmp = NULL;
-	char __iomem *pwm_base = NULL;
-	char __iomem *peri_crg_base = NULL;
-	int ret = 0;
-
-	peri_crg_base = hisi_peri_crg_base;
-	if (!peri_crg_base) {
-		DRM_ERROR("peri_crg_base is NULL");
-		return -EINVAL;
-	}
-
-	pwm_base = hisifd_pwm_base;
-	if (!pwm_base) {
-		DRM_ERROR("pwm_base is null!\n");
-		return -EINVAL;
-	}
-
-	if (g_pwm_on == 0)
-		return 0;
-
-	ret = pinctrl_cmds_tx(g_pwm_pdev, pwm_pinctrl_lowpower_cmds,
-			      ARRAY_SIZE(pwm_pinctrl_lowpower_cmds));
-
-	clk_tmp = g_pwm_clk;
-	if (clk_tmp) {
-		clk_disable(clk_tmp);
-		clk_unprepare(clk_tmp);
-	}
-
-	//reset pwm
-	writel(0x1, peri_crg_base + PERRSTEN2);
-
-	g_pwm_on = 0;
-
-	return ret;
-}
-
-static int hisi_pwm_probe(struct platform_device *pdev)
-{
-	struct device_node *np = NULL;
-	int ret = 0;
-
-	if (!pdev) {
-		DRM_ERROR("pdev is NULL");
-		return -EINVAL;
-	}
-
-	g_pwm_pdev = pdev;
-
-	np = of_find_compatible_node(NULL, NULL, DTS_COMP_PWM_NAME);
-	if (!np) {
-		DRM_ERROR("NOT FOUND device node %s!\n", DTS_COMP_PWM_NAME);
-		ret = -ENXIO;
-		goto err_return;
-	}
-
-	/* get pwm reg base */
-	hisifd_pwm_base = of_iomap(np, 0);
-	if (!hisifd_pwm_base) {
-		DRM_ERROR("failed to get pwm_base resource.\n");
-		return -ENXIO;
-	}
-
-	/* get peri_crg_base */
-	hisi_peri_crg_base = of_iomap(np, 1);
-	if (!hisi_peri_crg_base) {
-		DRM_ERROR("failed to get peri_crg_base resource.\n");
-		return -ENXIO;
-	}
-
-	/* pwm pinctrl init */
-	ret = pinctrl_cmds_tx(pdev, pwm_pinctrl_init_cmds,
-			      ARRAY_SIZE(pwm_pinctrl_init_cmds));
-	if (ret != 0) {
-		DRM_ERROR("Init pwm pinctrl failed! ret=%d.\n", ret);
-		goto err_return;
-	}
-
-	/* get pwm clk resource */
-	g_pwm_clk = of_clk_get(np, 0);
-	if (IS_ERR(g_pwm_clk)) {
-		DRM_ERROR("%s clock not found: %d!\n",
-			  np->name, (int)PTR_ERR(g_pwm_clk));
-		ret = -ENXIO;
-		goto err_return;
-	}
-
-	DRM_INFO("dss_pwm_clk:[%lu]->[%lu].\n",
-		 DEFAULT_PWM_CLK_RATE, clk_get_rate(g_pwm_clk));
-
-	return 0;
-
-err_return:
-	return ret;
-}
-
-static int hisi_pwm_remove(struct platform_device *pdev)
-{
-	struct clk *clk_tmp = NULL;
-	int ret = 0;
-
-	ret = pinctrl_cmds_tx(pdev, pwm_pinctrl_finit_cmds,
-			      ARRAY_SIZE(pwm_pinctrl_finit_cmds));
-
-	clk_tmp = g_pwm_clk;
-	if (clk_tmp) {
-		clk_put(clk_tmp);
-		clk_tmp = NULL;
-	}
-
-	return ret;
-}
-
-static const struct of_device_id hisi_pwm_match_table[] = {
-	{
-		.compatible = "hisilicon,hisipwm",
-		.data = NULL,
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, hisi_pwm_match_table);
-
-static struct platform_driver this_driver = {
-	.probe = hisi_pwm_probe,
-	.remove = hisi_pwm_remove,
-	.suspend = NULL,
-	.resume = NULL,
-	.shutdown = NULL,
-	.driver = {
-		.name = DEV_NAME_PWM,
-		.owner = THIS_MODULE,
-		.of_match_table = of_match_ptr(hisi_pwm_match_table),
-	},
-};
-
-static int __init hisi_pwm_init(void)
-{
-	int ret = 0;
-
-	ret = platform_driver_register(&this_driver);
-	if (ret) {
-		DRM_ERROR("platform_driver_register failed, error=%d!\n", ret);
-		return ret;
-	}
-
-	return ret;
-}
-
-module_init(hisi_pwm_init);
-
-MODULE_AUTHOR("cailiwei <cailiwei@hisilicon.com>");
-MODULE_AUTHOR("zhangxiubin <zhangxiubin1@huawei.com>");
-MODULE_DESCRIPTION("hisilicon Kirin SoCs' pwm driver");
-MODULE_LICENSE("GPL v2");
-- 
2.26.2

