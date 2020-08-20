Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3195C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC46F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gCA7p7Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHTO3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:29:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19709 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHTO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597933742; x=1629469742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=iuszyUpO1ndlzGbTxwV1GwNeRR/arNRnxwcYR1kXoYQ=;
  b=gCA7p7KxP6nhLdrnGz407SQ0YvKVoIov9KmlehHAJB5pRrerugQXJ8AU
   8M4boLofwuwU3ZdhxVzLncS47Jqn298jtFds3+Ig0BNAjeHDNlk5tQgaP
   YhmrWgyGI83Bqz/NRLP4HZFGOWA6E5vE6mUug7KTMbp4KCF4pPIO3nrOs
   o=;
X-IronPort-AV: E=Sophos;i="5.76,333,1592870400"; 
   d="scan'208";a="69467749"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Aug 2020 14:28:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 3673F1A7472;
        Thu, 20 Aug 2020 14:28:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 14:28:56 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.85) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 20 Aug 2020 14:28:40 +0000
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
Subject: Re: [RFC v7 06/10] mm/damon: Implement callbacks for physical memory monitoring
Date:   Thu, 20 Aug 2020 16:28:05 +0200
Message-ID: <20200820142805.10234-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod4i5f5RcsHao3DWddoDgHsO+vvGPZaAJUWkURZ2fqH9LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D21UWA004.ant.amazon.com (10.43.160.252) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 06:26:49 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Aug 20, 2020 at 12:17 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Wed, 19 Aug 2020 17:26:15 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Tue, Aug 18, 2020 at 12:27 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > This commit implements the four callbacks (->init_target_regions,
> > > > ->update_target_regions, ->prepare_access_check, and ->check_accesses)
> > > > for the basic access monitoring of the physical memory address space.
> > > > By setting the callback pointers to point those, users can easily
> > > > monitor the accesses to the physical memory.
> > > >
> > > > Internally, it uses the PTE Accessed bit, as similar to that of the
> > > > virtual memory support.  Also, it supports only user memory pages, as
> > > > idle page tracking also does, for the same reason.  If the monitoring
> > > > target physical memory address range contains non-user memory pages,
> > > > access check of the pages will do nothing but simply treat the pages as
> > > > not accessed.
> > > >
> > > > Users who want to use other access check primitives and/or monitor the
> > > > non-user memory regions could implement and use their own callbacks.
> > > >
> > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > [snip]
> > > > +static void damon_phys_mkold(unsigned long paddr)
> > > > +{
> > > > +       struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
> > > > +       struct rmap_walk_control rwc = {
> > > > +               .rmap_one = damon_page_mkold,
> > > > +               .anon_lock = page_lock_anon_vma_read,
> > > > +       };
> > > > +       bool need_lock;
> > > > +
> > > > +       if (!page)
> > > > +               return;
> > > > +
> > > > +       if (!page_mapped(page) || !page_rmapping(page))
> > > > +               return;
> > >
> > > I don't think you want to skip the unmapped pages. The point of
> > > physical address space monitoring was to include the monitoring of
> > > unmapped pages, so, skipping them invalidates the underlying
> > > motivation.
> >
> > I think my answer to your other mail[1] could be an answer to this.  Let me
> > quote some from it:
> >
> > ```
> > Technically speaking, this patchset introduces an implementation of DAMON's low
> > level primitives for physical address space of LRU-listed pages.  In other
> > words, it is not designed for cgroups case.  Also, please note that this
> > patchset is only RFC, because it aims to only show the future plan of DAMON and
> > get opinions about the concept before being serious.  It will be serious only
> > after the DAMON patchset is merged.  Maybe I didn' made this point clear in the
> > CV, sorry.  I will state this clearly in the next spin.
> > ```
> 
> The unmapped pages are also LRU pages.

Sorry, I missed the detail.  So, the description should be updated to:

    This patchset introduces an implementation of DAMON's low level primitives
    for physical addressspace of _mapped_ LRU pages.

> Let's forget about the cgroups
> support for a moment, the only reason to use DAMON's physical address
> space monitoring is also to track the accesses of unmapped pages
> otherwise virtual address space monitoring already does the monitoring
> for mapped pages.

Well, I didn't intended the use case...  I just wanted to let people see the
data accesses on physical address space without tracking every mappings of the
pages.

Anyway, ok, we could consider supporting unmapped pages, but I'm unsure why and
how much it is necessary.  After all, who could access unmapped pages?  Could
you give me more details on the needs for access monitoring of the unmapped
pages?


Thanks,
SeongJae Park
