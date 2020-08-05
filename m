Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13337C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E597D22BF3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y4aBlbTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHEHCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:02:04 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:3222 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596610922; x=1628146922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IDHkic1gYAf9g3QrAFwx1LEoduynRqvj1VEruhEXvww=;
  b=Y4aBlbTCmdFmbXrzdxpCgdh6mwT9uP6RNo0xn3TTKb5j5Ui62+7gWATz
   cuAL3M5+S1upeKkxt7LahQijflR6nR5Dizrw6YKxrYmXJvXi/s3XjaFPf
   M+hFt+lFh95fiPJXmt62yGzHfq7OA5mkOPnKiZSyqXclcrEsjCrCaFQ34
   I=;
IronPort-SDR: VOSuVAQNmVmnkRJ33tHLZy+bz82TXYjhD5rE7LmDVaa7W/v0JRZaU5PfMH4CYfBt2B1lqgnwX6
 S1I3du9u8ZMg==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="46045920"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Aug 2020 07:02:00 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id DED04A2272;
        Wed,  5 Aug 2020 07:01:49 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:01:48 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:01:32 +0000
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 04/10] selftests/damon/_chk_record: Do not check number of gaps
Date:   Wed, 5 Aug 2020 08:59:45 +0200
Message-ID: <20200805065951.18221-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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

