Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC71204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660381;
	bh=FQzGguG+hmcl7cfXxLr3IInpG6jYeF8Ns+/5r+ngYpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jzk4cyR9HG68X3I15bIGD3AIBvRWBP5P5rNJFSzBQqTltTaMcpwe/hb+hUD7K2GrV
	 SgJXqyTgAUU328M6DvV8B9FQHHporqXkiLl3by2pcD8RIG0GTdFfr8yV/U0gWf6VRB
	 QRC1G2I2IB5wqLATVKxi3FzKHrwZeFjhR0KO0b0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgFHXYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbgFHXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B519F2085B;
        Mon,  8 Jun 2020 23:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658362;
        bh=FQzGguG+hmcl7cfXxLr3IInpG6jYeF8Ns+/5r+ngYpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj2b/JqXuRZ09KycM+QbvX/M8Y7grECCLmmnU7D4rRoY6pwr3LUCoxdNUou4KInPa
         I9HTWsWFoD6Iz7/qfot6V4Bg7MzJvFEudZ8cBnk4HNujgahITGdCNzcQhoqQFcWO/J
         BuJOsUo7oR0CEYBmE6bGlE/WNk75VqhRdKDWdKRo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 027/175] spi: dw: Zero DMA Tx and Rx configurations on stack
Date:   Mon,  8 Jun 2020 19:16:20 -0400
Message-Id: <20200608231848.3366970-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3cb97e223d277f84171cc4ccecab31e08b2ee7b5 ]

Some DMA controller drivers do not tolerate non-zero values in
the DMA configuration structures. Zero them to avoid issues with
such DMA controller drivers. Even despite above this is a good
practice per se.

Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Feng Tang <feng.tang@intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20200506153025.21441-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw-mid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 2663bb12d9ce..242ac2768518 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -147,6 +147,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 	if (!xfer->tx_buf)
 		return NULL;
 
+	memset(&txconf, 0, sizeof(txconf));
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
 	txconf.dst_maxburst = 16;
@@ -193,6 +194,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 	if (!xfer->rx_buf)
 		return NULL;
 
+	memset(&rxconf, 0, sizeof(rxconf));
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
 	rxconf.src_maxburst = 16;
-- 
2.25.1

