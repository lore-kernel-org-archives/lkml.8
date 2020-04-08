Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgDHQBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:01:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbgDHQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:01:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MnqbU-1iyNtW0WDK-00pLyR; Wed, 08 Apr 2020 18:00:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     catalin.marinas@arm.com, will@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, chunyan.zhang@unisoc.com
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [RFC] clk: sprd: fix compile-testing
Date:   Wed,  8 Apr 2020 18:00:44 +0200
Message-Id: <20200408160044.2550437-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J6BJpZg6tGsBXqhtv/w/5/oW9Rnzup92xQ0SjE2vxeldApZgQj9
 QjIHkGAG9aQIQmH9wpdSxYOE8QHIrmRca7klY5BYRWNRjv+M/rvK7ySHuCj78C/tBmbdtvC
 FS3jMKblE2ms/X1TDRHMo8xVheCVUPLzBh57wOq6D1AkTFaAVPQ9YI/CwhmuU7H1O+zlmTr
 FkuoYSJHEbhujCgRBWFNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5QNQCaQT/k=:DSU4RMPmXjdaZVRs5KjWyf
 1YJwTvHrV2NqGLbVw5DcrdAOeBpKGdP6kedqM9Wcaeq5NLG7tK6HzfyMRmn4e2DO4uiAdYU3R
 HT1hK+gqGMHIpgm60ILZCLXhXQhKTrq4SIy/C4C0UcUx28SjA+UJ3oQDNb/0Rzn3LRCj1w4Lv
 5h/cj50kjyCi2pMrd1Ll3x/1kXvKVaL2gi2/35dLlUQUF4bK7N9Sn+Y17zq2NzFvaXlP6X0aU
 PWieHwNI70NWitkFoOHjnjMq7UK70LlkWfFaIJJwg8fQu4FBTn2WJPl3RAGGB9v7NzHy9Fv6a
 AhZMFMbARBMtfvxO+k6A9Rb+x+uFTuQSgvkWXUV5zjpIPLQXRQhGYskWtFbZCg+jc4xGJ1wld
 ukvUrn4CNR25sIC48g19/lvgF0bnnYKQdHwofRfYybe41F5X+pERcRR2bXz6BK7Aw2OBt8nhB
 qQOpQm3lwdYvfJWe3+9r0MiUlTu9uIyTO2i20UF611jY8g1FyH0q/fwjSsXDpowRZF86/1gsG
 mFiR8/iocQl4wH1y/PAocYHiVwTFSGx4x5aF/HnQUxAPzqB5JRppW/AsAKdofh2xrN5iN0Zwu
 e3zo0yvYEuaSowf22S9SnFRNPotXKcFz7R/5Wx/0HrnYK5Ly805H7MkqnrRRbZ5K59JjTA6k/
 WlBveSvQ8dpe0mEs7CFRr4CfXpEDzssdl7afxlBI3krwXX5ieaCeap7im2BZH7vYWz4yJeqb+
 VLIklPNdmo1cVMamOWG+bWw+Rf6UxN6N9VGIFhpUgfZwF2k6RnQcvgquIRqeKfVlxfJTZGkVX
 on5K/cARIyGjlSCw3WWM2LPwOt1GjCCPYEwSK9Y1jC3JaNZFoM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.26.0

