Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0922BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3EF12065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mxz8YiKj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kcer5Kx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGOHPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:15:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34248 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgGOHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594797336; x=1626333336;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tII83LcBFhSMiQu4pxR9wevuAlKOb2j4ZkKTUpjbLSE=;
  b=Mxz8YiKjaWUKGq5M3LH/pikQNdKtkW51pjCRDwF7xnkY8X2R7iqpIQ2T
   b/rT0CO3X6fbTO3mJnfzf1e+ZuwG5e4W3KwChg5+4Kaw++zELZetwMKNR
   GXGQXRaQfUlpj/M0Nq6jyAxP4D8UgR2j1Mojjir8f4GDKGeXdsdNDYNUe
   sG/fN5u+A48i5u2Rwl4ItKYqbQVKqxso7OCKKa3njNxWPJxO3+k8W5Usj
   bO+wuLgkBKw8K58r6IegqbhNViIE/rVf3s07Kzy2hkixjw5BvLOv4p45F
   P8t8O9kW9vtFmKLNXSHCFAol1ar9mZ8IGvvp0yFEsk80RtKR11mN0P3KE
   g==;
IronPort-SDR: Fue8FcHLxrcUvQ0zoITVdY6xjDsIbrPDSFe8m+ekIasY5GzcvX52Uq1vqa6lDSMjCcJzzVHqEQ
 yye6CUghqFy8iIqtkJ/KuDP1lPL+OaE3WMn/Syx9Ux8oM671qHPLdXRYX09URdVyNLyqikXDuj
 7FntecqfkEfk+Lyc8xEEW0zTGvIOxDJNNVE8FJcjjirZ83MtMN198qm3yTs9yHlIl0qWbseN9V
 3icGbP9EgN+P7eq73ZsuORCl8u2n6uF8HUkKEpyeo6XqzxMIHTF3hSV8mpsczyApfCcWLUNHvu
 Ibk=
