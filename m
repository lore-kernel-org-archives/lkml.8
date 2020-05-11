Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC762C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE893206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589226734;
	bh=1AP91u5FLrkOCFn5xDlNIB9AGLcDkNTXz6XYt5eZWlo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1ryj9wFNW/G6ogZGtdafHom/4mDoyNrng3NU/JI0GsHudSs0/h/VTNEgwbyVaQtua
	 +JzyE1NWIHY5uoWJJF5NDyvMOO1QV1Ih/WOzwX2yy+aCrYZupHPP88aLENRPLOZKEO
	 ulVJ9Swq1PCGH4P0iGg2fiOy/m5sx1QuCpQtO0Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgEKTwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgEKTwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:52:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735F9206DB;
        Mon, 11 May 2020 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589226731;
        bh=1AP91u5FLrkOCFn5xDlNIB9AGLcDkNTXz6XYt5eZWlo=;
        h=Date:From:To:Cc:Subject:From;
        b=AoHM0tJo4zVrxmrYFYRCpSGvm4rWYiZWjmqPbLl41WMnfwfnlT2Shx6hic8W+ZCE5
         dDy0jwfXxH0f7AVLnVuEK9WghzJ6dGeOsq5evkSzZh7xWq0/IJvjZ2Tn4IOY0TVFhl
         paGwJWQe7mR5f4sfv14KJYdtls/LoJh+VfGcvH28=
