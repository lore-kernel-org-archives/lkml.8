Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B49C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395AF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="s0amyLnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437196AbgDNIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:52:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15190 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437054AbgDNIuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:50:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 491dgS2JJKz9tydL;
        Tue, 14 Apr 2020 10:19:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=s0amyLnl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PaihnKQY4NHJ; Tue, 14 Apr 2020 10:19:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 491dgS16YHz9tycJ;
        Tue, 14 Apr 2020 10:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586852356; bh=GMrCjNEWVR8Y/FEQ5WhfC37NQuAEPumqmo0nYt9WLpE=;
        h=From:Subject:To:Cc:Date:From;
        b=s0amyLnlMQABR6KuiAkBN7Qvv+oMmu29N90RlNa8Z1iCTlRwt5fd0+MuTmhctVZph
         2xrDDnh63ZbKTyycUBgYDWhPpBY1TsKG4IDgRDID/C+FSjSC/SeTvMezp9ikZrqTJL
         It/r7wCgKWouoC5CUeJnZohgCfm1G74rinLWBaU4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2952F8B797;
        Tue, 14 Apr 2020 10:19:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rizMjqV5zcdu; Tue, 14 Apr 2020 10:19:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BABCA8B796;
        Tue, 14 Apr 2020 10:19:16 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 77D936578A; Tue, 14 Apr 2020 08:19:16 +0000 (UTC)
Message-Id: <cover.1586852082.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 00/13] Modernise powerpc 40x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, michal.simek@xilinx.com,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Apr 2020 08:19:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 and v2 of this series were aiming at removing 40x entirely,
but it led to protests.

v3 is trying to start modernising powerpc 40x:
- Rework TLB miss handlers to not use PTE_ATOMIC_UPDATES and _PAGE_HWWRITE
- Remove old versions of 40x processors, namely 403 and 405GP and associated
errata.
- Last two patches are trivial changes in TLB miss handlers to reduce number
of scratch registers.

I would have liked to test it with QEMU, but I get the following error when
trying to start QEMU for machine ref405ep.

	qemu-system-ppc: Could not load PowerPC BIOS 'ppc405_rom.bin'

Can someone help with that ?

Christophe Leroy (12):
  powerpc/40x: Rework 40x PTE access and TLB miss
  powerpc/pgtable: Drop PTE_ATOMIC_UPDATES
  powerpc/40x: Remove support for IBM 403GCX
  powerpc/40x: Remove STB03xxx
  powerpc/40x: Remove WALNUT
  powerpc/40x: Remove EP405
  powerpc/40x: Remove support for ISS Simulator
  powerpc/40x: Remove support for IBM 405GP
  powerpc/40x: Remove IBM405 Erratum #51
  powerpc: Remove IBM405 Erratum #77
  powerpc/40x: Avoid using r12 in TLB miss handlers
  powerpc/40x: Don't save CR in SPRN_SPRG_SCRATCH6

