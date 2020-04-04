Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B346CC2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9E20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDDImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgDDImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNB-0000yS-BG; Sat, 04 Apr 2020 10:41:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 051371C0483;
        Sat,  4 Apr 2020 10:41:44 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:43 -0000
From:   "tip-bot2 for Kemeng Shi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf symbols: Fix arm64 gap between kernel start
 and module end
Cc:     Kemeng Shi <shikemeng@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
References: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
MIME-Version: 1.0
Message-ID: <158598970362.28353.14113544312342122835.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     78886f3ed37e89a06c76b95be873573e27900979
Gitweb:        https://git.kernel.org/tip/78886f3ed37e89a06c76b95be873573e27900979
Author:        Kemeng Shi <shikemeng@huawei.com>
AuthorDate:    Mon, 30 Mar 2020 15:41:11 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf symbols: Fix arm64 gap between kernel start and module end

During execution of command 'perf report' in my arm64 virtual machine,
this error message is showed:

failed to process sample

__symbol__inc_addr_samples(860): ENOMEM! sym->name=__this_module,
    start=0x1477100, addr=0x147dbd8, end=0x80002000, func: 0

The error is caused with path:
cmd_report
 __cmd_report
  perf_session__process_events
   __perf_session__process_events
    ordered_events__flush
     __ordered_events__flush
      oe->deliver (ordered_events__deliver_event)
       perf_session__deliver_event
        machines__deliver_event
         perf_evlist__deliver_sample
          tool->sample (process_sample_event)
           hist_entry_iter__add
            iter->add_entry_cb(hist_iter__report_callback)
             hist_entry__inc_addr_samples
              symbol__inc_addr_samples
               __symbol__inc_addr_samples
                h = annotated_source__histogram(src, evidx) (NULL)

annotated_source__histogram failed is caused with path:
...
 hist_entry__inc_addr_samples
  symbol__inc_addr_samples
   symbol__hists
    annotated_source__alloc_histograms
     src->histograms = calloc(nr_hists, sizeof_sym_hist) (failed)

Calloc failed as the symbol__size(sym) is too huge. As show in error
message: start=0x1477100, end=0x80002000, size of symbol is about 2G.

This is the same problem as 'perf annotate: Fix s390 gap between kernel
end and module start (b9c0a64901d5bd)'. Perf gets symbol information from
/proc/kallsyms in __dso__load_kallsyms. A part of symbol in /proc/kallsyms
from my virtual machine is as follows:
 #cat /proc/kallsyms | sort
 ...
 ffff000001475080 d rpfilter_mt_reg      [ip6t_rpfilter]
 ffff000001475100 d $d   [ip6t_rpfilter]
 ffff000001475100 d __this_module        [ip6t_rpfilter]
 ffff000080080000 t _head
 ffff000080080000 T _text
 ffff000080080040 t pe_header
 ...

Take line 'ffff000001475100 d __this_module [ip6t_rpfilter]' as example.
The start and end of symbol are both set to ffff000001475100 in
dso__load_all_kallsyms. Then symbols__fixup_end will set the end of symbol
to next big address to ffff000001475100 in /proc/kallsyms, ffff000080080000
in this example. Then sizeof of symbol will be about 2G and cause the
problem.

The start of module in my machine is
 ffff000000a62000 t $x   [dm_mod]

The start of kernel in my machine is
 ffff000080080000 t _head

There is a big gap between end of module and begin of kernel if a samll
amount of memory is used by module. And the last symbol in module will
have a large address range as caotaining the big gap.

Give that the module and kernel text segment sequence may change in
the future, fix this by limiting range of last symbol in module and kernel
to 4K in arch arm64.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hewenliang <hewenliang4@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lore.kernel.org/lkml/33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com
[ refreshed the patch on current codebase, added string.h include as strchr() is used ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/Build     |  1 +-
 tools/perf/arch/arm64/util/machine.c | 27 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/machine.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 789956f..5c13438 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,4 +1,5 @@
 perf-y += header.o
+perf-y += machine.o
 perf-y += perf_regs.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
new file mode 100644
index 0000000..d41b27e
--- /dev/null
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include "debug.h"
+#include "symbol.h"
+
+/* On arm64, kernel text segment start at high memory address,
+ * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
+ * address, like 0xffff 0000 00ax xxxx. When only samll amount of
+ * memory is used by modules, gap between end of module's text segment
+ * and start of kernel text segment may be reach 2G.
+ * Therefore do not fill this gap and do not assign it to the kernel dso map.
+ */
+
+#define SYMBOL_LIMIT (1 << 12) /* 4K */
+
+void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
+{
+	if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
+			(strchr(p->name, '[') == NULL && strchr(c->name, '[')))
+		/* Limit range of last symbol in module and kernel */
+		p->end += SYMBOL_LIMIT;
+	else
+		p->end = c->start;
+	pr_debug4("%s sym:%s end:%#lx\n", __func__, p->name, p->end);
+}
