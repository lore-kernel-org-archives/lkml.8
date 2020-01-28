Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8382C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730232467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580199871;
	bh=FePdzsboiTYWKcDdgypCmdpksgflpMAko2eWtkymKtI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UwhMP+jNHSZPPv1Z7Lq+ez0O6/yLw7NqrzchqkAf3tOGwJzpOwe90e5bGYizZPQDJ
	 nilyzLp3QGi2f0iY40rVPZ4Yx/qJddCo768ArauMQ6QYc3WqRGoq3oRccf9Q5c/Q71
	 lGc+nsPxmTJH96hlt42Vcv9ocYiMv87Gv7er+XYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1IYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:24:30 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42504 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1IYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:24:30 -0500
Received: by mail-wr1-f44.google.com with SMTP id k11so237541wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z5HLCy3HqQCA1Lvh8LBCqzxr3I6wgiiwZJ7GMEJ0Dk8=;
        b=KeJPKu/JtQaPJQRKttpXFXkD2PEDtcTXZLJ/5Vg6EcP/0Ec/IlHL1jN94XuIVEa6ln
         R1JerfcC3bgHHvag3LBr8+b0GmP8ydNc9E/jgrrFgVxvN3SGd6MR+qn+YnamkSCx7J1U
         VLjFqtDWpVG7DkgpeTJGudV/zD88GdbKJSVPmkX/o1920JNvoScV+jDxHP+qszFdate4
         4+rwsrp7Bt0/LSrjaGXebAGjlklzF8JXFJHB63ktZD1RoUhI66CdCCQRhEvPkVtBS7mT
         Fr5UUUoKPgW0DtbHke9WFc9GfrkhKFPic4hh76TQ2VxJllffHtlJvwoN5t87Xcswk3dt
         Kwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=z5HLCy3HqQCA1Lvh8LBCqzxr3I6wgiiwZJ7GMEJ0Dk8=;
        b=n6aLAI3hRJJwCT4fYJkeRmEmxW3siqomUunBxhE4sJDVU2tt5taAugyYEUOeGicLKI
         95gOB3a+9R0Z1snSiBrT75iU5Qb6MG2TI1dAgPty4tU2b0a3mxBW0V6XkC2eLVS/R7Rp
         6ec3Uu+YZhUECPSnQv3DHlJXQ2Ro1dKPM81vJP/1AXXRDoYUoJcArtXNGbuYVjxLKGjp
         zLaS7gR2etd2qSpNiK+W2c3m/9v+pOnpgfMbyPlyMSEU+hDV5/GygAyvQdgNzw8FRff9
         pTiNbGH+2A2uzr9o+huBjt+xAgzgOFfVLCRcNV50CqH2PtsSOkY6Ww4cndLOoIV9S1Mr
         HNuw==
X-Gm-Message-State: APjAAAUP8aMw1v9h1wZgDUuR5usJEKo7z7STjDqYiX7p11a7RN1lRf5d
        EWvazN4oIVXdviHuu0JBsk8=
X-Google-Smtp-Source: APXvYqxbet9TKS0R5SKYuMFtdLZHyayd9WPeON7ugzgiDKrslnrRvJjBtSfxj7+DZR9Mm9+KIifB9g==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr27225933wro.202.1580199866631;
        Tue, 28 Jan 2020 00:24:26 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c4sm1985563wml.7.2020.01.28.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 00:24:26 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:24:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf changes for v5.6
Message-ID: <20200128082424.GA41606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: 0cc4bd8f70d1ea2940295f1050508c663fe9eff9 Merge branch 'core/kprobes' into perf/core, to pick up fixes

Kernel side changes:

 - Ftrace is one of the last W^X violators (after this only KLP is left). 
   These patches move it over to the generic text_poke() interface and 
   thereby get rid of this oddity. This requires a surprising amount of 
   surgery, by Peter Zijlstra.

 - x86/AMD PMUs: add support for 'Large Increment per Cycle Events' to 
   count certain types of events that have a special, quirky hw ABI.
   (by Kim Phillips)

 - kprobes fixes by Masami Hiramatsu

Lots of tooling updates as well, the following subcommands were updated: 
annotate/report/top, c2c, clang, record, report/top TUI, sched timehist, 
tests; plus updates were done to the gtk ui, libperf, headers and the 
parser. Please see the shortlog and git log for details.

 Thanks,

	Ingo

------------------>
Alexey Budankov (3):
      tools bitmap: Implement bitmap_equal() operation at bitmap API
      perf mmap: Declare type for cpu mask of arbitrary length
      perf record: Adapt affinity to machines with #CPUs > 1K

Andi Kleen (2):
      perf report: Clarify in help that --children is default
      perf tools: Support --prefix/--prefix-strip

