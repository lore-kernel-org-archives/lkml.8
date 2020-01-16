Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58DBC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E2B2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgAPJpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:45:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55406 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbgAPJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:45:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5D07E293886
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, drinkcat@chromium.org,
        Mark Brown <broonie@kernel.org>, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage
Date:   Thu, 16 Jan 2020 10:45:43 +0100
Message-Id: <20200116094543.2847321-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`cat /sys/kernel/debug/regulator/regulator_summary` ends on a deadlock
when you have a voltage controlled regulator (vctrl).

The problem is that the vctrl_get_voltage() and vctrl_set_voltage() calls the
regulator_get_voltage() and regulator_set_voltage() and that will try to lock
again the dependent regulators (the regulator supplying the control voltage).

Fix the issue by exporting the unlocked version of the regulator_get_voltage()
and regulator_set_voltage() API so drivers that need it, like the voltage
controlled regulator driver can use it.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/regulator/core.c            |  2 ++
 drivers/regulator/vctrl-regulator.c | 38 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03d79fee2987..e7d167ce326c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3470,6 +3470,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4034,6 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
+EXPORT_SYMBOL(regulator_get_voltage_rdev);
 
 /**
  * regulator_get_voltage - get regulator output voltage
diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index 9a9ee8188109..cbadb1c99679 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -11,10 +11,13 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regulator/coupler.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/sort.h>
 
+#include "internal.h"
+
 struct vctrl_voltage_range {
 	int min_uV;
 	int max_uV;
@@ -79,7 +82,7 @@ static int vctrl_calc_output_voltage(struct vctrl_data *vctrl, int ctrl_uV)
 static int vctrl_get_voltage(struct regulator_dev *rdev)
 {
 	struct vctrl_data *vctrl = rdev_get_drvdata(rdev);
-	int ctrl_uV = regulator_get_voltage(vctrl->ctrl_reg);
+	int ctrl_uV = regulator_get_voltage_rdev(vctrl->ctrl_reg->rdev);
 
 	return vctrl_calc_output_voltage(vctrl, ctrl_uV);
 }
@@ -90,16 +93,16 @@ static int vctrl_set_voltage(struct regulator_dev *rdev,
 {
 	struct vctrl_data *vctrl = rdev_get_drvdata(rdev);
 	struct regulator *ctrl_reg = vctrl->ctrl_reg;
-	int orig_ctrl_uV = regulator_get_voltage(ctrl_reg);
+	int orig_ctrl_uV = regulator_get_voltage_rdev(ctrl_reg->rdev);
 	int uV = vctrl_calc_output_voltage(vctrl, orig_ctrl_uV);
 	int ret;
 
 	if (req_min_uV >= uV || !vctrl->ovp_threshold)
 		/* voltage rising or no OVP */
-		return regulator_set_voltage(
-			ctrl_reg,
+		return regulator_set_voltage_rdev(ctrl_reg->rdev,
 			vctrl_calc_ctrl_voltage(vctrl, req_min_uV),
-			vctrl_calc_ctrl_voltage(vctrl, req_max_uV));
+			vctrl_calc_ctrl_voltage(vctrl, req_max_uV),
+			PM_SUSPEND_ON);
 
 	while (uV > req_min_uV) {
 		int max_drop_uV = (uV * vctrl->ovp_threshold) / 100;
@@ -114,9 +117,10 @@ static int vctrl_set_voltage(struct regulator_dev *rdev,
 		next_uV = max_t(int, req_min_uV, uV - max_drop_uV);
 		next_ctrl_uV = vctrl_calc_ctrl_voltage(vctrl, next_uV);
 
-		ret = regulator_set_voltage(ctrl_reg,
+		ret = regulator_set_voltage_rdev(ctrl_reg->rdev,
+					    next_ctrl_uV,
 					    next_ctrl_uV,
-					    next_ctrl_uV);
+					    PM_SUSPEND_ON);
 		if (ret)
 			goto err;
 
@@ -130,7 +134,8 @@ static int vctrl_set_voltage(struct regulator_dev *rdev,
 
 err:
 	/* Try to go back to original voltage */
-	regulator_set_voltage(ctrl_reg, orig_ctrl_uV, orig_ctrl_uV);
+	regulator_set_voltage_rdev(ctrl_reg->rdev, orig_ctrl_uV, orig_ctrl_uV,
+				   PM_SUSPEND_ON);
 
 	return ret;
 }
@@ -155,9 +160,10 @@ static int vctrl_set_voltage_sel(struct regulator_dev *rdev,
 
 	if (selector >= vctrl->sel || !vctrl->ovp_threshold) {
 		/* voltage rising or no OVP */
-		ret = regulator_set_voltage(ctrl_reg,
+		ret = regulator_set_voltage_rdev(ctrl_reg->rdev,
+					    vctrl->vtable[selector].ctrl,
 					    vctrl->vtable[selector].ctrl,
-					    vctrl->vtable[selector].ctrl);
+					    PM_SUSPEND_ON);
 		if (!ret)
 			vctrl->sel = selector;
 
@@ -173,9 +179,10 @@ static int vctrl_set_voltage_sel(struct regulator_dev *rdev,
 		else
 			next_sel = vctrl->vtable[vctrl->sel].ovp_min_sel;
 
-		ret = regulator_set_voltage(ctrl_reg,
+		ret = regulator_set_voltage_rdev(ctrl_reg->rdev,
 					    vctrl->vtable[next_sel].ctrl,
-					    vctrl->vtable[next_sel].ctrl);
+					    vctrl->vtable[next_sel].ctrl,
+					    PM_SUSPEND_ON);
 		if (ret) {
 			dev_err(&rdev->dev,
 				"failed to set control voltage to %duV\n",
@@ -195,9 +202,10 @@ static int vctrl_set_voltage_sel(struct regulator_dev *rdev,
 err:
 	if (vctrl->sel != orig_sel) {
 		/* Try to go back to original voltage */
-		if (!regulator_set_voltage(ctrl_reg,
+		if (!regulator_set_voltage_rdev(ctrl_reg->rdev,
+					   vctrl->vtable[orig_sel].ctrl,
 					   vctrl->vtable[orig_sel].ctrl,
-					   vctrl->vtable[orig_sel].ctrl))
+					   PM_SUSPEND_ON))
 			vctrl->sel = orig_sel;
 		else
 			dev_warn(&rdev->dev,
@@ -482,7 +490,7 @@ static int vctrl_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ctrl_uV = regulator_get_voltage(vctrl->ctrl_reg);
+		ctrl_uV = regulator_get_voltage_rdev(vctrl->ctrl_reg->rdev);
 		if (ctrl_uV < 0) {
 			dev_err(&pdev->dev, "failed to get control voltage\n");
 			return ctrl_uV;
-- 
2.24.1

