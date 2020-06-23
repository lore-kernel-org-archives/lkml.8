Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC50CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5F22072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948404;
	bh=cotzsTwSSR7gusIu00ZW7+RcgJzuYzN5XTv6IKlB3LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEVJ7+/k7zlRwzmDxghsk5pF/f42yQgHRw6FpXB8fWbtfVipH73/92XUr7a+gwZR9
	 no2vwVnJASYa+qv93BO5lbSupWojdo8wzvPZJCXiMQzpCe3pYjAc9+k2q+kYQscEVn
	 lOrcHn+Xxxby27eIw/fw/k3eZ1Hhw/A7wdyhrDkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbgFWUGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbgFWUGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:06:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B262064B;
        Tue, 23 Jun 2020 20:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942808;
        bh=cotzsTwSSR7gusIu00ZW7+RcgJzuYzN5XTv6IKlB3LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlgvOXLAP+pTbZE4zvidX3fnOhsDdOYZCA/EicM+9VxGOHhAUvmtRSwhKp6BA6UyX
         LoXRLCZ0buj7jjPjZcpo+dQcess7oTCuxfTYSOyrR4SWRfwMHz705l6qIqzaf40D20
         HsF/cqIQC04w2Shm6W7Tkxkoedg2wxmsI7cK7sgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 144/477] slimbus: ngd: get drvdata from correct device
Date:   Tue, 23 Jun 2020 21:52:21 +0200
Message-Id: <20200623195414.406011456@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
index fc2575fef51ba..7426b5884218a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1361,7 +1361,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
-		platform_set_drvdata(ngd->pdev, ctrl);
 
 		platform_device_add(ngd->pdev);
 		ngd->base = ctrl->base + ngd->id * data->offset +
@@ -1376,12 +1375,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 
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



