Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A643C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EAF2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cGNV4Jg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgFJKOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:14:11 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:58991 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591784049; x=1623320049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=CtNLCaD8mW2jfZ6LEQ4ahCDLJNSsZclpIdWVExMRWPo=;
  b=cGNV4Jg97bQ5pG1Sb9bMuzZ2Ym7uxL82UzlF5SgFBSRfNgamiiGNar8J
   jMFhY0SS21QQCnYQPpixxS2Q6ASb53YwufvRN0WPZ7GQKhH74uZxrD+m2
   J7CD/xbXcjlb2yiWs/7AEAyNOf639FVzyXGkrDRvnzZu5FqDjUqn+c4UR
   8=;
IronPort-SDR: dke9JTcwLcS6G+n1O6A4GNdauJ4coP5XGtmjnU1489ct9Otf/FYfhQaBHKJ7KquAN5GGblkUrs
 TMi1N1GQCvgw==
X-IronPort-AV: E=Sophos;i="5.73,495,1583193600"; 
   d="scan'208";a="35409709"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Jun 2020 10:14:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 8F90B286AD4;
        Wed, 10 Jun 2020 10:13:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 10:13:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Jun 2020 10:13:40 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 04/14] mm/damon: Adaptively adjust regions
Date:   Wed, 10 Jun 2020 12:13:24 +0200
Message-ID: <20200610101324.20437-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608114047.26589-5-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D36UWA003.ant.amazon.com (10.43.160.237) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 13:40:37 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> At the beginning of the monitoring, DAMON constructs the initial regions
> by evenly splitting the memory mapped address space of the process into
> the user-specified minimal number of regions.  In this initial state,
> the assumption of the regions (pages in same region have similar access
> frequencies) is normally not kept and thus the monitoring quality could
> be low.  To keep the assumption as much as possible, DAMON adaptively
> merges and splits each region.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two regions if the total number
> of regions is smaller than the half of the user-specified maximum number
> of regions.

I recently realized that only the 'maximum number of regions' is respected,
meanwhile the 'minimum number of regions' isn't.  In the next spin, I will
update the code to 1) set new internal variable, 'max_sz_region' as size of
entire monitoring target regions divided by the 'minimum number of regions',
and 2) avoid merging regions if it results in region of size larger than that.

This change would make DAMON more flexible for special cases.  For example,
some use cases would need static granularity monitoring.  In such case, users
will be able to adjust the granularity by controlling the 'minimum number of
regions', and avoid the split/merge of regions by setting the 'maximum number
of regions' as same to the 'minimum number of regions'.


Thanks,
SeongJae Park

> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the bounds users set for their trade-off.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
