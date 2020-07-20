Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BCBC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752DB206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263429;
	bh=KMkAKeNoZ26c+Gb1mutbil441mqczc7waHx+c2v1cJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZMqqCaGnTPGfP4bRTQXxKeGIv6nii5SzaMedBbqC4Syp73ZfQvx4/3ykSmqANoFH
	 EczkduTw4b4Y805vds14VE6EmqVaQVGhgqR+FA9RI+MQ8vB3Aw5UNoklA73NGedxPu
	 Hfi/00G8kODT+0k/Q2i/csPvp7qSzHH+5VsY5nsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgGTPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgGTPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936172064B;
        Mon, 20 Jul 2020 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259714;
        bh=KMkAKeNoZ26c+Gb1mutbil441mqczc7waHx+c2v1cJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYshliYSplSjDLTeGXUqMFJP7ShzxVHKC2G/2PbVjz0WuIFpdT35ZkRYr9gOykdsI
         5OsForaruYy27Q5xJOCKgiS/6s/1bW69XsFgRVwHvuXfdU9FLjzv6M5ftx2Vz0GdBC
         FNJwvTBB+Y+fnWRJXWUkK/SpDkh5ng/OAZh6tzC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 53/86] spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate
Date:   Mon, 20 Jul 2020 17:36:49 +0200
Message-Id: <20200720152755.830531635@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit ed7815db70d17b1741883f2da8e1d80bc2efe517 ]

A SPI transfer defines the _maximum_ speed of the SPI transfer. However the
driver doesn't take into account that the clock divider is always rounded down
(due to integer arithmetics). This results in a too high clock rate for the SPI
transfer.

E.g.: with a mclk_rate of 24 MHz and a SPI transfer speed of 10 MHz, the
original code calculates a reg of "0", which results in a effective divider of
"2" and a 12 MHz clock for the SPI transfer.

This patch fixes the issue by using DIV_ROUND_UP() instead of a plain
integer division.

While there simplify the divider calculation for the CDR1 case, use
order_base_2() instead of two ilog2() calculations.

Fixes: 3558fe900e8a ("spi: sunxi: Add Allwinner A31 SPI controller driver")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/r/20200706143443.9855-2-mkl@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sun6i.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 7e7da97982aaf..17068e62e792d 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -163,7 +163,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
@@ -241,14 +241,12 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * First try CDR2, and if we can't reach the expected
 	 * frequency, fall back to CDR1.
 	 */
-	div = mclk_rate / (2 * tfr->speed_hz);
-	if (div <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
-		if (div > 0)
-			div--;
-
-		reg = SUN6I_CLK_CTL_CDR2(div) | SUN6I_CLK_CTL_DRS;
+	div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
+	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
+	if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
+		reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
 	} else {
-		div = ilog2(mclk_rate) - ilog2(tfr->speed_hz);
+		div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
 		reg = SUN6I_CLK_CTL_CDR1(div);
 	}
 
-- 
2.25.1



