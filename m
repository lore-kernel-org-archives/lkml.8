Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA5C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D832620721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgAKBHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:07:49 -0500
Received: from [167.172.186.51] ([167.172.186.51]:42386 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbgAKBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 20:07:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EB408DFDFD;
        Sat, 11 Jan 2020 01:07:47 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 32PAmGpAMnwp; Sat, 11 Jan 2020 01:07:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4AAAEDFE00;
        Sat, 11 Jan 2020 01:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pjq_2cWuQb2N; Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9DBFFDFDFA;
        Sat, 11 Jan 2020 01:07:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 3/3] drm/armada: add mmp2 and mmp3 support
Date:   Sat, 11 Jan 2020 02:07:34 +0100
Message-Id: <20200111010734.286836-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111010734.286836-1-lkundrak@v3.sk>
References: <20200111010734.286836-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMP2 and MMP3 are mostly the same apart from MMP3 having the clock
select shifted one bit to the right, with an extra option to choose PLL3
as a clock source.

Data sheet for neither variant is available. James Cameron of OLPC kindly
provided some details about the LCD_SCLK_DIV register for MMP2.

MMP2 support was tested on with the internal panel on a OLPC XO 1.75
laptop, while the MMP3 support was tested on a Dell Wyse 3020 with a
Chrontel 7033 encoder driving a VGA and DVI display.

Link: https://lists.freedesktop.org/archives/dri-devel/2018-December/2010=
21.html
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- Added Armada 620 (MMP3) support

Changes since v1:
- Aligned with more recent Armada 510 support: using the same clock
  names and allowing for more flexible pixel clock source selection.

 drivers/gpu/drm/armada/Makefile      |   1 +
 drivers/gpu/drm/armada/armada_6x0.c  | 178 +++++++++++++++++++++++++++
 drivers/gpu/drm/armada/armada_crtc.c |   8 ++
 drivers/gpu/drm/armada/armada_drm.h  |   2 +
 drivers/gpu/drm/armada/armada_hw.h   |  17 +++
 5 files changed, 206 insertions(+)
 create mode 100644 drivers/gpu/drm/armada/armada_6x0.c

diff --git a/drivers/gpu/drm/armada/Makefile b/drivers/gpu/drm/armada/Mak=
efile
index 9bc3c32137248..80f7315bb6d20 100644
--- a/drivers/gpu/drm/armada/Makefile
+++ b/drivers/gpu/drm/armada/Makefile
@@ -2,6 +2,7 @@
 armada-y	:=3D armada_crtc.o armada_drv.o armada_fb.o armada_fbdev.o \
 		   armada_gem.o armada_overlay.o armada_plane.o armada_trace.o
 armada-y	+=3D armada_510.o
+armada-y	+=3D armada_6x0.o
 armada-$(CONFIG_DEBUG_FS) +=3D armada_debugfs.o
=20
 obj-$(CONFIG_DRM_ARMADA) :=3D armada.o
