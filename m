Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6E4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B5D206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585587781;
	bh=YKny/yppanFT9WZt4fhzuS3AfBDl5f/Agt76pQGDUjo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kwrecKyQjTKeBxNoNugiZ/vamFihc3EabRwlf74+35PW/yD8JIUl9WNZMZULpP9ul
	 LKfAdqADAGvRZzjmsEhv0xWjQlAI3Vis20via6TmkZ8aTkufwQ9Z1dyRMHWo19kEJV
	 LPZVJHI8RK92PXGYPBbEZZP6jNuJAZHH9l7FWQHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgC3RC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:02:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgC3RC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:02:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id z18so20769316wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WQGABGNHraR3DzQzmg7r3Vwp3lNh3i3ZmUY3RbyIUNk=;
        b=AdOgOwPPHAtoDrps32DknzGx0qthFTqbTFLBvO7cUtv/OES5+r5orRVcAK8w3L7R6u
         OintGhyMsPAt/saVsbycNFvwsd97PxFllMBXOOethZa7wWJUI6+t48IuTAMN1IUiafBD
         rx8I1b7N8Kluyj8GQtaBdHmBr9wBVMPAwRjl2HInwXFdOekpL+VtbHwpDDuC/jfqUMYC
         hhtcZstXhS/0sGIZBX3LE9Uog22cLvDvmMDAwYrnrhiT+S2Dkf20ZJy2aHR7wQoXX8XH
         rlhvHJTY8Q96ZhbvrXlKKI7LomsWVa4W2Hw58psHKWgyF5iBnmi0lYzHsv8YzKh3wtEf
         /06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WQGABGNHraR3DzQzmg7r3Vwp3lNh3i3ZmUY3RbyIUNk=;
        b=Czo4XhDhuLynCktbfzU19SYPmPcolKT0zSp2NHkNjTDdrFH1KJFTOiHKJ1wSrxJLRp
         I9BiZTxxiYkHgJqHB9BicYyqJ0wnI2zz38gSMQNgr/Aba0UJCIRrKh725ZemlH35fadZ
         r7w2m12Uo4vSeXUY9GKJN64NwT5x3mJSdtxDRySaYLDDkY4oCll7wtlZCnAUfcXFi3zs
         Drst0dT913Go2R2T82UB/j6QeFgCjuqQt6xbkUOT3wuu+ARtQLyM/ECtbCvZ7JAaar7U
         SCi7WkESahMq0JK9abar1QHodWEAOXIVb5i21GR+v34e/smqdNNr2ChgNNo9M4gZWV8V
         ErGA==
X-Gm-Message-State: ANhLgQ0ZqGPQOHFDxqGBgIMnZxZqaw7JbfoRByEc4z8TMChtjVvTfHxA
        vCsMS80oVPxII+7oHW7teenrDdma
X-Google-Smtp-Source: ADFU+vud1+DaEp0F9KnkOa1i6Drw6YRfSc9La39H8lyVKWF8z5IZG+g6qSuDYD8EWcERXFltC8QDNA==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr235555wmk.27.1585587775362;
        Mon, 30 Mar 2020 10:02:55 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h10sm23724450wrq.33.2020.03.30.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:02:54 -0700 (PDT)
Date:   Mon, 30 Mar 2020 19:02:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL] perf changes for v5.7
Message-ID: <20200330170252.GA125774@gmail.com>
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

   # HEAD: 629b3df7ecb01fddfdf71cb5d3c563d143117c33 Merge branch 'x86/cpu' into perf/core, to resolve conflict

The main changes in this cycle were:

Kernel side changes:

 - A couple of x86/cpu cleanups and changes were grandfathered in due to 
   patch dependencies. These clean up the set of CPU model/family 
   matching macros with a consistent namespace and C99 initializer style.

 - A bunch of updates to various low level PMU drivers:
   - AMD Family 19h L3 uncore PMU
   - Intel Tiger Lake uncore support
   - misc fixes to LBR TOS sampling

 - optprobe fixes

 - perf/cgroup: optimize cgroup event sched-in processing

 - misc cleanups and fixes

