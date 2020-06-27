Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D376C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22C320720
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PQPZqndM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qH9ds7Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgF0QVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:21:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2369 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgF0QVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593274869; x=1624810869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jq8OZC/qNaPDOKTBBbvsdje42SrIxjjmquuMy5UtPg8=;
  b=PQPZqndMDrITqKO/ADQt48LT8XTUFkGMTjJvVFxqd90x1ISFZdpcAnbb
   Riut1U1EO1yNTgZDsTmBB+6SpW1fLgi8D26Vd+yCG2yHqN08xqlkGmCsM
   Lw8RzkJpJaQMmEVLX4wnpBE7F3ucnFGH8h0Ne7w+U+V1oWE15gq8JGDTg
   UEZzfTzKG1DP3Pcw9v84Q61MKD1LmsZv7ZglIz37/Lf7/pPrZ8SCETeRr
   wnQg4Bai3udpPEUSNGsV462/a0miNFFvEON//mMaWjo8RKmXJg/1vE3oH
   3IrnHikmJFXDHv5JAMHkvbb6ozugVTdtKEJmMx/kvXKmAX4DTcZCP6qhv
   A==;
IronPort-SDR: n8kzBNjsl7R8Pu4Ruu9a2EtnJWeS9xRl+SLtBzrjH+I3jCVp/QiGQCvfPx1fMc3/qFrIfvVpg6
 3B+8Eqar3WTAL73nbPpKpOZGzc06ho/qbMuMXXqfo3hnSyhOFK7PUopLI3T1QdkbjTSNeoUZzY
 lzDGKFIjeFt7Wou5kt/qjdo+FHzH+fuuY0Zs9GtT+zcnmsTWz8y3xx9vjAHnrM9Xgm/C7c+NSM
 zxdx5qIUR1orF9EVOkBf9XVtqHICZMTbf50mU6FDzo2uI7VJwx1of57X2i7lR4dy/T993/B+OZ
 qWg=
