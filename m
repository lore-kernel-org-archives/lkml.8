Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569EC54E8B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C6124955
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgEKCRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:17:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729195AbgEKCRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:17:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1F80AF17779EC663B44;
        Mon, 11 May 2020 10:17:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 10:17:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 01/10] riscv: Fix unmet direct dependencies built based on SOC_VIRT
Date:   Mon, 11 May 2020 10:19:52 +0800
Message-ID: <20200511022001.179767-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
References: <20200511022001.179767-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unmet direct dependencies Warning and fix Kconfig indent.

WARNING: unmet direct dependencies detected for POWER_RESET_SYSCON
  Depends on [n]: POWER_RESET [=n] && OF [=y] && HAS_IOMEM [=y]
  Selected by [y]:
  - SOC_VIRT [=y]

WARNING: unmet direct dependencies detected for POWER_RESET_SYSCON_POWEROFF
  Depends on [n]: POWER_RESET [=n] && OF [=y] && HAS_IOMEM [=y]
  Selected by [y]:
  - SOC_VIRT [=y]

WARNING: unmet direct dependencies detected for RTC_DRV_GOLDFISH
  Depends on [n]: RTC_CLASS [=n] && OF [=y] && HAS_IOMEM [=y] && (GOLDFISH [=y] || COMPILE_TEST [=n])
  Selected by [y]:
  - SOC_VIRT [=y]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/Kconfig.socs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 4b2303ca20b9..6c88148f1b9b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -11,14 +11,15 @@ config SOC_SIFIVE
 	  This enables support for SiFive SoC platform hardware.
 
 config SOC_VIRT
-       bool "QEMU Virt Machine"
-       select POWER_RESET_SYSCON
-       select POWER_RESET_SYSCON_POWEROFF
-       select GOLDFISH
-       select RTC_DRV_GOLDFISH
-       select SIFIVE_PLIC
-       help
-         This enables support for QEMU Virt Machine.
+	bool "QEMU Virt Machine"
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	select POWER_RESET_SYSCON_POWEROFF
+	select GOLDFISH
+	select RTC_DRV_GOLDFISH if RTC_CLASS
+	select SIFIVE_PLIC
+	help
+	  This enables support for QEMU Virt Machine.
 
 config SOC_KENDRYTE
 	bool "Kendryte K210 SoC"
-- 
2.26.2

