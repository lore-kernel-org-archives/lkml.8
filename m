Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BD3207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591803730;
	bh=T0g/Y42kJC01OEoFBGhoaN5SHb8YsES7u1KLhw4yYQ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TfCpf8mRXGnQOMPDxPjSePSmLBMTxdiYlwU7HS6zFsWWBF6nhoN3nDymsVDBb/VmL
	 dBYCjfv6V3kNcyno0MeWReFDGZvRjcfxAPWNet6iYI+/hjKPyhLmkpAzM104obS38S
	 lTZ8F8nwWcJueEMM6niIcW1Vyszd4dTttipacgAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgFJPmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:42:08 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBF42072F;
        Wed, 10 Jun 2020 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591803728;
        bh=T0g/Y42kJC01OEoFBGhoaN5SHb8YsES7u1KLhw4yYQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=tVAv3mcHxoUQwI0t9AS6dDdcA911AilkLa+olqKAf9FYYA7kqQ4ifCb5LSK9hjAYG
         ZNkXSLGs62J4ZNSGhiDMdbyz7wOxUfd7rRRPTyW7YjhvjzMXE6IhqN+4elBKUpyq7H
         xchBOhP2nGhV6I4aB1qWTqrXIsH9mF9MLyM6eRG0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-dspi: Free DMA memory with matching function
Date:   Wed, 10 Jun 2020 17:41:57 +0200
Message-Id: <1591803717-11218-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver allocates DMA memory with dma_alloc_coherent() but frees it with
dma_unmap_single().

This causes DMA warning during system shutdown (with DMA debugging) on
Toradex Colibri VF50 module:

    WARNING: CPU: 0 PID: 1 at ../kernel/dma/debug.c:1036 check_unmap+0x3fc/0xb04
    DMA-API: fsl-edma 40098000.dma-controller: device driver frees DMA memory with wrong function
      [device address=0x0000000087040000] [size=8 bytes] [mapped as coherent] [unmapped as single]
    Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
      (unwind_backtrace) from [<8010bb34>] (show_stack+0x10/0x14)
      (show_stack) from [<8011ced8>] (__warn+0xf0/0x108)
      (__warn) from [<8011cf64>] (warn_slowpath_fmt+0x74/0xb8)
      (warn_slowpath_fmt) from [<8017d170>] (check_unmap+0x3fc/0xb04)
      (check_unmap) from [<8017d900>] (debug_dma_unmap_page+0x88/0x90)
      (debug_dma_unmap_page) from [<80601d68>] (dspi_release_dma+0x88/0x110)
      (dspi_release_dma) from [<80601e4c>] (dspi_shutdown+0x5c/0x80)
      (dspi_shutdown) from [<805845f8>] (device_shutdown+0x17c/0x220)
      (device_shutdown) from [<80143ef8>] (kernel_restart+0xc/0x50)
      (kernel_restart) from [<801441cc>] (__do_sys_reboot+0x18c/0x210)
      (__do_sys_reboot) from [<80100060>] (ret_fast_syscall+0x0/0x28)
    DMA-API: Mapped at:
     dma_alloc_attrs+0xa4/0x130
     dspi_probe+0x568/0x7b4
     platform_drv_probe+0x6c/0xa4
     really_probe+0x208/0x348
     driver_probe_device+0x5c/0xb4

Fixes: 90ba37033cb9 ("spi: spi-fsl-dspi: Add DMA support for Vybrid")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a35faced0456..58190c94561f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -588,14 +588,14 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		return;
 
 	if (dma->chan_tx) {
-		dma_unmap_single(dma->chan_tx->device->dev, dma->tx_dma_phys,
-				 dma_bufsize, DMA_TO_DEVICE);
+		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
+				  dma->tx_dma_buf, dma->tx_dma_phys);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_unmap_single(dma->chan_rx->device->dev, dma->rx_dma_phys,
-				 dma_bufsize, DMA_FROM_DEVICE);
+		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
+				  dma->rx_dma_buf, dma->rx_dma_phys);
 		dma_release_channel(dma->chan_rx);
 	}
 }
-- 
2.7.4

