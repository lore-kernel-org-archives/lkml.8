Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F30C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A793206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201897;
	bh=pIk3itN6SGLX9r+2vgQu8eYemBT/0ZRS1G62zBb6kZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdWLI2ugZdHqg50KfAFfoV5a61VHkT5lgogJ8V8j7nixqtG+bjlzb4WsFJlQmvNkj
	 Sc+lNvNVGxw+exxXIeiD95ER+ZXGqru68iLrnosMIiu9vwV8O1VGfUGtPyKPO0Zffk
	 x/BdQjl/RMxa9W2p12k/3YqSfCFhq+8j+26N09LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgAPRAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbgAPRAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5605F2467C;
        Thu, 16 Jan 2020 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194005;
        bh=pIk3itN6SGLX9r+2vgQu8eYemBT/0ZRS1G62zBb6kZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sq1HwvwJjd62VyOy8XCLqsdLcf+yYuLARkGkQqEGtyfaw9y2QQMzzZVcBRrKWKlm3
         ioy4sh6Hxl0CtqjTW4Wc8mGYKQFZ8O2G1HstPvMQQaePHbgwIsHrpzgClf/XVLHddK
         6JHHyjZqJFcnMWyAK36tJNu2UHGtk3Mgi5UTwXRw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 131/671] clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when ungating it
Date:   Thu, 16 Jan 2020 11:50:40 -0500
Message-Id: <20200116165940.10720-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 108a459ef4cd17a28711d81092044e597b5c7618 ]

The PLL-MIPI clock is somewhat special as it has its own LDOs which
need to be turned on for this PLL to actually work and output a clock
signal.

Add the 2 LDO enable bits to the gate bits.

Fixes: 5690879d93e8 ("clk: sunxi-ng: Add A23 CCU")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index a4fa2945f230..4b5f8f4e4ab8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -144,7 +144,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_mipi_clk, "pll-mipi",
 				    8, 4,		/* N */
 				    4, 2,		/* K */
 				    0, 4,		/* M */
-				    BIT(31),		/* gate */
+				    BIT(31) | BIT(23) | BIT(22), /* gate */
 				    BIT(28),		/* lock */
 				    CLK_SET_RATE_UNGATE);
 
-- 
2.20.1

