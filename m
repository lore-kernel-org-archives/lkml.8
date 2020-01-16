Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F0C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B3246C8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195578;
	bh=BbhYBKR4UIhlaNuwGxzS3sKtVv2MUrrSn2DNGZG68xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jSSQRsa+6ZncWwSbyRWt/nbmS461dDWv1G2ryynKdaiQCTm8ysvFO/FoPHZkZSX7Q
	 w8/RSdrKZcOqOaMoB1F8B2H8weKTZQF1c9SSyEyM6xi2duseMs6uzBnFagfEfTLzmR
	 0T6wxNMRVX1u5GhZA+beNwU/bzXL6NjxA4WknxyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbgAPR0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392221AbgAPR0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B5724653;
        Thu, 16 Jan 2020 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195562;
        bh=BbhYBKR4UIhlaNuwGxzS3sKtVv2MUrrSn2DNGZG68xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjSHlOAJrt/qrYnI0l/EJ/lq2RdODbczZ14s9t6g3oQQG+jPGupg2yeOLiVzTyr6K
         DLBWQXSkxOq12ikK2TkqU6Naej3pzJdF6pU2UtpoP1Xc1zRyB6Bgxai79BKrgcHR7h
         lxuVPVcKSEpG8KvZqDW5FGudmsL2yicnhD2jBHxU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 149/371] spi: tegra114: clear packed bit for unpacked mode
Date:   Thu, 16 Jan 2020 12:20:21 -0500
Message-Id: <20200116172403.18149-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit 7b3d10cdf54b8bc1dc0da21faed9789ac4da3684 ]

Fixes: Clear packed bit when not using packed mode.

Packed bit is not cleared when not using packed mode. This results
in transfer timeouts for the unpacked mode transfers followed by the
packed mode transfers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra114.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 2ad04796ef29..3a6b202dfffe 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -730,6 +730,8 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 
 	if (tspi->is_packed)
 		command1 |= SPI_PACKED;
+	else
+		command1 &= ~SPI_PACKED;
 
 	command1 &= ~(SPI_CS_SEL_MASK | SPI_TX_EN | SPI_RX_EN);
 	tspi->cur_direction = 0;
-- 
2.20.1

