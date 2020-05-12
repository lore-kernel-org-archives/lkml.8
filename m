Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D6C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7850E206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589301439;
	bh=/ag5mxtMtB14O5PkrdIqEL8OuE8Gocg/7v/laprfv8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xnWDovHx7fKGyDJ+1ioOyi33UMEkQnO9W6k+isAUfHozh8yLyzd35k1uZg7IAH5hU
	 0BbEoFvUCpt62BHFS3/d38ZT+DvWWgakr5DTWue9fpl8MD14cz68P95g4XDJIAmNde
	 Fpr7m1t30DoemEIG04GubxcHUQ4XwrnC4dM944jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgELQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:37:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36196 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:37:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id t3so11003112otp.3;
        Tue, 12 May 2020 09:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wBA/X/8LEF2/kwe3eKVgHZUc/oSPTTRgLnnWRSdSQLs=;
        b=f9zX+lWL/nAnW69HFhgqo0rUJre4q5gF56HVm+z4agkVTKwFhzeUUgtyTBrEJ+BGZz
         MlAKujhLZ971mWDMRlOhHBFUt1ZdHPUlaZtLmmQjlowZDpi0kux3ZpKjswQ8UjC5qj8y
         rIbwfyUo+CYTwJp3zUaXTIkcGXVK0ROWoOvcgI9NgFYDeSEXWxQ4Uj8og91jUINQYdMX
         gzB09BhvwHAA7sPqq0/Jk2BoeK8449VyhB/xKzA86uY/41DvWY8zdgBAviT1Ir+yFLk6
         RDXgfNNvagZ9fwbL+8++DvZ4yHGqqMDvll2NYvq7m1H5sp4xrzeRmVyxCY0h59jVrl1H
         mfdg==
X-Gm-Message-State: AGi0PuZtcSjVC8WY9TrbFK8lToPMeR/qxGaVcfcKWALAYxmZeTy3byg2
        Y8sqFqHZLp1b4CFLjs9Y0A==
X-Google-Smtp-Source: APiQypJPGJFpNg4zyPPhL4TuOM3za0wjxYJWn89WKnZvHZpHJujTR9ZomHIUQRCotEkQVHzDbu3bUA==
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr18180169otn.79.1589301436443;
        Tue, 12 May 2020 09:37:16 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 61sm3538453oty.56.2020.05.12.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:37:15 -0700 (PDT)
Received: (nullmailer pid 10735 invoked by uid 1000);
        Tue, 12 May 2020 16:37:14 -0000
Date:   Tue, 12 May 2020 11:37:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA
 regions tagged with "linux,cma-heap"
Message-ID: <20200512163714.GA22577@bogus>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org>
 <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
 <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
 <CALAqxLU6kmvJ+xPCFzc3N+RNMv4g=L9bmzgE0wrOXefiGfPoHg@mail.gmail.com>
 <20200504090628.d2q32dwyg6em5pp7@DESKTOP-E1NTVVP.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504090628.d2q32dwyg6em5pp7@DESKTOP-E1NTVVP.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:06:28AM +0100, Brian Starkey wrote:
> On Fri, May 01, 2020 at 12:01:40PM -0700, John Stultz wrote:
> > On Fri, May 1, 2020 at 4:08 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2020-05-01 11:21 am, Brian Starkey wrote:
> > > > Hi John,
> > > >
> > > > On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
> > > >> This patch reworks the cma_heap initialization so that
> > > >> we expose both the default CMA region and any CMA regions
> > > >> tagged with "linux,cma-heap" in the device-tree.
> > > >>
> > > >> Cc: Rob Herring <robh+dt@kernel.org>
> > > >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > >> Cc: "Andrew F. Davis" <afd@ti.com>
> > > >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > >> Cc: Liam Mark <lmark@codeaurora.org>
> > > >> Cc: Pratik Patel <pratikp@codeaurora.org>
> > > >> Cc: Laura Abbott <labbott@redhat.com>
> > > >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> > > >> Cc: Chenbo Feng <fengc@google.com>
> > > >> Cc: Alistair Strachan <astrachan@google.com>
> > > >> Cc: Sandeep Patil <sspatil@google.com>
> > > >> Cc: Hridya Valsaraju <hridya@google.com>
> > > >> Cc: Christoph Hellwig <hch@lst.de>
> > > >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > >> Cc: Robin Murphy <robin.murphy@arm.com>
> > > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > >> Cc: devicetree@vger.kernel.org
> > > >> Cc: dri-devel@lists.freedesktop.org
> > > >> Cc: linux-mm@kvack.org
> > > >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > >> ---
> > > >>   drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
> > > >>   1 file changed, 9 insertions(+), 9 deletions(-)
> > > >>
> > > >> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> > > >> index 626cf7fd033a..dd154e2db101 100644
> > > >> --- a/drivers/dma-buf/heaps/cma_heap.c
> > > >> +++ b/drivers/dma-buf/heaps/cma_heap.c
> > > >> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
> > > >>   {
> > > >>      struct cma_heap *cma_heap;
> > > >>      struct dma_heap_export_info exp_info;
> > > >> +    struct cma *default_cma = dev_get_cma_area(NULL);
> > > >> +
> > > >> +    /* We only add the default heap and explicitly tagged heaps */
> > > >> +    if (cma != default_cma && !cma_dma_heap_enabled(cma))
> > > >> +            return 0;
> > > >
> > > > Thinking about the pl111 thread[1], I'm wondering if we should also
> > > > let drivers call this directly to expose their CMA pools, even if they
> > > > aren't tagged for dma-heaps in DT. But perhaps that's too close to
> > > > policy.
> > >
> > > That sounds much like what my first thoughts were - apologies if I'm
> > > wildly off-base here, but as far as I understand:
> > >
> > > - Device drivers know whether they have their own "memory-region" or not.
> > > - Device drivers already have to do *something* to participate in dma-buf.
> > > - Device drivers know best how they make use of both the above.
> > > - Therefore couldn't it be left to drivers to choose whether to register
> > > their CMA regions as heaps, without having to mess with DT at all?

+1, but I'm biased toward any solution not using DT. :)

> > I guess I'm not opposed to this. But I guess I'd like to see some more
> > details? You're thinking the pl111 driver would add the
> > "memory-region" node itself?
> > 
> > Assuming that's the case, my only worry is what if that memory-region
> > node isn't a CMA area, but instead something like a carveout? Does the
> > driver need to parse enough of the dt to figure out where to register
> > the region as a heap?
> 
> My thinking was more like there would already be a reserved-memory
> node in DT for the chunk of memory, appropriately tagged so that it
> gets added as a CMA region. 
> 
> The device's node would have "memory-region=<&blah>;" and would use
> of_reserved_mem_device_init() to link up dev->cma_area to the
> corresponding cma region.
> 
> So far, that's all in-place already. The bit that's missing is
> exposing that dev->cma_area to userspace as a dma_heap - so we could
> just have "int cma_heap_add(struct cma *cma)" or "int
> cma_heap_dev_add(struct device *dev)" or something exported for
> drivers to expose their device-assigned cma region if they wanted to.
> 
> I don't think this runs into the lifetime problems of generalised
> heaps-as-modules either, because the CMA region will never go away
> even if the driver does.
> 
> Alongside that, I do think the completely DT-driven approach can be
> useful too - because there may be regions which aren't associated with
> any specific device driver, that we want exported as heaps.

And they are associated with the hardware description rather than the 
userspace environment? 

Rob
