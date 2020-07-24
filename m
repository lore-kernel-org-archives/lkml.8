Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20438C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F992073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oQbRyuwa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VvVy4nER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGXHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:18:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44710 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGXHSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595575145; x=1627111145;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vfF3ezd9BKAXGDtXBLzJ82rFbaS/+AIsExrexUxIt6E=;
  b=oQbRyuwaCDza1bxfQyT2bl+KnG70aACbPZt1Gw4v9THc/pAik58yCN73
   z7U+0rersn/ehrbPrr1m8mUGg5y+yYmq1zG5J0eZXdiyrqYS9xB8XVsLF
   JV9eL09rk7B51m5wRGnCuirEJpSrfPUxxILBtc57Pe5OEgj5G6o+tIa/8
   tEch2qy5sSQ55/u+pVYJOWeopg+TLBWLjPjQn8PA79wOkWxcb+yiekoWH
   YIJjW3T/mDehnnrfEne3AE/jwHhXUlFHJRtZF1xpBS//ZATf4cAMvmp5Y
   oW1JscNII755caC71wqE8+JthsSFcdI574G8dBjRN2xHPoLOQsNZIC401
   w==;
IronPort-SDR: XcTA52ZER6SpoOwc8/KScmQfs/dfG7sm+hd1vyQwkoVVv6BON1ikvjuQmCqOn1tLex1O8X+VcV
 KDqENs+M9VCVqn1Z1IRRaWqAU6nqQzyZOITBMitmQ2HdHYAr2/FqMCRN3DKcTI/H/Uc1ansrmp
 yO8Rox3yBI+HjCKJn5b45k/rBUitoMrC0m6wZZTFz2TyBE125+qvrPUXEsXUdwcjCkBEZWdTcM
 xfo9YTXDoKqOZLoIq4AoIxnlkNPyS31DBsQ06QgXeK9Sn2ALUiKX3aJaNxdOadV72jqWJO1uzD
 Ik8=