Andres Freund (1):
      perf c2c: Fix return type for histogram sorting comparision functions

Andrey Zhizhikin (1):
      tools lib api fs: Fix gcc9 stringop-truncation compilation error

Arnaldo Carvalho de Melo (12):
      perf tests bp_signal: Show expected versus obtained values
      perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
      perf report/top: Make ENTER consistently bring up menu
      perf report/top: Add menu entry for toggling callchain expansion
      perf report/top: Improve toggle callchain menu option
      perf hists browser: Generalize the do_zoom_dso() function
      perf report/top: Add 'k' hotkey to zoom directly into the kernel map
      perf hists browser: Allow passing an initial hotkey
      tools ui popup: Allow returning hotkeys
      perf report/top: Allow pressing hotkeys in the options popup menu
      perf report/top: Do not offer annotation for symbols without samples
      perf report/top: Make 'e' visible in the help and make it toggle showing callchains

Borislav Petkov (1):
      x86/ftrace: Mark ftrace_modify_code_direct() __ref

Cengiz Can (1):
      perf beauty sockaddr: Fix augmented syscall format warning

David Ahern (1):
      perf sched timehist: Add support for filtering on CPU

Harry Pan (1):
      perf/x86/intel/rapl: Add Comet Lake support

Jin Yao (1):
      perf report: Fix no libunwind compiled warning break s390 issue

Jiri Olsa (6):
      libperf: Move to tools/lib/perf
      libperf: Add man pages
      libperf: Setup initial evlist::all_cpus value
      perf tools: Use %define api.pure full instead of %pure-parser
      perf ui gtk: Add missing zalloc object
      perf/ui/gtk: Fix gtk2 build

Kim Phillips (2):
      perf/x86/amd: Constrain Large Increment per Cycle events
      perf/x86/amd: Add support for Large Increment per Cycle Events

Maciej S. Szmigiero (2):
      perf clang: Fix build with Clang 9
      tools build: Fix test-clang.cpp with Clang 8+

Masami Hiramatsu (3):
      x86/alternatives: Sync bp_patching update for avoiding NULL pointer exception
      kprobes: Set unoptimized flag after unoptimizing code
      kprobes: Fix optimize_kprobe()/unoptimize_kprobe() cancellation logic

Michael Petlan (1):
      perf header: Use last modification time for timestamp

Peter Zijlstra (17):
      x86/alternatives: Update int3_emulate_push() comment
      x86/alternatives, jump_label: Provide better text_poke() batching interface
      x86/alternatives: Add and use text_gen_insn() helper
      x86/ftrace: Use text_poke()
      x86/mm: Remove set_kernel_text_r[ow]()
      x86/alternative: Add text_opcode_size()
      x86/ftrace: Use text_gen_insn()
      x86/alternative: Remove text_poke_loc::len
      x86/alternative: Shrink text_poke_loc
      x86/kprobes: Convert to text-patching.h
      x86/kprobes: Fix ordering while text-patching
      arm/ftrace: Use __patch_text()
      module: Remove set_all_modules_text_*()
      ftrace: Rework event_create_dir()
      x86/kprobe: Add comments to arch_{,un}optimize_kprobes()
      x86/alternatives: Use INT3_INSN_SIZE
      x86/alternatives: Implement a better poke_int3_handler() completion scheme

Steven Rostedt (VMware) (1):
      tracing: Initialize ret in syscall_enter_define_fields()

