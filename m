Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F72C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2A4206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgBTWfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:35:13 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:59583 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729096AbgBTWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:35:13 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 4AF39FB39C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:35:11 +0000 (GMT)
Received: (qmail 15339 invoked from network); 20 Feb 2020 22:35:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Feb 2020 22:35:10 -0000
Date:   Thu, 20 Feb 2020 22:35:08 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, kvm@vger.kernel.org,
        david@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        yang.zhang.wz@gmail.com, pagupta@redhat.com,
        konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com,
        willy@infradead.org, lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, mhocko@kernel.org, vbabka@suse.cz,
        osalvador@suse.de
Subject: Re: [PATCH v17 4/9] mm: Introduce Reported pages
Message-ID: <20200220223508.GX3466@techsingularity.net>
References: <20200211224416.29318.44077.stgit@localhost.localdomain>
 <20200211224635.29318.19750.stgit@localhost.localdomain>
 <20200219145511.GS3466@techsingularity.net>
 <7d3c732d9ec7725dcb5a90c1dc8e9859fbe6ccc0.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <7d3c732d9ec7725dcb5a90c1dc8e9859fbe6ccc0.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:44:21AM -0800, Alexander Duyck wrote:
> > > +static int
> > > +page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> > > +		     unsigned int order, unsigned int mt,
> > > +		     struct scatterlist *sgl, unsigned int *offset)
> > > +{
> > > +	struct free_area *area = &zone->free_area[order];
> > > +	struct list_head *list = &area->free_list[mt];
> > > +	unsigned int page_len = PAGE_SIZE << order;
> > > +	struct page *page, *next;
> > > +	int err = 0;
> > > +
> > > +	/*
> > > +	 * Perform early check, if free area is empty there is
> > > +	 * nothing to process so we can skip this free_list.
> > > +	 */
> > > +	if (list_empty(list))
> > > +		return err;
> > > +
> > > +	spin_lock_irq(&zone->lock);
> > > +
> > > +	/* loop through free list adding unreported pages to sg list */
> > > +	list_for_each_entry_safe(page, next, list, lru) {
> > > +		/* We are going to skip over the reported pages. */
> > > +		if (PageReported(page))
> > > +			continue;
> > > +
> > > +		/* Attempt to pull page from list */
> > > +		if (!__isolate_free_page(page, order))
> > > +			break;
> > > +
> > 
> > Might want to note that you are breaking because the only reason to fail
> > the isolation is that watermarks are not met and we are likely under
> > memory pressure. It's not a big issue.
> > 
> > However, while I think this is correct, it's hard to follow. This loop can
> > be broken out of with pages still on the scatter gather list. The current
> > flow guarantees that err will not be set at this point so the caller
> > cleans it up so we always drain the list either here or in the caller.
> 
> I can probably submit a follow-up patch to update the comments. The reason
> for not returning an error is because I didn't consider it an error that
> we encountered the watermark and were not able to pull any more pages.
> Instead I considered that the "stop" point for this pass and have it just
> exit out of the loop and flush the data.
> 

I don't consider it an error and I don't think you should return an
error. The comment just needs to explain that the draining happens in
the caller in this case. That should be enough of a warning to a future
developer to double check the flow after any changes to make sure the
drain is reached.

> > While I think it works, it's a bit fragile. I recommend putting a comment
> > above this noting why it's safe and put a VM_WARN_ON_ONCE(err) before the
> > break in case someone tries to change this in a years time and does not
> > spot that the flow to reach page_reporting_drain *somewhere* is critical.
> 
> I assume this isn't about this section, but the section below?
> 

I meant something like

if (!__isolate_free_page(page, order)) {
	VM_WARN_ON_ONCE(err);
	break;
}

Because at this point it's possible there are entries that should go
through page_reporting_drain() but the caller will not call
page_reporting_drain() in the event of an error.

-- 
Mel Gorman
SUSE Labs