X-IronPort-AV: E=Sophos;i="5.75,287,1589212800"; 
   d="scan'208";a="141074513"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2020 00:21:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkZjIG9nwknjH+Ms3v15FcW/kWSxi4lPmnqFpnA+8ua7+KZ+FTJHRsfiMf1s8bxG0sHkBKy99IhWfn9PCBk2mgR1duwAn699uF4LHm7CRHmPvgpYEK5qDMJF1g74Ih0x95L+W3GVhibJP+5JpX4Gi01b0pvtUQ29sjAQp/DJt3iA1f5K3M7sw3PRFSAUbDscwZ+T42WhbyjK7564C4Q8HeEVma7xGXoYb8RgkiagOYp5BZkY7qDG3o4Os9RkfoMPZxC3uvq5OmDAQtCXW5SVSEuS8IHL+zq4Kg531omC8HNV2Y2Hh9EOcpu/g/BNQezHEPtcayh1xM0NV+MLq40MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enisWsoZRJOGUukHnQB8wG4W6soNBsIKAk3NlwbqZbE=;
 b=n3iGW3t3vK0bWpD/bpGQdsQSDifg6kbyepcnsX1ljSe7U+Tcpni4ap50T3Lni6XZlUCALFzVIWfBZuPCvs4Y+gYI+lbp8thwJwva+cZUR6Wo3d/ZiPQ+5U3+SFLs8CMEch5Meh8lNa8T1xxejupNqIAskrcMOLKwzCifpyDxOVgCbAJ4PVBuEYkJrBDXhCKrG56K3rg21fq8HsFnPgVdQDRkxkVBXuYXMi/b4yDrdCWJuuMx+EgituVFdrKmzCiX0+dpXhf0gOIemo06qJM25K6Xj0tHV4Dw1PAsbZ7Ra3ACDdxEJdRklE1FtNnl/0HqISmNWmPgJX6epQKghanAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enisWsoZRJOGUukHnQB8wG4W6soNBsIKAk3NlwbqZbE=;
 b=qH9ds7ReiahqqRB6czkJc4to+jEPh7R+f8Y0IKLwWhIck3zWQyYNEGAXa11HJR2LHOdac7sgIJZS/lzg2G0ltznvfjmO0GGpDmteq2IUGmYV5oVOry6Z9GcyQKA8uyCOliGY95dd932fD1RsCJzEPNWUvGh9mYdXLZlnKTuAaY0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32)
 by MN2PR04MB5725.namprd04.prod.outlook.com (2603:10b6:208:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Sat, 27 Jun
 2020 16:21:07 +0000
Received: from MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580]) by MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580%7]) with mapi id 15.20.3131.026; Sat, 27 Jun 2020
 16:21:07 +0000
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
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v2 3/5] clocksource/drivers/timer-riscv: Remove MMIO related stuff
Date:   Sat, 27 Jun 2020 21:49:55 +0530
Message-Id: <20200627161957.134376-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627161957.134376-1-anup.patel@wdc.com>
References: <20200627161957.134376-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MN2PR04MB6207.namprd04.prod.outlook.com
 (2603:10b6:208:de::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (42.109.128.251) by MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Sat, 27 Jun 2020 16:20:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [42.109.128.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bdf45d5-1e4e-46a3-dad1-08d81ab61836
X-MS-TrafficTypeDiagnostic: MN2PR04MB5725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB572559C5FE0E9968611BD3398D900@MN2PR04MB5725.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0447DB1C71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fufIVF0GIyp1MrP6njnDGlWzU9NCvx4HaS5LUD5JmAEA5c8hdRjiVfXAiN5Eh1zn6iMw/z82Bt0yeM2Cr47pk5jcVThe2dWdQOFS3qCisRCXUN0gM+R45O/GHEavrdgTfPJHLNkdSsocYjcid0+VOkoj4IxVEbuqk87ynA8uPWr8AdJX/wfrxYS2zBhBLvrnKF/XLeExewqjnSmcUQDj0tv62+IleiSXFF8/baKhXn6+IctZE7wtUy5Q7Sq5/c/iy89Oi+qJ52rqC0FUk9pnGi+cG57CaJcac6X+77EXl3gPUCM5SPwJd3xCVsw2Imwv6HALsfVywGzPqvpOJEanPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6207.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(1076003)(8886007)(186003)(16526019)(52116002)(86362001)(55016002)(1006002)(36756003)(7696005)(66946007)(5660300002)(83380400001)(26005)(66556008)(66476007)(110136005)(2616005)(4326008)(54906003)(478600001)(44832011)(8676002)(8936002)(2906002)(316002)(7416002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AM9EEtQIlCEs4sZVB2a1vSrnOYEzvvBXY+s/TMPn4M46IPlj5y3IfI+JiYBAD/lfsFV6u+xpCNoSWCW/QAjHjlEulFnJtzW8Z7uuFfplcg/wz3yTipbrLrNknoLpNVtvpfzcRakKkfYy8dVC9jfYk3V+Mal5FO5QvHO8wCiZqypsTIAQlbIeueV7NqMC/bKIyv964kSgCGBjmxUtRWmxfrX7TR18fdEVL3kf8UeHEidusiuxjyVi4HOs0TNdJwQdVk3tUUt8BxP0qxE6qeaTiVxpxZHUL5Zf/mZfizDBUHrYr9pJVwOs1Owh5uS7q6Vx/wGl6vibWdZxXi2riY3nubD3gyz3GFMP6mlxmFIjCqveQLqWhcybQxjGkAPpBdgyyF+hKyDY9GwBHRVtAXJsGRVaxpqHh+dMljK2iCaki+o5H32wEH+RVX+rek1coQhj6xoaXI2RMWL7m3oRvnC9yia9ocqkrLtXAtpFMHa23JA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdf45d5-1e4e-46a3-dad1-08d81ab61836
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6207.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2020 16:21:07.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNtdOg2aaAMmXrPgQl2TZqimtENARRoR0qOD60bS4rdYehovGKz3+/WhoC3w4YuD/QS6Enl0e2q3wo1GYTel2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the RISC-V timer is convoluted to support:
1. Linux RISC-V S-mode (with MMU) where it will use TIME CSR
   for clocksource and SBI timer calls for clockevent device.
2. Linux RISC-V M-mode (without MMU) where it will use CLINT
   MMIO counter register for clocksource and CLINT MMIO compare
   register for clockevent device.

This patch removes MMIO related stuff from RISC-V timer driver
so that we can have a separate CLINT timer driver.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |  2 +-
 arch/riscv/include/asm/timex.h    | 28 +++++++---------------------
 drivers/clocksource/Kconfig       |  2 +-
 drivers/clocksource/timer-riscv.c | 17 ++---------------
 4 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 448a9952aa2f..868bbc4d0803 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -72,7 +72,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_INTC
-	select RISCV_TIMER
+	select RISCV_TIMER if RISCV_SBI
 	select SPARSEMEM_STATIC if 32BIT
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
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
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 91418381fcd4..8c6a0f1274af 100644
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

