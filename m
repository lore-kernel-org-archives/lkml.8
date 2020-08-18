Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18805C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4002063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="daZjWWiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHRH0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:26:43 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:45680 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597735601; x=1629271601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aibriOLYHRMEMwE9Y2Udzz9CLQ41hY8QmqPUl8w9XOY=;
  b=daZjWWiGTYVebk6v+tA85bpo4uxc7vkCCnNcIewKfTPj0+uZT1JcYJ9A
   102/sGrYIcoWfKPntRIMVHNkpxNqXqagpamRAULgoLe3plUeiRq3nMYuE
   i5cwbsfN242hSsWZcxNi3oh4EAaszGntaChkziw7X8uU+l7OZruB4huQg
   o=;
X-IronPort-AV: E=Sophos;i="5.76,326,1592870400"; 
   d="scan'208";a="48499962"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Aug 2020 07:26:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id ACB9AA25F1;
        Tue, 18 Aug 2020 07:26:28 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:26:27 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:26:11 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v7 03/10] mm/damon-test: Add more unit tests for 'init_regions'
Date:   Tue, 18 Aug 2020 09:24:54 +0200
Message-ID: <20200818072501.30396-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818072501.30396-1-sjpark@amazon.com>
References: <20200818072501.30396-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D38UWB002.ant.amazon.com (10.43.161.171) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds more test cases for the new feature, 'init_regions'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon-test.h | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index 71413ffc1dcb..e67e8fb17eca 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -161,6 +161,58 @@ static void damon_test_set_recording(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, ctx->rfile_path, "foo");
 }
 
+static void damon_test_set_init_regions(struct kunit *test)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+	unsigned long ids[] = {1, 2, 3};
+	/* Each line represents one region in ``<target id> <start> <end>`` */
+	char * const valid_inputs[] = {"2 10 20\n 2   20 30\n2 35 45",
+		"2 10 20\n",
+		"2 10 20\n1 39 59\n1 70 134\n  2  20 25\n",
+		""};
+	/* Reading the file again will show sorted, clean output */
+	char * const valid_expects[] = {"2 10 20\n2 20 30\n2 35 45\n",
+		"2 10 20\n",
+		"1 39 59\n1 70 134\n2 10 20\n2 20 25\n",
+		""};
+	char * const invalid_inputs[] = {"4 10 20\n",	/* target not exists */
+		"2 10 20\n 2 14 26\n",		/* regions overlap */
+		"1 10 20\n2 30 40\n 1 5 8"};	/* not sorted by address */
+	char *input, *expect;
+	int i, rc;
+	char buf[256];
+
+	damon_set_targets(ctx, ids, 3);
+
+	/* Put valid inputs and check the results */
+	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
+		input = valid_inputs[i];
+		expect = valid_expects[i];
+
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, 0);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
+	}
+	/* Put invlid inputs and check the return error code */
+	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
+		input = invalid_inputs[i];
+		pr_info("input: %s\n", input);
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, -EINVAL);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
+	}
+
+	damon_set_targets(ctx, NULL, 0);
+}
+
 static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
 {
 	int i, j;
@@ -645,6 +697,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_regions),
 	KUNIT_CASE(damon_test_set_targets),
 	KUNIT_CASE(damon_test_set_recording),
+	KUNIT_CASE(damon_test_set_init_regions),
 	KUNIT_CASE(damon_test_three_regions_in_vmas),
 	KUNIT_CASE(damon_test_aggregate),
 	KUNIT_CASE(damon_test_write_rbuf),
-- 
2.17.1

