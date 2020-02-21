Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12805C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01DD2465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgBUCqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:46:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:38414 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgBUCqv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:46:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 18:46:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="259488913"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2020 18:46:49 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf annotate: Support interactive annotation of code without symbols
Date:   Fri, 21 Feb 2020 10:46:08 +0800
Message-Id: <20200221024608.1847-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221024608.1847-1-yao.jin@linux.intel.com>
References: <20200221024608.1847-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf report on stripped binaries it is currently impossible to do
annotation. The annotation state is all tied to symbols, but there are
either no symbols, or symbols are not covering all the code.

We should support the annotation functionality even without symbols.

This patch fakes a symbol and the symbol name is the string of address.
After that, we just follow current annotation working flow.

For example,

1. perf report

Overhead  Command  Shared Object     Symbol
  20.67%  div      libc-2.27.so      [.] __random_r
  17.29%  div      libc-2.27.so      [.] __random
  10.59%  div      div               [.] 0x0000000000000628
   9.25%  div      div               [.] 0x0000000000000612
   6.11%  div      div               [.] 0x0000000000000645

2. Select the line of "10.59%  div      div               [.] 0x0000000000000628" and ENTER.

Annotate 0x0000000000000628
Zoom into div thread
Zoom into div DSO (use the 'k' hotkey to zoom directly into the kernel)
Browse map details
Run scripts for samples of symbol [0x0000000000000628]
Run scripts for all samples
Switch to another data file in PWD
Exit

3. Select the "Annotate 0x0000000000000628" and ENTER.

Percent│
       │
       │
       │     Disassembly of section .text:
       │
       │     0000000000000628 <.text+0x68>:
       │       divsd %xmm4,%xmm0
       │       divsd %xmm3,%xmm1
       │       movsd (%rsp),%xmm2
       │       addsd %xmm1,%xmm0
       │       addsd %xmm2,%xmm0
       │       movsd %xmm0,(%rsp)

Now we can see the dump of object starting from 0x628.

 v2:
 ---
 Fix a crash issue when annotating an address in "unknown" object.

 The steps to reproduce this issue:

 perf record -e cycles:u ls
 perf report

    75.29%  ls       ld-2.27.so        [.] do_lookup_x
    23.64%  ls       ld-2.27.so        [.] __GI___tunables_init
     1.04%  ls       [unknown]         [k] 0xffffffff85c01210
     0.03%  ls       ld-2.27.so        [.] _start

 When annotating 0xffffffff85c01210, the crash happens.

 v2 adds checking for ms->map in add_annotate_opt(). If the object is
 "unknown", ms->map is NULL.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h     |  2 ++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f36dee499320..5144528b2931 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,13 +2465,47 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
+static struct symbol *new_annotate_sym(u64 addr, struct map *map,
+				       struct annotation_options *opts)
+{
+	struct symbol *sym;
+	struct annotated_source *src;
+	char name[64];
+
+	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
+
+	sym = symbol__new(addr,
+			  opts->annotate_dummy_len ?
+			  opts->annotate_dummy_len : ANNOTATION_DUMMY_LEN,
+			  0, 0, name);
+	if (sym) {
+		src = symbol__hists(sym, 1);
+		if (!src) {
+			symbol__delete(sym);
+			return NULL;
+		}
+
+		dso__insert_symbol(map->dso, sym);
+	}
+
+	return sym;
+}
+
 static int
-add_annotate_opt(struct hist_browser *browser __maybe_unused,
+add_annotate_opt(struct hist_browser *browser,
 		 struct popup_action *act, char **optstr,
-		 struct map_symbol *ms)
+		 struct map_symbol *ms,
+		 u64 addr)
 {
-	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
-	    symbol__annotation(ms->sym)->src == NULL)
+	if (!ms->map || !ms->map->dso || ms->map->dso->annotate_warned)
+		return 0;
+
+	if (!ms->sym) {
+		ms->sym = new_annotate_sym(addr, ms->map,
+					   browser->annotation_opts);
+	}
+
+	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3219,17 +3253,20 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       &bi->from.ms);
+						       &bi->from.ms,
+						       bi->from.al_addr);
 			if (bi->to.ms.sym != bi->from.ms.sym)
 				nr_options += add_annotate_opt(browser,
 							&actions[nr_options],
 							&options[nr_options],
-							&bi->to.ms);
+							&bi->to.ms,
+							bi->to.al_addr);
 		} else {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       browser->selection);
+						       browser->selection,
+						       browser->he_selection->ip);
 		}
 skip_annotation:
 		nr_options += add_thread_opt(browser, &actions[nr_options],
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 455403e8fede..40ca4b58cd17 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -74,6 +74,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 #define ANNOTATION__CYCLES_WIDTH 6
 #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
 #define ANNOTATION__AVG_IPC_WIDTH 36
+#define ANNOTATION_DUMMY_LEN	256
 
 struct annotation_options {
 	bool hide_src_code,
@@ -97,6 +98,7 @@ struct annotation_options {
 	const char *prefix;
 	const char *prefix_strip;
 	unsigned int percent_type;
+	int  annotate_dummy_len;
 };
 
 enum {
-- 
2.17.1

