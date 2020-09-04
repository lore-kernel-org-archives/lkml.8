Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134CDC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DA42067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W+f8sCts";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rPwe+DQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIDQVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:21:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26286 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIDQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599236522; x=1630772522;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QTMZ0PVAOmLCBvC4SCKK5o/5me3aGp+As6qQoh7e5Wo=;
  b=W+f8sCts502ChbyQi+F7n4XDWnbLWfBg4qMNhV4e25oKUgho6Sf1xtj4
   SeVzlmZNvM3xGO+wvJhKP1fUAUk39R1EDm7t3zZ1YxAZPIoIhEDu3sHmr
   O/h1BuD+o/JjovebAIKqKkAcZfdiegnopX3MTYjmmfyngB863CRBpKSYW
   I+tgU7fT07Zwq3QYWT2BMYBuNfhh/jy36Fkyvnr8ekktP5LsSND6QsfCm
   R7qaSwpm6RugLqc+rQeeqGZLY32G1plD29DxWFgL7FXoGrHteCDmQGcx/
   O8DTR+b2WJ0GzdkC9zUf0HGcgb8rUF9G8zBhpyPfihPWiO4KC+NAapNKX
   Q==;
IronPort-SDR: cIMqUYxQ7R7SaSLDmBOnoyZ0NgkV2y4PHK37mujqrTKcpF4o3Z0881DxSimHjIAQxJVl/5lLYU
 XLgWpQgGMyIAWXDTtN6sjeuxOMvLIo4Zq0Ar7vd2NureMEhQnmwQyJGuhlhaqR/eKpdbaJChCy
 EPRE7uVD4d1Jj6/LmCbZuSNG/8vSuJVJnSxuO8qyBKs++NAgnRAoJh5fXIp637wEL9CfZRt3n5
 tcjcj0a0N4ppddP5wHbubfAUmImBd+53R2VHUF/ira9fQcGdkuZfouVptZjqpSfk/SNHoUyIrv
 tQs=
X-IronPort-AV: E=Sophos;i="5.76,390,1592841600"; 
   d="scan'208";a="249868579"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2020 00:22:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrj7xABaRrS497/2EcSJtzbrEF/A/bm9BS99YYzvQGLYFSFR7OkuHgh9u2eZV6elkeSmvCKI1rfzobcPINbbE3LCiqOt7gG+85gqQbMUEBw+SsuMlhplzFL3tFGErdqZcMgmNCcKehIdSqgLjkjD+Jvpnx/hApJ13eDOWXlgFsW+48a5As6d+meMcd9r/F/k1EQC1GgQ5vO2AMcpIlVEZJN5NKjTO4Y2a4yZB3DY/pq5Ujokm123TXB/5oG26QMwX/IXEhokZ2hXsP98/Fmve8VezycZOmMzEmeP6jyWoF+Pka2VSnQCwJFc3+mnF2dYFunPuFNDZxrQABYw2rYB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5vypGpsqFhqoc0a1AjLX01Sw3bSNrgHuaOssFckris=;
 b=PBL2sHd3fjXg8PXKUSLkSFP2QIMWIWifURGNWGUO3dSEhPd2nJ0xlO/xvoyVzzKX/Xm2TaeXW4QEUVivyofyBA5N8c5pfXvSrmzLDP9d8hG/Hf6Jbhnwn4m0wZ2dEnWQJqDDj91OB31NSUDSLClnkMs/1xoBdvXCQ3KyKef/B69317l/hq3LFh2ddQh0glkNkVxeoYnlsT9yJnSvJr96xBDOtDnZQN0Gylqc2kXa5KmZQy1g24sXih+Cx1pr52ebQINs6yKidJjgzDiF90dno1DLSnBkWL6pA4qViayienKyHqAInSCLvi99Y+6IvbG24Xu1tPLerx+ZEbve5zARPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5vypGpsqFhqoc0a1AjLX01Sw3bSNrgHuaOssFckris=;
 b=rPwe+DQxJ57tMTg/0XhMyL7qDSbkowK1efdahsdXYb66uj4VHDLBxB0CPBd1VCQfiBVT5bPu5lg9iMHCcfFJxqy3ROSXTsi4v2qlsH8ppEQlHiM0qquIZSYPc7B+CJbjkZlRBLcgpo/rmxEAA7v56dcZVGp5I0pxquP6R+4YFFw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4521.namprd04.prod.outlook.com (2603:10b6:5:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 16:21:48 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 16:21:48 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64 for M-mode kernel
Date:   Fri,  4 Sep 2020 21:51:21 +0530
Message-Id: <20200904162121.279578-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::22) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.57.4) by BMXPR01CA0012.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 16:21:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.57.4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69b8a88f-a30b-499a-8d39-08d850ee9f9c
X-MS-TrafficTypeDiagnostic: DM6PR04MB4521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4521BD6C61134535E2E0C72E8D2D0@DM6PR04MB4521.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXyV86vxem8Jw9fQW7mW86Q/aoq5KlGdMm9+sL6oS4A0l41ME0qIJ3bs15zOsGA8o3rQODNE90z955/5xwOQyTRbDUwqcvODk1GPOHV5Albke1k5Jmy6j6laf2cU5JaXQ5fvrkeqnoE73Og2mk+NgJRznekQd3e7h2HlT6pSDsqz0oUnSuEpjz+gQ8AFwnmJNxYrgKC+lcUw9x0mIFJ6koL9zyn17wHjWGCBZrraJRai/xjL21NuLu2GGN3wM62ZSfpet1BTz40uMAzYB2Xwgyhyc06EnsgwVqXOx2pylku6yBTzLhdEVDGaBkDEfaJTW3GdH0iNXS4x4CG1NdUiRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(7696005)(52116002)(8936002)(66476007)(66946007)(2906002)(54906003)(66556008)(8886007)(36756003)(86362001)(5660300002)(55016002)(1076003)(16526019)(110136005)(26005)(44832011)(956004)(83380400001)(186003)(478600001)(4326008)(8676002)(6666004)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dzfwSRFStUVwlKVPLs+lll/gA9wMg6U33bT7LJbtMolhbkPIhW62ZksICdFy5LcYxb8QeztHBq52UG6QOlTNX9iQTWc8qBea5EYCTdELoSZ6m/AhYK5AsNsUJpopcsTr0C6Ca9lTEYFuZ3pmFN0RhEYQRYrGfwE0RMJFgefdFyLXveTEG0yOZR88E0ntnn2SzHTpjNQCPddWAlTEb+wlpoJt8S0j6bYKCIgO3ZWwHohaksKTF4P+25PFI4UAoWl5bVgpaVIntp1+F1/f+U/ewZJlBfgEV2h7xrgUitoJY08QTcPH/ED28/3vsCQouPFXbb66IQ3YjYe1MYmNs5cgcRO+k95ZzyoaltKCc9K+dpEPDNVm4B+kLZkTMA+wWYqph7H4ayDnJYUdBI8fCyjIURNJfQL+hyRCxmOhPZR+QTUYuA2GNm5sKyOjW6xTZv4ga0CwS+ng+j+4fxQCIUlRBRdUECQmbJJBGUqEVwAVxU8lQrkacdOJVFCXHrt3ITf6rra0UEaSoEPkmaQ0+HWKBeIb3wVtp7q24woC6cF0Kz9DLCr9ctfrkQMuLxq5f2IiKHmFynH2SpaulddTS+RqurJ65raphUxnhzFS6GcOGijKjU0jnWmLjgV1yynma1GoKT8HKRZkZkZ3rmO4ne8GBQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b8a88f-a30b-499a-8d39-08d850ee9f9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 16:21:48.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3JekYIEly8WtAK9WG1mxabeTE3aG0P9cwx0ttQmkt9rsA+REVr6/5taqujUSwM1Beas/PCQiydD5qygTjYr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIME CSR is usually not present on most RISC-V systems so the
M-mode firmware will emulate the TIME CSR for the S-mode (MMU) kernel
whereas the M-mode (NoMMU) kernel will have to use MMIO clocksource.

