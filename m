Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB9EC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FFD24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN1JZXAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgB0Ncu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:32:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38714 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgB0Ncu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:32:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so3086260qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wpjy1F6FcGN+CIuu+Ew/36xJ6S3okm70/DTE7n3IWj0=;
        b=fN1JZXAaHofvsInFXmV4CQXiraRZlOnAxcT0cudNYdtHZSPdhTmfzKPnynyLLhby6N
         j6rS2GB45NVEd0bGOhNTFb3xKynxLC4JHaVTHIMRiV4xoKgs0d4TZh+dOFBDoIeDBVV9
         sJOz581/3Z3qP8p9pLRSh/VBBuo5+4upiiJH1fQtgUzGorfAQzc5g5Ywv6p+hkg+zrSD
         UirfPS3AvBAvBfE4ygEGJK4JI3M8sIbB0GF4oo+a97iK5gaNfE3kwgpO7ySq5RBYpd0Y
         ZzviRd3MS0boIafDvML1UshUjion6B5PKyEC2bjjdGohbkX0HuObKmDZTOcu5Hj0TeCa
         BYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wpjy1F6FcGN+CIuu+Ew/36xJ6S3okm70/DTE7n3IWj0=;
        b=lUmNa0z2ADpWsFF7jKHBlHljZ8+KIrSMHfexxnvHV8REZIk2mw/gT9ajP4OsWttOuV
         bQsfYaWMrV40blf2G+Jex84c7AtFV/JhrI8fZmPrGPicJH3YB9hg/OTVicvPpsbHpZND
         0dav8pudGQeesgy05N1ej5BYzdsSVSJkBOGx+KKpWyyz4VJwr7Ve8WrU0rYRwh9uW5BY
         3yokTQ/+k3GZr4jYdMVQCTUj1d+vWXVbvI8F3qkt8/wiNwk/2KcQdQXqh9PQAhv7+0P8
         DE4rh70iwb3+cF28keMYUxN52GpjzkPF3EOhWwW5ZI0rar7wUSoYnuZaaobLbq/RqKTk
         Ylew==
X-Gm-Message-State: APjAAAXslB1AOYkBtVcLImlY6KN+GQ3px32ECk9xl7WlmyAc+GzV0MQy
        oKYkxyhg2uC8wpmnOYH8gBo=
X-Google-Smtp-Source: APXvYqwwtdWH9bIy6+UsAj6oSuyiNuQkfFsONmj5EbbuuqfIH0ylnhQmxjYCtWsXcBnIY6ONjOV0RQ==
X-Received: by 2002:a05:620a:15b3:: with SMTP id f19mr5327399qkk.15.1582810369226;
        Thu, 27 Feb 2020 05:32:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i28sm3234414qtc.57.2020.02.27.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:32:48 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 98544403AD; Thu, 27 Feb 2020 10:32:45 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:32:45 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, xieyisheng1@huawei.com,
        alexey.budankov@linux.intel.com, treeze.taeung@gmail.com,
        adrian.hunter@intel.com, tmricht@linux.ibm.com,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] perf annotate: Make perf config effective
Message-ID: <20200227133245.GD9899@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200213064306.160480-6-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213064306.160480-6-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 13, 2020 at 12:13:03PM +0530, Ravi Bangoria escreveu:
> perf default config set by user in [annotate] section is totally
> ignored by annotate code. Fix it.
> 
> Before:
> 
>   $ ./perf config
>   annotate.hide_src_code=true
>   annotate.show_nr_jumps=true
>   annotate.show_nr_samples=true
> 
>   $ ./perf annotate shash
>          │    unsigned h = 0;
>          │      movl   $0x0,-0xc(%rbp)
>          │    while (*s)
>          │    ↓ jmp    44
>          │    h = 65599 * h + *s++;
>    11.33 │24:   mov    -0xc(%rbp),%eax
>    43.50 │      imul   $0x1003f,%eax,%ecx
>          │      mov    -0x18(%rbp),%rax
> 
> After:
> 
>          │        movl   $0x0,-0xc(%rbp)
>          │      ↓ jmp    44
>        1 │1 24:   mov    -0xc(%rbp),%eax
>        4 │        imul   $0x1003f,%eax,%ecx
>          │        mov    -0x18(%rbp),%rax
> 
> Note that we have removed show_nr_samples and show_total_period from
> annotation_options because they are not used. Instead of them we use
> symbol_conf.show_nr_samples and symbol_conf.show_total_period.

Cool, applied, and consider using --stdio2 to test such changes in the
future, as I did in a commiter notes section when applying this patch:


commit 8e63100473a16173a5cdd1f3ebc2bb986a8d1047
Author: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu Feb 13 12:13:03 2020 +0530

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
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
    Cc: Changbin Du <changbin.du@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Taeung Song <treeze.taeung@gmail.com>
    Cc: Thomas Richter <tmricht@linux.ibm.com>
    Cc: Yisheng Xie <xieyisheng1@huawei.com>
    Link: http://lore.kernel.org/lkml/20200213064306.160480-6-ravi.bangoria@linux.ibm.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ff61795a4d13..ea89077bb8e0 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -605,7 +605,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init();
+	annotation_config__init(&annotate.opts);
 
 	symbol_conf.try_vmlinux_path = true;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9483b3f0cae3..72a12b69f120 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1507,7 +1507,7 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.priv_size += sizeof(u32);
 			symbol_conf.sort_by_name = true;
 		}
-		annotation_config__init();
+		annotation_config__init(&report.annotation_opts);
 	}
 
 	if (symbol__init(&session->header.env) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8affcab75604..cc26aeab6a66 100644
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
index f0741daf94ef..3b79da595db6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3094,66 +3094,46 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
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
index 6237c2cc582d..8e54184b43dc 100644
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
