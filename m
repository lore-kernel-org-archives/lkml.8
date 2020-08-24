Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E28C2310D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287060;
	bh=hw7FTUSXhDZbMZBtjwl2xsNh6Azl3v030xZeS/4xO5I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BiVHrtLPmZvzxUZDm1zad+JBOwuc3Tn62j+slwjQ+gxCYdJgNNBgnRplSld2Ya/vT
	 gaL1a29b/m624GPCFhMJn2Xya0zmiDEbxObogUUb8eYoWXRRzV1ebtdDZytsnfpmW0
	 H9BPYU1mkR486OvoqjZIN+pcGN9ds45328Xa5psA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgHXQhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgHXQfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565F42067C;
        Mon, 24 Aug 2020 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286906;
        bh=hw7FTUSXhDZbMZBtjwl2xsNh6Azl3v030xZeS/4xO5I=;
        h=From:To:Cc:Subject:Date:From;
        b=ukXoyUnBMMnRvB9lWekaJK+0fskIndrukJJPQMVstWYpGpnCe56y3BtBKQf5ihttg
         EDDFUNfU5CAes5GJjZWZOYrmCbMa+XZS59ZO+bopq+pBy7E1pzHvtWeLrlJKXTtWCJ
         pCDipM9TiXycMupO2qwoF1KWnkFnVz/ucHTRuKKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tobias Schramm <t.schramm@manjaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 01/63] spi: stm32: clear only asserted irq flags on interrupt
Date:   Mon, 24 Aug 2020 12:34:01 -0400
Message-Id: <20200824163504.605538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Schramm <t.schramm@manjaro.org>

[ Upstream commit ae1ba50f1e706dfd7ce402ac52c1f1f10becad68 ]

Previously the stm32h7 interrupt thread cleared all non-masked interrupts.
If an interrupt was to occur during the handling of another interrupt its
flag would be unset, resulting in a lost interrupt.
This patches fixes the issue by clearing only the currently set interrupt
flags.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Link: https://lore.kernel.org/r/20200804195136.1485392-1-t.schramm@manjaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c643dfc7fbbc..4a21feae0103d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -966,7 +966,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32h7_spi_read_rxfifo(spi, false);
 
-	writel_relaxed(mask, spi->base + STM32H7_SPI_IFCR);
+	writel_relaxed(sr & mask, spi->base + STM32H7_SPI_IFCR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-- 
2.25.1

