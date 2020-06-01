Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3973D20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591026884;
	bh=GyF1nmdSArqLtsnxv/DxXqrPfWerKyJn7bafJadv+9k=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VoYJit0yMZghkabrY600/eIk+Y1MAXEiGmtWO6pr2cfFuI77+u1Dovfl3sXpX3ONN
	 11pqbM27GXvdyrmje63wNEIZV+MT+kJKfMaAbNpPwZ26rIsfBrLzdXQrfDtJkuMU8Y
	 WReoal0RpM94CChWLIvfMjwrxX6nM7iCqHVthrP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgFAPyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:54:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C5C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:54:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so30388wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qdLArh4g+9sU5a/YaRrUtr4ZyJIcPV7SnukhPJSVWvQ=;
        b=g5Q4dyJhR3+GPQR0/vBa7nwkfXyMxF2Bj5EO2jn1/xf0jb4gioPVcH11Vh6PwaiB/y
         5VJqIGOHuuk9AsRJhKdZWmhC3czAS8QmMlEpDaMdlFGIRKCn1bGl9vHSZ0O2GBDUe9x1
         S3I+edM9p3itq0C/8svGvKwceTG1kSkLcCzFYvUSCus3VNXY6YszoiwJyzXB0nkN46mi
         u+2aUXyJhGDcnaLhBsKxajcEySn3RCH12y1GkdOx3ndz+AuiMQBOD9ohTqRjpuRYfSFi
         YuQ4adt01MpiQM+8Aa4J1FZVeYtmcU2V5OWTYHwNvb5xqFZOextn4rv8nUef60OANltO
         Jazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qdLArh4g+9sU5a/YaRrUtr4ZyJIcPV7SnukhPJSVWvQ=;
        b=JY+mo0lh4zt2cfjrdPatTaoFqBoASajgYU4GorMIK9mMkqJwc9+4bPMfFfHmA5snpy
         ufJQK7au8U5ZT68HFdjAFqLxCIBvA84ufkzKMSO+7Xo+ZMFuASOnU7kf5LdEmRBoSdW9
         ZaYC+K+lwE29SfdlIoNSZTWbWOZDORlQoF3R6oqlztToazrhsTzSDRJMGsUrA5wgeUln
         BLBq8HrbJcfKvjF3N2NzKlLQsboML0rP6bKkUWExjQEBYVanUC+rJxSdzQlEfvRJ6mZq
         /IpmRXrjuBr52opHyco9fVRDFlPCtpJHXhCaX1aJc9zVkv2oswi4HVd711GqsaOI5/Uk
         haLw==
X-Gm-Message-State: AOAM533Y8jQQg1IIAOhZG9xlPWhV38ax0bnXlejNZ3FwlE0Vn6X9Kbpr
        v/cLOlhDL1OPRKelie5DWZw=
X-Google-Smtp-Source: ABdhPJymmiJ1awOMR19ho0IHMStHK6sMZlmj0RXRyivYMt6acYQH0ZKviGYr4H3evEE3UVEvS1k0vA==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr25280wme.154.1591026880514;
        Mon, 01 Jun 2020 08:54:40 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v7sm23187313wre.93.2020.06.01.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:54:39 -0700 (PDT)
Date:   Mon, 1 Jun 2020 17:54:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf updates for v5.8
Message-ID: <20200601155437.GA1042527@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-06-01

   # HEAD: 5cde265384cad739b162cf08afba6da8857778bd perf/x86/rapl: Add AMD Fam17h RAPL support

Kernel side changes:

  - Add AMD Fam17h RAPL support
  - Introduce CAP_PERFMON to kernel and user space
  - Add Zhaoxin CPU support
  - Misc fixes and cleanups

