Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F7D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgHSMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:54:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbgHSMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:54:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53506ADC4;
        Wed, 19 Aug 2020 12:54:53 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:54:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 02/11] mm/memory_hotplug: enforce section granularity
 when onlining/offlining
Message-ID: <20200819125425.GJ5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-3-david@redhat.com>
 <20200819123743.GF5422@dhcp22.suse.cz>
 <d9e82d2e-0786-ebfd-acc3-7dcc5ec6ad9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e82d2e-0786-ebfd-acc3-7dcc5ec6ad9b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 14:43:28, David Hildenbrand wrote:
> On 19.08.20 14:37, Michal Hocko wrote:
> > On Wed 19-08-20 12:11:48, David Hildenbrand wrote:
> >> Already two people (including me) tried to offline subsections, because
> >> the function looks like it can deal with it. But we really can only
> >> online/offline full sections (e.g., we can only mark full sections
> >> online/offline via SECTION_IS_ONLINE).
> >>
> >> Add a simple safety net that to document the restriction now. Current users
> >> (core and powernv/memtrace) respect these restrictions.
> > 
> > I do agree with the warning because it clarifies our expectations
> > indeed. Se below for more questions.
> > 
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory_hotplug.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index c781d386d87f9..6856702af68d9 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -801,6 +801,11 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> >>  	int ret;
> >>  	struct memory_notify arg;
> >>  
> >> +	/* We can only online full sections (e.g., SECTION_IS_ONLINE) */
> >> +	if (WARN_ON_ONCE(!nr_pages ||
> >> +			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
> >> +		return -EINVAL;
> > 
> > This looks looks unnecessarily cryptic to me. Do you want to catch full
> > section operation that doesn't start at the usual section boundary? If
> > yes the above doesn't work work unless I am missing something.
> > 
> > Why don't you simply WARN_ON_ONCE(nr_pages % PAGES_PER_SECTION).
> > !nr_pages doesn't sound like something interesting to care about or why
> > do we care?
> > 
> 
> Also the start pfn has to be section aligned, so we always cover fully
> aligned sections (e.g., not two partial ones).

OK, I've misread your intention. I thought that we check for the start
pfn prior to this warning but we only do that after.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
