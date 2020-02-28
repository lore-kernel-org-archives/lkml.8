Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79535C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC2A24677
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgB1Nw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:52:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:23007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgB1Nwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:52:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:52:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242383294"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 05:52:51 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/13] perf kcore_copy: Fix module map when there are no modules loaded
Date:   Fri, 28 Feb 2020 15:51:21 +0200
Message-Id: <20200228135125.567-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135125.567-1-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of any modules, no "modules" map is created, but there are
other executable pages to map, due to eBPF JIT, kprobe or ftrace. Map them
by recognizing that the first "module" symbol is not necessarily from a
module, and adjust the map accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1965aefccb02..3df77b56e28a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1452,6 +1452,7 @@ struct kcore_copy_info {
 	u64 first_symbol;
 	u64 last_symbol;
 	u64 first_module;
+	u64 first_module_symbol;
 	u64 last_module_symbol;
 	size_t phnum;
 	struct list_head phdrs;
@@ -1528,6 +1529,8 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 		return 0;
 
 	if (strchr(name, '[')) {
+		if (!kci->first_module_symbol || start < kci->first_module_symbol)
+			kci->first_module_symbol = start;
 		if (start > kci->last_module_symbol)
 			kci->last_module_symbol = start;
 		return 0;
@@ -1725,6 +1728,10 @@ static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
 		kci->etext += page_size;
 	}
 
+	if (kci->first_module_symbol &&
+	    (!kci->first_module || kci->first_module_symbol < kci->first_module))
+		kci->first_module = kci->first_module_symbol;
+
 	kci->first_module = round_down(kci->first_module, page_size);
 
 	if (kci->last_module_symbol) {
-- 
2.17.1

