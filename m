Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF52C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725FC2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rQsKb7l0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OLXinpX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFKGO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:14:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22169 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFKGO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 02:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591856066; x=1623392066;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eOn5ER/b/ejbUDFEIssbX+livatM3KA5ETXmf3Txwkc=;
  b=rQsKb7l0+YyjN6Rs+XTCW9PNI9rQEFVtErfFiLmMgmOWLoxJPwuIGj6x
   wf0ZsKqPozNUums6Ymfg1hqJ9TkdRunB6VWCAk1tiucd0EDpiWNJ2bDZe
   zTR6izWHA3wehuTvrCl10c9S6DqkVQXwUksxZkNke553TmqT9RYPbdXG9
   haeQCA2TGIwg+iCdEwazNENuXNn87mtzEMOxoMEiBjiQFJUR1yeHLO/c2
   6Q2v4FVl7PQJ9/bq8OskOpR4+tYozQaFwlt23C/DcsTkJEnZdxcr5riOo
   vzDzPjikMF4/FND7ArT7ZHGlcS9XXWiWGkeWzvYw64DR8Ko8jIdFMTqrE
   A==;
IronPort-SDR: NSrhS4yt45KDxkc60u0ji4W+z3x9bqrlMvtF+vkO5BDFa1fX3iKd2bgjTeqa1Ce5yEVzjkr3gY
 bRd+oOsK1hnqhhUYTpHcLrtbjFSR+NOU0951JjkG6Q3+3uwf+PwgKZh4idHnZ1VyFRIpTxRyDd
 ezPeLd4IouwH64s/dpADyx6mbfzl0xHukUe9ZsHYxOe5eRQWhmrDDowyxEJnFH+44xe0ciiKUy
 LukKU9r9WN8ei+OBlMGhS4AhgQtarH3ruZI3xdsBv0M4q8/RlsEmu0GahCGv6xpQMwp3FN/Taf
 568=
X-IronPort-AV: E=Sophos;i="5.73,498,1583164800"; 
   d="scan'208";a="141117299"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 14:14:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D58hPZL7w+cgWTorKm++hKr7B1gx6RyAFxoVgAZHjkedodsEw0w6cR36eNS39iBLwxWVXraIUfEG2XqBtsjgS+N1CxK1UM4bMKi8a2ZkqByaESzzbCNEG3VuUlB3SjAD7qxWDibv9OVmQ9VzHPu4917XeTMLMaBf6c7Y2H2e14ns0OnFFLjIvizJHzaS7LlpgaaxeilG6rwXvHVSVRVkptVG7cDaFsloc/ZW1JTppdHYBpAUrJtUfMmh3V27eHs14UrrYBEFXWayXTPPN6XZ64IxtS/LXcNDaxHaJ/LSrken67MNvA9LS3ODFqRrncq5ggcY4CNWHEttE5eVPLZwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DgspORC0G2Ec2gHfY9r/7RcFUEKV22JPuYoq+paU5k=;
 b=GUGTLzc3QuAN4a0X3MaDxpGwXqNv8DUQ/2ZdfVLpwaM/3acC4aZWeRvCwFZsafo0+NjpVPbd9HkBUsajg/FsXOEuKpI34KzwEBw4t7RAeos14mz1byxLWsO5VhmLyBgEd1L1cfHGFxcFQaCm2MvSBdQNEh++N/cYgHeI1zU4IkbeNeFlf8/ZqwypMujjUUxXi6bDAcWmN25S/r/Wicfqljem3vAyp9jf72nlbdw9VSg8HzI760AFPGRqIkQbckhkvjUvPL9R9ix2H0VVRFqsZFk5ug7l4NCSZc7HytWau1RkyuUrWXc5bIJD1wfEsNRFfN+D+pyWuBEF/5QadYC+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DgspORC0G2Ec2gHfY9r/7RcFUEKV22JPuYoq+paU5k=;
 b=OLXinpX5sw3Dn7wYMmGSpbgF8htx5MX1gJjLmEblX/p+SWCZ842NTUn1JW4REDK1eVkAWe23mg38ZdPkcP4VA05ePdLMpG9EMH6EYALSEAfO7S6rFIPe79XVe+v1pJ6+Y9J0QhLUOVuU48cVF4IdifGUzdGqsvRtxc3BxVlqJ5g=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6332.namprd04.prod.outlook.com (2603:10b6:5:1e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 11 Jun
 2020 06:14:23 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 06:14:23 +0000
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
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v8 0/6] New RISC-V Local Interrupt Controller Driver
Date:   Thu, 11 Jun 2020 11:43:44 +0530
Message-Id: <20200611061350.434293-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17)
 To DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.182.246.89) by MA1PR01CA0077.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 06:14:17 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.182.246.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33111e46-7eac-43a5-2323-08d80dceaf23
