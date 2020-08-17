Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D584DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57232072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CnJgCh0g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TV2e2qp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgHQMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:43:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44398 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgHQMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597668214; x=1629204214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=z+x1tF2BXQuSLi85DARGyfQGxFOuHh5fk0iKsZbFyHI=;
  b=CnJgCh0g5CrFsxfa1QZNsYRrS+ES1LticjCtnmyaBuHVz45OS4FYjjw+
   V/u90XPGb4gBl9XcCuWc8qkYxwB61+OK7yCUUpzYUKL2kx+qL07odldNJ
   J7PbvPpFrVCHHh5OhgTEGnUJucFbVznrN6NteCI7lb7akzpkhVGNhfcVo
   ak+Bxn7Jfwf/JD8LFEsv2IrvaFTIDAGE6QcXWLQi4TcGLFk4cR/QCkYOx
   yktS7d9GNOLfaXwSjkxoN5hjobYi/huVXjx8TROyoY3sMn4gqCS3NeUcj
   WiB6jowRDqfe1QwDYYuu+A54nYuGthswcDSGgih/filioX3LzxzF4G+Cg
   A==;
IronPort-SDR: 14xLYnXm87KWtjxH5K9bP0ods55xLeVw01ACJTzZeo/AVwO8sjtxq+qCr7wDq4hcbXW0vM62C8
 P5LZT66kyuElv0pCWU8f5Yzhq+Qh0bLpHlJSUsYz9KtqJS7cflL8vgHIU6KtYabtkoD7B+iYbW
 92Zf1BGMhoAm2mdOOuryfbQUPpemYquMHmRANtZ4dpPl9m7g3SvjNivCyPJSBK/TXFfRfw1G9x
 svc4cdzKF1q8GRQhe+fzaqn0TFkyIliCixxa60CQsVq/H+ocjQK2BnfKoV/YBSXuemYsjea+R9
 UEY=
X-IronPort-AV: E=Sophos;i="5.76,322,1592841600"; 
   d="scan'208";a="145088391"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2020 20:43:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2VgKHkYzsvn56JywBGan07fX04G1vCWz5vOLqmKhwY/umCDze2LHAfrmMgi8fKsqWylDNNoXQaOiq1NjgDntnQRPlvnVlyLLjBOM64XRioqetXa9YS23SdDc6lhAi+cFX9oyGLt6UinBLbGu04xZYjlSsoWUyowrN6t6afq3LHoYfx5zbugWicg5Q2R/If5PXCoDQIv/3+3voQSPiHgbGijN6p89Av6A9EubrLkvLLPqc7ivRUck/qhE7hXzErz8MDwfrhSvMGQ/jNwWgo/UWmEwb6sGs8zyGPM6QPVWZ+o7T7/qfTtJQbAZrCFbscS8SWtzRvPyaGaOLBXIKZ/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOusikDnZLWR7q5bChECqxR1biXG2Ic/2XDUrb5+bi4=;
 b=M1mGM95EW5nT+iZnzqnPSYeGP3VlOofkgjAbbrqJO/Cxm4nt+EarGWswKWRe1pmhMpNfzkMAJXir+Bigd4wGCbnzCwE5ayuAFEK7J5tnF24Ti9RD29uKbhzBGtLCFkDw2DM1bI47s2O+ycNhBz/bNQxAzJojGRYpdQ5VVItt6QmlTLMsjhfZfOGK5fN6MQ7RQ+Ei488tciRfo7vw8ArpCRNLoB3O4+YBPZVAEms/MgyiEznB6/PunbqANL2ij8nh9tX+xlz54/Hmta8OMg7yINXpkwBqXsYpPwfapPoO+gee0enggZK7JoAB2JWMzT7lqVfa6xnl33fenqQzF4rDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOusikDnZLWR7q5bChECqxR1biXG2Ic/2XDUrb5+bi4=;
 b=TV2e2qp/fAIkiihBI9ez8gXYPNqjIB5QslQRKfJz8ipgjtVbi5vPCqNfL7g/qA5GjkzwlmVUprr5j+ktGTRO6cKiYUWo5NeSZSgBj2rhcMIFN61RQO1VW2ayoEAN15QlcE+BYzTZmpgLRn3F61JfrmZCL44j/NTtjUGiFl7FA7I=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB3865.namprd04.prod.outlook.com (2603:10b6:5:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 12:43:30 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 12:43:30 +0000
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
        Emil Renner Berhing <kernel@esmil.dk>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v7 3/4] RISC-V: Remove CLINT related code from timer and arch
