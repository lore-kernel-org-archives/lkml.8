Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F8BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5654120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J8Agmnbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgGFL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:59:05 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:39336 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgGFL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594036733; x=1625572733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pVcOoTXfEhP95n40P2tq5dup7mBPSiPPU6Yt3e8a7DQ=;
  b=J8AgmnbmHb1haAsWwWOvbDDwyt28veLcvuQaQPkJuX0DMvuoGAa4JQ0o
   j7rpBPtTzLgAle9/TLXQuTvGM9vJ2ei7cZtLcOn8erhv/KvxIPsaX70hs
   EJX+hBPHLzCczqIPY/x3hqHuw4MMlnOM/GvXvkBgQO52sRxQ1PSpRE8y2
   8=;
IronPort-SDR: qgI9ioM6R8agcTnj85nMh/1WQ8oh+E0VkU3pnTeVoxJRJRPrlHRJwcrmF8NT8XDDt+sXb1FlCT
 5IqCT4grAfmA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="40204357"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Jul 2020 11:58:49 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id D841EA1755;
        Mon,  6 Jul 2020 11:58:46 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:58:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:58:30 +0000
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
Subject: [PATCH v17 15/15] MAINTAINERS: Update for DAMON
Date:   Mon, 6 Jul 2020 13:53:22 +0200
Message-ID: <20200706115322.29598-16-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-1-sjpark@amazon.com>
References: <20200706115322.29598-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..2396a9098715 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4686,6 +4686,18 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/*
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon-test.h
+F:	mm/damon.c
+F:	tools/damon/*
+F:	tools/testing/selftests/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

