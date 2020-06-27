Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EAE20706
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lyXZQgby";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cOK1V+Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgF0QUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:20:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19171 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgF0QUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593274841; x=1624810841;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wP+xewqF2pqebseltpxeQ0/Jbctigpb9at/dgV5Fbow=;
  b=lyXZQgbyeRMZbJNGk9i2oasS4RPkdLGz1FkzN4oU1ht5TRkvH9T82VhX
   qaO3Nmi/J+66dHw72DVMPweQGx4J0uQCjOhxlHeE4piaMUt+zdbmtRAxb
   s8V8g2EUce7Qm1ZDLOcmrFUk9+QZhotmPHU+J/CkWZy3YLUPVDKz7PiMm
   DhYuxPlnyBK+hLz3lBTuE3UP2WSJdN4ygqRfLfzcTO6J5Ri3lJ7FoXc/S
   lDrymaEbrg2sNXThUbdp4WcF8/mrsKmaqobB28v/LIrC/5mSTTlh9h0su
   bBC0mJWLQhbPahfAkChnsn03LOfJngVp4XtEdg7mzeHnKGpykF5P2wxbb
   g==;
IronPort-SDR: +5cU2eNsXN/jWquJKEoOgDIC8FQB6k52GHqIPq3F3wy+RARnEi+/NJQrjtJVY1pKxp+jxRBxwG
 50wRTs1pZU5M8O3wxCxR0saLRQvRBIlZ7bjJd+hit0hfPb/b+obfsJ2RkN9ZtasnbduWEZLpru
 yxwrNA16bMt8tnDa8lXmlDF8CdHOCWo5epk3c6LX3htacJxhkK1VnwubaLdRQ1p+dPo06AAXqQ
 iZvmsYQGZg2SiciBoAK6wcjyFJMmbAaaeTWC9qMpRH3ziVbHR7E/P93OZTbQXAaNeq9jfkCYhH
 fio=
