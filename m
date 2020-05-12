Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A4FC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FF8206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgELMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:43193 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgELMTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:09 -0400
IronPort-SDR: gb9/nfZwvSx5yJu/iMY2DXTjALoDMfS3SwY8neFveKGX/Nj3GF6vBI3qZeh3l3qMeCpuBzdEgQ
 MvoQWqMYzc/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:07 -0700
IronPort-SDR: MDCNdQZWgLFq03O3l+bknwqi5ZatL+EMgypuAICWlgeA5SzAHGfy3kt6/WWZVMRNpyCOZOQnMP
 DlqnbM+0en3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879139"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 00/15] perf/x86: Add perf text poke events
Date:   Tue, 12 May 2020 15:19:07 +0300
Message-Id: <20200512121922.8997-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to add a text poke event to record changes to kernel text
(i.e. self-modifying code) in order to support tracers like Intel PT
decoding through jump labels, kprobes and ftrace trampolines.

The first 8 patches make the kernel changes and the subsequent patches are
tools changes.

The next 4 patches add support for updating perf tools' data cache
with the changed bytes.

The next patch is an Intel PT specific tools change.

The final 2 patches add perf script --show-text-poke-events option

Patches also here:

	git://git.infradead.org/users/ahunter/linux-perf.git text_poke

Changes in V7

  perf: Add perf text poke event
  perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
  kprobes: Add symbols for kprobe insn pages
  kprobes: Add perf ksymbol events for kprobe insn pages
  perf/x86: Add perf text poke events for kprobes
  ftrace: Add symbols for ftrace trampolines
  ftrace: Add perf ksymbol events for ftrace trampolines
  ftrace: Add perf text poke events for ftrace trampolines

	Added Peter's Ack
	Improved commit message for text_poke events for ftrace trampolines

  perf kcore_copy: Fix module map when there are no modules loaded
  perf evlist: Disable 'immediate' events last
  perf tools: Add support for PERF_RECORD_TEXT_POKE
  perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
  perf intel-pt: Add support for text poke events
  perf script: Add option --show-text-poke-events
  perf script: Show text poke address symbol

	Re-based on Arnaldo's perf/core branch

Changes in V6

  perf: Add perf text poke event

	Adjustments due to re-base on top of cgroup event patches

  perf/x86: Add perf text poke events for kprobes

	Expand commit message
	Add Masami's Ack

  perf tools: Add support for PERF_RECORD_TEXT_POKE

	Adjustments due to re-base on top of cgroup event patches
	Improvements to perf_event__fprintf_text_poke()

  perf script: Add option --show-text-poke-events
  perf script: Show text poke address symbol

	New patches

Changes in V5

  perf/x86: Add perf text poke events for kprobes

	Simplify optimized kprobes events (Peter)

Changes in V4

  kprobes: Add symbols for kprobe insn pages

	Change "module name" from kprobe to __builtin__kprobes
	Added comment about "module name" use

  ftrace: Add symbols for ftrace trampolines
	
	Change "module name" from ftrace to __builtin__ftrace
	Move calls of ftrace_add_trampoline_to_kallsyms() and
	ftrace_remove_trampoline_from_kallsyms() into
	kernel/trace/ftrace.c
	Added comment about "module name" use

  ftrace: Add perf ksymbol events for ftrace trampolines

	Move changes into kernel/trace/ftrace.c

  ftrace: Add perf text poke events for ftrace trampolines

	Move changes into kernel/trace/ftrace.c

Changes in V3:

  perf: Add perf text poke event

	To prevent warning, cast pointer to (unsigned long) not (u64)

  kprobes: Add symbols for kprobe insn pages

	Expand commit message
	Remove un-needed declarations of kprobe_cache_get_kallsym() and arch_kprobe_get_kallsym() when !CONFIG_KPROBES

  ftrace: Add symbols for ftrace trampolines

	Expand commit message
	Make ftrace_get_trampoline_kallsym() static

Changes in V2:

  perf: Add perf text poke event

	Separate out x86 changes
	The text poke event now has old len and new len
	Revised commit message

  perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers

	New patch containing x86 changes from original first patch

  kprobes: Add symbols for kprobe insn pages
  kprobes: Add perf ksymbol events for kprobe insn pages
  perf/x86: Add perf text poke events for kprobes
  ftrace: Add symbols for ftrace trampolines
  ftrace: Add perf ksymbol events for ftrace trampolines
  ftrace: Add perf text poke events for ftrace trampolines
  perf kcore_copy: Fix module map when there are no modules loaded
  perf evlist: Disable 'immediate' events last

	New patches

  perf tools: Add support for PERF_RECORD_TEXT_POKE

	The text poke event now has old len and new len
	Also select ksymbol events with text poke events

  perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL

	New patch

  perf intel-pt: Add support for text poke events

	The text poke event now has old len and new len
	Allow for the address not having a map yet


