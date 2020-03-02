Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,FUZZY_XPILL,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F9B2468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583133804;
	bh=MkctqU41voyujlEKKIfYrZfsEjLueXSi9+0DDHSLkIQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1+fOEhgZ1XhNj+DGnmZzXkPo1U7fxnkxmZPMA4Kow/BK9GeTf0HtLDsn6ZtWbaTi9
	 6LPGnXzZsiDKxUK9+i6Fc811O0NLZ7pRa06nARN3cJLGUkX9owm06OYhGnSCVueHmt
	 4+4+vtjGQKRaN/wAMaIj/OxSC/4RmoiYl7hTJ5Vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCBHXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:23:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33296 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBHXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:23:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so11146884wrr.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=cTDDn/dtcVFWtj/8BgMdOmb5XEBV9G5Uw2VfFOz47Es=;
        b=hFqHW1BOnE+OUbJCYgiHVfYnpW8j6sD6CTEKbUx3+Kf7fVVktYthmpn9c0Fh8JrSYm
         nbNrRyB2cxzWu1CP5m4iCrWdJQVfbyZCcPZ+cOAy+IN54oN58TCeGXOnN9WBMoJY12Ur
         rMkTGfHYNqK7VpEVK8K+9CmBFAqHWBCcBf1zIyx1n30RZwslha03WqP1i/o7+ikS4gHb
         6WYEsU60I+XTMo3uKooBsUH+KzcCdGx9KUmMWmntOAGYJGmZyEHmlHSVWoB4ge9Kr1Bd
         OKAde6SsaJuTqVN/8IYQGCNzS3zG0fDwwdfObwZQHHTz0bwYNgA4OJ+ZccBdxFMnU9H4
         1niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=cTDDn/dtcVFWtj/8BgMdOmb5XEBV9G5Uw2VfFOz47Es=;
        b=cVVt4YcvJBGZWSRdH7gJCiv+QUgi1DIIAV+EZ12t5jLY8uxQWnaPVKa7Pg3O6C+fNZ
         BMgYxC9jodukJqFZe8LuG/no8AWAPwk88U8lbnAJvPzokXLAzgakJj+DgTLK6hrFoy/l
         lxSSODLlbEhauug8GaWB4xbcXLlcnE9FmaQ/r3o3/aV3XhEVq3i9qlW+ehE6T8Bt+tai
         m82Xvn6AHWtHTGGXmluv4wnmMekM5lIFHhtasMlPfmVau1x/R09CK7BpiyvJIRLxSiSv
         l/16uV3iKb/zLIdoLp/luOm3foqQcM0wjd4EnqcJeW0lPtlt2H9J+xfPAe92nxMcHMUn
         d2Bw==
X-Gm-Message-State: APjAAAV/m2K+ngEOb2jiUGZHplP3KPfKRkfreg3b9TzB6c/DYsftrU0V
        cTuzjh6bx4yoj4h8ktOdXsY=
X-Google-Smtp-Source: APXvYqyWDbU7rhdcFqtG5UuRXF5X7G6hpEn/slvfVGfStmfzEvNCgWwP9OAp9JRudRMM98bAQRpsqQ==
X-Received: by 2002:adf:fe0a:: with SMTP id n10mr21836462wrr.229.1583133797420;
        Sun, 01 Mar 2020 23:23:17 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z64sm4127365wmg.35.2020.03.01.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:23:16 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:23:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] perf fixes
Message-ID: <20200302072314.GA89045@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 7977fed974d60a72733243cf54d7955cd6dccd91 Merge tag 'perf-urgent-for-mingo-5.6-20200228' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

No kernel side changes, the rest is tooling fixes plus two tooling 
cleanups that were committed late in the merge window alongside the perf 
annotate fixes, delayed by Arnaldo's European trip.

 Thanks,

	Ingo

------------------>
Adrian Hunter (2):
      perf arm-spe: Fix endless record after being terminated
      perf auxtrace: Add auxtrace_record__read_finish()

Arnaldo Carvalho de Melo (4):
      perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events
      perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Update tools's copy of kvm.h headers

