Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14361206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbgEYG6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:58:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:17380 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388630AbgEYG6H (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:58:07 -0400
IronPort-SDR: 5f65d+BryoAuAMlZ9nMSZ4vL8eD2UlBXqLdC7MJYcu3togVZkHfEOYQWulpoX+nVQPBBoaCpzI
 SCSonPWCMSsg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 23:58:07 -0700
IronPort-SDR: gklREQERGomyzYADS7zJT/xHygC0pkBu77JIk0mbYrbBH4g1NftadG90NZqGVk9Zc9f2nrqcHT
 MYA5BEXmEYIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="290784924"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2020 23:58:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf test: Add test case for group members
Date:   Mon, 25 May 2020 14:55:59 +0800
Message-Id: <20200525065559.6422-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525065559.6422-1-yao.jin@linux.intel.com>
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evlist may consist of some event + group combinations.

For example, perf stat -e "A,{B,C},D".

This patch testes the event in evlist to see if it has the
correct leader and correct nr_members.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/tests/parse-events.c | 35 ++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 895188b63f96..d584b77c878d 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1386,6 +1386,34 @@ static int test__sym_event_dc(struct evlist *evlist)
 	return 0;
 }
 
+static int test__mixed_group(struct evlist *evlist)
+{
+	struct evsel *evsel, *leader;
+
+	TEST_ASSERT_VAL("wrong number of entries", 4 == evlist->core.nr_entries);
+
+	/* cycles - leader is also itself */
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong nr_members", 0 == evsel->core.nr_members);
+
+	/* {cache-misses,branch-misses} - leader is cache-misses */
+	evsel = leader = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong nr_members", 2 == evsel->core.nr_members);
+
+	evsel = evsel__next(evsel);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong nr_members", 0 == evsel->core.nr_members);
+
+	/* instructions - leader is also itself */
+	evsel = leader = evlist__first(evlist);
+	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
+	TEST_ASSERT_VAL("wrong nr_members", 0 == evsel->core.nr_members);
+
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1737,7 +1765,12 @@ static struct evlist_test test__events[] = {
 		.name  = "cycles:k",
 		.check = test__sym_event_dc,
 		.id    = 55,
-	}
+	},
+	{
+		.name  = "cycles,{cache-misses,branch-misses},instructions",
+		.check = test__mixed_group,
+		.id    = 56,
+	},
 };
 
 static struct evlist_test test__events_pmu[] = {
-- 
2.17.1

