Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED35B2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YG/2hoG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgC3LyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:54:25 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:7818 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3LyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585569265; x=1617105265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=I5lhnzWRKWvNaF4MApexOfC/PP8h9gbeTKWBJi6wddY=;
  b=YG/2hoG/hGuKfEGNYAXY7Tlcb343QyKs6eZEFZxxvORwAL+S8NGwWRhE
   kzfnXSqqdOtsrrUUzpdM/OJbNZ22gbo4JfTOwS0NlVCp3GlzDXGtTD+EI
   YYKo4HJxPpKvQiHPkypSLaFwKHwiGtomU42/HuPwEL11uisSBlJaco03m
   0=;
IronPort-SDR: b17/lJxz8iP13K8IYzrTUvcIFCUztMe6UutrTTGC9hnutqTN8FHdDKjqq8E6IUCUKUDkwiQ1b3
 9g2Kpl0DyL3Q==
X-IronPort-AV: E=Sophos;i="5.72,324,1580774400"; 
   d="scan'208";a="24743547"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 30 Mar 2020 11:54:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 9FDDFA2489;
        Mon, 30 Mar 2020 11:54:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 30 Mar 2020 11:54:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.134) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 11:53:47 +0000
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
Subject: [RFC v5 6/7] mm/damon/selftests: Add 'schemes' debugfs tests
Date:   Mon, 30 Mar 2020 13:50:41 +0200
Message-ID: <20200330115042.17431-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330115042.17431-1-sjpark@amazon.com>
References: <20200330115042.17431-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D37UWC003.ant.amazon.com (10.43.162.183) To
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

