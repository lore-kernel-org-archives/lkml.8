Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5B20658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLMve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:51:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:63674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgBLMvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:51:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237702589"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 04:51:28 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/13] perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
Date:   Wed, 12 Feb 2020 14:49:48 +0200
Message-Id: <20200212124949.3589-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212124949.3589-1-adrian.hunter@intel.com>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_RECORD_KSYMBOL_TYPE_OOL marks an executable page. Create a map backed
only by memory, which will populated as necessary by text poke events.

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
index bae9e9d2d897..f80ce2e9f8b9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1031,6 +1031,11 @@ enum perf_event_type {
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
index 91f21239608b..9eb50ff6da96 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -191,6 +191,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
 	case DSO_BINARY_TYPE__JAVA_JIT:
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 		ret = -1;
 		break;
@@ -881,6 +882,8 @@ static struct dso_cache *dso_cache__populate(struct dso *dso,
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
 		*ret = bpf_read(dso, cache_offset, cache->data);
+	else if (dso->binary_type == DSO_BINARY_TYPE__OOL)
+		*ret = DSO__DATA_CACHE_SIZE;
 	else
 		*ret = file_read(dso, machine, cache_offset, cache->data);
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2db64b79617a..b482453bc3d1 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -40,6 +40,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__GUEST_KCORE,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BPF_PROG_INFO,
+	DSO_BINARY_TYPE__OOL,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c2825aaf3927..c7bb1aa81f3e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -730,6 +730,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		if (!map)
 			return -ENOMEM;
 
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
index f67960bedebb..4ec8cfd3967e 100644
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
index 3b379b1296f1..deb7f9bee3af 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1537,6 +1537,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		return true;
 
 	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__OOL:
 	case DSO_BINARY_TYPE__NOT_FOUND:
 	default:
 		return false;
-- 
2.17.1

