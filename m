Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C494F22B45
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bgFmuqv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHEHC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:02:27 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:3322 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596610946; x=1628146946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TaBhL5HojO46LzRrtNTJtjXeDGLmPmatGGRehayYLuY=;
  b=bgFmuqv+bUe8YirmnyQii6C/KQX9zSPCFn9LHyUIHL/kUborJMvO/rji
   3YH25L9WvaLj4kNJGE3oXxnHydp/nPhbuuRRc4DhbmdD7wkGrGABt8QEG
   Sfon4eJoTmqa+y9JMABQEQGGGZKxPfHUIXhxV/XZr4otReaGZTCQpzC2V
   Y=;
IronPort-SDR: 1njLGLtp2zkq+EzPQO2ocDFDKI7LstWAa5hNp7nJ6X/GoCddrUSwPU1CJTdxYX9P9o64N9r8aP
 LhOi3eh6dS/A==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="46045988"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 05 Aug 2020 07:02:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 5384CA21FD;
        Wed,  5 Aug 2020 07:02:14 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:02:13 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:01:56 +0000
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
Subject: [RFC v6 05/10] Docs/admin-guide/mm/damon: Document 'init_regions' feature
Date:   Wed, 5 Aug 2020 08:59:46 +0200
Message-ID: <20200805065951.18221-6-sjpark@amazon.com>
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

This commit adds description of the 'init_regions' feature in the DAMON
usage document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 41 +++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 96278227f925..cf0d44ce0ac9 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -281,8 +281,9 @@ for at least 100 milliseconds using below commands::
 debugfs Interface
 =================
 
-DAMON exports five files, ``attrs``, ``target_ids``, ``record``, ``schemes``
-and ``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports six files, ``attrs``, ``target_ids``, ``init_regions``,
+``record``, ``schemes`` and ``monitor_on`` under its debugfs directory,
+``<debugfs>/damon/``.
 
 
 Attributes
@@ -321,6 +322,42 @@ check it again::
 Note that setting the target ids doesn't start the monitoring.
 
 
+Initial Monitoring Target Regions
+---------------------------------
+
+In case of the debugfs based monitoring, DAMON automatically sets and updates
+the monitoring target regions so that entire memory mappings of target
+processes can be covered. However, users might want to limit the monitoring
+region to specific address ranges, such as the heap, the stack, or specific
+file-mapped area.  Or, some users might know the initial access pattern of
+their workloads and therefore want to set optimal initial regions for the
+'adaptive regions adjustment'.
+
+In such cases, users can explicitly set the initial monitoring target regions
+as they want, by writing proper values to the ``init_regions`` file.  Each line
+of the input should represent one region in below form.::
+
+    <target id> <start address> <end address>
+
+The ``target id`` should already in ``target_ids`` file, and the regions should
+be passed in address order.  For example, below commands will set a couple of
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
+Note that this sets the initial monitoring target regions only.  In case of
+virtual memory monitoring, DAMON will automatically updates the boundary of the
+regions after one ``regions update interval``.  Therefore, users should set the
+``regions update interval`` large enough in this case, if they don't want the
+update.
+
+
 Record
 ------
 
-- 
2.17.1

