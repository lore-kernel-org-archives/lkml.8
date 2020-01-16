Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF5C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24109214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197742;
	bh=AiKD26N73+dcE/BuuQ0MMJHJKa0NJr0JAFQM6yaVb+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Joe+lYmwc8iyDdOECcWtYTcHyQ96G5q0ym3K/Z1LSM4jarNHPpeN5qkfK1Acx5Bfu
	 LdeiPBdmDmFj6ETew7AApVPbXsOxuc9NDa+E9kPeU7J/fgptwX19SxAbBNKAU/aGG4
	 J7E5VoTxY8QDr/5fkgmJhay46gYwluIxdDkcAFow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393579AbgAPRlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388484AbgAPRkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6354E24705;
        Thu, 16 Jan 2020 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196411;
        bh=AiKD26N73+dcE/BuuQ0MMJHJKa0NJr0JAFQM6yaVb+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGUZY0JtOXbp5lvM/O/I7AhqCEmdFf0VYlRksCtJk0h1dO8TTjZrTO35iw7ioP322
         K/5D7G6QHfWZPp9rof/sr4adD9j7C3zRWd3fI4QT1cfrOZzT2iI9Ii2lCVFY1h9NBl
         wMvaMI/PAiOPJxxzJKAtE4DKaUqnMva3TWnNHeYg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 184/251] ASoC: sun4i-i2s: RX and TX counter registers are swapped
Date:   Thu, 16 Jan 2020 12:35:33 -0500
Message-Id: <20200116173641.22137-144-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit cf2c0e1ce9544df42170fb921f12da82dc0cc8d6 ]

The RX and TX counters registers offset have been swapped, fix that.

Fixes: fa7c0d13cb26 ("ASoC: sunxi: Add Allwinner A10 Digital Audio driver")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/8b26477560ad5fd8f69e037b167c5e61de5c26a3.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 15c92400cea4..02c373c65e19 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -78,8 +78,8 @@
 #define SUN4I_I2S_CLK_DIV_MCLK_MASK		GENMASK(3, 0)
 #define SUN4I_I2S_CLK_DIV_MCLK(mclk)			((mclk) << 0)
 
-#define SUN4I_I2S_RX_CNT_REG		0x28
-#define SUN4I_I2S_TX_CNT_REG		0x2c
+#define SUN4I_I2S_TX_CNT_REG		0x28
+#define SUN4I_I2S_RX_CNT_REG		0x2c
 
 #define SUN4I_I2S_TX_CHAN_SEL_REG	0x30
 #define SUN4I_I2S_TX_CHAN_SEL(num_chan)		(((num_chan) - 1) << 0)
-- 
2.20.1

