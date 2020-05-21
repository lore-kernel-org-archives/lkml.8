Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC5F20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F5qFZM2g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jIlHBsi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgEUNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgEUNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068806; x=1621604806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B1YCa9WtevsIneyMYRHZQO7mK/ptLy+6bCQ1v8wy5FY=;
  b=F5qFZM2gWSmvstBDGXoagwXWbuvYumdfgjJrtuG7hajmYOSgOJLT6P9U
   /xnxypMF5f9DuXOl27eocouK1Bq8Ho5TZj+6HsGQ9YtLi5bAo8o3YJAc0
   qSGrqB5IQsfpKLZtb8I34jIpLLXgiZBoi8HDYyCj8Idl2mnanc1lPeYpG
   5hqd9wfgq2/QRXtvrR2TgvOI5nD2bvE9tdS0ZXTe9RChcIpvJvw+XZrxU
   Mx4OAwu84i6Tys+RhtzmrNoAqhULjBlP17UQTNYCmwk5ZaEEpVBwDMBMH
   NZT5bs95Sqx1zDcpxPL+CVnUMgJ3uu8xR/FZADBGbGK7Vxgt6b+laZW2v
   g==;
IronPort-SDR: HnXVoC0Ds7Mwiropk0/S4i7o5f3U2uJCNUHLK0n98urYrDOTTXSiKk9nYArENCRxEePET3jE1A
 kVhndAcVqTd7sdkiEDdP9bTjKtaUcPw0y9VoRvPbCqfISTEsgHVzbJjGJhp0yT0Pil3t9E+IYP
 XTmOKmxRWQDCOdxapPNiPISdg5dbP3C4NtoBlH3+YocHbtYs7UnEAelY1K06wBwtgc2S1B3dZw
 CV5yDlMgtlce+tNV7buUk7h5oknDO+AFo6FXZzrIm7kkCQzMpaBXIQMK5Y5Ql2wmjzIRAQiBCi
 IOA=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="139661593"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:46:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN8RsuvcV0eZY49LMW5LKkyetxXNiF/IcjIBsvdQrSmknLNFaCg7pKFHSiC9X3a1JD2x5MKsiT0jA61d9MQ8gH5qRhC6dbvn/3owlr1JsNrpZy8dBgAjMA59DpK9zs5Uw9PVyPhiIbgjrnPyYdHa45PK2AkRIU5cz41f+lDNH4zGjQoNVHChyjuKcuoP8VjIry004AFCs2YR3o8HXxIzO8U73VLCxXNRs+CWNx68/VFGgbHjiorwvIx7IaaEGvEPm4OsLZW9ALP7XPOTHWijp2NTYV4q6tGYtCiQRF4YtweUd6iHY3XuJmBhIGDdPe8n/1Qtn5vC7MVXZl3zqttthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VVQ3ZS6TEI9sRWrb27Z77jx1KtOiPHyGgst/7QXjiU=;
 b=exr44c5DU+m+AvtSjCAKGoFLIaF3ymVgoce6sVk1r+ZCHI6eaoPrj8aVQvfMicoxQja7qxF1mNC+IwIKWMuflIUrVNLCHDi3fKqNL81BgX7Q1XQNFl9/or9Z1CM26g2lr/O19xdViqNNg5Ry8I1t7X4I+DOY1n141YoRcEG6se17qsd1NnNxkjLMxmQTtR9h2TEzYQ6kB07nSmimkLivT3gL8vxKaSa/TpDFctBoC33eB/zbbRzH3b8/1SluzVBOaTr/snniSK1osXtXpWq9gTtsO9JZQlNX54BSGVW3MmLk7QQROWMXURo5lI6OqIObKU1PUCyXNzzprkFZu+hfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VVQ3ZS6TEI9sRWrb27Z77jx1KtOiPHyGgst/7QXjiU=;
 b=jIlHBsi9u5VeK0FAwLorTpP8U6x/tiyFfBuEuSIGB3o1d5qUIMgF65NG83g6TFlUpgJV2DFSKnQkur5P2BZY1NzlFz0GuXq0dlaDDy2HKIAPJ7UCqvZ1/bL1QQuqnnv9LoTfUn/wVfS2qxEKRDrq7d0Hdq7/QdICB/vh799ql2g=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4380.namprd04.prod.outlook.com (2603:10b6:5:a2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 13:46:43 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:46:43 +0000
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
Subject: [PATCH 3/5] clocksource/drivers/timer-riscv: Remove MMIO related stuff
Date:   Thu, 21 May 2020 19:15:42 +0530
Message-Id: <20200521134544.816918-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521134544.816918-1-anup.patel@wdc.com>
References: <20200521134544.816918-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:46:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 767b1d03-cfc0-47bc-d38f-08d7fd8d6554
X-MS-TrafficTypeDiagnostic: DM6PR04MB4380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4380159169C3D7C54CE7F3DF8DB70@DM6PR04MB4380.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7sd8ZykpUHErpSqX8/7/NswR2RXRbS2uKPADZZ2CuXW9FTbEHaLUstxSagn3DIZKIKSNDBMT2Giex3ptjwPeyusaM4WnJ87bqHGf1g9NB3XlKp91s4reGCLXQ3NG1PwtOKmf5uX2puYIM1f/3zYaDfBBtD+Hb4m5KJi5oKzKMKQvJyEyWOM3LDyrUqL8bCAy/KkMBbHEFbG2I4n67I1cJPJi4zYHC5lg9K3WmUTFo/dTya85lFizu8V6CJu0dLz4ouVrScnMILrsVj09uhIopyD9kVleejVCxEZOzhN8JQHjPQjM9SvTOIYfnuwDXLlSQwPKbJ/ramTFl19AqKhWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(16526019)(55016002)(86362001)(316002)(6666004)(26005)(1006002)(52116002)(1076003)(186003)(8886007)(54906003)(478600001)(66476007)(66946007)(55236004)(7696005)(66556008)(5660300002)(110136005)(36756003)(8676002)(2906002)(956004)(2616005)(4326008)(7416002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: t2L9pURKhAKd6394cjPQSvuz13vL+zA4TYHI4GnM1j4ZZLZc+F2B0zJMhRY2NSiDLL06GsuZJ0F8JVT2cTf2C4WJ4dRNLKx5YssMRFYhdUiWzXwHb+D5JIS/KNJHVpfAEGMMlxFeZYiGLAkFNrMKFcWihDi6OkYtuGsjl5CcJjQ0sqj31uuUAXEsBTyi4YYz8hlRzwrw+6MGAtAGKMQztFiaVGzps9JTdga76WfM3asALOPLiN6FAToU3rcOVV7sCzB7PmYk9wALmBpy0XoCCrBoyJg+v8x1WFNdyU6SMhmMkov8J2789vVn9gIMbQWRUFT3abnFsGsB5n6izm4K9ajTfKN+6/+FwHcLmcp/Rbbz9oYmgU3X0SAhDm1IckdK7iBNERkA93AC9OwpY7OHcuHDsPQZIeth9uP0cmPi62GQns6/Knl50szjRAdYr5WzpXZmPuNWodoxacJE6dAlmrJj51zZyM6SGKtWWKDCerM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b1d03-cfc0-47bc-d38f-08d7fd8d6554
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:46:43.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDBEYuPnEjHyjK2G4S7mJre5+mCCBLKFEw0yOmbGndgpMOFgilApI58SIs+Ab9OtAaBn2GMLjWxHRW43j5Qi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4380
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
index 2cf0c83c1a47..bbdc37a78f7b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_INTC
-	select RISCV_TIMER
+	select RISCV_TIMER if RISCV_SBI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select ARCH_HAS_PTE_SPECIAL
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
index f2142e6bbea3..21950d9e3e9d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -650,7 +650,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
-	depends on GENERIC_SCHED_CLOCK && RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV_SBI
 	default y
 	select TIMER_PROBE
 	select TIMER_OF
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 5fb7c5ba5c91..3e7e0cf5b899 100644
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

