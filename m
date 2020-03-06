Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685EC20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="GzwVJ3Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFWYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:24:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40769 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:24:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1432855plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=jDwLJul+FxK3t2qLTY7GdkPDL4w6d80LdqnOuzgJII8=;
        b=GzwVJ3QwWk6jDijkAg9dfgQ5NVgUV5BfFWnUZq7G5tSxnrWZkonuq1/W8NjHjVdtow
         VmW0xQj/Q7/TcRKQPBUjO++peUT56wsmSbGNHccbVAdpSMYc+Zuhs5PDytQvIJZBpKed
         Ir0Vy/WulN7tXq4BhGTiONmAVRlsxiexXMBqE4hmVATLFm128n8wWsGHrGcsBQa6LYq4
         NOuZZdcwLKIU4PHCEEseJzhg78QGq7Hy5ES/S+aGejh5q24urRYTzZgt0oXyh/uLev6U
         DRuxDrC4gXYTlZkZ5iF6rRxBAstakKM+SHYB/BJWibs0hCdElnHCk+Ln4pNPUUEwUiRJ
         9+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=jDwLJul+FxK3t2qLTY7GdkPDL4w6d80LdqnOuzgJII8=;
        b=XwyeBulAhFA26P2xPrRWnfnSAVC+TaWEJ4xEtVrtnpWc6r48qG+NfloCnCHZmyip6b
         +wyKCfBz751nISEyKufV4+rf9ZVNPzzTOS4mTcIco28ryGmcDDvdByYCVD9IwYjStH7M
         5BLG0S90SaPTBs5I4yBuvTAhOFQerMIJQIF2NbHs5JrcRACVPHizy5h0po+t5duPmGNz
         YPu/hoLnqwtXalgU+PfKiOUr3WEEmORXws1WfiePBl2zS0tUzIaRAgPGMJsNBpnTjLk8
         yK/fbPlzQK7CxqQUCbtqqM6v8ImJELf3VaKszmylMyPoGbtUAk0Rg3x4wVYTzmfqYNjY
         axgA==
X-Gm-Message-State: ANhLgQ0SFyA+acurGHyRfECXoFmEXnbUNTO2WUjEzC2VyGArZfa99i0n
        50/wSLJ4MancRuVGvVo7breibA==
X-Google-Smtp-Source: ADFU+vv4h8olV0/VzG3gFtML4+rByo3lb53ykwWa7qHI14CRNJVGFqdTVJSjzqUP6zbDieizYGd1Mw==
X-Received: by 2002:a17:90b:370b:: with SMTP id mg11mr5848539pjb.122.1583533458108;
        Fri, 06 Mar 2020 14:24:18 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id x190sm37519605pfb.96.2020.03.06.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 14:24:17 -0800 (PST)
Date:   Fri, 06 Mar 2020 14:24:17 -0800 (PST)
X-Google-Original-Date: Fri, 06 Mar 2020 14:23:50 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.6-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ceb3e2ad-8656-4228-b1c3-b90731c84c5f@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.6-rc5

for you to fetch changes up to af33d2433b03d63ed31fcfda842f46676a5e1afc:

  riscv: fix seccomp reject syscall code path (2020-03-05 13:58:15 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.6-rc5

This tag contains a handful of fixes that I would like to target for 5.6:

* A pair of fixes to module loading, which we hope solve the last of the issues
  with module text being loaded too sparsely for our call relocations.
* A Kconfig fix that disallows selecting memory models not supported by NOMMU.
* A series of Kconfig updates to ease selecting the drivers necessary to run on
  QEMU's virt platform.
* DTS updates for SiFive's HiFive Unleashed.
* A fix to our seccomp support that avoids mangling restartable syscalls.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix range looking for kernel image memblock

Anup Patel (4):
      RISC-V: Add kconfig option for QEMU virt machine
      RISC-V: Enable QEMU virt machine support in defconfigs
      RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
      RISC-V: Select Goldfish RTC driver for QEMU virt machine

Damien Le Moal (1):
      riscv: Force flat memory model with no-mmu

Tycho Andersen (1):
      riscv: fix seccomp reject syscall code path

Vincent Chen (2):
      riscv: avoid the PIC offset of static percpu data in module beyond 2G limits
      riscv: Change code model of module to medany to improve data accessing

Yash Shah (1):
      riscv: dts: Add GPIO reboot method to HiFive Unleashed DTS file

 arch/riscv/Kconfig                                 |  1 +
 arch/riscv/Kconfig.socs                            | 24 ++++++++++++++++++++++
 arch/riscv/Makefile                                |  6 ++++--
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  5 +++++
 arch/riscv/configs/defconfig                       | 17 +++------------
 arch/riscv/configs/rv32_defconfig                  | 18 +++-------------
 arch/riscv/include/asm/syscall.h                   |  7 -------
 arch/riscv/kernel/entry.S                          | 11 +++-------
 arch/riscv/kernel/module.c                         | 16 +++++++++++++++
 arch/riscv/kernel/ptrace.c                         | 11 +++++-----
 arch/riscv/mm/init.c                               |  2 +-
 11 files changed, 65 insertions(+), 53 deletions(-)
