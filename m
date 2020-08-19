Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A825C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599D1205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838713;
	bh=v4yqX3wsgRwd3N1S84TVE2HcRnPAURPn4O0qze3Kx80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2k3RZbstnn99oL19aG1gZJ24Z/OZf5mDAfLJYh2A9bVgQSzLl9NiXcNwfyTq/shhE
	 lO/ykoXBAKdb3sT/GQubjrTwn4uUMuVvkbBbSEG9bnbXvbGbkOb8Axbp79JuMEgsI3
	 THvOPbOphNFQG+5GVEG7kd8zneWM7WNdJAbcbkfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgHSMFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgHSLro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:44 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAF523101;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837583;
        bh=v4yqX3wsgRwd3N1S84TVE2HcRnPAURPn4O0qze3Kx80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=socLXt5sgZayd0VhzC5/GvG9J4DWcq3iFE9vlpJjdRH9/8oqHGkdGNahmGvkp5Dfi
         gScvPhgR4we94E0D9YjG01x5xMaZSocNOqsxLed8M81MMiE/EIQASy9gUK0j+9TPFL
         387zxWfcBxeIqMMhLU2/nCiORVryd38DG6Pwu7/8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubX-Ox; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Liuyao An <anliuyao@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 35/49] staging: hikey9xx/gpu: add SPMI headers
Date:   Wed, 19 Aug 2020 13:46:03 +0200
Message-Id: <bb29260b57073c3e25b5a7d6379af0aea3cb7ee6.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPMI headers to identify the license of each file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/gpu/kirin960_dpe_reg.h   |  1 +
 .../staging/hikey9xx/gpu/kirin970_dpe_reg.h   |  1 +
 .../hikey9xx/gpu/kirin9xx_drm_dpe_utils.c     |  4 ++-
 .../hikey9xx/gpu/kirin9xx_drm_dpe_utils.h     |  4 ++-
 .../staging/hikey9xx/gpu/kirin9xx_drm_drv.c   |  1 +
 .../staging/hikey9xx/gpu/kirin9xx_drm_drv.h   |  1 +
 .../staging/hikey9xx/gpu/kirin9xx_drm_dss.c   |  1 +
 .../hikey9xx/gpu/kirin9xx_drm_overlay_utils.c | 10 +++----
 .../hikey9xx/gpu/kirin9xx_dw_drm_dsi.c        |  2 +-
 .../hikey9xx/gpu/kirin9xx_dw_dsi_reg.h        |  1 +
 .../staging/hikey9xx/gpu/kirin9xx_fb_panel.h  | 25 +++++++++---------
 drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c   | 26 ++++++++++---------
 12 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
index 7b9da796a671..131bb80d9bd1 100644
--- a/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin960_dpe_reg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2016 Linaro Limited.
  * Copyright (c) 2014-2016 Hisilicon Limited.
diff --git a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
index 0c6b6eb9dcab..00bbad95ee3d 100644
--- a/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin970_dpe_reg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2016 Linaro Limited.
  * Copyright (c) 2014-2016 Hisilicon Limited.
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
index 3b8ff0bdd359..fa317be188e0 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.c
@@ -1,4 +1,6 @@
-/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.h b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.h
index 0c5681d0a5ac..e3681c26f7f4 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dpe_utils.h
@@ -1,4 +1,6 @@
-/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
index 3d1b5f738a7f..12668646c2d3 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hisilicon Kirin SoCs drm master driver
  *
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
index 54b4ddc2fe42..8322abc0752c 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2016 Linaro Limited.
  * Copyright (c) 2014-2016 Hisilicon Limited.
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index fe5b371734fe..10e62bdb9161 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane driver
  *
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
index 2b9672a3d057..128d63d74168 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_overlay_utils.c
@@ -1,4 +1,6 @@
-/* Copyright (c) 2008-2011, Hisilicon Tech. Co., Ltd. All rights reserved.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2008-2011, Hisilicon Tech. Co., Ltd. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -8,12 +10,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- *
  */
 
 #include <drm/drm_atomic.h>
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
index f7f0deca3f53..0612ca149c4b 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * DesignWare MIPI DSI Host Controller v1.02 driver
  *
@@ -11,7 +12,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
  */
 
 #include <linux/clk.h>
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_dsi_reg.h b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_dsi_reg.h
index 00fac1f35265..c22f237a1262 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_dsi_reg.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_dsi_reg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2016 Linaro Limited.
  * Copyright (c) 2014-2016 Hisilicon Limited.
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h b/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
index 83e79a4350c1..69c7f1fd7ccf 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_fb_panel.h
@@ -1,15 +1,16 @@
-/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 and
-* only version 2 as published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
-* GNU General Public License for more details.
-*
-*/
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ */
 #ifndef KIRIN_FB_PANEL_H
 #define KIRIN_FB_PANEL_H
 
diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c b/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c
index bb540f5d77a6..f2b9cfe8fa54 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_pwm.c
@@ -1,15 +1,17 @@
-/* Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License version 2 and
-* only version 2 as published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
-* GNU General Public License for more details.
-*
-*/
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2014, Hisilicon Tech. Co., Ltd. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+ * GNU General Public License for more details.
+ *
+ */
 #include <drm/drm_drv.h>
 #include <drm/drm_mipi_dsi.h>
 
-- 
2.26.2

