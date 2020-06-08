Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD131C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCBE20825
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PZ+Q6kTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgFHLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:41:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39518 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgFHLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591616510; x=1623152510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tzqFpBqYuNYdmIDQaxDJFoQHYQ6t1Uuo0vpOOKcI5WQ=;
  b=PZ+Q6kTz48zAJLfcUAknrNBX9LRF0L55y47fpDTuURW2Zitl4ecywJyt
   F7DXiliZU2Gnm6qYvplErftcN2yYJCQxiDFc3vQohdTDUbTWFqzw+/egC
   LNP8U2AlqfnibRD4BQdTk2euUtcW/p6fQv5d/KFdAaFNW92Pf1kAEQjwL
   M=;
IronPort-SDR: xiFxRJogapcywc7OPAgfZIpUsq0I4f+zVXHXCtEhGJzFk+jPZ7boVra1W8mQr7X0C0Annpw+UI
 ViZjLVWoc8Eg==
X-IronPort-AV: E=Sophos;i="5.73,487,1583193600"; 
   d="scan'208";a="50569453"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Jun 2020 11:41:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 25316A1DDC;
        Mon,  8 Jun 2020 11:41:45 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 11:41:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 8 Jun 2020 11:41:27 +0000
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
Subject: [PATCH v15 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 8 Jun 2020 13:40:34 +0200
Message-ID: <20200608114047.26589-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608114047.26589-1-sjpark@amazon.com>
References: <20200608114047.26589-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D46UWB004.ant.amazon.com (10.43.161.204) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'lookup_page_ext()' to GPL modules.  This will be
used by DAMON.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 mm/page_ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index a3616f7a0e9e..9d802d01fcb5 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
 					MAX_ORDER_NR_PAGES);
 	return get_entry(base, index);
 }
+EXPORT_SYMBOL_GPL(lookup_page_ext);
 
 static int __init alloc_node_page_ext(int nid)
 {
-- 
2.17.1

