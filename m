Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8790C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A72207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446839;
	bh=10sXDbedggxckhqYcZsB+MHV9CqU9ANcMhYsBRC6/bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4c9bLSPIWHgVU7U0g8oejdBkzbgyo2qTqJ//BAubMycDG2aaIxHGu4rGPUly0vbX
	 6o3r+MwAWtmkY+Wvxm6z4KsGKdouhO0lB/MlAj+bynkJoJ+a3tS37tEWQgn0/S39TR
	 mo9sU9kHToHOhDmLbiDoDTGNUsEol8/hYxvsg1Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgFRCUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgFRBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:18:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD19421D7E;
        Thu, 18 Jun 2020 01:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443134;
        bh=10sXDbedggxckhqYcZsB+MHV9CqU9ANcMhYsBRC6/bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Io7Ab+5pCsdrMKf4vxDrJYYreuijBsPjSc17TLhfPItIFK+QbHx/YmR8HFZcmTJba
         qmn8TluUVlkCPSvDeS0WszUooPE4EEND7FkPQELsm5pHDGbkU3PizayevLodCXVmMB
         1or6i32HHl/acI94hjHMQ5KHA7V5n73oRUb313Bg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 106/266] slimbus: ngd: get drvdata from correct device
Date:   Wed, 17 Jun 2020 21:13:51 -0400
Message-Id: <20200618011631.604574-106-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit b58c663059b484f7ff547d076a34cf6d7a302e56 ]

Get drvdata directly from parent instead of ngd dev, as ngd
dev can probe defer and previously set drvdata will become null.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200417093618.7929-1-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 29fbab55c3b3..01a17d84b606 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1354,7 +1354,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
-		platform_set_drvdata(ngd->pdev, ctrl);
 
 		platform_device_add(ngd->pdev);
 		ngd->base = ctrl->base + ngd->id * data->offset +
@@ -1369,12 +1368,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
-	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev->parent);
 	int ret;
 
 	ctrl->ctrl.dev = dev;
 
+	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
 	pm_runtime_set_suspended(dev);
-- 
2.25.1

