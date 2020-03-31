Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49C220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585641678;
	bh=SEXRR0YKImr5GqWYa0iuDp7fZ45yYCpF3RHizsfFIcc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FGTLOSrDlZ64/oGqAqQ6dsQ0HjakSU9Pi910iYlp0CQXc+UMw6mgriPePdCjG6VV8
	 c8kz4sDXoKnGdZ5F5TiC3CCqhYc0sdwHntHgaKNCY5MgI/ngvLVBmr/fmX8jUowR15
	 KguYomu8Sfuj8HyvOGbqaFBWzmw3su6OI9GinXWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgCaIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:01:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38892 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:01:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so24647387wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uq3Bm8lDsibKXwTtQCswk2ewu1Uea2sCiQ3l4gEM8ys=;
        b=Qq5nUrpDgsi9aWcj6nvfbKL8pRZpEYcOtat/YlvhC9xuk9k+kkXtPrU3Phz3PXKCT7
         BPLnoBBNzKWNBcBw5bsVmW2ebof0FMVr/xAcarihyAaXZKEuZIPDgRVk/aEzy8OYFary
         VGJf7PCB+0Au7H1ZKBEv2gFKrgewWopQZLBTrp+iKqN63YJir84TEjlhNP7Gbt7Los/H
         r7yn+cBVS6lXeWcSWFK6EfsxwFCg0wuVY1Y1ZqURbju/edMU6QxJ/RlTGSsOWHLQ9hIh
         8gNp9XrDEnRhfUwVURnMDH5pbZ6t4h4T07sSaKI0YzmjMlsSV1uCqKOBTibaCPSZTvjS
         op2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=uq3Bm8lDsibKXwTtQCswk2ewu1Uea2sCiQ3l4gEM8ys=;
        b=oro42N+L/F272x0UZAHPD3XTUKEcvdTqR1hjoAlgedMfi4L0jvql+qpQYC0I6s758P
         mr9IFTZ3Hx5RbZ5uV6zhymPdNpJDOTyljhFnbVn82ZksWTBqbrqi+3L/QXzygRMxgt6P
         yA+7wQrj0HC4aSD6SNBtInTfbhe7rz/lHrT3YrjTL6QYFybIaudmXfeyqyzFpq8nMeR0
         wDPHtq+et73Ke5oLJTPzbi1q8eFwuFC9DEQgLgdMbZlisGQM8WGQciC4uaqyyo/orgHS
         H4ybn/yqaWFvrBHfij4PP0FKYwL0TD6FeQ8pQpe0IE0OZPFTO5MUyBDdoy+55T8cD05i
         +HdQ==
X-Gm-Message-State: ANhLgQ3R5nD9h9i6d+qemOuomKpv1ONfyFldXv+vFejSDQTvN6NLImCD
        m0t4ThjoCa71XVTwM+cHORs=
X-Google-Smtp-Source: ADFU+vuC8pdapX26hinmu+0zpij5ZEZfe/k+paF/N075HqHZ+2UyDEhDvjO9290G/WUln1jLJlYwrQ==
X-Received: by 2002:adf:f503:: with SMTP id q3mr19370545wro.135.1585641673490;
        Tue, 31 Mar 2020 01:01:13 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a8sm2699249wmb.39.2020.03.31.01.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:01:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:01:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 cleanups for v5.7
Message-ID: <20200331080111.GA20569@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: a2150327250efa866c412caee84aaf05ebff9a8f Merge branch 'next.uaccess-2' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into x86/cleanups

This topic tree contains more commits than usual:

 - most of it are uaccess cleanups/reorganization by Al

 - there's a bunch of prototype declaration (--Wmissing-prototypes) cleanups

 - misc other cleanups all around the map.


  out-of-topic modifications in x86-cleanups-for-linus:
  -------------------------------------------------------
  include/linux/compat.h             # 39f16c1c0f14: x86: get rid of put_user_try
  include/linux/signal.h             # 119cd59fcfbe: x86: get rid of put_user_try

 Thanks,

	Ingo

