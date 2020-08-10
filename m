Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971B720709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHJMW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:22:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgHJMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:22:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 19CC2293517
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: exynos: clear prefetch bits in default l2c_aux_val
Date:   Mon, 10 Aug 2020 13:22:08 +0100
Message-Id: <e44b5226f3ad1551459830c678ed183762d8e458.1597061474.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the L310_AUX_CTRL_DATA_PREFETCH and L310_AUX_CTRL_INSTR_PREFETCH
bits in the l2c_aux_val defaults for Exynos since they can now be set
using the standard l2c2x0 devicetree bindings.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---

Notes:
    v2: split patch to only clear exynos platform register bits

 arch/arm/mach-exynos/exynos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a96f3353a0c1..0e906cc3a48e 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,8 +193,8 @@ static void __init exynos_dt_fixup(void)
 }
 
 DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
-	.l2c_aux_val	= 0x38400000,
-	.l2c_aux_mask	= 0xc60fffff,
+	.l2c_aux_val	= 0x08400000,
+	.l2c_aux_mask	= 0xf60fffff,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
-- 
2.20.1

