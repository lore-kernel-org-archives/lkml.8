Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8A5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A864120729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595880330;
	bh=WyhugnpU9g4nQhQO5azNbcxmB+fGzCazlet9mhbPuQ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hWu5UZ58LrLW5u6HPHBObxmBcgMxC87QArys52jjPouRV3pJLbOKPSKudRMHSg4sT
	 /wr5YXIXn+z+qCw7aLGdzK0IfIpg52b1BDFrue1OM0Zb7IPASlgVaci3cSsm8+aYQA
	 4jc37quS/3nKPJAZGWK++YTx1Lw8/gak7U7zRa/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgG0UF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgG0UF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:05:29 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7844620759;
        Mon, 27 Jul 2020 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595880329;
        bh=WyhugnpU9g4nQhQO5azNbcxmB+fGzCazlet9mhbPuQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=CTIagBMHfZOzuF0kT9g34XYuLttGszaF2eIKVR0wGOC3q9pkd0kwUrEEGfWJNXaNd
         +ecGwBvCwh5K9zGeUUQv9bV4vYMacwQsJPLjePkU1LqgqjWv3NjAfMg41x2sA5dHtN
         Qzh1Bhw2Q4uA4viGeydkOUrmO939tbWQETYPQpzM=
Date:   Mon, 27 Jul 2020 15:11:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] clk: davinci: Use fallthrough pseudo-keyword
Message-ID: <20200727201122.GA2593@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/davinci/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 8a23d5dfd1f8..6c35e4bb7940 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -651,7 +651,7 @@ static int davinci_pll_sysclk_rate_change(struct notifier_block *nb,
 		pllcmd = readl(pll->base + PLLCMD);
 		pllcmd |= PLLCMD_GOSET;
 		writel(pllcmd, pll->base + PLLCMD);
-		/* fallthrough */
+		fallthrough;
 	case PRE_RATE_CHANGE:
 		/* Wait until for outstanding changes to take effect */
 		do {
-- 
2.27.0

