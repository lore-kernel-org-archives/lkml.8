Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB6C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E153120731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rwGGfwzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDGKBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:01:35 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:3794 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgDGKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586253694; x=1617789694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LEhvbl4WlekKWmbg/2lD8LPKggXeYFxSwkdByXNxcTk=;
  b=rwGGfwzLZqNucRrIzPUl/kTH1mNRA2YztQD4dWmq79WkorlBhswbYt3D
   2vHMKdPLnGHM1pkguxjCkUrRPCZc6v0cy2VfWHsPVntmVDJoHu+LIPwkf
   geCWEOklZRYrRqO+yVNBc5pEUTh/O3MiKLcZegX+QvGOWBtX8iAW1BXO6
   Y=;
IronPort-SDR: FS2sSDAGc/QhPftzcAtcMkwnaO8L70xDtSjbdKejFJRyWdo5veA3/Stth2Qy62M7pwDUqoCOLd
 DNAATJhSdXeg==
X-IronPort-AV: E=Sophos;i="5.72,353,1580774400"; 
   d="scan'208";a="25880856"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 07 Apr 2020 10:01:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 3A90CC5CF7;
        Tue,  7 Apr 2020 10:01:16 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:01:15 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.171) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Apr 2020 10:01:01 +0000
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
Subject: [RFC v6 1/7] mm/madvise: Export do_madvise() to external GPL modules
Date:   Tue, 7 Apr 2020 12:00:00 +0200
Message-ID: <20200407100007.3894-2-sjpark@amazon.com>
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