X-IronPort-AV: E=Sophos;i="5.75,389,1589212800"; 
   d="scan'208";a="246341010"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 15:19:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TePlCv7wZxggUYtSLcbpCj20eEpweo0YD6TDv1vKXCkojTvM/DG4wxvgnJ2ToukJ0GDd647bGOeXvgEzUWpO9lzz5pDCZBQ+tdXSfkiY6t9Lv2undpAvUA5G/lhI3fUiOszdrlomQ6TSnrhYPRB3MXVLSy1d4lt1/49yO93XqvpUtbaLqT5fNasX6byH9AsUaUQVkB3qr/02Dz2/LLiDZFJ28khRZeGM/yCRlV6Rv/zezfxwkgwtKIWi7h9nwhmJ68wa9WW0hIolSNFj+4PHDqxQwZj0pr/YEURV/Saqs4/pLGq47E11qe3m9ZPNZaDCTRsmHnmE6xc8fOgm/JmVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcbba1LtUTmUzEbbW+1gSnCWFTY1zYCZx5ZhJ+CE4i8=;
 b=NCEvOMvnpKa5GubG6qND+MjlgZMoOUqFUAfVJLBLQ39tLemwNzhJzg4DtMcEtqeJ71QPe5lICl2DjcTN7iypA66LrWZHfZBtJz1EipxptWAhNBbPEDs1JUG5YDnRk50s1yCxgGDQmPEq+WUmUpguo2v22CH6bJYng8wuRwBNZmrfdF85zwl3A2IW0KZGPUt4Kr/w6EZ944oP8zZ9tor0eBFOSeltPebCiUdFPJlnP4YE3euVcPNZKISVlvpD+7eONPnUD47sEdYwjpXEsCdeh8fMAJWSpfgZiM7Xgsb5MvGlFL4XWQQBsk2RU0qzQHF1MNTbZ0yFrpSjyJiptmOUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcbba1LtUTmUzEbbW+1gSnCWFTY1zYCZx5ZhJ+CE4i8=;
 b=VvVy4nERks0reJV8Ajt9tl2MAzLbft8M1rHesn1eQzoyqmCQLTc4Q/hnjokTaR4+W+vyBkPj7rXhMP1jbV53kE+0FErYzs1UImGiUOrVG+Z0RfkbBd5zMaRIFRFN1gthexVYktOiwSY/bOdEN7pH7j20tkmceTSy8+qeEU3hyQk=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5131.namprd04.prod.outlook.com (2603:10b6:5:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 07:18:47 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 07:18:47 +0000
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
Subject: [PATCH v6 0/4] Dedicated CLINT timer driver
Date:   Fri, 24 Jul 2020 12:48:18 +0530
Message-Id: <20200724071822.126758-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.20.29.132) by BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 07:18:41 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.20.29.132]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 379e6593-f982-4164-5bcf-08d82fa1ce19
X-MS-TrafficTypeDiagnostic: DM6PR04MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5131A5D2DC73A0358CBC4E2D8D770@DM6PR04MB5131.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNvmimoUvev41WWFgsHGFhXebTeHpP5orRwLgE7ZWk8Fr1BpK1Oe0HxmUmYukS2IV/BLLeeuU69VllhIq6UMFKDCpgWNGpz435oGZwkYyKiTyULejwOOpz1FiqdvSxs5UsX5Vl9LaDBUkdnwJ7/ixNUDl5RZU+CzttxjgwQt204pXzuGuBCzDpLXZiJsvWkDd1+/PszDltETthx12I+7vcjJ615MVRwWm7oBaV0zesDPG0hgfeAHfc0nWTKl5luGXR21ce5Z8kWbimC7AJDiQCnT9K9qB7mSB223+7A3W9bTg82+QOJxYItcugussrBx9iaB/bcvKxBn2C8WsqVyK8nvgfiJfD4gbTnb5gNBHQzyhOOQcNB4iCV3j7XtDWX47v2dphIt97lHXSr2bT5ESA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(7416002)(55016002)(186003)(478600001)(2616005)(52116002)(26005)(956004)(7696005)(110136005)(66476007)(44832011)(36756003)(66946007)(83380400001)(966005)(1076003)(316002)(54906003)(6666004)(4326008)(16526019)(5660300002)(8936002)(66556008)(2906002)(8676002)(8886007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sGDpnFNg2x2MsLarAK5QnG/TT5zOuRvlgZAXaRmzZEb3Bd4vTBqKRNVzNJj93u8TIvvhE9XZUDamYMbLtSS1laAhiwp/HHV6LIJk5Uh7wIbJB6t+RBQ94TvRPK0tm1cfTpMo6wRkcG3Wvv6Kld+zJeGclmfF69Bs2WFcemqCrLngJXxEMmvmK1w9bzDaT20mgt73wzhkHxbjRf31amW9oiWlSk7QYCKLe0bpLwk3xp7TgQGvzrfQTijdhwh/Sfpmbn7JB1m0JVk+GZQXCj4RJ3t7Znku2S2A6xBqzJtJKMNaCPAyBVM/Ddakr30KBsdPHRSP9dZz/SZ1NLlVavwcJXOCVCzWOtJOk8vpIuUT2x81l98uge5rhem0AZ3yobPI7aGUaPL/8kFlYXLwzuYObeG7cH9+fD6wTkG4WDvz6SQjMCUSCLlHsgkzz/ee40iXr5U3YFgUiz+cEt44FmH1ap4GY9+j8iy6N02xHG/xWPY=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e6593-f982-4164-5bcf-08d82fa1ce19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:18:46.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjObZe3w5licLFHWcC8E2a7DQT0oV6pswl7UoVKxTS/njnSf2a/DkY/UK52gr2F4BuKhRbc5Gioe48ezrhPcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5131
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

The patchset is based up Linux-5.8-rc6 and can be found at riscv_clint_v6
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

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

