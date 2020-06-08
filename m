Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1597C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D7D2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659383;
	bh=mtuGhnGkFOv4Dnysg1avCQwqR0R4OOqhgGtN1I4N6do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcN3gaRjpjMwluShNpLM2rHQShHJUCx0lZ3mXM40KtdQuNospf1FjXuCAtZRMwyLp
	 u+7nTs9Px5CMhnuZTt5mxzBPwcjaOsemPTAtPDCpaj7ojFBVxVg0AziEOqxSgodE0T
	 KGwsRF0b5jDunWareAP1TC8p0xqaXhSr+riVWpcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbgFHXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbgFHXZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:25:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39A92074B;
        Mon,  8 Jun 2020 23:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658709;
        bh=mtuGhnGkFOv4Dnysg1avCQwqR0R4OOqhgGtN1I4N6do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5LJdj55XBhL0KzkCMd8LcssockatR/FZMgfEYTlwrB9oR5EMzp1HWyQC27M0Wzb2
         BjIP+kTO/LWVBE+OvFhvReesa5dLJICcGPBnMELdEoJ5k0u5PrYa+f3eFhTn1WZspC
         T53jxVLhUVeLhlDUiTWzRhYaOJYDMUTT8XNioNAI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/72] spi: pxa2xx: Apply CS clk quirk to BXT
Date:   Mon,  8 Jun 2020 19:23:55 -0400
Message-Id: <20200608232500.3369581-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit 6eefaee4f2d366a389da0eb95e524ba82bf358c4 ]

With a couple allies at Intel, and much badgering, I got confirmation
from Intel that at least BXT suffers from the same SPI chip-select
issue as Cannonlake (and beyond). The issue being that after going
through runtime suspend/resume, toggling the chip-select line without
also sending data does nothing.

Add the quirk to BXT to briefly toggle dynamic clock gating off and
on, forcing the fabric to wake up enough to notice the CS register
change.

Signed-off-by: Evan Green <evgreen@chromium.org>
Cc: Shobhit Srivastava <shobhit.srivastava@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200427163238.1.Ib1faaabe236e37ea73be9b8dcc6aa034cb3c8804@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 5160e16d3a98..45a211c7dd22 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -156,6 +156,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 48,
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
+		.cs_clk_stays_gated = true,
 	},
 	{	/* LPSS_CNL_SSP */
 		.offset = 0x200,
-- 
2.25.1

