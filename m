Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0703C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA44C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgELMT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgELMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:56 -0400
IronPort-SDR: Wg3sVnT2eKP2gVuYvwSk+YiT0bujfa/seb4n33L4JQLH7ajyfMVKxPSFJttGQc4VJKb9pOgPr3
 h/6920DMeDLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:56 -0700
IronPort-SDR: 8T1IEdlQ8RZnXVV/mkhQsJpOCob/T7roVU020XUCjdX2jOZj5XP12quPj2knxdz68XqjuwJBIG
 0LeVvShmYdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879372"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 12/15] perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
Date:   Tue, 12 May 2020 15:19:19 +0300
Message-Id: <20200512121922.8997-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_RECORD_KSYMBOL_TYPE_OOL marks an executable page. Create a map backed
only by memory, which will be populated as necessary by text poke events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h | 5 +++++
 tools/perf/util/dso.c                 | 3 +++
 tools/perf/util/dso.h                 | 1 +
 tools/perf/util/machine.c             | 6 ++++++
 tools/perf/util/map.c                 | 5 +++++
 tools/perf/util/map.h                 | 3 ++-
 tools/perf/util/symbol.c              | 1 +
 7 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index e5bee6c17b86..52ca2093831c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1049,6 +1049,11 @@ enum perf_event_type {
 enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	/*
+	 * Out of line code such as kprobe-replaced instructions or optimized
+	 * kprobes or ftrace trampolines.
+	 */
+	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
 };
 
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f338990e0fe6..e68e1375e3c0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -192,6 +192,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__JAVA_JIT:
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
@@ -882,6 +883,8 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		*ret = bpf_read(dso, cache_offset, cache->data);
+	else if (dso->binary_type == DSO_BINARY_TYPE__OOL)
+		*ret = DSO__DATA_CACHE_SIZE;
 	else
 		*ret = file_read(dso, machine, cache_offset, cache->data);
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 9553a1fd9e8a..42b3a278ac59 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -41,6 +41,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
 	DSO_BINARY_TYPE__BPF_IMAGE,
+	DSO_BINARY_TYPE__OOL,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c7282c01ee53..9120d7dc274f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -762,6 +762,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			return -ENOMEM;
 		}
 
+		if (event->ksymbol.ksym_type == PERF_RECORD_KSYMBOL_TYPE_OOL) {
+			map->dso->binary_type = DSO_BINARY_TYPE__OOL;
+			map->dso->data.file_size = event->ksymbol.len;
+			dso__set_loaded(map->dso);
+		}
+
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 53d96611e6a6..f9dc8c5493ea 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -267,6 +267,11 @@ bool __map__is_bpf_prog(const struct map *map)
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
+bool __map__is_ool(const struct map *map)
+{
+	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 067036e8970c..9e312ae2d656 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -147,11 +147,12 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
 bool __map__is_bpf_prog(const struct map *map);
+bool __map__is_ool(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
 	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
-	       !__map__is_bpf_prog(map);
+	       !__map__is_bpf_prog(map) && !__map__is_ool(map);
 }
 
 bool map__has_symbols(const struct map *map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 381da6b39f89..7725c83996f4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1559,6 +1559,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
 	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
-- 
2.17.1

