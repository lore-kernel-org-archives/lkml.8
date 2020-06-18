Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA768C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7928D20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592508535;
	bh=EQi4Qrhk3QrTT/KplLqkFKEKEn6pAy1J44pZ0E5XQtU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kCSnNXpWArkvzAh1HOFUtKKWK58JdHf0ZF7DDdGG9J6DxlvkXCn8NyM9jX5ml97pJ
	 IKgekJPXxPh1kqJ7gV1P2qAGAI8sQErd+E2poYEiyBnIXLzEXGpiElF6fcrSIcq2Hb
	 vCw/kN9loNamClxD3/BRlNplwMoeiH2naxPguHCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgFRT2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRT2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:28:53 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.140.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8583F2070A;
        Thu, 18 Jun 2020 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592508532;
        bh=EQi4Qrhk3QrTT/KplLqkFKEKEn6pAy1J44pZ0E5XQtU=;
        h=From:To:Cc:Subject:Date:From;
        b=hd3P6AS0YvYWVbVTtNbveN0J0q/WWCZDG5cTqqqX4q5+jpTbsbSwWMkNjV7wuCz3r
         aJVsr3W1ZzF6TJg/ec1eySwCh2UsFIvz5dR28wghhnNGzWvFyxguAdWSHkMZwy9RzO
         uaBaL+HGv/fKrWUXErb3N1ScaIXuF8uo2LbR7Ke4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Gaurav Singh <gaurav1086@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tooling fixes for v5.8
Date:   Thu, 18 Jun 2020 16:28:40 -0300
Message-Id: <20200618192840.4519-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 69119673bd50b176ded34032fadd41530fb5af21:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-06-16 17:44:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-06-02

for you to fetch changes up to 6a1515c962b17e2596ae7b9f074fc5685d6b435b:

  perf build: Fix error message when asking for -fsanitize=address without required libraries (2020-06-18 10:34:31 -0300)

----------------------------------------------------------------
perf tooling fixes for v5.8:

- Update various UAPI headers, some automatically adding support for
  a new MSR and the faccess2 syscall.

- Fix corner case NULL deref in the histograms code.

- Fix corner case NULL deref in 'perf stat' aggregation code.

- Fix array pointer deref and old style declaration in the parsing of events.

- Fix segfault when processing ZSTD compressed perf.data files in 'perf script'
  due to lack of initialization of the ZSTD library.

- Handle __attribute__((user)) in libtraceevent fixing the parsing of syscall
  tracepoints with user buffers.

- Make libtraevent aware of __builtin_expect() appearing in tracepoint fields.

- Make the BPF prologue generation use bpf_probe_read_{user,kernel}().

- Fix the '@user' attribute parsing in kprobes variables in 'perf probe'.

- Fix error message when asking for -fsanitize=address without required libraries.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------

Arnaldo Carvalho de Melo (11):
      tools headers API: Update faccessat2 affected files
      tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      perf beauty: Add support to STATX_MNT_ID in the 'statx' syscall 'mask' argument
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      Merge remote-tracking branch 'torvalds/master' into perf/urgent
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Sync linux/fs.h with the kernel sources

Gaurav Singh (1):
      perf report: Fix NULL pointer dereference in hists__fprintf_nr_sample_events()

Hongbo Yao (1):
      perf stat: Fix NULL pointer dereference

Ian Rogers (3):
      perf parse-events: Fix an incompatible pointer
      perf parse-events: Fix an old style declaration
      perf pmu: Remove unused declaration

Milian Wolff (1):
      perf script: Initialize zstd_data

Steven Rostedt (VMware) (3):
      tools lib traceevent: Add append() function helper for appending strings
      tools lib traceevent: Handle __attribute__((user)) in field names
      tools lib traceevent: Add handler for __builtin_expect()

Sumanth Korikkar (2):
      perf probe: Fix user attribute access in kprobes
      perf bpf: Fix bpf prologue generation

Tiezhu Yang (1):
      perf build: Fix error message when asking for -fsanitize=address without required libraries

 tools/arch/x86/include/asm/cpufeatures.h          |   2 +
 tools/arch/x86/include/asm/msr-index.h            |   4 +
 tools/arch/x86/include/uapi/asm/kvm.h             |  21 ++-
 tools/arch/x86/include/uapi/asm/unistd.h          |   9 +-
 tools/arch/x86/include/uapi/asm/vmx.h             |   3 +
 tools/include/uapi/asm-generic/unistd.h           |   4 +-
 tools/include/uapi/drm/i915_drm.h                 |  24 ++++
 tools/include/uapi/linux/fcntl.h                  |  10 ++
 tools/include/uapi/linux/fs.h                     |   1 +
 tools/include/uapi/linux/fscrypt.h                |   3 +-
 tools/include/uapi/linux/kvm.h                    |  14 ++
 tools/include/uapi/linux/stat.h                   |   8 +-
 tools/include/uapi/linux/vhost.h                  |   4 +
 tools/lib/traceevent/event-parse.c                | 168 ++++++++++++++--------
 tools/perf/Makefile.config                        |  12 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 tools/perf/builtin-report.c                       |   3 +-
 tools/perf/builtin-script.c                       |   3 +
 tools/perf/trace/beauty/statx.c                   |   1 +
 tools/perf/util/bpf-prologue.c                    |  14 +-
 tools/perf/util/parse-events.y                    |   4 +-
 tools/perf/util/pmu.h                             |   1 -
 tools/perf/util/probe-event.c                     |   7 +-
 tools/perf/util/probe-file.c                      |   2 +-
 tools/perf/util/stat-display.c                    |   4 +-
 25 files changed, 250 insertions(+), 77 deletions(-)
