Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75737C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A02077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197321;
	bh=WQciWQeVuDbjGvDDY9MRGMybk2MWjpaMc9craR4RT1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSCetENjLesBlRvLWAn1t5J0oO4t8zol31LJZmY6MdUR991TcZy/a3DiMB+kUrwZk
	 d5NlVDH/yaMNvK40qum9pagoXUSCIFk88jLI2qxn3c/9dgZSsis8u5dLQu9Qpru9m3
	 3YlwRhj230R+v3tuX8nse8/tXk28MzVeYABBK3TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406742AbgAPRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394159AbgAPRoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170182475F;
        Thu, 16 Jan 2020 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196665;
        bh=WQciWQeVuDbjGvDDY9MRGMybk2MWjpaMc9craR4RT1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGdLhjZx/9rxub/Bs1Zrtw3l9a2CpoaH540MtlkDAzp5tQCK1uR/mRgFlAv+vFuU6
         Nbjf507Qul6Ten3BmBg7D6GbwWYsBo4S63azzO19VGX86iWmfmn5N7ZgzUMi0N0HHC
         7xQ+gRQv38e5qgcHkg/2O2BPM7aRPvfcZALHHjQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 067/174] spi: tegra114: clear packed bit for unpacked mode
Date:   Thu, 16 Jan 2020 12:41:04 -0500
Message-Id: <20200116174251.24326-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
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
index 705f515863d4..d98c502a9c47 100644
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

