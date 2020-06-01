Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02930C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80A6206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NiMgk/2P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sm7UwBbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFAJQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:16:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33265 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgFAJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591002986; x=1622538986;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=S1VAJNCRy8sSUFOGZ7ZWAIWaiSuJm0V+/7HstgBGLl4=;
  b=NiMgk/2PN3Gz1LspXOq6ZQ45RPxgkKm7+eZL/3wAShP0Q5g3so8FnPug
   P0VjMJJIJr/38Bc+C9XMhJz7Rw8s5sMHBlOczqNnhgT8vY+EUpCe2Ogu9
   GaZf6XrPS7VhI3ssv3WNYIy9WPmnIQ8TBZE4qs4yoVFiZzUI1lYvigoQ6
   BC23O5zpZzbPntaTqVtJoI+Ur6UfC53Hcg+8Qwm4zLaPvdwsGZzaPpe2E
   8wdJBnoWu/ScIuKqjTb671RJlDocr/cozMJnbEOu+r88bCEoUR3s8bBAk
   OlcBm7jJjp6cm031r4/x50sdDjS+wdxPAqlz/u41KLrHCP0s8/eG2tpv5
   w==;
IronPort-SDR: gpUVvKMGGznJaUo7vB2lSnYqvq+wFsDHY/cQsU7iD2ZgRoqsHMVEncwQeDwt/QhK9k2VGWDam6
 e3nnTsEapmBYP8oomRkHwLO78EYTn3Nz09cQFvg3wlNgk0CyN9uc2fkfMUUihCIY3z1SBcSg8Z
 Lr8W7s2sMTZyvQMHaVVcFXodL8Ie50M1Z9VnfCXAO4yjTUrGTzyvaEKGlvsjNBMWFsfrQRB2t/
 I1VSCVMObj/551K5wEkwudEaJIdEgyOTTaDGRi9sHjf1Cb0etgp9SL9XnwILgWflJYRFXIO008
 IlY=
X-IronPort-AV: E=Sophos;i="5.73,460,1583164800"; 
   d="scan'208";a="241785954"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2020 17:16:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViaaxP25gQzEV2hatmuu/C70HNE7ihW9gC3wKr/2bj9BndZcd3VGENNPhtfT+tuKxZgcnioHmN+goBy4soBx4YkIa5wbB2tD1TfDeiezUHdyltF62AS8y1pZqtvtgvciF01HwgZPxdpaY757KI/vS4x01AWerEdEPM3QsdLhr2NpDMafCCIgo4A2eRYfRn50/UxWH48nuzpGEF4PlKjLaG5CfWWpGOBwHHj3GUO3FmphozpLE+8sO8GhiMbphHnaJEeolb74JBlx0b9hOKVhrua2nmFJABNU3MriMAkV7f9RB7kayCmWj4bkcyPFTwr9xvfv3nXvWYuhjvJLeYXV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9VQTVyN880j1o95PCatVEzALLSh0rGtsfOE3c+OLcA=;
 b=kpy2lt2l2OCg6nM4z0wdsRIFQgiPm2ahCYDaHkN6VAAPc8z8DYRU5Z0EQvvkm0xHv+XDkFTekZH8yC61h20zAgNTmOXsMpEjv9/MRMUWj9ac/ep/dbI3QVjDQOKrVmNCvMsQXMDQVXD29d5aCneclaWNKSgBaBnd+yzFVMBfubQTONCG6zt7ZOeChetEE28CHNTmssR1OEczVNgXgH1K1cOrS+nvqZ8bKLqSDCHL/QjXJ1kHasZTiMxbCwYVN05eBttr46Wvk8Hqxz9x7lIGsPfMb19br1j30A7rMuqUx1NLgZgxMIFiw54NkYO+cduOx7lBor/AVw8TVviGfE/L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9VQTVyN880j1o95PCatVEzALLSh0rGtsfOE3c+OLcA=;
 b=sm7UwBbIgx5xxiQ2h8dL877q7U/yWaiSAIzKHyeltacbUxFYxmhLCZtjNSbxbQxQP1t7Z9QWOYrzdEI5TlDKOWeoNj8227iqcvLdwqwD7PcqqIYjL79Xb3CyKc0e4NLrPjJNMcBydkBbn4CX0YB0AhL66n9DAiqIM7QBsx2K9mM=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6955.namprd04.prod.outlook.com (2603:10b6:5:240::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 09:16:07 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 09:16:06 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH v7 0/6] New RISC-V Local Interrupt Controller Driver
