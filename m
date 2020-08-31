Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C281C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4E2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gtCyhoxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHaLZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:25:16 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:39878 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgHaLXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598872995; x=1630408995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=m6n6EuRTnJI3OIEU5O1Jd/703628N4sI9qEt+Ut99Lc=;
  b=gtCyhoxN4DgkQ4CUAk4AdZtzdFeiTSrcpQAQy+Ch/wHQ42ieto/ACc5Q
   WZ13pvumd4XfXpASADwJRwucmcDS/LggddGs6YVQm66VIPuBINkMBLNro
   cqv11fSbxxrE8B83HPJ11vooBmd4eBWtoWBTyJNFYb9tYbHsROp0Pktj7
   M=;
X-IronPort-AV: E=Sophos;i="5.76,375,1592870400"; 
   d="scan'208";a="64185476"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 31 Aug 2020 11:23:11 +0000
Received: from EX13D31EUB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 6425EA20E5;
        Mon, 31 Aug 2020 11:23:08 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.71) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 11:22:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 00/15] Introduce Data Access MONitor (DAMON)
Date:   Mon, 31 Aug 2020 13:22:35 +0200
Message-ID: <20200831112235.2675-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820072738.27602-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.71]
X-ClientProxiedBy: EX13D16UWB002.ant.amazon.com (10.43.161.234) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 09:27:38 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> On Mon, 17 Aug 2020 12:51:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Changes from Previous Version
> > =============================
> > 
> > - Place 'CREATE_TRACE_POINTS' after '#include' statements (Steven Rostedt)
> > - Support large record file (Alkaid)
> > - Place 'put_pid()' of virtual monitoring targets in 'cleanup' callback
> > - Avoid conflict between concurrent DAMON users
> > - Update evaluation result document
> > 
> > Introduction
> > ============
> > 
> > DAMON is a data access monitoring framework subsystem for the Linux kernel.
> > The core mechanisms of DAMON called 'region based sampling' and 'adaptive
> > regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
> > patchset for the detail) make it
> > 
> >  - accurate (The monitored information is useful for DRAM level memory
> >    management. It might not appropriate for Cache-level accuracy, though.),
> >  - light-weight (The monitoring overhead is low enough to be applied online
> >    while making no impact on the performance of the target workloads.), and
> >  - scalable (the upper-bound of the instrumentation overhead is controllable
> >    regardless of the size of target workloads.).
> > 
> > Using this framework, therefore, the kernel's core memory management mechanisms
> > such as reclamation and THP can be optimized for better memory management.  The
> > experimental memory management optimization works that incurring high
> > instrumentation overhead will be able to have another try.  In user space,
> > meanwhile, users who have some special workloads will be able to write
> > personalized tools or applications for deeper understanding and specialized
> > optimizations of their systems.
> 
> DAMON will be presented in the next week LPC[1].  To be prepared for a screen
> sharing error (if I get no such error, I will do a live-demo), I recorded a
> simple demo video.  I would like to share it here to help your easier
> understanding of DAMON.
> 
>     https://youtu.be/l63eqbVBZRY
> 
> [1] https://linuxplumbersconf.org/event/7/contributions/659/

During the session, I introduced the list of future works and asked the
audiences to vote for the priority of the tasks:
https://youtu.be/jOBkKMA0uF0?t=13253

To summarize here, the tasks are (highest priority first):

1. Make current DAMON patchset series merged in the mainline (6 votes)
2. User space interface improvement (4 votes)
 - Multiple monitoring contexts
 - Charging of the monitoring threads' CPU usage
3. Support more address spaces (2 votes)
 - Cgroups, cached pages, specific file-backed pages, swap slots, ...
3. DAMON-based MM optimizations (2 votes)
 - Page reclaim, THP, compaction, NUMA balancing, ...
4. Optimize for special use-cases (1 vote)
 - Page granularity monitoring, accessed-or-not monitoring, ...

So, I'd like to focus on polishing current patchset so that it could be merged
in.  For that, I'd like to ask your more reviews.

While waiting for the reviews, I will start implementing other future features
that received many votes.  The support of multiple monitoring contexts for the
user space would be the first one.  Once the implementation is finished, I will
post it as separated RFC patchset (the user space interface will be compatible
with current one).

Any comment is welcome.


Thanks,
SeongJae Park
