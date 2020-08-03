Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20391208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZRjMJ9i+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgHCMlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgHCMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:40:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07805C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:40:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so10090619wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkm6CObS36SJAMkOLwAunKXfddEBXbzFKEGDTTUK8x8=;
        b=ZRjMJ9i+3XtHFlvWGHZ8k1OJSiJIwYiuaYJjTSDvBsQo7p5Lw2lHEoeMLsDrOtbo5t
         Y/L6ct5WPSxA6i5eDn+OJ1XtcPhING+tXhwhkyjJXP10dSlFTTYrNBfbMF0GZXXGSSzG
         KHPqqWfMuDAAl6hwmgPB5+nYUkFTDd+lylEYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkm6CObS36SJAMkOLwAunKXfddEBXbzFKEGDTTUK8x8=;
        b=Ux/UyGuPdLiAeCs5i81L7wUngAIQS8HK0cbLTkaa9Pll52tA/pdDvvAnR541chofvs
         fTyD208gnakDxG6zmKfVxtdMF/IF1AayToUEwAjsgLJI9FicglXrgfj7OMzYPekQ6PrT
         GAfTYEfwFMvk0OzAAmQA9Jw3O8q8Ay/UJTD26fb6yBsMczyyD2VPZ02Unggtfa06uyVx
         d+b5mA8Kd0sQi1cb7Xm8ecFKo9eJ9bHlnURMLR2OyGsw7cVS+qNHWfn1O9W5niZYXrV4
         4ivo3LMpQEL8bAFW604ay2A24CdVFgbmD+DaD6oOBrmjGhrHVS9WUwGNtMK5TuIghIxh
         hMQA==
X-Gm-Message-State: AOAM530T5dd82fzBEdJ7UjoKTnKoiPiIuqphnvlyzXONjHBi456380Vv
        SLKWmlnEAVsHA1ob/aEAOZGvDV5nJwKafjq8LDV/ig==
X-Google-Smtp-Source: ABdhPJyhgboxKbPjxQ++0E3wx9USPAXOub0gcy5KJOARS+aCf/xp/ODALT+aGA7/GIEB4C7d3o1nsP0GO/rZzwXoO+I=
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr16280931wmj.111.1596458438572;
 Mon, 03 Aug 2020 05:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-10-james.quinlan@broadcom.com> <e37ff97826cf006bf1c9a3e0a134847f8030c79a.camel@suse.de>
