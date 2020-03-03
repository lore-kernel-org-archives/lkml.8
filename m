Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990EEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FECB21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dHMYrQ5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgCCMRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:17:05 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:15648 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgCCMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583237824; x=1614773824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I5lhnzWRKWvNaF4MApexOfC/PP8h9gbeTKWBJi6wddY=;
  b=dHMYrQ5Ma9Kzo67n36hZFBQmhrjtPVRWy+dyT1Znp+2DoZrGCwcpU5jj
   lhYPOESY8Bqfkx8sidvpssT1e6VosvMsAdgeMHZedkYJMzWBiKnPK/LjZ
   tKgDvXaT/NzbDDIJWTDOWDEzLx0wgeqGic1YSs47uThPqahpoxUoX4a4+
   s=;
IronPort-SDR: /87kFaqMwDmzA7t3U62vAaD4BmoDpitQ7m99La8eO4oLFBsB5TgmwokkAxagaoZUuS3FlMHNlO
 T5bl0NeJwUZA==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20475936"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 12:17:03 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id A2976A2C24;
        Tue,  3 Mar 2020 12:17:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 12:17:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 12:16:49 +0000
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
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v4 6/7] mm/damon/selftests: Add 'schemes' debugfs tests
Date:   Tue, 3 Mar 2020 13:14:05 +0100
Message-ID: <20200303121406.20954-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303121406.20954-1-sjpark@amazon.com>
References: <20200303121406.20954-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D22UWB002.ant.amazon.com (10.43.161.28) To
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