He Zhe (1):
      perf probe: Check return value of strlist__add() for -ENOMEM

Ravi Bangoria (12):
      perf annotate/tui: Re-render title bar after switching back from script browser
      perf annotate: Fix --show-total-period for tui/stdio2
      perf annotate: Fix --show-nr-samples for tui/stdio2
      perf config: Introduce perf_config_u8()
      perf annotate: Make perf config effective
      perf annotate: Prefer cmdline option over default config
      perf annotate: Fix perf config option description
      perf config: Document missing config options
      perf annotate: Remove privsize from symbol__annotate() args
      perf annotate: Simplify disasm_line allocation and freeing code
      perf annotate: Align struct annotate_args
      perf annotate: Fix segfault with source toggle

Thomas Richter (1):
      perf test: Fix test trace+probe_vfs_getname.sh on s390

Wei Li (3):
      perf intel-pt: Fix endless record after being terminated
      perf intel-bts: Fix endless record after being terminated
      perf cs-etm: Fix endless record after being terminated


 tools/arch/x86/include/asm/msr-index.h             |   2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
 tools/perf/Documentation/perf-config.txt           |  74 +++++++-
 tools/perf/arch/arm/util/cs-etm.c                  |  18 +-
 tools/perf/arch/arm64/util/arm-spe.c               |  17 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   2 +
 tools/perf/arch/x86/util/intel-bts.c               |  17 +-
 tools/perf/arch/x86/util/intel-pt.c                |  17 +-
 tools/perf/builtin-annotate.c                      |   4 +-
 tools/perf/builtin-probe.c                         |   6 +-
 tools/perf/builtin-report.c                        |   2 +-
 tools/perf/builtin-top.c                           |   4 +-
 tools/perf/include/bpf/pid_filter.h                |   2 +-
 tools/perf/include/bpf/stdio.h                     |   2 +-
 tools/perf/include/bpf/unistd.h                    |   2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   2 +-
 tools/perf/ui/browsers/annotate.c                  |  19 +-
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/util/annotate.c                         | 194 ++++++++-------------
 tools/perf/util/annotate.h                         |   9 +-
 tools/perf/util/auxtrace.c                         |  22 ++-
 tools/perf/util/auxtrace.h                         |   6 +
 tools/perf/util/config.c                           |  12 ++
 tools/perf/util/config.h                           |   1 +
 tools/perf/util/probe-file.c                       |  28 ++-
 25 files changed, 251 insertions(+), 214 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index ebe1685e92dd..d5e517d1c3dd 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -512,6 +512,8 @@
 #define MSR_K7_HWCR			0xc0010015
 #define MSR_K7_HWCR_SMMLOCK_BIT		0
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_HWCR_IRPERF_EN_BIT	30
+#define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 503d3f42da16..3f3f780c8c65 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -390,6 +390,7 @@ struct kvm_sync_regs {
 #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
 #define KVM_STATE_NESTED_EVMCS		0x00000004
+#define KVM_STATE_NESTED_MTF_PENDING	0x00000008
 
 #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
 #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c4dd23c4b478..8ead55593984 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -239,7 +239,6 @@ buildid.*::
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
 annotate.*::
-	These options work only for TUI.
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
@@ -269,6 +268,8 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 		│              return n;
 
+		This option works with tui, stdio2 browsers.
+
         annotate.use_offset::
 		Basing on a first address of a loaded function, offset can be used.
 		Instead of using original addresses of assembly code,
@@ -287,6 +288,8 @@ annotate.*::
 
 		             368:│  mov    0x8(%r14),%rdi
 
+		This option works with tui, stdio2 browsers.
+
 	annotate.jump_arrows::
 		There can be jump instruction among assembly code.
 		Depending on a boolean value of jump_arrows,
@@ -306,6 +309,8 @@ annotate.*::
 		│1330:   mov    %r15,%r10
 		│1333:   cmp    %r15,%r14
 
+		This option works with tui browser.
+
         annotate.show_linenr::
 		When showing source code if this option is 'true',
 		line numbers are printed as below.