Tooling side changes are to:

 - perf annotate,
 - perf expr,
 - perf record,
 - perf report,
 - perf stat,
 - perf test,
 - perl scripting,
 - libapi, libperf and libtraceevent,
 - vendor events on Intel and S390, ARM cs-etm
 - Intel PT updates
 - Documentation changes and updates to core facilities
 - misc cleanups, fixes and other enhancements.

 Thanks,

	Ingo

------------------>
Adrian Hunter (3):
      perf intel-pt: Rename intel-pt.txt and put it in man page format
      perf intel-pt: Add Intel PT man page references
      perf intel-pt: Update intel-pt.txt file with new location of the documentation

Alexey Budankov (1):
      perf record: Fix binding of AIO user space buffers to nodes

Arnaldo Carvalho de Melo (3):
      perf llvm: Add debug hint message about missing kernel-devel package
      tools headers UAPI: Update tools's copy of linux/perf_event.h
      perf map: Use strstarts() to look for Android libraries

Borislav Petkov (1):
      x86/amd_nb, char/amd64-agp: Use amd_nb_num() accessor

Dan Carpenter (1):
      perf/core: Fix reversed NULL check in perf_event_groups_less()

Ian Rogers (8):
      lib: Introduce generic min-heap
      perf/core: Use min_heap in visit_groups_merge()
      perf/core: Add per perf_cpu_context min_heap storage
      perf/cgroup: Grow per perf_cpu_context heap storage
      perf/cgroup: Order events in RB tree by cgroup id
      perf doc: Set man page date to last git commit
      perf test: Print if shell directory isn't present
      perf tools: Give synthetic mmap events an inode generation

Jin Yao (6):
      perf stat: Show percore counts in per CPU output
      perf block-info: Fix wrong block address comparison in block_info__cmp()
      perf diff: Use __block_info__cmp() to replace block_pair_cmp()
      perf block-info: Allow selecting which columns to report and its order
      perf block-info: Support color ops to print block percents in color
      perf report: Fix no branch type statistics report issue

Jiri Olsa (6):
      perf expr: Add expr.c object
      perf expr: Move expr lexer to flex
      perf expr: Increase EXPR_MAX_OTHER to support metrics with more than 15 variables
      perf expr: Straighten expr__parse()/expr__find_other() interface
      perf expr: Make expr__parse() return -1 on error
      perf expr: Fix copy/paste mistake

Kan Liang (14):
      perf/x86/intel: Avoid unnecessary PEBS_ENABLE MSR access in PMI
      perf/core: Add new branch sample type for HW index of raw branch records
      perf/x86/intel: Output LBR TOS information correctly
      perf/x86: Add Intel Tiger Lake uncore support
      perf tools: Add hw_idx in struct branch_stack
      perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
      perf header: Add check for unexpected use of reserved membrs in event attr
      perf jevents: Support metric constraint
      perf metricgroup: Factor out metricgroup__add_metric_weak_group()
      perf util: Factor out sysctl__nmi_watchdog_enabled()
      perf metricgroup: Support metric constraint
      perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint
      perf/x86/intel/uncore: Add box_offsets for free-running counters
      perf/x86/intel/uncore: Factor out __snr_uncore_mmio_init_box

Kim Phillips (4):
      x86/cpu/amd: Call init_amd_zn() om Family 19h processors too
      perf/amd/uncore: Prepare L3 thread mask code for Family 19h
      perf/amd/uncore: Make L3 thread mask code more readable
      perf/amd/uncore: Add support for Family 19h L3 PMU

Leo Yan (5):
      perf cs-etm: Swap packets for instruction samples
      perf cs-etm: Continuously record last branch
      perf cs-etm: Correct synthesizing instruction samples
      perf cs-etm: Optimize copying last branches
      perf cs-etm: Fix unsigned variable comparison to zero

Michael Petlan (2):
      libperf: Add counting example
      perf scripting perl: Add common_callchain to fix argument order

Namhyung Kim (1):
      tools lib api fs: Move cgroupsfs_find_mountpoint()

Nick Desaulniers (1):
      perf diff: Fix undefined string comparison spotted by clang's -Wstring-compare