Date:   Mon,  1 Jun 2020 14:45:37 +0530
Message-Id: <20200601091543.943678-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::26) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.23.166) by MA1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 09:16:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.23.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72a4b38e-039b-4e6c-98d7-08d8060c6a53
X-MS-TrafficTypeDiagnostic: DM6PR04MB6955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB695506B1DC33214972273E828D8A0@DM6PR04MB6955.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUBOnTS6ERzIcMPn7girln//HQPB+tIOFD804NSxKBUzMNNds4FQluXXqhbcPg2VnzxSNs2IyYVHD4y8tgTeHJaC1Z5PyQb/eYMX/gtMij6dgB9H91tGuKOhLF0O3msxfgTN4nPA2hkiKLDJUbnWt7vV298eL712OEfBJATC+Qz8CuepSNmU7UKxUhFXvFWmaIKM7i5SChly4MkUuIZJCMNj/xoSiCe36ja7nqgn785TLkGnUrm4ckbr81Ffw0iV6XcFVWopVkattU/PKFR0TBLjLvoOVlDb6U8+4mTHkUgFpIox1VZyAKgqn5eW2ReFU4TbwZf2jfTvJH6ixf9hVojPKVhI+7Ukvid9ki67RB6Sfg9RYqwaQze7PbaeW3f3NrjsozyKrwyLddCmrfqSow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(2906002)(8676002)(5660300002)(956004)(2616005)(44832011)(7416002)(1076003)(55236004)(16526019)(55016002)(86362001)(186003)(66476007)(66556008)(66946007)(8936002)(26005)(6666004)(7696005)(4326008)(83380400001)(110136005)(966005)(1006002)(316002)(8886007)(478600001)(36756003)(52116002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fRcgurwQTFHJGtd63c7NqG+Fy8fX6zupTk5vb3Xd4Ayk4bLjyxrw1TL9APSD0JS8Jj7LYyZJ9lCqi9lOQGaq5SIe3hLqq22mdpjEYh8jAswol4MX8rTv/8jjKNEUkL4rPx5emk/BAhmZuIIURcfIa5I9JTF9cw28P3zPJBTA8kYEU8yQ/+71yvlkoHxN64bfFkMS7LVmPKt6wPdkf6kk1nE5hU0IaQXQ/ZqzCIHNK6c8E+2YSc0JFHGBMDIQc0gNTCAMIybAhSrFDBnsQ/7eZGoBDSxtIM9oFZVMHn2Exywx9W8ROxTPiZT+6jRo7zVHFLrfefo8e6z5JC+ELOPfRakCShWJWcGZQgLZRxbfQJXxCAg645NjJDGPxILwgQbn5G13IZu90FJC7w8UeSYjH4Du5cK7VsHzpWBt6f5tlEYXabSaKhtQ/NlNJqZc26V621qydK6SFvc4xPlKCvfqIyF108l6bzYe8af9h0LklmE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a4b38e-039b-4e6c-98d7-08d8060c6a53
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 09:16:06.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKXsVjMGbtzgsYAQK4hi2aTT59G6d6fedLI6XJNsCUE1r1v//bI5GKa0JtcU8+N5G83nlMkpqJLsGwdmCmTBiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides a new RISC-V Local Interrupt Controller Driver
for managing per-CPU local interrupts. The overall approach is inspired
from the way per-CPU local interrupts are handled by Linux ARM64 and
ARM GICv3 driver.

