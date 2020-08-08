Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B4C433E4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BACF20825
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930125;
	bh=XJ5DmlNOlYa9O5RhsrLNP3SNVFa/vv5QstJP+KMrTms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=whCcmGvyuslom4iZHZ5tXubzAAKWs4F1kObaIQkCqTt95ENfU5jCF/O6mGw+LGLC1
	 WbAf/NSjA0xqSbJ373fQwc5Yp20A1K+jOByeDZAooS0idMvs43gv/Mgqnoule6n/cB
	 RlS5W8sbiGTcfZutgAto5InaN5PjbH0gfa8Zh/lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgHHXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgHHXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF63520716;
        Sat,  8 Aug 2020 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930011;
        bh=XJ5DmlNOlYa9O5RhsrLNP3SNVFa/vv5QstJP+KMrTms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeO+ZfyCmWVJEb+B74k76Gb1f7IJ9Wr7l1Z8yvHofSFnmKEiysuA+UsiCxdPLEQtV
         QDUP8TXa3uodanFH60mXn+SvMdKohuUnBFPLGdms+vcgRVUQaL+ZDqPHM1o8mx8MFx
         BVGPuCEtrZX5l/Z/x3fBXpUvB2R316SwbXlXlgDA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/21] spi: lantiq: fix: Rx overflow error in full duplex mode
Date:   Sat,  8 Aug 2020 19:39:40 -0400
Message-Id: <20200808233941.3619277-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233941.3619277-1-sashal@kernel.org>
References: <20200808233941.3619277-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dilip Kota <eswara.kota@linux.intel.com>

[ Upstream commit 661ccf2b3f1360be50242726f7c26ced6a9e7d52 ]

In full duplex mode, rx overflow error is observed. To overcome the error,
wait until the complete data got received and proceed further.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Link: https://lore.kernel.org/r/efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-lantiq-ssc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index d5976615d924b..dc740b5f720ba 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -187,6 +187,7 @@ struct lantiq_ssc_spi {
 	unsigned int			tx_fifo_size;
 	unsigned int			rx_fifo_size;
 	unsigned int			base_cs;
+	unsigned int			fdx_tx_level;
 };
 
 static u32 lantiq_ssc_readl(const struct lantiq_ssc_spi *spi, u32 reg)
@@ -484,6 +485,7 @@ static void tx_fifo_write(struct lantiq_ssc_spi *spi)
 	u32 data;
 	unsigned int tx_free = tx_fifo_free(spi);
 
+	spi->fdx_tx_level = 0;
 	while (spi->tx_todo && tx_free) {
 		switch (spi->bits_per_word) {
 		case 2 ... 8:
@@ -512,6 +514,7 @@ static void tx_fifo_write(struct lantiq_ssc_spi *spi)
 
 		lantiq_ssc_writel(spi, data, LTQ_SPI_TB);
 		tx_free--;
+		spi->fdx_tx_level++;
 	}
 }
 
@@ -523,6 +526,13 @@ static void rx_fifo_read_full_duplex(struct lantiq_ssc_spi *spi)
 	u32 data;
 	unsigned int rx_fill = rx_fifo_level(spi);
 
+	/*
+	 * Wait until all expected data to be shifted in.
+	 * Otherwise, rx overrun may occur.
+	 */
+	while (rx_fill != spi->fdx_tx_level)
+		rx_fill = rx_fifo_level(spi);
+
 	while (rx_fill) {
 		data = lantiq_ssc_readl(spi, LTQ_SPI_RB);
 
-- 
2.25.1

