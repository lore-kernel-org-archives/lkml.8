Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16CBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938FC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199398;
	bh=5GoVNpGh4Dr4dxWZ8reDc8lbWUTjAQH0PijjACcg4h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OkecEmX7e0/552O6oRVkukg8t+GZ2Mlf6n9U94Swbqezaywk4YSHa+GHmuxOpxWiD
	 WCKinTb7YtzxH/aON8RB2+StuiOuqhN0FgGHAAS5I2byx994D3K54VACwRD71hY7ky
	 aOoN/kTLlCMwkFg6ZuDK9T1Wu/BWXkRgSMa0fWF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407084AbgAPS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732862AbgAPRZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:25:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F837246A7;
        Thu, 16 Jan 2020 17:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195544;
        bh=5GoVNpGh4Dr4dxWZ8reDc8lbWUTjAQH0PijjACcg4h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjaQ4x/unDPoDlpaMPXY9OtmVcznT5OwYWal+8q8I2Qx6gEROYpReqQyh3NONIN8O
         6/twWnVtJJFPpPyEkiv5OxZXGECdIm4EOi09TU194YDlyw9Baic8QoPArs5CcUKcLq
         SbY2wM+t4wGj4OANbRKFLVomdyFPF0s74zqTkMXs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Keerthy <j-keerthy@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 136/371] regulator: lp87565: Fix missing register for LP87565_BUCK_0
Date:   Thu, 16 Jan 2020 12:20:08 -0500
Message-Id: <20200116172403.18149-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit d1a6cbdf1e597917cb642c655512d91b71a35d22 ]

LP87565_BUCK_0 is missed, fix it.

Fixes: f0168a9bf ("regulator: lp87565: Add support for lp87565 PMIC regulators")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/lp87565-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index cfdbe294fb6a..32d4e6ec2e19 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -188,7 +188,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_1, max_idx = LP87565_BUCK_3;
+	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
 
 	platform_set_drvdata(pdev, lp87565);
 
-- 
2.20.1