@@ -325,6 +330,8 @@ annotate.*::
 		│                     array++;
 		│             }
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_nr_jumps::
 		Let's see a part of assembly code.
 
@@ -335,6 +342,8 @@ annotate.*::
 
 		│1 1382:   movb   $0x1,-0x270(%rbp)
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_total_period::
 		To compare two records on an instruction base, with this option
 		provided, display total number of samples that belong to a line
@@ -348,11 +357,30 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+		This option works with tui, stdio2, stdio browsers.
+
+	annotate.show_nr_samples::
+		By default perf annotate shows percentage of samples. This option
+		can be used to print absolute number of samples. Ex, when set as
+		false:
+
+		Percent│
+		 74.03 │      mov    %fs:0x28,%rax
+
+		When set as true:
+
+		Samples│
+		     6 │      mov    %fs:0x28,%rax
+
+		This option works with tui, stdio2, stdio browsers.
+
 	annotate.offset_level::
 		Default is '1', meaning just jump targets will have offsets show right beside
 		the instruction. When set to '2' 'call' instructions will also have its offsets
 		shown, 3 or higher will show offsets for all instructions.
 
+		This option works with tui, stdio2 browsers.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
@@ -490,6 +518,12 @@ top.*::
 		column by default.
 		The default is 'true'.
 
+	top.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'top' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf top' to actually use it,
+		the command line option -g must be specified.
+
 man.*::
 	man.viewer::
 		This option can assign a tool to view manual pages when 'help'
@@ -517,6 +551,16 @@ record.*::
 		But if this option is 'no-cache', it will not update the build-id cache.
 		'skip' skips post-processing and does not update the cache.
 
+	record.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'record' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf record' to actually use it,
+		the command line option -g must be specified.
+
+	record.aio::
+		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
+		mode ('n' default: 1, max: 4).
+
 diff.*::
 	diff.order::
 		This option sets the number of columns to sort the result.
@@ -566,6 +610,11 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
+ftrace.*::
+	ftrace.tracer::
+		Can be used to select the default tracer. Possible values are
+		'function' and 'function_graph'.
+
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
@@ -610,6 +659,29 @@ scripts.*::
 	The script gets the same options passed as a full perf script,
 	in particular -i perfdata file, --cpu, --tid
 
+convert.*::
+
+	convert.queue-size::
+		Limit the size of ordered_events queue, so we could control
+		allocation size of perf data files without proper finished
+		round events.
+
+intel-pt.*::
+
+	intel-pt.cache-divisor::
+
+	intel-pt.mispred-all::
+		If set, Intel PT decoder will set the mispred flag on all
+		branches.
+
+auxtrace.*::
+
+	auxtrace.dumpdir::
+		s390 only. The directory to save the auxiliary trace buffer
+		can be changed using this option. Ex, auxtrace.dumpdir=/tmp.
+		If the directory does not exist or has the wrong file type,
+		the current directory is used.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2898cfdf8fe1..941f814820b8 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -858,21 +858,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 	free(ptr);
 }
 
-static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
-			return perf_evlist__enable_event_idx(ptr->evlist,
-							     evsel, idx);
-	}
-
-	return -EINVAL;
-}
-
 struct auxtrace_record *cs_etm_record_init(int *err)
 {
 	struct perf_pmu *cs_etm_pmu;
@@ -892,6 +877,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	}
 
 	ptr->cs_etm_pmu			= cs_etm_pmu;
+	ptr->itr.pmu			= cs_etm_pmu;
 	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
@@ -901,7 +887,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
 	ptr->itr.reference		= cs_etm_reference;
 	ptr->itr.free			= cs_etm_recording_free;
-	ptr->itr.read_finish		= cs_etm_read_finish;
+	ptr->itr.read_finish		= auxtrace_record__read_finish;
 
 	*err = 0;
 	return &ptr->itr;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..8d6821d9c3f6 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -158,20 +158,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 	free(sper);
 }
 
