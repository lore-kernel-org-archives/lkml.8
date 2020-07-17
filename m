Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7283C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939FE2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KWbsIiqu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xamhUZGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGQHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21827 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGQHv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594972316; x=1626508316;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lNAMGJicrUTIMgtDbjkoLIg5zjPIKjSwv6Aw+aLx2Bg=;
  b=KWbsIiquhQWPs07ld7epUCygyhon/5MxCiW4DGx8bDVZ/xEB1sF9nDwC
   bMq5E84//mUgOpLk9kL0bFLhB9pGeWViSg4mBd3CJGo2PFUbpjTW3+FY9
   a9FGeVySOvLzyn/SrNYfJaQrbcFaKAi1mA95ycnGChvh5pvE4iuKIF4wt
   ai07MsE8Ji9gOSzsGTyfctD46+qOIkJlYgjG5iyRbR5t7ZBemaFkHlp94
   +K5WIUvuqUpCK+d5M1lqakG0wltmhOJAjbW74jxixZk2ojQIYFAq+U21l
   zSG/B0dXsrOCHqCPkAvLNLiEsO9GzpVHBofolqYINruQMZCDejG+4SyoU
   Q==;
IronPort-SDR: OHUtu+HgpKBL2sjvmlxibTWUbqspPSzcRuTCnkn8II44AX3wQiVrpgmtYobGZRxF7RjTzqWDBs
 cz666kFGxP4tz6KV/mb+3fvxb3aurxmbiqdQsU1EzjNwwMGej0U0iG2iFB3nX/BCLEMUKNRVsU
 HNIEpxb2YNpjwopQ1W2X+sGai3ZyJSD5ACTzNjzDnKazo4E+3AGVijQHtYC+rskWj401ra0Gkg
 ew03h2ku3YI2E1FCnWqA7zBHPw9Xh5Cd7LPu/UG/eUHKO5LxTheA4QrcbB10mG0bJV1+MQ33zF
 +8I=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="142816140"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:51:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agB2261eyULrJr8wrdmktbGMdr6MPIZAbyipgT+bExxQYMiaUbkL1WfnnBaQh/5uOxTQOafvYdOKT9GA+N7Uz7r0jY+6fVBY3SnBfdow8Egi0Ld5uNSWgAE6Q5Lx22OgizNslUjhrMDTycZ4gi/CeJsGdZgRW3sN6+AI+xcSnd+SqNCNV7BaSiwZX+KCGGNwkOFuepg8wT1icfVaqcgkQJ6TXDpSFa/bFKm22v0nNzZp6tIP7JBVhm1yFDolx4gq0CF0aobeYvoDeaEc6N+JZuxYc0QXwrR4kXfH924OV04FlUbiUK7WVkePLXUd/XpvKJ9GL1nqBoj0zMrSFanD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ7jN6pQseoyVcuw0R9LtbpiwZoFQ3xZIbG6RxNcgqM=;
 b=AG0glSgNvQAXCj+klnWSU5/s0gCOFjygB/dCy8b3VKpp4jmUHt+UU24yqoy8aBVZOlHEkxCCI72BehKZLROJek7si945ErBBlQplVeN10Xp4BCoudeQGvPNGXdcfbDheJyCxGAj9/75pmXJE/oHr0yeFhgFvNwJItnU0r4AeyDrXQWnEzdclL3KkJ9qV+/0zPNtgIMxQpSrJWHx6+PqRvWrkEmD6mY+/bCvWDoscJyLVh0WSL9vtxwWwYME07rD7METAeQsP2biQ3nHVzfmIHbRlDJoL2JF1emRqwZTQ/fZEY+80HCrbKB6zmncHvLmb9JyBb3tWj/cuQqdeM01GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ7jN6pQseoyVcuw0R9LtbpiwZoFQ3xZIbG6RxNcgqM=;
 b=xamhUZGNxT3C+46k0uOwIgYEHWlLlKzfJ2f3vn/Fsou2oFdpkbk5rWIjhVyifVS+2rcpD/JhQgp2/UmOgKSmrebnJm9idrY41ECKq/C6Ye694+9pPEsGUJM6uQJbDenS7OJfNU/m9LSOL+JqJ6tqhIQ/NYPyq187rkztF9bTOIY=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6331.namprd04.prod.outlook.com (2603:10b6:5:1e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 07:51:41 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:51:40 +0000
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
Subject: [PATCH v4 0/4] Dedicated CLINT timer driver
Date:   Fri, 17 Jul 2020 13:20:57 +0530
Message-Id: <20200717075101.263332-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.182.72) by BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 07:51:35 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.182.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bcaacb6-779f-40c9-cd23-08d82a263dda
X-MS-TrafficTypeDiagnostic: DM6PR04MB6331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB633121FEDBC126103CBDC8E18D7C0@DM6PR04MB6331.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLJrtDwa/Wo6i2UQ/tchZ6Z9hXLTH9p6zS40/vxvVIE0PGJpRvxvDs0CcUu0nET1SGRt1Fqx6G+z6aoiMZDnIKIb9yvkSxc+5o/kkqqrhBXlbWjUETNjnlE5uJGUhfxRlTsoa4QK+nI9iE+kdaLyiu4jdtUWzG34aiA1oobHN132fRYexUPk76O9zmM3aTHqJT1G05FyQx6B8MIKT95JvOcBVq3k6z+mDlXwP1xU1XgLvWFRO2bXuMAeguRx3MbR1WjDURTVKHkidcC2eazSOavjGHoJ0isKbrdGrQtB48rrwrAviRKMaqnHvtUvVlrg4zaKRDVE5GKRBhtIB17R5b/Nx4VtPt8eOP+/L3V9ms6HmyQgJIdK8fu63Ruv79mgAyZnz0SdoMyjXsQ1Eo4Bog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(8886007)(8936002)(66946007)(83380400001)(66476007)(66556008)(1076003)(4326008)(5660300002)(86362001)(36756003)(44832011)(316002)(186003)(110136005)(7416002)(54906003)(478600001)(2616005)(956004)(8676002)(6666004)(26005)(7696005)(55016002)(966005)(16526019)(52116002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KgKsLb93MWDcq5B2dgLGSfZ4Xc2NZy6mnS8QuseOKvMA1pyPjGjgY3x8oGEqMfKYnFvCS5qwos7cyRpiOLgBR8nGE2UuKM8pdnKfeTadnpYADzeRfTzLovBPazmMav/ZMTn3PROGC+WU978UgJXgvOmFytrRf8YxtWAh2Bxf7M+HPKfmgKV2XlJs4u60qi+VJaPvi+S+Ry7BZLyKFLuPu3QxYCqZzbV9d0Mo7PcaJeIzW7gNj8fxCCm85zH613+SyTk+UnuBYLeb015mycemF+L4tsivCOJsXY6DluYSq8MaArmYMExa+vFWIEg340XLOFoKWDahawZX4Q4ekdTmYUZCpEQBlSkXL6+QZSM7DiPmHyI1F3OsFWqPzqoWEa2cJ8F6GvVuX16aLpK2kMGhHpSomRlc2U2LGSetrvPZtMffSiskjnOuV7mluSTDDMNbZrP8gZbVYhkigXnWxS0JEd5Rgmu9KNZaWHSweR5dSD0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcaacb6-779f-40c9-cd23-08d82a263dda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:51:40.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7pVaXOaFQCYlOUsA5hIPXdnXBEhdDy/QL2S83MBzG1arHf/sIWbDMwyBh2yCsvXGSL079h2wcz8lInbWeIdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6331
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

The patchset is based up Linux-5.8-rc5 and can be found at riscv_clint_v4
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

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

 .../bindings/timer/sifive,clint.yaml          |  58 +++++
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
 drivers/clocksource/Kconfig                   |  11 +-
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-clint.c             | 231 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |  17 +-
 include/linux/cpuhotplug.h                    |   1 +
 18 files changed, 374 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c

-- 
2.25.1

