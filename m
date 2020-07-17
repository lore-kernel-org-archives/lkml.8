Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA8C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACE720704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e2TCPjdS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nvmJnYh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgGQHwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:52:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGQHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594972321; x=1626508321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mZRvrjllQRoFuvmEwXVD7b3H+yaSCILAy+4PQ0axU3w=;
  b=e2TCPjdS0eF24tHo6tYO64UdntVlGGzoaP+ibvmqhMGTOSFXrhqmYolr
   woO04B7lNtRp+s54DVZFmxtHNo71P04YyGcTRVjVHJhScsRvE1U7JthE+
   RIjL/3qomegvxLnGTpqJDBLNo2dvJPkta0exWYfRKy/oteRLYRyj5vfhf
   rUL3wnJ2Oo2BeqdsjdC1fL8VLVcLWCkrk8eQnMfnnn3KQ8kfOvIKkauDo
   TmU879y4Cg1wlFBk4JwueLRRP4qqPoGPkJ5qAdw+BjwfrZ5eVquuNMQkI
   oQWIPJZhnENKU2Xk3OqyYuDrO+Q9gAuCv5S5g3rJpxrwmtnTa1ygBEiO2
   w==;
IronPort-SDR: kF3qV5FzxOubYaQObgdqSMGWvFtxV9y35tjh6+THAyRFSE+wX4D7gWtKnxRkNkBtindr3N4DCt
 RSTme3WKyt+xG1bU0GrZESyT+YAD6aQzhWBgQkNeZOMuwUw7jcJ4HtFoWc8ijafo4QsAp55yfS
 6/8wt7Mf8ZVfLNb6dWWVZWejKOdmY9wfjSfDrnFQ7w+CBQahuB4fzX3SzQINr1xn4953H6MnIM
 5RYKyw8sQewSdN6A3ar9j9n7l484c7Ja+qplnxZDQZkL7e/SWDxh7RW1tZuCBJaLW1W2tAWiem
 ZgM=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="142816155"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eljxtIc4Ig1Tg+A7CmgGa7PRnKBHny9nnvowitq2BIF1LVBihufFsq0LOD9GtytWmOzSjKo2y77Wq7wF7mzp2PdrNnNfOU2bUeXQhJRXH3EBzjJc066CkWmBNaqA8aI6eqeAvlDM8h32riCVqhqKnbGHUcoTDmp6UuKUD60JdQFnbDQOjnj3znSGUee3Cbr3LvZId60tZWJisVAYqFsquvBtrh+rat03JHDfAXfBbI52YSZb3xPftqHWhUXKjnlGrvgg5MwbQ2VCs5OqDj8Rqyj8gkF5BQW2KDe+EtdhYOhcR2rBgVLcTHxug5uJz3Am3VyAbOTHdo/ziSMcU3bAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBn3FBa3XktQxd4d3KRS9mqwJTAQXdET4arNhpVAfw4=;
 b=NlBwv+uOrxZXQRphU3PLs70vZ4mLlbey4+ms8cURA/eCkweNnIckvhKu0BZw2TBDX9uw4BQ/l1kKGwrAXwb5l+8eC7sKhAxe2eI8bwAH+skUoGoiUDJnc0CgXe7ft2SC5ccBH/k4zd40CFyyB6++KEWJi06/SULSP/Zt1BXxgxXBEug63u06ABhnaofYiKGvqtX0JGdwFjIWQWwKx3gAR2mPF2uOTcLxoYRJFId5vIbR/AJqC0TnGR6OgpxM32v6cseISlpWC27ilIq3ozxQJ2dksit9EC6jYRgcTPsNZMi1KF7aV1mQaF1SUlYU/YtFRY7FTPzbT8Cb6BlvPYDF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBn3FBa3XktQxd4d3KRS9mqwJTAQXdET4arNhpVAfw4=;
 b=nvmJnYh747lqYNKGDKm2kZTjl1rnSVVyilUpGxofo7PwpuBKNNfJ8KsBLK5M9Sb0QV5yKN+1FKC0Q5Yh+TudXfvxAFYAzySrxnKV/4PeH90IJWp1Yno5mIFs8TveMZzc57elYpvt3TpeB3ddU7qWfYGPtgWFTLHSvBgXZKGSpbw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 07:51:58 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:51:58 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berhing <kernel@esmil.dk>