Michal Simek (1):
  powerpc: Remove Xilinx PPC405/PPC440 support

 Documentation/devicetree/bindings/xilinx.txt | 143 ------
 Documentation/powerpc/bootwrapper.rst        |  28 +-
 arch/powerpc/Kconfig.debug                   |   2 +-
 arch/powerpc/boot/Makefile                   |  14 +-
 arch/powerpc/boot/dts/Makefile               |   1 -
 arch/powerpc/boot/dts/ep405.dts              | 230 ---------
 arch/powerpc/boot/dts/virtex440-ml507.dts    | 406 ----------------
 arch/powerpc/boot/dts/virtex440-ml510.dts    | 466 -------------------
 arch/powerpc/boot/dts/walnut.dts             | 246 ----------
 arch/powerpc/boot/ep405.c                    |  71 ---
 arch/powerpc/boot/ops.h                      |   1 -
 arch/powerpc/boot/serial.c                   |   5 -
 arch/powerpc/boot/treeboot-walnut.c          |  81 ----
 arch/powerpc/boot/uartlite.c                 |  79 ----
 arch/powerpc/boot/virtex.c                   |  97 ----
 arch/powerpc/boot/virtex405-head.S           |  31 --
 arch/powerpc/boot/wrapper                    |   8 -
 arch/powerpc/configs/40x/acadia_defconfig    |   1 -
 arch/powerpc/configs/40x/ep405_defconfig     |  62 ---
 arch/powerpc/configs/40x/kilauea_defconfig   |   1 -
 arch/powerpc/configs/40x/klondike_defconfig  |   1 -
 arch/powerpc/configs/40x/makalu_defconfig    |   1 -
 arch/powerpc/configs/40x/obs600_defconfig    |   1 -
 arch/powerpc/configs/40x/virtex_defconfig    |  75 ---
 arch/powerpc/configs/44x/virtex5_defconfig   |  74 ---
 arch/powerpc/configs/ppc40x_defconfig        |   9 -
 arch/powerpc/configs/ppc44x_defconfig        |   8 -
 arch/powerpc/include/asm/asm-405.h           |  19 -
 arch/powerpc/include/asm/atomic.h            |  11 -
 arch/powerpc/include/asm/bitops.h            |   4 -
 arch/powerpc/include/asm/cache.h             |   2 +-
 arch/powerpc/include/asm/cmpxchg.h           |  11 -
 arch/powerpc/include/asm/futex.h             |   3 -
 arch/powerpc/include/asm/nohash/32/pgtable.h |  33 --
 arch/powerpc/include/asm/nohash/32/pte-40x.h |  23 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  27 --
 arch/powerpc/include/asm/nohash/pgtable.h    |   2 -
 arch/powerpc/include/asm/reg_booke.h         |  54 ---
 arch/powerpc/include/asm/spinlock.h          |   4 -
 arch/powerpc/include/asm/time.h              |  12 -
 arch/powerpc/include/asm/xilinx_intc.h       |  16 -
 arch/powerpc/include/asm/xilinx_pci.h        |  21 -
 arch/powerpc/kernel/cputable.c               | 102 ----
 arch/powerpc/kernel/entry_32.S               |  11 -
 arch/powerpc/kernel/head_40x.S               | 316 +++----------
 arch/powerpc/kernel/misc_32.S                |   9 -
 arch/powerpc/kernel/setup-common.c           |   4 -
 arch/powerpc/mm/nohash/40x.c                 |   4 +-
 arch/powerpc/platforms/40x/Kconfig           |  76 ---
 arch/powerpc/platforms/40x/Makefile          |   3 -
 arch/powerpc/platforms/40x/ep405.c           | 123 -----
 arch/powerpc/platforms/40x/virtex.c          |  54 ---
 arch/powerpc/platforms/40x/walnut.c          |  65 ---
 arch/powerpc/platforms/44x/Kconfig           |  40 +-
 arch/powerpc/platforms/44x/Makefile          |   2 -
 arch/powerpc/platforms/44x/virtex.c          |  60 ---
 arch/powerpc/platforms/44x/virtex_ml510.c    |  30 --
 arch/powerpc/platforms/Kconfig               |   4 -
 arch/powerpc/sysdev/Makefile                 |   2 -
 arch/powerpc/sysdev/xilinx_intc.c            |  88 ----
 arch/powerpc/sysdev/xilinx_pci.c             | 132 ------
 drivers/char/Kconfig                         |   2 +-
 drivers/video/fbdev/Kconfig                  |   2 +-
 63 files changed, 83 insertions(+), 3430 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/ep405.dts
 delete mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
 delete mode 100644 arch/powerpc/boot/dts/virtex440-ml510.dts
 delete mode 100644 arch/powerpc/boot/dts/walnut.dts
 delete mode 100644 arch/powerpc/boot/ep405.c
 delete mode 100644 arch/powerpc/boot/treeboot-walnut.c
 delete mode 100644 arch/powerpc/boot/uartlite.c
 delete mode 100644 arch/powerpc/boot/virtex.c
 delete mode 100644 arch/powerpc/boot/virtex405-head.S
 delete mode 100644 arch/powerpc/configs/40x/ep405_defconfig
 delete mode 100644 arch/powerpc/configs/40x/virtex_defconfig
 delete mode 100644 arch/powerpc/configs/44x/virtex5_defconfig
 delete mode 100644 arch/powerpc/include/asm/asm-405.h
 delete mode 100644 arch/powerpc/include/asm/xilinx_intc.h
 delete mode 100644 arch/powerpc/include/asm/xilinx_pci.h
 delete mode 100644 arch/powerpc/platforms/40x/ep405.c
 delete mode 100644 arch/powerpc/platforms/40x/virtex.c
 delete mode 100644 arch/powerpc/platforms/40x/walnut.c
 delete mode 100644 arch/powerpc/platforms/44x/virtex.c
 delete mode 100644 arch/powerpc/platforms/44x/virtex_ml510.c
 delete mode 100644 arch/powerpc/sysdev/xilinx_intc.c
 delete mode 100644 arch/powerpc/sysdev/xilinx_pci.c

-- 
2.25.0