Tooling changes:

  perf record:

    - Introduce --switch-output-event to use arbitrary events to be setup
      and read from a side band thread and, when they take place a signal
      be sent to the main 'perf record' thread, reusing the --switch-output
      code to take perf.data snapshots from the --overwrite ring buffer, e.g.:

	# perf record --overwrite -e sched:* \
		      --switch-output-event syscalls:*connect* \
		      workload

      will take perf.data.YYYYMMDDHHMMSS snapshots up to around the
      connect syscalls.

    - Add --num-synthesize-threads option to control degree of parallelism of the
      synthesize_mmap() code which is scanning /proc/PID/task/PID/maps and can be
      time consuming. This mimics pre-existing behaviour in 'perf top'.

  perf bench:

    - Add a multi-threaded synthesize benchmark.
    - Add kallsyms parsing benchmark.

  Intel PT support:

    - Stitch LBR records from multiple samples to get deeper backtraces,
      there are caveats, see the csets for details.
    - Allow using Intel PT to synthesize callchains for regular events.
    - Add support for synthesizing branch stacks for regular events (cycles,
      instructions, etc) from Intel PT data.

  Misc changes:

    - Updated perf vendor events for power9 and Coresight.
    - Add flamegraph.py script via 'perf flamegraph'
    - Misc other changes, fixes and cleanups - see the Git log for details.

Also, since over the last couple of years perf tooling has matured and 
decoupled from the kernel perf changes to a large degree, going 
forward Arnaldo is going to send perf tooling changes via direct pull 
requests to you.

 Thanks,

	Ingo

------------------>
Adrian Hunter (27):
      perf script: Simplify auxiliary event printing functions
      perf auxtrace: Add ->evsel_is_auxtrace() callback
      perf intel-pt: Implement ->evsel_is_auxtrace() callback
      perf intel-bts: Implement ->evsel_is_auxtrace() callback
      perf arm-spe: Implement ->evsel_is_auxtrace() callback
      perf cs-etm: Implement ->evsel_is_auxtrace() callback
      perf s390-cpumsf: Implement ->evsel_is_auxtrace() callback
      perf auxtrace: For reporting purposes, un-group AUX area event
      perf auxtrace: Add an option to synthesize callchains for regular events
      perf thread-stack: Add thread_stack__sample_late()
      perf evsel: Be consistent when looking which evsel PERF_SAMPLE_ bits are set
      perf evsel: Add support for synthesized sample type
      perf intel-pt: Add support for synthesizing callchains for regular events
      perf evsel: Move and globalize perf_evsel__find_pmu() and perf_evsel__is_aux_event()
      perf evlist: Move leader-sampling configuration
      perf evsel: Rearrange perf_evsel__config_leader_sampling()
      perf evlist: Allow multiple read formats
      perf tools: Add support for leader-sampling with AUX area events
      perf thread-stack: Add branch stack support
      perf intel-pt: Consolidate thread-stack use condition
      perf intel-pt: Change branch stack support to use thread-stacks
      perf auxtrace: Add option to synthesize branch stack for regular events
      perf evsel: Add support for synthesized branch stack sample type
      perf thread-stack: Add thread_stack__br_sample_late()
      perf intel-pt: Add support for synthesizing branch stacks for regular events
      perf intel-pt: Update documentation about itrace G and L options
      perf intel-pt: Update documentation about using /proc/kcore

Alexey Budankov (12):
      capabilities: Introduce CAP_PERFMON to kernel and user space
      perf/core: Open access to the core for CAP_PERFMON privileged process
      perf/core: open access to probes for CAP_PERFMON privileged process
      perf tools: Support CAP_PERFMON capability
      drm/i915/perf: Open access for CAP_PERFMON privileged process
      trace/bpf_trace: Open access for CAP_PERFMON privileged process
      powerpc/perf: open access for CAP_PERFMON privileged process
      parisc/perf: open access for CAP_PERFMON privileged process
      drivers/perf: Open access for CAP_PERFMON privileged process
      drivers/oprofile: Open access for CAP_PERFMON privileged process
      doc/admin-guide: Update perf-security.rst with CAP_PERFMON information
      doc/admin-guide: update kernel.rst with CAP_PERFMON information

Andreas Gerstmayr (1):
      perf script: Add flamegraph.py script

