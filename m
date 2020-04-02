Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56308C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141F420784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHSvVe8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbgDBMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:37:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729213AbgDBMhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585831041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z83ZFN7U6iOT0EPOREo66Rtq033CFmiu/su55XugOps=;
        b=XHSvVe8kGfeUTcKC1dODE8gKohFTfGq3A0I70xaU5tBbEDwuFauMF+RVm4aqFArj3PByxv
        9Gg8bSLWGwmbRcoUXjK05IioKdaHlhe81KxzwQbKhzbvSGMgdUbQUa0izvWJ6ZaJjql11I
        rWU3CYZEUDTmldWCtVOWv8MkiTQlZE4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-24hSVt0xOYaed2VmhgIdSA-1; Thu, 02 Apr 2020 08:37:20 -0400
X-MC-Unique: 24hSVt0xOYaed2VmhgIdSA-1
Received: by mail-qv1-f70.google.com with SMTP id f4so2514638qvu.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 05:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z83ZFN7U6iOT0EPOREo66Rtq033CFmiu/su55XugOps=;
        b=Vue8d4JMznDBj7BQ607ogLyx115kdIQq7BdbRKAOIPi9IZd5An5fOtnxVZTnranitL
         qlFhShiyvQ64zZ5Zf5Wf8DLlk72Z4ZG4TR2Kd+UxfrJrtdNPweEJJlvxs1qkttqGHouD
         +MKMS/vgCj0HDO9Zm6NPgTu/xMMYOlU7cHFzVjue1Y/KhmXxrU+FcCbMo8zLMaDj03n2
         N1ftFix1q0hRTJgWNslVvK078K3OwUe2x/u9AzxQqpfOh0MeJhZq0dvPi84g8dZfMlis
         6Yqqej8ocmxh2rMmK8BTDg+MwGIgebAViimLTlIbL1nqgWo20vl1UIr1Gnn/yYa6mJ8t
         7wFA==
X-Gm-Message-State: AGi0PuYnET++J0jnmTJ6/RBNhOShDBSDqnOI4ZSHpLXD+6uN1+wEx6u8
        fzBwC3etBJmmxdtPEQMPf6EQntYGMLMmwHErk06zVQ/lGjoVuj/gNhRoRyW7SO+BiQVmWTI0SCe
        dJx2GXGJ9mZVGtlG84hBaN3X6
X-Received: by 2002:a37:a7cd:: with SMTP id q196mr2960688qke.447.1585831039544;
        Thu, 02 Apr 2020 05:37:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ0I00cVKswz3vNdf6Dr0WhRrTlZgEbT2Br3s+aMGt4SrYp5fv90+mvLN93pvzAK4++FO8L4w==
X-Received: by 2002:a37:a7cd:: with SMTP id q196mr2960665qke.447.1585831039221;
        Thu, 02 Apr 2020 05:37:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id 68sm3343978qkh.75.2020.04.02.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:37:17 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:37:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER
 to handle THP spilt issue