------------------>
Al Viro (22):
      x86 user stack frame reads: switch to explicit __get_user()
      x86 kvm page table walks: switch to explicit __get_user()
      x86: switch sigframe sigset handling to explict __get_user()/__put_user()
      x86: get rid of small constant size cases in raw_copy_{to,from}_user()
      vm86: get rid of get_user_ex() use
      x86: get rid of get_user_ex() in ia32_restore_sigcontext()
      x86: get rid of get_user_ex() in restore_sigcontext()
      x86: kill get_user_{try,catch,ex}
      x86: switch save_v86_state() to unsafe_put_user()
      x86: switch setup_sigcontext() to unsafe_put_user()
      x86: switch ia32_setup_sigcontext() to unsafe_put_user()
      x86: get rid of put_user_try in {ia32,x32}_setup_rt_frame()
      x86: ia32_setup_sigcontext(): lift user_access_{begin,end}() into the callers
      x86: ia32_setup_frame(): consolidate uaccess areas
      x86: ia32_setup_rt_frame(): consolidate uaccess areas
      x86: get rid of put_user_try in __setup_rt_frame() (both 32bit and 64bit)
      x86: setup_sigcontext(): list user_access_{begin,end}() into callers
      x86: __setup_frame(): consolidate uaccess areas
      x86: __setup_rt_frame(): consolidate uaccess areas
      x86: x32_setup_rt_frame(): consolidate uaccess areas
      x86: unsafe_put-style macro for sigmask
      kill uaccess_try()

Anshuman Khandual (1):
      x86/mm: Drop pud_mknotpresent()

Benjamin Thiel (8):
      x86/iopl: Include prototype header for ksys_ioperm()
      x86/syscalls: Add prototypes for C syscall callbacks
      x86/cpu: Move prototype for get_umwait_control_msr() to a global location
      x86/cpu: Fix a -Wmissing-prototypes warning for init_ia32_feat_ctl()
      x86/platform/uv: Add a missing prototype for uv_bau_message_interrupt()
      x86/mm: Mark setup_emu2phys_nid() static
      x86/efi: Add a prototype for efi_arch_mem_reserve()
      x86/mm/set_memory: Fix -Wmissing-prototypes warnings

Martin Molnar (1):
      x86: Fix a handful of typos

Qiujun Huang (1):
      x86/alternatives: Mark text_poke_loc_init() static

Randy Dunlap (2):
      x86/configs: Slightly reduce defconfigs
      x86/jump_label: Move 'inline' keyword placement

afzal mohammed (1):
      x86: Replace setup_irq() by request_irq()


 Documentation/x86/exception-tables.rst |   6 -
 arch/x86/configs/i386_defconfig        |   2 -
 arch/x86/configs/x86_64_defconfig      |   2 -
 arch/x86/entry/common.c                |   1 +
 arch/x86/events/core.c                 |  27 +--
 arch/x86/ia32/ia32_signal.c            | 304 +++++++++++--------------
 arch/x86/include/asm/asm.h             |   6 -
 arch/x86/include/asm/mwait.h           |   2 +
 arch/x86/include/asm/pgtable.h         |   6 -
 arch/x86/include/asm/processor.h       |   1 -
 arch/x86/include/asm/set_memory.h      |   2 +
 arch/x86/include/asm/sigframe.h        |   6 +-
 arch/x86/include/asm/sighandling.h     |   3 -
 arch/x86/include/asm/syscall.h         |   5 +
 arch/x86/include/asm/uaccess.h         | 140 ------------
 arch/x86/include/asm/uaccess_32.h      |  27 ---
 arch/x86/include/asm/uaccess_64.h      | 108 +--------
 arch/x86/include/asm/uv/uv_bau.h       |   2 +
 arch/x86/kernel/alternative.c          |   4 +-
 arch/x86/kernel/cpu/feat_ctl.c         |   1 +
 arch/x86/kernel/cpu/umwait.c           |   1 +
 arch/x86/kernel/ioport.c               |   1 +
 arch/x86/kernel/irqinit.c              |  18 +-
 arch/x86/kernel/jump_label.c           |   2 +-
 arch/x86/kernel/nmi.c                  |   4 +-
 arch/x86/kernel/reboot.c               |   2 +-
 arch/x86/kernel/signal.c               | 399 +++++++++++++++------------------
 arch/x86/kernel/smpboot.c              |   2 +-
 arch/x86/kernel/stacktrace.c           |   6 +-
 arch/x86/kernel/time.c                 |  15 +-
 arch/x86/kernel/tsc.c                  |   2 +-
 arch/x86/kernel/tsc_sync.c             |   2 +-
 arch/x86/kernel/vm86_32.c              | 115 +++++-----
 arch/x86/kvm/mmu/paging_tmpl.h         |   2 +-
 arch/x86/kvm/vmx/vmx.c                 |   1 +
 arch/x86/kvm/vmx/vmx.h                 |   2 -
 arch/x86/mm/extable.c                  |  12 -
 arch/x86/mm/numa_emulation.c           |   2 +-
 arch/x86/mm/pat/set_memory.c           |   3 +
 arch/x86/mm/pti.c                      |   8 +-
 include/linux/compat.h                 |   9 +-
 include/linux/efi.h                    |   2 +
 include/linux/signal.h                 |   8 +-
 43 files changed, 445 insertions(+), 828 deletions(-)
