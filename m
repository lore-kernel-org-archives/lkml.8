Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D82C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDD7206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGGJWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:22:49 -0400
Received: from mail.loongson.cn ([114.242.206.163]:51160 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgGGJWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:22:48 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxL+jcPgRfsi9RAA--.921S2;
        Tue, 07 Jul 2020 17:22:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: allwinner: Make PHY_SUN6I_MIPI_DPHY depend on COMMON_CLK
Date:   Tue,  7 Jul 2020 17:22:26 +0800
Message-Id: <1594113746-25393-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxL+jcPgRfsi9RAA--.921S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17ur4UKF1DXF4xWFWfKrg_yoW8Cr1xpa
        yfGrW8uryrtFWYqFsrJrykuFZaganrXFyxGaykGa43ZF98Aa1j93s8CFyqkF4jvr4kJr4f
        Gas5GFZIgF98t37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0nXo5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ARCH_SUNXI is not set but CONFIG_COMPILE_TEST=y,
CONFIG_HAVE_CLK=y, CONFIG_HAVE_LEGACY_CLK=y, there exists
the following build errors with CONFIG_PHY_SUN6I_MIPI_DPHY=y:

drivers/phy/allwinner/phy-sun6i-mipi-dphy.o: In function `sun6i_dphy_init':
phy-sun6i-mipi-dphy.c:(.text+0x320): undefined reference to `clk_set_rate_exclusive'
drivers/phy/allwinner/phy-sun6i-mipi-dphy.o: In function `sun6i_dphy_exit':
phy-sun6i-mipi-dphy.c:(.text+0x2c8): undefined reference to `clk_rate_exclusive_put'

clk_set_rate_exclusive() and clk_rate_exclusive_put() are defined
in drivers/clk/clk.c, this file is built under CONFIG_COMMON_CLK,
so in order to build drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
successful used with various configs, CONFIG_PHY_SUN6I_MIPI_DPHY
should depend on CONFIG_COMMON_CLK.

Fixes: 133552bf03ed ("phy: Remove CONFIG_ARCH_* check for related subdir in Makefile")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This patch is based on linux-phy.git:
https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/?h=next

 drivers/phy/allwinner/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index e760d89..fb584518 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -22,7 +22,7 @@ config PHY_SUN4I_USB
 config PHY_SUN6I_MIPI_DPHY
 	tristate "Allwinner A31 MIPI D-PHY Support"
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && COMMON_CLK
 	depends on RESET_CONTROLLER
 	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
-- 
2.1.0