Arnaldo Carvalho de Melo (45):
      perf stat: Honour --timeout for forked workloads
      perf tools: Move routines that probe for perf API features to separate file
      perf record: Move sb_evlist to 'struct record'
      perf top: Move sb_evlist to 'struct perf_top'
      perf bpf: Decouple creating the evlist from adding the SB event
      perf parse-events: Add parse_events_option() variant that creates evlist
      perf evlist: Move the sideband thread routines to separate object
      perf evlist: Allow reusing the side band thread for more purposes
      libsubcmd: Introduce OPT_CALLBACK_SET()
      perf record: Introduce --switch-output-event
      perf record: Move side band evlist setup to separate routine
      perf evsel: Rename 'struct perf_evsel__sb_cb_t' to 'struct evsel__sb_cb_t'
      perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()
      perf evsel: Rename perf_evsel__compute_deltas() to evsel__compute_deltas()
      perf evsel: Rename perf_evsel__find_pmu() to evsel__find_pmu()
      perf evsel: Rename perf_evsel__is_aux_event() to evsel__is_aux_event()
      perf evsel: Rename perf_evsel__exit() to evsel__exit()
      perf evsel: Rename perf_evsel__config*() to evsel__config*()
      perf evsel: Rename perf_evsel__calc_id_pos() to evsel__calc_id_pos()
      perf evsel: Rename __perf_evsel__sample_size() to __evsel__sample_size()
      perf evsel: Rename *perf_evsel__*name() to *evsel__*name()
      perf evsel: Rename perf_evsel__group_desc() to evsel__group_desc()
      perf evsel: Rename *perf_evsel__*set_sample_*() to *evsel__*set_sample_*()
      perf evsel: Rename perf_evsel__*filter*() to evsel__*filter*()
      perf evsel: Rename perf_evsel__open_per_*() to evsel__open_per_*()
      perf evsel: Rename perf_evsel__{str,int}val() and other tracepoint field metehods to to evsel__*()
      perf evsel: Rename perf_evsel__is_*() to evsel__is*()
      perf evsel: Ditch perf_evsel__cmp(), not used for quite a while
      perf evsel: Rename *perf_evsel__read*() to *evsel__read()
      perf evsel: Rename perf_evsel__parse_sample*() to evsel__parse_sample*()
      perf evsel: Rename perf_evsel__{prev,next}() to evsel__{prev,next}()
      perf evsel: Rename perf_evsel__has*() to evsel__has*()
      perf evsel: Rename perf_evsel__fallback() to evsel__fallback()
      perf evsel: Rename perf_evsel__group_idx() to evsel__group_idx()
      perf evsel: Rename perf_evsel__env() to evsel__env()
      perf evsel: Rename perf_evsel__store_ids() to evsel__store_id()
      perf stat: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf kmem: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf lock: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf sched: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf script: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf trace: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf annotate: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf inject: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf flamegraph: Use /bin/bash for report and record scripts

Barret Rhoden (1):
      perf: Add cond_resched() to task_function_call()

CodyYao-oc (1):
      x86/perf: Add hardware performance events support for Zhaoxin CPU.

Gustavo A. R. Silva (2):
      perf/x86: Replace zero-length array with flexible-array
      perf/core: Replace zero-length array with flexible-array

He Zhe (2):
      tools lib traceevent: Take care of return value of asprintf
      libperf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.

Ian Rogers (16):
      perf bench: Add event synthesis benchmark
      perf synthetic-events: save 4kb from 2 stack frames
      perf doc: allow ASCIIDOC_EXTRA to be an argument
      perf script: Avoid NULL dereference on symbol
      perf bench: Add a multi-threaded synthesize benchmark
      tools api: Add a lightweight buffered reading api
      perf synthetic events: Remove use of sscanf from /proc reading
      perf parse-events: Fix memory leaks found on parse_events
      perf parse-events: Fix memory leaks found on parse_events
      perf parse-events: Fix another memory leaks found on parse_events()
      libperf evlist: Fix a refcount leak
      perf mem2node: Avoid double free related to realloc
      perf doc: Pass ASCIIDOC_EXTRA as an argument
      perf bench: Add kallsyms parsing
      libsymbols kallsyms: Parse using io api
      libsymbols kallsyms: Move hex2u64 out of header

