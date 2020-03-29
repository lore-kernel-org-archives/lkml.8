Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57683C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37A120774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585481231;
	bh=XlD/rihe2uD3FtUjT9s0LeYEFnXi1c/4qrNLLeabtUc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZHhMBRba2MIowl3lcU9v+HlWF2Y7nLVwRUt/GTuY0yNej43lMdT1LTgooPzhlRq2Q
	 NM48MUaOzHjCyvf+1k12xcr5LiIjLmwZU5AfXlUBqK2tnna/dmy/2jf3wrBTda/E0z
	 b7ZWVT4VzjhhEPCUNqKW6GLvsgN+GaHm870g0w8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgC2L1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 07:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgC2L1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 07:27:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22E472076A;
        Sun, 29 Mar 2020 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585481229;
        bh=XlD/rihe2uD3FtUjT9s0LeYEFnXi1c/4qrNLLeabtUc=;
        h=From:To:Cc:Subject:Date:From;
        b=uj9I9H5L/EQkSbe4lV2BFzrGRWiUe6W3aje6mwGWqcgM8MY0zJ6iwvwUoTjXPZ0z9
         pFpzpbv2F44EFJOd6wvKnYA4fXlE5bepns2artTfBGaVjYRUcQKy6iHamMC3p/N87j
         pBprw75jXz61nkk8J4Y6mWR9RIG6+YGQiq5lNcpE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jIW5q-00Gd4s-Qp; Sun, 29 Mar 2020 12:27:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Anirudha Sarangi <anirudha.sarangi@xilinx.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Eric Auger <eric.auger@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Heyi Guo <guoheyi@huawei.com>,
        Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Marek Vasut <marex@denx.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Sungbo Eo <mans0n@gorani.run>,
        Zenghui Yu <yuzenghui@huawei.com>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for Linux 5.7
Date:   Sun, 29 Mar 2020 12:26:59 +0100
Message-Id: <20200329112659.327916-1-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, afzal.mohd.ma@gmail.com, alexandre.torgue@st.com, anirudha.sarangi@xilinx.com, Anson.Huang@nxp.com, anup@brainfault.org, atish.patra@wdc.com, eric.auger@redhat.com, f.fainelli@gmail.com, geert+renesas@glider.be, gustavo@embeddedor.com, guoheyi@huawei.com, zhangliguang@linux.alibaba.com, linus.walleij@linaro.org, lukas@wunner.de, marex@denx.de, michal.simek@xilinx.com, mubin.usman.sayyed@xilinx.com, tangnianyao@huawei.com, nsaenzjulienne@suse.de, stefan.asserhall@xilinx.com, mans0n@gorani.run, yuzenghui@huawei.com, zhouyanjie@wanyeetech.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here are the irqchip department updates for Linux 5.7.

The largest part is the second half of the GICv4.1 support code (the
*third* half will go via the KVM tree). The rest is a varied bunch of
feature improvement (level trigger support for STM32, multi-instance
support for Xilinx and PLIC, CPU hotplug support for PLIC, Ingenic
X100 support) as well as a selection of fixes (interrupt retriggering,
RPi initialization, a number of GIC blunders...) and cleanups
(farewell to setup_irq).

Stay safe, and please pull,

	M.

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.7

for you to fetch changes up to 771df8cf0bc3a9a94bc16a58da136cad186cea27:

  Merge branch 'irq/gic-v4.1' into irq/irqchip-next (2020-03-24 12:43:47 +0000)

----------------------------------------------------------------
irqchip updates for Linux 5.7

- Second batch of the GICv4.1 support saga
- Level triggered interrupt support for the stm32 controller
- Versatile-fpga chained interrupt fixes
- DT support for cascaded VIC interrupt controller
- RPi irqchip initialization fixes
- Multi-instance support for the Xilinx interrupt controller
- Multi-instance support for the PLIC interrupt controller
- CPU hotplug support for the PLIC interrupt controller
- Ingenic X1000 TCU support
- Small fixes all over the shop (GICv3, GICv4, Xilinx, Atmel, sa1111)
- Cleanups (setup_irq removal, zero-length array removal)

----------------------------------------------------------------
Alexandre Torgue (2):
      irqchip/stm32: Add irq retrigger support
      pinctrl: stm32: Add level interrupt support to gpio irq chip

Anson Huang (1):
      irqchip: Add COMPILE_TEST support for IMX_INTMUX

Atish Patra (2):
      irqchip/sifive-plic: Enable/Disable external interrupts upon cpu online/offline
      irqchip/sifive-plic: Add support for multiple PLICs

Geert Uytterhoeven (1):
      irqchip/renesas-intc-irqpin: Restore devm_ioremap() alignment

Gustavo A. R. Silva (2):
      irqchip/irq-bcm7038-l1: Replace zero-length array with flexible-array member
      irqchip/qcom-irq-combiner: Replace zero-length array with flexible-array member