diff --git a/drivers/gpu/drm/armada/armada_6x0.c b/drivers/gpu/drm/armada=
/armada_6x0.c
new file mode 100644
index 0000000000000..2053da32abea6
--- /dev/null
+++ b/drivers/gpu/drm/armada/armada_6x0.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 Russell King
+ * Copyright (C) 2018,2019,2020 Lubomir Rintel
+ *  Largely based on Armada 510 support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Support for Armada MMP2 and MMP3 variants
+ */
+#include <linux/clk.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_crtc.h>
+#include "armada_crtc.h"
+#include "armada_drm.h"
+#include "armada_hw.h"
+
+struct armada6x0_variant_data {
+	struct clk *clks[5];
+	struct clk *sel_clk;
+};
+
+static int armada6x0_crtc_init(struct armada_crtc *dcrtc, struct device =
*dev)
+{
+	struct armada6x0_variant_data *v;
+	struct property *prop;
+	struct clk *clk;
+	const char *s;
+	int idx;
+
+	v =3D devm_kzalloc(dev, sizeof(*v), GFP_KERNEL);
+	if (!v)
+		return -ENOMEM;
+
+	dcrtc->variant_data =3D v;
+
+	of_property_for_each_string(dev->of_node, "clock-names", prop, s) {
+		if (!strcmp(s, "ext_ref_clk0"))
+			idx =3D 0;
+		else if (!strcmp(s, "ext_ref_clk1"))
+			idx =3D 1;
+		else if (!strcmp(s, "plldivider"))
+			idx =3D 2;
+		else if (!strcmp(s, "axibus"))
+			idx =3D 3;
+		else if (!strcmp(s, "pll3"))
+			idx =3D 4;
+		else
+			continue;
+
+		clk =3D devm_clk_get(dev, s);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk) =3D=3D -ENOENT ? -EPROBE_DEFER :
+				PTR_ERR(clk);
+		v->clks[idx] =3D clk;
+	}
+
+	return 0;
+}
+
+static const struct armada_clocking_params armada6x0_clocking =3D {
+	/* HDMI requires -0.6%..+0.5% */
+	.permillage_min =3D 0,
+	.permillage_max =3D 2000,
+	.settable =3D BIT(0) | BIT(1) | BIT(2),
+	.div_max =3D SCLK_610_INT_DIV_MASK,
+};
+
+/*
+ * This gets called with sclk =3D NULL to test whether the mode is
+ * supportable, and again with sclk !=3D NULL to set the clocks up for
+ * that.  The former can return an error, but the latter is expected
+ * not to.
+ */
+static int armada6x0_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk,
+	const u32 clk_sels[], size_t num_clk_sels)
+{
+	struct armada6x0_variant_data *v =3D dcrtc->variant_data;
+	unsigned long desired_khz =3D mode->crtc_clock;
+	struct armada_clk_result res;
+	int ret, idx;
+
+	idx =3D armada_crtc_select_clock(dcrtc, &res, &armada6x0_clocking,
+				       v->clks, ARRAY_SIZE(v->clks),
+				       desired_khz);
+	if (idx < 0)
+		return idx;
+	if (idx >=3D num_clk_sels)
+		return -EINVAL;
+
+	ret =3D clk_prepare_enable(res.clk);
+	if (ret)
+		return ret;
+
+	if (sclk) {
+		clk_set_rate(res.clk, res.desired_clk_hz);
+
+		*sclk =3D 0x00001000;	/* No idea */
+		*sclk |=3D 1 << 8;	/* MIPI clock bypass */
+		*sclk |=3D clk_sels[idx];
+		*sclk |=3D res.div;
+
+		/* We are now using this clock */
+		v->sel_clk =3D res.clk;
+		swap(dcrtc->clk, res.clk);
+	}
+
+	clk_disable_unprepare(res.clk);
+
+	return 0;
+}
+
+static const u32 armada610_clk_sels[] =3D {
+	SCLK_610_DISP0,
+	SCLK_610_DISP1,
+	SCLK_610_HDMI_PLL,
+	SCLK_610_AXI,
+};
+
+static int armada610_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk)
+{
+	return armada6x0_crtc_compute_clock(dcrtc, mode, sclk,
+					    armada610_clk_sels,
+					    ARRAY_SIZE(armada610_clk_sels));
+}
+
+static const u32 armada620_clk_sels[] =3D {
+	SCLK_620_DISP0,
+	SCLK_620_DISP1,
+	SCLK_620_HDMI_PLL,
+	SCLK_620_AXI,
+	SCLK_620_PLL3,
+};
+
+static int armada620_crtc_compute_clock(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode, uint32_t *sclk)
+{
+	return armada6x0_crtc_compute_clock(dcrtc, mode, sclk,
+					    armada620_clk_sels,
+					    ARRAY_SIZE(armada620_clk_sels));
+}
+
+static void armada6x0_crtc_disable(struct armada_crtc *dcrtc)
+{
+	if (dcrtc->clk) {
+		clk_disable_unprepare(dcrtc->clk);
+		dcrtc->clk =3D NULL;
+	}
+}
+
+static void armada6x0_crtc_enable(struct armada_crtc *dcrtc,
+	const struct drm_display_mode *mode)
+{
+	struct armada6x0_variant_data *v =3D dcrtc->variant_data;
+
+	if (!dcrtc->clk && v->sel_clk) {
+		if (!WARN_ON(clk_prepare_enable(v->sel_clk)))
+			dcrtc->clk =3D v->sel_clk;
+	}
+}
+
+const struct armada_variant armada610_ops =3D {
+	.init =3D armada6x0_crtc_init,
+	.compute_clock =3D armada610_crtc_compute_clock,
+	.disable =3D armada6x0_crtc_disable,
+	.enable =3D armada6x0_crtc_enable,
+};
+
+const struct armada_variant armada620_ops =3D {
+	.init =3D armada6x0_crtc_init,
+	.compute_clock =3D armada620_crtc_compute_clock,
+	.disable =3D armada6x0_crtc_disable,
+	.enable =3D armada6x0_crtc_enable,
+};
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armad=
a/armada_crtc.c
index 0f343bf584c8c..3ac1363933097 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1101,6 +1101,14 @@ static const struct of_device_id armada_lcd_of_mat=
ch[] =3D {
 		.compatible	=3D "marvell,dove-lcd",
 		.data		=3D &armada510_ops,
 	},
