Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDDAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1620A206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201800;
	bh=XX4X6EpJrToEwjK3Fv9nagxPTDojAtDKIFRZMSV0bSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=du7GcUfYedizTRtly6kVk7O9e/w2uOaQ/umDn2s3loraZkWOzaX6jrziQuNMFPN2U
	 yfk0UY1o/P8ohY8zf4m0k8ZHszOSSYlyL2FdaBU6MTPiBZD/4QFW4InzG90wPRiAhw
	 CAyfzsF8tRPTGvD/O5rNFHcZ+CqiUNNvNeA7EQ4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406886AbgAPTJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387856AbgAPRAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F079422525;
        Thu, 16 Jan 2020 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194037;
        bh=XX4X6EpJrToEwjK3Fv9nagxPTDojAtDKIFRZMSV0bSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKgeloLCSxgn+DI+51VViBc9wBhLw7GPE+4j2BdzoxYDS0MaiekupReMtdOhBa6Eb
         IHXG+E3b0LINKbZDNKz+MXhlvpEY8TsXozET87dapblK4+7LyA3K8tsWQuOInmiKBm
         d8KFoZkx7vtPZ9Qbbfr9dPx+hYuFaLGfm94gRlnc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 155/671] clk: ingenic: jz4740: Fix gating of UDC clock
Date:   Thu, 16 Jan 2020 11:51:04 -0500
Message-Id: <20200116165940.10720-38-sashal@kernel.org>
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

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit b7e29924a1a628aec60d18651b493fa1601bf944 ]

The UDC clock is gated when the bit is cleared, not when it is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Fixes: 2b555a4b9cae ("clk: ingenic: Add missing flag for UDC clock")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ingenic/jz4740-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 4479c102e899..b86edd328249 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -165,7 +165,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
 		.mux = { CGU_REG_CPCCR, 29, 1 },
 		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
-		.gate = { CGU_REG_SCR, 6 },
+		.gate = { CGU_REG_SCR, 6, true },
 	},
 
 	/* Gate-only clocks */
-- 
2.20.1