Heyi Guo (2):
      irqchip/gic-v3-its: Fix access width for gicr_syncr
      irqchip/gic-v4: Use Inner-Shareable attributes for virtual pending tables

Linus Walleij (1):
      irqchip: vic: Support cascaded VIC in device tree

Lukas Wunner (1):
      irqchip/bcm2835: Quiesce IRQs left enabled by bootloader

Marc Zyngier (21):
      irqchip/gic-v3-its: Probe ITS page size for all GITS_BASERn registers
      irqchip/atmel-aic: Fix irq_retrigger callback return value
      irqchip/atmel-aic5: Fix irq_retrigger callback return value
      ARM: sa1111: Fix irq_retrigger callback return value
      irqchip/gic-v4: Provide irq_retrigger to avoid circular locking dependency
      irqchip/gic-v3: Use SGIs without active state if offered
      irqchip/gic-v4.1: Skip absent CPUs while iterating over redistributors
      irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access
      irqchip/gic-v4.1: Ensure mutual exclusion betwen invalidations on the same RD
      irqchip/gic-v4.1: Advertise support v4.1 to KVM
      irqchip/gic-v4.1: Map the ITS SGIR register page
      irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
      irqchip/gic-v4.1: Add initial SGI configuration
      irqchip/gic-v4.1: Plumb mask/unmask SGI callbacks
      irqchip/gic-v4.1: Plumb get/set_irqchip_state SGI callbacks
      irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI callbacks
      irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction layer
      irqchip/gic-v4.1: Add VSGI allocation/teardown
      irqchip/gic-v4.1: Add VSGI property setup
      irqchip/gic-v4.1: Eagerly vmap vPEs
      Merge branch 'irq/gic-v4.1' into irq/irqchip-next

Marek Vasut (1):
      irqchip/stm32: Retrigger both in eoi and unmask callbacks

Michal Simek (2):
      irqchip/xilinx: Fill error code when irq domain registration fails
      irqchip/xilinx: Enable generic irq multi handler

Mubin Sayyed (2):
      irqchip/xilinx: Add support for multiple instances
      irqchip/xilinx: Do not call irq_set_default_host()

Sungbo Eo (2):
      irqchip/versatile-fpga: Handle chained IRQs properly
      irqchip/versatile-fpga: Apply clear-mask earlier

Zenghui Yu (1):
      irqchip/gic-v4.1: Wait for completion of redistributor's INVALL operation

afzal mohammed (1):
      irqchip: Replace setup_irq() by request_irq()

luanshi (1):
      irqchip/gic-v3: Move irq_domain_update_bus_token to after checking for NULL domain

周琰杰 (Zhou Yanjie) (1):
      irqchip/ingenic: Add support for TCU of X1000.

 arch/arm/common/sa1111.c                  |   7 +-
 arch/microblaze/Kconfig                   |   2 +
 arch/microblaze/include/asm/irq.h         |   3 -
 arch/microblaze/kernel/irq.c              |  21 +-
 arch/riscv/kernel/traps.c                 |   2 +-
 drivers/irqchip/Kconfig                   |   2 +-
 drivers/irqchip/irq-atmel-aic.c           |   2 +-
 drivers/irqchip/irq-atmel-aic5.c          |   2 +-
 drivers/irqchip/irq-bcm2835.c             |  15 +
 drivers/irqchip/irq-bcm7038-l1.c          |   2 +-
 drivers/irqchip/irq-gic-v3-its.c          | 532 ++++++++++++++++++++++++++----
 drivers/irqchip/irq-gic-v3.c              |  16 +-
 drivers/irqchip/irq-gic-v4.c              | 134 +++++++-
 drivers/irqchip/irq-i8259.c               |  16 +-
 drivers/irqchip/irq-ingenic-tcu.c         |   1 +
 drivers/irqchip/irq-ingenic.c             |   9 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c |   2 +-
 drivers/irqchip/irq-sifive-plic.c         | 119 +++++--
 drivers/irqchip/irq-stm32-exti.c          |  14 +-
 drivers/irqchip/irq-versatile-fpga.c      |  18 +-
 drivers/irqchip/irq-vic.c                 |   9 +-
 drivers/irqchip/irq-xilinx-intc.c         | 123 ++++---
 drivers/irqchip/qcom-irq-combiner.c       |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c     |  57 +++-
 include/kvm/arm_vgic.h                    |   1 +
 include/linux/cpuhotplug.h                |   1 +
 include/linux/irqchip/arm-gic-common.h    |   2 +
 include/linux/irqchip/arm-gic-v3.h        |  23 +-
 include/linux/irqchip/arm-gic-v4.h        |  25 +-
 virt/kvm/arm/vgic/vgic-v3.c               |   4 +-
 virt/kvm/arm/vgic/vgic-v4.c               |  34 +-
 31 files changed, 964 insertions(+), 236 deletions(-)
