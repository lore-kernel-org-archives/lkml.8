Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0220838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRSA5KKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgCaOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:07:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730466AbgCaOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585663637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtErzcoM7afpPuWAmYNyKjwkbHkmP1wrlJah8ZVehyM=;
        b=DRSA5KKUANWeyTGeCIbc+qzl2iZezBNpApO0QCc6GzHGyyO3/il1pVRdrncxWSCwyYPFEN
        bVEHvFmJf1SrRpcZ8UdtwjIZ8tMc9lPwOXenOzDXda9OLSMvVtFV7RjUv9lTPrtErM2wh5
        2EAaN5OvQYTUSM0CZJsIcsqMj/SaeXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-qMhrPfx9NACyUFVIxY4WQw-1; Tue, 31 Mar 2020 10:07:15 -0400
X-MC-Unique: qMhrPfx9NACyUFVIxY4WQw-1
Received: by mail-wm1-f71.google.com with SMTP id z24so196348wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mtErzcoM7afpPuWAmYNyKjwkbHkmP1wrlJah8ZVehyM=;
        b=KIyf3RavoDw0PEDWbGpVBk1LfFlj5RRNFc2ITKF5ky+Eqfve+lElAqWLHqlPxh/IJl
         DyYrkYA2hWyWTI+S5J2Z7A2JU/m+hy2xCcbj6UKUp3KpDcv7B4Tt+YjveiWQWMlU4fDA
         szYxaMZ8/a//TPddfeOMxI36pktbYk0/Up6vPa4OvtA73ZECM8peQjkPKXQtMdryVlwI
         OzJDgJ5tdVXuGz0r6MLul5Mog77GrxpegSBoLgo1WFekqVHQHzalXWa/bLWbrLgiedNM
         eRv9fEYYesawpZidppIFgUF6rz3iDiN8PG/UhyottMEgmVjNTRwTFb3OE4Qhdn3TkUUd
         gbOA==
X-Gm-Message-State: ANhLgQ28Z3uXBNDC9FfFzDoqyjQcm+121EthHG9+T9I81IHZW48CuQu6
        2I5UpRaogDl0ysT121mNVi9YRg6SUr7uZEy4tRj2DoHYYP5kPqD6hNgvV5I6M5xlAHCoKxkDbp9
        o6jNX/LyOznBhnfVyYAqU3fbC
