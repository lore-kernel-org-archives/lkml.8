Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF03FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84A620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F2bbG169"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbgEZH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:59:48 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3334 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgEZH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590479988; x=1622015988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LEhvbl4WlekKWmbg/2lD8LPKggXeYFxSwkdByXNxcTk=;
  b=F2bbG169JW7Utoqh9wgevuGSQw7JWceoZOVgUxJqmUZ6mQ8CqxxnBZiF
   PvLqa/QDcQizNW7XO5y5mzBJPXVqAvxtJD9IJTaVCIZOXAITPfFUm/P72
   MKiYTr5KEhmCRTAd04J7lcccRAZQMftazZJSVgihb6z/NXCTKjuiCuHrQ
   o=;
IronPort-SDR: LOpKn3M2VH6hNIBbwCFvhiT1EbytfGxI37xk+otEr8NbtXWyHib+fIK4LbLs5ZFzcjDQ5pXlVt
 T9hkA7hKCD4A==
X-IronPort-AV: E=Sophos;i="5.73,436,1583193600"; 
   d="scan'208";a="45914243"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 May 2020 07:59:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id DEE65A1C0C;
        Tue, 26 May 2020 07:59:32 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 07:59:28 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.193) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 07:59:13 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v9 1/8] mm/madvise: Export do_madvise() to external GPL modules
Date:   Tue, 26 May 2020 09:56:55 +0200
Message-ID: <20200526075702.27339-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526075702.27339-1-sjpark@amazon.com>
References: <20200526075702.27339-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D08UWB004.ant.amazon.com (10.43.161.232) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'do_madvise()' to external GPL modules, so that
other modules including DAMON could use the function.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 80f8a1839f70..151aaf285cdd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1151,6 +1151,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(do_madvise);
 
 SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 {
-- 
2.17.1

