Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2AC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6E321974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YPf/qtfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEHSzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:55:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52968 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgEHSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:54:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 048IsfLP054662;
        Fri, 8 May 2020 13:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588964081;
        bh=nEbscNX33RKbq+zFcQZwVu/alXuHc+8pSIbituzNk2U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YPf/qtfBOPqSSxs07alqxbOcnDU/LuYK5LEzzfr3mfCwHTyTrt041c51ah7IbB8o9
         sS5TZ8IWNydtR2Mu1EtQBw0w+bnZscWz6Nu6OrIkT8paj5p3aS2JFkZAQ/WlSOdExp
         sE/fCcuJDxxGq3EwPoUYtFVDcQ7WcV2iRa8F6XeU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 048IsfeV097209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 13:54:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 13:54:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 13:54:40 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 048IsGpW077355;
        Fri, 8 May 2020 13:54:36 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: [PATCH 4/6] mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
Date:   Sat, 9 May 2020 00:24:09 +0530
Message-ID: <20200508185411.487-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508185411.487-1-vigneshr@ti.com>
References: <20200508185411.487-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to undo the prior changes done by the driver when exiting due
to failure to acquire reset lines.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
index 6feb94a38dff..51ed644f58c5 100644
--- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
@@ -1352,13 +1352,13 @@ static int cqspi_probe(struct platform_device *pdev)
 	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
 	if (IS_ERR(rstc)) {
 		dev_err(dev, "Cannot get QSPI reset.\n");
-		return PTR_ERR(rstc);
+		goto probe_reset_failed;
 	}
 
 	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
 	if (IS_ERR(rstc_ocp)) {
 		dev_err(dev, "Cannot get QSPI OCP reset.\n");
-		return PTR_ERR(rstc_ocp);
+		goto probe_reset_failed;
 	}
 
 	reset_control_assert(rstc);
@@ -1377,7 +1377,7 @@ static int cqspi_probe(struct platform_device *pdev)
 			       pdev->name, cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot request IRQ.\n");
-		goto probe_irq_failed;
+		goto probe_reset_failed;
 	}
 
 	cqspi_wait_idle(cqspi);
@@ -1394,7 +1394,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return ret;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-probe_irq_failed:
+probe_reset_failed:
 	clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
 	pm_runtime_put_sync(dev);
-- 
2.26.2

