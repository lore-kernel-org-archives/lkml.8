Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A92DC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519B520748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="crQvtBdM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sXIcvihK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgGXHTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:19:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65207 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595575148; x=1627111148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VeLtr9yfJz0rzSBocup5BVELwI4/Z5ngFUTfsHjO6aM=;
  b=crQvtBdMFKiz/XZBYc8niz3cxSZqitZAAyyZRVL+Lw7IX7YotOALfbaz
   yqP+gcCNCyEutCybjRskLzxxUHzoktmito/DSMbYHAI2Fu/rHb3aIJws7
   xGcBxLYumqTheMrXum/Ce6k+Qw0HNfwCjO9SH4w1ZGorZkFmcNsj+ln2r
   qAkz1IEQXGGTSa97WJiT6KjRTbePr1f7jNOePe8gy93ri00C+0dOgTigG
   803kpAMdFabMmCrbfIvoxH4yqBftdHpgTln9rBbDhwkbrVrrzSZEDQdi4
   EbhXHnHfj1xyCcLfXjJFAe5xZrOshmrIut2UamVo71k+Btw+PAJUdkuDM
   A==;
IronPort-SDR: RAReh8Rr1M9pp8oplThSpjOSr9icV1JKT6sTwxY5h/VA25mhUUcLxIKYQCvUUAm8dqrMAenVMB
 QuGlH0di3ochVyBASVNDx8nRw2vQwezUMx/Dw+tMxOmvKMn5bevTjQuBYj4fZO0W/N2sQINGvP
 FmXF1Q3+wJ6dE9C9ajqeH21G2k2UYoV2v5M9BJleGMbanhEQAgSp8+zflYX1bDjjJdzSp5lBNv
 n6dWLCIudOyFEjp8z1/FaaogTHlkdCQyT1urMR6oGYYW5Bt1iAMNSLg+NIqCakhEm/9zNCI/OA
 FX8=