Jagadeesh Pagadala (1):
      perf evlist: Remove duplicate headers

Jin Yao (2):
      perf stat: Zero all the 'ena' and 'run' array slot stats for interval mode
      perf stat: Improve runtime stat for interval mode

Jiri Olsa (6):
      perf tools: Synthesize bpf_trampoline/dispatcher ksymbol event
      perf machine: Set ksymbol dso as loaded on arrival
      perf annotate: Add basic support for bpf_image
      perf expr: Add expr_ prefix for parse_ctx and parse_id
      perf expr: Add expr_scanner_ctx object
      perf parser: Add support to specify rXXX event with pmu

Kajol Jain (5):
      perf metrictroup: Split the metricgroup__add_metric function
      perf metricgroups: Enhance JSON/metric infrastructure to handle "?"
      perf tests expr: Added test for runtime param in metric expression
      perf tools: Enable Hz/hz prinitg for --metric-only option
      perf vendor events power9: Add hv_24x7 socket/chip level metric events

Kan Liang (17):
      perf pmu: Add support for PMU capabilities
      perf header: Support CPU PMU capabilities
      perf machine: Remove the indent in resolve_lbr_callchain_sample
      perf machine: Refine the function for LBR call stack reconstruction
      perf machine: Factor out lbr_callchain_add_kernel_ip()
      perf machine: Factor out lbr_callchain_add_lbr_ip()
      perf thread: Add a knob for LBR stitch approach
      perf thread: Save previous sample for LBR stitching approach
      perf callchain: Save previous cursor nodes for LBR stitching approach
      perf callchain: Stitch LBR call stack
      perf report: Add option to enable the LBR stitching approach
      perf script: Add option to enable the LBR stitching approach
      perf top: Add option to enable the LBR stitching approach
      perf c2c: Add option to enable the LBR stitching approach
      perf hist: Add fast path for duplicate entries check
      perf/x86/rapl: Add Ice Lake RAPL support
      perf/x86/intel: Add more available bits for OFFCORE_RESPONSE of Intel Tremont

Konstantin Khlebnikov (2):
      perf tools: Fix reading new topology attribute "core_cpus"
      perf tools: Simplify checking if SMT is active.

Leo Yan (1):
      perf cs-etm: Move definition of 'traceid_list' global variable from header file

Mike Leach (1):
      perf: cs-etm: Update to build with latest opencsd version.

Paul Gortmaker (1):
      perf/x86/intel/pt: Drop pointless NULL assignment.

Shaokun Zhang (1):
      perf pmu: Fix function name in comment, its get_cpuid_str(), not get_cpustr()

Stephane Eranian (11):
      tools api fs: Make xxx__mountpoint() more scalable
      perf stat: Force error in fallback on :k events
      perf record: Add num-synthesize-threads option
      perf script: Remove extraneous newline in perf_sample__fprintf_regs()
      tools feature: Add support for detecting libpfm4
      perf pmu: Add perf_pmu__find_by_type helper
      perf/x86/rapl: Move RAPL support to common x86 code
      perf/x86/rapl: Refactor to share the RAPL code between Intel and AMD CPUs
      perf/x86/rapl: Flip logic on default events visibility
      perf/x86/rapl: Make perf_probe_msr() more robust and flexible
      perf/x86/rapl: Add AMD Fam17h RAPL support

Thomas Richter (1):
      perf symbol: Fix kernel symbol address display

Tommi Rantala (3):
      perf cgroup: Avoid needless closing of unopened fd
      perf bench: Fix div-by-zero if runtime is zero
      perf test session topology: Fix data path

