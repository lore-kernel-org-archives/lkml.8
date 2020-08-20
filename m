Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E70C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F0E2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922716;
	bh=rHY6bYRMoExjyfEcAUsfa6ZPTbkCpO03krJyyBwM/NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hc+NrUMTbCeX4t9ze/7nJmxlNwdN4MhSz2vm5tqh0iXvPX2nmFhOHuVwCK1WMndKR
	 IU3La+B95KfrNeIHaKbguusAZ2QwUSBjT1pfkdqdAUj3Yv4DW76SZow7PfjNCtxfq/
	 MkIFxSY3WZuckSBOEM1oQ9dpNqWx/7uvg4jh1JME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgHTKGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgHTKCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:02:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B285208E4;
        Thu, 20 Aug 2020 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917734;
        bh=rHY6bYRMoExjyfEcAUsfa6ZPTbkCpO03krJyyBwM/NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEyd4Vl/BG8NmugjHG/qWpMx75Ml83gFtFAXIwlwxYXYtmKTMK5DBGdA8B7lQ9Ewq
         FXUcX4vonMHJa/++RCYq/oG7qjz0ga0L2ZFwT5BlfUxHDsNFNER+pKVdvVuMJ8blPN
         jCQHVUH4/i4O1QgP+Whj08CMSXM19LhKt6tKrFS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 131/212] drm/imx: tve: fix regulator_disable error path
Date:   Thu, 20 Aug 2020 11:21:44 +0200
Message-Id: <20200820091608.964012615@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 7bb58b987fee26da2a1665c01033022624986b7c ]

Add missing regulator_disable() as devm_action to avoid dedicated
unbind() callback and fix the missing error handling.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/imx-tve.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 89cf0090feaca..9ae515f3171ec 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -511,6 +511,13 @@ static int imx_tve_register(struct drm_device *drm, struct imx_tve *tve)
 	return 0;
 }
 
+static void imx_tve_disable_regulator(void *data)
+{
+	struct imx_tve *tve = data;
+
+	regulator_disable(tve->dac_reg);
+}
+
 static bool imx_tve_readable_reg(struct device *dev, unsigned int reg)
 {
 	return (reg % 4 == 0) && (reg <= 0xdc);
@@ -635,6 +642,9 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 		ret = regulator_enable(tve->dac_reg);
 		if (ret)
 			return ret;
+		ret = devm_add_action_or_reset(dev, imx_tve_disable_regulator, tve);
+		if (ret)
+			return ret;
 	}
 
 	tve->clk = devm_clk_get(dev, "tve");
@@ -681,18 +691,8 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 }
 
-static void imx_tve_unbind(struct device *dev, struct device *master,
-	void *data)
-{
-	struct imx_tve *tve = dev_get_drvdata(dev);
-
-	if (!IS_ERR(tve->dac_reg))
-		regulator_disable(tve->dac_reg);
-}
-
 static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
-	.unbind	= imx_tve_unbind,
 };
 
 static int imx_tve_probe(struct platform_device *pdev)
-- 
2.25.1



