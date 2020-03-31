Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5440AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2820784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3S7DA5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgCaNh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:37:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730216AbgCaNh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585661845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14WjY7npFb95dfs4u91xTUnm/drEuiMIwCcYb9+aV0E=;
        b=R3S7DA5kvMu/+ssV72RMKZgz/uHJ/MRyOBJ4gFxubl4248DQhxwPIfHIGxM3NxivsJcB4a
        P9tX5pj9KL0HhCF1i6TSimzdrbn0MynNk9RPcDVUQgNrKwgwAKBDWEuZCuXZ9uHiUtRv3d
        nyHM/WoHeFSldFfd6AWJ4IIBRhPzUto=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-TId9PnWVMDe-OFfS6EgrFw-1; Tue, 31 Mar 2020 09:37:24 -0400
X-MC-Unique: TId9PnWVMDe-OFfS6EgrFw-1
Received: by mail-wr1-f71.google.com with SMTP id c8so11102133wru.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14WjY7npFb95dfs4u91xTUnm/drEuiMIwCcYb9+aV0E=;
        b=CHZgvbq2IJF+D1z5yJ9PdiI2yXRWL0fH7+VLtP7mwMnUn/xgbQHTHum3E+89zM5Vu9
         sJys3Qh5v6t3cs8lYKFONBsAVw4W2K/OuciEM5EeN0IdNrX4Cc1asgMY2M55wpHzja7k
         3pzPW1dNVCmkZVjJ7ZUtE47Pis/FFxEJOGxL4bf0Bpm70fpJuoHq1enDYQYx0gmmZUCT
         MQM/Bk2/zhKHzaN1GgbLzaDcpixH+3FDJYhW82gsHbqENOo0QvAt1U5jTz2gLoAICQ3E
         6VsjPLsQddqUIC+m5i+tpvc1sZchhV79vk0NZfsYL9v4F1qop9ew+kwXPw+7tJ2cwOWU
         hhkg==
X-Gm-Message-State: AGi0PuZZY0llsjYLKATNqDLxD6VCTZXSnsR4kYf8g26capOhVVYM9DUo
        Xvtwh0jMCDw8fyCdykdQ/90NOgpclmfz9A+xf96LWGIQdQTQcBpnZu3djNY1SGQA3UZMGVSRTL6
        zz//wqirloeicd28dI18K9lFd
X-Received: by 2002:a05:600c:294d:: with SMTP id n13mr338176wmd.155.1585661843028;
        Tue, 31 Mar 2020 06:37:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHOVQZvcKj5qnhJ3T+XcRb/jgIhPeq4jvZUSNB0Q2o5aF7+L0uVNJTtAjoRsYEjD9/meV5Hg==
X-Received: by 2002:a05:600c:294d:: with SMTP id n13mr338144wmd.155.1585661842712;
        Tue, 31 Mar 2020 06:37:22 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n2sm28124947wro.25.2020.03.31.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:37:22 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:37:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hui Zhu <teawater@gmail.com>, jasowang@redhat.com,
        akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200331093300-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>>>
> >>>>
> >>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >>>>>
> >>>>> ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> >>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>>>>>> mapping (THP in guest and host) is gone. The guest won't be able to make
> >>>>>>>> use of THP where it previously was able to. I can imagine this implies a
> >>>>>>>> performance degradation for some workloads. This needs a proper
> >>>>>>>> performance evaluation.
> >>>>>>>
> >>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>> That gives you exactly the given order, and if there's
> >>>>>>> a larger chunk available, it will split it up.
> >>>>>>>
> >>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>> we do not want to stress the system but if a large
> >>>>>>> chunk is available anyway, then we could handle
> >>>>>>> that more optimally by getting it all in one go.
> >>>>>>>
> >>>>>>>
> >>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>> Along the lines of
> >>>>>>>
> >>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>
> >>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>> range.
> >>>>>>>
> >>>>>>> What do you think? Want to try implementing that?
> >>>>>>
> >>>>>> You can just start with the highest order and decrement the order until
> >>>>>> your allocation succeeds using alloc_pages(), which would be enough for
> >>>>>> a first version. At least I don't see the immediate need for a new
> >>>>>> kernel API.
> >>>>>
> >>>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
> >>>>> completely disabled, any of these calls can sleep. After it wakes up,
> >>>>> we would like to get the larger order that has become available
> >>>>> meanwhile.
> >>>>>
> >>>>
> >>>> Yes, but that‘s a pure optimization IMHO.
> >>>> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
> >>>>
> >>>
> >>> Well how do you propose implement the necessary semantics?
> >>> I think we are both agreed that alloc_page_range is more or
> >>> less what's necessary anyway - so how would you approximate it
> >>> on top of existing APIs?
> >> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h

.....


> >> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >> index 26de020aae7b..067810b32813 100644
> >> --- a/mm/balloon_compaction.c
> >> +++ b/mm/balloon_compaction.c
> >> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >>  
> >>  /*
> >> - * balloon_page_alloc - allocates a new page for insertion into the balloon
> >> - *			page list.
> >> + * balloon_pages_alloc - allocates a new page (of at most the given order)
> >> + * 			 for insertion into the balloon page list.
> >>   *
> >>   * Driver must call this function to properly allocate a new balloon page.
> >>   * Driver must call balloon_page_enqueue before definitively removing the page
> >>   * from the guest system.
> >>   *
> >> + * Will fall back to smaller orders if allocation fails. The order of the
> >> + * allocated page is stored in page->private.
> >> + *
> >>   * Return: struct page for the allocated page or NULL on allocation failure.
> >>   */
> >> -struct page *balloon_page_alloc(void)
> >> +struct page *balloon_pages_alloc(int order)
> >>  {
> >> -	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> >> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >> -				       __GFP_NOWARN);
> >> -	return page;
> >> +	struct page *page;
> >> +
> >> +	while (order >= 0) {
> >> +		page = alloc_pages(balloon_mapping_gfp_mask() |
> >> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >> +				   __GFP_NOWARN, order);
> >> +		if (page) {
> >> +			set_page_private(page, order);
> >> +			return page;
> >> +		}
> >> +		order--;
> >> +	}
> >> +	return NULL;
> >>  }
> >> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >>  
> >>  /*
> >>   * balloon_page_enqueue - inserts a new page into the balloon page list.
> > 
> > 
> > I think this will try to invoke direct reclaim from the first iteration
> > to free up the max order.
> 
> %__GFP_NORETRY: The VM implementation will try only very lightweight
> memory direct reclaim to get some memory under memory pressure (thus it
> can sleep). It will avoid disruptive actions like OOM killer.
> 
> Certainly good enough for a first version I would say, no?

Frankly how well that behaves would depend a lot on the workload.
Can regress just as well.

For the 1st version I'd prefer something that is the least disruptive,
and that IMHO means we only trigger reclaim at all in the same configuration
as now - when we can't satisfy the lowest order allocation.

Anything else would be a huge amount of testing with all kind of
workloads.

-- 
MST

