Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C9C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CCA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262381;
	bh=RqVU8Df+lOK7unML23BC5+Sc36ZeTBM8k96AayuSAis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HrW8KIom8R6F6CTiJuZ94dx2nGUZTwLteCYZVfF2aE/+E+YeohEOSesD/YBJRhwWK
	 /5rm+iCXZTqvOBX72Wx/X+4G8Bhoj7lhJmxmSrcaGHKD7Lnt/QQDxV1YgDaraPecQt
	 c59YpKCDxdDnoRQcCvlLm6p00erqS1KOxNWcCUVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgGTQAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbgGTQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:00:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B0FE20773;
        Mon, 20 Jul 2020 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260810;
        bh=RqVU8Df+lOK7unML23BC5+Sc36ZeTBM8k96AayuSAis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jL+KYAHfu3BZbYGK/6S7g8EZGNqSTQ3A4/cY/aS9janiiy1545qEH/KRj7Wt2SGUp
         j9J4mlCORNSR/IA7CC0RSnsKdbBbSf8kqLPFyAGYxs9QxA9ArMVTGedzpKXKFrnxbm
         AwVPJHT7SBVxtfh5qOM6SWMnPcJ0oka5vwX4juT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 105/215] spi: spi-sun6i: sun6i_spi_transfer_one(): fix setting of clock rate
Date:   Mon, 20 Jul 2020 17:36:27 +0200
Message-Id: <20200720152825.204287142@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
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
index ec7967be9e2f5..956df79035d56 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -198,7 +198,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_master_get_devdata(master);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
 	unsigned int tx_len = 0;
@@ -287,14 +287,12 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
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



