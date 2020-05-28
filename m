Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E370C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07011207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbgE1Pqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:46:49 -0400
Received: from lists.gateworks.com ([108.161.130.12]:57374 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404511AbgE1Pqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:46:44 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1jeKmo-0000aY-Rh; Thu, 28 May 2020 15:49:39 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Robert Richter <rrichter@marvell.com>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>
Subject: [RFC PATCH] spi: spi-cavium-thunderx: flag controller as half duplex
Date:   Thu, 28 May 2020 08:46:39 -0700
Message-Id: <1590680799-5640-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OcteonTX (TX1/ThunderX) SPI controller does not support full
duplex transactions. Set the appropriate flag such that the spi
core will return -EINVAL on such transactions requested by chip
drivers.

This is an RFC as I need someone from Marvell/Cavium to confirm
if this driver is used for other silicon that does support
full duplex transfers (in which case we will need to identify
that we are running on the ThunderX arch before setting the flag).

Cc: Robert Richter <rrichter@marvell.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/spi/spi-cavium-thunderx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index fd6b9ca..60c0d69 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -64,6 +64,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 		p->sys_freq = SYS_FREQ_DEFAULT;
 	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
 
+	master->flags = SPI_MASTER_HALF_DUPLEX;
 	master->num_chipselect = 4;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
 			    SPI_LSB_FIRST | SPI_3WIRE;
-- 
2.7.4