-static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type)
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *arm_spe_recording_init(int *err,
 					       struct perf_pmu *arm_spe_pmu)
 {
@@ -189,12 +175,13 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	}
 
 	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.recording_options = arm_spe_recording_options;
 	sper->itr.info_priv_size = arm_spe_info_priv_size;
 	sper->itr.info_fill = arm_spe_info_fill;
 	sper->itr.free = arm_spe_recording_free;
 	sper->itr.reference = arm_spe_reference;
-	sper->itr.read_finish = arm_spe_read_finish;
+	sper->itr.read_finish = auxtrace_record__read_finish;
 	sper->itr.alignment = 0;
 
 	*err = 0;
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 43f736ed47f2..35b61bfc1b1a 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -517,3 +517,5 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 27d9e214d068..26cee1052179 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -413,20 +413,6 @@ static int intel_bts_find_snapshot(struct auxtrace_record *itr, int idx,
 	return err;
 }
 
-static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_bts_recording *btsr =
-			container_of(itr, struct intel_bts_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(btsr->evlist, evsel) {
-		if (evsel->core.attr.type == btsr->intel_bts_pmu->type)
-			return perf_evlist__enable_event_idx(btsr->evlist,
-							     evsel, idx);
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_bts_recording_init(int *err)
 {
 	struct perf_pmu *intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
@@ -447,6 +433,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	}
 
 	btsr->intel_bts_pmu = intel_bts_pmu;
+	btsr->itr.pmu = intel_bts_pmu;
 	btsr->itr.recording_options = intel_bts_recording_options;
 	btsr->itr.info_priv_size = intel_bts_info_priv_size;
 	btsr->itr.info_fill = intel_bts_info_fill;
@@ -456,7 +443,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	btsr->itr.find_snapshot = intel_bts_find_snapshot;
 	btsr->itr.parse_snapshot_options = intel_bts_parse_snapshot_options;
 	btsr->itr.reference = intel_bts_reference;
-	btsr->itr.read_finish = intel_bts_read_finish;
+	btsr->itr.read_finish = auxtrace_record__read_finish;
 	btsr->itr.alignment = sizeof(struct branch);
 	return &btsr->itr;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 20df442fdf36..7eea4fd7ce58 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1166,20 +1166,6 @@ static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
 	return rdtsc();
 }
 
-static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
-{
-	struct intel_pt_recording *ptr =
-			container_of(itr, struct intel_pt_recording, itr);
-	struct evsel *evsel;
-
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
-			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
-							     idx);
-	}
-	return -EINVAL;
-}
-
 struct auxtrace_record *intel_pt_recording_init(int *err)
 {
 	struct perf_pmu *intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
@@ -1200,6 +1186,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	}
 
 	ptr->intel_pt_pmu = intel_pt_pmu;
+	ptr->itr.pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
 	ptr->itr.info_fill = intel_pt_info_fill;
@@ -1209,7 +1196,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	ptr->itr.find_snapshot = intel_pt_find_snapshot;
 	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
 	ptr->itr.reference = intel_pt_reference;
