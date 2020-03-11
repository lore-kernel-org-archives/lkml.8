Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB414C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E56E20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jzc8Slbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgCKNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:41:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50464 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729345AbgCKNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:41:20 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3383643B13;
        Wed, 11 Mar 2020 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583934080; bh=Jsae6YmAanO4z9FCcsjbrAEHTLrNXGOZPwk43q6ik60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzc8SlbhBKj3TbiyL2YRoFTe5fhXmG1Z0VAoSeJbljwzo/7pZuO533oHLT1M8RNoZ
         TABbi9Pza/pL5Y2fJpzD6/cH5X8yaBSI+NJ1e/8P8bFUvLVoQvTmUzwA3KlRfhzc/7
         7zSLlza3k2qtD15FVKjXgigCzRH+gOoCDHg5Z42yg7TXRJc68nDVAUHhg5FBzJBnOA
         qVQ6Li/zeCIlTIhKaZrL4gQn4itl3tNz9DS8HX+rld77XFmNfKyqPC3rZzocq7bdu0
         W89agejxYGrlH/bmhkip6R8VOvaS1zOU9iMqXzCz5asMeX/gQWGAIVrtKMbk44LX49
         8CzvI7N1QzUWg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5A381A0062;
        Wed, 11 Mar 2020 13:41:18 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/3] CLK: HSDK: CGU: check if PLL is bypassed first
Date:   Wed, 11 Mar 2020 16:41:13 +0300
Message-Id: <20200311134115.13257-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
References: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PLL is bypassed the EN (enable) bit has no effect on
output clock.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/clk/clk-hsdk-pll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index 97d1e8c35b71..b47a559f3528 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -172,14 +172,14 @@ static unsigned long hsdk_pll_recalc_rate(struct clk_hw *hw,
 
 	dev_dbg(clk->dev, "current configuration: %#x\n", val);
 
-	/* Check if PLL is disabled */
-	if (val & CGU_PLL_CTRL_PD)
-		return 0;
-
 	/* Check if PLL is bypassed */
 	if (val & CGU_PLL_CTRL_BYPASS)
 		return parent_rate;
 
+	/* Check if PLL is disabled */
+	if (val & CGU_PLL_CTRL_PD)
+		return 0;
+
 	/* input divider = reg.idiv + 1 */
 	idiv = 1 + ((val & CGU_PLL_CTRL_IDIV_MASK) >> CGU_PLL_CTRL_IDIV_SHIFT);
 	/* fb divider = 2*(reg.fbdiv + 1) */
-- 
2.21.1

