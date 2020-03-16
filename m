Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45337C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4F220679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JymR0FKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbgCPVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:39:17 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33312 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgCPVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:39:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id dw20so4388947pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iv7KMVJA85Sx1LgEUzFaUAJSP9avw45LZ2+zg6JYxC0=;
        b=JymR0FKoBkS7vFA9Y9eHf56KJX5/lpQ6CnOhgF4ApCmOkhRuyrt/tL+iiadfwjJfJb
         0QctrffzOqb8ejQptBMkab9Rqpl3CarXsDaZ9ksnHBUqU7skAHWnSLQen6ETTKRGEuof
         BzCuM+OwkZp3Ch5ZEpAtllltH1eg6qJeID636d9MVp5u1cWvdE7WgeC3RiH3ciFUpFOq
         tFM8On4+pa4wgQC0Y0NOqH9DjNheis+PvpoIT4YvayIUUxuFkLtgk7xdK+q8u0EVMtkP
         7HA4xETo44jU6jZaQk7aIufFLMcMZAHfyl0iCni+AiWbGgvEwLgUCFiWzQzTfxkAmzWy
         e5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iv7KMVJA85Sx1LgEUzFaUAJSP9avw45LZ2+zg6JYxC0=;
        b=L8GlNx8waDSrdDOPrS7KJlvRZWdcXEoKU/n8wUr91A2/vNflVrkuAQ50Wmf3gcqcFu
         Zns4kcRa8U/cL0NG0PzXyMrXbUuPHH3MNiqCpPVbk2+XYuHzDpb0Dd/xmBK02UcB6ATL
         9xBwy8Gub17t6p1UgoRrD6RS/qkMW9fixdw44JvFXe/Kix0i8608/l4IQUhctyL/9mXo
         qtdRVUH1L+rVfYNLDbqBuISxjPbuJa1M0inMX3xLNoLLsCkqlVCJzftVC+RG8gXYHvdd
         7O7YThenZvoJvyXw2PQG81iiawiXfeL5qvS2LIFG4EJWHk47GNYj9+xIEi5DGZbtTlh0
         YZug==
X-Gm-Message-State: ANhLgQ3u0DLcMpCLIdE7FhOZwVOr3zcNNInTPXeX77hPxc6SAJxQ+0V7
        jEzs0lb5CVCPlv9x82qVKPM=
X-Google-Smtp-Source: ADFU+vvPWLU8A4OXFX2ZE53ogKTzeu6QmkvmI3lQ/esLaVRKUv1TXt0q6nzE5CdBuByH5H8iYYu0Jg==
X-Received: by 2002:a17:90a:c482:: with SMTP id j2mr1617116pjt.71.1584394755228;
        Mon, 16 Mar 2020 14:39:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c16sm635317pfn.86.2020.03.16.14.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 14:39:14 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:39:27 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     m.szyprowski@samsung.com, hch@lst.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316213923.GA18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thank you for the inputs.

On Mon, Mar 16, 2020 at 12:12:08PM +0000, Robin Murphy wrote:
> On 2020-03-14 12:00 am, Nicolin Chen wrote:
> > More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> > only a handful of drivers call dma_set_seg_boundary(). This means
> > that most drivers have a 4GB segmention boundary because DMA API
> > returns DMA_BIT_MAKS(32) as a default value, though they might be
> > able to handle things above 32-bit.
> 
> Don't assume the boundary mask and the DMA mask are related. There do exist
> devices which can DMA to a 64-bit address space in general, but due to
> descriptor formats/hardware design/whatever still require any single
> transfer not to cross some smaller boundary. XHCI is 64-bit yet requires
> most things not to cross a 64KB boundary. EHCI's 64-bit mode is an example
> of the 4GB boundary (not the best example, admittedly, but it undeniably
> exists).

I see. But for those cases, they should set seg_boundary_mask in
the drivers, in my opinion, because only they know what hardware
limits are, same as they set dma_mask and coherent_dma_mask.

The reason for I picked dma_mask was because we won't likely hit
the boundary, if it's >= dma_mask -- maybe I am wrong here.

