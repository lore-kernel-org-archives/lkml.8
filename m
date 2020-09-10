Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA47C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D084520C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599728167;
	bh=wI+o7l6xyWnZkwD9Z2sUxIBAfYQ5d3573I9H1mMjVxo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dIrt05dse/1a2oUQYEe3zBcn9kZ98oG3yTZDBvHyDfy/yCDhCdnF+tr1ymZF04CI4
	 dwj10a4hC4rFcDPCHt3gq5nlZzoKA/EsoVUcmlnU3+A7am3oGwa4tqt90rp05YyqZ8
	 +hsy62PS9mZPSkELELZiwpMMNaeWPKjDjdJJpiDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgIJI4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgIJIzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:55:01 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B492078B;
        Thu, 10 Sep 2020 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728100;
        bh=wI+o7l6xyWnZkwD9Z2sUxIBAfYQ5d3573I9H1mMjVxo=;
        h=From:To:Cc:Subject:Date:From;
        b=fs19XQ7nPvnlkUAZcRhKE9n5KkZbFVK1xCOCrH9eofj82OgUCWwdDTgV1tcKAi/az
         xifMX33ajKxnsujvAg/mm1Kvp3nuBgetTCxAF4v0GLztP6Q5fEytYrrvdaciIXFRgZ
         SA7xGF8TLicYox9Znt0fU36myjsissLBdkHJ8D2M=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/8] tracing/boot: Add new options for tracing specific period
Date:   Thu, 10 Sep 2020 17:54:54 +0900
Message-Id: <159972809455.428528.4737752126800169128.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 3rd version of the series to improve the boot-time tracing to
support kretprobe and tracing_on option. Previous version is here:

 https://lkml.kernel.org/r/159894698993.1478826.2813843560314595660.stgit@devnote2

This version adds uprobe %return suffix support ([5/8]) and the testcases
([8/8]), and update kprobe %suffix support([4/8]) and the uprobe event
document([6/8]).


The combination of tracing_on and kretprobe allows us to trace events
while a specific function call period. For example, the below bootconfig
will make a function callgraph in the pci_proc_init() function at boot
time.

ftrace {
	tracing_on = 0  # off at start
	tracer = function_graph
	event.kprobes {
		start_event {
			probes = "pci_proc_init"
			actions = "traceon"
		}
		end_event {
			probes = "pci_proc_init%return"
			actions = "traceoff"
		}
	}
}

Here is the example output;

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  pci_proc_init() {
 0)               |    proc_mkdir() {
 0)               |      proc_mkdir_data() {
 0)               |        __proc_create() {
 0)               |          _raw_read_lock() {
 0)   0.179 us    |            preempt_count_add();
 0)   0.203 us    |            do_raw_read_lock();
 0)   1.210 us    |          }
 0)               |          __xlate_proc_name() {
 0)   0.449 us    |            pde_subdir_find();
 0)   0.913 us    |          }
 0)               |          _raw_read_unlock() {
 0)   0.169 us    |            do_raw_read_unlock();
 0)   0.175 us    |            preempt_count_sub();
 0)   0.841 us    |          }
 0)               |          kmem_cache_alloc() {
 0)               |            fs_reclaim_acquire() {
 0)   0.154 us    |              __need_fs_reclaim();
 0)   0.240 us    |              fs_reclaim_acquire.part.0();
 0)   0.889 us    |            }
 0)               |            fs_reclaim_release() {
 0)   0.174 us    |              __need_fs_reclaim();
 0)   0.516 us    |            }
 0)   0.157 us    |            should_failslab();
 0)               |            rcu_read_lock_sched_held() {
 0)               |              rcu_read_lock_held_common() {
 0)   0.156 us    |                rcu_is_watching();
 0)   0.158 us    |                rcu_lockdep_current_cpu_online();
 0)   0.735 us    |              }
 0)   1.054 us    |            }
 0)   3.407 us    |          }
 0)   0.168 us    |          __raw_spin_lock_init();
 0)   7.575 us    |        }
 0)               |        proc_register() {
 0)               |          _raw_spin_lock_irqsave() {
 0)   0.187 us    |            preempt_count_add();
...


Thank you,

---

Masami Hiramatsu (8):
      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
      tracing/boot: Add per-instance tracing_on option support
      Documentation: tracing: Add tracing_on option to boot-time tracer
      tracing/kprobes: Support perf-style return probe
      tracing/uprobes: Support perf-style return probe
      Documentation: tracing: Add %return suffix description
      Documentation: tracing: boot: Add an example of tracing function-calls
      selftests/ftrace: Add %return suffix tests


 Documentation/trace/boottime-trace.rst             |   24 ++++++++++++++++++++
 Documentation/trace/kprobetrace.rst                |    2 ++
 Documentation/trace/uprobetracer.rst               |    2 ++
 include/linux/kprobes.h                            |    5 ++++
 init/main.c                                        |    2 ++
 kernel/kprobes.c                                   |   22 ++++++++++++++++++
 kernel/trace/trace.c                               |    4 ++-
 kernel/trace/trace_boot.c                          |   10 ++++++++
 kernel/trace/trace_kprobe.c                        |   18 ++++++++++++++-
 kernel/trace/trace_probe.h                         |    1 +
 kernel/trace/trace_uprobe.c                        |   15 ++++++++++++-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    6 +++++
 .../test.d/kprobe/kretprobe_return_suffix.tc       |   21 ++++++++++++++++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    6 +++++
 14 files changed, 134 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_return_suffix.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
