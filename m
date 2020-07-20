Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5263C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DA62250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGTBBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:01:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:57743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgGTBBZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:01:25 -0400
IronPort-SDR: KX4oMZDfJaA0DE3gvvUnMWrNIUIiyleZ4fcwDhJ66pUNwMgLdVZS/inKWyCMasYU/O3ckfgp6d
 p7ZuQY0f+p0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="147794510"
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="147794510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2020 18:01:24 -0700
IronPort-SDR: 5RjyWleyqjZxby5dn7u5oLQX4oF+jAuWMu0S0SMrVF7v121GpFQteB1Zc7BSfsckFI8/R/LVJl
 B1g35I6FoOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,373,1589266800"; 
   d="scan'208";a="319363759"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jul 2020 18:01:21 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf evsel: Don't set sample_regs_intr/sample_regs_user for dummy event
Date:   Mon, 20 Jul 2020 09:00:13 +0800
Message-Id: <20200720010013.18238-1-yao.jin@linux.intel.com>
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

See following code:

/* in kernel/events/core.c */
static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)

{
        ....
        if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
            has_extended_regs(event))
                ret = -EOPNOTSUPP;
        ....
}

For software dummy event, the PMU should not be set with
PERF_PMU_CAP_EXTENDED_REGS. But unfortunately now, the dummy
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
attr->sample_regs_intr and attr->sample_regs_user.

After:
  # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]

 v2:
 ---
 Rebase to perf/core

Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9aa51a65593d..11794d3b7879 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1014,12 +1014,14 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
 		evsel__config_callchain(evsel, opts, callchain);
 
-	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
+	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
+	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
 		evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
-	if (opts->sample_user_regs && !evsel->no_aux_samples) {
+	if (opts->sample_user_regs && !evsel->no_aux_samples &&
+	    !evsel__is_dummy_event(evsel)) {
 		attr->sample_regs_user |= opts->sample_user_regs;
 		evsel__set_sample_bit(evsel, REGS_USER);
 	}
-- 
2.17.1