Date:   Mon, 11 May 2020 14:56:43 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf tools: Replace zero-length array with flexible-array
Message-ID: <20200511195643.GA9850@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/perf/bench/sched-messaging.c       | 2 +-
 tools/perf/builtin-inject.c              | 2 +-
 tools/perf/builtin-script.c              | 2 +-
 tools/perf/builtin-timechart.c           | 2 +-
 tools/perf/util/annotate.h               | 4 ++--
 tools/perf/util/branch.h                 | 2 +-
 tools/perf/util/cputopo.h                | 2 +-
 tools/perf/util/dso.h                    | 4 ++--
 tools/perf/util/event.h                  | 2 +-
 tools/perf/util/jitdump.c                | 2 +-
 tools/perf/util/jitdump.h                | 6 +++---
 tools/perf/util/ordered-events.h         | 2 +-
 tools/perf/util/pstack.c                 | 2 +-
 tools/perf/util/symbol.h                 | 2 +-
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 97e4a4fb3362..71d830d7b923 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -40,7 +40,7 @@ struct sender_context {
 	unsigned int num_fds;
 	int ready_out;
 	int wakefd;
-	int out_fds[0];
+	int out_fds[];
 };
 
 struct receiver_context {
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7e124a7b8bfd..8f983877c42d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -51,7 +51,7 @@ struct perf_inject {
 struct event_entry {
 	struct list_head node;
 	u32		 tid;
-	union perf_event event[0];
+	union perf_event event[];
 };
 
 static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1f57a7ecdf3d..02d64a9c6f64 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2619,7 +2619,7 @@ static int __cmd_script(struct perf_script *script)
 struct script_spec {
 	struct list_head	node;
 	struct scripting_ops	*ops;
-	char			spec[0];
+	char			spec[];
 };
 
 static LIST_HEAD(script_specs);
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9e84fae9b096..0ba568efa939 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -128,7 +128,7 @@ struct sample_wrapper {
 	struct sample_wrapper *next;
 
 	u64		timestamp;
-	unsigned char	data[0];
+	unsigned char	data[];
 };
 
 #define TYPE_NONE	0
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2d88069d6428..0a0cd4f32175 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -144,7 +144,7 @@ struct annotation_line {
 	u32			 idx;
 	int			 idx_asm;
 	int			 data_nr;
-	struct annotation_data	 data[0];
+	struct annotation_data	 data[];
 };
 
 struct disasm_line {
@@ -227,7 +227,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
-	struct sym_hist_entry addr[0];
+	struct sym_hist_entry addr[];
 };
 
 struct cyc_hist {
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 154a05cd03af..748f1d23a5c4 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -41,7 +41,7 @@ struct branch_entry {
 struct branch_stack {
 	u64			nr;
 	u64			hw_idx;
-	struct branch_entry	entries[0];
+	struct branch_entry	entries[];
 };
 
 /*
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 7bf6b811f715..6201c3790d86 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -22,7 +22,7 @@ struct numa_topology_node {
 
 struct numa_topology {
 	u32				nr;
-	struct numa_topology_node	nodes[0];
+	struct numa_topology_node	nodes[];
 };
 
 struct cpu_topology *cpu_topology__new(void);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b79617a..d7ba29ad19ff 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -136,7 +136,7 @@ struct dso_cache {
 	struct rb_node	rb_node;
 	u64 offset;
 	u64 size;
-	char data[0];
+	char data[];
 };
 
 struct auxtrace_cache;
@@ -208,7 +208,7 @@ struct dso {
 	struct nsinfo	*nsinfo;
 	struct dso_id	 id;
 	refcount_t	 refcnt;
-	char		 name[0];
+	char		 name[];
 };
 
 /* dso__for_each_symbol - iterate over the symbols of given type
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index b8289f160f07..6ae01c3c2ffa 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -79,7 +79,7 @@ struct sample_read {
 
 struct ip_callchain {
 	u64 nr;
-	u64 ips[0];
+	u64 ips[];
 };
 
 struct branch_stack;
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0ce1938..32bb05e03fb2 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -57,7 +57,7 @@ struct debug_line_info {
 	unsigned long vma;
 	unsigned int lineno;
 	/* The filename format is unspecified, absolute path, relative etc. */
-	char const filename[0];
+	char const filename[];
 };
 
 struct jit_tool {
diff --git a/tools/perf/util/jitdump.h b/tools/perf/util/jitdump.h
index f2c3823cc81a..ab2842def83d 100644
--- a/tools/perf/util/jitdump.h
+++ b/tools/perf/util/jitdump.h
@@ -93,7 +93,7 @@ struct debug_entry {
 	uint64_t addr;
 	int lineno;	    /* source line number starting at 1 */
 	int discrim;	    /* column discriminator, 0 is default */
-	const char name[0]; /* null terminated filename, \xff\0 if same as previous entry */
+	const char name[]; /* null terminated filename, \xff\0 if same as previous entry */
 };
 
 struct jr_code_debug_info {
@@ -101,7 +101,7 @@ struct jr_code_debug_info {
 
 	uint64_t code_addr;
 	uint64_t nr_entry;
-	struct debug_entry entries[0];
+	struct debug_entry entries[];
 };
 
 struct jr_code_unwinding_info {
@@ -110,7 +110,7 @@ struct jr_code_unwinding_info {
 	uint64_t unwinding_size;
 	uint64_t eh_frame_hdr_size;
 	uint64_t mapped_size;
-	const char unwinding_data[0];
+	const char unwinding_data[];
 };
 
 union jr_entry {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0920fb0ec6cc..75345946c4b9 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -29,7 +29,7 @@ typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
 
 struct ordered_events_buffer {
 	struct list_head	list;
-	struct ordered_event	event[0];
+	struct ordered_event	event[];
 };
 
 struct ordered_events {
diff --git a/tools/perf/util/pstack.c b/tools/perf/util/pstack.c
index 80ff41fc45be..a1d1e4ef6257 100644
--- a/tools/perf/util/pstack.c
+++ b/tools/perf/util/pstack.c
@@ -15,7 +15,7 @@
 struct pstack {
 	unsigned short	top;
 	unsigned short	max_nr_entries;
-	void		*entries[0];
+	void		*entries[];
 };
 
 struct pstack *pstack__new(unsigned short max_nr_entries)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 93fc43db1be3..ff4f4c47e148 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -55,7 +55,7 @@ struct symbol {
 	u8		inlined:1;
 	u8		arch_sym;
 	bool		annotate2;
-	char		name[0];
+	char		name[];
 };
 
 void symbol__delete(struct symbol *sym);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index b4649f5a0c2f..9aededc0bc06 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -243,7 +243,7 @@ struct eh_frame_hdr {
 	 *    encoded_t fde_addr;
 	 * } binary_search_table[fde_count];
 	 */
-	char data[0];
+	char data[];
 } __packed;
 
 static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
-- 
2.26.2

