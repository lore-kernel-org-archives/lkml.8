Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA63620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pb8usziu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgFIOWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:22:03 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:7814 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgFIOWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591712522; x=1623248522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=v6Vmzq5EIDAZEFmnvXrN4Ci7XeSQ+6uNTzvYLYOmCMg=;
  b=pb8usziuC+fs/n+G+/Qy+woXfJmm2sEKfAj4VidLiSkUXwqgjRSBy+EG
   dGryqdBNY3HqiVk1MrRxAybGkuGgX8UMV5bSn9su0CKiY3xbeGlKEtfdK
   zZe1NSCEEc8ySMuhwA7NKw9v3d6hynS8Q8E0Oaeb3evCgzWi0YL2ar55l
   w=;
IronPort-SDR: nEpkDPK0Sk41CVJJYXq9cww3EDIAVJgQCfJearg4PLeUq/AU2/79A5knzDXjrum2RiFlD66pp1
 qSSxpNs97AnA==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="35297528"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Jun 2020 14:22:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 6529F24230A;
        Tue,  9 Jun 2020 14:21:50 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:21:49 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:21:33 +0000
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
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v3 05/10] Docs/damon: Document 'initial_regions' feature
Date:   Tue, 9 Jun 2020 16:19:36 +0200
Message-ID: <20200609141941.19184-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609141941.19184-1-sjpark@amazon.com>
References: <20200609141941.19184-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
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
index 18a19c35b4f3..f600366cdd4e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -326,6 +326,40 @@ having pids 42 and 4242 as the processes to be monitored and check it again::
 Note that setting the pids doesn't start the monitoring.
 
 
+Initial Monitoring Target Regions
+---------------------------------
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

