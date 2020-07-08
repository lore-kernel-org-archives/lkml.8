Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C82EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3414120739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGHSyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:54:32 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:16811 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgGHSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:54:31 -0400
X-IronPort-AV: E=Sophos;i="5.75,328,1589209200"; 
   d="scan'208";a="51643897"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jul 2020 03:54:30 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C28BC40CC766;
        Thu,  9 Jul 2020 03:54:28 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: defconfig: Enable R-Car PCIe endpoint driver
Date:   Wed,  8 Jul 2020 19:53:43 +0100
Message-Id: <1594234423-30914-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable R-Car PCIe endpoint driver on RZ/G2E board, including enabling
endpoint configurations CONFIG_PCI_ENDPOINT, CONFIG_PCI_ENDPOINT_CONFIGFS,
CONFIG_PCI_EPF_TEST and CONFIG_PCI_ENDPOINT_TEST required to use and test
the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 This patch is re-based on https://patchwork.kernel.org/patch/11549899/
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e578650..7cfeb0a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -196,6 +196,7 @@ CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
+CONFIG_PCIE_RCAR_EP=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCIE_ALTERA=y
@@ -212,6 +213,9 @@ CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
 CONFIG_PCIE_TEGRA194_HOST=m
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
@@ -242,6 +246,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
+CONFIG_PCI_ENDPOINT_TEST=y
 CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_AT25=m
 CONFIG_UACCE=m
-- 
2.7.4

