Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F94C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FA620776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448491;
	bh=ihHrUJsOCew8oKzpD6uj34VNb3wBjlV3dDlrBrZhBnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkH+21CBD5rmwRaAjc1fya3knT4DHEn1xZui71NiwBXl/SaTaXVBQ18n53i1dRGy2
	 DNQuBt2q3dduKmOEu41s7U+0YjQmMsTI//SFnEbwe3yTa58ZWm0Albx56eC1XNDd/p
	 X7bTcZTQmpHA31CNiKCpemvebq2DAyJSU9+mcTvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFRBKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbgFRBKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E132221EA;
        Thu, 18 Jun 2020 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442603;
        bh=ihHrUJsOCew8oKzpD6uj34VNb3wBjlV3dDlrBrZhBnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEiYq+8LGen4idONssMiAplT1dl7YRgXqF1hCzlmixiAyPUr2hqIUwfOz9Zt2h1Ro
         H1dgX5JG9GK3QtGVF7mS5HmQSzghzkytHEiAX/hG0tVMKpXpk6GmonbOsvG+7yyLjW
         l4c97cgzeIvbzfQXKpn98g8LBMmB7eGeSsBAML70=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 089/388] clk: sprd: fix compile-testing
Date:   Wed, 17 Jun 2020 21:03:06 -0400
Message-Id: <20200618010805.600873-89-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b5f73d47f34b238221ac771b5fe4907df621d7cb ]

I got a build failure with CONFIG_ARCH_SPRD=m when the
main portion of the clock driver failed to get linked into
the kernel:

ERROR: modpost: "sprd_pll_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_comp_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_clk_probe" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9863a-clk.ko] undefined!
ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!
ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9860-clk.ko] undefined!

This is a combination of two trivial bugs:

- A platform should not be 'tristate', it should be a 'bool' symbol
  like the other platforms, if only for consistency, and to avoid
  surprises like this one.

- The clk Makefile does not traverse into the sprd subdirectory
  if the platform is disabled but the drivers are enabled for
  compile-testing.

Fixing either of the two would be sufficient to address the link failure,
but for correctness, both need to be changed.

Fixes: 2b1b799d7630 ("arm64: change ARCH_SPRD Kconfig to tristate")
Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
Acked-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig.platforms | 2 +-
 drivers/clk/Makefile         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cfe0f9e..3c7e310fd8bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -248,7 +248,7 @@ config ARCH_TEGRA
 	  This enables support for the NVIDIA Tegra SoC family.
 
 config ARCH_SPRD
-	tristate "Spreadtrum SoC platform"
+	bool "Spreadtrum SoC platform"
 	help
 	  Support for Spreadtrum ARM based SoCs
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc2fd31..60e811d3f226 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
-obj-$(CONFIG_ARCH_SPRD)			+= sprd/
+obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
-- 
2.25.1

