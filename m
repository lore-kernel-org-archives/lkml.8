Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA12C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D92080C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PbD2YNA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHTHRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:17:35 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:49458 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgHTHRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597907854; x=1629443854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=W59BglKGXdUJkCj/066BuyTZwUlLWMs0tlr8zdLJoL8=;
  b=PbD2YNA0eTQqkB7eWTrFtKw2n732tQdyFclOskO2CN37O3kNjlyEAagA
   iPBRNZnI7SlEy+/biHNcSALNpCrFLFgpDhgrndjUdEV0mUltYoG/sE7ko
   fL3bZoGq4bwTWftIQWrH45GpbsNPaiYseF00Zf5w6RdHwd3HkVLiX1U2d
   8=;
X-IronPort-AV: E=Sophos;i="5.76,332,1592870400"; 
   d="scan'208";a="61201794"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 20 Aug 2020 07:17:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id B889BA222B;
        Thu, 20 Aug 2020 07:17:18 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:17:17 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.38) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 07:17:01 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
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
Subject: Re: [RFC v7 06/10] mm/damon: Implement callbacks for physical memory monitoring
Date:   Thu, 20 Aug 2020 09:16:47 +0200
Message-ID: <20200820071647.25280-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5ZRUHO+=Bvwj4aEKNL0Egwea2dZKuYDKhkvvUyezbgdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D22UWB003.ant.amazon.com (10.43.161.76) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 17:26:15 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Aug 18, 2020 at 12:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit implements the four callbacks (->init_target_regions,
> > ->update_target_regions, ->prepare_access_check, and ->check_accesses)
> > for the basic access monitoring of the physical memory address space.
> > By setting the callback pointers to point those, users can easily
> > monitor the accesses to the physical memory.
> >
> > Internally, it uses the PTE Accessed bit, as similar to that of the
> > virtual memory support.  Also, it supports only user memory pages, as
> > idle page tracking also does, for the same reason.  If the monitoring
> > target physical memory address range contains non-user memory pages,
> > access check of the pages will do nothing but simply treat the pages as
> > not accessed.
> >
> > Users who want to use other access check primitives and/or monitor the
> > non-user memory regions could implement and use their own callbacks.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> [snip]
> > +static void damon_phys_mkold(unsigned long paddr)
> > +{
> > +       struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
> > +       struct rmap_walk_control rwc = {
> > +               .rmap_one = damon_page_mkold,
> > +               .anon_lock = page_lock_anon_vma_read,
> > +       };
> > +       bool need_lock;
> > +
> > +       if (!page)
> > +               return;
> > +
> > +       if (!page_mapped(page) || !page_rmapping(page))
> > +               return;
> 
> I don't think you want to skip the unmapped pages. The point of
> physical address space monitoring was to include the monitoring of
> unmapped pages, so, skipping them invalidates the underlying
> motivation.

I think my answer to your other mail[1] could be an answer to this.  Let me
quote some from it:

```
Technically speaking, this patchset introduces an implementation of DAMON's low
level primitives for physical address space of LRU-listed pages.  In other
words, it is not designed for cgroups case.  Also, please note that this
patchset is only RFC, because it aims to only show the future plan of DAMON and
get opinions about the concept before being serious.  It will be serious only
after the DAMON patchset is merged.  Maybe I didn' made this point clear in the
CV, sorry.  I will state this clearly in the next spin.
```

```
So, DAMON is a framework rather than a tool.  Though it comes with basic
applications using DAMON as a framework (e.g., the virtual address space low
primitives implementation, DAMON debugfs interface, and the DAMON user space
tool) that could be useful in simple use cases, you need to code your
application on it if your use cases are out of the simple cases.  I will also
develop more of such applications for more use-cases, but it will be only after
the framework is complete enough to be merged in the mainline.
```

Of course, we could prioritize the cgroup support if strongly required, though
I still prefer focusing on the framework itself for now.

[1] https://lore.kernel.org/linux-mm/20200820071052.24271-1-sjpark@amazon.com/


Thanks,
SeongJae Park
