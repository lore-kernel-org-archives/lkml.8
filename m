Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CE9207D5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eDbD0YYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFCOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:16:43 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:37575 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193796; x=1622729796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Q95Imqm6D4GsRp4TGS1qrEUIPf92/YhKKGxjfjqdz5s=;
  b=eDbD0YYJzxl5IHLNfy4GgBvJxs/fDMpYz42218Fw2gGxv4JLTuLBp429
   LxgouLDE7qEScWwn/eIWLSZstIhi/dng4LsXYONk5xIknpEa0lc1S4co3
   21MLDhKJqXuuhzj4rArLT2+Xpsb5KdhBG94ShjG7WJPFrJBUenaHJ0CwQ
   Q=;
IronPort-SDR: lspKg3ajDh5Oo2wnIVCzaXvCQutKzWtGrcE+8aN0BzbvFkBGtmQ8EEl+hH5XyAVRNxqSDbBgCb
 HnYlj4rQ6KoA==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="35573782"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Jun 2020 14:16:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 01E29A27D2;
        Wed,  3 Jun 2020 14:16:29 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:16:29 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:16:13 +0000
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
Subject: [RFC v2 9/9] Docs/damon: Document physical memory monitoring support
Date:   Wed, 3 Jun 2020 16:11:35 +0200
Message-ID: <20200603141135.10575-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603141135.10575-1-sjpark@amazon.com>
References: <20200603141135.10575-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D45UWB002.ant.amazon.com (10.43.161.78) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds description for the physical memory monitoring usage in
the DAMON document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 42 ++++++++++++++------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 137ed770c2d6..359745f0dbfb 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -314,27 +314,42 @@ check it again::
 Target PIDs
 -----------
 
-Users can get and set the pids of monitoring target processes by reading from
-and writing to the ``pids`` file.  For example, below commands set processes
-having pids 42 and 4242 as the processes to be monitored and check it again::
+To monitor the virtual memory address spaces of specific processes, users can
+get and set the pids of monitoring target processes by reading from and writing
+to the ``pids`` file.  For example, below commands set processes having pids 42
+and 4242 as the processes to be monitored and check it again::
 
     # cd <debugfs>/damon
     # echo 42 4242 > pids
     # cat pids
     42 4242
 
+Users can also monitor the physical memory address space of the system by
+writing a special keyword, "``paddr\n``" to the file.  In this case, reading the
+file will show ``-1``, as below::
+
+    # cd <debugfs>/damon
+    # echo paddr > pids
+    # cat pids
+    -1
+
 Note that setting the pids doesn't start the monitoring.
 
 
 Initla Monitoring Target Regions
 --------------------------------
 
-DAMON automatically sets and updates the monitoring target regions so that
-entire memory mappings of target processes can be covered.  However, users
-might want to limit the monitoring region to specific address ranges, such as
-the heap, the stack, or specific file-mapped area.  Or, some users might know
-the initial access pattern of their workloads and therefore want to set optimal
-initial regions for the 'adaptive regions adjustment'.
+In case of the virtual memory monitoring, DAMON automatically sets and updates
+the monitoring target regions so that entire memory mappings of target
+processes can be covered.  However, users might want to limit the monitoring
+region to specific address ranges, such as the heap, the stack, or specific
+file-mapped area.  Or, some users might know the initial access pattern of
+their workloads and therefore want to set optimal initial regions for the
+'adaptive regions adjustment'.
+
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions in case of physical memory monitoring.  Therefore, users should set the
+monitoring target regions by themselves.
 
 In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
@@ -354,10 +369,11 @@ region of process 42, and another couple of address ranges, ``20-40`` and
             4242 20      40
             4242 50      100" > init_regions
 
-Note that this sets the initial monitoring target regions only.  DAMON will
-automatically updates the boundary of the regions after one ``regions update
-interval``.  Therefore, users should set the ``regions update interval`` large
-enough.
+Note that this sets the initial monitoring target regions only.  In case of
+virtual memory monitoring, DAMON will automatically updates the boundary of the
+regions after one ``regions update interval``.  Therefore, users should set the
+``regions update interval`` large enough in this case, if they don't want the
+update.
 
 
 Record
-- 
2.17.1

