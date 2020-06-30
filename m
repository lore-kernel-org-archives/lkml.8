Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D320675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgF3NkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:40:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:31774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbgF3NkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:40:16 -0400
IronPort-SDR: QXk1B417Zw9MSA9cPb0kTYE6qrtbJ4f0lmMj2q9LeAc/YMFUl5Vohw097wDGHM0XEpKqP5Euun
 NRBParKNd/pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145302176"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="145302176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:40:15 -0700
IronPort-SDR: y6eBT4xEjJ2Z85sJb6xs7/KFvbutpwcKoxkePjqb3fHAd0bE3ruKKEb+XnrHJPtqttkNztYY9o
 DqzV6GVwMuIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="425207190"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 06:40:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 1/3] perf intel-pt: Fix recording PEBS-via-PT with registers
Date:   Tue, 30 Jun 2020 16:39:33 +0300
Message-Id: <20200630133935.11150-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630133935.11150-1-adrian.hunter@intel.com>
References: <20200630133935.11150-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When recording PEBS-via-PT, the kernel will not accept the intel_pt event
with register sampling e.g.

 # perf record --kcore -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
 Error:
 intel_pt/branch=0/: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

Fix by suppressing register sampling on the intel_pt evsel.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9e64cefe4335b ("perf intel-pt: Process options for PEBS event synthesis")
---
 tools/perf/arch/x86/util/intel-pt.c | 1 +
 tools/perf/util/evsel.c             | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 839ef52c1ac2..6ce451293634 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -641,6 +641,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->no_aux_samples = true;
 			intel_pt_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a68ac3632ae6..ef802f6d40c1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1014,12 +1014,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
 		evsel__config_callchain(evsel, opts, callchain);
 
-	if (opts->sample_intr_regs) {
+	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
-	if (opts->sample_user_regs) {
+	if (opts->sample_user_regs && !evsel->no_aux_samples) {
 		attr->sample_regs_user |= opts->sample_user_regs;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
-- 
2.17.1