X-Received: by 2002:a1c:c246:: with SMTP id s67mr3712850wmf.160.1585663634566;
        Tue, 31 Mar 2020 07:07:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvunAjTTWpk3eEB7o8y8hawt8FeOLm0WnVg1qsVj8zmmbE1v+hESAXRtWS1ID2NUECm449Ccw==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr3712744wmf.160.1585663633292;
        Tue, 31 Mar 2020 07:07:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id w9sm29228802wrk.18.2020.03.31.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:07:09 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:07:02 -0400
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
Message-ID: <20200331100359-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
> On 31.03.20 15:37, Michael S. Tsirkin wrote:
> > On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> >> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> >>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>>>>>
> >>>>>>
> >>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >>>>>>>
> >>>>>>> ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> >>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be able to make
> >>>>>>>>>> use of THP where it previously was able to. I can imagine this implies a
> >>>>>>>>>> performance degradation for some workloads. This needs a proper
> >>>>>>>>>> performance evaluation.
> >>>>>>>>>
> >>>>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>>>> That gives you exactly the given order, and if there's
> >>>>>>>>> a larger chunk available, it will split it up.
> >>>>>>>>>
> >>>>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>>>> we do not want to stress the system but if a large
> >>>>>>>>> chunk is available anyway, then we could handle
> >>>>>>>>> that more optimally by getting it all in one go.
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>> Along the lines of
> >>>>>>>>>
> >>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>
> >>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>> range.
> >>>>>>>>>
> >>>>>>>>> What do you think? Want to try implementing that?
> >>>>>>>>
> >>>>>>>> You can just start with the highest order and decrement the order until
> >>>>>>>> your allocation succeeds using alloc_pages(), which would be enough for
> >>>>>>>> a first version. At least I don't see the immediate need for a new
> >>>>>>>> kernel API.
> >>>>>>>
> >>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
> >>>>>>> completely disabled, any of these calls can sleep. After it wakes up,
> >>>>>>> we would like to get the larger order that has become available
> >>>>>>> meanwhile.
> >>>>>>>
> >>>>>>
> >>>>>> Yes, but that‘s a pure optimization IMHO.
> >>>>>> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
> >>>>>>
> >>>>>
> >>>>> Well how do you propose implement the necessary semantics?
> >>>>> I think we are both agreed that alloc_page_range is more or
> >>>>> less what's necessary anyway - so how would you approximate it
> >>>>> on top of existing APIs?
> >>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> > 
> > .....
> > 
> > 
> >>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >>>> index 26de020aae7b..067810b32813 100644
> >>>> --- a/mm/balloon_compaction.c
> >>>> +++ b/mm/balloon_compaction.c
> >>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >>>>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >>>>  
> >>>>  /*
> >>>> - * balloon_page_alloc - allocates a new page for insertion into the balloon
> >>>> - *			page list.
> >>>> + * balloon_pages_alloc - allocates a new page (of at most the given order)
> >>>> + * 			 for insertion into the balloon page list.
> >>>>   *
> >>>>   * Driver must call this function to properly allocate a new balloon page.
> >>>>   * Driver must call balloon_page_enqueue before definitively removing the page
> >>>>   * from the guest system.
> >>>>   *
> >>>> + * Will fall back to smaller orders if allocation fails. The order of the
> >>>> + * allocated page is stored in page->private.
> >>>> + *
> >>>>   * Return: struct page for the allocated page or NULL on allocation failure.
> >>>>   */
> >>>> -struct page *balloon_page_alloc(void)
> >>>> +struct page *balloon_pages_alloc(int order)
> >>>>  {
> >>>> -	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> >>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>> -				       __GFP_NOWARN);
> >>>> -	return page;
> >>>> +	struct page *page;
> >>>> +
> >>>> +	while (order >= 0) {
> >>>> +		page = alloc_pages(balloon_mapping_gfp_mask() |
> >>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>> +				   __GFP_NOWARN, order);
> >>>> +		if (page) {
> >>>> +			set_page_private(page, order);
> >>>> +			return page;
> >>>> +		}
> >>>> +		order--;
> >>>> +	}
> >>>> +	return NULL;
> >>>>  }
> >>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >>>>  
> >>>>  /*
> >>>>   * balloon_page_enqueue - inserts a new page into the balloon page list.
> >>>
> >>>
> >>> I think this will try to invoke direct reclaim from the first iteration
> >>> to free up the max order.
> >>
> >> %__GFP_NORETRY: The VM implementation will try only very lightweight
> >> memory direct reclaim to get some memory under memory pressure (thus it
> >> can sleep). It will avoid disruptive actions like OOM killer.
> >>
> >> Certainly good enough for a first version I would say, no?
> > 
> > Frankly how well that behaves would depend a lot on the workload.
> > Can regress just as well.
> > 
> > For the 1st version I'd prefer something that is the least disruptive,
> > and that IMHO means we only trigger reclaim at all in the same configuration
> > as now - when we can't satisfy the lowest order allocation.
> 
> Agreed.
> 
> > 
> > Anything else would be a huge amount of testing with all kind of
> > workloads.
> > 
> 
> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
> GFP_TRANSHUGE_LIGHT)

That will improve the situation when reclaim is not needed, but leave
the problem in place for when it's needed: if reclaim does trigger, we
can get a huge free page and immediately break it up.

So it's ok as a first step but it will make the second step harder as
we'll need to test with reclaim :).


> -- 
> Thanks,
> 
> David / dhildenb

