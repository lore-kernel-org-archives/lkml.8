Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37488C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1761120775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="G5URi8l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGGOsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:48:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28487 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgGGOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133332; x=1625669332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Qc9whmri0AG1b7Tn1mnONsKzQtWP3wUxU6BN9M8YXo0=;
  b=G5URi8l2B6R153n8vZN1Q4fPhitmOnWoI+3Sd85+wMDlgbJRJFeo7Dku
   u2bYhsV6ZWlq1y9iUgH/pszz8Knh2bZ9E/Z8T4qJ9noTppDgWMemMxhM6
   lZCxT9IaORaiThkhbZM9vQtMrm7NQmgNHQcd3AMTiLVOPNRVWUO5X5ZlY
   8=;
IronPort-SDR: irG6a8phksdfbHXmB70v1Eim+j8f72r7wvvbFAQyNeGzvhe3WlBhWo3uIoJ7l40e3nbVYpDHl5
 I3WEfnPKbK6g==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="40494985"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 07 Jul 2020 14:48:22 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id C1278A24EA;
        Tue,  7 Jul 2020 14:48:21 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:48:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:48:01 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 05/11] Docs/damon: Document 'initial_regions' feature
Date:   Tue, 7 Jul 2020 16:45:34 +0200
Message-ID: <20200707144540.21216-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit documents the 'initial_regions' feature.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 153f07da9368..573fcb4c57a7 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -315,6 +315,41 @@ having pids 42 and 4242 as the processes to be monitored and check it again::
 Note that setting the pids doesn't start the monitoring.
 
 
+Initial Monitoring Target Regions
+---------------------------------
+
+In case of the debugfs based monitoring, DAMON automatically sets and updates
+the monitoring target regions so that entire memory mappings of target
+processes can be covered. However, users might want to limit the monitoring
+region to specific address ranges, such as the heap, the stack, or specific
+file-mapped area. Or, some users might know the initial access pattern of their
+workloads and therefore want to set optimal initial regions for the 'adaptive
+regions adjustment'.
+
+In such cases, users can explicitly set the initial monitoring target regions
+as they want, by writing proper values to the ``init_regions`` file.  Each line
+of the input should represent one region in below form.::
+
+    <pid> <start address> <end address>
+
+The ``pid`` should already in ``pids`` file, and the regions should be
+passed in address order.  For example, below commands will set a couple of
+address ranges, ``1-100`` and ``100-200`` as the initial monitoring target
+region of process 42, and another couple of address ranges, ``20-40`` and
+``50-100`` as that of process 4242.::
+
+    # cd <debugfs>/damon
+    # echo "42   1       100
+            42   100     200
+            4242 20      40
+            4242 50      100" > init_regions
+
+Note that this sets the initial monitoring target regions only.  DAMON will
+automatically updates the boundary of the regions after one ``regions update
+interval``.  Therefore, users should set the ``regions update interval`` large
+enough.
+
+
 Record
 ------
 
-- 
2.17.1

