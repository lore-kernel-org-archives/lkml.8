Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3324C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C1B20775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565814;
	bh=B7CGiG0pCM17QhTb775VkylPBpMzSdyEGtH1Vf/QKG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mT2apm+4mVGcJl28X+G+edBhfSN6oQ50rXg52PemMxUgSXgamjXV6udc1pQy9lyTd
	 psGz/WBGfFcS0shwY/L73rF/9AVtqNfNVIfKDOF3FLwbTLs7cVQpJamJeM1h9NBNH1
	 loJKOCyS6/0NBNjb3GS1IjB2i49ltpX6ZIhzD2HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgCRVKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCRUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E868220775;
        Wed, 18 Mar 2020 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564809;
        bh=B7CGiG0pCM17QhTb775VkylPBpMzSdyEGtH1Vf/QKG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0OO+MVthe28tFk4crvVSemJY8NQPOi7nOpGb0V5yANfImXuzMfgjVoTbvSNWNMdx
         C7tC30PsM3VMOiTKixPODr50lyyJgvAt9qNpLX/G/e4vtrZGSQfIkkFw9it/+sLWv5
         +Hw+x2Z1M6cq0/FPoIq9okzB9575eNcC19URxtv0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 06/84] pinctrl: meson-gxl: fix GPIOX sdio pins
Date:   Wed, 18 Mar 2020 16:52:03 -0400
Message-Id: <20200318205321.16066-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205321.16066-1-sashal@kernel.org>
References: <20200318205321.16066-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Belin <nbelin@baylibre.com>

[ Upstream commit dc7a06b0dbbafac8623c2b7657e61362f2f479a7 ]

In the gxl driver, the sdio cmd and clk pins are inverted. It has not caused
any issue so far because devices using these pins always take both pins
so the resulting configuration is OK.

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
Link: https://lore.kernel.org/r/1582204512-7582-1-git-send-email-nbelin@baylibre.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 1b6e8646700f9..2ac921c83da91 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -147,8 +147,8 @@ static const unsigned int sdio_d0_pins[]	= { GPIOX_0 };
 static const unsigned int sdio_d1_pins[]	= { GPIOX_1 };
 static const unsigned int sdio_d2_pins[]	= { GPIOX_2 };
 static const unsigned int sdio_d3_pins[]	= { GPIOX_3 };
-static const unsigned int sdio_cmd_pins[]	= { GPIOX_4 };
-static const unsigned int sdio_clk_pins[]	= { GPIOX_5 };
+static const unsigned int sdio_clk_pins[]	= { GPIOX_4 };
+static const unsigned int sdio_cmd_pins[]	= { GPIOX_5 };
 static const unsigned int sdio_irq_pins[]	= { GPIOX_7 };
 
 static const unsigned int nand_ce0_pins[]	= { BOOT_8 };
-- 
2.20.1

