Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C912078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgE0Nk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:40:57 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgE0Nk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:40:56 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MxHLs-1ipQ2O23r6-00xZeZ; Wed, 27 May 2020 15:40:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: versatile: undo some dependency changes
Date:   Wed, 27 May 2020 15:40:33 +0200
Message-Id: <20200527134043.807045-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oX8d96/3agk6HQYMnHtVprdFalOQlNymeCToneAXooVriuWLRR+
 c/h+AwhIj6fC9vUzuz5Aa2eLCM3DNnwR+1QROcwAEUOdv4Lulkj+kNPH+g7+VS00QAnl+gr
 c/dD0CTtn4iEhMxVhrytOTGK3BdJav61Y5VWmm06MbbfbRJF+wr0RM02TJCmEuNKu6GocqM
 fVPA8dCdLvlOl5QyMJoIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8aMReIkVdqU=:yhFX2lu64OasDPFeHhky3H
 IC/WFCqnWvNVHYf5ttpwJsFmp8RmKdFCdbWyOd18oY93TMgMHBSi8BG4PNcmAcoOCzQbTAjVe
 2n0FO4gp/b8z0cbzciNh1NhDV0DzamUtNPfAS8PAhkfrmKZw8elLwnUZMZOT7mBFEkOgGvNzZ
 ThhEgJyTv2JKI3sgBiQKIbZb8GRfvZJ3uGyje0aDEnZvabf/qwD8lcTjl9Ke1tA3R3Uli1pIv
 YoMV4J4lZrUpvBNy8Hszb8VvYzzsmcfUTxRdAdpHfd6a6WiVtbzPYQCTCu0UYPfSgoXCDkm6k
 Bl9xZ1P2tqJTpSTlI7fKnvmoU/cyRIE/E3ra0bIx1xIbMaptle12QYTc16RCVzmhe62aBMJ7J
 Ml2ZBk2UrFyq8fbq0BoH6b/xnigNotBVskzXNTlpg+GA5iAgAVBC468xVXlMixGq51OsYx4ur
 ikKJLzdpwjh+l5Ci1t7KLGorX51y2xm09nP3NGro/PAOMBUOC8JaaVCUxTy5QkjoWIveWwXfv
 f4Vh12dELsS0OTHvouycvZJ7B8ti+36fqacZ///KhnekwVAtgGhn4/3MJCplRbvNIPV9c8jfG
 pAmlZjnk/57dsb0vHyc7IO4OW+Lm6F8ZoFYg6K+W66eZNwPy269MjncCjaCFa2B7xl+/Ys+ug
 +mW0eawTP/R9H0IE7cOoAfPolwNq2bevSAywLpxhuuU/cgovHRbYKgMBRInSn2LkLb7YkIoPU
 L7z0bsXHv515uZ0R8FsS5miYtqW8nxOfNOvXXjBtw9udx3Qz5UiemItenrFyhRpLkCQzgja/D
 vToTOthP83fSoshZtvzcCxjjx3RTDLF3cS67SJ6JCc5FYsPm2E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SP810 and ICST are selected by a couple of platforms, most but
not all in the versatile family:

WARNING: unmet direct dependencies detected for CLK_SP810
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_VERSATILE [=n]
  Selected by [y]:
  - ARCH_REALVIEW [=y] && (ARCH_MULTI_V5 [=n] || ARCH_MULTI_V6 [=n] ||
ARCH_MULTI_V7 [=y])

WARNING: unmet direct dependencies detected for ICST
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_VERSATILE [=n]
  Selected by [y]:
  - ARCH_REALVIEW [=y] && (ARCH_MULTI_V5 [=n] || ARCH_MULTI_V6 [=n] || ARCH_MULTI_V7 [=y])
  - ARCH_VEXPRESS [=y] && ARCH_MULTI_V7 [=y]
  - ARCH_ZYNQ [=y] && ARCH_MULTI_V7 [=y]

Change back the Kconfig logic to allow these to be selected
without the main option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/versatile/Kconfig | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index a0ed412e8396..a557886d813e 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -7,6 +7,18 @@ menuconfig COMMON_CLK_VERSATILE
 
 if COMMON_CLK_VERSATILE
 
+config CLK_VEXPRESS_OSC
+	tristate "Clock driver for Versatile Express OSC clock generators"
+	depends on VEXPRESS_CONFIG
+	select REGMAP_MMIO
+	default y if ARCH_VEXPRESS
+	---help---
+	  Simple regmap-based driver driving clock generators on Versatile
+	  Express platforms hidden behind its configuration infrastructure,
+	  commonly known as OSCs.
+
+endif
+
 config ICST
 	bool "Clock driver for ARM Reference designs ICST"
 	select REGMAP_MMIO
@@ -22,14 +34,4 @@ config CLK_SP810
 	  Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
 	  of the ARM SP810 System Controller cell.
 
-config CLK_VEXPRESS_OSC
-	tristate "Clock driver for Versatile Express OSC clock generators"
-	depends on VEXPRESS_CONFIG
-	select REGMAP_MMIO
-	default y if ARCH_VEXPRESS
-	---help---
-	  Simple regmap-based driver driving clock generators on Versatile
-	  Express platforms hidden behind its configuration infrastructure,
-	  commonly known as OSCs.
 
-endif
-- 
2.26.2

