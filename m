Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45D922404
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TuuKaCgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgDFNKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:10:55 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:36133 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586178654; x=1617714654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BDFe8BdspXl/Hr6m/aHRrBSBiGgATUgcBTWlj2SknD0=;
  b=TuuKaCgmOTqz27j89u59rXP1EgL+VBAfrokAmRpALW0uZ6ez79q/CmUb
   nUyUUOdJy3yeCQko/Kih6yHpt6RUTFlnBdWqAu62R0GtdjmFyOsCwTFjM
   aIE+DXi6dY0JSzBW7K++4vjAKMqSRt3hjMeEq1rqsbAkre4rahdsHdbf+
   4=;
IronPort-SDR: h/W3PBdLYN4jZVt02PzjdCqrgjCNuR+PJcSgkIcUyRw6niSSwCC6BZtYvLYXXoaQyrnl0x1TH1
 9pB9sm/8b+rQ==
X-IronPort-AV: E=Sophos;i="5.72,351,1580774400"; 
   d="scan'208";a="36894307"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Apr 2020 13:10:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 0850BA1D74;
        Mon,  6 Apr 2020 13:10:49 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:10:49 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:10:36 +0000
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
Subject: [PATCH v8 02/15] mm/page_ext: Export lookup_page_ext() to GPL modules
Date:   Mon, 6 Apr 2020 15:09:25 +0200
Message-ID: <20200406130938.14066-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406130938.14066-1-sjpark@amazon.com>
References: <20200406130938.14066-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D11UWB003.ant.amazon.com (10.43.161.206) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports 'lookup_page_ext()' to GPL modules.  This will be
used by DAMON.

This reverts commit a50179d0e22931032aa56718cd069b0ec74974c6.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
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