Peter Zijlstra (5):
      perf/core: Unify {pinned,flexible}_sched_in()
      perf/core: Remove 'struct sched_in_data'
      perf/cgroup: Reorder perf_cgroup_connect()
      x86/optprobe: Fix OPTPROBE vs UACCESS
      perf/core: Fix endless multiplex timer

Ravi Bangoria (1):
      perf annotate: Get rid of annotation->nr_jumps

Steven Rostedt (VMware) (1):
      tools lib traceevent: Remove extra '\n' in print_event_time()

Thomas Gleixner (23):
      x86/devicetable: Move x86 specific macro out of generic code
      x86/cpu: Add consistent CPU match macros
      x86/cpu/bugs: Convert to new matching macros
      x86/perf/events: Convert to new CPU match macros
      x86/kvm: Convert to new CPU match macros
      x86/kernel: Convert to new CPU match macros
      x86/platform: Convert to new CPU match macros
      ACPI: Convert to new X86 CPU match macros
      cpufreq: Convert to new X86 CPU match macros
      EDAC: Convert to new X86 CPU match macros
      platform/x86: Convert to new CPU match macros
      hwmon: Convert to new X86 CPU match macros
      thermal: Convert to new X86 CPU match macros
      extcon: axp288: Convert to new X86 CPU match macros
      intel_idle: Convert to new X86 CPU match macros
      mmc: sdhci-acpi: Convert to new X86 CPU match macros
      PCI: intel-mid: Convert to new X86 CPU match macros
      powercap/intel_rapl: Convert to new X86 CPU match macros
      ASoC: Intel: Convert to new X86 CPU match macros
      crypto: Convert to new CPU match macros
      hwrng: via_rng: Convert to new X86 CPU match macros
      x86/cpu: Cleanup the now unused CPU match macros
      cpufreq/intel_pstate: Fix wrong macro conversion

Thomas Richter (1):
      perf vendor events s390: Add new deflate counters for IBM z15

Tony W Wang-oc (1):
      x86/Kconfig: Drop vendor dependency for X86_UMIP

