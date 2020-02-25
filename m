Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4628AC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEE0222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K29YXvtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgBYK0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:26:19 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:64328 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgBYK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582626378; x=1614162378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I5lhnzWRKWvNaF4MApexOfC/PP8h9gbeTKWBJi6wddY=;
  b=K29YXvtMhCz6Syzaz8Bvk+nnc02LafaXkSYgve2gya+F7kKp644x5Gxv
   72pw3IJP6K+rF9CKx/Q4QKbVFIt93HGWfvtKjb3cPtKkWfhZIz5sbOTYy
   NzF8ULK4Lgzt6mNFtJi+6VJ86Nq7T++MB9gCgmcpfOU4Z0lZDKM2Urwuo
   s=;
IronPort-SDR: R1LTugDP/R3oV6o9+9pnARTGmnAJbZvZMbTTzEsR9MRBvgDhthg4fJm0KWxoBSLAImvpjAAaiN
 bTDOpR4zEV5w==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18757024"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Feb 2020 10:26:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 78CC1A1EFB;
        Tue, 25 Feb 2020 10:25:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 10:25:55 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 10:25:44 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 6/7] mm/damon/selftests: Add 'schemes' debugfs tests
Date:   Tue, 25 Feb 2020 11:22:59 +0100
Message-ID: <20200225102300.23895-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225102300.23895-1-sjpark@amazon.com>
References: <20200225102300.23895-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds simple selftets for 'schemes' debugfs file of DAMON.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../testing/selftests/damon/debugfs_attrs.sh  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index d5188b0f71b1..82a98c81975b 100755
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -97,6 +97,35 @@ fi
 
 echo $ORIG_CONTENT > $file
 
+# Test schemes file
+file="$DBGFS/schemes"
+
+ORIG_CONTENT=$(cat $file)
+echo "1 2 3 4 5 6 3" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "1 2
+3 4 5 6 3" > $file
+if [ $? -eq 0 ]
+then
+	echo "$file splitted write success (expected fail)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo > $file
+if [ $? -ne 0 ]
+then
+	echo "$file empty string writing fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
 # Test pids file
 file="$DBGFS/pids"
 
-- 
2.17.1

