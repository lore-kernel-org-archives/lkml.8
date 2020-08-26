Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF36C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EED20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598477444;
	bh=Mdh/uob6URxySyRHxrRvur9qhtL893eouBRnVJlaukA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y/6JpGvc1CBoBeystRZUJgvNyZO1LhTxu0t2lVgcFufZmPeuTv3TCaplFA+jz6z+v
	 WMLQ6+nZOKkrrGdIdJXUl5TI9uiSRwSkvxDhgp2FXDuf1MVCdYpcEc4HMqMSTRlWmE
	 i1u/BqkqAOrAN0gDBso5sZLuw60j0mRyK2VEOdz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHZVan convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:30:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726753AbgHZVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:30:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Zs2im0ktOzWu__BFaEW2Sw-1; Wed, 26 Aug 2020 17:30:33 -0400
X-MC-Unique: Zs2im0ktOzWu__BFaEW2Sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B36F873116;
        Wed, 26 Aug 2020 21:30:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2D350B3F;
        Wed, 26 Aug 2020 21:30:26 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf tools: Add bpf image check to __map__is_kmodule
Date:   Wed, 26 Aug 2020 23:30:17 +0200
Message-Id: <20200826213017.818788-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When validating kcore modules the do_validate_kcore_modules
function checks on every kernel module dso against modules
record. The __map__is_kmodule check is used to get only
kernel module dso objects through.

Currently the bpf images are slipping through the check and
making the validation to fail, so report falls back from kcore
usage to kallsyms.

Adding __map__is_bpf_image check for bpf image and adding
it to __map__is_kmodule check.

Fixes: 3c29d4483e85 ("perf annotate: Add basic support for bpf_image")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c |  6 ------
 tools/perf/util/map.c     | 16 ++++++++++++++++
 tools/perf/util/map.h     |  9 ++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 208b813e00ea..85587de027a5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -736,12 +736,6 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static int is_bpf_image(const char *name)
-{
-	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
-	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
-}
-
 static int machine__process_ksymbol_register(struct machine *machine,
 					     union perf_event *event,
 					     struct perf_sample *sample __maybe_unused)
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 1d7210804639..cc0faf8f1321 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -267,6 +267,22 @@ bool __map__is_bpf_prog(const struct map *map)
 	return name && (strstr(name, "bpf_prog_") == name);
 }
 
+bool __map__is_bpf_image(const struct map *map)
+{
+	const char *name;
+
+	if (map->dso->binary_type == DSO_BINARY_TYPE__BPF_IMAGE)
+		return true;
+
+	/*
+	 * If PERF_RECORD_KSYMBOL is not included, the dso will not have
+	 * type of DSO_BINARY_TYPE__BPF_IMAGE. In such cases, we can
+	 * guess the type based on name.
+	 */
+	name = map->dso->short_name;
+	return name && is_bpf_image(name);
+}
+
 bool __map__is_ool(const struct map *map)
 {
 	return map->dso && map->dso->binary_type == DSO_BINARY_TYPE__OOL;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 9e312ae2d656..c2f5d28fe73a 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -147,12 +147,14 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name,
 bool __map__is_kernel(const struct map *map);
 bool __map__is_extra_kernel_map(const struct map *map);
 bool __map__is_bpf_prog(const struct map *map);
+bool __map__is_bpf_image(const struct map *map);
 bool __map__is_ool(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
 	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map) &&
-	       !__map__is_bpf_prog(map) && !__map__is_ool(map);
+	       !__map__is_bpf_prog(map) && !__map__is_ool(map) &&
+	       !__map__is_bpf_image(map);
 }
 
 bool map__has_symbols(const struct map *map);
@@ -164,4 +166,9 @@ static inline bool is_entry_trampoline(const char *name)
 	return !strcmp(name, ENTRY_TRAMPOLINE_NAME);
 }
 
+static inline bool is_bpf_image(const char *name)
+{
+	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
+	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
+}
 #endif /* __PERF_MAP_H */
-- 
2.25.4

