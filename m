Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFF7C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BA8208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCXJZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:25:19 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:49484 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgCXJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:25:19 -0400
Received: from [100.112.192.175] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 3A/A8-12948-DF1D97E5; Tue, 24 Mar 2020 09:25:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRWlGSWpSXmKPExsVy8MN7Xd2/Fyv
  jDKYfErGY+vAJm8W3Kx1MFpd3zWFzYPbYOesuu8emVZ1sHp83yQUwR7Fm5iXlVySwZly40sJW
  8FGwYs2+xAbGKfxdjFwcQgLrGCUmHH/H2MXICeRUSKw+v4oZxGYTsJCYfOIBG4jNIqAqcfPdA
  RYQW1ggUOLF/a1gcREBD4nFD16xdzFycDALREj8OQXWyivgILH8wDEoW1Di5MwnYK3MAhISB1
  +8YIZYZSBxekEjywRG7llIymYhKVvAyLSK0TypKDM9oyQ3MTNH19DAQNfQ0EjX0NIYyNZLrNJ
  N1Est1S1PLS7RNdRLLC/WK67MTc5J0ctLLdnECAynlIKDXDsYn619r3eIUZKDSUmUN/14ZZwQ
  X1J+SmVGYnFGfFFpTmrxIUYZDg4lCd78C0A5waLU9NSKtMwcYGjDpCU4eJREeBeDpHmLCxJzi
  zPTIVKnGHU5rr/fu5RZiCUvPy9VSpyXGxgpQgIgRRmleXAjYHF2iVFWSpiXkYGBQYinILUoN7
  MEVf4VozgHo5Iw73qQVTyZeSVwm14BHcEEdET6rHKQI0oSEVJSDUwbWjvZeJOkhOovMzy5YhD
  +f1t557oO3QvvnsmEsz/+6bT7rAYfR8SF1ECmeOMFp7+kLErcv/zHjvfP5Dfkms68ZrmXj90n
  SLkrtYJzt+aHC/YqTSvvLmOze2fj0OfMYN2VJCx5/vDjpQ/b3ylONZa1yZugypW049vFM5eUD
  iokdgc/e3R+4YtSS5WNb848lZhi/e/lxkntDi9O/PPmNODqn3Mv86H+Md6tP1+anBWWr7/EJe
  Fqyx49o+P/5q/lPdOluadv7WJO136p0ybuwDyFw040PSTg+Sr/1JZTCxmdi3kC27nOde3OCrH
  6cnSRpxjTpHsKu1YvzsiZN/Vp/1ahpS7HCy3jp9kdy2lhcFBiKc5INNRiLipOBABkuibSLgMA
  AA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-5.tower-268.messagelabs.com!1585041916!2081680!1
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16974 invoked from network); 24 Mar 2020 09:25:17 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-5.tower-268.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 24 Mar 2020 09:25:17 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 24 Mar 2020 10:25:16 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 60B5C3FB8D; Tue, 24 Mar 2020 09:25:16 +0000 (GMT)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 24 Mar 2020 09:25:16 +0000
Subject: [PATCH] regulator: da9063: Fix get_mode() functions to read sleep
 field
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Message-ID: <20200324092516.60B5C3FB8D@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_mode() is used to retrieve the active mode state. Settings-A
config is used during active state, whilst Settings-B is for
suspend. This means we only need to check the sleep field of each
buck and LDO as that field solely relates to Settings-A config.

This change is a clone of the get_mode() update which was committed
as part of:
 - regulator: da9062: fix suspend_enable/disable preparation
   [a72865f057820ea9f57597915da4b651d65eb92f]

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/regulator/da9063-regulator.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b..4a70f27 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -224,7 +224,6 @@ static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	unsigned int val;
 	int ret;
 
@@ -245,18 +244,7 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 		return REGULATOR_MODE_NORMAL;
 	}
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -293,21 +281,9 @@ static int da9063_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9063_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	int ret, val;
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
-- 
1.9.1

