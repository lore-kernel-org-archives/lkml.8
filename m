Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B49C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6AD2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgDVMTt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728873AbgDVMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B75C03C1AC;
        Wed, 22 Apr 2020 05:17:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREK2-0008C2-JI; Wed, 22 Apr 2020 14:17:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9BE971C0451;
        Wed, 22 Apr 2020 14:17:38 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:38 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf annotate: Add basic support for bpf_image
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, bjorn.topel@intel.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312195610.346362-16-jolsa@kernel.org>
References: <20200312195610.346362-16-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158755785814.28353.3367154762576190249.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3c29d4483e855b6ba5c6e35b0c81caad7d9e3984
Gitweb:        https://git.kernel.org/tip/3c29d4483e855b6ba5c6e35b0c81caad7d9e3984
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 12 Mar 2020 20:56:10 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:06 -03:00

perf annotate: Add basic support for bpf_image

Add the DSO_BINARY_TYPE__BPF_IMAGE dso binary type to recognize BPF
images that carry trampoline or dispatcher.

Upcoming patches will add support to read the image data, store it
within the BPF feature in perf.data and display it for annotation
purposes.

Currently we only display following message:

  # ./perf annotate bpf_trampoline_24456 --stdio
   Percent |      Source code & Disassembly of . for cycles (504  ...
  --------------------------------------------------------------- ...
           :       to be implemented

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: BjÃ¶rn TÃ¶pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200312195610.346362-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 20 ++++++++++++++++++++
 tools/perf/util/dso.c      |  1 +
 tools/perf/util/dso.h      |  1 +
 tools/perf/util/machine.c  | 11 +++++++++++
 tools/perf/util/symbol.c   |  1 +
 5 files changed, 34 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f1ea0d6..9760d58 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1821,6 +1821,24 @@ static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
 }
 #endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 
+static int
+symbol__disassemble_bpf_image(struct symbol *sym,
+			      struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl;
+
+	args->offset = -1;
+	args->line = strdup("to be implemented");
+	args->line_nr = 0;
+	dl = disasm_line__new(args);
+	if (dl)
+		annotation_line__add(&dl->al, &notes->src->source);
+
+	free(args->line);
+	return 0;
+}
+
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
@@ -1920,6 +1938,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
 		return symbol__disassemble_bpf(sym, args);
+	} else if (dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE) {
+		return symbol__disassemble_bpf_image(sym, args);
 	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 91f2123..f338990 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -191,6 +191,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b7..9553a1f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -40,6 +40,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
+	DSO_BINARY_TYPE__BPF_IMAGE,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 06aa4e4..09845ea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -736,6 +736,12 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int is_bpf_image(const char *name)
+{
+	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
+	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
+}
+
 static int machine__process_ksymbol_register(struct machine *machine,
 					     union perf_event *event,
 					     struct perf_sample *sample __maybe_unused)
@@ -760,6 +766,11 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
 		dso__set_loaded(dso);
+
+		if (is_bpf_image(event->ksymbol.name)) {
+			dso->binary_type = DSO_BINARY_TYPE__BPF_IMAGE;
+			dso__set_long_name(dso, "", false);
+		}
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 26bc6a0..8f43004 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1544,6 +1544,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		return true;
 
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
