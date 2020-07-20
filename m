Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2387C433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B476B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263321;
	bh=O22/EjZW3s43Xvx5U7ldwDb0VR1/xykQGrG5Q6WrfIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NOBkQVtKoNImHlfbu+X/lMYCDAyHB9bilqt1hSFGQxpVrgG84S4xRUb697ENt098K
	 Fxl+KShYlSOgv3bFfnxI0/Q+ne/b/raffmtHtQV4bTPbxFwK7mQB0kMGEtSszDwdqy
	 LQS2fkZXiu2YPw2oisFZEVQ1+kHVtyF9aKIgmsc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgGTPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgGTPoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:44:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5B720773;
        Mon, 20 Jul 2020 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259864;
        bh=O22/EjZW3s43Xvx5U7ldwDb0VR1/xykQGrG5Q6WrfIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4lCxzgMN17K23NiJQ6UxT2sng85W4f2XIHCP+zXdt43GeAdBXJsBYARsNCeDKP9X
         ZDNbyu1rnEoGfTaQfMN2lg2cqfWcSrVDjyGGowZVL6S+dywvDjtZAM2tFXEDJzKjy+
         wiWJz+1fqwtKB+NFWrhqfyi1PAj2ZRbusEbRIRLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 003/125] spi: spi-fsl-dspi: Fix lockup if device is removed during SPI transfer
Date:   Mon, 20 Jul 2020 17:35:42 +0200
Message-Id: <20200720152803.098024305@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 7684580d45bd3d84ed9b453a4cadf7a9a5605a3f ]

During device removal, the driver should unregister the SPI controller
and stop the hardware.  Otherwise the dspi_transfer_one_message() could
wait on completion infinitely.

Additionally, calling spi_unregister_controller() first in device
removal reverse-matches the probe function, where SPI controller is
registered at the end.

Fixes: 05209f457069 ("spi: fsl-dspi: add missing clk_disable_unprepare() in dspi_remove()")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200622110543.5035-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d5b56b7814fe3..baf5274485004 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1070,9 +1070,18 @@ static int dspi_remove(struct platform_device *pdev)
 	struct fsl_dspi *dspi = spi_master_get_devdata(master);
 
 	/* Disconnect from the SPI framework */
+	spi_unregister_controller(dspi->master);
+
+	/* Disable RX and TX */
+	regmap_update_bits(dspi->regmap, SPI_MCR,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,
+			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF);
+
+	/* Stop Running */
+	regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, SPI_MCR_HALT);
+
 	dspi_release_dma(dspi);
 	clk_disable_unprepare(dspi->clk);
-	spi_unregister_master(dspi->master);
 
 	return 0;
 }
-- 
2.25.1



