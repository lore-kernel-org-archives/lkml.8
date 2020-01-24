Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9936C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142020708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864528;
	bh=Z2e3TdZKupN01dUrMHq1I9q68NvHCMqnkZ6AhniEOHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OInLpMz2GHZYkuP4f9HAGG2Sj57g3tWdhC264Fq3ES491j9RBfvZ1cswaUnB12Evm
	 v+rFZgzRvqFwFQI5ZepQ+RjsaUeiQd4qC68DyRTmmzG7okZVuFACupfdj7894A7H1f
	 09JUMw9QQyKL73pdGOIht9uJ91UsOgk6BaN35vzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgAXLP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390259AbgAXLPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:15:23 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3542077C;
        Fri, 24 Jan 2020 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864522;
        bh=Z2e3TdZKupN01dUrMHq1I9q68NvHCMqnkZ6AhniEOHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii2Ucn6iPKlR1En59G3vdntmT2Zri65RJVC9lrdrINa8txEaug94GGVZz7GlZtiAv
         1H+3rPqUyguHZ1oSXQUW+YlSc9eUOQMZ7spkTctk2Fz1wsNKaB2BaQkqXE33fsGHcM
         tMtxSoiDcGhnnoJkYXRYplFvfz8fjXUMzoQM7iNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 289/639] spi: bcm2835aux: fix driver to not allow 65535 (=-1) cs-gpios
Date:   Fri, 24 Jan 2020 10:27:39 +0100
Message-Id: <20200124093123.082918885@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

[ Upstream commit 509c583620e9053e43d611bf1614fc3d3abafa96 ]

The original driver by default defines num_chipselects as -1.
This actually allicates an array of 65535 entries in
of_spi_register_master.

There is a side-effect for buggy device trees that (contrary to
dt-binding documentation) have no cs-gpio defined.

This mode was never supported by the driver due to limitations
of native cs and additional code complexity and is explicitly
not stated to be implemented.

To keep backwards compatibility with such buggy DTs we limit
the number of chip_selects to 1, as for all practical purposes
it is only ever realistic to use a single chip select in
native cs mode without negative side-effects.

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 12c1fa5b06c5b..c63ed402cf860 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -416,7 +416,18 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	master->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->num_chipselect = -1;
+	/* even though the driver never officially supported native CS
+	 * allow a single native CS for legacy DT support purposes when
+	 * no cs-gpio is configured.
+	 * Known limitations for native cs are:
+	 * * multiple chip-selects: cs0-cs2 are all simultaniously asserted
+	 *     whenever there is a transfer -  this even includes SPI_NO_CS
+	 * * SPI_CS_HIGH: is ignores - cs are always asserted low
+	 * * cs_change: cs is deasserted after each spi_transfer
+	 * * cs_delay_usec: cs is always deasserted one SCK cycle after
+	 *     a spi_transfer
+	 */
+	master->num_chipselect = 1;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
 	master->handle_err = bcm2835aux_spi_handle_err;
 	master->prepare_message = bcm2835aux_spi_prepare_message;
-- 
2.20.1