Subject: [PATCH v4 3/4] RISC-V: Remove CLINT related code from timer and arch
Date:   Fri, 17 Jul 2020 13:21:00 +0530
Message-Id: <20200717075101.263332-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717075101.263332-1-anup.patel@wdc.com>
References: <20200717075101.263332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.182.72) by BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 07:51:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.182.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa1bf483-fb64-4262-a595-08d82a26486f
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6331ECB96320E452ABDED8448D7C0@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LIFBubT2BU54Sy3Uv1LDFDcFOGeCQetZxTyFgf5HO0UIgtp2gGvXIFSeH28iHSc3e99OHt8x88TJSk97xJyZMFSYzPLlz5BgyWKUDPSdf2nWBD4pGWVT4RE1bBx9rHWwWcUCmoSpl9skZiwkR7d1Bj6S2IVpo/QohAam7Xu9JzEUZdDu7XUqssRjZL2PEGsBzxzPWuB6+IMtu9Nac1/5dtpDUAwAZZVPdhbrjI1NidSooQgG3/cXt/32uaiAfkc/H7lJy8+sQsYIfr4JmlEq7FfCJItWa4xj2Gq3de+MDsrjmOY1TC3s43QeLdlUmVPAE5KflgluRGQd3u5nxXUQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8886007)(8936002)(66946007)(83380400001)(66476007)(66556008)(1076003)(4326008)(5660300002)(86362001)(36756003)(44832011)(316002)(186003)(110136005)(7416002)(54906003)(478600001)(2616005)(956004)(8676002)(6666004)(26005)(7696005)(55016002)(16526019)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BFXu8k94Ifjf1QVh6GhIsmSVNv9D+p/PPBKzLnOmxRIj2baMt6SaP5C4WtTz+lx6oCXY6LKbAD4rcK/MDJjMr7EQynfcv9sjsXQFVCZx0ZBMceqaC42d1KCqy84he/I958DU+lR289lyJEcmo0SMOq5Kkh3e+haq2OAGrGP6UOmgSI7xXQZbIXmzUvdt4z4Xyr9CGZrno9qSp6kKL0Rtp9b+0vQ4e5SdJ8262AYvViPPcY4MnLkHXR+RF5+G2LS7IfZAdk1kybPCW1QzPiza9hDFqo/xqEATFUUs6xUKlhFRebYEb8qlz1MEMdDDUKPygIA/SIoC1xom62fKQIyWWHDpFrZEnxWNP2LT6lMLl4LSGriPdPKvnbH2VqF3KpuSeP+bbSqjViyKkNRi4kl2odMwt2lbFF0ZuoPf8J2I3vOZK84iq+cgOp2Y9DY2hpozp3U+EgvnAJxd1qC5RKO49zFGvjAckmjmbAjKeUEZea0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1bf483-fb64-4262-a595-08d82a26486f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:51:58.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXnmvOZ+6zZpXuZ1LOwA4Fq1Lv+Lfd1LPfpG+aB3DjRLl+cl/sOyLOMMXCOZbyNzxlrFZb3f0idKhHfykw5Log==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the RISC-V timer driver is convoluted to support:
1. Linux RISC-V S-mode (with MMU) where it will use TIME CSR for
   clocksource and SBI timer calls for clockevent device.
2. Linux RISC-V M-mode (without MMU) where it will use CLINT MMIO
   counter register for clocksource and CLINT MMIO compare register
   for clockevent device.

