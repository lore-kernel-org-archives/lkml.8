Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ADB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgHZJdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:33:10 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:15396 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727956AbgHZJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:33:07 -0400
X-IronPort-AV: E=Sophos;i="5.76,355,1592838000"; 
   d="scan'208";a="55579352"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2020 18:33:05 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BEA6A400419A;
        Wed, 26 Aug 2020 18:33:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] ARM: shmobile: defconfig: enable CONFIG_PCIE_RCAR_HOST
Date:   Wed, 26 Aug 2020 10:32:20 +0100
Message-Id: <20200826093220.10266-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826093220.10266-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200826093220.10266-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

config option PCIE_RCAR internally selects PCIE_RCAR_HOST which builds the
same driver. So this patch renames CONFIG_PCIE_RCAR to
CONFIG_PCIE_RCAR_HOST so that PCIE_RCAR can be safely dropped from Kconfig
file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index bbedc42bb2d9..a49c90714e63 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -37,7 +37,7 @@ CONFIG_CAN_RCAR=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCIE_RCAR=y
+CONFIG_PCIE_RCAR_HOST=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SIMPLE_PM_BUS=y
-- 
2.17.1

