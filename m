Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01298C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F082077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgDAKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgDAKRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:40 -0400
IronPort-SDR: YdKX+08BcjmBm6a4mXEmHLv7rbASpkOyi6ZJHsq2HOOFuQoySWv8tiJBvQW7uSrjSdlwwNSf76
 cKQpSTxSJfgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:39 -0700
IronPort-SDR: ZIr5R7cgFCG/dxli9sUlOXUQ2GkKztPMvSgpXr43e8VQ5051ig4KVhEPm+VKopvqkpM8Kov6SP
 NIy8SaaPkruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925498"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 04/16] perf arm-spe: Implement ->evsel_is_auxtrace() callback
Date:   Wed,  1 Apr 2020 13:16:01 +0300
Message-Id: <20200401101613.6201-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
---
 tools/perf/util/arm-spe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 53be12b23ff4..b30cc74d0fb4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -176,6 +176,15 @@ static void arm_spe_free(struct perf_session *session)
 	free(spe);
 }
 
+static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+					     auxtrace);
+
+	return evsel->core.attr.type == spe->pmu_type;
+}
+
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
@@ -218,6 +227,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.flush_events = arm_spe_flush;
 	spe->auxtrace.free_events = arm_spe_free_events;
 	spe->auxtrace.free = arm_spe_free;
+	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
 	arm_spe_print_info(&auxtrace_info->priv[0]);
-- 
2.17.1

