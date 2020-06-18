Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD07C2220A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443750;
	bh=QT4do9IAgrgRk1CM6Sv6l1cKCtsv7Ln/YTdCXQrOmWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fX1dSndO7JK0HS0JbV4VNgd7Oru827/qy4B7w8sHa/8j6TTceQ7IVGIAdz96zUrNS
	 OPSoX2x9IiVk2x0hUVW+E7xNU08gHlZkcTqMyR1G8jIcroTKcC+CF52q5sjQZM8rKu
	 RhFgMdPSuTb9bV2V2Gu8cVVCJBGsu06TnwMdj4w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbgFRB3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbgFRB0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA50F20776;
        Thu, 18 Jun 2020 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443563;
        bh=QT4do9IAgrgRk1CM6Sv6l1cKCtsv7Ln/YTdCXQrOmWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFNv9nPiivh5TBAd0YQsONp7luL8ebF3eeMkz+eTM9xd/mezRnP3qip2e05R4Lcxi
         0d5o0H9nLS9UiU4OPy5uh4s28z8y3noEdrEp50gDf3tpTiorYYnSAoZtiRKF89bRjr
         jTn93U5cLztKhCf//N5ZT2xEKCduTf9FeLzh4RZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 002/108] clk: sunxi: Fix incorrect usage of round_down()
Date:   Wed, 17 Jun 2020 21:24:14 -0400
Message-Id: <20200618012600.608744-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

[ Upstream commit ee25d9742dabed3fd18158b518f846abeb70f319 ]

round_down() can only round to powers of 2. If round_down() is asked
to round to something that is not a power of 2, incorrect results are
produced. The incorrect results can be both too large and too small.

Instead, use rounddown() which can round to any number.

Fixes: 6a721db180a2 ("clk: sunxi: Add A31 clocks support")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index aa4add580516..0b5e091742f9 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -98,7 +98,7 @@ static void sun6i_a31_get_pll1_factors(struct factors_request *req)
 	 * Round down the frequency to the closest multiple of either
 	 * 6 or 16
 	 */
-	u32 round_freq_6 = round_down(freq_mhz, 6);
+	u32 round_freq_6 = rounddown(freq_mhz, 6);
 	u32 round_freq_16 = round_down(freq_mhz, 16);
 
 	if (round_freq_6 > round_freq_16)
-- 
2.25.1