-	ptr->itr.read_finish = intel_pt_read_finish;
+	ptr->itr.read_finish = auxtrace_record__read_finish;
 	/*
 	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
 	 * should give at least 1 PSB per sample.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ff61795a4d13..6c0a0412502e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -566,6 +566,8 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	annotation_config__init(&annotate.opts);
+
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 	if (argc) {
 		/*
@@ -605,8 +607,6 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init();
-
 	symbol_conf.try_vmlinux_path = true;
 
 	ret = symbol__init(&annotate.session->header.env);
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc5923e6b5..70548df2abb9 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -449,7 +449,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
 			goto error;
-	}
+	} else if (ret == -ENOMEM)
+		goto error;
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
@@ -459,7 +460,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
 			goto error;
-	}
+	} else if (ret2 == -ENOMEM)
+		goto error;
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9483b3f0cae3..72a12b69f120 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1507,7 +1507,7 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.priv_size += sizeof(u32);
 			symbol_conf.sort_by_name = true;
 		}
-		annotation_config__init();
+		annotation_config__init(&report.annotation_opts);
 	}
 
 	if (symbol__init(&session->header.env) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8affcab75604..f6dd1a63f159 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
@@ -1683,7 +1683,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
-	annotation_config__init();
+	annotation_config__init(&top.annotation_opts);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 607189a315b2..6e61c4bdf548 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 7ca6fa5463ee..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index d1a35b6c649d..ca7877f9a976 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 7cb99b433888..c2cc42daf924 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -14,7 +14,7 @@ add_probe_vfs_getname() {
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
 	fi
 }
 
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index badbddbb30f8..9023267e5643 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -754,10 +754,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
-			{
-				script_browse(NULL, NULL);
-				continue;
-			}
+			script_browse(NULL, NULL);
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case 'k':
 			notes->options->show_linenr = !notes->options->show_linenr;
 			break;
@@ -834,13 +833,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			map_symbol__annotation_dump(ms, evsel, browser->opts);
 			continue;
 		case 't':
-			if (notes->options->show_total_period) {
-				notes->options->show_total_period = false;
-				notes->options->show_nr_samples = true;
-			} else if (notes->options->show_nr_samples)
-				notes->options->show_nr_samples = false;
+			if (symbol_conf.show_total_period) {
+				symbol_conf.show_total_period = false;
+				symbol_conf.show_nr_samples = true;
+			} else if (symbol_conf.show_nr_samples)
+				symbol_conf.show_nr_samples = false;
 			else
-				notes->options->show_total_period = true;
+				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
 		case 'c':
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 22cc240f7371..35f9641bf670 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
+	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ca73fb74ad03..0ea95be84b3b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,93 +1143,70 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 }
 
 struct annotate_args {
-	size_t			 privsize;
-	struct arch		*arch;
-	struct map_symbol	 ms;
-	struct evsel	*evsel;
+	struct arch		  *arch;
+	struct map_symbol	  ms;
+	struct evsel		  *evsel;
 	struct annotation_options *options;
-	s64			 offset;
-	char			*line;
-	int			 line_nr;
+	s64			  offset;
+	char			  *line;
+	int			  line_nr;
 };
 
-static void annotation_line__delete(struct annotation_line *al)
+static void annotation_line__init(struct annotation_line *al,
+				  struct annotate_args *args,
+				  int nr)
 {
-	void *ptr = (void *) al - al->privsize;
+	al->offset = args->offset;
+	al->line = strdup(args->line);
+	al->line_nr = args->line_nr;
+	al->data_nr = nr;
+}
 
+static void annotation_line__exit(struct annotation_line *al)
+{
 	free_srcline(al->path);
 	zfree(&al->line);
-	free(ptr);
 }
 
-/*
- * Allocating the annotation line data with following
- * structure:
- *
- *    --------------------------------------
- *    private space | struct annotation_line
- *    --------------------------------------
- *
- * Size of the private space is stored in 'struct annotation_line'.
- *
- */
-static struct annotation_line *
-annotation_line__new(struct annotate_args *args, size_t privsize)
+static size_t disasm_line_size(int nr)
 {
 	struct annotation_line *al;
-	struct evsel *evsel = args->evsel;
-	size_t size = privsize + sizeof(*al);
-	int nr = 1;
-
-	if (perf_evsel__is_group_event(evsel))
-		nr = evsel->core.nr_members;
 
-	size += sizeof(al->data[0]) * nr;
-
-	al = zalloc(size);
-	if (al) {
-		al = (void *) al + privsize;
-		al->privsize   = privsize;
-		al->offset     = args->offset;
-		al->line       = strdup(args->line);
-		al->line_nr    = args->line_nr;
-		al->data_nr    = nr;
-	}
-
-	return al;
+	return (sizeof(struct disasm_line) + (sizeof(al->data[0]) * nr));
 }
 
 /*
  * Allocating the disasm annotation line data with
  * following structure:
  *
- *    ------------------------------------------------------------
- *    privsize space | struct disasm_line | struct annotation_line
- *    ------------------------------------------------------------
+ *    -------------------------------------------
+ *    struct disasm_line | struct annotation_line
+ *    -------------------------------------------
  *
  * We have 'struct annotation_line' member as last member
  * of 'struct disasm_line' to have an easy access.
- *
  */
 static struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
 	struct disasm_line *dl = NULL;
