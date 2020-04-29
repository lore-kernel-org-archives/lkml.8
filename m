Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D98CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8622137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="hk/9t7lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgD2Uqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:46:52 -0400
Received: from plaes.org ([188.166.43.21]:35014 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgD2Uqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:46:51 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id 8259C40020;
        Wed, 29 Apr 2020 20:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588193178; bh=Rqs4HjYcziWdoELVeMyrIuXF1YyfE34PXc+elobZQps=;
        h=From:To:Cc:Subject:Date:From;
        b=hk/9t7lgfmJHTxXPfraMm8glNpLJjruhcgVLxCg+WeYERuAqjqsEgY4SBIrC2UgJg
         aMqL3gounEr6LZcNMNSXqtMlkkHoka0CH+yG0F8G7OjCdYB1qMHbSrHIwhE28coN6e
         oskYJmr734Hd7fm+p3ih2cj4TuZLklnnpyRLPrIe6vXifYU0/7n1GWQtQRwLpJnFIj
         BV5pGrKa3BL8TKh10ZjEQO8jqT1gP+oRvbPLDi306XjHb1xgGs8mqHKrkD77ASJ/TC
         idigqFGCLqhCyJVFcsxU+kjR2xD/3H/D0DM4cVbjkQuWGlmmwOqfVO+BRUfT+7JsB8
         aH5uFMc4SarWw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 0/6] ARM: sunxi: Convert A20/A31 GMAC driver to use CCU
Date:   Wed, 29 Apr 2020 23:46:06 +0300
Message-Id: <20200429204612.31883-1-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie converts Allwinner A20 and A31 GMAC driver to CCU
while still retaining compatibility with existing devicetrees.

This patchset touches 3 areas:
- sun7i and sun6i CCUs now set up regmap to allow dwmac-sunxi driver
to properly access the GMAC clock register.
- dwmac-sunxi can now handle syscon-based clock register to handle
clock itself.
- sun7i and sun6i devicetrees are converted to use the new syscon-based
access.

Changes since v1:
* Use CLK_OF_DECLARE_DRIVER to make it possible to probe again and set up
regmap using platform device probe.
* Clarify the meaning of "legacy" in dwmac-sunxi driver.
* Make sure we don't mess with the RX/TX delay settings when updating
clock registers.
* Update devicetree bindings
* Add sun6i-A31 support. (not tested due to lack of hardware)

Priit Laes (6):
  clk: sunxi-ng: a20: Register regmap for sun7i CCU
  clk: sunxi-ng: a31: Register regmap for sun6i CCU
  net: stmmac: dwmac-sunxi: Implement syscon-based clock handling
  dt-bindings: net: sun7i-gmac: Add syscon support
  ARM: dts: sun7i: Use syscon-based implementation for gmac
  ARM: dts: sun6i: Use syscon-based implementation for gmac

 .../net/allwinner,sun7i-a20-gmac.yaml         |  15 +-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  35 +----
 arch/arm/boot/dts/sun7i-a20.dtsi              |  36 +----
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c          |  60 +++++++-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c          |  60 +++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 130 ++++++++++++++++--
 6 files changed, 258 insertions(+), 78 deletions(-)

-- 
2.26.2

