Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF3C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888C20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GMucuiiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgBXOky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:40:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18372 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgBXOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:40:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e53e0670000>; Mon, 24 Feb 2020 06:40:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 06:40:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Feb 2020 06:40:52 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 14:40:52 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Feb 2020 14:40:52 +0000
Received: from thunderball.nvidia.com (Not Verified[10.21.140.91]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e53e0720007>; Mon, 24 Feb 2020 06:40:51 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] regulator: pwm: Don't warn on probe deferral
Date:   Mon, 24 Feb 2020 14:40:48 +0000
Message-ID: <20200224144048.6587-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582555239; bh=xX7Mgn1VlNejVzsSKFLhZRbMP4+2YtN6WM4DdeoOEHs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=GMucuiiqAspPQsWQ1ebM1v5mPEShSHma2lu4iNERqE/uilIy4CUp4eHq6df8Lcsvu
         11bCdd116mWyRJ5/F69vtHcgJHTbeaaRcf+A1/A3DLTuc6Z/PRb5jcySSX/aRCaPfA
         +au3XaR3dyBeV+xizDks3Ibot8dmHuQWswqibwwVp5Qanoow2Dj75j/Q++AU7PwM6A
         ChvWMkFCBBz6FO8SGi5jCQrCgLTrHtX90cRQZsaaQFrbBYLhLrAsdFkFM2mVLd+xqz
         rc7bwTn707Mpf71vRGfmJgoiBm/Pm1qLnRoyLBakyb0xfmEJkCP99y3nO62z9DIpDm
         DdSZ9ONzuo7vA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for devm_pwm_get(). Given
that the driver deals with it properly, there's no need to output a
warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/regulator/pwm-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index e74e11101fc1..fb25777a7d47 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -354,7 +354,8 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

