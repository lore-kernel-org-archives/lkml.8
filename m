Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D41204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458266;
	bh=VKLBm1Y0G5MJy9sYWzDySXAwe/K8P9U3VX29nFCySU0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dq0nwFc+yOPMv58pu2ggwfmTvPyqbXrH6f3I2xRMYCfvoxpuQKh/s37VE02GgwWj9
	 pu4kzc3ODCx6w/phJoX6krV9UlEsz/6LItVb9Llm15bHTjTnzDjPTW+Os6A4cq4m9l
	 ZiabfHcRKrNIHNMniQ4TZYNeWNNb3f5DMezKlxdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgHCMhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgHCMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:37:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:37:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so23646857ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SYFkGFotJhjv8HSUDqLl/g6SWYqewU0n8NYVoK0ozDU=;
        b=WIwTFj6u6mG0HCLAD2zEll9ZTp4GBGQG/fS6MZWTHARNXNgSs9xVe9TQgusqLMzJ56
         8ztCfWBozbc2mwEMJEQ8CY21UZTy7pr3FjDNeYPTpHMCnrvC2owerHrJzgUXHrD503oD
         G5TYQdbM+U/SiI1n+owk9QrHZMxGqhBr5gBnPY4zusYkvEZyuV9eqjOjoNTKobGPJrly
         wDaDJoknVS/x88eodvZAAmzNNVrNolPkzfHh0RW3JztwbXenLyuDD9UaTWgLN4Z8wN3z
         zsYWbTzezjb7evWgylGiOjzTdFFPMckUHELZT0nY/6MJ66tNhlW5/IVBwpSbhFEqA7pf
         wliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=SYFkGFotJhjv8HSUDqLl/g6SWYqewU0n8NYVoK0ozDU=;
        b=iuupiV+y+1zxoCHz31wUksUTpTY2iIuU70gV4H6NvcI9/TB0Xag6r2R3EP93YhC/wz
         6felwfCO4p066SDBnfp0rN5SnEtRYH4WEY0VS1SAkY/5wcXVMtHX7qT3Ly9PlLywwsXl
         dxVadJWmB1hf0wQUHljkxw+tCvSmF+ojO6pwXBym4ndqvWM/++jroD05kuDAHR/qEI82
         t7jJ1IpDMY8ELAYU6NWOe3TTNth0xWsbrbde8MDVCseuJjuXWKcBQwpNvn/YWwVNNBCV
         v+1H3HBntyBDHD1NaCxuj65l2CXh0tGofJk+Xuupq9C+Sa89131F2Vx3CVpJ2f+EDXcg
         zxgQ==
X-Gm-Message-State: AOAM530+Lq2sGEgjGZ1R4wD+6RTIDYWtQxsdKAVCUo2lrhzeRWR/L5+f
        bz+eUqrMPtqJjny1+G1Pqo0=
X-Google-Smtp-Source: ABdhPJwaCa6exlp1u0baTo/T1cg7xGnn0Rwe9zWCJHEqEaUmtjHVaognzbtGVOPe62k1lxhoCHgs9w==
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr16815476ejj.197.1596458251793;
        Mon, 03 Aug 2020 05:37:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id bc10sm15968725edb.5.2020.08.03.05.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:37:31 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:37:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events updates for v5.9
Message-ID: <20200803123729.GA567306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-08-03

   # HEAD: d903b6d029d66e6478562d75ea18d89098f7b7e8 perf/x86/rapl: Add Hygon Fam18h RAPL support

- HW support updates:

   - Add uncore support for Intel Comet Lake

   - Add RAPL support for Hygon Fam18h

   - Add Intel "IIO stack to PMON mapping" support on Skylake-SP CPUs,
     which enumerates per device performance counters via sysfs and enables
     the perf stat --iiostat functionality

   - Add support for Intel "Architectural LBRs", which generalized the model
     specific LBR hardware tracing feature into a model-independent, architected
     performance monitoring feature. Usage is mostly seamless to tooling, as the
     pre-existing LBR features are kept, but there's a couple of advantages
     under the hood, such as faster context-switching, faster LBR reads,
     cleaner exposure of LBR features to guest kernels, etc.

     ( Since architectural LBRs are supported via XSAVE, there's related
       changes to the x86 FPU code as well. )

 - ftrace/perf updates: Add support to add a text poke event to record changes
                        to kernel text (i.e. self-modifying code) in order to
                        support tracers like Intel PT decoding through
                        jump labels, kprobes and ftrace trampolines.

 - Misc cleanups, smaller fixes.

 Thanks,

	Ingo

------------------>
Adrian Hunter (8):
      perf: Add perf text poke event
      perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
      kprobes: Add symbols for kprobe insn pages
      kprobes: Add perf ksymbol events for kprobe insn pages
      perf/x86: Add perf text poke events for kprobes
      ftrace: Add symbols for ftrace trampolines
      ftrace: Add perf ksymbol events for ftrace trampolines
      ftrace: Add perf text poke events for ftrace trampolines

