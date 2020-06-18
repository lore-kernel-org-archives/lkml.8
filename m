Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4107421534
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447128;
	bh=H0tB5CLrfqC4eBdg95LLl8Ih+5nTvZlXEJaOMCsV8F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UeYokIBOXlcMiDNmaTN4xxSa4QDKMnGNeuATFmhTuTP8qr4F+TP9BM1wVQIaggySw
	 iVlkJHTU3sPaetMxr4tXLROvY/giSNEWVNOLL/8BPuBqq6lkUlM2cSN78BSPUdj0i6
	 qUeCvsXAPoCRmi+vqg6/cOvGRyb6Md+XWi1mQ00I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbgFRCZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgFRBRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BC521D82;
        Thu, 18 Jun 2020 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443045;
        bh=H0tB5CLrfqC4eBdg95LLl8Ih+5nTvZlXEJaOMCsV8F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSvDpf4rPnr6DoLl5/EXNZPsP30zWnOavNMwKSENWWklvisRGjv6EDJgFUxiuAPst
         yZ/KzJL9mSkMG6hTJwSc1Oh+oufwJ2qA2BAbdZyu1U9cOa4lAWpl2fLMT4Q8SNU7bM
         U+JS/DPs5f1Ijq3j5dHBCCOIDop36hKBm8n7/aXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 040/266] clk: renesas: cpg-mssr: Fix STBCR suspend/resume handling
Date:   Wed, 17 Jun 2020 21:12:45 -0400
Message-Id: <20200618011631.604574-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ace342097768e35fd41934285604fa97da1e235a ]

On SoCs with Standby Control Registers (STBCRs) instead of Module Stop
Control Registers (MSTPCRs), the suspend handler saves the wrong
registers, and the resume handler prints the wrong register in an error
message.

Fortunately this cannot happen yet, as the suspend/resume code is used
on PSCI systems only, and systems with STBCRs (RZ/A1 and RZ/A2) do not
use PSCI.  Still, it is better to fix this, to avoid this becoming a
problem in the future.

Distinguish between STBCRs and MSTPCRs where needed.  Replace the
useless printing of the virtual register address in the resume error
message by printing the register index.

Fixes: fde35c9c7db5732c ("clk: renesas: cpg-mssr: Add R7S9210 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200507074713.30113-1-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 132cc96895e3..6f9612c169af 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -800,7 +800,8 @@ static int cpg_mssr_suspend_noirq(struct device *dev)
 	/* Save module registers with bits under our control */
 	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
 		if (priv->smstpcr_saved[reg].mask)
-			priv->smstpcr_saved[reg].val =
+			priv->smstpcr_saved[reg].val = priv->stbyctrl ?
+				readb(priv->base + STBCR(reg)) :
 				readl(priv->base + SMSTPCR(reg));
 	}
 
@@ -860,8 +861,9 @@ static int cpg_mssr_resume_noirq(struct device *dev)
 		}
 
 		if (!i)
-			dev_warn(dev, "Failed to enable SMSTP %p[0x%x]\n",
-				 priv->base + SMSTPCR(reg), oldval & mask);
+			dev_warn(dev, "Failed to enable %s%u[0x%x]\n",
+				 priv->stbyctrl ? "STB" : "SMSTP", reg,
+				 oldval & mask);
 	}
 
 	return 0;
-- 
2.25.1

