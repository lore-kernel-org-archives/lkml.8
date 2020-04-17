Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E966C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16D922247
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="VMv0txaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgDQW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:28:46 -0400
Received: from plaes.org ([188.166.43.21]:57482 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgDQW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:28:45 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:9d4d:940e:6b9e:3deb:4])
        by plaes.org (Postfix) with ESMTPSA id E48EC404A6;
        Fri, 17 Apr 2020 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587161871; bh=Et23DSQX+mYnPBoOaUK80Omdf6ErKOl84UqRoFglySE=;
        h=From:To:Cc:Subject:Date:From;
        b=VMv0txaDabnlDJtPEbe/qgBuhJXoBNCTYURXJYKEtGgcXzNxYwh0grJ/5uFNtWlDM
         Wmq4RGo2277lZ8nYq0Wlpb6ZWXL3Tmzi8knUm0ZwTrfZ+qXoKFqfHd01BnRnJbp9FL
         T130y4RuP7JUG0iqzwAzV6zhPmpzQW8805DTsNotayGIPj0e4B23jvu3Ex0lr+kIQ7
         SbEByUN4KXl9uhr+J+cGZcwjJzxdKCes1lvw9e5LQ9Pe998QxoPJABh6m2suAczpH3
         3ZgXqE9XkS8zINO1S4yPEUQcv7lPYixHVqJ/dE79tdgchxo6+jsUY8zNWU1ZIjFTaJ
         PSSF1sajUKRAg==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 0/4] ARM: sun7i: Convert A20 GMAC driver to CCU
Date:   Sat, 18 Apr 2020 01:17:26 +0300
Message-Id: <20200417221730.555954-1-plaes@plaes.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie converts Allwinner A20 (sun7i) GMAC driver to CCU
while still retaining compatibility with existing devicetrees.

First two patches contain preliminary work which convert
sun4i/sun7i clock drivers to platform devices and creates regmap
to access gmac register from the sun7i gmac driver.

Third patch implements syscon-based regmap to allow driver manage
its own clock source.

Fourth patch updates the devicetree and drops the unused clocks.

While testing the driver I noticed following bugs with the existing
sun7i gmac driver:
- driver relies on u-boot for initialization (fixed in this
  implementation)
- `systemctl restart networking` fails to bring the link up again.


Priit Laes (4):
  clk: sunxi-ng: a10/a20: rewrite init code to a platform driver
  clk: sunxi-ng: a20: export a regmap to access the GMAC register
  net: stmmac: dwmac-sunxi: Implement syscon-based clock handling
  ARM: dts: sun7i: Use syscon-based implementation for gmac

 arch/arm/boot/dts/sun7i-a20.dtsi              |  36 +----
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c          | 108 ++++++++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 124 ++++++++++++++++--
 3 files changed, 206 insertions(+), 62 deletions(-)

-- 
2.25.2

