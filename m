Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E78C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3A12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cGJZeWd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbgEYJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:31:48 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11425 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389514AbgEYJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590399107; x=1621935107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EhBVAsDs98qhULlRXqAfS/sAw/8j0NvB9F91fcrKmCM=;
  b=cGJZeWd+FbcAun2LyZlL0vaEIC41vlIibEuOz/wPJrlrGlN9JAiYgZ5W
   6Azx+rbKEUW1u9obiLYWoSN9EsGaOwr1N1Gj3Soqg7A3xoaEuUyQjoYuJ
   0Dd+1R3PJlGR+KdmV6Km377BMzuLfIo3lBUqTEooGsq2jJOEnJ5F+bufZ
   0=;
IronPort-SDR: /RbCI2gbLMK/BHdAHLO4QcFAhG+IkZBT7l6kTAwS0pqcD/4K1yBUlugXwNdeSTbFpeip8zyKgu
 NhdYf2l9I+JQ==
X-IronPort-AV: E=Sophos;i="5.73,432,1583193600"; 
   d="scan'208";a="47147033"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 25 May 2020 09:31:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id AB695A1C81;
        Mon, 25 May 2020 09:31:32 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:31:31 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.200) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:31:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 15/15] MAINTAINERS: Update for DAMON
Date:   Mon, 25 May 2020 11:31:01 +0200
Message-ID: <20200525093101.1550-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525091512.30391-1-sjpark@amazon.com>
References: <20200525091512.30391-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.200]
X-ClientProxiedBy: EX13D08UWB003.ant.amazon.com (10.43.161.186) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
index 5a5332b3591d..586513e92b65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4661,6 +4661,18 @@ F:	net/ax25/ax25_out.c
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

