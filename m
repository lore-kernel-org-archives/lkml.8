Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E33B22B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596475667;
	bh=X7YS1nIq8m5uuz//Bpdx4OxigfHTmYq51mGHxLK0n0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uEAlLdn+tWNKR1IAcD98qS7KJ7dpaIFJQ4THtyC2kACC5MfoQO8dg+EQzT6PgfMEr
	 5SLyJBtVM/+OZrchWucF0gPoie/F0d4nBNuO8jJ7dh5cDfWVbfoXvg03G9dI4fJtCF
	 Q9evo1ZeOcItVTqQ8inGeK4HvoSqE0b/897v/A2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHCR1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHCR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:27:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569CCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 10:27:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so24495393edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XwGtkgBXWJ5ptzMM1XHrWXCSXJHU8r2ZM6QXjvpHVP8=;
        b=NWQHrX8oWtBMiRSVT4QlHk6fpt2H9JClvu2ljHylOHc7fXE4QMY41tjhggqTvZYGmj
         Fs/YyG8AaWg4wYpihD1C4EfhRJ/8LwogGE8yZkmxkRFPBpj/oOvOgoxL7XKIbZHAbFpg
         RBvlXlFZkttMOnzkbX4nz2ykUmSCEZCzhtvrMBI7pTZRWtZKO8mjGE0o7mjlwP7w+7XA
         4BiO/DerFvHCZM4HYyrF+OUmaE8JXGdAukky8AcfUuBfI/5qw7JLfR5hUQyr13rWSSUb
         q0aPcyzBh4Vw00s45jrHwP9jv99/w8vwoKZ7id/p2LeeNRVLRVh76AfLbUqbNNOOXNH7
         vOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=XwGtkgBXWJ5ptzMM1XHrWXCSXJHU8r2ZM6QXjvpHVP8=;
        b=TGoXVNDvegURcxPFK8oK4WmMaG0Ijl3WEJqawKlnkzHQHHq0/HUjptcVYm6tWaV/0r
         fpNoFOA9kU65l+u+20c43BSgAmkXWH4jaiXAWqR0YtE6DoBT7WU8f3g5O2++R5xxxuec
         2JmW1qjYbxzdKNhKhXZf9eFNcJLdDst/suOVJLZIR8uggVPrLvasi0ckB8aD0zC9T2EM
         oWdiyIffIfxBcwvRCQe+V9y3YqcvjmUcSg0UdzZ2HHnex14WmdzNwr3/MayXw24gMSIm
         dBfD6ZhRsqL+h5xuOAz1M5xmjK8GN+tj+OW+mSxBBAOu+zjEUl/JDJGzL5iPu7P98qe+
         heJA==
X-Gm-Message-State: AOAM530lZN6TtSrL2yTV2I4mT98zFVG0Pnz1ElXD8Px1vWO0VJ68ELiR
        ELjKvO+VFgTE/XIYQHpZ8Yk=
X-Google-Smtp-Source: ABdhPJyrDDiHCy7B0j/dyv/9qivDaf+gIIyIY6RY+SSlls3Af/AVkTEmh7nQMEYehqRYQxATm995jg==
X-Received: by 2002:a50:fc0e:: with SMTP id i14mr5331808edr.346.1596475664028;
        Mon, 03 Aug 2020 10:27:44 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id vr6sm16364135ejb.36.2020.08.03.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:27:43 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:27:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.9
Message-ID: <20200803172741.GA914875@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2020-08-03

   # HEAD: 90fc73928fec2f62bbee1476781754c7392a7b61 x86/ioperm: Initialize pointer bitmap with NULL rather than 0

Misc cleanups all around the place.

  out-of-topic modifications in x86-cleanups-2020-08-03:
  --------------------------------------------------------
  drivers/hwmon/fam15h_power.c       # 1068ed4547ad: x86/msr: Lift AMD family 0x1
  include/linux/cpu.h                # 2accfa69050c: cpu/speculation: Add prototy
  init/do_mounts_initrd.c            # eacb0c101a0b: initrd: Remove erroneous com

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/mm: Drop unused MAX_PHYSADDR_BITS

Benjamin Thiel (2):
      x86/mm: Fix -Wmissing-prototypes warnings for arch/x86/mm/init.c
      x86/mm/32: Fix -Wmissing prototypes warnings for init.c

Borislav Petkov (4):
      x86/msr: Lift AMD family 0x15 power-specific MSRs
      x86/cpufeatures: Mark two free bits in word 3
      x86/asm: Unify __ASSEMBLY__ blocks
      x86/msr: Move the F15h MSRs where they belong

Colin Ian King (1):
      x86/ioperm: Initialize pointer bitmap with NULL rather than 0

Guenter Roeck (1):
      cpu/speculation: Add prototype for cpu_show_srbds()

Ingo Molnar (3):
      x86/ioapic: Remove unused "IOAPIC_AUTO" define
      x86/tsc: Remove unused "US_SCALE" and "NS_SCALE" leftover macros
      x86/mm: Remove the unused mk_kernel_pgd() #define

Jason Andryuk (1):
      x86/idt: Make idt_descr static

Randy Dunlap (3):
      x86: bootparam.h: Delete duplicated word
      x86: cmpxchg_32.h: Delete duplicated word
      x86: uv: uv_hub.h: Delete duplicated word

Tom Rini (1):
      initrd: Remove erroneous comment


 arch/x86/events/amd/power.c           |  4 ----
 arch/x86/include/asm/asm.h            |  6 ++----
 arch/x86/include/asm/cmpxchg_32.h     |  2 +-
 arch/x86/include/asm/cpufeatures.h    |  2 ++
 arch/x86/include/asm/io_apic.h        |  1 -
 arch/x86/include/asm/mem_encrypt.h    |  5 ++++-
 arch/x86/include/asm/msr-index.h      |  4 +++-
 arch/x86/include/asm/pgtable.h        |  9 +++------
 arch/x86/include/asm/pgtable_64.h     | 11 ++++-------
 arch/x86/include/asm/sparsemem.h      |  6 +-----
 arch/x86/include/asm/tsc.h            |  3 ---
 arch/x86/include/asm/uv/uv_hub.h      |  2 +-
 arch/x86/include/uapi/asm/bootparam.h |  2 +-
 arch/x86/kernel/idt.c                 |  2 +-
 arch/x86/mm/init.c                    |  3 +--
 arch/x86/mm/mem_encrypt.c             |  2 +-
 arch/x86/xen/enlighten_pv.c           |  2 +-
 drivers/hwmon/fam15h_power.c          |  4 ----
 include/linux/cpu.h                   |  1 +
 init/do_mounts_initrd.c               |  5 -----
 20 files changed, 27 insertions(+), 49 deletions(-)
