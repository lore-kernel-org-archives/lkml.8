Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1327C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C891824654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D0KB/4YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBTIRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:17:42 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10017 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582186662; x=1613722662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=RLTXfx7fYdK319XaeyXL5HDwJIQwzFkcbgDe8LGSdWA=;
  b=D0KB/4YVA0SmLyGX2GZmaGnPeCrIXZqZH8XWJDqAGjDx6ubrbUlqK+cu
   PO5pC9SKU0DZB+XrtYMHj/VfrJwUv/CzVAyqaBK6akrCUQl7gny3TfIX6
   FJpwz+BzrOi1HKEX0A10/LzAkiDTvICe3C6K0hkRr9fY6rVFIDWus3JyA
   Y=;
IronPort-SDR: VMdHx0aL2wlJwG7+qs5TKuDlO/e4vPV6vY+s/Qs5VqSBsTTWC4cluGFk7Fu2E5reftsEEwjPWV
 25+EcFAggvZA==
X-IronPort-AV: E=Sophos;i="5.70,463,1574121600"; 
   d="scan'208";a="26277303"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Feb 2020 08:17:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 46840A040E;
        Thu, 20 Feb 2020 08:17:37 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 20 Feb 2020 08:17:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 20 Feb 2020 08:17:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/14] Introduce Data Access MONitor (DAMON)
Date:   Thu, 20 Feb 2020 09:17:10 +0100
Message-ID: <20200220081710.15211-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217102544.29012-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D23UWA004.ant.amazon.com (10.43.160.72) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 11:25:30 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Introduction
> ============
> 
> Memory management decisions can be improved if finer data access information is
> available.  However, because such finer information usually comes with higher
> overhead, most systems including Linux forgives the potential improvement and
> rely on only coarse information or some light-weight heuristics.  The
> pseudo-LRU and the aggressive THP promotions are such examples.
> 
> A number of experimental data access pattern awared memory management
> optimizations (refer to 'Appendix A' for more details) say the sacrifices are
> huge.  However, none of those has successfully adopted to Linux kernel mainly
> due to the absence of a scalable and efficient data access monitoring
> mechanism.  Refer to 'Appendix B' to see the limitations of existing memory
> monitoring mechanisms.
> 
> DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> enough to be used for the DRAM level memory management (a straightforward
> DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> to be applied online (compared to a straightforward access monitoring scheme,
> DAMON is up to 94.242.42x lighter) and 3) keeps predefined upper-bound overhead
> regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> C' if you interested in how it is possible.
> 
> DAMON has mainly designed for the kernel's memory management mechanisms.
> However, because it is implemented as a standalone kernel module and provides
> several interfaces, it can be used by a wide range of users including kernel
> space programs, user space programs, programmers, and administrators.  DAMON
> is now supporting the monitoring only, but it will also provide simple and
> convenient data access pattern awared memory managements by itself.  Refer to
> 'Appendix D' for more detailed expected usages of DAMON.

So, with this patchset, you can (1) do data access pattern based memory
management optimizations and (2) analyze your program's dynamic data access
pattern.  For the analysis, this patchset also supports visualization of the
pattern in (1) heatmap form and distribution of the (2-1) dynamic working set
size and (2-2) monitoring overhead.

To help you better understand what DAMON can give you, I made web pages showing
the visualized dynamic data access pattern of various realistic workloads,
which I picked up from PARSEC3 and SPLASH-2X bechmark suites.  Note that
another big part of DAMON's usecases, access pattern based optimization is not
demonstrated in the pages, yet.

There are pages showing the heatmap format dynamic access pattern of each
workload for heap area[1], mmap()-ed area[2], and stack[3] area.  I splitted
the entire address space to the three area because the total address space is
too huge.

You can also show how the dynamic working set size of each workload is
distributed, and how it is changing chronologically[5].

The biggest characteristic of DAMON is its promise of the upperbound of
the monitoring overhead.  To show whether DAMON keeps the promise well, I
visualized the number of monitoring operations required for each 5
milliseconds, which is configured to not exceed 1000.  You can show the
distribution of the numbers[6] and how it changes chronologically[7].

As previously mentioned, these are only a fraction of the outputs of DAMON.  I
believe DAMON can be used for more wide and creative purposes.  Nonetheless, I
hope the pages help you understand what DAMON can give you in more intuitive
fashion.


[1] https://damonitor.github.io/reports/latest/by_image/heatmap.0.png.html
[2] https://damonitor.github.io/reports/latest/by_image/heatmap.1.png.html
[3] https://damonitor.github.io/reports/latest/by_image/heatmap.2.png.html
[4] https://damonitor.github.io/reports/latest/by_image/wss_sz.png.html
[5] https://damonitor.github.io/reports/latest/by_image/wss_time.png.html
[6] https://damonitor.github.io/reports/latest/by_image/nr_regions_sz.png.html
[7] https://damonitor.github.io/reports/latest/by_image/nr_regions_time.png.html
