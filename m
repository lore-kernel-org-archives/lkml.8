Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D056AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D34020792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="OP8u+zwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFKRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:54:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EA6C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so2994614pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=osYKD6rW/9QKGBBLAoQd2ZrBPFatLhRpJY9OJfIaprQ=;
        b=OP8u+zwhsykLsjNQysre6l5FfAwk7hmhl+MVEqIKbSrpDPU5PmTQ9NGYQVWxNPsRf9
         Ej5uITJXSBBQJE6MfSsWSFEEgeUMVlTBl1Bfs2vtxqGjvcDE0Mesopt03pxwooGUk90f
         R+8jilSFPe4o0m09FbfTF/zXEqD/Ah06AiRkaGCVCwpA+fecP2GAIxsDDoNhfkDMPjWM
         s5S+qALttn4NlQkKZjO4hN4WE1o1XEmE6VIkM56g5qKTHjkOXUZxITS/nFEmXAwYTh7q
         76VTIqMO23wzZrmikkMYwwtjyDg3wuR9AHEjxYXqPt65ayTg21NsqvPSfbbSGUDY+Q1n
         NMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=osYKD6rW/9QKGBBLAoQd2ZrBPFatLhRpJY9OJfIaprQ=;
        b=mM/aws9a4AgToP5wl/DPavAn9tRMa+Huf6IBh9h6P5JJYyTfZOW1IC2SIh8lvhQNtk
         Vc6O6g9n7Tkv4kwt/Q4r1q8K40DGtoho4F9o6//OSik2nucg2GDMV+9cUq30oQPAYW+o
         j7jpR6OWYjrGRcksViwGU0VdZEsz9eaSBt/V8C1djw9bz3nPqQ5SyHsm7Mix/SNXKEYT
         QSX5mev+JKbeZ5ishDhzY8GgqKXRBiVjbijdnqTkdi0uYetlspc+VbOrfI/901iZyKu8
         tqKeumE6dHmdzd+79VkwwB9Zu3suTJZLVws+eSVl0VKdGJjIj5/q58YJahRL4gdizjXy
         48yg==
X-Gm-Message-State: AOAM533wc5hJVGZvDhR/9PgkGF5QI4+ySpQwPKpSIRMVOix5W0TapvuS
        gKVAnTtv0vaJ7RB6xD09SekDFKg39c5yXQ==
X-Google-Smtp-Source: ABdhPJxNIcqcpFRkQgZ2/kYwDJZft6hRYsp7u8NpEkM6Nb/BQW8hIHuFSxJQ9NilVVQTVwU/IXQI8g==
X-Received: by 2002:a63:f642:: with SMTP id u2mr7511591pgj.151.1591898040274;
        Thu, 11 Jun 2020 10:54:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i34sm3396611pje.10.2020.06.11.10.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:53:59 -0700 (PDT)
Date:   Thu, 11 Jun 2020 10:53:59 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Jun 2020 10:49:16 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-70ded5ff-c09c-4703-837e-7ab2d9eea85c@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 084623e468d535d98f883cc2ccf2c4fdf2108556:

  Merge tag 'modules-for-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux (2020-06-05 12:31:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw1

for you to fetch changes up to 01f76386b0ac0b1c1094456c8f43ea6085fc49d2:

  riscv: set the permission of vdso_data to read-only (2020-06-10 19:47:35 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.8 Merge Window, Part 2

* Select statements are now sorted alphanumerically.
* Our first-level interrupts are now handled via a full irqchip driver.
* CPU hotplug is fixed.
* Our vDSO calls now use the common vDSO infrastructure.

----------------------------------------------------------------
Anup Patel (7):
      RISC-V: self-contained IPI handling routine
      RISC-V: Rename and move plic_find_hart_id() to arch directory
      irqchip: RISC-V per-HART local interrupt controller driver
      clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
      RISC-V: Remove do_IRQ() function
      RISC-V: Force select RISCV_INTC for CONFIG_RISCV
      RISC-V: Don't mark init section as non-executable

Palmer Dabbelt (1):
      RISC-V: Sort select statements alphanumerically

Vincent Chen (2):
      riscv: use vDSO common flow to reduce the latency of the time-related functions
      riscv: set the permission of vdso_data to read-only

Zong Li (1):
      riscv: fix build warning of missing prototypes

 arch/riscv/Kconfig                         |  74 +++++++++-------
 arch/riscv/include/asm/clocksource.h       |   7 ++
 arch/riscv/include/asm/irq.h               |   5 --
 arch/riscv/include/asm/processor.h         |  13 +--
 arch/riscv/include/asm/smp.h               |   3 +
 arch/riscv/include/asm/vdso.h              |   2 +
 arch/riscv/include/asm/vdso/clocksource.h  |   8 ++
 arch/riscv/include/asm/vdso/gettimeofday.h |  79 +++++++++++++++++
 arch/riscv/include/asm/vdso/processor.h    |  19 ++++
 arch/riscv/include/asm/vdso/vsyscall.h     |  27 ++++++
 arch/riscv/kernel/cpu.c                    |  16 ++++
 arch/riscv/kernel/entry.S                  |   4 +-
 arch/riscv/kernel/irq.c                    |  33 +------
 arch/riscv/kernel/patch.c                  |   1 +
 arch/riscv/kernel/smp.c                    |  11 ++-
 arch/riscv/kernel/time.c                   |   9 ++
 arch/riscv/kernel/traps.c                  |   2 -
 arch/riscv/kernel/vdso.c                   |  24 ++++-
 arch/riscv/kernel/vdso/Makefile            |  12 ++-
 arch/riscv/kernel/vdso/clock_getres.S      |  18 ----
 arch/riscv/kernel/vdso/clock_gettime.S     |  18 ----
 arch/riscv/kernel/vdso/gettimeofday.S      |  18 ----
 arch/riscv/kernel/vdso/vdso.lds.S          |   2 +
 arch/riscv/kernel/vdso/vgettimeofday.c     |  25 ++++++
 arch/riscv/mm/init.c                       |  11 ---
 drivers/clocksource/timer-riscv.c          |  43 ++++++++-
 drivers/irqchip/Kconfig                    |  13 +++
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-riscv-intc.c           | 138 +++++++++++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c          |  46 +++++-----
 include/linux/cpuhotplug.h                 |   1 +
 31 files changed, 500 insertions(+), 183 deletions(-)
 create mode 100644 arch/riscv/include/asm/clocksource.h
 create mode 100644 arch/riscv/include/asm/vdso/clocksource.h
 create mode 100644 arch/riscv/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/riscv/include/asm/vdso/processor.h
 create mode 100644 arch/riscv/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/riscv/kernel/vdso/clock_getres.S
 delete mode 100644 arch/riscv/kernel/vdso/clock_gettime.S
 delete mode 100644 arch/riscv/kernel/vdso/gettimeofday.S
 create mode 100644 arch/riscv/kernel/vdso/vgettimeofday.c
 create mode 100644 drivers/irqchip/irq-riscv-intc.c