Vitaly Chikunov (1):
      tools lib: Fix builds when glibc contains strlcpy()


 arch/arm/kernel/Makefile                           |   4 +-
 arch/arm/kernel/ftrace.c                           |  10 +-
 arch/nds32/kernel/ftrace.c                         |  12 -
 arch/x86/events/amd/core.c                         | 109 +++-
 arch/x86/events/core.c                             |  74 ++-
 arch/x86/events/intel/rapl.c                       |   2 +
 arch/x86/events/perf_event.h                       |  20 +
 arch/x86/include/asm/ftrace.h                      |   2 -
 arch/x86/include/asm/kprobes.h                     |  14 +-
 arch/x86/include/asm/set_memory.h                  |   2 -
 arch/x86/include/asm/text-patching.h               |  86 ++-
 arch/x86/kernel/alternative.c                      | 198 ++++--
 arch/x86/kernel/ftrace.c                           | 688 ++++-----------------
 arch/x86/kernel/jump_label.c                       | 116 ++--
 arch/x86/kernel/kprobes/core.c                     |  20 +-
 arch/x86/kernel/kprobes/opt.c                      |  67 +-
 arch/x86/kernel/traps.c                            |   9 -
 arch/x86/mm/init_32.c                              |  28 -
 arch/x86/mm/init_64.c                              |  36 --
 drivers/infiniband/hw/hfi1/trace_tid.h             |   8 +-
 drivers/infiniband/hw/hfi1/trace_tx.h              |   2 +-
 drivers/lightnvm/pblk-trace.h                      |   8 +-
 drivers/net/fjes/fjes_trace.h                      |   2 +-
 drivers/net/wireless/ath/ath10k/trace.h            |   6 +-
 fs/xfs/scrub/trace.h                               |   6 +-
 fs/xfs/xfs_trace.h                                 |   4 +-
 include/linux/module.h                             |   4 -
 include/linux/trace_events.h                       |  18 +-
 include/trace/events/filemap.h                     |   2 +-
 include/trace/trace_events.h                       |  64 +-
 kernel/kprobes.c                                   |  71 ++-
 kernel/module.c                                    |  43 --
 kernel/trace/trace.h                               |  31 +-
 kernel/trace/trace_entries.h                       |  66 +-
 kernel/trace/trace_events.c                        |  20 +-
 kernel/trace/trace_events_hist.c                   |   8 +-
 kernel/trace/trace_export.c                        | 106 ++--
 kernel/trace/trace_kprobe.c                        |  16 +-
 kernel/trace/trace_syscalls.c                      |  51 +-
 kernel/trace/trace_uprobe.c                        |   9 +-
 net/mac80211/trace.h                               |  28 +-
 net/wireless/trace.h                               |   6 +-
 tools/build/feature/Makefile                       |   2 +-
 tools/build/feature/test-clang.cpp                 |   6 +
 tools/include/linux/bitmap.h                       |  30 +
 tools/include/linux/string.h                       |   8 +
 tools/lib/api/fs/fs.c                              |   4 +-
 tools/lib/bitmap.c                                 |  15 +
 tools/{perf/lib => lib/perf}/Build                 |   0
 tools/lib/perf/Documentation/Makefile              | 156 +++++
 tools/lib/perf/Documentation/asciidoc.conf         | 120 ++++
 tools/lib/perf/Documentation/examples/sampling.c   | 119 ++++
 tools/lib/perf/Documentation/libperf-counting.txt  | 211 +++++++
 tools/lib/perf/Documentation/libperf-sampling.txt  | 243 ++++++++
 tools/lib/perf/Documentation/libperf.txt           | 246 ++++++++
 tools/lib/perf/Documentation/manpage-1.72.xsl      |  14 +
 tools/lib/perf/Documentation/manpage-base.xsl      |  35 ++
 .../perf/Documentation/manpage-bold-literal.xsl    |  17 +
 tools/lib/perf/Documentation/manpage-normal.xsl    |  13 +
 .../lib/perf/Documentation/manpage-suppress-sp.xsl |  21 +
 tools/{perf/lib => lib/perf}/Makefile              |   7 +-
 tools/{perf/lib => lib/perf}/core.c                |   0
 tools/{perf/lib => lib/perf}/cpumap.c              |   0
 tools/{perf/lib => lib/perf}/evlist.c              |   3 +
 tools/{perf/lib => lib/perf}/evsel.c               |   0
 .../lib => lib/perf}/include/internal/cpumap.h     |   0
 .../lib => lib/perf}/include/internal/evlist.h     |   0
 .../lib => lib/perf}/include/internal/evsel.h      |   0
 .../{perf/lib => lib/perf}/include/internal/lib.h  |   0
 .../{perf/lib => lib/perf}/include/internal/mmap.h |   0
 .../lib => lib/perf}/include/internal/tests.h      |   0
 .../lib => lib/perf}/include/internal/threadmap.h  |   0
 .../lib => lib/perf}/include/internal/xyarray.h    |   0
 tools/{perf/lib => lib/perf}/include/perf/core.h   |   0
 tools/{perf/lib => lib/perf}/include/perf/cpumap.h |   0
 tools/{perf/lib => lib/perf}/include/perf/event.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/evlist.h |   0
 tools/{perf/lib => lib/perf}/include/perf/evsel.h  |   0
 tools/{perf/lib => lib/perf}/include/perf/mmap.h   |   0
 .../lib => lib/perf}/include/perf/threadmap.h      |   0
 tools/{perf/lib => lib/perf}/internal.h            |   0
 tools/{perf/lib => lib/perf}/lib.c                 |   0
 tools/{perf/lib => lib/perf}/libperf.map           |   0
 tools/{perf/lib => lib/perf}/libperf.pc.template   |   0
 tools/{perf/lib => lib/perf}/mmap.c                |   0
 tools/{perf/lib => lib/perf}/tests/Makefile        |   2 +-
 tools/{perf/lib => lib/perf}/tests/test-cpumap.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evlist.c   |   0
 tools/{perf/lib => lib/perf}/tests/test-evsel.c    |   0
 .../{perf/lib => lib/perf}/tests/test-threadmap.c  |   0
 tools/{perf/lib => lib/perf}/threadmap.c           |   0
 tools/{perf/lib => lib/perf}/xyarray.c             |   0
 tools/lib/string.c                                 |   7 +
 tools/perf/Documentation/perf-annotate.txt         |   6 +
 tools/perf/Documentation/perf-report.txt           |   6 +
 tools/perf/Documentation/perf-sched.txt            |   4 +
 tools/perf/Documentation/perf-top.txt              |   6 +
 tools/perf/MANIFEST                                |   1 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/builtin-annotate.c                      |   7 +
 tools/perf/builtin-c2c.c                           |  14 +-
 tools/perf/builtin-record.c                        |  28 +-
 tools/perf/builtin-report.c                        |  16 +-
 tools/perf/builtin-sched.c                         |  13 +
 tools/perf/builtin-top.c                           |   7 +
 tools/perf/lib/Documentation/Makefile              |   7 -
 tools/perf/lib/Documentation/man/libperf.rst       | 100 ---
 tools/perf/lib/Documentation/tutorial/tutorial.rst | 123 ----
 tools/perf/tests/bp_signal.c                       |  10 +-
 tools/perf/trace/beauty/sockaddr.c                 |   2 +-
 tools/perf/ui/browsers/hists.c                     | 277 ++++++---
 tools/perf/ui/browsers/hists.h                     |   2 +-
 tools/perf/ui/browsers/res_sample.c                |   2 +-
 tools/perf/ui/browsers/scripts.c                   |   2 +-
 tools/perf/ui/gtk/Build                            |   7 +-
 tools/perf/ui/tui/util.c                           |  12 +-
 tools/perf/ui/util.h                               |   2 +-
 tools/perf/util/annotate.c                         |  19 +-
 tools/perf/util/annotate.h                         |   5 +
 tools/perf/util/c++/clang.cpp                      |   4 +
 tools/perf/util/expr.y                             |   3 +-
 tools/perf/util/header.c                           |   2 +-
 tools/perf/util/mmap.c                             |  40 +-
 tools/perf/util/mmap.h                             |  13 +-
 tools/perf/util/parse-events.y                     |   2 +-
 tools/perf/util/sort.c                             |   3 +-
 tools/perf/util/sort.h                             |   2 +
 128 files changed, 2515 insertions(+), 1591 deletions(-)
 rename tools/{perf/lib => lib/perf}/Build (100%)
 create mode 100644 tools/lib/perf/Documentation/Makefile
 create mode 100644 tools/lib/perf/Documentation/asciidoc.conf
 create mode 100644 tools/lib/perf/Documentation/examples/sampling.c
 create mode 100644 tools/lib/perf/Documentation/libperf-counting.txt
 create mode 100644 tools/lib/perf/Documentation/libperf-sampling.txt
 create mode 100644 tools/lib/perf/Documentation/libperf.txt
 create mode 100644 tools/lib/perf/Documentation/manpage-1.72.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-base.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-bold-literal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-normal.xsl
 create mode 100644 tools/lib/perf/Documentation/manpage-suppress-sp.xsl
 rename tools/{perf/lib => lib/perf}/Makefile (96%)
 rename tools/{perf/lib => lib/perf}/core.c (100%)
 rename tools/{perf/lib => lib/perf}/cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/evlist.c (99%)
 rename tools/{perf/lib => lib/perf}/evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/lib.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/tests.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/internal/xyarray.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/core.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/cpumap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/event.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evlist.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/evsel.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/mmap.h (100%)
 rename tools/{perf/lib => lib/perf}/include/perf/threadmap.h (100%)
 rename tools/{perf/lib => lib/perf}/internal.h (100%)
 rename tools/{perf/lib => lib/perf}/lib.c (100%)
 rename tools/{perf/lib => lib/perf}/libperf.map (100%)
 rename tools/{perf/lib => lib/perf}/libperf.pc.template (100%)
 rename tools/{perf/lib => lib/perf}/mmap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/Makefile (93%)
 rename tools/{perf/lib => lib/perf}/tests/test-cpumap.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evlist.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-evsel.c (100%)
 rename tools/{perf/lib => lib/perf}/tests/test-threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/threadmap.c (100%)
 rename tools/{perf/lib => lib/perf}/xyarray.c (100%)
 delete mode 100644 tools/perf/lib/Documentation/Makefile
 delete mode 100644 tools/perf/lib/Documentation/man/libperf.rst
 delete mode 100644 tools/perf/lib/Documentation/tutorial/tutorial.rst