X-IronPort-AV: E=Sophos;i="5.75,354,1589212800"; 
   d="scan'208";a="142495400"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2020 15:15:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLGyQ6UNyGq8c23x+aYGvsvK7qVLmSjlWgT43YtOsPP6aBvz05KreeMkn1G7ez6FMUTe4Lb90Iv46ayZis4rJQ3XetSNkU3/SQ1o6GEptpGrRAMtQCbh7d24Byfy5KgASCJe01Mqf+fQJHtKvB7psf+89YBtXESZmI78IpPm0xHdnUNnOjAcbFJq2fGXpbvIFxSt53otN7aidZi2hjb02MJ51A5+9s4/6lDsdNKBwfROgWCJNZG/scMBmVw+99fa8CVlyWNVfSVKhPHq945ocF/yVYq0tXTtWoz5k2udXzfqu+icKIee3iJ6o/nemwLveeEHPFtnrw7jufSHLQ4qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS52t0qr/fipFdFVxhmkZ2pmHbAVQUNqe1V0zCmmJ4w=;
 b=PKlqV7lW74Dw6F4XhFMfaq4aNMZe/UVKkh8FlqXIbSNIOseRpn9TLT6Ip4qimI+cqKwp61HJsO5jXLyq5nqVKEJiNf+HZ0VnA5XXFKAtD90vJeXRtzvlp7ZA0+oZ3ES/1SVvDvHlTwMQ0DwMLUY56aZ+xmO/T2cu51FaWav/vGSYdmthxZwevaVzVMkbzLhNQbABLLycxfWz5p1h4Ysch+GbBL+M065VyjL8FwvnhlGSB9KOfTyotabWh1dq6jA4dUogYSgx7dDvwwoDOWBEwOIcJvjNZOIOSBH7/FKLFcTYKycWHiQea6A47wwQEv2b5MIDzW2NC4ujvLYlDQg7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZS52t0qr/fipFdFVxhmkZ2pmHbAVQUNqe1V0zCmmJ4w=;
 b=kcer5Kx0jRL5eRWCLHylx/7QQQM93NemjnCgFrW37+vb2AaUZn4GQ2LMojVSxgDJoQrCpbwEXOZpD/84WY0bg9HBWzPWxyrKRqWKbqUENoNe02vpLGcBmnDxbB4Ih6z9CAESy5HXydzcPUeczGURq2QfBMBkWQJJA015+PrLSPs=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4329.namprd04.prod.outlook.com (2603:10b6:5:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 07:15:33 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 07:15:33 +0000
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
Subject: [PATCH v3 0/4] Dedicated CLINT timer driver
Date:   Wed, 15 Jul 2020 12:45:01 +0530
Message-Id: <20200715071506.10994-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.15.57.135) by PN1PR0101CA0047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 07:15:27 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.15.57.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c0d6489-06b3-4557-e4ad-08d8288edcb3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB432934A591A83D2287014F668D7E0@DM6PR04MB4329.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz4s/SK5c9t8r1bBoIB17pJQJR5DEpAEDfopXrwgQ6GgcDkhs5ZT9oexQXvYpMi2pxA8CDJ7JcNwU+CHtvc+wINAyWKniejvMJvdGgx3HKJlVHVox+dsimiITlmywaWPxdMNFUY1L6TtpaHcSspZrETdt5Boj/t6I0qgEcqXMlGVD4nnt2GbrOBsWEnuHLoSBgtnXT0r7UDE7tiuZYrVkc9UoKvs84/VFCNkd5luzjdiTlb81nXKDuOyzf8ssLEb1gb5sfLjBr5jES3okruG5LJHzKmHaM0MMCfwBF3PiUkgfsyV7LWTFBb08lZNW8RlnWXYMGvxwoDHg3BqWQEvU3O5/BfVGAnoNPQRnSCH24aJwBVr+J7BdXNtbvgI8XD6eYCTl4wqM9szAWfYnhz6Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(8936002)(16526019)(8886007)(186003)(44832011)(36756003)(7696005)(478600001)(26005)(66476007)(7416002)(66556008)(66946007)(54906003)(110136005)(52116002)(966005)(2616005)(316002)(956004)(6666004)(2906002)(86362001)(55016002)(1076003)(8676002)(83380400001)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Vc5wdxrplfUKLsdUhIzUBaM66kPe7UPZ6vVQD/Gp9szM0aIEFP55Cv1/W8FqBe1ZqqoJp5hGK9qQQutMyZTczFkN7KKarvgAGXbI39dVMGpDQvKSjonX92j0WXt0CNEUDnDe0ORPSMHEoLndmwR2lCJA07Ofekx9w1YbKsRE2/3CuAC2RMc2QYgID1cdMnmKPJiM3tDSzPyeocmsoJK3Y5Q9vV2CaOnjLH+Dy0t3gK2Nxe4bBTsy6m26Yd91Saqio6w0t/pZuxgW4B7VrAwSKy5zPnCkci4nAnK6eyukUapOezxkqBCSS/GZVaF+8dSxyHap/YOg2ThcBTBXkr4ZyJRPEnAewGaVu3QkyEwI44R+h2nmsJSxynkrYEt07p69dnIq3ugNIwwigh6nQzUs+WeyvlKJh51j55vIhCiO9wnG5rZZnr35N4fv+uJhChBrVIReccUOgdy2/u91TDmPRPcVACAXArXMN4Burzbubps=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d6489-06b3-4557-e4ad-08d8288edcb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 07:15:33.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iU5tFNf/l2PQn4vXEanPgC9a2hBfWztoGFU4GIj4HxJwC8W+BhAM2otyYa5TsmME/rkf/hsasQiBBlPMngcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4329
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

The patchset is based up Linux-5.8-rc5 and can be found at riscv_clint_v3
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

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
 drivers/clocksource/timer-clint.c             | 229 ++++++++++++++++++
 drivers/clocksource/timer-riscv.c             |  17 +-
 include/linux/cpuhotplug.h                    |   1 +
 16 files changed, 369 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
 delete mode 100644 arch/riscv/include/asm/clint.h
 delete mode 100644 arch/riscv/kernel/clint.c
 create mode 100644 drivers/clocksource/timer-clint.c

-- 
2.25.1

