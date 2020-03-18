Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC47C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F9220768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bJbqWPqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCRL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:29:34 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:51921 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgCRL3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584530973; x=1616066973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JA2aQZlnEaxp5yQP3+f4dvGiPHN9KB1VJHGZIRRVqdU=;
  b=bJbqWPqBjB5vafvuQgEBhmHpTnUzUaQSrzQWopS0cHiwm6dK4rLxAUtB
   6/fWO8gA/aiB2sXOGnKV2SP47HmfoagR/GNOKxDwLSVRalUsOk9xjEM10
   gTEj+o1QQsxGWvtdP62yI0tl8zW31B0QYk461vvrlYobbbvJVcO44ESLG
   c=;
IronPort-SDR: BtpZ7YY1oweq6otGrrEHR3D6EGguH0I4AXG6xgXP9yMfDd/uvcf+ez/206DLaM/RhbLjw8458a
 KR2kLOxxhc9g==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="23517231"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Mar 2020 11:29:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 094BBA29FC;
        Wed, 18 Mar 2020 11:29:18 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:29:18 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:29:01 +0000
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
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 02/15] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Wed, 18 Mar 2020 12:27:09 +0100
Message-ID: <20200318112722.30143-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com>
References: <20200318112722.30143-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'lookup_page_ext()' to GPL modules.  This will be
used by DAMON.

This reverts commit a50179d0e22931032aa56718cd069b0ec74974c6.
---
 mm/page_ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4ade843ff588..71169b45bba9 100644
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

