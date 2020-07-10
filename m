Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BD02077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594386682;
	bh=Gh8g9KAXggF+LVGCdLW0eULu3Uh36VUeia/Ve9dDfu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWo9oxZpS2+R3Ie4+fiGDB3UZdKOwY90TjLJF4eUwVnQH0/29F+Hu5bNeQl/IbUKq
	 CEotnsCh3KK5KeLc/TD+U05luCDkFHEcoRvOpn/UcfNIUYgX34uB3B4YTCL9cQdpon
	 0BPh+RekLcR4x3jCqVOlmd/LZ318DI6rF/3KdYyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGJNLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgGJNLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:11:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3412077D;
        Fri, 10 Jul 2020 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386668;
        bh=Gh8g9KAXggF+LVGCdLW0eULu3Uh36VUeia/Ve9dDfu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQfL3PH0aTjj5r3URAp2ItjWQjRMhr1QLbkE7GlBsgdrdZMXLvuVTg0X31Z56ALvO
         PWBYgLwpn1L1o6b2OUW7HIW0IKQcbYV7BXHURtH8MWPelt22zp7ZuC6GCeRTojexdV
         VUNxxe3uR2KBoKLUmUTNQ7EP9rVYPLYACPo8pYMg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/4] perf-probe: Avoid setting probes on same address on same event
Date:   Fri, 10 Jul 2020 22:11:04 +0900
Message-Id: <159438666401.62703.15196394835032087840.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159438665389.62703.13848613271334658629.stgit@devnote2>
References: <159438665389.62703.13848613271334658629.stgit@devnote2>
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
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 Changes in V2
  - Change "find" word to "Found".
---
 tools/perf/util/probe-event.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index df713a5d1e26..8cd1224e5f4c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2968,6 +2968,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	for (j = 0; j < num_matched_functions; j++) {
 		sym = syms[j];
 
+		/* There can be duplicated symbols in the map */
+		for (i = 0; i < j; i++)
+			if (sym->start == syms[i]->start) {
+				pr_debug("Found duplicated symbol %s @ %lx\n",
+					 sym->name, sym->start);
+				break;
+			}
+		if (i != j)
+			continue;
+
 		tev = (*tevs) + ret;
 		tp = &tev->point;
 		if (ret == num_matched_functions) {

