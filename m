Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358DEC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2E2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD3MqM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:46:12 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:35990 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgD3MqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:46:11 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        by skedge04.snt-world.com (Postfix) with ESMTP id 1011167A7D8;
        Thu, 30 Apr 2020 14:46:08 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 14:46:07 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 14:46:07 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Adam Ford <aford173@gmail.com>, Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Li Jun" <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/4] drm/etnaviv: Prevent IRQ triggering at probe time on
 i.MX8MM
Thread-Topic: [RFC PATCH 1/4] drm/etnaviv: Prevent IRQ triggering at probe
 time on i.MX8MM
Thread-Index: AQHWHu1RaS/QCZFEh0aIMChy0QTuwg==
Date:   Thu, 30 Apr 2020 12:46:07 +0000
Message-ID: <20200430124602.14463-2-frieder.schrempf@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
In-Reply-To: <20200430124602.14463-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 1011167A7D8.A1C56
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aford173@gmail.com, anson.huang@nxp.com,
        christian.gmeiner@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, festevam@gmail.com, jun.li@nxp.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux+etnaviv@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

On i.MX8MM there is an interrupt getting triggered immediately after
requesting the IRQ, which leads to a stall as the handler accesses
the GPU registers whithout the clock being enabled.

Enabling the clocks briefly seems to clear the IRQ state, so we do
this before requesting the IRQ.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 29 ++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a31eeff2b297..23877c1f150a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1775,13 +1775,6 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 		return gpu->irq;
 	}
 
-	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
-			       dev_name(gpu->dev), gpu);
-	if (err) {
-		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
-		return err;
-	}
-
 	/* Get Clocks: */
 	gpu->clk_reg = devm_clk_get(&pdev->dev, "reg");
 	DBG("clk_reg: %p", gpu->clk_reg);
@@ -1805,6 +1798,28 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 		gpu->clk_shader = NULL;
 	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
 
+	/*
+	 * On i.MX8MM there is an interrupt getting triggered immediately
+	 * after requesting the IRQ, which leads to a stall as the handler
+	 * accesses the GPU registers whithout the clock being enabled.
+	 * Enabling the clocks briefly seems to clear the IRQ state, so we do
+	 * this here before requesting the IRQ.
+	 */
+	err = etnaviv_gpu_clk_enable(gpu);
+	if (err)
+		return err;
+
+	err = etnaviv_gpu_clk_disable(gpu);
+	if (err)
+		return err;
+
+	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
+			       dev_name(gpu->dev), gpu);
+	if (err) {
+		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
+		return err;
+	}
+
 	/* TODO: figure out max mapped size */
 	dev_set_drvdata(dev, gpu);
 
-- 
2.17.1
