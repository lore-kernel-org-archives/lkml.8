Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653CAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386FC21974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ALJGwowB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEHSrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726807AbgEHSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:47:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04D5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:47:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so1122540plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=2tA1zP7hu7E8xr10Gwcfc3VadGWJSXb2fISg7SkRPxQ=;
        b=ALJGwowB2DhmNrLBkC5TvLAynj0KTLZmI46t9FYy0pnp4OHc03/RBh6qgxjINbVRQx
         cpJyOT2H9D48oxDfsBf1F1FBIFW6QQh1XAy4UQ888vUkSUh9r2fP1rURo+48wzyeHOWb
         iOTTX+J2IiR7PKzFJTioqHolR7oDM8lYgnSNJfPub4RTr9//biR9dSq02ohUEst++4M7
         ISo1L2whwgXazS2NdT/tls0/zW1LFRndCAFaYzWkpmZN57j43oCqF9RCHAmoA0OAyH11
         o41Xw+xWUy57SeW+DqV9bhsPFG3pECFYZZ4m6GCPW26ZyGW3dIh6FCH+/sM7k3hXvB/n
         9UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=2tA1zP7hu7E8xr10Gwcfc3VadGWJSXb2fISg7SkRPxQ=;
        b=MErli8qxrekN2Ijtd+lqmKX7s+oolTDYhbe+6H6T/meYoliySNycacy2kBzaT8oGnB
         NFgJ8mXZtFHSWGxpxzvjsY1GQyM6GsPoDBZQxRSfHR07h0soKRvWaroBJ6UnPk1VSKC1
         wdne2JOLWojWZeLbReQpF7njfjlMvhEAoj0UCoCO/xfeOcKlDAl8GkfUH6l3iAdII0HO
         JXM0/huKbt+rWc14PtWULFK3rKFdnyaNXmFC8GMchqJHzva5pUJnHad4zOXGjxod8JFP
         gZspaGIu8NH9ulAsqvwDyB/+zBJZZpcOzrtQhguAqyGo14+HvkBmmuhHn5ABNDOrWPbj
         vcVQ==
X-Gm-Message-State: AGi0PubMrnMkXJtsIA9qjRjx2YmDVef7QurO9O4TW/T/WOXqww/HiFHG
        bnzA6n3q6H/OB1OhdBOcOtS0XkjJzlw=
X-Google-Smtp-Source: APiQypL6xxJoPjSqNwoBDWP883ePodLOm4PYJpDnqIqsdM/QMjrLcsb2G/Waay3RFVFs9WecHfvv9g==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr7766474pjb.86.1588963634825;
        Fri, 08 May 2020 11:47:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j2sm2609271pfb.73.2020.05.08.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:47:13 -0700 (PDT)
Date:   Fri, 08 May 2020 11:47:13 -0700 (PDT)
X-Google-Original-Date: Fri, 08 May 2020 11:47:08 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.7-rc5
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.7-rc4'
The following changes since commit 1d2cc5ac6f6668cc15216d51051103c61467d7e8:

  Merge tag 'riscv-for-linus-5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-04-29 09:25:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc5

for you to fetch changes up to 73cb8e2a5863ccc5215660f5123db621bd57dff7:

  RISC-V: Remove unused code from STRICT_KERNEL_RWX (2020-05-05 17:02:14 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.7-rc5

This contains a smattering of fixes and cleanups that I'd like to target for
5.7:

* Dead code removal.
* Exporting riscv_cpuid_to_hartid_mask for modules.
* Per-CPU tracking of ISA features.
* Setting max_pfn correctly when probing memory.
* Adding a note to the VDSO so glibc can check the kernel's version without a
  uname().
* A fix to force the bootloader to initialize the boot spin tables, which still
  get used as a fallback when SBI-0.1 is enabled.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: add Linux note to vdso

Anup Patel (3):
      RISC-V: Export riscv_cpuid_to_hartid_mask() API
      RISC-V: Add bitmap reprensenting ISA features common across CPUs
      RISC-V: Remove N-extension related defines

Atish Patra (1):
      RISC-V: Remove unused code from STRICT_KERNEL_RWX

Vincent Chen (1):
      riscv: set max_pfn to the PFN of the last page

Zong Li (1):
      riscv: force __cpu_up_ variables to put in data section

 arch/riscv/include/asm/csr.h        |  3 --
 arch/riscv/include/asm/hwcap.h      | 22 ++++++++++
 arch/riscv/include/asm/set_memory.h |  8 ----
 arch/riscv/kernel/cpu_ops.c         |  4 +-
 arch/riscv/kernel/cpufeature.c      | 83 +++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/smp.c             |  2 +
 arch/riscv/kernel/vdso/Makefile     |  2 +-
 arch/riscv/kernel/vdso/note.S       | 12 ++++++
 arch/riscv/mm/init.c                | 19 +--------
 9 files changed, 121 insertions(+), 34 deletions(-)
 create mode 100644 arch/riscv/kernel/vdso/note.S
