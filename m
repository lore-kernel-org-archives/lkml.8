Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A068422D6E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287147;
	bh=4y3xbROUZGon7lxJn2+2Rwx+vsAhc8DrsiF8n1Ii7NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TMZknmni58PZ+lTkPUYNoTR43paMvR9+lVJt2+1dpmPi/9X6Azl4DrZ4BFqXGk7il
	 Jp9M0Dj5v5zN5mMjdw6xg0l7qddoNMbog8RetufDDgC7tuC9WlOVppG+7/GKQFDcq+
	 MxIijGL9Dg8tOdJEWJ6HtTdrzdkvjztJPttkeIyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgHXQjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgHXQf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D536622C9E;
        Mon, 24 Aug 2020 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286925;
        bh=4y3xbROUZGon7lxJn2+2Rwx+vsAhc8DrsiF8n1Ii7NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3Fsndt22kEXmVNuRJXHCcDzVqcyWsJ2tR3xP53F67CrKdS/GbVRfSw5iNizIWel2
         Lapi2or9VNg2oCEQFh3unkurkwlidTIlDdFuMFiaaVCNaleWQ++M4tKq8N+A19uJgC
         XrV82dIusACredZKw8ao7zYE/MtuRrqgPgi+jjjU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <alain.volmat@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 16/63] spi: stm32: always perform registers configuration prior to transfer
Date:   Mon, 24 Aug 2020 12:34:16 -0400
Message-Id: <20200824163504.605538-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@st.com>

[ Upstream commit 60ccb3515fc61a0124c70aa37317f75b67560024 ]

SPI registers content may have been lost upon suspend/resume sequence.
So, always compute and apply the necessary configuration in
stm32_spi_transfer_one_setup routine.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
Link: https://lore.kernel.org/r/1597043558-29668-6-git-send-email-alain.volmat@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 42 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 571dea72bf7e6..37dac7f0b8609 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1596,41 +1596,33 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	unsigned long flags;
 	unsigned int comm_type;
 	int nb_words, ret = 0;
+	int mbr;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
 	spi->cur_xferlen = transfer->len;
 
-	if (spi->cur_bpw != transfer->bits_per_word) {
-		spi->cur_bpw = transfer->bits_per_word;
-		spi->cfg->set_bpw(spi);
-	}
-
-	if (spi->cur_speed != transfer->speed_hz) {
-		int mbr;
-
-		/* Update spi->cur_speed with real clock speed */
-		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
-					    spi->cfg->baud_rate_div_min,
-					    spi->cfg->baud_rate_div_max);
-		if (mbr < 0) {
-			ret = mbr;
-			goto out;
-		}
+	spi->cur_bpw = transfer->bits_per_word;
+	spi->cfg->set_bpw(spi);
 
-		transfer->speed_hz = spi->cur_speed;
-		stm32_spi_set_mbr(spi, mbr);
+	/* Update spi->cur_speed with real clock speed */
+	mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
+				    spi->cfg->baud_rate_div_min,
+				    spi->cfg->baud_rate_div_max);
+	if (mbr < 0) {
+		ret = mbr;
+		goto out;
 	}
 
-	comm_type = stm32_spi_communication_type(spi_dev, transfer);
-	if (spi->cur_comm != comm_type) {
-		ret = spi->cfg->set_mode(spi, comm_type);
+	transfer->speed_hz = spi->cur_speed;
+	stm32_spi_set_mbr(spi, mbr);
 
-		if (ret < 0)
-			goto out;
+	comm_type = stm32_spi_communication_type(spi_dev, transfer);
+	ret = spi->cfg->set_mode(spi, comm_type);
+	if (ret < 0)
+		goto out;
 
-		spi->cur_comm = comm_type;
-	}
+	spi->cur_comm = comm_type;
 
 	if (spi->cfg->set_data_idleness)
 		spi->cfg->set_data_idleness(spi, transfer->len);
-- 
2.25.1

