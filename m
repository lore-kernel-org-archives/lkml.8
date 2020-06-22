Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC885C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECBE20578
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592823967;
	bh=bfVZtAFU8NdMRRNSEVZYVNoiKI0ceYpx6CxgFvwkv3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l2x15/Mb25b2dBH7oYpRahqr3/YkHkJQzqdeeRZG+IoT7k20Ganmrn4UQu4oSI4BA
	 PYIAfTbHw+/0A0ZiMJaFlX45LVgdIk/0/Y9Zbe5AsBOR/KBu6ncibKjq8UQj2t/INW
	 eT1NC9Tf1qysZ6F24ibcLyvAbYjlkSKPkfAFcT5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFVLGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgFVLGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:06:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA7C20767;
        Mon, 22 Jun 2020 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592823960;
        bh=bfVZtAFU8NdMRRNSEVZYVNoiKI0ceYpx6CxgFvwkv3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuFBEsCGCO32GnoZZXedi+W8XKo3fucdlXJrWtbSMRxhxS2ZXsh6vO3KitDLZtt3q
         vrliGSvpcYHocYrBfFQb3lz++9bVCLJb9QaIhJ2dDC86wS8nMPy6BiW7Au39Gf8FPL
         nDH7Ko+oj8aUZ0h823e/HyllJ3ITvDrncJPz4vT8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Peng Ma <peng.ma@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 4/4] spi: spi-fsl-dspi: Initialize completion before possible interrupt
Date:   Mon, 22 Jun 2020 13:05:43 +0200
Message-Id: <20200622110543.5035-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622110543.5035-1-krzk@kernel.org>
References: <20200622110543.5035-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handler calls completion and is IRQ requested before the
completion is initialized.  Logically it should be the other way.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. None

Changes since v1:
1. Rework the commit msg.
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e0b30e4b1b69..91c6affe139c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1389,6 +1389,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto poll_mode;
 	}
 
+	init_completion(&dspi->xfer_done);
+
 	ret = request_threaded_irq(dspi->irq, dspi_interrupt, NULL,
 				   IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
@@ -1396,8 +1398,6 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	init_completion(&dspi->xfer_done);
-
 poll_mode:
 
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-- 
2.17.1

