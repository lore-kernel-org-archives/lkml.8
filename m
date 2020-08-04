Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA16CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFC222B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GiaQdyGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgHDHIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgHDHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:08:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:08:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l2so13339156pff.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35BiOlb22ru4CGnPoo6iHnh3zmliFNgqR+5vekQUOZ8=;
        b=GiaQdyGWcliLCXOn0m5dbIgoGN522wMvcn58exSrgF2+UzYffu330TGxQohH8ug/wY
         55Kd9aB9tl43JzYC2K/q8IXxdTN4auMdDCyCXUdepEVKEp6/1Ju3SKNfLm8fXk0PyJq3
         Yg4C7I7m5e0RoHke7qnJ3ahEToN2vjxw/mOnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35BiOlb22ru4CGnPoo6iHnh3zmliFNgqR+5vekQUOZ8=;
        b=tS1SKnExa2pRxdib54LpywWPPgz7fX4MRDeWv4ER5ZK0nYIM5eroH0Z2sZ1DGpFsQq
         Xpse7nL9PMOBq3B2SCajIQAHzyGgDR8rZBU0a/8WtJmy6GeiCa2qX8RDno73CorFCojy
         /S23Vt6nqWi6reo4jFdR1UcZBdaI86OvfMXYTKTuht8zpkjJbsGPexECXhfBYIXaJayh
         rPN6dwdA+qgQ97xMl9c48EhaAJYqEKzvpN1qtuPTQvyv0ntp5bd5BnEnW4It0NVPFalg
         GaUCdTQDCpV/FFu2qRq326bBWR3Ohca+ZQS/yXZo3EwsVAZh+qqo6Kc7gdOWnbpPtaFs
         82aw==
X-Gm-Message-State: AOAM532491ne43jMY2OjekBnESud6m+sWFdUD7SayB6dbG2EKaS8QBRx
        0oCeCyiAHQZUi1Kccw3b9U6f/qfi9zc=
X-Google-Smtp-Source: ABdhPJxCqUrkSIlvanRHnn+xOGdz90iMjsof+L7Vac5ZGhmEbb+sxyEbpFWKU4oL04E2hXXkkP5Qgg==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr18517312pfq.182.1596524918494;
        Tue, 04 Aug 2020 00:08:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e125sm16538752pfh.69.2020.08.04.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 00:08:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] regulator: Avoid grabbing regulator lock during suspend/resume
Date:   Tue,  4 Aug 2020 00:08:37 -0700
Message-Id: <20200804070837.1084024-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see it takes about 5us per regulator to grab the lock, check that this
regulator isn't going to do anything for suspend, and then release the
lock. When that is combined with PMICs that have dozens of regulators we
get into a state where we spend a few miliseconds doing a bunch of
locking operations synchronously to figure out that there's nothing to
do. Let's reorganize the code here a bit so that we don't grab the lock
until we're actually going to do something so that suspend is a little
faster.

Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/regulator/core.c | 75 +++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03154f5b939f..c94b656178ec 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -564,6 +564,30 @@ regulator_get_suspend_state(struct regulator_dev *rdev, suspend_state_t state)
 	}
 }
 
+static const struct regulator_state *
+regulator_get_suspend_state_check(struct regulator_dev *rdev, suspend_state_t state)
+{
+	const struct regulator_state *rstate;
+
+	rstate = regulator_get_suspend_state(rdev, state);
+	if (rstate == NULL)
+		return NULL;
+
+	/* If we have no suspend mode configuration don't set anything;
+	 * only warn if the driver implements set_suspend_voltage or
+	 * set_suspend_mode callback.
+	 */
+	if (rstate->enabled != ENABLE_IN_SUSPEND &&
+	    rstate->enabled != DISABLE_IN_SUSPEND) {
+		if (rdev->desc->ops->set_suspend_voltage ||
+		    rdev->desc->ops->set_suspend_mode)
+			rdev_warn(rdev, "No configuration\n");
+		return NULL;
+	}
+
+	return rstate;
+}
+
 static ssize_t regulator_uV_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -981,27 +1005,10 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	return err;
 }
 
-static int suspend_set_state(struct regulator_dev *rdev,
-				    suspend_state_t state)
+static int __suspend_set_state(struct regulator_dev *rdev,
+			       const struct regulator_state *rstate)
 {
 	int ret = 0;
-	struct regulator_state *rstate;
-
-	rstate = regulator_get_suspend_state(rdev, state);
-	if (rstate == NULL)
-		return 0;
-
-	/* If we have no suspend mode configuration don't set anything;
-	 * only warn if the driver implements set_suspend_voltage or
-	 * set_suspend_mode callback.
-	 */
-	if (rstate->enabled != ENABLE_IN_SUSPEND &&
-	    rstate->enabled != DISABLE_IN_SUSPEND) {
-		if (rdev->desc->ops->set_suspend_voltage ||
-		    rdev->desc->ops->set_suspend_mode)
-			rdev_warn(rdev, "No configuration\n");
-		return 0;
-	}
 
 	if (rstate->enabled == ENABLE_IN_SUSPEND &&
 		rdev->desc->ops->set_suspend_enable)
@@ -1036,6 +1043,18 @@ static int suspend_set_state(struct regulator_dev *rdev,
 	return ret;
 }
 
+static int suspend_set_initial_state(struct regulator_dev *rdev)
+{
+	const struct regulator_state *rstate;
+
+	rstate = regulator_get_suspend_state_check(rdev,
+			rdev->constraints->initial_state);
+	if (!rstate)
+		return 0;
+
+	return __suspend_set_state(rdev, rstate);
+}
+
 static void print_constraints(struct regulator_dev *rdev)
 {
 	struct regulation_constraints *constraints = rdev->constraints;
@@ -1318,7 +1337,7 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 
 	/* do we need to setup our suspend state */
 	if (rdev->constraints->initial_state) {
-		ret = suspend_set_state(rdev, rdev->constraints->initial_state);
+		ret = suspend_set_initial_state(rdev);
 		if (ret < 0) {
 			rdev_err(rdev, "failed to set suspend state\n");
 			return ret;
@@ -5297,9 +5316,14 @@ static int regulator_suspend(struct device *dev)
 	struct regulator_dev *rdev = dev_to_rdev(dev);
 	suspend_state_t state = pm_suspend_target_state;
 	int ret;
+	const struct regulator_state *rstate;
+
+	rstate = regulator_get_suspend_state_check(rdev, state);
+	if (!rstate)
+		return 0;
 
 	regulator_lock(rdev);
-	ret = suspend_set_state(rdev, state);
+	ret = __suspend_set_state(rdev, rstate);
 	regulator_unlock(rdev);
 
 	return ret;
@@ -5316,11 +5340,14 @@ static int regulator_resume(struct device *dev)
 	if (rstate == NULL)
 		return 0;
 
+	/* Avoid grabbing the lock if we don't need to */
+	if (!rdev->desc->ops->resume)
+		return 0;
+
 	regulator_lock(rdev);
 
-	if (rdev->desc->ops->resume &&
-	    (rstate->enabled == ENABLE_IN_SUSPEND ||
-	     rstate->enabled == DISABLE_IN_SUSPEND))
+	if (rstate->enabled == ENABLE_IN_SUSPEND ||
+	    rstate->enabled == DISABLE_IN_SUSPEND)
 		ret = rdev->desc->ops->resume(rdev);
 
 	regulator_unlock(rdev);
-- 
Sent by a computer, using git, on the internet

