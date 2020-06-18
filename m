Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D8C21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442565;
	bh=oYIe6/U8JRWSGr/ppugOUsi7E32io1WeQ87L2V4PHIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMWNQmoRGHk8Hu6A9N8ArntTR6Al8ejkLaLBPrUM2cd9HzCn7CrB8XAHSqD91Eif8
	 fZb4IOam2Lp6h/ftUdzqVXu5XEnktGLHgHio70gb6TrE4RkxUC+VRNUUCH9lfnxTbr
	 ti5rXtTdDNyXYWexGwXc/F+zKTdNTRMX11dDaTho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgFRBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgFRBJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA07F21974;
        Thu, 18 Jun 2020 01:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442557;
        bh=oYIe6/U8JRWSGr/ppugOUsi7E32io1WeQ87L2V4PHIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4SEtCX7Q3KiDsG4s+fe04YPbMu8K2cfwY0Zzrff6iaeo9f9C56sVyoYUM1cbCWou
         hQbYojvZhZjcW+3QlNRXbizA84rHp8VnBii0qdAXWfS6dX95G+E9kPxYqlv1t6/Xsw
         RKQIP1nqzyaYyZeJfyXBoMoKVcBqGiUchbKIRmE4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 054/388] clk: renesas: cpg-mssr: Fix STBCR suspend/resume handling
Date:   Wed, 17 Jun 2020 21:02:31 -0400
Message-Id: <20200618010805.600873-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
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
index a2663fbbd7a5..d6a53c99b114 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -812,7 +812,8 @@ static int cpg_mssr_suspend_noirq(struct device *dev)
 	/* Save module registers with bits under our control */
 	for (reg = 0; reg < ARRAY_SIZE(priv->smstpcr_saved); reg++) {
 		if (priv->smstpcr_saved[reg].mask)
-			priv->smstpcr_saved[reg].val =
+			priv->smstpcr_saved[reg].val = priv->stbyctrl ?
+				readb(priv->base + STBCR(reg)) :
 				readl(priv->base + SMSTPCR(reg));
 	}
 
@@ -872,8 +873,9 @@ static int cpg_mssr_resume_noirq(struct device *dev)
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

