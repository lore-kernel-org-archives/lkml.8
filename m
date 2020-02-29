Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF03C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0A5246D2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB2JRW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgB2JRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEw-0005py-Kr; Sat, 29 Feb 2020 10:16:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5252B1C2187;
        Sat, 29 Feb 2020 10:16:49 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:48 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Make perf config effective
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213064306.160480-6-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-6-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158296780897.28353.7011546647615002956.tip-bot2@tip-bot2>
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

Commit-ID:     7384083ba616092e62df7bfb4f2034730e631e40
Gitweb:        https://git.kernel.org/tip/7384083ba616092e62df7bfb4f2034730e631e40
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 13 Feb 2020 12:13:03 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 10:44:59 -03:00

perf annotate: Make perf config effective

perf default config set by user in [annotate] section is totally ignored
by annotate code. Fix it.

Before:

  $ ./perf config
  annotate.hide_src_code=true
  annotate.show_nr_jumps=true
  annotate.show_nr_samples=true

  $ ./perf annotate shash
         │    unsigned h = 0;
         │      movl   $0x0,-0xc(%rbp)
         │    while (*s)
         │    ↓ jmp    44
         │    h = 65599 * h + *s++;
   11.33 │24:   mov    -0xc(%rbp),%eax
   43.50 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

After:

         │        movl   $0x0,-0xc(%rbp)
         │      ↓ jmp    44
       1 │1 24:   mov    -0xc(%rbp),%eax
       4 │        imul   $0x1003f,%eax,%ecx
         │        mov    -0x18(%rbp),%rax

Note that we have removed show_nr_samples and show_total_period from
annotation_options because they are not used. Instead of them we use
symbol_conf.show_nr_samples and symbol_conf.show_total_period.

Committer testing:

Using 'perf annotate --stdio2' to use the TUI rendering but emitting the output to stdio:

  # perf config
  #
  # perf config annotate.hide_src_code=true
  # perf config
  annotate.hide_src_code=true
  #
  # perf config annotate.show_nr_jumps=true
  # perf config annotate.show_nr_samples=true
  # perf config
  annotate.hide_src_code=true
  annotate.show_nr_jumps=true
  annotate.show_nr_samples=true
  #
  #

