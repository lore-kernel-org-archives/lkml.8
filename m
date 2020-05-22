Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791D022475
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bk/q9kC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgEVObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbgEVObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:31:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE0C05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:31:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so1976600wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wut4c+bPuiYy5OjbI94UBdHQ9qFX+/Iy0AUzvohHk0E=;
        b=Bk/q9kC2opiRlf3mZ6GqbOpTzKaXhi8G0UmcOaPcarVVY51tYm1AZ3dwlD6g7RTh2t
         yVfVonK1kMPgOsKHHYogV8ogadZTEohsnqozJlTV+hRL9MClCSdmuGyMZUBZMEY3Kylg
         qQDUO9kDg1MrX4jXnrk/MiOGpLI6maBUqcKU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wut4c+bPuiYy5OjbI94UBdHQ9qFX+/Iy0AUzvohHk0E=;
        b=GX5FobzocMAcaqoTfXh4HXr7my3DB5c5m81eAddg4xx79UuP9fD4cHMcCOpfMOf8vH
         sPVjLAhLVwMNU8bW+3ROE/vpkb0F4ARQjfif6YF87WslFayatPQdf5D9KoANJZJDwIU8
         qQHiDAwIEmtEO68FiPNbqVGYS4CeMF7EZ+E9DNezEDbVAXWgFDdL4D22S8JFzRcpQu1A
         t3Q/PwdkyBAIeTZR4tmS/Jvdufql9j6UmoCKvWBmtLU4jimPM3t/JPzZ89/F3NU5FpNA
         uezJUV5AT2v9hNzZ2PXurH0AMpeAQUo9WltCBLHbOirLDJEeVlSywvh9viA2sLtLtvs9
         aYcA==
X-Gm-Message-State: AOAM532NBAkB/cEpFDD72azh54EqRZeKTD7lUG/Egtre6E7l3A1aKVVL
        N+aNw60fL+kOC6KRLvRP99IBEG7p+iBkqZyJZQgACw==
X-Google-Smtp-Source: ABdhPJyDTNQNorc4YA9Ng6UYpWYZ3xL4wPN4AoNiZ22sI5HulYRwzdCv5cajnBlTutkDgHl/rclh9HiVaVJ277hG528=
X-Received: by 2002:adf:ec03:: with SMTP id x3mr740401wrn.297.1590157872537;
 Fri, 22 May 2020 07:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com> <2aa6f276085319a5af7a96b3d7bdd0501641a7d7.camel@suse.de>
In-Reply-To: <2aa6f276085319a5af7a96b3d7bdd0501641a7d7.camel@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 22 May 2020 10:31:00 -0400
Message-ID: <CA+-6iNzeVO=WpLKR7wv-7URLk2aiZbGjPdQe_o6F_gfyX03oMQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma offsets
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Nicolas,

On Wed, May 20, 2020 at 7:28 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Jim,
> thanks for having a go at this! My two cents.
>
> On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> > The device variable 'dma_pfn_offset' is used to do a single
> > linear map between cpu addrs and dma addrs.  The variable
> > 'dma_map' is added to struct device to point to an array
> > of multiple offsets which is required for some devices.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > ---
>
> [...]
>
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -493,6 +493,8 @@ struct dev_links_info {
> >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> >   *           DMA limit than the device itself supports.
> >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > + * @dma_map: Like dma_pfn_offset but used when there are multiple
> > + *           pfn offsets for multiple dma-ranges.
> >   * @dma_parms:       A low level driver may set these to teach IOMMU code
> > about
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
>
> I get a bad feeling about separating the DMA offset handling into two distinct
> variables. Albeit generally frowned upon, there is a fair amount of trickery
> around dev->dma_pfn_offset all over the kernel. usb_alloc_dev() comes to mind
> for example. And this obviously doesn't play well with it.

The trickery should only be present when
CONFIG_DMA_PFN_OFFSET_MAP=y**.  Otherwise it does no harm.  Also, I
feel that if dev-dma_pfn_offset is valid then so is
dev->dma_pfn_offset_map -- they both use the same mechanism in the
same places.  I am merely
extending something that has been in Linux for a long time..

Further,  I could have had dma_pfn_offset_map  subsume dma_pfn_offset
but I wanted to leave it alone since folks would complain that it
would go from an addition to an if-clause and an inline function.  But
if I did go that way there would  only be one mechanism that would
cover both cases.

> I feel a potential
> solution to multiple DMA ranges should completely integrate with the current
> device DMA handling code, without special cases, on top of that, be transparent
> to the user.

Having dma_pfn_offset_map subsume  dma_pfn_offset would integrate the
current  code too.  And I am not sure what you mean by being
"transparent to the user" -- the writer of the PCIe endpoint driver is
going to do some DMA calls and they have no idea if this mechanism is
in play or not.

>
> In more concrete terms, I'd repackage dev->bus_dma_limit and
> dev->dma_pfn_offset into a list/array of DMA range structures

This is sort of what I am doing except I defined my own structure.
Using the of_range structure would require one to do the same extra
calculations over  and over for a DMA call; this is why I  defined my
structure that has all of the needed precomputed variables.

> and adapt/create
> the relevant getter/setter functions so as for DMA users not to have to worry
> about the specifics of a device's DMA constraints.

I'm not sure I understand where these getter/setter functions would
exist or what they would do.

> editing dev->dma_pfn_offset, you'd be passing a DMA range structure to the
> device core, and let it take the relevant decisions on how to handle it

How and where would the device core operate for these getter/setters?
In how many places in the code?  The way I see it, any solution has to
adjust the value when doing dma2phys and phys2dma conversions, and the
most efficient place to do that is in the two DMA header files (the
second one is for ARM).

> internally (overwrite, add a new entry, merge them, etc...).
I'm concerned that  this would be overkill; I am just trying to get a
driver upstream for some baroque PCIe RC HW I'm not sure if we should
set up something elaborate when the demand is not there.

I'll be posting a v2.  ChrisophH has sent me some personal feedback
which I am incorporating; so feel free to discuss your ideas with him
as well because I really want consensus on any large changes in
direction.

Thanks,
Jim

** CONFIG_DMA_OF_PFN_OFFSET_MAP=y only occurs when building for
ARCH_BRCMSTB.  However, ARCH_BRCMSTB is set by the ARM64 defconfig and
the ARM multi_v7_defconfig, so it would be activated for those
defconfigs.  This may(a)  get us kicked out of those defconfigs  or
(b) we may have to keep DMA_OF_PFN_OFFSET_MAP off in those defconfigs
and only turn it on solely for Broadcom STB Linux.

>
> Easier said than done. :)
>
> Regards,
> Nicolas
>
