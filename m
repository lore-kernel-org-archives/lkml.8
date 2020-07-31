Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A022CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgGaC5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:57:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:49992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbgGaC5n (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:57:43 -0400
IronPort-SDR: 5B5gaYFgO+5DNPzNaNiN+cI6R94o5iDcf6p7dOh0uUnE33Yg7I0W5rz5HWgTPX85cdFXFiZnSK
 zEfJNWCCcxUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131794859"
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="131794859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 19:57:42 -0700
IronPort-SDR: SaQ46j4k1s3xtdAFwIyUgeHEhuwVp4jVbD1hNq4ZuF6rHrnRuQL+H4tbikSG+5W4XidndXohmJ
 C7ORKAiHpu/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="323103322"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2020 19:57:38 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     peterz@infradead.org, mingo@redhat.com, oleg@redhat.com,
        acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Date:   Fri, 31 Jul 2020 10:56:17 +0800
Message-Id: <20200731025617.16243-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731025617.16243-1-yao.jin@linux.intel.com>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing sampling, for example,

perf record -e cycles:u ...

On workloads that do a lot of kernel entry/exits we see kernel
samples, even though :u is specified. This is due to skid.

This is a potential security issue because it may leak kernel
address even though kernel sampling is disabled.

The commit cc1582c231ea ("perf/core: Drop kernel samples even
though :u is specified") dropped the leaked kernel samples but it
broke rr-project.

Another idea is (inspired by Mark Rutland's original patch), it
doesn't lose the samples, it keeps the samples but fakes the regs
by using the user regs of current task. If the user regs is not
available, uses the instruction_pointer_set to set -1L to ip address
of regs.

For CALLCHAIN, the get_perf_callchain has checked user_mode(regs)
and use task_pt_regs(current) instead in some cases. So actually it
has considered the leaking possibility.

For REGS_USER and STACK_USER, it's similar. The perf_sample_regs_user
has also checked the user_mode(regs). It calls perf_get_regs_user()
for kthread. So we don't need to use "regs_fake" there.

Example:

  perf record -e cycles:u ./div
  perf report --stdio

Before:

  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  ........................
  #
      41.08%  div      div               [.] main
      21.04%  div      libc-2.27.so      [.] __random_r
      19.90%  div      libc-2.27.so      [.] __random
       9.86%  div      div               [.] compute_flag
       4.24%  div      libc-2.27.so      [.] rand
       3.88%  div      div               [.] rand@plt
       0.01%  div      [unknown]         [k] 0xffffffffb9601c20
       0.00%  div      libc-2.27.so      [.] _dl_addr
       0.00%  div      ld-2.27.so        [.] __GI___tunables_init
       0.00%  div      [unknown]         [k] 0xffffffffb9601210
       0.00%  div      ld-2.27.so        [.] _start

"0xffffffffb9601c20, 0xffffffffb9601210" are leaked kernel addresses.

After:

  # Overhead  Command  Shared Object  Symbol
  # ........  .......  .............  ........................
  #
      40.86%  div      div            [.] main
      20.67%  div      libc-2.27.so   [.] __random_r
      20.54%  div      libc-2.27.so   [.] __random
       9.65%  div      div            [.] compute_flag
       4.32%  div      libc-2.27.so   [.] rand
       3.97%  div      div            [.] rand@plt
       0.00%  div      ld-2.27.so     [.] __GI___tunables_init
       0.00%  div      ld-2.27.so     [.] _start

Now there is no kernel address leaked.

Inspired-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 kernel/events/core.c | 48 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c436d705fbd..52f6d7f0b86b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6973,7 +6973,8 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
-	bool kernel = !event->attr.exclude_callchain_kernel;
+	bool kernel = !event->attr.exclude_callchain_kernel &&
+		      !event->attr.exclude_kernel;
 	bool user   = !event->attr.exclude_callchain_user;
 	/* Disallow cross-task user callchains. */
 	bool crosstask = event->ctx->task && event->ctx->task != current;
@@ -6988,12 +6989,39 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+static struct pt_regs *leak_check(struct perf_event_header *header,
+				  struct perf_event *event,
+				  struct pt_regs *regs)
+{
+	struct pt_regs *regs_fake = NULL;
+
+	if (event->attr.exclude_kernel && !user_mode(regs)) {
+		if (!(current->flags & PF_KTHREAD)) {
+			regs_fake = task_pt_regs(current);
+			if (!user_mode(regs_fake)) {
+				regs_fake = NULL;
+				instruction_pointer_set(regs, -1L);
+			}
+		} else
+			instruction_pointer_set(regs, -1L);
+
+		if ((header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
+		     PERF_RECORD_MISC_KERNEL) {
+			header->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
+			header->misc |= PERF_RECORD_MISC_USER;
+		}
+	}
+
+	return regs_fake;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
 	u64 sample_type = event->attr.sample_type;
+	struct pt_regs *regs_fake;
 
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
@@ -7003,8 +7031,19 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the
+	 * kernel before taking an overflow, even if the PMU is only
+	 * counting user events. To avoid leaking kernel address to
+	 * userspace, we try to fake the regs by using the user regs
+	 * of current task.
+	 */
+	regs_fake = leak_check(header, event, regs);
+
 	if (sample_type & PERF_SAMPLE_IP)
-		data->ip = perf_instruction_pointer(regs);
+		data->ip = (regs_fake) ?
+			perf_instruction_pointer(regs_fake) :
+			perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -7099,7 +7138,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		if (regs_fake)
+			perf_sample_regs_intr(&data->regs_intr, regs_fake);
+		else
+			perf_sample_regs_intr(&data->regs_intr, regs);
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
-- 
2.17.1

