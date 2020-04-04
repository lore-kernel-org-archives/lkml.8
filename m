Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB54CC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F020752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDDImx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgDDImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNb-0001L5-17; Sat, 04 Apr 2020 10:42:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B3DDE1C07EC;
        Sat,  4 Apr 2020 10:42:03 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:42:03 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf report: Support interactive annotation of
 code without symbols
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227043939.4403-3-yao.jin@linux.intel.com>
References: <20200227043939.4403-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598972330.28353.16120533898105990431.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7b0a0dcb64705d1dbed46d33c9810251667469b9
Gitweb:        https://git.kernel.org/tip/7b0a0dcb64705d1dbed46d33c9810251667469b9
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 27 Feb 2020 12:39:38 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 09:36:33 -03:00

perf report: Support interactive annotation of code without symbols

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

 v5:
 ---
 Remove the hotkey 'a' implementation from this patch. It
 will be moved to a separate patch.

 v4:
 ---
 1. Support the hotkey 'a'. When we press 'a' on address,
    now it supports the annotation.

 2. Change the patch title from
    "Support interactive annotation of code without symbols" to
    "perf report: Support interactive annotation of code without symbols"

 v3:
 ---
 Keep just the ANNOTATION_DUMMY_LEN, and remove the
 opts->annotate_dummy_len since it's the "maybe in future
 we will provide" feature.

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

Committer notes:

Renamed new_annotate_sym() to symbol__new_unresolved().

Use PRIx64 to fix this issue in some 32-bit arches:

  ui/browsers/hists.c: In function 'symbol__new_unresolved':
  ui/browsers/hists.c:2474:38: error: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
    snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
                                  ~~~~~~^                      ~~~~
                                  %-#.*llx

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200227043939.4403-3-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 43 ++++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h     |  1 +-
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f36dee4..d0f9745 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,13 +2465,41 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
+static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
+{
+	struct annotated_source *src;
+	struct symbol *sym;
+	char name[64];
+
+	snprintf(name, sizeof(name), "%.*" PRIx64, BITS_PER_LONG / 4, addr);
+
+	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
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
 add_annotate_opt(struct hist_browser *browser __maybe_unused,
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
+	if (!ms->sym)
+		ms->sym = symbol__new_unresolved(addr, ms->map);
+
+	if (ms->sym == NULL || symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3219,17 +3247,20 @@ do_hotkey:		 // key came straight from options ui__popup_menu()
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
index 07c7759..2d88069 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -74,6 +74,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
 #define ANNOTATION__CYCLES_WIDTH 6
 #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
 #define ANNOTATION__AVG_IPC_WIDTH 36
+#define ANNOTATION_DUMMY_LEN	256
 
 struct annotation_options {
 	bool hide_src_code,