Currently, the get_cycles() implementation in asm/timex.h does not
consider the above fact so we provide alternate implementation of
the get_cycles() for the M-mode (NoMMU) kernel which expects drivers
to provide custom MMIO based read_cycles64() method.

Fixes: 2bc3fc877aa9 ("RISC-V: Remove CLINT related code from timer
and arch")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/timex.h    | 27 +++++++++++++++++++++++++++
 arch/riscv/kernel/time.c          |  3 +++
 drivers/clocksource/timer-clint.c |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a3fb85d505d4..94019b35c050 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -10,6 +10,31 @@
 
 typedef unsigned long cycles_t;
 
+extern u64 (*riscv_read_cycles64)(void);
+
+static inline void riscv_set_read_cycles64(u64 (*read_fn)(void))
+{
+	riscv_read_cycles64 = read_fn;
+}
+
+#ifdef CONFIG_RISCV_M_MODE
+
+static inline cycles_t get_cycles(void)
+{
+	if (riscv_read_cycles64)
+		return riscv_read_cycles64();
+	return 0;
+}
+
+static inline u64 get_cycles64(void)
+{
+	if (riscv_read_cycles64)
+		return riscv_read_cycles64();
+	return 0;
+}
+
+#else /* CONFIG_RISCV_M_MODE */
+
 static inline cycles_t get_cycles(void)
 {
 	return csr_read(CSR_TIME);
@@ -41,6 +66,8 @@ static inline u64 get_cycles64(void)
 }
 #endif /* CONFIG_64BIT */
 
+#endif /* !CONFIG_RISCV_M_MODE */
+
 #define ARCH_HAS_READ_CURRENT_TIMER
 static inline int read_current_timer(unsigned long *timer_val)
 {
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 4d3a1048ad8b..c9453ab3d5e9 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -12,6 +12,9 @@
 unsigned long riscv_timebase;
 EXPORT_SYMBOL_GPL(riscv_timebase);
 
+u64 (*riscv_read_cycles64)(void);
+EXPORT_SYMBOL_GPL(riscv_read_cycles64);
+
 void __init time_init(void)
 {
 	struct device_node *cpu;
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 8eeafa82c03d..43e31bfd6d23 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/smp.h>
+#include <linux/timex.h>
 
 #define CLINT_IPI_OFF		0
 #define CLINT_TIMER_CMP_OFF	0x4000
@@ -211,6 +212,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 	}
 
 	riscv_set_ipi_ops(&clint_ipi_ops);
+	riscv_set_read_cycles64(clint_get_cycles64);
 	clint_clear_ipi();
 
 	return 0;
-- 
2.25.1

