Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA2C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C92071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgDAQIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:08:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59950 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgDAQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:08:48 -0400
Received: from submarine.cbg.collabora.co.uk (unknown [IPv6:2a00:5f00:102:0:b4e9:caff:feac:d8b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8BF942974E8;
        Wed,  1 Apr 2020 17:08:46 +0100 (BST)
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] ARM: exynos: update l2c_aux_mask to fix alert message
Date:   Wed,  1 Apr 2020 17:08:03 +0100
Message-Id: <b29f34870380093e6268c11d3033033d6def61b7.1585756648.git.guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow setting the number of cycles for RAM reads in the pl310 cache
controller L2 auxiliary control register mask (bits 0-2) since it
needs to be changed in software.  This only affects exynos4210 and
exynos4412 as they use the pl310 cache controller.

With the mask used until now, the following warnings were generated,
the 2nd one being a pr_alert():

  L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
  L2C: platform provided aux values permit register corruption.

This latency cycles value has always been set in software in spite of
the warnings.  Keep it this way but clear the alert message about
register corruption to acknowledge it is a valid thing to do.

Tested on exynos4412-odroid-x2.

Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
---
 arch/arm/mach-exynos/exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 7a8d1555db40..ed1bba49210d 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -194,7 +194,7 @@ static void __init exynos_dt_fixup(void)
 
 DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
 	.l2c_aux_val	= 0x3c400001,
-	.l2c_aux_mask	= 0xc20fffff,
+	.l2c_aux_mask	= 0xc20ffff8,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos_init_io,
 	.init_early	= exynos_firmware_init,
-- 
2.20.1