X-MS-TrafficTypeDiagnostic: DM6PR04MB6332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6332693D624A7B4F5ADF205E8D800@DM6PR04MB6332.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2d1z6+moVvjv21YcQHTtM+x5CydaqWnoPKauTdRp77axU+7e3EycclBwCh2DU0X6ZXDDq/g3Tfy7oEUxQdXbxGT0RdzZ9bH4utRj8tDH8ZwXrNUJKGCO7hJ9ND8SVHTLh0P4aNSSoILsPccedlr6z/9VW5bfBHuefIWueyDf9M+CKDoBQleqnc5DfxH3uI1wfoNYHIYj8hL72Ds8oV8dOL7NcVBVzUQnHqbFmpFxJhl4O9ConZVg0+VzXdLo2Gy3GKOK2e41/QFHNrsRwU9wHt8KXenOjG47MyGs9rxmwm7zPr3ia1PYL0WjJ/GwjNF6W17xk08tZAfkz1WQBPPxgorgonPA7lALPrDB/xfZnBj2YVUIKVbUKIcd7qkaqweUAgFs6GQW8nkmcFiJMVmSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(36756003)(16526019)(4326008)(186003)(44832011)(2616005)(55016002)(8936002)(1076003)(5660300002)(956004)(7696005)(110136005)(7416002)(83380400001)(478600001)(52116002)(8886007)(966005)(86362001)(316002)(6666004)(54906003)(66556008)(2906002)(8676002)(26005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ulLCRJ/3D7NAsZ4YPQ4Gam8dJlVQzpaUF4Lw5sEouOklmJkxWYdjA9ldlxp22PIX6tW5bJTqYN8+V53FnvnXZMe0CdQtXWJWAPplhs7lT1nOTIVUxvk9t3g5TXBwZcSgYi0zA2UKwVxVPvtLJmWDZoiQA3+8PUgdpgu8l5JVq4IE3op9q2auhmiHg9ucMZ3/1ADjn9jE4YP/czBD9JZr7r5BwZArlrNfSoYWkdS/3SPI3/5F2fB+BmrggIYGVakirzmPWfgKrqDtaaeSJeWho4G2m6/9RlNx5OX/HM4118aicdEoz6hvCHPxyZ2x3h57QaEZPvzFtq9JBYWszHsY/EMF42wNr9/wlvp2/cxWb/Zy9A7+9wtkjIhDH2C8swsa0LjyLm0cwV+D4NOsTc15gMO6XTFdI5DztYN5Uck0bAIYg1ZH1wwul8ovHwD2Vg09IF8rM4or+4YCWBUuIynsHnOyM7I7hCNRWsd0EryO9P2xWjJIx3+FIdY6IN1vE4iY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33111e46-7eac-43a5-2323-08d80dceaf23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 06:14:22.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBr9enE+Ts4wG/PDknkGNAcD/X9Tc2g5DNv75aLE+udO/7xVhZQ0b/q+zUzMz1gBIxzzVamZ8C1ouGKYHzjG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6332
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

Changes since v7:
 - Rebased on Linux-5.7 release
 - Minor typo-fix in pr_warn() of PATCH3

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

