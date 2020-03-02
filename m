Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE449C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D4721D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T9+3w88X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgCBOOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:14:34 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6298 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgCBOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:14:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5d14bc0000>; Mon, 02 Mar 2020 06:14:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Mar 2020 06:14:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Mar 2020 06:14:33 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Mar
 2020 14:14:33 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 2 Mar 2020 14:14:33 +0000
Received: from thunderball.nvidia.com (Not Verified[10.21.140.91]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5d14c70003>; Mon, 02 Mar 2020 06:14:32 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2] regulator: pwm: Don't warn on probe deferral
Date:   Mon, 2 Mar 2020 14:14:28 +0000
Message-ID: <20200302141428.14119-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583158460; bh=0GatP6vVf/seOlgH+tfmFyiVZODDdF0j2nUvSd2GwHU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=T9+3w88XNgfhfSvSGfpdhaifYMwZ8orawBGaaKlHYKNYnAXqoUS0OJgQY6JlCLbTt
         Jf/6IcaD1OOChMycsXp0ICSct1vjmhIuMWfWYV3LRyrHkJEkhdsViqY34HiSwf56yg
         ORZU+x+sZI1VpK0WHgbJRLqGpZkgSvtRKdc56H4mmWjCxJMC7b44QpWO53/8vZG5D4
         AlkTwe6eJNO1Z7MaK2epDSlDSoJkzL+5RlEfwAKE2HChW28eVSS1p6F7Oo2VR1OTwq
         xrC3LMst2HZP7OfP68rW8US6VCSvAKyAsI6cfIYWpku1UTZ0gpiOApYz0tXIVRriPH
         RfyPb8BoaLXiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for devm_pwm_get(). Given
that the driver deals with it properly, rather than warn on probe
deferral, only output a message on probe deferral if debug level
prints are enabled.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V1:
- Update change to add a debug print for probe deferral

 drivers/regulator/pwm-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index e74e11101fc1..638329bd0745 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -354,7 +354,11 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev,
+				"Failed to get PWM, deferring probe\n");
+		else
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