Message-ID: <20200402083630-mutt-send-email-mst@kernel.org>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <02745FD3-E30D-453B-8664-94B8EBF3B313@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02745FD3-E30D-453B-8664-94B8EBF3B313@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:00:05PM +0800, teawater wrote:
> 
> 
> > 2020年3月31日 22:07，Michael S. Tsirkin <mst@redhat.com> 写道：
> > 
> > On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
> >> On 31.03.20 15:37, Michael S. Tsirkin wrote:
> >>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand wrote:
> >>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
> >>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand wrote:
> >>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand wrote:
> >>>>>>>> 
> >>>>>>>> 
> >>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
> >>>>>>>>> 
> >>>>>>>>> ﻿On Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote:
> >>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
> >>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
> >>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So the fastest
> >>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't be able to make
> >>>>>>>>>>>> use of THP where it previously was able to. I can imagine this implies a
> >>>>>>>>>>>> performance degradation for some workloads. This needs a proper
> >>>>>>>>>>>> performance evaluation.
> >>>>>>>>>>> 
> >>>>>>>>>>> I think the problem is more with the alloc_pages API.
> >>>>>>>>>>> That gives you exactly the given order, and if there's
> >>>>>>>>>>> a larger chunk available, it will split it up.
> >>>>>>>>>>> 
> >>>>>>>>>>> But for balloon - I suspect lots of other users,
> >>>>>>>>>>> we do not want to stress the system but if a large
> >>>>>>>>>>> chunk is available anyway, then we could handle
> >>>>>>>>>>> that more optimally by getting it all in one go.
> >>>>>>>>>>> 
> >>>>>>>>>>> 
> >>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>> Along the lines of
> >>>>>>>>>>> 
> >>>>>>>>>>> struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>>>                 unsigned int max_order, unsigned int *order)
> >>>>>>>>>>> 
> >>>>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>>>> range.
> >>>>>>>>>>> 
> >>>>>>>>>>> What do you think? Want to try implementing that?
> >>>>>>>>>> 
> >>>>>>>>>> You can just start with the highest order and decrement the order until
> >>>>>>>>>> your allocation succeeds using alloc_pages(), which would be enough for
> >>>>>>>>>> a first version. At least I don't see the immediate need for a new
> >>>>>>>>>> kernel API.
> >>>>>>>>> 
> >>>>>>>>> OK I remember now.  The problem is with reclaim. Unless reclaim is
> >>>>>>>>> completely disabled, any of these calls can sleep. After it wakes up,
> >>>>>>>>> we would like to get the larger order that has become available
> >>>>>>>>> meanwhile.
> >>>>>>>>> 
> >>>>>>>> 
> >>>>>>>> Yes, but that‘s a pure optimization IMHO.
> >>>>>>>> So I think we should do a trivial implementation first and then see what we gain from a new allocator API. Then we might also be able to justify it using real numbers.
> >>>>>>>> 
> >>>>>>> 
> >>>>>>> Well how do you propose implement the necessary semantics?
> >>>>>>> I think we are both agreed that alloc_page_range is more or
> >>>>>>> less what's necessary anyway - so how would you approximate it
> >>>>>>> on top of existing APIs?
> >>>>>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> >>> 
> >>> .....
> >>> 
> >>> 
> >>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> >>>>>> index 26de020aae7b..067810b32813 100644
> >>>>>> --- a/mm/balloon_compaction.c
> >>>>>> +++ b/mm/balloon_compaction.c
> >>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
> >>>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
> >>>>>> 
> >>>>>> /*
> >>>>>> - * balloon_page_alloc - allocates a new page for insertion into the balloon
> >>>>>> - *			page list.
> >>>>>> + * balloon_pages_alloc - allocates a new page (of at most the given order)
> >>>>>> + * 			 for insertion into the balloon page list.
> >>>>>> *
> >>>>>> * Driver must call this function to properly allocate a new balloon page.
> >>>>>> * Driver must call balloon_page_enqueue before definitively removing the page
> >>>>>> * from the guest system.
> >>>>>> *
> >>>>>> + * Will fall back to smaller orders if allocation fails. The order of the
> >>>>>> + * allocated page is stored in page->private.
> >>>>>> + *
> >>>>>> * Return: struct page for the allocated page or NULL on allocation failure.
> >>>>>> */
> >>>>>> -struct page *balloon_page_alloc(void)
> >>>>>> +struct page *balloon_pages_alloc(int order)
> >>>>>> {
> >>>>>> -	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> >>>>>> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>>>> -				       __GFP_NOWARN);
> >>>>>> -	return page;
> >>>>>> +	struct page *page;
> >>>>>> +
> >>>>>> +	while (order >= 0) {
> >>>>>> +		page = alloc_pages(balloon_mapping_gfp_mask() |
> >>>>>> +				   __GFP_NOMEMALLOC | __GFP_NORETRY |
> >>>>>> +				   __GFP_NOWARN, order);
> >>>>>> +		if (page) {
> >>>>>> +			set_page_private(page, order);
> >>>>>> +			return page;
> >>>>>> +		}
> >>>>>> +		order--;
> >>>>>> +	}
> >>>>>> +	return NULL;
> >>>>>> }
> >>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> >>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
> >>>>>> 
> >>>>>> /*
> >>>>>> * balloon_page_enqueue - inserts a new page into the balloon page list.
> >>>>> 
> >>>>> 
> >>>>> I think this will try to invoke direct reclaim from the first iteration
> >>>>> to free up the max order.
> >>>> 
> >>>> %__GFP_NORETRY: The VM implementation will try only very lightweight
> >>>> memory direct reclaim to get some memory under memory pressure (thus it
> >>>> can sleep). It will avoid disruptive actions like OOM killer.
> >>>> 
> >>>> Certainly good enough for a first version I would say, no?
> >>> 
> >>> Frankly how well that behaves would depend a lot on the workload.
> >>> Can regress just as well.
> >>> 
> >>> For the 1st version I'd prefer something that is the least disruptive,
> >>> and that IMHO means we only trigger reclaim at all in the same configuration
> >>> as now - when we can't satisfy the lowest order allocation.
> >> 
> >> Agreed.
> >> 
> >>> 
> >>> Anything else would be a huge amount of testing with all kind of
> >>> workloads.
> >>> 
> >> 
> >> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
> >> GFP_TRANSHUGE_LIGHT)
> > 
> > That will improve the situation when reclaim is not needed, but leave
> > the problem in place for when it's needed: if reclaim does trigger, we
> > can get a huge free page and immediately break it up.
> > 
> > So it's ok as a first step but it will make the second step harder as
> > we'll need to test with reclaim :).
> 
> 
> I worry that will increases the allocation failure rate for large pages.
> 
> I tried alloc 2M memory without __GFP_RECLAIM when I wrote the VIRTIO_BALLOON_F_THP_ORDER first version.
> It will fail when I use usemem punch-holes function generates 400m fragmentation pages in the guest kernel.
> 
> What about add another option to balloon to control with __GFP_RECLAIM or without it?
> 
> Best,
> Hui

That is why I suggested a new API so we do not fragment memory.

> > 
> > 
> >> -- 
> >> Thanks,
> >> 
> >> David / dhildenb

