Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96264C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9D2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOFPVQdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392460AbgFSPQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392026AbgFSPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75AC061794
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:15:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r9so8761934wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeFy9wL2Na9dIEGGYMCL8c8bGY8Gy3Nu7ahNCzjtECA=;
        b=aOFPVQdoMro4skSpksjBTH4t+98ZY+spcPEOiieM1NH/tnUqkVtfKNcN6Z14vp9ju5
         E67yUxSizCWZ4lUBa0RenDThusaP7YDp/Tx82kHdpDWvfoheQo0dCQRzpvCuU6QL6Gny
         ctrxF6wNrAs3+J30UnS7GMwpkQngkcU6bQly2bqn5zZSXn3b+SNz0H7c3DOmsFejzrrL
         tXlDFSL10Y0qPAUw0n5WcZfKVJ3GompRTZbt7xvSL+i2Topt1IHIqeWCFM+LfS15mYVG
         mAe9FZS9PZn1D1LBApsQwF9ARsMZnRCtSYajnhQypAu6E81l5oKN5d+ZiIktVgUIPkWj
         T6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeFy9wL2Na9dIEGGYMCL8c8bGY8Gy3Nu7ahNCzjtECA=;
        b=VH3u0s2v7ZmfshLMgC3I/ToBS89vuehqJqwPuguYEt+Bu35BsH5GSdrDjY9VsXW3/z
         ozGowr9bWoeiOKMwlcEEPFpt2Iqgs2JVEVmLuCZD/ABGy7idFvPR+167lbiijvNGgjWA
         YP4XFnM+vop5bSIEhvn1wHIIdFeUhywVmW9oquOh3kiD5CiU32Puvv6bwLo9k1FJORhR
         PvkW9LE5e9+qumMGRD6CG7IHcO3KOrTiLBn+yufJPDIsnyXBh3/YMHI7JCKdOmkAxnX9
         y+T1YKviMUZ5HfvC1NuYPZg2cW6SVYuHmMmy07QqxJsdentxJFh7rilYNVpq9z9m1etJ
         ZxFQ==
X-Gm-Message-State: AOAM532MfGg6yrQhNfZRiIBTsoYamrLrQ766fth4qi5F91pN9AbWHQR1
        whR21oRJmOf42hedBBDrEpglSAGpmU/VdN1haCATgg==
X-Google-Smtp-Source: ABdhPJxMvIZHL8PmdzS0CIhA1M0D49se4Kk9bDB8WzjCsQGQsoRYSFww/ABR7CVPLeBuzfGER1sPb6CVbvYtnSIWYYM=
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr4122864wmg.76.1592579745373;
 Fri, 19 Jun 2020 08:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com> <20200619121557.GC12579@kernel.org>
 <20200619122051.GD12579@kernel.org>
In-Reply-To: <20200619122051.GD12579@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 19 Jun 2020 08:15:33 -0700
Message-ID: <CAP-5=fUrWOTangQFD6fATZQQUXLhwkt3U=_PuVL0GozhnmrVmA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] perf parse-events: enable more flex/bison warnings
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 5:20 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 19, 2020 at 09:15:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jun 18, 2020 at 09:33:46PM -0700, Ian Rogers escreveu:
> > > All C compiler warnings are disabled are disabled by -w. This change
> > > removes the -w from flex and bison targets. To avoid implicit
> > > declarations header files are declared as targets and included.
> > >
> > > Tested with GCC 9.3.0 and clang 9.0.1.
> > >
> > > v2. predicates disabling the warnings on more recent bison and flex
> > >     versions (3.5.3 and 2.6.4 respectively). An alternative would be
> > >     to disabled a large number of warnings to cover the warnings
> > >     generated in older distributions:
> > >   flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function \
> > >     -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter \
> > >     -Wno-missing-prototypes -Wno-misleading-indentation
> > >   bison_flags := -DYYENABLE_NLS=0 -Wno-unused-parameter -Wno-nested-externs \
> > >     -Wno-implicit-function-declaration -Wno-switch-enum
> >
> > So, it is failing with older versions of alpine Linux, but then at
> > alpine 3.8 I noticed that the problem is happening only when building
> > with this following set of options, and when building with gcc, building
> > with clang, i.e. adding CC=clang to the following make command line
> > works.
>
> I'll also check if this isn't because these container tests do multiple
> make calls, with different sets of options (NO_LIBBPF=1, another with
> NO_LIBELF=1, the one with LIBCLANGLLVM=1, etc) and perhaps the stuff
> from previous builds pollute a subsequent build, i.e. will try adding a
> rm -rf to the O= directory if missing.

Thanks! I don't have a good explanation as to why this would fail.
Sorry about the Acked-by. Let me know if I should do anything more.

Ian

> > + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' 'LIBCLANGLLVM=1' -C /git/linux/tools/perf 'O=/tmp/build/perf'
> > make: Entering directory '/git/linux/tools/perf'
> >   BUILD:   Doing 'make -j8' parallel build
> >   HOSTCC   /tmp/build/perf/fixdep.o
> >   HOSTLD   /tmp/build/perf/fixdep-in.o
> >   LINK     /tmp/build/perf/fixdep
> >
> > Auto-detecting system features:
> > ...                         dwarf: [ OFF ]
> > ...            dwarf_getlocations: [ OFF ]
> > ...                         glibc: [ OFF ]
> > ...                          gtk2: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                        libcap: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ OFF ]
> > ...        numa_num_possible_cpus: [ OFF ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ OFF ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ on  ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...                       libzstd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> >
> > Makefile.config:409: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
> > Makefile.config:414: No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev
> > Makefile.config:485: gelf_getnote() not found on libelf, SDT support disabled
> > Makefile.config:528: DWARF support is off, BPF prologue is disabled
> > Makefile.config:536: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
> > Makefile.config:890: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
> > Makefile.config:945: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > Makefile.config:971: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
> > Makefile.config:1008: No suitable libclang found, disabling builtin clang and LLVM support. Please install libclang-dev(el) (>= 3.9.0)
> >   GEN      /tmp/build/perf/common-cmds.h
> > sort: unrecognized option: V
> > BusyBox v1.28.4 (2018-12-31 18:05:13 UTC) multi-call binary.
> >   PERF_VERSION = 5.7.g6f01af8176af
> >
> > Usage: sort [-nrugMcszbdfiokt] [-o FILE] [-k start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...
> >
> > Sort lines of text
> >
> >       -o FILE Output to FILE
> >       -c      Check whether input is sorted
> >       -b      Ignore leading blanks
> >       -f      Ignore case
> >       -i      Ignore unprintable characters
> >       -d      Dictionary order (blank or alphanumeric only)
> >       -g      General numerical sort
> >       -M      Sort month
> >       -n      Sort numbers
> >       -t CHAR Field separator
> >       -k N[,M] Sort by Nth field
> >       -r      Reverse sort order
> >       -s      Stable (don't sort ties alphabetically)
> >       -u      Suppress duplicate lines
> >       -z      Lines are terminated by NUL, not newline
> >   CC       /tmp/build/perf/exec-cmd.o
> >   CC       /tmp/build/perf/event-parse.o
> >   MKDIR    /tmp/build/perf/fd/
> >   CC       /tmp/build/perf/fd/array.o
> >   GEN      /tmp/build/perf/bpf_helper_defs.h
> >   CC       /tmp/build/perf/event-plugin.o
> >   CC       /tmp/build/perf/core.o
> >   LD       /tmp/build/perf/fd/libapi-in.o
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/fs/fs.o
> >   CC       /tmp/build/perf/cpumap.o
> >   CC       /tmp/build/perf/trace-seq.o
> >   CC       /tmp/build/perf/threadmap.o
> >   CC       /tmp/build/perf/help.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   CC       /tmp/build/perf/staticobjs/libbpf.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   CC       /tmp/build/perf/staticobjs/bpf.o
> >   CC       /tmp/build/perf/cpu.o
> >   CC       /tmp/build/perf/parse-filter.o
> >   CC       /tmp/build/perf/evsel.o
> >   CC       /tmp/build/perf/evlist.o
> >   CC       /tmp/build/perf/pager.o
> >   CC       /tmp/build/perf/parse-options.o
> >   CC       /tmp/build/perf/parse-utils.o
> >   CC       /tmp/build/perf/mmap.o
> >   CC       /tmp/build/perf/kbuffer-parse.o
> >   CC       /tmp/build/perf/zalloc.o
> >   CC       /tmp/build/perf/tep_strerror.o
> >   CC       /tmp/build/perf/xyarray.o
> >   CC       /tmp/build/perf/event-parse-api.o
> >   CC       /tmp/build/perf/run-command.o
> >   CC       /tmp/build/perf/sigchain.o
> >   LD       /tmp/build/perf/libtraceevent-in.o
> >   LINK     /tmp/build/perf/libtraceevent.a
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/fs/tracing_path.o
> >   CC       /tmp/build/perf/debug.o
> >   CC       /tmp/build/perf/str_error_r.o
> >   CC       /tmp/build/perf/fs/cgroup.o
> >   CC       /tmp/build/perf/subcmd-config.o
> >   CC       /tmp/build/perf/lib.o
> >   CC       /tmp/build/perf/staticobjs/nlattr.o
> >   CC       /tmp/build/perf/staticobjs/btf.o
> >   CC       /tmp/build/perf/staticobjs/libbpf_errno.o
> >   LD       /tmp/build/perf/fs/libapi-in.o
> >   CC       /tmp/build/perf/staticobjs/str_error.o
> >   CC       /tmp/build/perf/staticobjs/netlink.o
> >   LD       /tmp/build/perf/libapi-in.o
> >   AR       /tmp/build/perf/libapi.a
> >   CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
> >   LD       /tmp/build/perf/libperf-in.o
> >   AR       /tmp/build/perf/libperf.a
> >   CC       /tmp/build/perf/staticobjs/libbpf_probes.o
> >   CC       /tmp/build/perf/staticobjs/xsk.o
> >   LD       /tmp/build/perf/libsubcmd-in.o
> >   CC       /tmp/build/perf/staticobjs/hashmap.o
> >   AR       /tmp/build/perf/libsubcmd.a
> >   CC       /tmp/build/perf/staticobjs/btf_dump.o
> >   CC       /tmp/build/perf/staticobjs/ringbuf.o
> >   MKDIR    /tmp/build/perf/pmu-events/
> >   GEN      perf-archive
> >   HOSTCC   /tmp/build/perf/pmu-events/json.o
> >   GEN      perf-with-kcore
> >   MKDIR    /tmp/build/perf/ui/gtk/
> >   MKDIR    /tmp/build/perf/pmu-events/
> >   CC       /tmp/build/perf/ui/gtk/browser.o
> >   HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
> >   HOSTCC   /tmp/build/perf/pmu-events/jevents.o
> >   CC       /tmp/build/perf/plugin_jbd2.o
> >   CC       /tmp/build/perf/plugin_hrtimer.o
> >   CC       /tmp/build/perf/plugin_kmem.o
> >   CC       /tmp/build/perf/plugin_kvm.o
> >   LD       /tmp/build/perf/plugin_hrtimer-in.o
> >   LD       /tmp/build/perf/plugin_jbd2-in.o
> >   LD       /tmp/build/perf/plugin_kmem-in.o
> >   CC       /tmp/build/perf/plugin_mac80211.o
> >   CC       /tmp/build/perf/plugin_sched_switch.o
> >   CC       /tmp/build/perf/plugin_function.o
> >   LD       /tmp/build/perf/plugin_kvm-in.o
> >   LD       /tmp/build/perf/plugin_mac80211-in.o
> >   MKDIR    /tmp/build/perf/ui/gtk/
> >   CC       /tmp/build/perf/plugin_xen.o
> >   CC       /tmp/build/perf/ui/gtk/hists.o
> >   LD       /tmp/build/perf/plugin_sched_switch-in.o
> >   LD       /tmp/build/perf/staticobjs/libbpf-in.o
> >   LD       /tmp/build/perf/plugin_xen-in.o
> >   LINK     /tmp/build/perf/libbpf.a
> >   CC       /tmp/build/perf/plugin_scsi.o
> >   LD       /tmp/build/perf/plugin_function-in.o
> >   CC       /tmp/build/perf/plugin_cfg80211.o
> >   HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
> >   CC       /tmp/build/perf/ui/gtk/setup.o
> >   LINK     /tmp/build/perf/plugin_jbd2.so
> >   LINK     /tmp/build/perf/pmu-events/jevents
> >   GEN      /tmp/build/perf/pmu-events/pmu-events.c
> >   LINK     /tmp/build/perf/plugin_hrtimer.so
> >   LD       /tmp/build/perf/plugin_cfg80211-in.o
> >   LD       /tmp/build/perf/plugin_scsi-in.o
> >   LINK     /tmp/build/perf/plugin_kmem.so
> >   LINK     /tmp/build/perf/plugin_kvm.so
> >   CC       /tmp/build/perf/ui/gtk/util.o
> >   LINK     /tmp/build/perf/plugin_mac80211.so
> >   LINK     /tmp/build/perf/plugin_sched_switch.so
> >   LINK     /tmp/build/perf/plugin_function.so
> >   LINK     /tmp/build/perf/plugin_xen.so
> >   LINK     /tmp/build/perf/plugin_scsi.so
> >   LINK     /tmp/build/perf/plugin_cfg80211.so
> >   CC       /tmp/build/perf/ui/gtk/helpline.o
> >   GEN      /tmp/build/perf/libtraceevent-dynamic-list
> >   GEN      /tmp/build/perf/python/perf.so
> >   CC       /tmp/build/perf/ui/gtk/progress.o
> >   CC       /tmp/build/perf/pmu-events/pmu-events.o
> >   CC       /tmp/build/perf/ui/gtk/annotate.o
> >   CC       /tmp/build/perf/builtin-bench.o
> >   CC       /tmp/build/perf/ui/gtk/zalloc.o
> >   CC       /tmp/build/perf/builtin-annotate.o
> >   CC       /tmp/build/perf/builtin-config.o
> >   CC       /tmp/build/perf/builtin-diff.o
> >   CC       /tmp/build/perf/builtin-evlist.o
> >   CC       /tmp/build/perf/builtin-ftrace.o
> >   CC       /tmp/build/perf/builtin-help.o
> >   CC       /tmp/build/perf/builtin-sched.o
> >   CC       /tmp/build/perf/builtin-buildid-list.o
> >   LD       /tmp/build/perf/pmu-events/pmu-events-in.o
> >   LD       /tmp/build/perf/ui/gtk/gtk-in.o
> >   CC       /tmp/build/perf/builtin-buildid-cache.o
> >   CC       /tmp/build/perf/builtin-kallsyms.o
> >   CC       /tmp/build/perf/builtin-list.o
> >   CC       /tmp/build/perf/builtin-record.o
> >   CC       /tmp/build/perf/builtin-report.o
> >   LD       /tmp/build/perf/gtk-in.o
> >   LINK     /tmp/build/perf/libperf-gtk.so
> >   CC       /tmp/build/perf/builtin-stat.o
> >   CC       /tmp/build/perf/builtin-timechart.o
> >   CC       /tmp/build/perf/builtin-top.o
> >   CC       /tmp/build/perf/builtin-script.o
> >   CC       /tmp/build/perf/builtin-kmem.o
> >   CC       /tmp/build/perf/builtin-lock.o
> >   CC       /tmp/build/perf/builtin-kvm.o
> >   CC       /tmp/build/perf/builtin-inject.o
> >   CC       /tmp/build/perf/builtin-mem.o
> >   CC       /tmp/build/perf/builtin-data.o
> >   CC       /tmp/build/perf/builtin-version.o
> >   CC       /tmp/build/perf/builtin-c2c.o
> >   CC       /tmp/build/perf/builtin-trace.o
> >   CC       /tmp/build/perf/builtin-probe.o
> >   MKDIR    /tmp/build/perf/bench/
> >   CC       /tmp/build/perf/bench/sched-messaging.o
> >   MKDIR    /tmp/build/perf/tests/
> >   CC       /tmp/build/perf/tests/builtin-test.o
> >   MKDIR    /tmp/build/perf/bench/
> >   CC       /tmp/build/perf/bench/sched-pipe.o
> >   MKDIR    /tmp/build/perf/util/
> >   CC       /tmp/build/perf/util/annotate.o
> >   CC       /tmp/build/perf/bench/mem-functions.o
> >   CC       /tmp/build/perf/arch/common.o
> >   MKDIR    /tmp/build/perf/tests/
> >   MKDIR    /tmp/build/perf/arch/x86/util/
> >   CC       /tmp/build/perf/arch/x86/util/header.o
> >   CC       /tmp/build/perf/bench/futex-hash.o
> >   CC       /tmp/build/perf/tests/parse-events.o
> >   CC       /tmp/build/perf/bench/futex-wake.o
> >   MKDIR    /tmp/build/perf/arch/x86/util/
> >   CC       /tmp/build/perf/arch/x86/util/tsc.o
> >   CC       /tmp/build/perf/arch/x86/util/pmu.o
> >   CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
> >   CC       /tmp/build/perf/bench/futex-wake-parallel.o
> >   CC       /tmp/build/perf/arch/x86/util/perf_regs.o
> >   CC       /tmp/build/perf/bench/futex-requeue.o
> >   CC       /tmp/build/perf/bench/futex-lock-pi.o
> >   CC       /tmp/build/perf/arch/x86/util/group.o
> >   CC       /tmp/build/perf/arch/x86/util/machine.o
> >   CC       /tmp/build/perf/arch/x86/util/event.o
> >   CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
> >   CC       /tmp/build/perf/arch/x86/util/auxtrace.o
> >   CC       /tmp/build/perf/bench/epoll-wait.o
> >   MKDIR    /tmp/build/perf/arch/x86/tests/
> >   CC       /tmp/build/perf/arch/x86/tests/regs_load.o
> >   MKDIR    /tmp/build/perf/util/
> >   CC       /tmp/build/perf/util/block-info.o
> >   MKDIR    /tmp/build/perf/arch/x86/tests/
> >   CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
> >   CC       /tmp/build/perf/arch/x86/util/archinsn.o
> >   CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
> >   CC       /tmp/build/perf/bench/epoll-ctl.o
> >   CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
> >   CC       /tmp/build/perf/tests/dso-data.o
> >   CC       /tmp/build/perf/arch/x86/util/intel-pt.o
> >   CC       /tmp/build/perf/arch/x86/tests/perf-time-to-tsc.o
> >   CC       /tmp/build/perf/bench/synthesize.o
> >   CC       /tmp/build/perf/util/block-range.o
> >   CC       /tmp/build/perf/bench/kallsyms-parse.o
> >   CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
> >   CC       /tmp/build/perf/util/build-id.o
> >   CC       /tmp/build/perf/util/cacheline.o
> >   CC       /tmp/build/perf/bench/mem-memcpy-x86-64-lib.o
> >   CC       /tmp/build/perf/tests/attr.o
> >   CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
> >   CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
> >   CC       /tmp/build/perf/util/config.o
> >   CC       /tmp/build/perf/arch/x86/util/intel-bts.o
> >   LD       /tmp/build/perf/bench/perf-in.o
> >   CC       /tmp/build/perf/arch/x86/tests/intel-pt-pkt-decoder-test.o
> >   CC       /tmp/build/perf/ui/setup.o
> >   CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
> >   CC       /tmp/build/perf/arch/x86/tests/bp-modify.o
> >   CC       /tmp/build/perf/ui/helpline.o
> >   LD       /tmp/build/perf/arch/x86/util/perf-in.o
> >   CC       /tmp/build/perf/ui/progress.o
> >   CC       /tmp/build/perf/tests/openat-syscall.o
> >   LD       /tmp/build/perf/arch/x86/tests/perf-in.o
> >   CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
> >   LD       /tmp/build/perf/arch/x86/perf-in.o
> >   LD       /tmp/build/perf/arch/perf-in.o
> >   CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
> >   CC       /tmp/build/perf/ui/util.o
> >   CC       /tmp/build/perf/ui/hist.o
> >   CC       /tmp/build/perf/util/copyfile.o
> >   CC       /tmp/build/perf/tests/mmap-basic.o
> >   MKDIR    /tmp/build/perf/ui/stdio/
> >   CC       /tmp/build/perf/ui/stdio/hist.o
> >   CC       /tmp/build/perf/tests/perf-record.o
> >   CC       /tmp/build/perf/util/ctype.o
> >   CC       /tmp/build/perf/util/db-export.o
> >   CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
> >   CC       /tmp/build/perf/tests/evsel-tp-sched.o
> >   MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
> >   CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
> >   CC       /tmp/build/perf/tests/fdarray.o
> >   CC       /tmp/build/perf/tests/pmu.o
> >   CC       /tmp/build/perf/tests/pmu-events.o
> >   CC       /tmp/build/perf/tests/hists_common.o
> >   CC       /tmp/build/perf/tests/hists_link.o
> >   LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
> >   MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
> >   CC       /tmp/build/perf/ui/browser.o
> >   CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
> >   CC       /tmp/build/perf/tests/hists_filter.o
> >   CC       /tmp/build/perf/util/env.o
> >   CC       /tmp/build/perf/tests/hists_output.o
> >   CC       /tmp/build/perf/tests/hists_cumulate.o
> >   LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
> >   LD       /tmp/build/perf/scripts/perf-in.o
> >   CC       /tmp/build/perf/trace/beauty/clone.o
> >   CC       /tmp/build/perf/perf.o
> >   CC       /tmp/build/perf/trace/beauty/fcntl.o
> >   MKDIR    /tmp/build/perf/ui/browsers/
> >   CC       /tmp/build/perf/ui/browsers/annotate.o
> >   CC       /tmp/build/perf/util/event.o
> >   CC       /tmp/build/perf/tests/python-use.o
> >   CC       /tmp/build/perf/trace/beauty/flock.o
> >   CC       /tmp/build/perf/trace/beauty/fsmount.o
> >   CC       /tmp/build/perf/trace/beauty/fspick.o
> >   CC       /tmp/build/perf/trace/beauty/ioctl.o
> >   CC       /tmp/build/perf/trace/beauty/kcmp.o
> >   CC       /tmp/build/perf/tests/bp_signal.o
> >   CC       /tmp/build/perf/tests/bp_signal_overflow.o
> >   CC       /tmp/build/perf/trace/beauty/mount_flags.o
> >   CC       /tmp/build/perf/trace/beauty/move_mount.o
> >   CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
> >   CC       /tmp/build/perf/trace/beauty/arch_prctl.o
> >   CC       /tmp/build/perf/trace/beauty/prctl.o
> >   CC       /tmp/build/perf/tests/bp_account.o
> >   CC       /tmp/build/perf/trace/beauty/renameat.o
> >   CC       /tmp/build/perf/tests/wp.o
> >   CC       /tmp/build/perf/tests/task-exit.o
> >   CC       /tmp/build/perf/util/evlist.o
> >   CC       /tmp/build/perf/trace/beauty/sockaddr.o
> >   CC       /tmp/build/perf/trace/beauty/socket.o
> >   CC       /tmp/build/perf/trace/beauty/statx.o
> >   CC       /tmp/build/perf/trace/beauty/sync_file_range.o
> >   CC       /tmp/build/perf/util/sideband_evlist.o
> >   MKDIR    /tmp/build/perf/ui/browsers/
> >   CC       /tmp/build/perf/ui/browsers/hists.o
> >   CC       /tmp/build/perf/ui/browsers/map.o
> >   MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
> >   CC       /tmp/build/perf/trace/beauty/tracepoints/x86_irq_vectors.o
> >   MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
> >   CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
> >   CC       /tmp/build/perf/util/evsel.o
> >   LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
> >   LD       /tmp/build/perf/trace/beauty/perf-in.o
> >   CC       /tmp/build/perf/tests/sw-clock.o
> >   CC       /tmp/build/perf/util/evsel_fprintf.o
> >   CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
> >   CC       /tmp/build/perf/tests/mmap-thread-lookup.o
> >   CC       /tmp/build/perf/util/evswitch.o
> >   CC       /tmp/build/perf/tests/thread-maps-share.o
> >   CC       /tmp/build/perf/tests/switch-tracking.o
> >   CC       /tmp/build/perf/util/find_bit.o
> >   CC       /tmp/build/perf/util/get_current_dir_name.o
> >   CC       /tmp/build/perf/util/kallsyms.o
> >   MKDIR    /tmp/build/perf/ui/tui/
> >   CC       /tmp/build/perf/tests/keep-tracking.o
> >   CC       /tmp/build/perf/ui/tui/setup.o
> >   CC       /tmp/build/perf/util/levenshtein.o
> >   CC       /tmp/build/perf/util/llvm-utils.o
> >   CC       /tmp/build/perf/util/mmap.o
> >   CC       /tmp/build/perf/util/memswap.o
> >   MKDIR    /tmp/build/perf/ui/tui/
> >   CC       /tmp/build/perf/ui/tui/util.o
> >   CC       /tmp/build/perf/tests/code-reading.o
> >   CC       /tmp/build/perf/tests/sample-parsing.o
> >   CC       /tmp/build/perf/ui/tui/helpline.o
> >   CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
> >   CC       /tmp/build/perf/ui/tui/progress.o
> >   CC       /tmp/build/perf/tests/kmod-path.o
> >   CC       /tmp/build/perf/tests/thread-map.o
> >   LD       /tmp/build/perf/ui/tui/perf-in.o
> >   CC       /tmp/build/perf/tests/llvm.o
> >   CC       /tmp/build/perf/tests/bpf.o
> >   CC       /tmp/build/perf/tests/topology.o
> >   CC       /tmp/build/perf/tests/mem.o
> >   CC       /tmp/build/perf/tests/cpumap.o
> >   CC       /tmp/build/perf/tests/stat.o
> >   CC       /tmp/build/perf/tests/event_update.o
> >   CC       /tmp/build/perf/ui/browsers/scripts.o
> >   CC       /tmp/build/perf/ui/browsers/header.o
> >   CC       /tmp/build/perf/tests/event-times.o
> >   CC       /tmp/build/perf/ui/browsers/res_sample.o
> >   CC       /tmp/build/perf/tests/expr.o
> >   CC       /tmp/build/perf/tests/backward-ring-buffer.o
> >   CC       /tmp/build/perf/tests/sdt.o
> >   CC       /tmp/build/perf/tests/is_printable_array.o
> >   CC       /tmp/build/perf/tests/bitmap.o
> >   BISON    /tmp/build/perf/util/parse-events-bison.c
> >   CC       /tmp/build/perf/tests/perf-hooks.o
> >   CC       /tmp/build/perf/tests/clang.o
> >   CC       /tmp/build/perf/util/perf_regs.o
> >   CC       /tmp/build/perf/tests/unit_number__scnprintf.o
> >   CC       /tmp/build/perf/tests/mem2node.o
> >   CC       /tmp/build/perf/tests/maps.o
> >   CC       /tmp/build/perf/tests/time-utils-test.o
> >   CC       /tmp/build/perf/tests/genelf.o
> >   CC       /tmp/build/perf/tests/api-io.o
> >   CC       /tmp/build/perf/tests/demangle-java-test.o
> >   CC       /tmp/build/perf/util/path.o
> >   CC       /tmp/build/perf/util/print_binary.o
> >   CC       /tmp/build/perf/tests/pfm.o
> >   CC       /tmp/build/perf/tests/parse-metric.o
> >   CC       /tmp/build/perf/util/rlimit.o
> >   CC       /tmp/build/perf/tests/dwarf-unwind.o
> >   CC       /tmp/build/perf/util/argv_split.o
> >   CC       /tmp/build/perf/util/rbtree.o
> >   CC       /tmp/build/perf/util/libstring.o
> >   CC       /tmp/build/perf/util/bitmap.o
> >   CC       /tmp/build/perf/tests/llvm-src-base.o
> >   CC       /tmp/build/perf/tests/llvm-src-kbuild.o
> >   CC       /tmp/build/perf/tests/llvm-src-prologue.o
> >   CC       /tmp/build/perf/tests/llvm-src-relocation.o
> >   CC       /tmp/build/perf/util/hweight.o
> >   CC       /tmp/build/perf/util/smt.o
> >   CC       /tmp/build/perf/util/strbuf.o
> >   CC       /tmp/build/perf/util/string.o
> >   LD       /tmp/build/perf/tests/perf-in.o
> >   CC       /tmp/build/perf/util/strlist.o
> >   CC       /tmp/build/perf/util/strfilter.o
> >   CC       /tmp/build/perf/util/top.o
> >   CC       /tmp/build/perf/util/usage.o
> >   CC       /tmp/build/perf/util/dso.o
> >   CC       /tmp/build/perf/util/dsos.o
> >   CC       /tmp/build/perf/util/symbol.o
> >   CC       /tmp/build/perf/util/symbol_fprintf.o
> >   CC       /tmp/build/perf/util/color.o
> >   CC       /tmp/build/perf/util/color_config.o
> >   CC       /tmp/build/perf/util/metricgroup.o
> >   CC       /tmp/build/perf/util/header.o
> >   LD       /tmp/build/perf/ui/browsers/perf-in.o
> >   CC       /tmp/build/perf/util/callchain.o
> >   LD       /tmp/build/perf/ui/perf-in.o
> >   CC       /tmp/build/perf/util/values.o
> >   CC       /tmp/build/perf/util/debug.o
> >   CC       /tmp/build/perf/util/fncache.o
> >   CC       /tmp/build/perf/util/machine.o
> >   CC       /tmp/build/perf/util/map.o
> >   CC       /tmp/build/perf/util/pstack.o
> >   CC       /tmp/build/perf/util/session.o
> >   CC       /tmp/build/perf/util/sample-raw.o
> >   CC       /tmp/build/perf/util/s390-sample-raw.o
> >   CC       /tmp/build/perf/util/syscalltbl.o
> >   CC       /tmp/build/perf/util/ordered-events.o
> >   CC       /tmp/build/perf/util/namespaces.o
> >   CC       /tmp/build/perf/util/comm.o
> >   CC       /tmp/build/perf/util/thread.o
> >   CC       /tmp/build/perf/util/thread_map.o
> >   CC       /tmp/build/perf/util/trace-event-parse.o
> >   FLEX     /tmp/build/perf/util/parse-events-flex.h
> >   BISON    /tmp/build/perf/util/pmu-bison.c
> >   CC       /tmp/build/perf/util/trace-event-read.o
> >   CC       /tmp/build/perf/util/trace-event-info.o
> >   CC       /tmp/build/perf/util/trace-event-scripting.o
> >   CC       /tmp/build/perf/util/trace-event.o
> >   CC       /tmp/build/perf/util/svghelper.o
> >   CC       /tmp/build/perf/util/sort.o
> >   CC       /tmp/build/perf/util/hist.o
> >   CC       /tmp/build/perf/util/util.o
> >   CC       /tmp/build/perf/util/cpumap.o
> >   CC       /tmp/build/perf/util/affinity.o
> >   CC       /tmp/build/perf/util/cputopo.o
> >   CC       /tmp/build/perf/util/cgroup.o
> >   CC       /tmp/build/perf/util/target.o
> >   CC       /tmp/build/perf/util/rblist.o
> >   CC       /tmp/build/perf/util/intlist.o
> >   CC       /tmp/build/perf/util/vdso.o
> >   CC       /tmp/build/perf/util/counts.o
> >   CC       /tmp/build/perf/util/stat.o
> >   CC       /tmp/build/perf/util/stat-shadow.o
> >   CC       /tmp/build/perf/util/stat-display.o
> >   CC       /tmp/build/perf/util/perf_api_probe.o
> >   CC       /tmp/build/perf/util/record.o
> >   CC       /tmp/build/perf/util/srcline.o
> >   CC       /tmp/build/perf/util/srccode.o
> >   CC       /tmp/build/perf/util/synthetic-events.o
> >   CC       /tmp/build/perf/util/data.o
> >   CC       /tmp/build/perf/util/tsc.o
> >   CC       /tmp/build/perf/util/cloexec.o
> >   CC       /tmp/build/perf/util/call-path.o
> >   CC       /tmp/build/perf/util/rwsem.o
> >   CC       /tmp/build/perf/util/thread-stack.o
> >   CC       /tmp/build/perf/util/spark.o
> >   CC       /tmp/build/perf/util/auxtrace.o
> >   MKDIR    /tmp/build/perf/util/intel-pt-decoder/
> >   CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
> >   MKDIR    /tmp/build/perf/util/intel-pt-decoder/
> >   GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
> >   MKDIR    /tmp/build/perf/util/arm-spe-decoder/
> >   CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
> >   MKDIR    /tmp/build/perf/util/scripting-engines/
> >   CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
> >   CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
> >   CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
> >   MKDIR    /tmp/build/perf/util/arm-spe-decoder/
> >   MKDIR    /tmp/build/perf/util/scripting-engines/
> >   CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
> >   CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
> >   LD       /tmp/build/perf/util/arm-spe-decoder/perf-in.o
> >   CC       /tmp/build/perf/util/intel-pt.o
> >   CC       /tmp/build/perf/util/intel-bts.o
> >   CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
> >   CC       /tmp/build/perf/util/arm-spe.o
> >   CC       /tmp/build/perf/util/s390-cpumsf.o
> >   CC       /tmp/build/perf/util/parse-branch-options.o
> >   CC       /tmp/build/perf/util/dump-insn.o
> >   CC       /tmp/build/perf/util/parse-regs-options.o
> >   CC       /tmp/build/perf/util/term.o
> >   CC       /tmp/build/perf/util/help-unknown-cmd.o
> >   CC       /tmp/build/perf/util/mem-events.o
> >   CC       /tmp/build/perf/util/vsprintf.o
> >   CC       /tmp/build/perf/util/units.o
> >   CC       /tmp/build/perf/util/time-utils.o
> >   BISON    /tmp/build/perf/util/expr-bison.c
> >   CC       /tmp/build/perf/util/branch.o
> >   CC       /tmp/build/perf/util/mem2node.o
> >   CC       /tmp/build/perf/util/bpf-loader.o
> >   CC       /tmp/build/perf/util/bpf_map.o
> >   LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
> >   LD       /tmp/build/perf/util/scripting-engines/perf-in.o
> >   CC       /tmp/build/perf/util/symbol-elf.o
> >   CC       /tmp/build/perf/util/probe-file.o
> >   CC       /tmp/build/perf/util/probe-event.o
> >   CC       /tmp/build/perf/util/unwind-libunwind-local.o
> >   CC       /tmp/build/perf/util/unwind-libunwind.o
> >   CC       /tmp/build/perf/util/zlib.o
> >   CC       /tmp/build/perf/util/lzma.o
> >   CC       /tmp/build/perf/util/zstd.o
> >   CC       /tmp/build/perf/util/cap.o
> >   CC       /tmp/build/perf/util/demangle-java.o
> >   CC       /tmp/build/perf/util/demangle-rust.o
> >   CC       /tmp/build/perf/util/jitdump.o
> >   CC       /tmp/build/perf/util/genelf.o
> >   CC       /tmp/build/perf/util/perf-hooks.o
> >   CC       /tmp/build/perf/util/bpf-event.o
> >   FLEX     /tmp/build/perf/util/parse-events-flex.c
> >   CC       /tmp/build/perf/util/parse-events-bison.o
> >   FLEX     /tmp/build/perf/util/pmu-flex.c
> >   CC       /tmp/build/perf/util/pmu-bison.o
> >   FLEX     /tmp/build/perf/util/expr-flex.c
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:546:0: error: unterminated #else
> >  #ifndef YY_READ_BUF_SIZE
> >
> > /tmp/build/perf/util/parse-events-flex.h:545:0: error: unterminated #ifndef
> >  /* Amount of stuff to slurp up with each read. */
> >
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:1:0: error: unterminated #ifndef
> >  #ifndef parse_events_HEADER_H
> >
> > mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
> > make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/util/parse-events-bison.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> > make[2]: *** [Makefile.perf:625: /tmp/build/perf/perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:231: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory '/git/linux/tools/perf'
> >
> >
> >    1 alpine:3.4       : FAIL gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
> >    2 alpine:3.5       : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
> >
> >   CC       /tmp/build/perf/util/parse-events-bison.o
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:323:0: error: unterminated #ifndef
> >  #ifndef YY_DECL
> >  ^
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:1:0: error: unterminated #ifndef
> >  #ifndef parse_events_HEADER_H
> >  ^
> > mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
> > /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/parse-events-bison.o' failed
> > make[4]: *** [/tmp/build/perf/util/parse-events-bison.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >   LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
> > /git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
> >
> > Slightly different:
> >
> >      3 alpine:3.6     : FAIL gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
> >
> >   CC       /tmp/build/perf/util/perf-hooks.o
> >   FLEX     /tmp/build/perf/util/parse-events-flex.c
> >   CC       /tmp/build/perf/util/parse-events-bison.o
> >   FLEX     /tmp/build/perf/util/pmu-flex.c
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:1:0: error: unterminated #ifndef
> >  #ifndef parse_events_HEADER_H
> >
> > mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
> > make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/parse-events-bison.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >
> >
> >    4 alpine:3.7       : FAIL gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
> >
> >   CC       /tmp/build/perf/util/pmu-bison.o
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:546:0: error: unterminated #else
> >  #ifndef YY_READ_BUF_SIZE
> >
> > /tmp/build/perf/util/parse-events-flex.h:545:0: error: unterminated #ifndef
> >  /* Amount of stuff to slurp up with each read. */
> >
> > In file included from util/parse-events.y:20:0:
> > /tmp/build/perf/util/parse-events-flex.h:1:0: error: unterminated #ifndef
> >  #ifndef parse_events_HEADER_H
> >
> >   FLEX     /tmp/build/perf/util/expr-flex.c
> > mv: can't rename '/tmp/build/perf/util/.parse-events-bison.o.tmp': No such file or directory
> > make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/util/parse-events-bison.o] Error 1
> >
> >
>
> --
>
> - Arnaldo