Before:

  # perf annotate --stdio2 ObjectInstance::weak_pointer_was_finalized
  Samples: 1  of event 'cycles', 4000 Hz, Event count (approx.): 830873, [percent: local period]
  ObjectInstance::weak_pointer_was_finalized() /usr/lib64/libgjs.so.0.0.0
  Percent
              00000000000609f0 <ObjectInstance::weak_pointer_was_finalized()@@Base>:
                endbr64
                cmpq    $0x0,0x20(%rdi)
              ↓ je      10
                xor     %eax,%eax
              ← retq
                xchg    %ax,%ax
  100.00  10:   push    %rbp
                cmpq    $0x0,0x18(%rdi)
                mov     %rdi,%rbp
              ↓ jne     20
          1b:   xor     %eax,%eax
                pop     %rbp
              ← retq
                nop
          20:   lea     0x18(%rdi),%rdi
              → callq   JS_UpdateWeakPointerAfterGC(JS::Heap<JSObject*
                cmpq    $0x0,0x18(%rbp)
              ↑ jne     1b
                mov     %rbp,%rdi
              → callq   ObjectBase::jsobj_addr() const@plt
                mov     $0x1,%eax
                pop     %rbp
              ← retq
  #

After:

  # perf annotate --stdio2 ObjectInstance::weak_pointer_was_finalized 2> /dev/null
  Samples: 1  of event 'cycles', 4000 Hz, Event count (approx.): 830873, [percent: local period]
  ObjectInstance::weak_pointer_was_finalized() /usr/lib64/libgjs.so.0.0.0
  Samples       endbr64
                cmpq    $0x0,0x20(%rdi)
              ↓ je      10
                xor     %eax,%eax
              ← retq
                xchg    %ax,%ax
     1  1 10:   push    %rbp
                cmpq    $0x0,0x18(%rdi)
                mov     %rdi,%rbp
              ↓ jne     20
        1 1b:   xor     %eax,%eax
                pop     %rbp
              ← retq
                nop
        1 20:   lea     0x18(%rdi),%rdi
              → callq   JS_UpdateWeakPointerAfterGC(JS::Heap<JSObject*
                cmpq    $0x0,0x18(%rbp)
              ↑ jne     1b
                mov     %rbp,%rdi
              → callq   ObjectBase::jsobj_addr() const@plt
                mov     $0x1,%eax
                pop     %rbp
              ← retq
  #
  # perf config annotate.show_nr_jumps
  annotate.show_nr_jumps=true
  # perf config annotate.show_nr_jumps=false
  # perf config annotate.show_nr_jumps
  annotate.show_nr_jumps=false
  #
  # perf annotate --stdio2 ObjectInstance::weak_pointer_was_finalized 2> /dev/null
  Samples: 1  of event 'cycles', 4000 Hz, Event count (approx.): 830873, [percent: local period]
  ObjectInstance::weak_pointer_was_finalized() /usr/lib64/libgjs.so.0.0.0
  Samples       endbr64
                cmpq    $0x0,0x20(%rdi)
              ↓ je      10
                xor     %eax,%eax
              ← retq
                xchg    %ax,%ax
       1  10:   push    %rbp
                cmpq    $0x0,0x18(%rdi)
                mov     %rdi,%rbp
              ↓ jne     20
          1b:   xor     %eax,%eax
                pop     %rbp
              ← retq
                nop
          20:   lea     0x18(%rdi),%rdi
              → callq   JS_UpdateWeakPointerAfterGC(JS::Heap<JSObject*
                cmpq    $0x0,0x18(%rbp)
              ↑ jne     1b
                mov     %rbp,%rdi
              → callq   ObjectBase::jsobj_addr() const@plt
                mov     $0x1,%eax
                pop     %rbp
              ← retq
  #

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-6-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  2 +-
 tools/perf/builtin-report.c   |  2 +-
 tools/perf/builtin-top.c      |  2 +-
 tools/perf/util/annotate.c    | 78 ++++++++++++----------------------
 tools/perf/util/annotate.h    |  4 +--
 5 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ff61795..ea89077 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -605,7 +605,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init();
+	annotation_config__init(&annotate.opts);
 
 	symbol_conf.try_vmlinux_path = true;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9483b3f..72a12b6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1507,7 +1507,7 @@ repeat:
 			symbol_conf.priv_size += sizeof(u32);
 			symbol_conf.sort_by_name = true;
 		}
-		annotation_config__init();
+		annotation_config__init(&report.annotation_opts);
 	}
 
 	if (symbol__init(&session->header.env) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8affcab..cc26aea 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1683,7 +1683,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
-	annotation_config__init();
+	annotation_config__init(&top.annotation_opts);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f0741da..3b79da5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3094,66 +3094,46 @@ out_free_offsets:
 	return err;
 }
 
-#define ANNOTATION__CFG(n) \
-	{ .name = #n, .value = &annotation__default_options.n, }
-
-/*
- * Keep the entries sorted, they are bsearch'ed
- */
-static struct annotation_config {
-	const char *name;
-	void *value;
-} annotation__configs[] = {
-	ANNOTATION__CFG(hide_src_code),
-	ANNOTATION__CFG(jump_arrows),
-	ANNOTATION__CFG(offset_level),
-	ANNOTATION__CFG(show_linenr),
-	ANNOTATION__CFG(show_nr_jumps),
-	ANNOTATION__CFG(show_nr_samples),
-	ANNOTATION__CFG(show_total_period),
-	ANNOTATION__CFG(use_offset),
-};
-
-#undef ANNOTATION__CFG
-
-static int annotation_config__cmp(const void *name, const void *cfgp)
+static int annotation__config(const char *var, const char *value, void *data)
 {
-	const struct annotation_config *cfg = cfgp;
-
-	return strcmp(name, cfg->name);
-}
-
-static int annotation__config(const char *var, const char *value,
-			    void *data __maybe_unused)
-{
-	struct annotation_config *cfg;
-	const char *name;
+	struct annotation_options *opt = data;
 
 	if (!strstarts(var, "annotate."))
 		return 0;
 
-	name = var + 9;
-	cfg = bsearch(name, annotation__configs, ARRAY_SIZE(annotation__configs),
-		      sizeof(struct annotation_config), annotation_config__cmp);
-
-	if (cfg == NULL)
-		pr_debug("%s variable unknown, ignoring...", var);
-	else if (strcmp(var, "annotate.offset_level") == 0) {
-		perf_config_int(cfg->value, name, value);
-
-		if (*(int *)cfg->value > ANNOTATION__MAX_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MAX_OFFSET_LEVEL;
-		else if (*(int *)cfg->value < ANNOTATION__MIN_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MIN_OFFSET_LEVEL;
+	if (!strcmp(var, "annotate.offset_level")) {
+		perf_config_u8(&opt->offset_level, "offset_level", value);
+
+		if (opt->offset_level > ANNOTATION__MAX_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MAX_OFFSET_LEVEL;
+		else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else if (!strcmp(var, "annotate.hide_src_code")) {
+		opt->hide_src_code = perf_config_bool("hide_src_code", value);
+	} else if (!strcmp(var, "annotate.jump_arrows")) {
+		opt->jump_arrows = perf_config_bool("jump_arrows", value);
+	} else if (!strcmp(var, "annotate.show_linenr")) {
+		opt->show_linenr = perf_config_bool("show_linenr", value);
+	} else if (!strcmp(var, "annotate.show_nr_jumps")) {
+		opt->show_nr_jumps = perf_config_bool("show_nr_jumps", value);
+	} else if (!strcmp(var, "annotate.show_nr_samples")) {
+		symbol_conf.show_nr_samples = perf_config_bool("show_nr_samples",
+								value);
+	} else if (!strcmp(var, "annotate.show_total_period")) {
+		symbol_conf.show_total_period = perf_config_bool("show_total_period",
+								value);
+	} else if (!strcmp(var, "annotate.use_offset")) {
+		opt->use_offset = perf_config_bool("use_offset", value);
 	} else {
-		*(bool *)cfg->value = perf_config_bool(name, value);
+		pr_debug("%s variable unknown, ignoring...", var);
 	}
+
 	return 0;
 }
 
-void annotation_config__init(void)
+void annotation_config__init(struct annotation_options *opt)
 {
-	perf_config(annotation__config, NULL);
+	perf_config(annotation__config, opt);
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6237c2c..8e54184 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -83,8 +83,6 @@ struct annotation_options {
 	     full_path,
 	     show_linenr,
 	     show_nr_jumps,
-	     show_nr_samples,
-	     show_total_period,
 	     show_minmax_cycle,
 	     show_asm_raw,
 	     annotate_src;
@@ -413,7 +411,7 @@ static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 }
 #endif
 
-void annotation_config__init(void);
+void annotation_config__init(struct annotation_options *opt);
 
 int annotate_parse_percent_type(const struct option *opt, const char *_str,
 				int unset);
