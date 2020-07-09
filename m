Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55480C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BF42074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGIKML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:12:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58881 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIKMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:12:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jtTX9-0007mJ-I9; Thu, 09 Jul 2020 10:12:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Peng Fan <fanpeng@loongson.cn>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: atmel: remove redundant label out_free
Date:   Thu,  9 Jul 2020 11:12:03 +0100
Message-Id: <20200709101203.1374117-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error exit label out_free is no longer being used, it is redundant
and can be removed.

Cleans up warning:
drivers/spi/spi-atmel.c:1680:1: warning: label ‘out_free’ defined but not used [-Wunused-label]

Fixes: 2d9a744685bc ("spi: atmel: No need to call spi_master_put() if spi_alloc_master() failed")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-atmel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 6ed7abdcf74a..2cfe6253a784 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1677,7 +1677,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(clk);
 out_free_irq:
 out_unmap_regs:
-out_free:
 	spi_master_put(master);
 	return ret;
 }
-- 
2.27.0

