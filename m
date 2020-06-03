Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3071C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9102F20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tVfb+69e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCOOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:14:09 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:54210 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193648; x=1622729648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4Ff2FlavwNWCorfCk4OWW1ES8k5kxbCqQvU0uywv4K0=;
  b=tVfb+69e/SsRImO1ca/5EtBZf7wUe4xWDRzJjv1qR3f7PRl7kXl8lLvO
   QKEdHcEw7j43+ODTZCsWsfxEwv/+kSI1iPC6hMrcnzKlFdirC7MYOj+Li
   hswKZAf3PnTDCDGWldYsJJSu197tGFSSpw3ojpYnICFJtiQcGdupfcTFC
   o=;
IronPort-SDR: 9LPTo87SywWCVFvOKx9F2B7bSyqWuI15pbcIlfIhXQMnPvAPH8bAMF7pI2Asnp0wHrIHkBx6DC
 FEioX7uvQnOQ==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="41265128"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Jun 2020 14:14:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 3C4ECA1C6F;
        Wed,  3 Jun 2020 14:14:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:14:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:13:48 +0000
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
Subject: [RFC v2 5/9] Docs/damon: Document 'initial_regions' feature
Date:   Wed, 3 Jun 2020 16:11:31 +0200
Message-ID: <20200603141135.10575-6-sjpark@amazon.com>
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

This commit documents the 'initial_regions' feature.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 18a19c35b4f3..137ed770c2d6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -326,6 +326,40 @@ having pids 42 and 4242 as the processes to be monitored and check it again::
 Note that setting the pids doesn't start the monitoring.
 
 
+Initla Monitoring Target Regions
+--------------------------------
+
+DAMON automatically sets and updates the monitoring target regions so that
+entire memory mappings of target processes can be covered.  However, users
+might want to limit the monitoring region to specific address ranges, such as
+the heap, the stack, or specific file-mapped area.  Or, some users might know
+the initial access pattern of their workloads and therefore want to set optimal
+initial regions for the 'adaptive regions adjustment'.
+
+In such cases, users can explicitly set the initial monitoring target regions
+as they want, by writing proper values to the ``init_regions`` file.  Each line
+of the input should represent one region in below form.::
+
+    <pid> <start address> <end address>
+
+The ``pid`` should be already in ``pids`` file, and the regions should be
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

