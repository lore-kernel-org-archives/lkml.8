Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9967CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBEC20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxDqJ5Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgCaP2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:28:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46284 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727703AbgCaP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585668527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbjZ/8kYKp7eRMJMyV+34cf5N5B3hMsmVB1uhWILGRg=;
        b=RxDqJ5FcArVBv/cUieog7tlvQdhbn4pw7yXTI6jw9mgpmFCwpVLtEGKDsFDFi6ujcrUVKg
        ucOx1yHI4RqFTnaoIsfDbFJRzzjE8Dcy/ePO7vR6GLwLYZCVN0qLsQrIY7cxGMah+Mr1DM
        LASzxeDhtETYxrJaZSCg6gCVbpvBvnI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-1cmEDf1oOx-ws3UXrj8qGg-1; Tue, 31 Mar 2020 11:28:46 -0400
X-MC-Unique: 1cmEDf1oOx-ws3UXrj8qGg-1
Received: by mail-wr1-f71.google.com with SMTP id h14so13106287wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbjZ/8kYKp7eRMJMyV+34cf5N5B3hMsmVB1uhWILGRg=;
        b=eg62f04vGr0YMDuMG6tDZFdbVyqi+TCG7i805XCtxYsw98DJU8gK7f2Nv9rcH9mTew
         +7yXK84An4HR29p0dRswoAO/UAOtCiiZattXPfS5h+N9z9yxpCyYznEvVdFlIlcWBSpU
         abw2I6HldrElZ7PVuTY+/gIwrz7t0ygviSCGn1EPdNmOP8s+R5nUadCn0quQrKjwOM/z
         WWJpTJ6XOsby43CPvOTjNplYNxbi1MYB9tq8kpCqvRTy1pCUjmtQp9nkCNKe9mc+/kDp
         FJ4tltsCuJitNg++4IMur9HCUFLCOhloFFfDo4IYUUHz/Z0i1UqYyftxZcK4GAYns2dU
         Zt7Q==
X-Gm-Message-State: ANhLgQ3qXcZCLj6WtghHpQou50hQXHKZeAwHliInCKLkUbqAQpTu/ZVx
        1Z8rYbRyhWB44/4fewIk+V5oNcJJ06Y7nD1yHUuyXvY8/niTbTW3+KRSSIvBqz4byAStB2iTXg2
        TaLtB3M6l/uunyuxqBayUks8+
X-Received: by 2002:a1c:c246:: with SMTP id s67mr4069846wmf.160.1585668525068;
        Tue, 31 Mar 2020 08:28:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuMBsfYL4fBH/dyfa7LMsqKN06EtOubW3BDQDDF16qT0lG1gYEHk80ZPDmqIeS9K1EOzGhzsw==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr4069822wmf.160.1585668524863;
        Tue, 31 Mar 2020 08:28:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id w7sm26825926wrr.60.2020.03.31.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:28:44 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:28:41 -0400
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
Message-ID: <20200331112730-mutt-send-email-mst@kernel.org>
References: <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <20200331101117-mutt-send-email-mst@kernel.org>
 <118bc13b-76b2-f5a1-6aca-65bd10a22f6c@redhat.com>
 <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dc8bad-05e5-6085-525c-ce9fded672cc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:34:48PM +0200, David Hildenbrand wrote:
> On 31.03.20 16:29, David Hildenbrand wrote:
> > On 31.03.20 16:18, Michael S. Tsirkin wrote:
> >> On Tue, Mar 31, 2020 at 04:09:59PM +0200, David Hildenbrand wrote:
> >>
> >> ...
> >>
> >>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new API.
> >>>>>>>>>>>>>> Along the lines of
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
> >>>>>>>>>>>>>>                    unsigned int max_order, unsigned int *order)
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> the idea would then be to return at a number of pages in the given
> >>>>>>>>>>>>>> range.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What do you think? Want to try implementing that?
> >>
> >> ..
> >>
> >>> I expect the whole "steal huge pages from your guest" to be problematic,
> >>> as I already mentioned to Alex. This needs a performance evaluation.
> >>>
> >>> This all smells like a lot of workload dependent fine-tuning. :)
> >>
> >>
> >> So that's why I proposed the API above.
> >>
> >> The idea is that *if we are allocating a huge page anyway*,
> >> rather than break it up let's send it whole to the device.
> >> If we have smaller pages, return smaller pages.
> >>
> > 
> > Sorry, I still fail to see why you cannot do that with my version of
> > balloon_pages_alloc(). But maybe I haven't understood the magic you
> > expect to happen in alloc_page_range() :)
> > 
> > It's just going via a different inflate queue once we have that page, as
> > I stated in front of my draft patch "but with an
> > optimized reporting interface".
> > 
> >> That seems like it would always be an improvement, whatever the
> >> workload.
> >>
> > 
> > Don't think so. Assume there are plenty of 4k pages lying around. It
> > might actually be *bad* for guest performance if you take a huge page
> > instead of all the leftover 4k pages that cannot be merged. Only at the
> > point where you would want to break a bigger page up and report it in
> > pieces, where it would definitely make no difference.
> 
> I just understood what you mean :) and now it makes sense - it avoids
> exactly that. Basically
> 
> 1. Try to allocate order-0. No split necessary? return the page
> 2. Try to allocate order-1. No split necessary? return the page
> ...
> 
> up to MAX_ORDER - 1.
> 
> Yeah, I guess this will need a new kernel API.

Exactly what I meant. And whever we fail and block for reclaim, we
restart this.

> 
> -- 
> Thanks,
> 
> David / dhildenb