-	struct annotation_line *al;
-	size_t privsize = args->privsize + offsetof(struct disasm_line, al);
+	int nr = 1;
 
-	al = annotation_line__new(args, privsize);
-	if (al != NULL) {
-		dl = disasm_line(al);
+	if (perf_evsel__is_group_event(args->evsel))
+		nr = args->evsel->core.nr_members;
 
-		if (dl->al.line == NULL)
-			goto out_delete;
+	dl = zalloc(disasm_line_size(nr));
+	if (!dl)
+		return NULL;
 
-		if (args->offset != -1) {
-			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
-				goto out_free_line;
+	annotation_line__init(&dl->al, args, nr);
+	if (dl->al.line == NULL)
+		goto out_delete;
 
-			disasm_line__init_ins(dl, args->arch, &args->ms);
-		}
+	if (args->offset != -1) {
+		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
+			goto out_free_line;
+
+		disasm_line__init_ins(dl, args->arch, &args->ms);
 	}
 
 	return dl;
@@ -1248,7 +1225,8 @@ void disasm_line__free(struct disasm_line *dl)
 	else
 		ins__delete(&dl->ops);
 	zfree(&dl->ins.name);
-	annotation_line__delete(&dl->al);
+	annotation_line__exit(&dl->al);
+	free(dl);
 }
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name)
@@ -2149,13 +2127,12 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		     struct annotation_options *options, struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.privsize	= privsize,
 		.evsel		= evsel,
 		.options	= options,
 	};
@@ -2644,6 +2621,8 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	struct annotation_line *al;
 
 	notes->max_line_len = 0;
