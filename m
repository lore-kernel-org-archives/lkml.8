Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60869C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3806920714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="llAXAobl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgBYKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:25:55 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:38138 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgBYKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582626354; x=1614162354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SBNXt18fiSDkKKFTHL/6fBU1JbEP1Jnn1oHT/2Qkjhc=;
  b=llAXAoblaH989jWHXuhP8RENMXwTjEbgCasvoBG/uku6AClmCKsE/ZIa
   y4xbP/NCqjyBF0u1spAKV+lXccRTZSaiWg9gpWseX+WnYMROGko5BwCHs
   +IoenAv3hn5BuAa9ILW1gIdk49lxyCxVJIJUdNh1wwtBU5zOk38a16OMY
   8=;
IronPort-SDR: c1MTE6zIDsERP/BMd3ciZjJLwc1BK/AFz+nddmSExjM4R59h+QVfYXDT8uBjP+/NwrlmNNO5iq
 2rJjWWTD1niQ==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="27313402"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Feb 2020 10:25:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id BCFF124622A;
        Tue, 25 Feb 2020 10:25:41 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 10:25:40 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 10:25:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 5/7] mm/damon-test: Add kunit test case for regions age accounting
Date:   Tue, 25 Feb 2020 11:22:58 +0100
Message-ID: <20200225102300.23895-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225102300.23895-1-sjpark@amazon.com>
References: <20200225102300.23895-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

After merges of regions, each region should know their last shape in
proper way to measure the changes from the last modification and reset
the age if the changes are significant.  This commit adds kunit test
cases checking whether the regions are knowing their last shape properly
after merges of regions.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index c7dc21325c77..2ba757357211 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -540,6 +540,8 @@ static void damon_test_merge_regions_of(struct kunit *test)
 
 	unsigned long saddrs[] = {0, 114, 130, 156, 170};
 	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	unsigned long lsa[] = {0, 114, 130, 156, 184};
+	unsigned long lea[] = {100, 122, 156, 170, 230};
 	int i;
 
 	t = damon_new_task(42);
@@ -556,6 +558,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		r = damon_nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->last_vm_start, lsa[i]);
+		KUNIT_EXPECT_EQ(test, r->last_vm_end, lea[i]);
+
 	}
 	damon_free_task(t);
 }
-- 
2.17.1

