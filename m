Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6031820826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgESCeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:34:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:61471 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgESCeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:34:07 -0400
IronPort-SDR: Opvm5Wwrd/XRZm9rataGI/YdIueIqovSMIfnyZC51sqCn/MqlrisaHqAbPptCSHggPTKukKR2Z
 /NTwxiQkDwIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 19:34:07 -0700
IronPort-SDR: vBHg2K0Ij2/0m7cbktpV+07Wf8bS0P9BYbDn0MTSAjaZA6RBlUW2gDRxBlSIpRRXihgkAI/Y6v
 Ivtl+csvlhEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="299428957"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2020 19:34:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jas4y-0001jy-4b; Tue, 19 May 2020 10:34:04 +0800
Date:   Tue, 19 May 2020 10:33:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>, linux-clk@vger.kernel.org
Subject: [RFC PATCH linus] clk: sprd: lpll_gate can be static
Message-ID: <20200519023332.GA61191@e6e5adba6cbc>
References: <202005191007.Gr8sypTM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005191007.Gr8sypTM%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 0e4b8a2349f3 ("clk: sprd: add clocks support for SC9863A")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 sc9863a-clk.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
index 2e2dfb2d48fff..446a44d8744ab 100644
--- a/drivers/clk/sprd/sc9863a-clk.c
+++ b/drivers/clk/sprd/sc9863a-clk.c
@@ -27,7 +27,7 @@ SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll0_gate, "mpll0-gate", "ext-26m", 0x94,
 			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
 SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll0_gate, "dpll0-gate", "ext-26m", 0x98,
 			     0x1000, BIT(0), 0, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(lpll_gate, "lpll-gate", "ext-26m", 0x9c,
 			     0x1000, BIT(0), 0, 0, 240);
 SPRD_PLL_SC_GATE_CLK_FW_NAME(gpll_gate, "gpll-gate", "ext-26m", 0xa8,
 			     0x1000, BIT(0), 0, 0, 240);
@@ -35,9 +35,9 @@ SPRD_PLL_SC_GATE_CLK_FW_NAME(dpll1_gate, "dpll1-gate", "ext-26m", 0x1dc,
 			     0x1000, BIT(0), 0, 0, 240);
 SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll1_gate, "mpll1-gate", "ext-26m", 0x1e0,
 			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(mpll2_gate, "mpll2-gate", "ext-26m", 0x1e4,
 			     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0, 240);
-SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m", 0x1e8,
+static SPRD_PLL_SC_GATE_CLK_FW_NAME(isppll_gate, "isppll-gate", "ext-26m", 0x1e8,
 			     0x1000, BIT(0), 0, 0, 240);
 
 static struct sprd_clk_common *sc9863a_pmu_gate_clks[] = {
