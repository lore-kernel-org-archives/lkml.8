Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84172C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593D2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W36zoldO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgHaKtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:49:33 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:41044 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598870969; x=1630406969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IDHkic1gYAf9g3QrAFwx1LEoduynRqvj1VEruhEXvww=;
  b=W36zoldOZS3F37t67SxARmTJLcm8VbAIBqGZuLTz+vqbx1g+/Azs031l
   9KOgI/9B8fcdxXJ7bmnPxK5+W2P2myXnw2/gJ5LttsDGrJqhn0iE2SAub
   kWkh7eblF4PNYhbo1DYkqb5yMuliT0WCUxksz1gBaPbXkU9Flqj0rICd8
   I=;
X-IronPort-AV: E=Sophos;i="5.76,375,1592870400"; 
   d="scan'208";a="50991436"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 31 Aug 2020 10:49:25 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id DFDA2A218C;
        Mon, 31 Aug 2020 10:49:13 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.100) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 10:48:56 +0000
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
Subject: [RFC v8 04/10] selftests/damon/_chk_record: Do not check number of gaps
Date:   Mon, 31 Aug 2020 12:47:24 +0200
Message-ID: <20200831104730.28970-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831104730.28970-1-sjpark@amazon.com>
References: <20200831104730.28970-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D49UWB002.ant.amazon.com (10.43.163.68) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Now the regions can be explicitly set as users want.  Therefore checking
the number of gaps doesn't make sense.  Remove the condition.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/_chk_record.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/damon/_chk_record.py b/tools/testing/selftests/damon/_chk_record.py
index 73e128904319..5f11be64abed 100644
--- a/tools/testing/selftests/damon/_chk_record.py
+++ b/tools/testing/selftests/damon/_chk_record.py
@@ -37,12 +37,9 @@ def chk_task_info(f):
         print('too many regions: %d > %d' % (nr_regions, max_nr_regions))
         exit(1)
 
-    nr_gaps = 0
     eaddr = 0
     for r in range(nr_regions):
         saddr = struct.unpack('L', f.read(8))[0]
-        if eaddr and saddr != eaddr:
-            nr_gaps += 1
         eaddr = struct.unpack('L', f.read(8))[0]
         nr_accesses = struct.unpack('I', f.read(4))[0]
 
@@ -56,9 +53,6 @@ def chk_task_info(f):
                 print('too high nr_access: expected %d but %d' %
                         (max_nr_accesses, nr_accesses))
                 exit(1)
-    if nr_gaps != 2:
-        print('number of gaps are not two but %d' % nr_gaps)
-        exit(1)
 
 def parse_time_us(bindat):
     sec = struct.unpack('l', bindat[0:8])[0]
-- 
2.17.1