+	{
+		.compatible	=3D "marvell,mmp2-lcd",
+		.data		=3D &armada610_ops,
+	},
+	{
+		.compatible	=3D "marvell,mmp3-lcd",
+		.data		=3D &armada620_ops,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, armada_lcd_of_match);
diff --git a/drivers/gpu/drm/armada/armada_drm.h b/drivers/gpu/drm/armada=
/armada_drm.h
index a11bdaccbb336..33ed772449268 100644
--- a/drivers/gpu/drm/armada/armada_drm.h
+++ b/drivers/gpu/drm/armada/armada_drm.h
@@ -52,6 +52,8 @@ struct armada_variant {
=20
 /* Variant ops */
 extern const struct armada_variant armada510_ops;
+extern const struct armada_variant armada610_ops;
+extern const struct armada_variant armada620_ops;
=20
 struct armada_private {
 	struct drm_device	drm;
diff --git a/drivers/gpu/drm/armada/armada_hw.h b/drivers/gpu/drm/armada/=
armada_hw.h
index 9c88b38a40039..6eb6ab6d8416c 100644
--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -216,6 +216,23 @@ enum {
 	SCLK_510_FRAC_DIV_MASK	=3D 0xfff << 16,
 	SCLK_510_INT_DIV_MASK	=3D 0xffff << 0,
=20
+	/* Armada 610 */
+	SCLK_610_AXI		=3D 0x0 << 30,
+	SCLK_610_DISP0		=3D 0x1 << 30,	/* LCD Display 1 */
+	SCLK_610_DISP1		=3D 0x2 << 30,	/* LCD Display 2 */
+	SCLK_610_HDMI_PLL	=3D 0x3 << 30,	/* HDMI PLL clock */
+	SCLK_610_PANEL_CLK_DIS	=3D 0x1 << 28,	/* 1 =3D panel clock disabled */
+	SCLK_610_FRAC_DIV_MASK	=3D 0xfff << 16,
+	SCLK_610_MIPI_DIV_MASK	=3D 0xf << 8,	/* 0 =3D off, 1 =3D bypass, ... */
+	SCLK_610_INT_DIV_MASK	=3D 0xff << 0,
+
+	/* Armada 620 */
+	SCLK_620_AXI		=3D 0x0 << 29,
+	SCLK_620_DISP0		=3D 0x1 << 29,	/* LCD Display 1 */
+	SCLK_620_DISP1		=3D 0x2 << 29,	/* LCD Display 2 */
+	SCLK_620_HDMI_PLL	=3D 0x3 << 29,	/* HDMI PLL clock */
+	SCLK_620_PLL3		=3D 0x7 << 29,	/* HDMI PLL clock */
+
 	/* Armada 16x */
 	SCLK_16X_AHB		=3D 0x0 << 28,
 	SCLK_16X_PCLK		=3D 0x1 << 28,
--=20
2.24.1

