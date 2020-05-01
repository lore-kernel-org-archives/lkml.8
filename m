Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49349C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B22216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UntPIa0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgEATBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729766AbgEATBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:01:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B0C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 12:01:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c124so547916oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMHcXNrz3zhrHnqit232OJlMzuARuHoUe7nsiYDOkco=;
        b=UntPIa0Cvl/kGm1Feg2IwMKj/LyidTxG24GKd+jWt7NC0FWh32Mo+L7v/raeC6ovRf
         ADYVNuFPCd+kiw17nIQhzCbWAVAukYbQ+8UmP+ySXXb2ziBYjBruuXz+8O0yFE+gBjpE
         zkeFaW/GLk8b2Lz5UX5r5JfawXzw+4HhNTZtEQgpRPA97wluyD/i17WepzTgof+gACX9
         n5n4GewjabnbZRDxX6DKw4084Q4FcSuexAMrnh6DZQ4QRsFyoQaBLXWdpNkv2QfdjXWi
         B9qn836vftMISEpaE1gzPC8ddaRZgavhorj7xAbff9tWbwKlIyEMQlabcYNnOwDE4YZ8
         qklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMHcXNrz3zhrHnqit232OJlMzuARuHoUe7nsiYDOkco=;
        b=C1i6XdpelA27iVrYS2VzIaJceG6/Y1zuNyIdri5uoJrSwA2Hfjs4SS2wzhXCiFlT1t
         aaIpGilxZlfYl4ehBLuflatTX0c1Eh3TTJE2wSXJHF+ItjOShEAKL584Z84zp+LjGki/
         D5DdnlrjNYOxpPB+/ggVVA1vpapCyNHy2dGEQ+r99NGxojE1bhDo1Hv21y2v5fc4WLvL
         8CRgPGiYt7cpwAzRT0HFR3FwicPooVe17UANtX2dEhrcrQnIMO/DF61kBS2suQk87/aN
         t5y9VxNh78NNEPlH2TpYJ5fOsB7vdD0iY0i9ARwmEt9Uv2c1PhKPeg8jXECn6CpMeSdE
         iLGw==
X-Gm-Message-State: AGi0PuYv2cvtBOUoojRlh8YfatpQIWr/eeQNErMYHUecyv2UUSMpqMEB
        sSKjVEj8pTRMG97+3JRmcxqMceiZ7svEzDyfrnv5Cg==
X-Google-Smtp-Source: APiQypJYvqKKFvfOFQUK1ntLEscYvQrHeBF7fGsVt3flNjLdjYuuXkdbUHFmseAznhnmIL+vzVVh7igl6t18YXGu6mU=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr838335oiy.10.1588359710953;
 Fri, 01 May 2020 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org> <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
 <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
In-Reply-To: <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 May 2020 12:01:40 -0700
Message-ID: <CALAqxLU6kmvJ+xPCFzc3N+RNMv4g=L9bmzgE0wrOXefiGfPoHg@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA
 regions tagged with "linux,cma-heap"
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm <linux-mm@kvack.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 4:08 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-05-01 11:21 am, Brian Starkey wrote:
> > Hi John,
> >
> > On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
> >> This patch reworks the cma_heap initialization so that
> >> we expose both the default CMA region and any CMA regions
> >> tagged with "linux,cma-heap" in the device-tree.
> >>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >> Cc: "Andrew F. Davis" <afd@ti.com>
> >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >> Cc: Liam Mark <lmark@codeaurora.org>
> >> Cc: Pratik Patel <pratikp@codeaurora.org>
> >> Cc: Laura Abbott <labbott@redhat.com>
> >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> >> Cc: Chenbo Feng <fengc@google.com>
> >> Cc: Alistair Strachan <astrachan@google.com>
> >> Cc: Sandeep Patil <sspatil@google.com>
> >> Cc: Hridya Valsaraju <hridya@google.com>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Cc: Robin Murphy <robin.murphy@arm.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: linux-mm@kvack.org
> >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> >> ---
> >>   drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
> >>   1 file changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> >> index 626cf7fd033a..dd154e2db101 100644
> >> --- a/drivers/dma-buf/heaps/cma_heap.c
> >> +++ b/drivers/dma-buf/heaps/cma_heap.c
> >> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
> >>   {
> >>      struct cma_heap *cma_heap;
> >>      struct dma_heap_export_info exp_info;
> >> +    struct cma *default_cma = dev_get_cma_area(NULL);
> >> +
> >> +    /* We only add the default heap and explicitly tagged heaps */
> >> +    if (cma != default_cma && !cma_dma_heap_enabled(cma))
> >> +            return 0;
> >
> > Thinking about the pl111 thread[1], I'm wondering if we should also
> > let drivers call this directly to expose their CMA pools, even if they
> > aren't tagged for dma-heaps in DT. But perhaps that's too close to
> > policy.
>
> That sounds much like what my first thoughts were - apologies if I'm
> wildly off-base here, but as far as I understand:
>
> - Device drivers know whether they have their own "memory-region" or not.
> - Device drivers already have to do *something* to participate in dma-buf.
> - Device drivers know best how they make use of both the above.
> - Therefore couldn't it be left to drivers to choose whether to register
> their CMA regions as heaps, without having to mess with DT at all?

I guess I'm not opposed to this. But I guess I'd like to see some more
details? You're thinking the pl111 driver would add the
"memory-region" node itself?

Assuming that's the case, my only worry is what if that memory-region
node isn't a CMA area, but instead something like a carveout? Does the
driver need to parse enough of the dt to figure out where to register
the region as a heap?

thanks
-john
