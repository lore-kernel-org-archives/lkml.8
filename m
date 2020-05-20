Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8973C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D16620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CjbbxN8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETNuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:50:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B4C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:50:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so2613459wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTWjeswxH0l98lyAxNqRNJAIOGggfbasSyUWJF3O/mI=;
        b=CjbbxN8hygEVQLVlGrH7l+/V/HdHKau/Ebvqwk35rM13T4gaQNRQy7FepGskwmW3na
         +RHf7e1uuO7h0fovTB5z0nEvtSTAPxYrR+kFXWhjKT9xQIyhn1hzLCv7DYoGzBdAU2cy
         /DVgXsWaQCgLoKd3OHE1X0o8+YbdAu18dWgfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTWjeswxH0l98lyAxNqRNJAIOGggfbasSyUWJF3O/mI=;
        b=rKfvJsvJMuaDUTlHbi+edvFnck5gATG7h6o5FndzOk9oUPun6U25CgUUtJh87jCB/l
         UW29prKGfzLyrf56N2JHMZaK2gtmGI2i93s2eorjIVs269d/PkCxqd2M3OGmZ7ykLtOF
         PPd2EFSclK69VQpBex39UH+lAFtNIihWdi6jYE2GDzvveZYvXQyX0rJqkFpk23WLodxD
         EKuzRlhzGEAaoLxxIszWK/tR12P+XwNZjs7IQbQSQPrpK0lgPcZhW++QaBXJp73W/tan
         3K/TzF0kAsKosoN/KmChA1MCrpqiGGMhs78qm+ERsBCXHBrtZ19cpjXXMuAtdCQrcnl0
         i0fw==
X-Gm-Message-State: AOAM532X4xx5hwR0lpQdDaAn+HbX8wMOJ5o/QchwYqQnpAyMjm8tyTCL
        3mYFAy+ZH4lUugvuioFxzyAl5pNR3d/y+B/gE7BLUw==
X-Google-Smtp-Source: ABdhPJyaXGaSNp9tyc7HR3h1s5MPA9ExbrcjOq9FSNfXd4CqVCIoj7d0aI/ZbycoUGoC9EKycGOKogZNdnICVdwHSus=
X-Received: by 2002:a05:600c:d6:: with SMTP id u22mr4468679wmm.45.1589982649690;
 Wed, 20 May 2020 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com> <20200520054349.GB2180554@kroah.com>
In-Reply-To: <20200520054349.GB2180554@kroah.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 20 May 2020 09:50:36 -0400
Message-ID: <CA+-6iNyQFauYc0ZNbzRmao_oOZD8XM+1D0XE133HP_-zgMLzuA@mail.gmail.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma offsets
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 1:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index ac8e37cd716a..6cd916860b5f 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -493,6 +493,8 @@ struct dev_links_info {
> >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> >   *           DMA limit than the device itself supports.
> >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > + * @dma_map: Like dma_pfn_offset but used when there are multiple
> > + *           pfn offsets for multiple dma-ranges.
> >   * @dma_parms:       A low level driver may set these to teach IOMMU code about
> >   *           segment limitations.
> >   * @dma_pools:       Dma pools (if dma'ble device).
> > @@ -578,7 +580,12 @@ struct device {
> >                                            allocations such descriptors. */
> >       u64             bus_dma_limit;  /* upstream dma constraint */
> >       unsigned long   dma_pfn_offset;
> > -
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +     const void *dma_offset_map;     /* Like dma_pfn_offset, but for
> > +                                      * the unlikely case of multiple
> > +                                      * offsets. If non-null, dma_pfn_offset
> > +                                      * will be 0. */
> > +#endif
> >       struct device_dma_parameters *dma_parms;
> >
> >       struct list_head        dma_pools;      /* dma pools (if dma'ble) */
>
> I'll defer to Christoph here, but I thought we were trying to get rid of
> stuff like this from struct device, not add new things to it for dma
Hi Greg,

I wasn't aware of this policy.  I put it in 'struct device' because
just like the existing dma_pfn_offset; it seemed to be the only way to
pull this off.  I'll certainly follow any ideas on alternative
strategies from Christoph et al.

> apis.  And why is it a void *?
Just wanted to minimize the number of lines I've added to device.h, no
other reason.

Thanks,
Jim
>
> thanks,
>
> greg k-h
