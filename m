Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8DDC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AFD2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZKVDUsc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgDGKDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:03:08 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20136 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGKDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586253786; x=1617789786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=C3a0ef6a18hPts2wj/nlFM3bY0Fh11hq6Un7xfBBjdc=;
  b=ZKVDUsc5RAbCnsfGiZQqNFbfcIxh+14uf/FH4qfmQoFxHz32dtnO9uPX
   zHD6D0VGdTUIsaeGziK6MtmzP7/6/b/QdCyaCXa7BCfmlO07Qr0LUCsqf
   e5bb0xEZK9oFw1riPFkmnBIqWvRmgP82jH9H0VSQ1qK4tOPFkUohYn/Wb
   w=;
IronPort-SDR: +yp07F8D8M4d2yM2xdEW8abMijFYro2/BxtDuw7K+CY+YzQ253f/2mp6Lg9vMj78dEYUe1ZI5h
 fnJNBt9RjRYw==
X-IronPort-AV: E=Sophos;i="5.72,353,1580774400"; 
   d="scan'208";a="35693334"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Apr 2020 10:03:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 966DFA1F80;
        Tue,  7 Apr 2020 10:03:00 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:03:00 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.171) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:02:46 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v6 5/7] mm/damon-test: Add kunit test case for regions age accounting
Date:   Tue, 7 Apr 2020 12:00:04 +0200
Message-ID: <20200407100007.3894-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407100007.3894-1-sjpark@amazon.com>
References: <20200407100007.3894-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D34UWA002.ant.amazon.com (10.43.160.245) To
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/damon-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index 2b6b1fee928d..af6a1e84b8eb 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -538,6 +538,8 @@ static void damon_test_merge_regions_of(struct kunit *test)
 
 	unsigned long saddrs[] = {0, 114, 130, 156, 170};
 	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	unsigned long lsa[] = {0, 114, 130, 156, 184};
+	unsigned long lea[] = {100, 122, 156, 170, 230};
 	int i;
 
 	t = damon_new_task(42);
@@ -554,6 +556,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
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