X-IronPort-AV: E=Sophos;i="5.75,389,1589212800"; 
   d="scan'208";a="246341046"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 15:19:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHCefrHarCZFVP0XA0CCyA9MF+28FoEL87+BPYVJVXcHir6d0TAxvZ0crWy/rdAhqWduvQ/rc3EvO9eB0swRB2+aPACClsI+tD1diUooQb2ntmWLvxjfflKym25BwzpfoPadp5zW14CnFyk9VNlDpJScnjn30pKcSBY6SNsKqhLDvpGpWZQTrawhupFfx+F8rkBMOmEii5zbsbIe+rkto+In/SkQ//E8T1kz8/uLrKJ4qvjABIXg7TO5BN//d7QRaO2ZZ5WjUWAabSkTzMGIzBl0k40/9YgWuxWM3f52RKy1Q3SprducBc3BXbhkgjVrka0T2d0lX4wZ+DuqPp5wDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Mar8wp8DiY0nJxWZhfQsF7cp15xRLPKkOquDOQ4fA=;
 b=AenMLUob4OS+VdVAJMjjdL8YYBkyPjsX9GtQygRYUnZ5luiZEMRaUZBv4TEjBP3MKcoSTjnt6iU3SFz0A1OHQhZRKJmbXypA8Atyo7TBRmpJ94lRfpxpMOXIeC/lhMkFl+qHqJuSJfvJCIHiZThc3kWoSykTV4cCt07VhDEAWtOwnp22YcW91/0h4QWLkTgp9T4IOjoIajbhJwRMWBf91gfag7MMLM4geLI2GDVHUdrVfSZ+meQ4LlNyk4kszma/CsLkOCGVFktpkk3U0HP9MOpF3XhVcHoOpqk7Ab5DadSq+yMlEFUaAcPDrdSam5wnFZAA54gOJU/pPv1kQephXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4Mar8wp8DiY0nJxWZhfQsF7cp15xRLPKkOquDOQ4fA=;
 b=sXIcvihK5n5aVZJ0Egl1tO1dx9GAJklQXLJCRA96GzKj+0QxbsJkn4OoCybVIcsnPvLLUxGWceRp3n9U4tlJzkLjMPyGP1UE8iSOck3tgsaD86kvm1U7A/Cm4H9mpQZ/soxmd2G3aCDiO6uyeZdeK09hG1NbkEKKVXekBgodNwQ=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5131.namprd04.prod.outlook.com (2603:10b6:5:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:19:05 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 07:19:05 +0000
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
Subject: [PATCH v6 3/4] RISC-V: Remove CLINT related code from timer and arch
Date:   Fri, 24 Jul 2020 12:48:21 +0530
Message-Id: <20200724071822.126758-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724071822.126758-1-anup.patel@wdc.com>
References: <20200724071822.126758-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.20.29.132) by BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 07:18:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.20.29.132]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3828d5cf-0b1b-4a1e-0623-08d82fa1d8b9
X-MS-TrafficTypeDiagnostic: DM6PR04MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB51310EDF75C6D5C5E15C05178D770@DM6PR04MB5131.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qbz0CqimJcKqzpJRtJmgENhPuYwdcaBlWoxyreEF3DqemnKq905XMv7UElP35OeZ9mvze4ohoyn7Kwq7aSOMzcTHtL8yez+KX45KfPRhSGhNpgBqtUBVzQaetMTW4404hwUBaUKFv6XIIckkUrSTuoPMktvzmKNgEITaQxInDpAQJK6fcbXGMcs0iAGzUrXe3B24F2qOllULXOVgaSNA595akOhBxr0N0cs2QPlGtIqEP4R+VjuvtZ4aeJbSB9d1zTtELluzz70jz2i5sJbH6cnbkpwWh3/9LawG400f4FE6Wk3e7WlPeOrt4yschZl5lE0T6Nr+34ktM4iXReZNjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(7416002)(55016002)(186003)(478600001)(2616005)(52116002)(26005)(956004)(7696005)(110136005)(66476007)(44832011)(36756003)(66946007)(83380400001)(1076003)(316002)(54906003)(6666004)(4326008)(16526019)(5660300002)(8936002)(66556008)(2906002)(8676002)(8886007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mMpogKYFP9Nu/PBu/12UXe1KFqcRJkSqikYExxGwGvLDDK4d3tLkZ9kpzN209jAF8GKHcl/C1ZAnbGOA349ByZwk55nsp4vEZHf0Doen+dWcCclgURMgMW+DE1+ClD8/T9MPl1TFXHeqnCvY4ylj6noZOCTPNcH1ft34kcShdg33Zpc9aVOdJnS8Us4nN9UBbb3CBWIkXulupoMZ+TT1Kid6jRLppPS0TcC1Er4NeKYGeLI7BtKsKPKB1ZIlNm4/mlKD/uGS+5EY0nuRraONQYdrK7xBaM3k+YZbBVn7iHxjedPuZXDEKGuL3uKlQrvo84UHOqgIiTr3rOifwX12166KbfZs3cplhxLi+VlHo3bxnKVpUU/Lq3UEC8IZYEq2US2LDEkfNFe+NeyRKAGyMWjzRIytV0ZWG17BFirMkgh3+w8+exUdkbnNcXgMo3OIVtJnX1s55Bm4YPzqzQeJaR0qYYXvQ3thelKedYIUbds=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828d5cf-0b1b-4a1e-0623-08d82fa1d8b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:19:04.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9GX/0HPAGXeHqaJmMn9+2Qaq3G3W5+o4d/G0wxCJNzLLzcW93i+XbnEzh3Disdl68zV3I5R7FhKJimTGL0USw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5131
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
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
 drivers/clocksource/Kconfig             |  3 +-
 drivers/clocksource/timer-riscv.c       | 17 +------
 12 files changed, 16 insertions(+), 126 deletions(-)
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
index 41f1c147c178..b24449da3022 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -648,9 +648,8 @@ config ATCPIT100_TIMER
 	  This option enables support for the Andestech ATCPIT100 timers.
 
 config RISCV_TIMER
-	bool "Timer for the RISC-V platform"
+	bool "Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
-	default y
 	select TIMER_PROBE
 	select TIMER_OF
 	help
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

