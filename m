Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4215206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876784;
	bh=/L54vVnnNVCgLi+l/otzPqeZ9ozHFoiiQUcEnjPcDwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUTRc3urEgePW2/65CA7tr6A56DMjjFRR3AfUcRkynVAyKUNUBTUeC8f0gLBvMW2r
	 2YksshtKDlDkShNWQxv59Id+Rnnu/RqEHVkagFza7o7couTXM50tWrCANRGrxXtEU/
	 ubtpjvR7IqDVnZZ3mTG2v6RKlOXY9HlsY8IsXiEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390677AbgAXOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390527AbgAXOSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6112087E;
        Fri, 24 Jan 2020 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875504;
        bh=/L54vVnnNVCgLi+l/otzPqeZ9ozHFoiiQUcEnjPcDwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BR15FaAWgs/x8d3vN5Eqvk4gHLF7i06aRuyaOGRgpfGAIMHAFRQ2fElmSZxzLyoAW
         XG+LApijnUc3bn7MxVbs2daen77pAUhIL0G01K5MRPTXCG23ejuVIhkrqc3JPgbZBo
         HfgUNO8o4y/PnjPvKx/cxU0MKE8loPJj5AHK7Hs8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 006/107] ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap
Date:   Fri, 24 Jan 2020 09:16:36 -0500
Message-Id: <20200124141817.28793-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 90bdfa0b05e3cc809a7c1aa3b1f162b46ea1b330 ]

We must bail out early if the clock is not hw_omap. Otherwise we will
try to access invalid address with hwclk->clkdm_name:

Unable to handle kernel paging request at virtual address ffffffff
Internal error: Oops: 27 [#1] ARM
...
(strcmp) from [<c011b348>] (clkdm_lookup+0x40/0x60)
[<c011b348>] (clkdm_lookup) from [<c011cb84>] (ti_sysc_clkdm_init+0x5c/0x64)
[<c011cb84>] (ti_sysc_clkdm_init) from [<c03680a8>] (sysc_probe+0x948/0x117c)
[<c03680a8>] (sysc_probe) from [<c03d0af4>] (platform_drv_probe+0x48/0x98)
...

Fixes: 2b2f7def058a ("bus: ti-sysc: Add support for missing clockdomain handling")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 1b7cf81ff0356..33688e1d9acf9 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -368,10 +368,14 @@ static void __init dra7x_evm_mmc_quirk(void)
 
 static struct clockdomain *ti_sysc_find_one_clockdomain(struct clk *clk)
 {
+	struct clk_hw *hw = __clk_get_hw(clk);
 	struct clockdomain *clkdm = NULL;
 	struct clk_hw_omap *hwclk;
 
-	hwclk = to_clk_hw_omap(__clk_get_hw(clk));
+	hwclk = to_clk_hw_omap(hw);
+	if (!omap2_clk_is_hw_omap(hw))
+		return NULL;
+
 	if (hwclk && hwclk->clkdm_name)
 		clkdm = clkdm_lookup(hwclk->clkdm_name);
 
-- 
2.20.1

