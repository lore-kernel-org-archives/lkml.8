Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7DDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F092A2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664820;
	bh=qKFBRQ81UcIuTIqoYgZMaUlWh2lfDV9p7Zr182yEqCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BLwRS42Pzz6CzORQoTS7XdAyr2eLhaiSXum8BHa//GCif7ZEkwWTinxV6mdsfavOG
	 yLajfZ5JqdPTVU9NvxQCSkuMbGr3Y0RNRJvrQIwImCD05H6m2RSbbcpLVxQZYOUfR/
	 FZEA3tOdinK3vPOGt+kid8qKB14L7/SfBUOyVdsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFHXHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgFHXGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDC22078C;
        Mon,  8 Jun 2020 23:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657599;
        bh=qKFBRQ81UcIuTIqoYgZMaUlWh2lfDV9p7Zr182yEqCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHoSNLueWKRyrz7VJJg1kLdM4tsHszdCF1tmjmiU9U7ACp0uKVOFBVpKWSp8smY09
         m3bQEyTnRlZO7U+EHcW42NJlGspQRySYBBrCi70hcSsHLfKrmr4uTkWHMtjwbkWU1w
         biCJYns9VMn5rqw7VfTIEITQ5V1fr2IOBXJljvBo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 025/274] spi: pxa2xx: Apply CS clk quirk to BXT
Date:   Mon,  8 Jun 2020 19:01:58 -0400
Message-Id: <20200608230607.3361041-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
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
index 73d2a65d0b6e..20dcbd35611a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -150,6 +150,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_hi = 48,
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
+		.cs_clk_stays_gated = true,
 	},
 	{	/* LPSS_CNL_SSP */
 		.offset = 0x200,
-- 
2.25.1

