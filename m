Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2898C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F2820738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947148;
	bh=M86fOLiCQkK9k6YYz0e5I3FGzgfHy4XRhEqm5QpA51c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UbUerWj7Z/sK4u5v6n9pZV8RpJgAVPz29VtmdnOZATZ0lTaTYYMwru8beXY78Rsg2
	 32+WIbZu1ISrwC2shqFojBxRUQnCtBHFQOwJa+94i5nQkHtMUHbkb6RCoXEHOKt4a0
	 lbd4iDRyXkiAMDF2M8fGHeucxXDWzg7JiVIsjS2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393470AbgFWVTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390004AbgFWUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50EB2064B;
        Tue, 23 Jun 2020 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943922;
        bh=M86fOLiCQkK9k6YYz0e5I3FGzgfHy4XRhEqm5QpA51c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/5sb38dIN4mFnikJ2EFpNmnHLZyYT6kG2Ryqlp6q00FGybvPO7cew9UYeQDAOaeI
         VIjPQjvxmDGl3fgen/aresLv2z79JCoXN16Tvv9Avmg8kBCuoroNZ8QOr5KGdZy4LA
         hrRiqZjkjYrCd185s+xkLuYqknY2XoCXf4DTxFNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/314] slimbus: ngd: get drvdata from correct device
Date:   Tue, 23 Jun 2020 21:54:59 +0200
Message-Id: <20200623195343.812290910@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 29fbab55c3b38..01a17d84b6064 100644
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



