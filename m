Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFD12072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XV/xGPXo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gKyKtoxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHQMnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:43:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55841 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHQMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597668198; x=1629204198;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3AP6BdgGATPqceAzpWdqL013/+h9snWRXpVWqWsd25M=;
  b=XV/xGPXo9o9ED3osSIXu+VvT0LiC391Xsbf8B6rjGf0AuIimFzpESftv
   YQZUg4v6Yn/HlFZq5zvOGFdTNfdI1BKQvwnwj62tIqGGTAOgb0nhx6nVF
   sfnLhaUW5CDjcYzvX3GuImQFdj7YvPetVSQgXekfuQj4abB8FjU6M5jwL
   3y2g7r8Dj+NCQo31dyde/P3OyCRFaIc/HHH0XwDfu2Pp995Xvy2L9hXoX
   SOXHATwjBfAxGbLTfpynqdZ46FNdHnGoHxFI3cxEmJFOzv3R9EP1D4RqO
   eUPH34+7EQHxp6eStc9OkA9JTRlPOcxamnH02KTZxE4zbvwcLQcnUJO4U
   g==;
IronPort-SDR: 8GX8NkwfXsXeIye/NNX8DgTL0nncCIytnYAhTj8kqmWvIfEr4ss2BTFH8nQB7GV90LykRw0+FO
 O143MlGROYBTE+YohU9G4TTfwV9dTfd8PfZ/JY8aGh4pOaVwUX25s+cs/irc/+Q6Fad6yeWhqC
 pGkEkY1eE6c0n8en6Jx0PVyhs/sKx2DrIfHgO7IzyS/M1pcwTh6y7xf5nYACNIL3oStkmC1+3j
 kF+I28sYjagpDY4boRJgcFNFDc25uh01yhoIOifrjDy8ZkVJu+Ad+RDwaQE/2c6X/nMjbgtDzs
 D+8=