+	notes->nr_entries = 0;
+	notes->nr_asm_entries = 0;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		size_t line_len = strlen(al->line);
@@ -2790,7 +2769,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
+	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -2915,9 +2894,9 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			percent = annotation_data__percent(&al->data[i], percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
-			if (notes->options->show_total_period) {
+			if (symbol_conf.show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
-			} else if (notes->options->show_nr_samples) {
+			} else if (symbol_conf.show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
@@ -2931,8 +2910,8 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			obj__printf(obj, "%-*s", pcnt_width, " ");
 		else {
 			obj__printf(obj, "%-*s", pcnt_width,
-					   notes->options->show_total_period ? "Period" :
-					   notes->options->show_nr_samples ? "Samples" : "Percent");
+					   symbol_conf.show_total_period ? "Period" :
+					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
 
@@ -3070,7 +3049,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, 0, options, parch);
+	err = symbol__annotate(ms, evsel, options, parch);
 	if (err)
 		goto out_free_offsets;
 
@@ -3094,69 +3073,46 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	return err;
 }
 
-#define ANNOTATION__CFG(n) \
-	{ .name = #n, .value = &annotation__default_options.n, }
-
-/*
- * Keep the entries sorted, they are bsearch'ed
- */
-static struct annotation_config {
-	const char *name;
-	void *value;
-} annotation__configs[] = {
-	ANNOTATION__CFG(hide_src_code),
-	ANNOTATION__CFG(jump_arrows),
-	ANNOTATION__CFG(offset_level),
-	ANNOTATION__CFG(show_linenr),
-	ANNOTATION__CFG(show_nr_jumps),
-	ANNOTATION__CFG(show_nr_samples),
-	ANNOTATION__CFG(show_total_period),
-	ANNOTATION__CFG(use_offset),
-};
-
-#undef ANNOTATION__CFG
-
-static int annotation_config__cmp(const void *name, const void *cfgp)
-{
-	const struct annotation_config *cfg = cfgp;
-
-	return strcmp(name, cfg->name);
-}
-
-static int annotation__config(const char *var, const char *value,
-			    void *data __maybe_unused)
+static int annotation__config(const char *var, const char *value, void *data)
 {
-	struct annotation_config *cfg;
-	const char *name;
+	struct annotation_options *opt = data;
 
 	if (!strstarts(var, "annotate."))
 		return 0;
 
-	name = var + 9;
-	cfg = bsearch(name, annotation__configs, ARRAY_SIZE(annotation__configs),
-		      sizeof(struct annotation_config), annotation_config__cmp);
-
-	if (cfg == NULL)
-		pr_debug("%s variable unknown, ignoring...", var);
-	else if (strcmp(var, "annotate.offset_level") == 0) {
-		perf_config_int(cfg->value, name, value);
-
-		if (*(int *)cfg->value > ANNOTATION__MAX_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MAX_OFFSET_LEVEL;
-		else if (*(int *)cfg->value < ANNOTATION__MIN_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MIN_OFFSET_LEVEL;
+	if (!strcmp(var, "annotate.offset_level")) {
+		perf_config_u8(&opt->offset_level, "offset_level", value);
+
+		if (opt->offset_level > ANNOTATION__MAX_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MAX_OFFSET_LEVEL;
+		else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else if (!strcmp(var, "annotate.hide_src_code")) {
+		opt->hide_src_code = perf_config_bool("hide_src_code", value);
+	} else if (!strcmp(var, "annotate.jump_arrows")) {
+		opt->jump_arrows = perf_config_bool("jump_arrows", value);
+	} else if (!strcmp(var, "annotate.show_linenr")) {
+		opt->show_linenr = perf_config_bool("show_linenr", value);
+	} else if (!strcmp(var, "annotate.show_nr_jumps")) {
+		opt->show_nr_jumps = perf_config_bool("show_nr_jumps", value);
+	} else if (!strcmp(var, "annotate.show_nr_samples")) {
+		symbol_conf.show_nr_samples = perf_config_bool("show_nr_samples",
+								value);
+	} else if (!strcmp(var, "annotate.show_total_period")) {
+		symbol_conf.show_total_period = perf_config_bool("show_total_period",
+								value);
+	} else if (!strcmp(var, "annotate.use_offset")) {
+		opt->use_offset = perf_config_bool("use_offset", value);
 	} else {
-		*(bool *)cfg->value = perf_config_bool(name, value);
+		pr_debug("%s variable unknown, ignoring...", var);
 	}
+
 	return 0;
 }
 
-void annotation_config__init(void)
+void annotation_config__init(struct annotation_options *opt)
 {
-	perf_config(annotation__config, NULL);
-
-	annotation__default_options.show_total_period = symbol_conf.show_total_period;
-	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
+	perf_config(annotation__config, opt);
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 455403e8fede..001258601a37 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -83,8 +83,6 @@ struct annotation_options {
 	     full_path,
 	     show_linenr,
 	     show_nr_jumps,
-	     show_nr_samples,
-	     show_total_period,
 	     show_minmax_cycle,
 	     show_asm_raw,
 	     annotate_src;
@@ -141,7 +139,6 @@ struct annotation_line {
 	u64			 cycles;
 	u64			 cycles_max;
 	u64			 cycles_min;
-	size_t			 privsize;
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
@@ -309,7 +306,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
+	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
@@ -352,7 +349,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
-		     struct evsel *evsel, size_t privsize,
+		     struct evsel *evsel,
 		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
@@ -413,7 +410,7 @@ static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 }
 #endif
 
-void annotation_config__init(void);
+void annotation_config__init(struct annotation_options *opt);
 
 int annotate_parse_percent_type(const struct option *opt, const char *_str,
 				int unset);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index eb087e7df6f4..3571ce72ca28 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -629,8 +629,10 @@ int auxtrace_record__options(struct auxtrace_record *itr,
 			     struct evlist *evlist,
 			     struct record_opts *opts)
 {
-	if (itr)
+	if (itr) {
+		itr->evlist = evlist;
 		return itr->recording_options(itr, evlist, opts);
+	}
 	return 0;
 }
 
@@ -664,6 +666,24 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
+{
+	struct evsel *evsel;
+
+	if (!itr->evlist || !itr->pmu)
+		return -EINVAL;
+
+	evlist__for_each_entry(itr->evlist, evsel) {
+		if (evsel->core.attr.type == itr->pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			return perf_evlist__enable_event_idx(itr->evlist, evsel,
+							     idx);
+		}
+	}
+	return -EINVAL;
+}
+
 /*
  * Event record size is 16-bit which results in a maximum size of about 64KiB.
  * Allow about 4KiB for the rest of the sample record, to give a maximum
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 749d72cd9c7b..e58ef160b599 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -29,6 +29,7 @@ struct record_opts;
 struct perf_record_auxtrace_error;
 struct perf_record_auxtrace_info;
 struct events_stats;
+struct perf_pmu;
 
 enum auxtrace_error_type {
        PERF_AUXTRACE_ERROR_ITRACE  = 1,
@@ -322,6 +323,8 @@ struct auxtrace_mmap_params {
  * @read_finish: called after reading from an auxtrace mmap
  * @alignment: alignment (if any) for AUX area data
  * @default_aux_sample_size: default sample size for --aux sample option
+ * @pmu: associated pmu
+ * @evlist: selected events list
  */
 struct auxtrace_record {
 	int (*recording_options)(struct auxtrace_record *itr,
@@ -346,6 +349,8 @@ struct auxtrace_record {
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
 	unsigned int default_aux_sample_size;
+	struct perf_pmu *pmu;
+	struct evlist *evlist;
 };
 
 /**
@@ -537,6 +542,7 @@ int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 				   struct auxtrace_mmap *mm,
 				   unsigned char *data, u64 *head, u64 *old);
 u64 auxtrace_record__reference(struct auxtrace_record *itr);
+int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx);
 
 int auxtrace_index__auxtrace_event(struct list_head *head, union perf_event *event,
 				   off_t file_offset);
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0bc9c4d7fdc5..ef38eba56ed0 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -374,6 +374,18 @@ int perf_config_int(int *dest, const char *name, const char *value)
 	return 0;
 }
 
+int perf_config_u8(u8 *dest, const char *name, const char *value)
+{
+	long ret = 0;
+
+	if (!perf_parse_long(value, &ret)) {
+		bad_config(name);
+		return -1;
+	}
+	*dest = ret;
+	return 0;
+}
+
 static int perf_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int ret;
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index bd0a5897c76a..c10b66dde2f3 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -29,6 +29,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_int(int *dest, const char *, const char *);
+int perf_config_u8(u8 *dest, const char *name, const char *value);
 int perf_config_u64(u64 *dest, const char *, const char *);
 int perf_config_bool(const char *, const char *);
 int config_error_nonbool(const char *);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba403345..0f5fda11675f 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -301,10 +301,15 @@ int probe_file__get_events(int fd, struct strfilter *filter,
 		p = strchr(ent->s, ':');
 		if ((p && strfilter__compare(filter, p + 1)) ||
 		    strfilter__compare(filter, ent->s)) {
-			strlist__add(plist, ent->s);
+			ret = strlist__add(plist, ent->s);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 			ret = 0;
 		}
 	}
+out:
 	strlist__delete(namelist);
 
 	return ret;
@@ -511,7 +516,11 @@ static int probe_cache__load(struct probe_cache *pcache)
 				ret = -EINVAL;
 				goto out;
 			}
-			strlist__add(entry->tevlist, buf);
+			ret = strlist__add(entry->tevlist, buf);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 		}
 	}
 out:
@@ -672,7 +681,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 		command = synthesize_probe_trace_command(&tevs[i]);
 		if (!command)
 			goto out_err;
-		strlist__add(entry->tevlist, command);
+		ret = strlist__add(entry->tevlist, command);
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			goto out_err;
+		}
+
 		free(command);
 	}
 	list_add_tail(&entry->node, &pcache->entries);
@@ -853,9 +867,15 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
 			break;
 		}
 
-		strlist__add(entry->tevlist, buf);
+		ret = strlist__add(entry->tevlist, buf);
+
 		free(buf);
 		entry = NULL;
+
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			break;
+		}
 	}
 	if (entry) {
 		list_del_init(&entry->node);