In-Reply-To: <e37ff97826cf006bf1c9a3e0a134847f8030c79a.camel@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 3 Aug 2020 08:40:26 -0400
Message-ID: <CA+-6iNyzD9DEqKw+w+Cx9ZXpc9j9RF3JS=avF7fk7CsCaTz=og@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] PCI: brcmstb: Set additional internal memory DMA
 viewport sizes
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fls64
On Sat, Aug 1, 2020 at 1:39 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Jim,
>
> On Fri, 2020-07-24 at 16:33 -0400, Jim Quinlan wrote:
> > The Raspberry Pi (RPI) is currently the only chip using this driver
> > (pcie-brcmstb.c).  There, only one memory controller is used, without an
> > extension region, and the SCB0 viewport size is set to the size of the
> > first and only dma-range region.  Other BrcmSTB SOCs have more complicated
> > memory configurations that require setting additional viewport sizes.
> >
> > BrcmSTB PCIe controllers are intimately connected to the memory
> > controller(s) on the SOC.  The SOC may have one to three memory
> > controllers; they are indicated by the term SCBi.  Each controller has a
> > base region and an optional extension region.  In physical memory, the base
> > and extension regions of a controller are not adjacent, but in PCIe-space
> > they are.
> >
> > There is a "viewport" for each memory controller that allows DMA from
> > endpoint devices.  Each viewport's size must be set to a power of two, and
> > that size must be equal to or larger than the amount of memory each
> > controller supports which is the sum of base region and its optional
> > extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.
> >
> > Unfortunately the viewport sizes cannot be ascertained from the
> > "dma-ranges" property so they have their own property, "brcm,scb-sizes".
> > This is because dma-range information does not indicate what memory
> > controller it is associated.  For example, consider the following case
> > where the size of one dma-range is 2GB and the second dma-range is 1GB:
> >
> >     /* Case 1: SCB0 size set to 4GB */
> >     dma-range0: 2GB (from memc0-base)
> >     dma-range1: 1GB (from memc0-extension)
> >
> >     /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
> >     dma-range0: 2GB (from memc0-base)
> >     dma-range1: 1GB (from memc0-extension)
> >
> > By just looking at the dma-ranges information, one cannot tell which
> > situation applies. That is why an additional property is needed.  Its
> > length indicates the number of memory controllers being used and each value
> > indicates the viewport size.
> >
> > Note that the RPI DT does not have a "brcm,scb-sizes" property value,
> > as it is assumed that it only requires one memory controller and no
> > extension.  So the optional use of "brcm,scb-sizes" will be backwards
> > compatible.
> >
> > One last layer of complexity exists: all of the viewports sizes must be
> > added and rounded up to a power of two to determine what the "BAR" size is.
> > Further, an offset must be given that indicates the base PCIe address of
> > this "BAR".  The use of the term BAR is typically associated with endpoint
> > devices, and the term is used here because the PCIe HW may be used as an RC
> > or an EP.  In the former case, all of the system memory appears in a single
> > "BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
> > used in the EP role and its system of mapping memory is an artifact that
> > requires multiple dma-ranges regions.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 8dacb9d3b7b6..3ef2d37cc43b 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -715,22 +720,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> >                                                       u64 *rc_bar2_offset)
> >  {
> >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > -     struct device *dev = pcie->dev;
> >       struct resource_entry *entry;
> > +     struct device *dev = pcie->dev;
> > +     u64 lowest_pcie_addr = ~(u64)0;
> > +     int ret, i = 0;
> > +     u64 size = 0;
> >
> > -     entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > -     if (!entry)
> > -             return -ENODEV;
> > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > +             u64 pcie_beg = entry->res->start - entry->offset;
> >
> > +             size += entry->res->end - entry->res->start + 1;
> > +             if (pcie_beg < lowest_pcie_addr)
> > +                     lowest_pcie_addr = pcie_beg;
> > +     }
> >
> > -     /*
> > -      * The controller expects the inbound window offset to be calculated as
> > -      * the difference between PCIe's address space and CPU's. The offset
> > -      * provided by the firmware is calculated the opposite way, so we
> > -      * negate it.
> > -      */
> > -     *rc_bar2_offset = -entry->offset;
> > -     *rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> > +     if (lowest_pcie_addr == ~(u64)0) {
> > +             dev_err(dev, "DT node has no dma-ranges\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> > +                                               PCIE_BRCM_MAX_MEMC);
> > +
> > +     if (ret <= 0) {
> > +             /* Make an educated guess */
> > +             pcie->num_memc = 1;
> > +             pcie->memc_size[0] = 1 << fls64(size - 1);
>
> You need to 1ULL here.
Got it.
Thanks,
Jim
>
> Regards,
> Nicolas
>
> > +     } else {
> > +             pcie->num_memc = ret;
> > +     }
> > +
> > +     /* Each memc is viewed through a "port" that is a power of 2 */
> > +     for (i = 0, size = 0; i < pcie->num_memc; i++)
> > +             size += pcie->memc_size[i];
> > +
> > +     /* System memory starts at this address in PCIe-space */
> > +     *rc_bar2_offset = lowest_pcie_addr;
> > +     /* The sum of all memc views must also be a power of 2 */
> > +     *rc_bar2_size = 1ULL << fls64(size - 1);
> >
> >       /*
> >        * We validate the inbound memory view even though we should trust
>