X-IronPort-AV: E=Sophos;i="5.76,322,1592841600"; 
   d="scan'208";a="149449700"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2020 20:43:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/MFyTy3pSbTsIOfDpNg/rSZBvSztxbD37DvpsnozZ2whZytNQtz1KakwrUMLoJ/bYUxHTcSTTA14HObowTnUv3M9eL3sf9neH/Gl2ww/XxpUFohu2hH+SZ1Kx1U+CQieQKjVJ9u8wtIk2vpKRmBFBEi+J6mnARmU3Jo8HO4eTBEWw+w16DtsbDC1HlkNJrIyViarBq/jW5ia5A2kdFSpemf3Uyp56sZnQhvoLrz+AZlBOzDhT0rt92MoLr8cXx2+P7RWNcq2QjaxwNHTm4GrAbi7LH1hd3OCAqwoU2RPzW1CWIP79eDuMZZItUzzL3qWZ1aqLPrLNM7pDyC7Xy6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me4pRDWwtSxDONqMUukjTaaR6QdfmdTsZLzS89EK35Y=;
 b=RkVyNheNLF7AIoNwG8J+iIrjANwMkCiO2lmQmBWn08HqMWIk1pDSBRWs9y+txqIXqSAmp7tjFpVnfLszE5fgz27SWwUFubCXsTEDnmVQvrj3oeZaCdCs+OqACI+rU3Tyj+eNaUpRDqDh5SRHsnb3EvqJrtFfYe44esNlR5iHR7i2LBeSeeQerUL/MJY/DS7PoNczl8nQcb9t8qcs7/+PiQFCgQbDLvzECh16P0gSw568lGuOkJnBSIV995Aw1LK3R6dJ6it74XCvn8SDD+zCvhZzZFyTqr448j69zomCCDUipmEYXhqNUq93n2c6Uds/NkVIArPtlVppda9l6dbG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me4pRDWwtSxDONqMUukjTaaR6QdfmdTsZLzS89EK35Y=;
 b=gKyKtoxXPARlLKf0SQ8dqxfiz1WkeHqhY9tsZ0xuMCqkpAQqCYNRktccUhVbEgcSedLjF8ncK8+B/sI5z7nFCe8EMqDaea2536mLB3/KfWpzOrXohC2BT/TGidvfoqGQCQCzmeZxwdL/x/Uv+RSW+wKbBLvpfB0WWwgP2PU5JCA=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB3865.namprd04.prod.outlook.com (2603:10b6:5:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 12:43:15 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::607a:44ed:1477:83e%7]) with mapi id 15.20.3283.028; Mon, 17 Aug 2020
 12:43:14 +0000
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
Subject: [PATCH v7 0/4] Dedicated CLINT timer driver
Date:   Mon, 17 Aug 2020 18:12:47 +0530
Message-Id: <20200817124251.508183-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::13) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.59.21) by BM1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 12:43:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.59.21]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76a6cf1f-2529-4449-69f5-08d842ab1bca
X-MS-TrafficTypeDiagnostic: DM6PR04MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB3865531BA464A8E2F70219738D5F0@DM6PR04MB3865.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a4rn+VKdoviBfOCDlh5AT7LsYoMz9TLtvR9HMNT8ZTDh+nimlNu6QVGYviRl+dIABM8mDXSYqZGKFhfc/ag102fLyYN3coRMwtNCzoqfq0Iwzva/p8wxMPrcR6OjY14bpXoOq9iJPOWOv6XVkPD4wniQWJWs73hGNml5nRMXhpccYNcdAZayB4/E7x4l2iWY9YdmrODoGOI+ZG+eQAOEfERQoJtzOq72eoCujD/483ZPNK0gE7UY24vETDVU5V+Fn2Yar03CJgNZtrfya1Z5APL8dvxEE54zZmPgW27AfDXoHdBCycu4NrTaiPq3m5ohuqAd+M2RHQDdza+7QNlfqI2Rjo5ZponM6NXoI6WM1b1fZ8nyGIIFlyOqPxIMj3BVVoeHcejflcqOdiFD5k7lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(36756003)(966005)(7416002)(52116002)(6666004)(66946007)(55016002)(2906002)(54906003)(83380400001)(110136005)(5660300002)(478600001)(7696005)(66556008)(66476007)(1076003)(4326008)(8886007)(186003)(16526019)(44832011)(8676002)(956004)(26005)(8936002)(86362001)(316002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3KAWdgGRg6IsfZEe+FQKUgAJPiqbfQY5FmFLN1pLlU0QgBJmZKwdt3ZrSH+mUkRAOYiIpVDsFdl8Wj4ue4gY//pPM+Xkn7Xsx033ahZ1yI4UuTIejj3issHifofdsuh3DWZgQVngGGm8Jr4h4ghMLuZbu0rxpc3KhwnsE41xXQh8Vs2AiQfHaGTW9xox9+zft7PAROnImKjlCE5V96Z30egfG0/gyCGFf4hPTJrt21IxVyilfEvKyl15DPkSFOn8RY4J8f2v/SsHibb5j1bEl6ofcO6r+SAUDZt6DLetBtdA+yX2M3RLaJ+6RwVM6rRuMD57eCLVQtl2BhTIzOYAO5UiJJKvrgiWTjOWNSbya0uOfrSxBVSQkWYB7l+VgFK+zYUm94rHWHIBB7S+OW0QM16oE7eJrpxYKQ7N3qVIYqYQe8gtUHkalDREafIrMUyolxbE0C1KN0rj+joqoc+Vf/LL1zZ1BNq/uL9zU+rat+BB1huq3kKhHXHfaA3h0nvQ5ApfsERwvULU8jWz8aGIwafZHuhmxgyJro1EnLERRZ1MJZjMLF6nv/dgo7/v9SzmKepDcP7NJSNT7HaCgOPfrWFSa8E5kRS+1mwqlmCTpIeR6WjW4bAGuwZK/MN2YYcZ3Ft3g3rNlzzAevUF3Bz5Qg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a6cf1f-2529-4449-69f5-08d842ab1bca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 12:43:14.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrbVOAxtwLVzsmDd+rJ+06Gh1Y/1cHHygzHnT2cW4dygxnzwCijT54qXrLLrbyT7ElQjBR61xJofX5JSwLGJXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3865
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

The patchset is based up Linux-5.9-rc1 and can be found at riscv_clint_v7
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

Changes since v6:
 - Rebased series on Linux-5.9-rc1

Changes since v5:
 - Fixed order of compatible strings in PATCH4
 - Added "additionalProperties: false" in PATCH4
 - Fixed register space size for example DT node in PATCH4

Changes since v4:
 - Rebased series on Linux-5.8-rc6
 - Updated Kconfig option as suggested by Daniel in PATCH2
 - Removed per-CPU registered flag in PATCH2
 - Addressed nit comments from Atish in PATCH2

Changes since v3:
 - Updated commit description of PATCH2
 - Use clint_get_cycles64() in clint_rdtime() of PATCH2
 - Call clockevents_config_and_register() only once for each CPU in
   clint_timer_starting_cpu of PATCH2
 - Select CLINT timer driver from platform Kconfig in PATCH3
 - Fixed 'make dt_binding_check' for PATCH4

Changes since v2:
 - Rebased series on Linux-5.8-rc5
 - Squashed PATCH3 onto PATCH2 to preserve GIT bisectability
 - Moved PATCH4 before PATCH2 to preserve GIT bisectability
 - Replaced CLINT dt-bindings text document with YAML schema
 - Use SiFive CLINT compatible string as per SiFive IP block versioning

Changes since v1:
 - Rebased series on Linux-5.8-rc2
 - Added pr_warn() for case where ipi_ops not available in PATCH1
 - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
 - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
 - Added riscv,clint0 compatible string in DT bindings document

Anup Patel (4):
  RISC-V: Add mechanism to provide custom IPI operations
  clocksource/drivers: Add CLINT timer driver
  RISC-V: Remove CLINT related code from timer and arch
  dt-bindings: timer: Add CLINT bindings

 .../bindings/timer/sifive,clint.yaml          |  60 +++++
 arch/riscv/Kconfig                            |   2 +-
 arch/riscv/Kconfig.socs                       |   2 +
 arch/riscv/configs/nommu_virt_defconfig       |   7 +-
 arch/riscv/include/asm/clint.h                |  39 ---
 arch/riscv/include/asm/smp.h                  |  19 ++
 arch/riscv/include/asm/timex.h                |  28 +--
 arch/riscv/kernel/Makefile                    |   2 +-
 arch/riscv/kernel/clint.c                     |  44 ----
 arch/riscv/kernel/sbi.c                       |  14 ++
 arch/riscv/kernel/setup.c                     |   2 -
 arch/riscv/kernel/smp.c                       |  44 ++--
 arch/riscv/kernel/smpboot.c                   |   4 +-
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-clint.c             | 226 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |  17 +-
 include/linux/cpuhotplug.h                    |   1 +
 18 files changed, 371 insertions(+), 153 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c

-- 
2.25.1

