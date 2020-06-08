Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED4EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CC5208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658913;
	bh=fA/uAMCRd6Wtix16my7fC6/09nubqAfWg1dTSGzBK4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=psKgk7snm2yyZMyFje1eRB3lecW4/OtKVMP7SIYYE4+B8DgoK85AyIs93NAveg8Fx
	 9nKpzrUt+muu0dK3qTq8VQ+h4i1T1IP7wkmlA167+MzdrgjpgwJFrDjMkkaxX/veZ1
	 N6IHEsNxhwGzpITxT/Bk7781Ls+G+S9DsBQmqhjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgFHX2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbgFHXWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89ED520842;
        Mon,  8 Jun 2020 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658567;
        bh=fA/uAMCRd6Wtix16my7fC6/09nubqAfWg1dTSGzBK4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zeh3StAKMlJdSPnMm3EeZIWVWuzT12gwg8qx8gAICUtptlZSacbTv15GZVGDnipO7
         PjqQf1kqbcVU5QqpMuqgS+EjyTIfWL6RiEb917EGRYf2EHRYwo0Nljyky3tErISzHA
         0MCR1qZeRI5n3ou7MGeOCBMLEangWy0GBiw9VP9E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 007/106] spi: pxa2xx: Apply CS clk quirk to BXT
Date:   Mon,  8 Jun 2020 19:20:59 -0400
Message-Id: <20200608232238.3368589-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
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
index e4482823d8d7..34662ce04522 100644
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

