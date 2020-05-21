Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B87120721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n18AuaZ3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vDM0xBgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgEUNqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:46:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32012 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgEUNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590068776; x=1621604776;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=n56Ua0gVn4byYIHurAUklEE7cP4RIhB1UyeY0jy3nfg=;
  b=n18AuaZ3foC3BROfYGG4Up6Rh7pXKn0K7zm6atTJw8dsBfWmK7vOesES
   D7fkWZwOzyOkw99Mmt88ewySzQFpFnylsoyP835DYYZjwDxXFiTE1/PVw
   0XgZmi9KWNW/FDC3SF+EO8kHexLwgYHQMqVyLE8Y4f3SRgPSOICBInDrf
   Z/kBQTiAiPz1sPWM+cOQ1ec4IPhDvmE7YBT8l5QJGj37D6k80Htg3G75N
   UOIW6vfTnSb8Yc6/WcdWZcHzr3qOkt47qmwrTdElHAq5ivvmGHT0+Jl20
   bRz+CpC2n+KH5GU2APRH8fYKRtnxkOLc4FX/BBT0yrZPFKgeuT3qZWqC8
   Q==;
IronPort-SDR: TfFD6fqapxvDrWiAU+EEPHeMPLdJcoZX+Wz3/oGn3+huVUz2avDg5vNaNP5GyKNm5lYN8goemz
 xXq1ZPf45t2eJQTkT7Iz1k0okmzFlaVC3nV468uL8g6ZHJnw8XrgiSu24CUQg4vgnUVSNHWi/U
 WOkljO1ggqs6bNNZT9S4u3ZaIMGM9c5MW+1vlj1yofZ8JlR6zT/VXzmPzAP2NoKvgw3RGWUeeb
 3CJtiuvRZW+DzeXJfgpYkuAtJMNMCv4sybVhKNCv6glyAw05R3CXh3UPN+tf+/pW2HlnXZOdCW
 HyQ=