We now have a separate CLINT timer driver which also provide CLINT
based IPI operations so let's remove CLINT MMIO related code from
arch/riscv directory and RISC-V timer driver.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Emil Renner Berhing <kernel@esmil.dk>
---
 arch/riscv/Kconfig                      |  2 +-
 arch/riscv/Kconfig.socs                 |  2 +
 arch/riscv/configs/nommu_virt_defconfig |  7 +--
 arch/riscv/include/asm/clint.h          | 14 ------
 arch/riscv/include/asm/timex.h          | 28 +++--------
 arch/riscv/kernel/Makefile              |  2 +-
 arch/riscv/kernel/clint.c               | 63 -------------------------
 arch/riscv/kernel/setup.c               |  2 -
 arch/riscv/kernel/smp.c                 |  1 -
 arch/riscv/kernel/smpboot.c             |  1 -
 drivers/clocksource/Kconfig             |  2 +-
 drivers/clocksource/timer-riscv.c       | 17 +------
 12 files changed, 16 insertions(+), 125 deletions(-)
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fedb4a72b29a..57a72ae23d10 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -74,7 +74,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_INTC
-	select RISCV_TIMER
+	select RISCV_TIMER if RISCV_SBI
 	select SPARSEMEM_STATIC if 32BIT
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6c88148f1b9b..8a55f6156661 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -12,6 +12,7 @@ config SOC_SIFIVE
 
 config SOC_VIRT
 	bool "QEMU Virt Machine"
+	select CLINT_TIMER if RISCV_M_MODE
 	select POWER_RESET
 	select POWER_RESET_SYSCON
 	select POWER_RESET_SYSCON_POWEROFF
@@ -24,6 +25,7 @@ config SOC_VIRT
 config SOC_KENDRYTE
 	bool "Kendryte K210 SoC"
 	depends on !MMU
+	select CLINT_TIMER if RISCV_M_MODE
 	select SERIAL_SIFIVE if TTY
 	select SERIAL_SIFIVE_CONSOLE if TTY
 	select SIFIVE_PLIC
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index cf74e179bf90..cf9388184aa3 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -26,6 +26,7 @@ CONFIG_EXPERT=y
 CONFIG_SLOB=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
+CONFIG_SOC_VIRT=y
 CONFIG_MAXPHYSMEM_2GB=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
@@ -48,7 +49,6 @@ CONFIG_VIRTIO_BLK=y
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_LDISC_AUTOLOAD is not set
-# CONFIG_DEVMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -56,16 +56,13 @@ CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+# CONFIG_DEVMEM is not set
 # CONFIG_HWMON is not set
-# CONFIG_LCD_CLASS_DEVICE is not set
-# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
 # CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
-CONFIG_SIFIVE_PLIC=y
-# CONFIG_VALIDATE_FS_PARSER is not set
 CONFIG_EXT2_FS=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
deleted file mode 100644
index adaba98a7d6c..000000000000
--- a/arch/riscv/include/asm/clint.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_RISCV_CLINT_H
-#define _ASM_RISCV_CLINT_H 1
-
-#include <linux/io.h>
-#include <linux/smp.h>
-
-#ifdef CONFIG_RISCV_M_MODE
-void clint_init_boot_cpu(void);
-#else /* CONFIG_RISCV_M_MODE */
-#define clint_init_boot_cpu()	do { } while (0)
-#endif /* CONFIG_RISCV_M_MODE */
-
-#endif /* _ASM_RISCV_CLINT_H */
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index bad2a7c2cda5..a3fb85d505d4 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -7,41 +7,27 @@
 #define _ASM_RISCV_TIMEX_H
 
 #include <asm/csr.h>
-#include <asm/mmio.h>
 
 typedef unsigned long cycles_t;
 
-extern u64 __iomem *riscv_time_val;
-extern u64 __iomem *riscv_time_cmp;
-
-#ifdef CONFIG_64BIT
-#define mmio_get_cycles()	readq_relaxed(riscv_time_val)
-#else
-#define mmio_get_cycles()	readl_relaxed(riscv_time_val)
-#define mmio_get_cycles_hi()	readl_relaxed(((u32 *)riscv_time_val) + 1)
-#endif
-
 static inline cycles_t get_cycles(void)
 {
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		return csr_read(CSR_TIME);
-	return mmio_get_cycles();
+	return csr_read(CSR_TIME);
 }
 #define get_cycles get_cycles
 