> > This might result in a situation that iommu_map_sg() cuts an IOVA
> > region, larger than 4GB, into discontiguous pieces and creates a
> > faulty IOVA mapping that overlaps some physical memory being out
> > of the scatter list, which might lead to some random kernel panic
> > after DMA overwrites that faulty IOVA space.
> 
> If that's really a problem, then what about users who set a non-default
> mask?

I got a (downstream) bug report from our GPU side. I am not 100%
sure if it's a real world case. But I can't simply ignore -- even
if it's not at this point, sooner or later it'd be.

Not quite getting what could be a user case for non-default mask.
Yet, whoever sets the mask should take the responsibility for any
bad thing happens.

> Furthermore, scatterlist segments are just DMA duffers - if there is no
> IOMMU and a device accesses outside a buffer, Bad Things can and will
> happen; if the ends of the buffer don't line up exactly to page boundaries
> even with an IOMMU, if the device accesses outside the buffer then Bad
> Things can happen; even if an IOMMU can map a buffer perfectly, accesses
> outside it will either hit other buffers or generate unexpected faults,
> which are both - you guessed it - Bad Things.
> 
> In short, if this is happening then something is certainly broken, but it
> isn't the DMA layer.

I don't mean DMA API should be blamed for bad thing happening.
Yet, it sets the 32-bit boundary by returning in the get(), so
it's just easier to do the flu-shot in the API; otherwise, we
will end up with patching every single driver. Maybe not quite
a lot at this point, but there will be potentially.

> > We have CONFIG_DMA_API_DEBUG_SG in kernel/dma/debug.c that checks
> > such situations to prevent bad things from happening. However, it
> > is not a mandatory check. And one might not think of enabling it
> > when debugging a random kernel panic until figuring out that it's
> > related to iommu_map_sg().
> > 
> > A safer solution may be to align the default segmention boundary
> > with the configured dma_mask, so DMA API may create a contiguous
> > IOVA space as a device "expect" -- what tries to make sense is:
> > Though it's device driver's responsibility to set dma_parms, it
> > is not fair or even safe to apply a 4GB boundary here, which was
> > added a decade ago to work for up-to-4GB mappings at that time.
> > 
> > This patch updates the default segment_boundary_mask by aligning
> > it with dma_mask.
> 
> Why bother even interrogating the device? You can trivially express "no
> limit" as "~0UL", which is arguably less confusing than pretending this
> bears any relation to DMA masks. However, like Christoph I'm concerned that
> we don't know how many drivers are relying on the current default (and to a
> lesser extent that it leads to a subtle difference in behaviour between
> 32-bit PAE and 'proper' 64-bit builds).

I stated the reason in my first inline reply. But I don't have a
problem for "~0UL", if it feels less confusing to most of people.

And I agree with the concern. Yet we still need to do something,
right? Is there any other value that we may rely on, rather than
dma_mask, even if just for safety? Or would it be possible for us
to warn user when mapping gets out of the given physical address
space, since this is the point when thing goes wrong?

> And in the specific case of iommu-dma, this only comes into the picture at
> all if a single scatterlist maps more than 4GB at once, which isn't exactly
> typical streaming DMA behaviour - given that that implies a rather absurd
> figure of more than 65536 entries at the default max_segment_size, the
> relevant device probably doesn't want to be relying on the default dma_parms
> in the first place.

From my point of view, when a device doesn't set dma_params but
uses the default one, it sounds like "I don't have such a limit
in my hardware so you can just give me whatever you can prepare
for me", instead of "I am just a non-absurd case" :)

Overall, I do see a fear of regression for touching the default
segmentation boundary mask. At least I want to see if there can
be anything that we can or will likely do in the future, rather
than adding dma_set_seg_boundary() to all the drivers.

> [ I though I'd replied to your previous mail already; let me go see what
> happened to that... ]

I did send a related bug-reporting email a couple of weeks ago:
https://lists.linuxfoundation.org/pipermail/iommu/2020-March/042220.html

Yet have not seen any reply.

Thanks a lot!

> Robin.
> 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >   include/linux/dma-mapping.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 330ad58fbf4d..0df0ee92eba1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
> >   {
> >   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
> >   		return dev->dma_parms->segment_boundary_mask;
> > -	return DMA_BIT_MASK(32);
> > +	return (unsigned long)dma_get_mask(dev);
> >   }
> >   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> > 