X-IronPort-AV: E=Sophos;i="5.75,287,1589212800"; 
   d="scan'208";a="145398669"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2020 00:20:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpZBASZnao2R5wEoqipEGqQsWOk2ysL/Y4BlRAzbXynzeVb5PY+6SYwVxi++Zj/hLqZs6LDakn1VronyjITdFBXMvMWMnY16ICWI2CExCscW6LeK8P66vKy8N3ythlhMzFtC6L0MXP+8YlyMduhgZ0a4kUmfFUjH/VyT1TZBJhrtrfZiJ3lhQoS1c7LFFpbzwxj2Z03HeIxRGPDKtHg00zaVEjl2OJX3z/0Mdl+5rfromrvfjlEOoCUU28LgL94IilRWlKnUgDLzbxDgwMrf/MxHtMQvNqjapMRTehp0hiqLIvIj2J5JeujC4Q6bfqg4aCP4UJobNAXFc8RTgUiMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZJ7PYrAFgpMng2KWEvnBx3HBIApOFm8ARyF6GuFQJw=;
 b=lnllqRCIwUy1XYuMX8t6aVzJULYe5G84K/k3suQzWi94LeeOZGaRE2PiU9yhHxj23xstsYH3ntAt0ZGERRGwzcRPi3Js5iXep7HlfsRjqdVYX+OZvONH7sHJLqxMWDMLZZFbtRdHZjis66Eo15BHzTOdQmoeB0q498QlYnaXgkrYUFmyVJZrm+BneokKSJTQi06WhK8dJ42CYd4kHnvQwZrbSxwiLw7rnirc4swoshx0U+qj+hnzamzOvVDQc+Q/7TUshKUBwpxjbMvqmMeDrTysM4lv2gpW1lZ1WcUdabfZ5im1Gb5NgsiJvupWx9zuZjSU1+6Ovtss1DbCC6eMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZJ7PYrAFgpMng2KWEvnBx3HBIApOFm8ARyF6GuFQJw=;
 b=cOK1V+RqE2etXBcOq5mi0XbBYBmGlEOzj+H7U2pWHspd1y3JspK56rppPwK0xAyys2LFu8P+orXbQUtPIBJdVj5l7+oZTPRmKpeHbgjH69ayQZX8FoX4mX6gf92M3uedw3k51TodZeezrXMjpGB1KV/YXUBRdGRlN4ahYXyw0NY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB6207.namprd04.prod.outlook.com (2603:10b6:208:de::32)
 by MN2PR04MB5599.namprd04.prod.outlook.com (2603:10b6:208:fe::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Sat, 27 Jun
 2020 16:20:38 +0000
Received: from MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580]) by MN2PR04MB6207.namprd04.prod.outlook.com
 ([fe80::e0ef:7fce:ff0d:f580%7]) with mapi id 15.20.3131.026; Sat, 27 Jun 2020
 16:20:38 +0000
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
Subject: [PATCH v2 0/5] Dedicated CLINT timer driver
Date:   Sat, 27 Jun 2020 21:49:52 +0530
Message-Id: <20200627161957.134376-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MN2PR04MB6207.namprd04.prod.outlook.com
 (2603:10b6:208:de::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (42.109.128.251) by MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Sat, 27 Jun 2020 16:20:28 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [42.109.128.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fa3b50b-a110-4601-2d76-08d81ab606b8
X-MS-TrafficTypeDiagnostic: MN2PR04MB5599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB55997A5A19F66976C4292EB58D900@MN2PR04MB5599.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0447DB1C71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Rumslxucs3jO3Ioy34lNtsG2JVTASuY+iM0Lj38WgIPPBk7wnKc2OotNRsA5VygqGiWZ93vQ2iJ8YmXTbvUL+BH0Y/4BRolyLgWyeb8Ghbe/xoZ2om6HMlG/IXk6fz7IVr2ni02m5L5yxCkXA821EySRDyrKrPL6RjYLAdm4VYRc6lVg4hee5xbCSHzJxgf+fEYw2lQRS6D/ADQBZwrK0s0/Hv+o2z15YLACY9D/gM/QwVJDmlVaU490231fwlcMA7dhindFcSGe/wEecupqVJ8ho+y3MXkFJ0zQmsVx4yHs53MaAk2pyQfWzv1i1mz+keet8rUQHa4REGy+IdhV2TgdnvwamOt3DWS9mbQ9GEId4qwtM7IkBzDYNjQ+sZadyisLmjZmo+XfXuCoCJI3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6207.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(5660300002)(8936002)(86362001)(186003)(16526019)(7416002)(1076003)(8676002)(956004)(2616005)(8886007)(110136005)(36756003)(54906003)(83380400001)(26005)(55016002)(316002)(44832011)(66946007)(52116002)(1006002)(478600001)(2906002)(7696005)(66556008)(6666004)(66476007)(966005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 944vChs3SsWKH1nhtN1yviC5aIHdgfeKVciIa+yJrNKgR8hcZr0CD35uLpMsmPBYpQXbv40MyhirapSnzoOsArhKNJSkgKIkUj0evpCK+GgukdNpXh9cbYv130kw+hEz+tP3R3We+hdAzhPB0E3b8frbHr8WS8N891iB7RerYGb7TwK1MisWOqwS9oo9/H87DaYV4tT2otuTyQzFAWhdOoXq3nITcXzfVYwlyR6MTNPN1U0brjEmOpIj0jiXzOhGV7k2re8DdCgAJG6Fmo9w7Sae6mM7gRcfoFLWEb7BZV4FTD2sQhyeEa0NP1htHWGFSyGjiYQt/yQDk8yHQ5BbsGGBvXnyUuX2j5ZpUvVtjWYLv/caAjs13tTj5Mu8t3PVzPLciNXSdZHKMP9JRbc0w7idGviZqkMNw8CxAcOph29it4A28HBwuqLsoaEADaM3FSgVFt9mxosIAEtid1B1fMzSXfuCTb7Ov9CSqZot0gEIdA4VxRhoB/wTOchc3JqB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3b50b-a110-4601-2d76-08d81ab606b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6207.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2020 16:20:37.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKr5/RfX2zKBv1UIr7x2UcmjgLoTht/20X8NE4ISQw6Kq49UZNbUJcBEJahxZDjubwGcFvOjiTowNf7+cAoCzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current RISC-V timer driver is convoluted and implements two
distinct timers:
 1. S-mode timer: This is for Linux RISC-V S-mode with MMU. The
    clocksource is implemented using TIME CSR and clockevent device
    is implemented using SBI Timer calls.
 2. M-mode timer: This is for Linux RISC-V M-mode without MMU. The
    clocksource is implemented using CLINT MMIO time register and
    clockevent device is implemented using CLINT MMIO timecmp registers.

This patchset removes clint related code from RISC-V timer driver and
arch/riscv directory. Instead, the series adds a dedicated MMIO based
CLINT driver under drivers/clocksource directory which can be used by
Linux RISC-V M-mode (i.e NoMMU Linux RISC-V).

The patchset is based up Linux-5.8-rc2 and can be found at riscv_clint_v2
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

Changes since v1:
 - Rebased series on Linux-5.8-rc2
 - Added pr_warn() for case where ipi_ops not available in PATCH1
 - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
 - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
 - Added riscv,clint0 compatible string in DT bindings document

Anup Patel (5):
  RISC-V: Add mechanism to provide custom IPI operations
  RISC-V: Remove CLINT related code
  clocksource/drivers/timer-riscv: Remove MMIO related stuff
  clocksource/drivers: Add CLINT timer driver
  dt-bindings: timer: Add CLINT bindings

 .../bindings/timer/sifive,clint.txt           |  34 +++
 arch/riscv/Kconfig                            |   2 +-
 arch/riscv/include/asm/clint.h                |  39 ---
 arch/riscv/include/asm/smp.h                  |  11 +
 arch/riscv/include/asm/timex.h                |  28 +--
 arch/riscv/kernel/Makefile                    |   2 +-
 arch/riscv/kernel/clint.c                     |  44 ----
 arch/riscv/kernel/sbi.c                       |  14 ++
 arch/riscv/kernel/setup.c                     |   2 -
 arch/riscv/kernel/smp.c                       |  44 ++--
 arch/riscv/kernel/smpboot.c                   |   4 +-
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-clint.c             | 229 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |  17 +-
 include/linux/cpuhotplug.h                    |   1 +
 16 files changed, 337 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c

-- 
2.25.1