Changes since RFC:

  Dropped 'flags' from the new event.  The consensus seemed to be that text
  pokes should employ a scheme similar to x86's INT3 method instead.

  dropped tools patches already applied.


Example:

  For jump labels, the kernel needs
	CONFIG_JUMP_LABEL=y
  and also an easy to flip jump label is in sysctl_schedstats() which needs
	CONFIG_SCHEDSTATS=y
	CONFIG_PROC_SYSCTL=y
	CONFIG_SCHED_DEBUG=y

  Also note the 'sudo perf record' is put into the background which, as
  written, needs sudo credential caching (otherwise the background task
  will stop awaiting the sudo password), hence the 'sudo echo' to start.

Before:

  $ sudo echo
  $ sudo perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
  [1] 1640
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1640
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 16.635 MB perf.data.before ]
  $ perf script -i perf.data.before --itrace=e >/dev/null
  Warning:
  1946 instruction trace errors

After:

  $ sudo echo
  $ sudo perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
  [1] 1882
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1882
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 10.893 MB perf.data.after ]
  $ perf script -i perf.data.after --itrace=e
  $


Adrian Hunter (15):
      perf: Add perf text poke event
      perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
      kprobes: Add symbols for kprobe insn pages
      kprobes: Add perf ksymbol events for kprobe insn pages
      perf/x86: Add perf text poke events for kprobes
      ftrace: Add symbols for ftrace trampolines
      ftrace: Add perf ksymbol events for ftrace trampolines
      ftrace: Add perf text poke events for ftrace trampolines
      perf kcore_copy: Fix module map when there are no modules loaded
      perf evlist: Disable 'immediate' events last
      perf tools: Add support for PERF_RECORD_TEXT_POKE
      perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
      perf intel-pt: Add support for text poke events
      perf script: Add option --show-text-poke-events
      perf script: Show text poke address symbol

 arch/x86/include/asm/kprobes.h            |   2 +
 arch/x86/kernel/alternative.c             |  37 ++++++++++-
 arch/x86/kernel/kprobes/core.c            |  15 ++++-
 arch/x86/kernel/kprobes/opt.c             |  38 +++++++++--
 include/linux/ftrace.h                    |  12 ++--
 include/linux/kprobes.h                   |  15 +++++
 include/linux/perf_event.h                |   8 +++
 include/uapi/linux/perf_event.h           |  26 +++++++-
 kernel/events/core.c                      |  90 +++++++++++++++++++++++++-
 kernel/kallsyms.c                         |  42 +++++++++++--
 kernel/kprobes.c                          |  57 +++++++++++++++++
 kernel/trace/ftrace.c                     | 101 +++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     |  26 +++++++-
 tools/lib/perf/include/perf/event.h       |   9 +++
 tools/perf/Documentation/perf-script.txt  |   4 ++
 tools/perf/arch/x86/util/intel-pt.c       |   4 ++
 tools/perf/builtin-record.c               |  45 +++++++++++++
 tools/perf/builtin-script.c               |  23 ++++++-
 tools/perf/tests/perf-record.c            |   4 +-
 tools/perf/util/dso.c                     |   3 +
 tools/perf/util/dso.h                     |   1 +
 tools/perf/util/event.c                   |  62 +++++++++++++++++-
 tools/perf/util/event.h                   |   9 ++-
 tools/perf/util/evlist.c                  |  31 ++++++---
 tools/perf/util/evsel.c                   |   7 ++-
 tools/perf/util/intel-pt.c                |  77 ++++++++++++++++++++++-
 tools/perf/util/machine.c                 |  49 +++++++++++++++
 tools/perf/util/machine.h                 |   3 +
 tools/perf/util/map.c                     |   5 ++
 tools/perf/util/map.h                     |   3 +-
 tools/perf/util/perf_api_probe.c          |  10 +++
 tools/perf/util/perf_api_probe.h          |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   1 +
 tools/perf/util/record.h                  |   1 +
 tools/perf/util/session.c                 |  23 +++++++
 tools/perf/util/symbol-elf.c              |   7 +++
 tools/perf/util/symbol.c                  |   1 +
 tools/perf/util/tool.h                    |   3 +-
 38 files changed, 815 insertions(+), 40 deletions(-)


Regards
Adrian
