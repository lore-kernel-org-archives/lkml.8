Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5269C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDAA2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JVkDrcyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgHDO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:26:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4046 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgHDO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596551203; x=1628087203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=y54T24GyHij+L4YlC4ErOhrawn7/T9RzI2P4TOBHFCI=;
  b=JVkDrcyvw8n1tc4n8Qck03RZj6fRFEkRV8mHdpz5gFbYj+GSQycua0sJ
   NCz2x4wAn9tncFTfRJxhfJtksSmQx7mCxaCWVJ3EXO9WTcz7hfUeYbp25
   8et2owlvJRYR+VXI6Fi6uDUiEwUAtoBBx4DBUAm2PpZm5Zer0TKUgm4g7
   o=;
IronPort-SDR: UtloN8/oEEd/c7fRvmj0wLTBbHDXdFb2EMt1jw92lBVe43QtV3epX1n+gGuLRujMlC4S0PZGPf
 ootihV4JwJIg==
X-IronPort-AV: E=Sophos;i="5.75,434,1589241600"; 
   d="scan'208";a="46072520"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 Aug 2020 14:26:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id C0255A16A1;
        Tue,  4 Aug 2020 14:26:36 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 14:26:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 14:26:19 +0000
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
Subject: [RFC v14 5/7] mm/damon/selftests: Add 'schemes' debugfs tests
Date:   Tue, 4 Aug 2020 16:24:28 +0200
Message-ID: <20200804142430.15384-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804142430.15384-1-sjpark@amazon.com>
References: <20200804142430.15384-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D17UWC004.ant.amazon.com (10.43.162.195) To
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
index c75557e8ba58..61fd3e5598e9 100755
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
+	echo "$file multi line write success (expected fail)"
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
 # Test target_ids file
 file="$DBGFS/target_ids"
 
-- 
2.17.1

