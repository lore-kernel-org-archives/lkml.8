Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D23C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A3922D01
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="C9n4Z2Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHEHEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:04:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25572 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgHEHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:04:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573JXq012759;
        Wed, 5 Aug 2020 09:04:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=2nQxMmex42TyLT5VNzIG8e3lAQvRSXXBh413df+tvyc=;
 b=C9n4Z2VhCakw5bTCEHlKWhBj+bR9P5hDku9zfi4D9yNC0Q4CGE56zgyy8yTmjfrOKMZe
 +Od2jVs6iqvV5NefItY3LPMA5lZp2Q8X+h5T8skk5U/yGw4yep8utbTqN8d9ZzNcDMRK
 b4dDbEIjMdm2GN9greCCAm4nT7xSJoyP07Te8LjbCTqsYUGJ6guo7EE7Spv4pYtUW8Oc
 b1/Ob2vlEjiQcR5TwCurHnrcNBTpkY+cjOdmg8JZkSj9oczPDkZd/0IThaK1DIkRGst9
 mDXg336JAGZlBWI0HlrvTKn0CZlYv/vitWFNP6SFt2OXd/RQsSZXf5SniCTVWXyecr1V 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6theqhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 143E6100034;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 035912A4D8E;
        Wed,  5 Aug 2020 09:04:14 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:13
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 01/18] spi: stm32-spi: driver uses reset controller only at init
Date:   Wed, 5 Aug 2020 09:01:56 +0200
Message-ID: <1596610933-32599-2-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Remove reset controller device reference from the device private
structure since it is used only at probe time and can be discarded
once used to reset the SPI device.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c643dfc7fbb..838d3ce3ebae 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -267,7 +267,6 @@ struct stm32_spi_cfg {
  * @base: virtual memory area
  * @clk: hw kernel clock feeding the SPI clock generator
  * @clk_rate: rate of the hw kernel clock feeding the SPI clock generator
- * @rst: SPI controller reset line
  * @lock: prevent I/O concurrent access
  * @irq: SPI controller interrupt line
  * @fifo_size: size of the embedded fifo in bytes
@@ -293,7 +292,6 @@ struct stm32_spi {
 	void __iomem *base;
 	struct clk *clk;
 	u32 clk_rate;
-	struct reset_control *rst;
 	spinlock_t lock; /* prevent I/O concurrent access */
 	int irq;
 	unsigned int fifo_size;
@@ -1824,6 +1822,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct stm32_spi *spi;
 	struct resource *res;
+	struct reset_control *rst;
 	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
@@ -1887,11 +1886,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(spi->rst)) {
-		reset_control_assert(spi->rst);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
 		udelay(2);
-		reset_control_deassert(spi->rst);
+		reset_control_deassert(rst);
 	}
 
 	if (spi->cfg->has_fifo)
-- 
2.7.4