Hu Haowen (1):
      x86/perf: Fix a typo

Kan Liang (27):
      perf/x86/intel/uncore: Add Comet Lake support
      perf/x86/intel/uncore: Fix oops when counting IMC uncore events on some TGL
      perf/x86/intel/uncore: Record the size of mapped area
      perf/x86/intel/uncore: Validate MMIO address before accessing
      x86/cpufeatures: Add Architectural LBRs feature bit
      perf/x86/intel/lbr: Add a function pointer for LBR reset
      perf/x86/intel/lbr: Add a function pointer for LBR read
      perf/x86/intel/lbr: Add the function pointers for LBR save and restore
      perf/x86/intel/lbr: Factor out a new struct for generic optimization
      perf/x86/intel/lbr: Use dynamic data structure for task_ctx
      x86/msr-index: Add bunch of MSRs for Arch LBR
      perf/x86: Expose CPUID enumeration bits for arch LBR
      perf/x86/intel/lbr: Support LBR_CTL
      perf/x86/intel/lbr: Unify the stored format of LBR information
      perf/x86/intel/lbr: Mark the {rd,wr}lbr_{to,from} wrappers __always_inline
      perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()
      perf/x86/intel/lbr: Factor out intel_pmu_store_lbr
      perf/x86/intel/lbr: Support Architectural LBR
      perf/core: Factor out functions to allocate/free the task_ctx_data
      perf/core: Use kmem_cache to allocate the PMU specific data
      perf/x86/intel/lbr: Create kmem_cache for the LBR context data
      perf/x86: Remove task_ctx_size
      x86/fpu: Use proper mask to replace full instruction mask
      x86/fpu/xstate: Support dynamic supervisor feature for LBR
      x86/fpu/xstate: Add helpers for LBR dynamic supervisor feature
      perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch
      perf/x86/intel/lbr: Support XSAVES for arch LBR read

Like Xu (4):
      perf/x86/core: Refactor hw->idx checks and cleanup
      perf/x86/lbr: Add interface to get LBR information
      perf/x86: Add constraint to create guest LBR event without hw counter
      perf/x86: Keep LBR records unchanged in host context for guest usage

Masami Hiramatsu (1):
      kprobes: Remove unnecessary module_mutex locking from kprobe_optimizer()

Pu Wen (1):
      perf/x86/rapl: Add Hygon Fam18h RAPL support

Randy Dunlap (1):
      perf: <linux/perf_event.h>: drop a duplicated word

Roman Sudarikov (3):
      perf/x86/intel/uncore: Expose an Uncore unit to PMON mapping
      perf/x86/intel/uncore: Wrap the max dies calculation into an accessor
      perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping

Wei Wang (1):
      perf/x86: Fix variable types for LBR registers


 Documentation/ABI/testing/sysfs-devices-mapping |  33 ++
 arch/x86/events/core.c                          |  28 +-
 arch/x86/events/intel/core.c                    | 127 ++--
 arch/x86/events/intel/ds.c                      |   6 +-
 arch/x86/events/intel/lbr.c                     | 733 ++++++++++++++++++++----
 arch/x86/events/intel/uncore.c                  |  26 +-
 arch/x86/events/intel/uncore.h                  |  37 ++
 arch/x86/events/intel/uncore_snb.c              |  80 ++-
 arch/x86/events/intel/uncore_snbep.c            | 208 ++++++-
 arch/x86/events/perf_event.h                    | 125 +++-
 arch/x86/events/rapl.c                          |   3 +-
 arch/x86/events/zhaoxin/core.c                  |   2 +-
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/fpu/internal.h             |  47 +-
 arch/x86/include/asm/fpu/types.h                |  27 +
 arch/x86/include/asm/fpu/xstate.h               |  36 ++
 arch/x86/include/asm/kprobes.h                  |   2 +
 arch/x86/include/asm/msr-index.h                |  16 +
 arch/x86/include/asm/perf_event.h               |  82 ++-
 arch/x86/kernel/alternative.c                   |  37 +-
 arch/x86/kernel/fpu/core.c                      |  39 ++
 arch/x86/kernel/fpu/xstate.c                    |  89 ++-
 arch/x86/kernel/kprobes/core.c                  |  15 +-
 arch/x86/kernel/kprobes/opt.c                   |  38 +-
 include/linux/ftrace.h                          |  12 +-
 include/linux/kprobes.h                         |  15 +
 include/linux/perf_event.h                      |  15 +-
 include/uapi/linux/perf_event.h                 |  26 +-
 kernel/events/core.c                            | 115 +++-
 kernel/kallsyms.c                               |  42 +-
 kernel/kprobes.c                                |  60 +-
 kernel/trace/ftrace.c                           | 101 +++-
 32 files changed, 1943 insertions(+), 280 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-mapping