disconnect3d (1):
      perf map: Fix off by one in strncpy() size argument


 arch/powerpc/perf/core-book3s.c                    |    1 +
 arch/x86/Kconfig                                   |    1 -
 arch/x86/crypto/aesni-intel_glue.c                 |    2 +-
 arch/x86/crypto/crc32-pclmul_glue.c                |    2 +-
 arch/x86/crypto/crc32c-intel_glue.c                |    2 +-
 arch/x86/crypto/crct10dif-pclmul_glue.c            |    2 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c         |    2 +-
 arch/x86/events/amd/power.c                        |    2 +-
 arch/x86/events/amd/uncore.c                       |   44 +-
 arch/x86/events/intel/core.c                       |   25 +-
 arch/x86/events/intel/cstate.c                     |   83 +-
 arch/x86/events/intel/lbr.c                        |    9 +
 arch/x86/events/intel/rapl.c                       |   58 +-
 arch/x86/events/intel/uncore.c                     |   75 +-
 arch/x86/events/intel/uncore.h                     |    7 +-
 arch/x86/events/intel/uncore_snb.c                 |  159 ++++
 arch/x86/events/intel/uncore_snbep.c               |   12 +-
 arch/x86/include/asm/amd_nb.h                      |    1 -
 arch/x86/include/asm/cpu_device_id.h               |  132 ++-
 arch/x86/include/asm/cpufeatures.h                 |    2 +-
 arch/x86/include/asm/intel-family.h                |   17 +-
 arch/x86/include/asm/kprobes.h                     |    1 +
 arch/x86/include/asm/perf_event.h                  |   15 +-
 arch/x86/kernel/amd_nb.c                           |    4 +-
 arch/x86/kernel/apic/apic.c                        |   32 +-
 arch/x86/kernel/cpu/amd.c                          |    3 +-
 arch/x86/kernel/cpu/common.c                       |    4 +-
 arch/x86/kernel/cpu/match.c                        |   13 +-
 arch/x86/kernel/kprobes/opt.c                      |   25 +
 arch/x86/kernel/smpboot.c                          |    2 +-
 arch/x86/kernel/tsc_msr.c                          |   14 +-
 arch/x86/kvm/svm.c                                 |    3 +-
 arch/x86/kvm/vmx/vmx.c                             |    3 +-
 arch/x86/platform/atom/punit_atom_debug.c          |   13 +-
 arch/x86/platform/efi/quirks.c                     |    7 +-
 .../platform/intel-mid/device_libs/platform_bt.c   |    5 +-
 arch/x86/platform/intel-quark/imr.c                |    2 +-
 arch/x86/platform/intel-quark/imr_selftest.c       |    2 +-
 arch/x86/power/cpu.c                               |   16 +-
 drivers/acpi/acpi_lpss.c                           |    6 +-
 drivers/acpi/x86/utils.c                           |   20 +-
 drivers/char/agp/amd64-agp.c                       |    2 +-
 drivers/char/hw_random/via-rng.c                   |    7 +-
 drivers/cpufreq/acpi-cpufreq.c                     |    5 +-
 drivers/cpufreq/amd_freq_sensitivity.c             |    3 +-
 drivers/cpufreq/e_powersaver.c                     |    2 +-
 drivers/cpufreq/elanfreq.c                         |    2 +-
 drivers/cpufreq/intel_pstate.c                     |   71 +-
 drivers/cpufreq/longhaul.c                         |    2 +-
 drivers/cpufreq/longrun.c                          |    3 +-
 drivers/cpufreq/p4-clockmod.c                      |    2 +-
 drivers/cpufreq/powernow-k6.c                      |    4 +-
 drivers/cpufreq/powernow-k7.c                      |    2 +-
 drivers/cpufreq/powernow-k8.c                      |    2 +-
 drivers/cpufreq/sc520_freq.c                       |    2 +-
 drivers/cpufreq/speedstep-centrino.c               |   14 +-
 drivers/cpufreq/speedstep-ich.c                    |   10 +-
 drivers/cpufreq/speedstep-smi.c                    |   10 +-
 drivers/crypto/padlock-aes.c                       |    2 +-
 drivers/crypto/padlock-sha.c                       |    2 +-
 drivers/edac/amd64_edac.c                          |   14 +-
 drivers/edac/i10nm_base.c                          |    8 +-
 drivers/edac/pnd2_edac.c                           |    4 +-
 drivers/edac/sb_edac.c                             |   14 +-
 drivers/edac/skx_base.c                            |    2 +-
 drivers/extcon/extcon-axp288.c                     |    2 +-
 drivers/hwmon/coretemp.c                           |    2 +-
 drivers/hwmon/via-cputemp.c                        |    8 +-
 drivers/idle/intel_idle.c                          |   79 +-
 drivers/mmc/host/sdhci-acpi.c                      |    4 +-
 drivers/pci/pci-mid.c                              |    6 +-
 drivers/platform/x86/intel-uncore-frequency.c      |   14 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |    4 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |    4 +-
 drivers/platform/x86/intel_pmc_core.c              |   24 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c       |   16 +-
 .../x86/intel_speed_select_if/isst_if_mbox_msr.c   |    4 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |    5 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |    7 +-
 drivers/platform/x86/intel_turbo_max_3.c           |    6 +-
 drivers/powercap/intel_rapl_common.c               |   87 +-
 drivers/thermal/intel/intel_powerclamp.c           |    2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c    |    5 +-
 drivers/thermal/intel/intel_soc_dts_thermal.c      |    3 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |    2 +-
 include/linux/min_heap.h                           |  134 +++
 include/linux/mod_devicetable.h                    |    4 +-
 include/linux/perf_event.h                         |   19 +
 include/uapi/linux/perf_event.h                    |    8 +-
 kernel/events/core.c                               |  357 +++++--
 lib/Kconfig.debug                                  |   10 +
 lib/Makefile                                       |    1 +
 lib/test_min_heap.c                                |  194 ++++
 sound/soc/intel/common/soc-intel-quirks.h          |   14 +-
 tools/include/uapi/linux/perf_event.h              |    8 +-
 tools/lib/api/fs/Build                             |    1 +
 tools/lib/api/fs/cgroup.c                          |   67 ++
 tools/lib/api/fs/fs.h                              |    2 +
 tools/lib/perf/Documentation/examples/counting.c   |   83 ++
 tools/lib/traceevent/event-parse.c                 |    2 +-
 tools/perf/Documentation/Makefile                  |    5 +-
 tools/perf/Documentation/intel-pt.txt              |  992 +------------------
 tools/perf/Documentation/perf-inject.txt           |    3 +-
 tools/perf/Documentation/perf-intel-pt.txt         | 1007 ++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt           |    2 +-
 tools/perf/Documentation/perf-report.txt           |    3 +-
 tools/perf/Documentation/perf-script.txt           |    2 +-
 tools/perf/Documentation/perf-stat.txt             |    9 +
 tools/perf/builtin-diff.c                          |   21 +-
 tools/perf/builtin-report.c                        |   30 +-
 tools/perf/builtin-script.c                        |   70 +-
 tools/perf/builtin-stat.c                          |    4 +
 .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |    8 +-
 .../perf/pmu-events/arch/s390/cf_z15/extended.json |   30 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |    3 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |    3 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    3 +-
 tools/perf/pmu-events/jevents.c                    |   19 +-
 tools/perf/pmu-events/jevents.h                    |    2 +-
 tools/perf/pmu-events/pmu-events.h                 |    1 +
 tools/perf/scripts/perl/check-perf-trace.pl        |    6 +-
 tools/perf/scripts/perl/failed-syscalls.pl         |    2 +-
 tools/perf/scripts/perl/rw-by-file.pl              |    6 +-
 tools/perf/scripts/perl/rw-by-pid.pl               |   10 +-
 tools/perf/scripts/perl/rwtop.pl                   |   10 +-
 tools/perf/scripts/perl/wakeup-latency.pl          |    6 +-
 tools/perf/tests/builtin-test.c                    |    5 +-
 tools/perf/tests/expr.c                            |   10 +-
 tools/perf/tests/sample-parsing.c                  |    7 +-
 tools/perf/util/Build                              |   11 +-
 tools/perf/util/annotate.c                         |    2 -
 tools/perf/util/annotate.h                         |    1 -
 tools/perf/util/block-info.c                       |  106 ++-
 tools/perf/util/block-info.h                       |    9 +-
 tools/perf/util/branch.h                           |   22 +
 tools/perf/util/cgroup.c                           |   63 +-
 tools/perf/util/cs-etm.c                           |  159 +++-
 tools/perf/util/event.h                            |    1 +
 tools/perf/util/evsel.c                            |   20 +-
 tools/perf/util/evsel.h                            |    6 +
 tools/perf/util/expr.c                             |  112 +++
 tools/perf/util/expr.h                             |    8 +-
 tools/perf/util/expr.l                             |  114 +++
 tools/perf/util/expr.y                             |  185 +---
 tools/perf/util/header.c                           |   37 +
 tools/perf/util/hist.c                             |    3 +-
 tools/perf/util/intel-pt.c                         |    2 +
 tools/perf/util/llvm-utils.c                       |    2 +
 tools/perf/util/machine.c                          |   35 +-
 tools/perf/util/map.c                              |    8 +-
 tools/perf/util/metricgroup.c                      |  109 ++-
 tools/perf/util/mmap.c                             |   21 +-
 tools/perf/util/perf_event_attr_fprintf.c          |    1 +
 .../util/scripting-engines/trace-event-python.c    |   30 +-
 tools/perf/util/session.c                          |    8 +-
 tools/perf/util/stat-display.c                     |   39 +-
 tools/perf/util/stat-shadow.c                      |    4 +-
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/synthetic-events.c                 |    7 +-
 tools/perf/util/util.c                             |   18 +
 tools/perf/util/util.h                             |    2 +
 161 files changed, 3532 insertions(+), 2098 deletions(-)
 create mode 100644 include/linux/min_heap.h
 create mode 100644 lib/test_min_heap.c
 create mode 100644 tools/lib/api/fs/cgroup.c
 create mode 100644 tools/lib/perf/Documentation/examples/counting.c
 create mode 100644 tools/perf/Documentation/perf-intel-pt.txt
 create mode 100644 tools/perf/util/expr.c
 create mode 100644 tools/perf/util/expr.l
