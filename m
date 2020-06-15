Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0706C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD66207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="i5hdJ/m+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgFOQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:20:27 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:65224 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgFOQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592238027; x=1623774027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KFodkFYUcobTypZK2z+lk2aPe8xpAQLyInNhOFuMluc=;
  b=i5hdJ/m+unwqguHl4zHUEXgH7tdkwAd4sm86OrBUtDgE16ANXhK3ntPj
   sbm7WqwH4WI/kous/AxkfZaCV5sBYcNzp6QKPi95QuKllgnIcQpj2CZIB
   6c0/KmcS8eHhpQ8pYmoZPU66v+Ibc6zl6mbBtBhQFrYKZTU7IFmVsamZT
   U=;
IronPort-SDR: d+8kFcmrVjMOo4zHUcEZP8LaGpLfub6toaIfFxqqY4YchE3iHQfJmLk93bVNQkFC+x0eEvJbgZ
 iCArwFJMIFeg==
X-IronPort-AV: E=Sophos;i="5.73,515,1583193600"; 
   d="scan'208";a="51081083"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 15 Jun 2020 16:20:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id CC59CA224C;
        Mon, 15 Jun 2020 16:20:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 16:20:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.145) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 15 Jun 2020 16:20:02 +0000
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
Subject: [PATCH v16 01/14] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 15 Jun 2020 18:19:14 +0200
Message-ID: <20200615161927.12637-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615161927.12637-1-sjpark@amazon.com>
References: <20200615161927.12637-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D23UWA004.ant.amazon.com (10.43.160.72) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'lookup_page_ext()' to GPL modules.  It will be used
by DAMON in following commit for the implementation of the region based
sampling.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Varad Gautam <vrd@amazon.de>
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