Date:   Mon, 17 Aug 2020 18:12:50 +0530
Message-Id: <20200817124251.508183-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817124251.508183-1-anup.patel@wdc.com>
References: <20200817124251.508183-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.59.21) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 12:43:25 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.59.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bece1ef2-8680-48be-976c-08d842ab251e
X-MS-TrafficTypeDiagnostic: DM6PR04MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB38658C552AC4B784D59A74488D5F0@DM6PR04MB3865.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JRymj90efqnB+nbzBtOqjSNpnfV5vEAJi8qRBEi3zQcATlqrmiuk+39WovOzm5NPiTPPHA9J9ehcLD0FJBOVr/q+qoleq07iRaiP5JzQv7+DvonUUe4q/NPfO3+2iMJ3pX3HUJOkMTRsWHQRo5ct0/TWYGbJHs8gsHId4fzOn7P0zj35lpGF7Uuc1XW2Nqs/a6ny8zWSCEVeLvACV2aVQMmxcUxDZ1aOWwWWDuOZjgLc13pA6ItcPzZd5+ilMXUbWQ1Rvl3LY0TKN6ivMCszu7VWAQmsgGWWxrFF76SEDhZNf6XKOQGqFP84jkxfesRNyZ10Ieo5rfLtIyr4hDF/NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(36756003)(7416002)(52116002)(6666004)(66946007)(55016002)(2906002)(54906003)(83380400001)(110136005)(5660300002)(478600001)(7696005)(66556008)(66476007)(1076003)(4326008)(8886007)(186003)(16526019)(44832011)(8676002)(956004)(26005)(8936002)(86362001)(316002)(30864003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: eKSqq9XB7JqNEGnjfGUd8YLzp1voSyqzuKmS3GvtRuJLK88FwK/Tu9NTIMbFQT0qI+1ZeBp4hVQ+ifXW7q80qcN1ZXfqlGbAYNYlKy079T/3kUUkDI5xGKqzPkPRLI81Avnasp9SJ0lLU0QDK+WXNnwJU10VjYrymOrDOTfyTLQn7sIX+ByGmbAiwpv3Z66j6nXnxuel70Vz+pf7FkQsFt4YG9kwObiZxI3wM/DbRapU0jnE8kWejEd4l0bBw3gsTCy3cAhVHpR89XmsTuq5OfWmNmlK9bzgF+7oNqf1SnFDR3y+WsSgcdbELG1z3d/6beo5dQf/vWJZFLt4+kKNI+CoNSEZZfKoG7n3FwAALpkY4loWm+3HK2VJ6CnqodBzq9xutxxZ02JmTdGWAx9aWXojKcgw2b2RLEsjp2+jAlp9ZMAEzGBkL4DnkH2dN3clQzWYJbJyhcUpqvu9/ZjLou8ag0iQa31+DDQYJARV5mR+PcqX1eGbs573ut0cHp7+YqOUdBCF+jiOawONRioaJZrhFA7jJ+DhlC+yRGxc99erDsviF9wIAoCp5owJ2rfEhMfuvO7rAx6jxpjO77mfaLsv5CFEKz2EpszU3VbZNA+K1ejdZYNPQgVZ0ytSO7e5BUqtVVqTTJJrPthivBIsfQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bece1ef2-8680-48be-976c-08d842ab251e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 12:43:30.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0svMNYKSqFvZevTnydEPVzSKVKzPTgVm+Q07YBRcHegboEEretGjEHDY5I1jSs7AoY2QDuceQA4oZLu7yWViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3865
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
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
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
index 520bf04cf04b..a8f20141f506 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -82,7 +82,7 @@ config RISCV
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
index f27596e9663e..e046a0babde4 100644
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
@@ -49,7 +50,6 @@ CONFIG_VIRTIO_BLK=y
 # CONFIG_SERIO is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_LDISC_AUTOLOAD is not set
-# CONFIG_DEVMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
@@ -57,16 +57,13 @@ CONFIG_SERIAL_8250_NR_UARTS=1
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
index a5287ab9f7f2..dc93710f0b2f 100644
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
index cf9acb43604c..ea028d9e0d24 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/irq_work.h>
 
-#include <asm/clint.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 12033d71ba0c..96167d55ed98 100644
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
index d95cc7234a66..68b087bff59c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -653,9 +653,8 @@ config ATCPIT100_TIMER
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

