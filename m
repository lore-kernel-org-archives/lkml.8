Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA14FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90E52068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598877932;
	bh=fooCJMfBdpktrxHeMxIHu9Z2K4X+c+5VBfikzAUUOlY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tmeocVGnRlW/s6qmjtpX8dNLB90aFqL/T5TW1cFqr9HFdQKvAi0maWx+xGnZQ09iO
	 lggv1xSL7eydyTyNG0mQAYp9fUmYIDKv+7Rv6i7b0CJOryTkYUyTqeeZ7lCUERNz8k
	 FtIMUaRksPafVzYFj98Fi7LR8ZzTomuNIKWYVYrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHaMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaMp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:45:29 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3FE207DA;
        Mon, 31 Aug 2020 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598877928;
        bh=fooCJMfBdpktrxHeMxIHu9Z2K4X+c+5VBfikzAUUOlY=;
        h=From:To:Cc:Subject:Date:From;
        b=wThvLyx/lab/MqoJCQ2WVY1Yndd1PBUGdq1ZeV4Goe10nRNhN3VPFZvgTrgBdqflz
         V2X/t0te64WFaqle0KR+Em3dGEI3bLcvZw2Y6eNvu8uPURBKdG4TD6iUjWHwofwPo5
         KA9AV2Nebi/cDhpG1wfFTF8plZrEL+VAtFEFBfRs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/6] tracing/boot: Add new options for tracing specific period
Date:   Mon, 31 Aug 2020 21:45:24 +0900
Message-Id: <159887792384.1330989.5993224243767476896.stgit@devnote2>
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

Here is a series of patches to improve the boot-time tracing to support
kretprobe and tracing_on option. The combination of these options allows
us to trace events while a specific function call period.

This also includes a bugfix about boot-time kprobe event as [1/6].

For example, this bootconfig will make a function callgraph in the
pci_proc_init() function at boot time.

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

Masami Hiramatsu (6):
      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
      tracing/boot: Add per-instance tracing_on option support
      Documentation: tracing: Add tracing_on option to boot-time tracer
      tracing/kprobes: Support perf-style return probe
      Documentation: tracing: Add %return suffix description
      Documentation: tracing: boot: Add an example of tracing function-calls


 Documentation/trace/boottime-trace.rst |   24 ++++++++++++++++++++++++
 Documentation/trace/kprobetrace.rst    |    2 ++
 include/linux/kprobes.h                |    5 +++++
 init/main.c                            |    2 ++
 kernel/kprobes.c                       |   22 ++++++++++++++++++++++
 kernel/trace/trace_boot.c              |   10 ++++++++++
 kernel/trace/trace_kprobe.c            |   21 ++++++++++++++++++++-
 7 files changed, 85 insertions(+), 1 deletion(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
