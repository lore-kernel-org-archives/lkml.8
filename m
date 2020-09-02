Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1EB7207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599061128;
	bh=UMnXX4q58kDVi44f6XjnbJSc5MxuQI9RrANTFCpqSeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nwHTW4ueakXavlfNcWBvI5L6nj0SSfJYf47oZ9H8sl+U1B/L18yVybc1hw+RCRmdG
	 +CiVX1YGVrhiJ9Go5gJyZ6Pwl8r40Zv8N7cRxoP165NYNWKPsBErumaCMUpwlb/CP0
	 lAgF9A/vshDENCLng1lXiT9NPK3PYmENU/2P3ShQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgIBPij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgIBPDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:03:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EB720FC3;
        Wed,  2 Sep 2020 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599058981;
        bh=UMnXX4q58kDVi44f6XjnbJSc5MxuQI9RrANTFCpqSeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIJS7ypxYbb8CkyLaBmkbZgIUh3Qg6PcJeEqzWkQzf86l8eapKoXGfPaB1+Q86/wZ
         e/ayYCjXghzzCPykCM0y9B8nkpQnyMqQe+CcFT7tTPbZlJzDohsuM1rDk3kqb7nK8L
         3gvlbcpAURhkfqz4e6GShhbLsWlJJ7JwABZTwn6o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] clk: imx: Fix and update kerneldoc
Date:   Wed,  2 Sep 2020 17:02:44 +0200
Message-Id: <20200902150244.14347-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150244.14347-1-krzk@kernel.org>
References: <20200902150244.14347-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix and add missing kerneldoc to fix compile warnings like:

  drivers/clk/imx/clk-pfd.c:27: warning: Function parameter or member 'hw' not described in 'clk_pfd'
  drivers/clk/imx/clk-pllv3.c:53: warning: Function parameter or member 'ref_clock' not described in 'clk_pllv3'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/imx/clk-pfd.c   | 2 +-
 drivers/clk/imx/clk-pfdv2.c | 2 +-
 drivers/clk/imx/clk-pllv3.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index 50b7c30296f7..5d2a9a3be95e 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -12,7 +12,7 @@
 
 /**
  * struct clk_pfd - IMX PFD clock
- * @clk_hw:	clock source
+ * @hw:		clock source
  * @reg:	PFD register address
  * @idx:	the index of PFD encoded in the register
  *
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index 78e1f7641aaa..6b744c84278e 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -17,7 +17,7 @@
 
 /**
  * struct clk_pfdv2 - IMX PFD clock
- * @clk_hw:	clock source
+ * @hw:		clock source
  * @reg:	PFD register address
  * @gate_bit:	Gate bit offset
  * @vld_bit:	Valid bit offset
diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index b20cdea3e9cc..20ee9611ba6e 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -30,12 +30,15 @@
 
 /**
  * struct clk_pllv3 - IMX PLL clock version 3
- * @clk_hw:	 clock source
+ * @hw:		clock source
  * @base:	 base address of PLL registers
  * @power_bit:	 pll power bit mask
  * @powerup_set: set power_bit to power up the PLL
  * @div_mask:	 mask of divider bits
  * @div_shift:	 shift of divider bits
+ * @ref_clock:	reference clock rate
+ * @num_offset:	num register offset
+ * @denom_offset: denom register offset
  *
  * IMX PLL clock version 3, found on i.MX6 series.  Divider for pllv3
  * is actually a multiplier, and always sits at bit 0.
-- 
2.17.1

