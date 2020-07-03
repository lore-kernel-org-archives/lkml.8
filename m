Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD40920748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgGCAnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:43:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:44080 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgGCAnQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:43:16 -0400
IronPort-SDR: nbIl1QTTtlJIsUzwnP8Gu+eJKM43RF7TdGqA3/NJBPf6GexnUL5Kp13c9V1l8pN8e5nYKNizBu
 gTl4vbD7Aesw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="165119489"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="165119489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 17:43:15 -0700
IronPort-SDR: +3BATNlpnb2LhdaxdKRXQ83hMGdtC/P2mVh6XB5Up5u23Hh6dO5qDqdPK/s72/zJvMJyE5gAJA
 qXkHLfcIJ1vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="356619200"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by orsmga001.jf.intel.com with ESMTP; 02 Jul 2020 17:43:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user for dummy event
Date:   Fri,  3 Jul 2020 08:42:15 +0800
Message-Id: <20200703004215.24418-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
a dummy event is added to capture mmaps.

But if we run perf-record as,

 # perf record -e cycles:p -IXMM0 -a -- sleep 1
 Error:
 dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

The issue is, if we enable the extended regs (-IXMM0), but the
pmu->capabilities is not set with PERF_PMU_CAP_EXTENDED_REGS, the kernel
will return -EOPNOTSUPP error.

See following code pieces.

/* in kernel/events/core.c */
static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)

{
	....
	if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
	    has_extended_regs(event))
		ret = -EOPNOTSUPP;
	....
}

For software dummy event, the PMU should be not set with
PERF_PMU_CAP_EXTENDED_REGS. But unfortunately in current code, the dummy
event has possibility to be set with PERF_REG_EXTENDED_MASK bit.

In evsel__config, /* tools/perf/util/evsel.c */

if (opts->sample_intr_regs) {
	attr->sample_regs_intr = opts->sample_intr_regs;
}

If we use -IXMM0, the attr>sample_regs_intr will be set with
PERF_REG_EXTENDED_MASK bit.

It doesn't make sense to set attr->sample_regs_intr for a
software dummy event.

This patch adds dummy event checking before setting
attr->sample_regs_intr.

After:
  # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]

Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 96e5171dce41..df3315543e86 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1020,12 +1020,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
 		evsel__config_callchain(evsel, opts, callchain);
 
-	if (opts->sample_intr_regs) {
+	if (opts->sample_intr_regs && !is_dummy_event(evsel)) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
-	if (opts->sample_user_regs) {
+	if (opts->sample_user_regs && !is_dummy_event(evsel)) {
 		attr->sample_regs_user |= opts->sample_user_regs;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
-- 
2.17.1

