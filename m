Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB44420720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594282031;
	bh=y0a2f/ZKUJLdbWg350s311mc7sM3VDi/PX/4ZofdmTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAOBOkgEIYVtC6ybuHzFKZ/WwLK9AivdqFoagoPY4YlTRslYW1zIw/zmb6Ra/ToOn
	 lB4grdoV2JbTbH5K61zsDC80C8gVtDbYr/A+NeN7VDdlg6FHDMV2qWAW/x14riIacd
	 eR2T1KzwAPPebrlXgrmGqMbdIBc3ApBAh2MEOROo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGIIHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgGIIHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:07:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1084E20720;
        Thu,  9 Jul 2020 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282026;
        bh=y0a2f/ZKUJLdbWg350s311mc7sM3VDi/PX/4ZofdmTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR63mC+IUesjGYOIysB4pn0a8kpQ1Qn2BMUbUeqKhuBj8oJ3vsvaPA5qtmk972uu5
         cisaw8pCmsgQ9Yhlz9gJYKbxK13qEG96ubRtAbLCLK6vprrlfeiYaTdDtFSRlamvA5
         QGuocGCnixFWlQrYhfHYH8zkZwujZ9rTaxF2bXjk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/4] perf-probe: Avoid setting probes on same address on same event
Date:   Thu,  9 Jul 2020 17:07:01 +0900
Message-Id: <159428202173.56570.3555041287477206859.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159428201109.56570.3802208017109058146.stgit@devnote2>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a case that the several same-name symbols points
same address. In that case, perf probe returns an error.

E.g.

  perf probe -x /lib64/libc-2.30.so -v -a "memcpy arg1=%di"
  probe-definition(0): memcpy arg1=%di
  symbol:memcpy file:(null) line:0 offset:0 return:0 lazy:(null)
  parsing arg: arg1=%di into name:arg1 %di
  1 arguments
  symbol:setjmp file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:longjmp file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:longjmp_target file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:lll_lock_wait_private file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_arena_max file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_arena_test file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_tunable_tcache_max_bytes file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_tunable_tcache_count file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_tunable_tcache_unsorted_limit file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_trim_threshold file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_top_pad file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_mmap_threshold file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_mmap_max file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_perturb file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_mxfast file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_heap_new file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_arena_reuse_free_list file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_arena_reuse file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_arena_reuse_wait file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_arena_new file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_arena_retry file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_sbrk_less file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_heap_free file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_heap_less file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_tcache_double_free file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_heap_more file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_sbrk_more file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_malloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_memalign_retry file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt_free_dyn_thresholds file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_realloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_calloc_retry file:(null) line:0 offset:0 return:0 lazy:(null)
  symbol:memory_mallopt file:(null) line:0 offset:0 return:0 lazy:(null)
  Open Debuginfo file: /usr/lib/debug/usr/lib64/libc-2.30.so.debug
  Try to find probe point from debuginfo.
  Opening /sys/kernel/debug/tracing//README write=0
  Failed to find the location of the '%di' variable at this address.
   Perhaps it has been optimized out.
   Use -V with the --range option to show '%di' location range.
  An error occurred in debuginfo analysis (-2).
  Trying to use symbols.
  Opening /sys/kernel/debug/tracing//uprobe_events write=1
  Writing event: p:probe_libc/memcpy /usr/lib64/libc-2.30.so:0x914c0 arg1=%di
  Writing event: p:probe_libc/memcpy /usr/lib64/libc-2.30.so:0x914c0 arg1=%di
  Failed to write event: File exists
    Error: Failed to add events. Reason: File exists (Code: -17)

You can see the perf tried to write completely same probe definition
twice, which caused an error.

To fix this issue, check the symbol list and drop duplicated
symbols (which has same symbol name and address) from it.

With this patch;

  # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
  Failed to find the location of the '%di' variable at this address.
   Perhaps it has been optimized out.
   Use -V with the --range option to show '%di' location range.
  Added new events:
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
    probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)

  You can now use it in all perf tools, such as:

  	perf record -e probe_libc:memcpy -aR sleep 1


Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index df713a5d1e26..1e95a336862c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2968,6 +2968,15 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	for (j = 0; j < num_matched_functions; j++) {
 		sym = syms[j];
 
+		/* There can be duplicated symbols in the map */
+		for (i = 0; i < j; i++)
+			if (sym->start == syms[i]->start) {
+				pr_debug("find duplicated symbol %s @ %lx\n", sym->name, sym->start);
+				break;
+			}
+		if (i != j)
+			continue;
+
 		tev = (*tevs) + ret;
 		tp = &tev->point;
 		if (ret == num_matched_functions) {

