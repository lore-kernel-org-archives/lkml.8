Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB64C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274EF207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="okiHBEmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgHTRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:34:28 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:2074 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbgHTReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597944848; x=1629480848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=MEA3ZhuWPoS1IieuWPGBAER8PruyG5EIp2kQWXV3Uws=;
  b=okiHBEmAad8HTbk2suf+KuvP1XdldNIUn0DWCyIR2xmdMG4/pi8ORw8T
   nFAdoK2xDvvHyM6H65lCV9FlBgTepp2GQtMkYy+j/OqZnEdc6IKfrc/v2
   CMnEbABqth65XKvmBpF/lBfy2+wCmHPYfQ0A80UFILGp4HpPwdtrtKblS
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,333,1592870400"; 
   d="scan'208";a="50392757"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Aug 2020 17:33:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 21249A211A;
        Thu, 20 Aug 2020 17:33:42 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 17:33:42 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 17:33:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <Jonathan.Cameron@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        "Du, Fan" <fan.du@intel.com>, <foersleo@amazon.de>,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v7 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Thu, 20 Aug 2020 19:33:10 +0200
Message-ID: <20200820173310.18933-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7a=zr8VX3T2KOheUJ-THjGz=O+JBdcjw4iraN3m9jSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D27UWA001.ant.amazon.com (10.43.160.19) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 08:44:33 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Aug 20, 2020 at 12:11 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Wed, 19 Aug 2020 18:21:44 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Tue, Aug 18, 2020 at 12:25 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > Changes from Previous Version
> > > > =============================
> > > >
> > > > - Use 42 as the fake target id for paddr instead of -1
> > > > - Fix a typo
> > > >
> > > > Introduction
> > > > ============
> > > >
> > > > DAMON[1] programming interface users can extend DAMON for any address space by
> > > > configuring the address-space specific low level primitives with appropriate
> > > > ones including their own implementations.  However, because the implementation
> > > > for the virtual address space is only available now, the users should implement
> > > > their own for other address spaces.  Worse yet, the user space users who rely
> > > > on the debugfs interface and user space tool, cannot implement their own.
> > > >
> > > > This patchset implements another reference implementation of the low level
> > > > primitives for the physical memory address space.  With this change, hence, the
> > > > kernel space users can monitor both the virtual and the physical address spaces
> > > > by simply changing the configuration in the runtime.  Further, this patchset
> > > > links the implementation to the debugfs interface and the user space tool for
> > > > the user space users.
> > > >
> > > > Note that the implementation supports only the user memory, as same to the idle
> > > > page access tracking feature.
> > > >
> > > > [1] https://lore.kernel.org/linux-mm/20200706115322.29598-1-sjpark@amazon.com/
> > > >
> > >
> > > I am still struggling to find the benefit of this feature the way it
> > > is implemented i.e. region based physical address space monitoring.
> > > What exactly am I supposed to do for a given hot (or cold) physical
> > > region? In a containerized world, that region can contain pages from
> > > any cgroup. I can not really do anything about the accesses PHY-DAMON
> > > provides me for a region.
> >
> > Technically speaking, this patchset introduces an implementation of DAMON's low
> > level primitives for physical address space of LRU-listed pages.  In other
> > words, it is not designed for cgroups case.
> 
> So, this RFC is for a system running a single workload which comprises
> multiple processes. Instead of registering each process with DAMON,
> just monitor the whole physical memory, right?

Right.  Also I assumed the kernel space DAMON users as the primary users of
this feature.

> 
> Though I am still not sure how the output from DAMON can be used in
> this case. DAMON told me a physical region is cold, how do I find out
> processes that have mapped the pages in that region to do
> process_madvise(PAGEOUT) on them?

Seems you are saying about the user space DAMON use.  Indeed, it would be quite
complicated.  For example, maybe the user space could read '/proc/pid/pagemap'
of every process, but this really sounds awkward.  Thank you for pointing this
:)  Even in the virtual address case, it could be complicated.

For this reason, I am developing DAMON-based Operation Schemes[1].  It is
designed to do the monitoring and optimization of specific regions fit in
special monitoring result by DAMON itself.  Nonetheless, current version of it
supports only virtual address spaces.  A support of physical address space from
the feature will be another future work.

If the user space really need to do that by itself, we could provide the
physical address to virtual address mapping info in addition to the monitoring
result in future.

And, yes, we have so many TODO tasks that really necessary.  I will eventually
do all of those, but also concerning about my limited time.  Nevertheless, I
believe it would better to focus on the core of DAMON[2] for now and continue
further TODO tasks after it is merged in the mainline, because maintainance of
the code will be much easier and hopefully more developers could collaborate
for the many TODO tasks.

[1] https://lore.kernel.org/linux-mm/20200804142430.15384-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200817105137.19296-1-sjpark@amazon.com/


Thanks,
SeongJae Park
