Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6CD217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GPgT2SFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgCBMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:45:36 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.125]:30857 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbgCBMpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:45:36 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E8A70B87ED
        for <linux-kernel@vger.kernel.org>; Mon,  2 Mar 2020 06:45:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8kRxjTfnwvBMd8kRxjOZhB; Mon, 02 Mar 2020 06:45:33 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tl8+3TSgEq6tAPLGgAaiTefQihYsH/3BU/lyPlzh9Iw=; b=GPgT2SFPXC633+7BHksASa2QrB
        eSZdc9l+tQjgEhZq4fWnnmHBHFoidyCPI5v7Cv8Pfuj8IYFOAfGkn8ZwprgS+2OBG0NRxgjFOxWNt
        /GumsrW7HyY1ul5wqVhBikb1J7lbO8bBQJvb0XSqE6vNbcMW0tYRKUCP9bC1BLjzmiNuKdTuzkeMS
        0yvUMDbKGBNNoRTeQxD93jxJqR04IQi8DI2kstGeB0Ia7KzdnQRylZF5FViTV7OJlljM1W+LUPeYy
        /icrTlhZ5rrnojU7P8iNvpLG5cJPTkBnFgibpwTSew8R7p8k8beGEtSIK+xR8a8fnFNycWzWlcpxn
        7xsGDKhQ==;
Received: from [201.162.161.142] (port=43686 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j8kRv-0001vX-HB; Mon, 02 Mar 2020 06:45:32 -0600
Date:   Mon, 2 Mar 2020 06:48:32 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] perf: Replace zero-length array with flexible-array
 member
Message-ID: <20200302124832.GA7504@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.161.142
X-Source-L: No
X-Exim-ID: 1j8kRv-0001vX-HB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.161.142]:43686
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 55
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 include/linux/perf_event.h               | 4 ++--
 include/uapi/linux/perf_event.h          | 2 +-
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
 17 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 68e21e828893..11b63013e1d9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -61,7 +61,7 @@ struct perf_guest_info_callbacks {
 
 struct perf_callchain_entry {
 	__u64				nr;
-	__u64				ip[0]; /* /proc/sys/kernel/perf_event_max_stack */
+	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
 };
 
 struct perf_callchain_entry_ctx {
@@ -113,7 +113,7 @@ struct perf_raw_record {
 struct perf_branch_stack {
 	__u64				nr;
 	__u64				hw_idx;
-	struct perf_branch_entry	entries[0];
+	struct perf_branch_entry	entries[];
 };
 
 struct task_struct;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 397cfd65b3fe..d71023c46058 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -453,7 +453,7 @@ struct perf_event_query_bpf {
 	/*
 	 * User provided buffer to store program ids
 	 */
-	__u32	ids[0];
+	__u32	ids[];
 };
 
 /*
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
index e2406b291c1c..4576b0b226fb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2568,7 +2568,7 @@ static int __cmd_script(struct perf_script *script)
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
index 001258601a37..d641029d0c4a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -143,7 +143,7 @@ struct annotation_line {
 	u32			 idx;
 	int			 idx_asm;
 	int			 data_nr;
-	struct annotation_data	 data[0];
+	struct annotation_data	 data[];
 };
 
 struct disasm_line {
@@ -226,7 +226,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
-	struct sym_hist_entry addr[0];
+	struct sym_hist_entry addr[];
 };
 
 struct cyc_hist {
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 88e00d268f6f..e353a5c1aa72 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -39,7 +39,7 @@ struct branch_entry {
 
 struct branch_stack {
 	u64			nr;
-	struct branch_entry	entries[0];
+	struct branch_entry	entries[];
 };
 
 struct branch_type_stat {
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
index 85223159737c..adda817569d8 100644
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
2.25.0

