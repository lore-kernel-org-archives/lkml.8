Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6875C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C99208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598630516;
	bh=oeFxheDeyKEU7Axch7cQ61Axd1RufsNZkjf2ilfJqBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g4CO9wjYDSfpck7h2frS4GLMM4v4CstjHHjyWPsC8XKHk/dv+whi6tNsmMcCbs3sZ
	 Qeo6wPXpbfCUi0b0p5wz1hqKO2/VtPj/zdKHqR0YGOhICAdYHY2QGcLm4jYe5CSBtq
	 bPx+b/59VGOZLXElxYe1yhA73GnL48IXfHreGz0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgH1QBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgH1QBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:01:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6684F20DD4;
        Fri, 28 Aug 2020 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598630465;
        bh=oeFxheDeyKEU7Axch7cQ61Axd1RufsNZkjf2ilfJqBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAQJZ+5idRTVIilg9jDLRVf9wk3UMlwtW1DkIflE5R2x24q/Mjyx9IditU6Zu2Idx
         bSsc8wc44jHBVrurWEq5SXxBLwRM20C1joBc+Y3IVDrKROwai8Mu5hFAPEPFEOXnxk
         4IIqocB7R3UaEiepXBG9Z96Z9bvIgq5AqfFQEd3s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] media: imx258: Add support for binding via device tree
Date:   Fri, 28 Aug 2020 18:00:52 +0200
Message-Id: <20200828160053.6064-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828160053.6064-1-krzk@kernel.org>
References: <20200828160053.6064-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IMX258 can be used also on embedded designs using device tree so
allow the sensor to bind to a device tree node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/media/i2c/imx258.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index f86ae18bc104..c20bac9b00ec 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -1291,11 +1291,18 @@ static const struct acpi_device_id imx258_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
 #endif
 
+static const struct of_device_id imx258_dt_ids[] = {
+	{ .compatible = "sony,imx258" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx258_dt_ids);
+
 static struct i2c_driver imx258_i2c_driver = {
 	.driver = {
 		.name = "imx258",
 		.pm = &imx258_pm_ops,
 		.acpi_match_table = ACPI_PTR(imx258_acpi_ids),
+		.of_match_table	= imx258_dt_ids,
 	},
 	.probe_new = imx258_probe,
 	.remove = imx258_remove,
-- 
2.17.1