It is a major re-write over perviously submitted version.
(Refer, https://www.spinics.net/lists/devicetree/msg241230.html)

Few advantages of this new driver over previous one are:
1. All local interrupts are registered as per-CPU interrupts
2. The RISC-V timer driver can register timer interrupt handler
   using kernel irq subsystem without relying on arch/riscv to
   explicitly call it's interrupt handler
3. The KVM RISC-V can use this driver to implement interrupt
   handler for per-HART guest external interrupt defined by
   the RISC-V H-Extension
4. In future, we can develop drivers for devices with per-HART
   interrupts without changing arch code or this driver (example,
   CLINT timer driver for RISC-V M-mode kernel)

With this patchset, output of "cat /proc/interrupts" looks as follows:
           CPU0       CPU1       CPU2       CPU3       
  2:        379          0          0          0  SiFive PLIC  10  ttyS0
  3:        591          0          0          0  SiFive PLIC   8  virtio0
  5:       5079      10821       8435      12984  RISC-V INTC   5  riscv-timer
IPI0:      2045       2537        891        870  Rescheduling interrupts
IPI1:         9        269         91        168  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts

The patchset is based upon Linux-5.7 and can be found at riscv_intc_v7
branch of: https://github.com/avpatel/linux.git

This series is tested on:
 1. QEMU RV64 virt machine using Linux RISC-V S-mode
 2. QEMU RV32 virt machine using Linux RISC-V S-mode
 3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)

Changes since v6:
 - Rebased patches on Linux-5.7 and tested with runtime CPU hotplug
 - Minor changes in PATCH3 as suggested by Marc Z
 - Don't programm PLIC threshold for CPU_OFF in PATCH3
 - Simplified finding IRQ domain in riscv_timer_init_dt() of PATCH4

Changes since v5:
 - Rebased to Linux-5.7-rc7 with PLIC improvement patches
 - Removed riscv_of_parent_hartid() from PATCH3
 - Addressed other minor comments from Palmer and Marc Z

Changes since v4:
 - Rebased to Linux-5.7-rc6 and multi-PLIC improvement patches
 - Added separate patch to force select RISCV_INTC for CONFIG_RISCV
 - Fixed the driver for Linux RISC-V NoMMU

Changes since v3:
 - Rebased to Linux-5.6-rc5 and Atish's PLIC patches
 - Added separate patch to rename and move plic_find_hart_id()
   to arch directory
 - Use riscv_of_parent_hartid() in riscv_intc_init() instead of
   atomic counter

Changes since v2:
 - Dropped PATCH2 since it was merged long-time back
 - Rebased series from Linux-4.19-rc2 to Linux-5.6-rc2

Changes since v1:
 - Removed changes related to puggable IPI triggering
 - Separate patch for self-contained IPI handling routine
 - Removed patch for GENERIC_IRQ kconfig options
 - Added patch to remove do_IRQ() function
 - Rebased upon Atish's SMP patches

Anup Patel (6):
  RISC-V: self-contained IPI handling routine
  RISC-V: Rename and move plic_find_hart_id() to arch directory
  irqchip: RISC-V per-HART local interrupt controller driver
  clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
  RISC-V: Remove do_IRQ() function
  RISC-V: Force select RISCV_INTC for CONFIG_RISCV

 arch/riscv/Kconfig                 |   2 +
 arch/riscv/include/asm/irq.h       |   5 --
 arch/riscv/include/asm/processor.h |   1 +
 arch/riscv/include/asm/smp.h       |   3 +
 arch/riscv/kernel/cpu.c            |  16 ++++
 arch/riscv/kernel/entry.S          |   4 +-
 arch/riscv/kernel/irq.c            |  33 +------
 arch/riscv/kernel/smp.c            |  11 ++-
 arch/riscv/kernel/traps.c          |   2 -
 drivers/clocksource/timer-riscv.c  |  43 ++++++++-
 drivers/irqchip/Kconfig            |  13 +++
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-riscv-intc.c   | 138 +++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c  |  44 ++++-----
 include/linux/cpuhotplug.h         |   1 +
 15 files changed, 252 insertions(+), 65 deletions(-)
 create mode 100644 drivers/irqchip/irq-riscv-intc.c

-- 
2.25.1

