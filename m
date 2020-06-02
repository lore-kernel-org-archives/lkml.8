Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEEFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9958A20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k8pfcQVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFBNQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:16:46 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:40667 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFBNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591103800; x=1622639800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=P84mRIQzKrwCVq5uxgHNtZN8HW/b5hkyeS6yj/UbW4A=;
  b=k8pfcQVKaxynOmaWqzv8axHToGYYcNBDiheOf/aYGc6vm1TK31tty3DV
   vDhLmY7688VfbLKLf2UtPLSpqbvAt9kgqEbly0CmKc4R8AT83uhCi8KuD
   n+aJYPxS0WhEgCsvXxlC6mmWTBaAhcbHT4j19iAfOTytnTtkRYM/ecWml
   s=;
IronPort-SDR: wi30j8U1jqV8InCQm0WcaBes5KBTq5/SBXhs4jATm1wktr0yLfUco/6IsfHVHfQiyciRKLRswq
 H/UL2SrbmKpA==
X-IronPort-AV: E=Sophos;i="5.73,464,1583193600"; 
   d="scan'208";a="34015768"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 02 Jun 2020 13:16:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 4B5F4A06A9;
        Tue,  2 Jun 2020 13:16:21 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:16:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:16:04 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 13/15] mm/damon-test: Add a kunit test for recording setup
Date:   Tue, 2 Jun 2020 15:15:49 +0200
Message-ID: <20200602131549.23617-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602130125.20467-1-sjpark@amazon.com>
References: <20200602130125.20467-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D41UWC001.ant.amazon.com (10.43.162.107) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds another unit test case for the recording setup.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon-test.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index cf715529ff64..5b18619efe72 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -137,6 +137,18 @@ static void damon_test_set_pids(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 }
 
+static void damon_test_set_recording(struct kunit *test)
+{
+	struct damon_ctx *ctx = &damon_user_ctx;
+
+	damon_set_recording(ctx, 4242, "foo.bar");
+	KUNIT_EXPECT_EQ(test, ctx->rbuf_len, 4242u);
+	KUNIT_EXPECT_STREQ(test, ctx->rfile_path, "foo.bar");
+	damon_set_recording(ctx, 42, "foo");
+	KUNIT_EXPECT_EQ(test, ctx->rbuf_len, 42u);
+	KUNIT_EXPECT_STREQ(test, ctx->rfile_path, "foo");
+}
+
 /*
  * Test damon_three_regions_in_vmas() function
  *
@@ -596,6 +608,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_tasks),
 	KUNIT_CASE(damon_test_regions),
 	KUNIT_CASE(damon_test_set_pids),
+	KUNIT_CASE(damon_test_set_recording),
 	KUNIT_CASE(damon_test_three_regions_in_vmas),
 	KUNIT_CASE(damon_test_aggregate),
 	KUNIT_CASE(damon_test_write_rbuf),
-- 
2.17.1

