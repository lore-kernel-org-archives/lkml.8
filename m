Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C01EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD1D22B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aSNe+g53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCBLgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:36:05 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:64872 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgCBLgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583148965; x=1614684965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=oC+sHqqor/YXZFufFO4f+Vkq6AmhWnj6RaFndViWmTI=;
  b=aSNe+g53E0+IbcRa3RBNdiYcbZzJY/WqwYk0fVcOOCxIbMzIs4W23ayj
   RW1MfHLY8xdGQ0U+/AdUmKouG068JIqVb1wVPYFnKzZtaUucUXXHFt9nh
   ieYqGfBvsgGnbcl4xleork7axJUbHZVxFNkjk18uaR4jZ4woP9W91ZpA3
   4=;
IronPort-SDR: NFgSqvTchRtrH2OgxPCJhIR+IpWvawBTDEEkLI9AM+1mDBmz/Dl7tM6DwOfUffA0lKp3u/9af3
 cwnogZa21mBg==
X-IronPort-AV: E=Sophos;i="5.70,506,1574121600"; 
   d="scan'208";a="28575233"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Mar 2020 11:35:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 89BE9249F0D;
        Mon,  2 Mar 2020 11:35:48 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 11:35:47 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.74) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Mar 2020 11:35:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.com>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Mon, 2 Mar 2020 12:35:12 +0100
Message-ID: <20200302113512.8880-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224123047.32506-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.74]
X-ClientProxiedBy: EX13D04UWA004.ant.amazon.com (10.43.160.234) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 24 Feb 2020 13:30:33 +0100 SeongJae Park <sjpark@amazon.com> wrote:

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

I have posted this patchset once per week, but skip this week because there
were no comments in last week and therefore made no change in the patchset.

I think I answered to all previous comments and fixed all bugs previously
found.  May I ask some more comments or reviews?  If I missed something or
doing wrong, please let me know.


Thanks,
SeongJae Park

[...]