X-IronPort-AV: E=Sophos;i="5.73,417,1583164800"; 
   d="scan'208";a="138544969"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 21:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y80ztxqXvo7wsKkfM4RbGDR1ef89f/29TlqKDFqow6I3p7zVrueooGWsOPaBt8bcOdHkIqURizPv8IGUi2hCzyCf8KXsQZhYco11RGmYglMVOhB29+ZXAvBfs9wEDbRBcLoMFhmWz4wQuXYiBf3dqPJzO3s+aAuWcTKe49JKHWUEWpv/XcMTyfN+lNyH91PsqxN+G13+rTFj6FV2FcyLohy0hiwm+eaqHzk1bZe/Jl95tgsmsCCB/BRaBAbSlTIqQoMMicOJcVK6kGvZvVFgK5P8b+jfQ21NasQWcIvTwlrkfkF91S15zoSihmTBkDlQsCMju0sC8zp6k05LOflEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qUZESzc8reHR6IMWEZEygGJnIDg2AVuUWY03NpW/EM=;
 b=JjndAGKAoo2XNK2ixBskXmaLpItSmMcl8rnTw8fVLA/PxMW7I9wzrtN2a/uL34BZVOroAJW+2X15uYMjJY7hv/hzxt9uMqpk2DK7qgjqHpSAE7KAoUoADnUN90dAfa4iSVn0Gxgil+/IJCVKZZSnvO7/C1CFujOnpNOyj2UrM1voTo+5+0Y9kF+10BUs/4Ej81nsIO+gJMH/bDqhU+JvBFyPUjFOZZdp2gekmbr8ZqX5/mYKlrd1GxG5iBtZLKcI6BNhZK830q7tDRiUJSvpxGveFt2WBH00KHlyIgstcS9mJ5VZIi7MC4+hjlpHOYgGtdZ58zaI3kg9eSwrU7AFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qUZESzc8reHR6IMWEZEygGJnIDg2AVuUWY03NpW/EM=;
 b=vDM0xBgQr2PiAyG0LqZOzcxUzLS0Glwy60p8Jdk7G2GRqK9a4Qod0Rv8bEb7sh9SW4ntlylp2U58TUbC/nP4MPnTxPTdpMKJPW2N0KWPcIx8uP1+6h+/pA/ZasMpflFaWZE3K7q+Iqzx8GhA4E4Ujut8RHAQNG7klzouB0wzrt8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4985.namprd04.prod.outlook.com (2603:10b6:5:fe::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 21 May
 2020 13:46:13 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 13:46:13 +0000
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
Subject: [PATCH 0/5] Dedicated CLINT timer driver
Date:   Thu, 21 May 2020 19:15:39 +0530
Message-Id: <20200521134544.816918-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::15) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.72) by MAXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 13:46:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f8122ff-1c81-4087-6eff-08d7fd8d536f
X-MS-TrafficTypeDiagnostic: DM6PR04MB4985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4985F4BA5D66899A2EE055538DB70@DM6PR04MB4985.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMmJtdKiL3hLbXcGjlgoI0qC2KVRnuFgZcs2xMhi0S1Sp400TvfxmIWjURo1sZKuJgBz6I80cOoWNFYqLZrNml/LoPHVlzFrQC2StdhPHSbaw9Ia+kBR1xLqc8J+yUZqr7km4GJ3r3O8dnUsoFlIXrZ5Y+qiTILepnzgCtol624jpAyslhvBkQjgjZnwnmE4gQTUy30koT4kCdLKaL9sxJ2VwER4+bwzkL49DrmNINPXJTJ5n+SBBt5Mn7VGI5z79UMx2Af3ItgQr7TID7W/75IW6HqBI/vQwC1OzPm3jLuuCbm02AaHh9gKgwKXwryV9GAV31VrNtpOQIqH+dZvcWm1mI7l0DZG5SwFbb8TAvcegrtoTgKVHVCTQpv95B26CpzXTPkmQPfH7jx/ASOrJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(55016002)(1076003)(1006002)(7416002)(6666004)(7696005)(2906002)(86362001)(55236004)(8886007)(52116002)(4326008)(16526019)(186003)(8936002)(66556008)(66476007)(66946007)(2616005)(956004)(44832011)(36756003)(110136005)(54906003)(478600001)(5660300002)(316002)(8676002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Guqs74YlNcWbPq73jwGOHasNoW5hkKWqooqvmWJDbEflb5HKPLE9aNYDKvfwhC9G38+7hi8kQjyxSEmO6fnpEEDlCQDzbSNnoFYrWz2rEPYexbok33r6l0QDAD9vTdS/uYf0HFvXif/tO72jXCvb7BpW40ltTAJy7BnvokI1qMYxgACUENbdH1ckobrVvdm6HhG0yDFXyugnreLjTTRp3HwZSerpusV7IouGdo14uwbbby/7DXWmNxRS3D4TJ+5G8JFctkHAaEknYvIsFd5hDc/kEhBsdwp2LootxoNtkhqeNBwNtO7WKuiBftrj0YNyvqczquVPaKPdAm4GNvSqBDjCfPBSD/XgBfxlDO5Wq34BvZYNL0XZZGB//hQcOzXM1w9PKevJBYjr3Symb2+9QMq/Jpk30ODFed1WZHY7zKNS+hdLcdqLi8q0V0TSVI5Hg0UZp9uGre5VMd9TC2HfgMDa/PoMeLQzNPDq9tMs9PE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8122ff-1c81-4087-6eff-08d7fd8d536f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 13:46:13.4438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPASQxIdN0Gn1BPTYIKQxiIZieVUs0PjD0nqXbV8MawaHxjjtEXpZuxzrvR+uz13c+99qY7Vc8/7fBHZA8bdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4985
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

The patchset is based up Linux-5.7-rc6 and can be found at riscv_clint_v1
branch of: https://github.com/avpatel/linux.git

These patches require "New RISC-V Local Interrupt Controller Driver"
which can be found at at riscv_intc_v5 branch of:
https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

Anup Patel (5):
  RISC-V: Add mechanism to provide custom IPI operations
  RISC-V: Remove CLINT related code
  clocksource/drivers/timer-riscv: Remove MMIO related stuff
  clocksource/drivers: Add CLINT timer driver
  dt-bindings: timer: Add CLINT bindings

 .../bindings/timer/sifive,clint.txt           |  33 +++
 arch/riscv/Kconfig                            |   2 +-
 arch/riscv/include/asm/clint.h                |  39 ---
 arch/riscv/include/asm/smp.h                  |  11 +
 arch/riscv/include/asm/timex.h                |  28 +--
 arch/riscv/kernel/Makefile                    |   2 +-
 arch/riscv/kernel/clint.c                     |  44 ----
 arch/riscv/kernel/setup.c                     |   2 -
 arch/riscv/kernel/smp.c                       |  53 ++--
 arch/riscv/kernel/smpboot.c                   |   4 +-
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-clint.c             | 226 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |  17 +-
 include/linux/cpuhotplug.h                    |   1 +
 15 files changed, 330 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c

-- 
2.25.1

