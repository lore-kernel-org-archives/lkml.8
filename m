Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2020716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHMHJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:09:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:12772 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMHJa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:09:30 -0400
IronPort-SDR: 1Ekkrbjno9bvoS0GYgdlAWZakXyNq2f0zQKW6V2hADf88sN8u+zgQOMFaECFGcrqkAVMdAEQlp
 Lxr5EptZlqXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="142012455"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="142012455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 00:09:29 -0700
IronPort-SDR: Lkmox1joMNeEgxcnKkXPiREXEoCTYDozJEdolZK2bynEQvCQlJklWzVjzCt7V7CmI+bGpVoGVw
 BUb10yKDpeEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="333032638"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2020 00:09:26 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, like.xu@linux.intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf parse-events: Set exclude_guest for user-space counting
Date:   Thu, 13 Aug 2020 15:09:11 +0800
Message-Id: <20200813070911.26477-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if we run 'perf record -e cycles:u', exclude_guest is 0.

But it doesn't make sense that we request for user-space counting
but we also get the guest report.

To keep perf semantics consistent and clear, this patch sets
exclude_guest for user-space counting.

Before:

  perf record -e cycles:u ./div
  perf evlist -v
  cycles:u: ..., exclude_kernel: 1, exclude_hv: 1, ...

After:

  perf record -e cycles:u ./div
  perf evlist -v
  cycles:u: ..., exclude_kernel: 1, exclude_hv: 1,  exclude_guest: 1, ...

perf test 6
 6: Parse event definition strings             : Ok

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v2:
 ---
 Fix the 'perf test 6' failure.

 tools/perf/tests/parse-events.c | 4 ++--
 tools/perf/util/parse-events.c  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7f9f87a470c3..aae0fd9045c1 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -719,7 +719,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -842,7 +842,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
+	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9f7260e69113..4d809f1fe269 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1794,6 +1794,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 		if (*str == 'u') {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
+			if (!exclude_GH)
+				eG = 1;
 			eu = 0;
 		} else if (*str == 'k') {
 			if (!exclude)
-- 
2.17.1

