Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5E6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EB72072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579275874;
	bh=L0fiN25xKwkfHWebmdwAz8I7w/AgztY9UcLQL8QHI5Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vfcQS4SWvw84iPRsQ4cBLKu0eiEoJvd7HlDfIgWo2y71/hZXbTlx/W2jVxYp32ls1
	 K5r2QT/X1d870HaGGb/xDenA7AsuSSAuZrZjagXb8zg/8gYkKU768JoA9EzmC6933Y
	 ajGPhDtx2tam+qL8HFlMq4/97+aghjNyK8xlkdPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:44:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53704 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAQPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zs8EI7g/GU1QocvpiXp6DpSMOwGeQzJVgjqlnF9ZfuI=; b=Jvd5ycdlD/UB
        SNWKRp+uDWsKX1eItY3AIUN7Wno7U+vht0rw4L94z0CFJWhnwcHWL5qX5/Ec8wF7DoMlvY0Tv1eVC
        cp+NWw1HU4qD1QP9Qqs8kMMmNRsVxdvZkPNB4blZt3hk4Mg/BJU/qZph5OQQe46oFqnCeJNugkttG
        cUEXw=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnG-0006tz-Nc; Fri, 17 Jan 2020 15:44:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 68ACAD02C26; Fri, 17 Jan 2020 15:44:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        drinkcat@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mka@chromium.org
Subject: Applied "regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage" to the regulator tree
In-Reply-To: <20200116094543.2847321-1-enric.balletbo@collabora.com>
Message-Id: <applied-20200116094543.2847321-1-enric.balletbo@collabora.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e9153311491da9d9863ead9888a1613531cb4a1b Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Thu, 16 Jan 2020 10:45:43 +0100
Subject: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage

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
Link: https://lore.kernel.org/r/20200116094543.2847321-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c            |  2 ++
 drivers/regulator/vctrl-regulator.c | 38 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2961ac08d1ae..6be687d25484 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3466,6 +3466,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
+EXPORT_SYMBOL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4030,6 +4031,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
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
2.20.1

