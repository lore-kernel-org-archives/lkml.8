Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07451C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 10:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D355B2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 10:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592132190;
	bh=0rKkJ1Z3YBYfBse9lAc1mMovRr1RvwKisv2qZzA8c1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2ZBxKf9v4WR3JoZwoZ4CiP8QirsZO8hLTG1HvP5zxAHytIVIeSIQK90KNBi1mqvo
	 yElk4OqkzCz2TAs291aN8V7phf0DvyFt1+XqtzFy+Bn4AKcUQlso7GbcCbdiyUWJOI
	 Wap2/iwOGhAaPOboawefCkDcu9lj+/1ct9ZRI9+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFNK4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 06:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgFNK4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 06:56:04 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74802078A;
        Sun, 14 Jun 2020 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592132163;
        bh=0rKkJ1Z3YBYfBse9lAc1mMovRr1RvwKisv2qZzA8c1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHhS9Me1B0s+Henc9ngYOTebfbSDtxDdovc11hC6bkNxcgnphI8lp22ljb4k2iY0q
         tMoQtocbiXvWUvAoBdniKSJDvpDycWkS3ooJ0LAuPkZxbIDio6nEizGYDDLxN/DHNQ
         vtKqJyBzO1xVOHQHAfKAauAr6/h+elBoUoFHq8rU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-fsl-dspi: Initialize completion before possible interrupt
Date:   Sun, 14 Jun 2020 12:55:54 +0200
Message-Id: <1592132154-20175-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592132154-20175-1-git-send-email-krzk@kernel.org>
References: <1592132154-20175-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupt fires early, the dspi_interrupt() could complete
(dspi->xfer_done) before its initialization happens.

Fixes: 4f5ee75ea171 ("spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 57e7a626ba00..efb63ed9fd86 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1385,6 +1385,8 @@ static int dspi_probe(struct platform_device *pdev)
 		goto poll_mode;
 	}
 
+	init_completion(&dspi->xfer_done);
+
 	ret = request_threaded_irq(dspi->irq, dspi_interrupt, NULL,
 				   IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
@@ -1392,8 +1394,6 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	init_completion(&dspi->xfer_done);
-
 poll_mode:
 
 	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-- 
2.7.4