Zou Wei (4):
      libtraceevent: Remove unneeded semicolon
      perf c2c: Remove unneeded semicolon
      perf tools: Remove unneeded semicolons
      perf report: Fix warning assignment of 0/1 to bool variable


 Documentation/admin-guide/perf-security.rst        |  86 ++-
 Documentation/admin-guide/sysctl/kernel.rst        |  16 +-
 arch/parisc/kernel/perf.c                          |   2 +-
 arch/powerpc/perf/imc-pmu.c                        |   4 +-
 arch/x86/events/Kconfig                            |   6 +-
 arch/x86/events/Makefile                           |   3 +
 arch/x86/events/core.c                             |   4 +
 arch/x86/events/intel/Makefile                     |   2 -
 arch/x86/events/intel/bts.c                        |   2 +-
 arch/x86/events/intel/core.c                       |   4 +-
 arch/x86/events/intel/pt.c                         |   2 -
 arch/x86/events/intel/uncore.h                     |   2 +-
 arch/x86/events/perf_event.h                       |  10 +
 arch/x86/events/probe.c                            |  13 +
 arch/x86/events/{intel => }/rapl.c                 |  69 ++-
 arch/x86/events/zhaoxin/Makefile                   |   2 +
 arch/x86/events/zhaoxin/core.c                     | 613 +++++++++++++++++++++
 arch/x86/include/asm/msr-index.h                   |   3 +
 arch/x86/kernel/cpu/perfctr-watchdog.c             |   8 +
 drivers/gpu/drm/i915/i915_perf.c                   |  13 +-
 drivers/oprofile/event_buffer.c                    |   2 +-
 drivers/perf/arm_spe_pmu.c                         |   4 +-
 include/linux/capability.h                         |   4 +
 include/linux/perf_event.h                         |  10 +-
 include/uapi/linux/capability.h                    |   8 +-
 kernel/events/callchain.c                          |   2 +-
 kernel/events/core.c                               |  29 +-
 kernel/events/internal.h                           |   2 +-
 kernel/trace/bpf_trace.c                           |   2 +-
 security/selinux/include/classmap.h                |   4 +-
 tools/build/Makefile.feature                       |   3 +-
 tools/build/feature/Makefile                       |   6 +-
 tools/build/feature/test-libopencsd.c              |   4 +-
 tools/build/feature/test-libpfm4.c                 |   9 +
 tools/lib/api/fs/fs.c                              |  17 +
 tools/lib/api/fs/fs.h                              |  12 +
 tools/lib/api/io.h                                 | 115 ++++
 tools/lib/perf/cpumap.c                            |   2 +-
 tools/lib/perf/evlist.c                            |   4 +-
 tools/lib/subcmd/parse-options.h                   |   2 +
 tools/lib/symbol/kallsyms.c                        |  86 ++-
 tools/lib/symbol/kallsyms.h                        |   2 -
 tools/lib/traceevent/kbuffer-parse.c               |   2 +-
 tools/lib/traceevent/parse-filter.c                |  29 +-
 tools/perf/Documentation/Makefile                  |   4 +-
 tools/perf/Documentation/itrace.txt                |   6 +
 tools/perf/Documentation/perf-bench.txt            |   8 +
 tools/perf/Documentation/perf-c2c.txt              |  11 +
 tools/perf/Documentation/perf-intel-pt.txt         |  53 +-
 tools/perf/Documentation/perf-list.txt             |   8 +
 tools/perf/Documentation/perf-record.txt           |  17 +
 tools/perf/Documentation/perf-report.txt           |  11 +
 tools/perf/Documentation/perf-script.txt           |  11 +
 tools/perf/Documentation/perf-stat.txt             |   2 +
 tools/perf/Documentation/perf-top.txt              |   9 +
 tools/perf/Documentation/perf.data-file-format.txt |  16 +
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
 tools/perf/arch/arm64/util/arm-spe.c               |  12 +-
 tools/perf/arch/powerpc/util/header.c              |   8 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +-
 tools/perf/arch/s390/util/kvm-stat.c               |   8 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   6 +-
 tools/perf/arch/x86/util/intel-bts.c               |   2 +-
 tools/perf/arch/x86/util/intel-pt.c                |  21 +-
 tools/perf/arch/x86/util/kvm-stat.c                |  12 +-
 tools/perf/bench/Build                             |   3 +-
 tools/perf/bench/bench.h                           |   3 +-
 tools/perf/bench/epoll-wait.c                      |   3 +-
 tools/perf/bench/futex-hash.c                      |   3 +-
 tools/perf/bench/futex-lock-pi.c                   |   3 +-
 tools/perf/bench/kallsyms-parse.c                  |  75 +++
 tools/perf/bench/synthesize.c                      | 262 +++++++++
 tools/perf/builtin-annotate.c                      |  15 +-
 tools/perf/builtin-bench.c                         |   7 +
 tools/perf/builtin-c2c.c                           |  21 +-
 tools/perf/builtin-diff.c                          |   8 +-
 tools/perf/builtin-ftrace.c                        |   5 +-
 tools/perf/builtin-inject.c                        |  19 +-
 tools/perf/builtin-kmem.c                          |  65 +--
 tools/perf/builtin-kvm.c                           |  23 +-
 tools/perf/builtin-lock.c                          |  42 +-
 tools/perf/builtin-mem.c                           |   2 +-
 tools/perf/builtin-record.c                        | 117 +++-
 tools/perf/builtin-report.c                        |  36 +-
 tools/perf/builtin-sched.c                         |  78 ++-
 tools/perf/builtin-script.c                        | 391 ++++---------
 tools/perf/builtin-stat.c                          |  36 +-
 tools/perf/builtin-timechart.c                     |  52 +-
 tools/perf/builtin-top.c                           |  47 +-
 tools/perf/builtin-trace.c                         | 115 ++--
 tools/perf/design.txt                              |   3 +-
 .../arch/powerpc/power9/nest_metrics.json          |  19 +
 tools/perf/pmu-events/pmu-events.h                 |   2 +-
 tools/perf/scripts/python/bin/flamegraph-record    |   2 +
 tools/perf/scripts/python/bin/flamegraph-report    |   3 +
 tools/perf/scripts/python/flamegraph.py            | 124 +++++
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/api-io.c                          | 304 ++++++++++
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/event-times.c                     |   8 +-
 tools/perf/tests/event_update.c                    |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c            |  20 +-
 tools/perf/tests/evsel-tp-sched.c                  |   2 +-
 tools/perf/tests/expr.c                            |  20 +-
 tools/perf/tests/hists_cumulate.c                  |   8 +-
 tools/perf/tests/mmap-basic.c                      |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   6 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   6 +-
 tools/perf/tests/openat-syscall.c                  |   8 +-
 tools/perf/tests/parse-events.c                    | 155 +++---
 tools/perf/tests/perf-record.c                     |   6 +-
 tools/perf/tests/sample-parsing.c                  |   6 +-
 tools/perf/tests/switch-tracking.c                 |  14 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/topology.c                        |  12 +-
 tools/perf/ui/browsers/hists.c                     |  18 +-
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/ui/gtk/hists.c                          |   6 +-
 tools/perf/ui/hist.c                               |  16 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate.c                         |  40 +-
 tools/perf/util/arm-spe.c                          |   9 +
 tools/perf/util/auxtrace.c                         | 125 +++--
 tools/perf/util/auxtrace.h                         |  16 +
 tools/perf/util/bpf-event.c                        |  96 +++-
 tools/perf/util/bpf-event.h                        |   7 +-
 tools/perf/util/bpf-loader.c                       |   2 +-
 tools/perf/util/branch.h                           |  19 +-
 tools/perf/util/callchain.h                        |   8 +
 tools/perf/util/cap.h                              |   4 +
 tools/perf/util/cgroup.c                           |   3 +-
 tools/perf/util/cloexec.c                          |   2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   2 +
 tools/perf/util/cs-etm.c                           |  14 +
 tools/perf/util/cs-etm.h                           |   3 -
 tools/perf/util/data-convert-bt.c                  |   6 +-
 tools/perf/util/dso.c                              |   1 +
 tools/perf/util/dso.h                              |   1 +
 tools/perf/util/env.h                              |   3 +
 tools/perf/util/event.c                            |   2 +-
 tools/perf/util/evlist.c                           | 159 +-----
 tools/perf/util/evlist.h                           |   9 +-
 tools/perf/util/evsel.c                            | 343 ++++++------
 tools/perf/util/evsel.h                            | 194 +++----
 tools/perf/util/evsel_config.h                     |   2 +-
 tools/perf/util/evsel_fprintf.c                    |   8 +-
 tools/perf/util/expr.c                             |  25 +-
 tools/perf/util/expr.h                             |  19 +-
 tools/perf/util/expr.l                             |  37 +-
 tools/perf/util/expr.y                             |   6 +-
 tools/perf/util/header.c                           | 121 +++-
 tools/perf/util/header.h                           |   1 +
 tools/perf/util/hist.c                             |  31 +-
 tools/perf/util/intel-bts.c                        |  16 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   2 +-
 tools/perf/util/intel-pt.c                         | 306 ++++++----
 tools/perf/util/machine.c                          | 436 ++++++++++++---
 tools/perf/util/mem2node.c                         |   3 +-
 tools/perf/util/metricgroup.c                      |  78 ++-
 tools/perf/util/metricgroup.h                      |   2 +
 tools/perf/util/ordered-events.c                   |   2 +-
 tools/perf/util/parse-events.c                     |  39 +-
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/parse-events.l                     |   1 +
 tools/perf/util/parse-events.y                     |  12 +-
 tools/perf/util/perf_api_probe.c                   | 164 ++++++
 tools/perf/util/perf_api_probe.h                   |  14 +
 tools/perf/util/pmu.c                              | 113 ++++
 tools/perf/util/pmu.h                              |  10 +
 tools/perf/util/python.c                           |   4 +-
 tools/perf/util/record.c                           | 185 ++-----
 tools/perf/util/record.h                           |   1 +
 tools/perf/util/s390-cpumcf-kernel.h               |   1 +
 tools/perf/util/s390-cpumsf.c                      |  12 +-
 .../util/scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/session.c                          |   9 +-
 tools/perf/util/sideband_evlist.c                  | 148 +++++
 tools/perf/util/smt.c                              |  10 +-
 tools/perf/util/sort.c                             |  12 +-
 tools/perf/util/sort.h                             |   2 +
 tools/perf/util/stat-display.c                     |  23 +-
 tools/perf/util/stat-shadow.c                      |  55 +-
 tools/perf/util/stat.c                             |  24 +-
 tools/perf/util/symbol.c                           |  15 +
 tools/perf/util/synthetic-events.c                 | 179 +++---
 tools/perf/util/thread-stack.c                     | 274 ++++++++-
 tools/perf/util/thread-stack.h                     |  11 +-
 tools/perf/util/thread.c                           |  24 +
 tools/perf/util/thread.h                           |  15 +
 tools/perf/util/top.c                              |   2 +-
 tools/perf/util/top.h                              |   3 +-
 tools/perf/util/trace-event-read.c                 |   2 +-
 tools/perf/util/util.c                             |   1 +
 194 files changed, 5221 insertions(+), 1993 deletions(-)
 rename arch/x86/events/{intel => }/rapl.c (91%)
 create mode 100644 arch/x86/events/zhaoxin/Makefile
 create mode 100644 arch/x86/events/zhaoxin/core.c
 create mode 100644 tools/build/feature/test-libpfm4.c
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/bench/kallsyms-parse.c
 create mode 100644 tools/perf/bench/synthesize.c
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 create mode 100755 tools/perf/scripts/python/flamegraph.py
 create mode 100644 tools/perf/tests/api-io.c
 create mode 100644 tools/perf/util/perf_api_probe.c
 create mode 100644 tools/perf/util/perf_api_probe.h
 create mode 100644 tools/perf/util/sideband_evlist.c
