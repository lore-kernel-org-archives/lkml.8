Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340DCC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcRR219w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgBYRhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:37:33 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54686 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgBYRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:37:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so1563029pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:cc:from:to:message-id;
        bh=KNvnzC4oy7KeGoItCm2P3D+dtl4fdF1QEHNvZmvd+Fo=;
        b=RcRR219wmefc2NDuy99V7MKkcPkTiKEfsKTV5RkD2Ese5TwGN7pSKpdM/iepI+egaR
         25ig4ZTc6/gdu4GjFG6aY9u10ueyVjBDfw13DCbXSHO+llzTWH03d7m+TB0wCiBQWhKv
         7FYDowj8+TnXEzMpewLZzSyPKQcchlihzyc6XrJQpbkfp8O8pxvQYVUFvUpnrHIDnsYR
         13rAh13fXoDnncztPYwXXlNwGVOD1Qk0mw3BJtcfmEFAZY4PNwhUUfoWMrbNvw2LN+Yz
         nLbjyikj26YPDwFcspHeM4iKgtSBHaGl1I2lqSB9C5JpMFmREE+zd4QXoH++2XBVQKu5
         W2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=KNvnzC4oy7KeGoItCm2P3D+dtl4fdF1QEHNvZmvd+Fo=;
        b=cdslXDojZrgLVS9CTXX6Ivlwv4CVQzWgV/i0YgJIzSuOF8tyftQs+0iBhFhm2zP0KX
         xbVIAINSfy987Y537mKcymotuMO99aaIDrqRmtQYBoUp7FFUYG53PQE5LKDnfvFy9K7o
         Fxg9+70TRTsh7cueGu1ffURow2XMLH+200iWSpGALIjfqgdobNeA3eTLw24zs74aSKSw
         ZtJpqic+lDJ9s0x6P3hTX+5PJPstQKIynQ3dNxRFx8KiMXZ3+FgleJ1gYEfeThFl+iXM
         E5IEoYsVBcUGZt0JPvjQaZFTdRZxCnYQtpenWU8Y28mByGvNawSQjvPrdT3w1xGgoYCU
         t2tQ==
X-Gm-Message-State: APjAAAXTXBHEEJoqW8oU8fR/VqmsyfH1QvKHHNF4dQrhcXrFQ7VEqcYm
        zKTPo2bdUO3NDkajv1hU23gsFgeuGte6cw==
X-Google-Smtp-Source: APXvYqx2NqMCDRlWrHkTS9e3SAEWFrbYlWqkJCzFqzk781hycVlBMo6fbq5zxxw4FbS1uXdqczmr0A==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr63638pjn.39.1582652252230;
        Tue, 25 Feb 2020 09:37:32 -0800 (PST)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id q6sm17721821pfh.127.2020.02.25.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:37:31 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:37:31 -0800 (PST)
X-Google-Original-Date: Tue, 25 Feb 2020 09:35:29 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.6-rc4
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linux-5.6-rc4

for you to fetch changes up to 8458ca147c204e7db124e8baa8fede219006e80d:

  riscv: adjust the indent (2020-02-24 13:12:53 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.6-rc4

This tag contains a handful of RISC-V related fixes that I've collected and
would like to target for 5.6-rc4:

* A fix to set up the PMPs on boot, which allows the kernel to access memory on
  systems that don't set up permissive PMPs before getting to Linux.  This only
  effects machine-mode kernels, which currently means only NOMMU kernels.
* A fix to avoid enabling supervisor-mode interrupts when running in
  machine-mode, also only for NOMMU kernels.
* A pair of fixes to our KASAN support to avoid corrupting memory.
* A gitignore fix.

This boots on QEMU's virt board for me.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Don't enable all interrupts in trap_init()

Damien Le Moal (1):
      riscv: Fix gitignore

Greentime Hu (1):
      riscv: set pmp configuration if kernel is running in M-mode

Zong Li (2):
      riscv: allocate a complete page size for each page table
      riscv: adjust the indent

 arch/riscv/boot/.gitignore   |  2 ++
 arch/riscv/include/asm/csr.h | 12 ++++++++++
 arch/riscv/kernel/head.S     |  6 +++++
 arch/riscv/kernel/traps.c    |  4 ++--
 arch/riscv/mm/kasan_init.c   | 53 ++++++++++++++++++++++++++------------------
 5 files changed, 53 insertions(+), 24 deletions(-)