+static inline u32 get_cycles_hi(void)
+{
+	return csr_read(CSR_TIMEH);
+}
+#define get_cycles_hi get_cycles_hi
+
 #ifdef CONFIG_64BIT
 static inline u64 get_cycles64(void)
 {
 	return get_cycles();
 }
 #else /* CONFIG_64BIT */
-static inline u32 get_cycles_hi(void)
-{
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		return csr_read(CSR_TIMEH);
-	return mmio_get_cycles_hi();
-}
-
 static inline u64 get_cycles64(void)
 {
 	u32 hi, lo;
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index b355cf485671..7edf15643146 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -31,7 +31,7 @@ obj-y	+= cacheinfo.o
 obj-y	+= patch.o
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
-obj-$(CONFIG_RISCV_M_MODE)	+= clint.o traps_misaligned.o
+obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
deleted file mode 100644
index a9845ee023e2..000000000000
--- a/arch/riscv/kernel/clint.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2019 Christoph Hellwig.
- */
-
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-#include <asm/clint.h>
-#include <asm/csr.h>
-#include <asm/timex.h>
-
-/*
- * This is the layout used by the SiFive clint, which is also shared by the qemu
- * virt platform, and the Kendryte KD210 at least.
- */
-#define CLINT_IPI_OFF		0
-#define CLINT_TIME_CMP_OFF	0x4000
-#define CLINT_TIME_VAL_OFF	0xbff8
-
-u32 __iomem *clint_ipi_base;
-
-static void clint_send_ipi(const struct cpumask *target)
-{
-	unsigned int cpu;
-
-	for_each_cpu(cpu, target)
-		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
-}
-
-static void clint_clear_ipi(void)
-{
-	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
-}
-
-static struct riscv_ipi_ops clint_ipi_ops = {
-	.ipi_inject = clint_send_ipi,
-	.ipi_clear = clint_clear_ipi,
-};
-
-void clint_init_boot_cpu(void)
-{
-	struct device_node *np;
-	void __iomem *base;
-
-	np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
-	if (!np) {
-		panic("clint not found");
-		return;
-	}
-
-	base = of_iomap(np, 0);
-	if (!base)
-		panic("could not map CLINT");
-
-	clint_ipi_base = base + CLINT_IPI_OFF;
-	riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
-	riscv_time_val = base + CLINT_TIME_VAL_OFF;
-
-	clint_clear_ipi();
-	riscv_set_ipi_ops(&clint_ipi_ops);
-}
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f04373be54a6..2c6dd329312b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -18,7 +18,6 @@
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
 
-#include <asm/clint.h>
 #include <asm/cpu_ops.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -79,7 +78,6 @@ void __init setup_arch(char **cmdline_p)
 #else
 	unflatten_device_tree();
 #endif
-	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8b85683ce203..07626be78c23 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 
-#include <asm/clint.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 5fe849791bf0..a6cfa9842d4b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
-#include <asm/clint.h>
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e1ce0d510a03..2e7c4b8387ae 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -649,7 +649,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
-	depends on GENERIC_SCHED_CLOCK && RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV_SBI
 	default y
 	select TIMER_PROBE
 	select TIMER_OF
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 9de1dabfb126..c51c5ed15aa7 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -19,26 +19,13 @@
 #include <linux/of_irq.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
-
-u64 __iomem *riscv_time_cmp;
-u64 __iomem *riscv_time_val;
-
-static inline void mmio_set_timer(u64 val)
-{
-	void __iomem *r;
-
-	r = riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id());
-	writeq_relaxed(val, r);
-}
+#include <asm/timex.h>
 
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
 	csr_set(CSR_IE, IE_TIE);
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
-		sbi_set_timer(get_cycles64() + delta);
-	else
-		mmio_set_timer(get_cycles64() + delta);
+	sbi_set_timer(get_cycles64() + delta);
 	return 0;
 }
 
-- 
2.25.1

