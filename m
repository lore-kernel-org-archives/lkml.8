Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C996C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2840020707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtJISmEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgHZPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:15:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbgHZPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598454915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5sNgrzn5FhTxLM1sS1TXXuO7hObBpky+B+k/luMmaw=;
        b=YtJISmEMCGJjqGrzH9KfrvXCqvPgxffwQ0Z8VtRiPWO6FE8yFLpbavWGlALCJBLlr3/RR/
        3Py4ztnJx1KRYd+Py7Gs7odJR1pkMod4Bm8Wwf9gtWp1kbIzHE9tYcnbJyQNMBiLFM2MKV
        V8dx5qghZ+vFLCT7IhHM4atBPYmYiUo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-z4VrO4fBMU2QSCz2y6Nclg-1; Wed, 26 Aug 2020 11:15:13 -0400
X-MC-Unique: z4VrO4fBMU2QSCz2y6Nclg-1
Received: by mail-qk1-f199.google.com with SMTP id s128so630710qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5sNgrzn5FhTxLM1sS1TXXuO7hObBpky+B+k/luMmaw=;
        b=fFdybI/QdHvK67T8FSCH/tzZ3PH3uPseO0ebx0pjimJvQTvFqRReSiWNDK4pVpr+66
         CF52EA3HGDw95tJcpJmIuyUmYskafGaDFMY8fgiDKQdd8Giyfj3bjo36Iyqz99nGgkNQ
         8pE1ZE+8eslFFclrXvtor7AVdKAHHnKoYksSIqBcXe1CGr4rdQH92J0pMvH+RRDKd/Nn
         geigSbCtkveJoAZvDStuJnV6AhphBsGBws0xokiQcjd0VHrcg7iQOYRL+7c/riaps68a
         +PX68f3p/dm6Xm1wRtYS/ISYXw/GTXcL58nLahHsH464zBcE/vO9mFpIQ2YPAzHt4fZD
         WeRA==
X-Gm-Message-State: AOAM530i86a+ev4oTq8ZNhCA1zosHe/qLpokM/zAbRtDnG2ChKfvHHGt
        BRWTazDtItfQPBUT7BitYNBa+3Z1HkmHKGbjbaO2HRGiBVnAkWbPxv6A5zR3NyRJ40xFB07N1HO
        gywkZ7YZHcY7uizdys6H3wUon
X-Received: by 2002:ad4:41c9:: with SMTP id a9mr14376482qvq.171.1598454912565;
        Wed, 26 Aug 2020 08:15:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8D+KxCEvE3v1gysX35rDUKFgHfo42TjV0oOlLWCA309rI6rx4ComNW4vhIgH0v5SazHqK1Q==
X-Received: by 2002:ad4:41c9:: with SMTP id a9mr14376450qvq.171.1598454912268;
        Wed, 26 Aug 2020 08:15:12 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id g21sm2218058qts.18.2020.08.26.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:15:10 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:15:09 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Maoming (maoming, Cloud Infrastructure Service Product Dept.)" 
        <maoming.maoming@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        wangyunjian <wangyunjian@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= V2] vfio
 dma_map/unmap: optimized for hugetlbfs pages
Message-ID: <20200826151509.GD8235@xz-x1>
References: <20200814023729.2270-1-maoming.maoming@huawei.com>
 <20200825205907.GB8235@xz-x1>
 <8B561EC9A4D13649A62CF60D3A8E8CB28C2D9ABB@dggeml524-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8B561EC9A4D13649A62CF60D3A8E8CB28C2D9ABB@dggeml524-mbx.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:56:43PM +0000, Maoming (maoming, Cloud Infrastructure Service Product Dept.) wrote:
> > +	/*
> > +	 * Unlike THP, the splitting should not happen for hugetlb pages.
> > +	 * Since PG_reserved is not relevant for compound pages, and the pfn of
> > +	 * PAGE_SIZE page which in hugetlb pages is valid,
> > +	 * it is not necessary to check rsvd for hugetlb pages.
> > +	 * We do not need to alloc pages because of vaddr and we can finish all
> > +	 * work by a single operation to the head page.
> > +	 */
> > +	atomic_add(contiguous_npage, compound_pincount_ptr(head));
> > +	page_ref_add(head, contiguous_npage);
> > +	mod_node_page_state(page_pgdat(head), NR_FOLL_PIN_ACQUIRED, 
> > +contiguous_npage);
> 
> I think I asked this question in v1, but I didn't get any answer... So I'm trying again...
> 
> Could I ask why manual referencing of pages is done here rather than using
> pin_user_pages_remote() just like what we've done with vaddr_get_pfn(), and let
> try_grab_page() to do the page reference and accountings?
> 
> I feel like this at least is against the FOLL_PIN workflow of gup, because those FOLL_PIN paths were bypassed, afaict.
> 
> 
> Hi,
> My apologies for not answering your question.
> As I understand, pin_user_pages_remote() might spend much time.
> Because all PAGE_SIZE-pages in a hugetlb page are pinned one by one in pin_user_pages_remote() and try_grab_page().
> So I think maybe we can use these simple code to do all work.
> Am I wrong? And is there something else we can use? For example :pin_user_pages_fast()

Yeah I can understand your concern, however so far it's not about the perf but
correctness.  Documentation/core-api/pin_user_pages.rst tells us that we should
always use pin_user_page*() APIs to pin DMA pages (with FOLL_LONGTERM).  That's
something we should follow for now, otherwise the major logic of either
FOLL_PIN or FULL_LONGTERM could be bypassed without being noticed.

I'm not sure whether the perf issue is a big one.  So have you tried the pin
page APIs first and did some measurement?  There is indeed a tight loop in
follow_hugetlb_page() however not sure how much it'll affect VFIO_IOMMU_MAP_DMA
in general.  Even if we want to do something, it seems to be more suitable to
be done inside follow_hugetlb_page() rather than in vfio, imho.

Another comment is about the design of the whole patch - I think Alex commented
on that too on the awkwardness on appending the hugetlbfs logic to the end of
the existing logic.  Considering that current logic of vfio_pin_pages_remote()
is "let's pin some pages as long as continuous", not sure whether we can make
it into:

vfio_pin_pages_remote()
{
  if (PageHuge(first_page))
    vfio_pin_pages_hugetlbfs();
  else
    vfio_pin_pages_normal();
}

The thing is, if the 1st page is normal page, then the follow-up pages
shouldn't normally be hugetlbfs pages so they won't be physically continuous.
Vice versa.  In other words, each call to vfio_pin_pages_remote() should only
handle only one type of page after all.  So maybe we can diverge them at the
beginning of the call directly.

-- 
Peter Xu

