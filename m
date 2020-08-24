Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA674C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D7B2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQXLFuQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHXRau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHXRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:30:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67144C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:30:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id oz20so7992778ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pv9P9U6pxLlwMoplcSWHM0HVEAc+hsmuC2XIfXUykA=;
        b=MQXLFuQXuwoKlu3fd4XyBErZA9e2H8z9kAXsrL9JfqOnhiArUFNm5rTXpHuyaca30B
         j3+Hb+BLsOR6HAmseGR/njI2ubT9hInGmg3VFUve5o7gAsNT0w9XzR1I3+fUD512IgTP
         eEEIU2xOtudBI0wVeRc4FJOElyTL0U0PmPFBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pv9P9U6pxLlwMoplcSWHM0HVEAc+hsmuC2XIfXUykA=;
        b=THO5RI5LACvQUjSrhhvjqbNBoEZfRdqPngIuKA0+50cAe6g7sIBI6bj4AMB3W/i9pX
         wRwY5OG/eL1RqglW9TWmrdlMJpmaq+cCQqFBEajBFeuIHSJYDBj0s00Ex4F7RMmvaqJ2
         VHATa7ukcAIy4Yhh9Lt5obo5jk0hv43jU6KwyKkrWz4oyMVV09f5+x167uOEBh9cYHIm
         RWch8x43QKsFjKjhcD85RFvZoVULAAV1ivCYUbLCsAN3nGuP6/ARi5k4sziy0fnfAwwo
         TzlUzYvQ+YR2+OhGZ9ySL8KKOCrL7tHkvL5MeN7T7KKh641PWGG2UiKFbOq95T9gBb8v
         /Cbw==
X-Gm-Message-State: AOAM531D9kdueAKmOmV/0F3FEZOYFuY4oDH+Vvd3Sp3LKECeHgOypmh7
        dNrjUuHRtEd0unVXT9G1H3jObNxmPNpoxQ==
X-Google-Smtp-Source: ABdhPJz70U6aOlRYmiw+q3HWKOA2YFhdpPmTgnl0a4qK/7Z+daiLRPp/BRAJfpOLPYPbFQBjjSPO/A==
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr6772899ejg.12.1598290221305;
        Mon, 24 Aug 2020 10:30:21 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id o5sm10165846edi.3.2020.08.24.10.30.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:30:21 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id x9so5092908wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:30:20 -0700 (PDT)
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr256519wmo.183.1598289877815;
 Mon, 24 Aug 2020 10:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org> <20200728050140.996974-5-tientzu@chromium.org>
 <20200731205804.GB756942@bogus> <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
 <CAAFQd5Cm+ZGx9ia2sAdvHQC6zC1U=+9AWs7iW7o-qE4g7wZgsw@mail.gmail.com> <CAAFQd5AfbN0V3sGCs8vhmeD-MNn3bTvfWBCaT-OY3hgjBUs-LQ@mail.gmail.com>
In-Reply-To: <CAAFQd5AfbN0V3sGCs8vhmeD-MNn3bTvfWBCaT-OY3hgjBUs-LQ@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 24 Aug 2020 19:24:25 +0200
X-Gmail-Original-Message-ID: <CAAFQd5B_LAb0uU3J9umGWBhaVSKT3N9SynnvTxw_PVEwHu4Cww@mail.gmail.com>
Message-ID: <CAAFQd5B_LAb0uU3J9umGWBhaVSKT3N9SynnvTxw_PVEwHu4Cww@mail.gmail.com>
Subject: Re: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
To:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:15 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Mon, Aug 3, 2020 at 5:15 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > Hi Claire and Rob,
> >
> > On Mon, Aug 3, 2020 at 4:26 PM Claire Chang <tientzu@chromium.org> wrote:
> > >
> > > On Sat, Aug 1, 2020 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 28, 2020 at 01:01:39PM +0800, Claire Chang wrote:
> > > > > Introduce the new compatible string, device-swiotlb-pool, for restricted
> > > > > DMA. One can specify the address and length of the device swiotlb memory
> > > > > region by device-swiotlb-pool in the device tree.
> > > > >
> > > > > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > > > > ---
> > > > >  .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
> > > > >  1 file changed, 35 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > > index 4dd20de6977f..78850896e1d0 100644
> > > > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > > > @@ -51,6 +51,24 @@ compatible (optional) - standard definition
> > > > >            used as a shared pool of DMA buffers for a set of devices. It can
> > > > >            be used by an operating system to instantiate the necessary pool
> > > > >            management subsystem if necessary.
> > > > > +        - device-swiotlb-pool: This indicates a region of memory meant to be
> > > >
> > > > swiotlb is a Linux thing. The binding should be independent.
> > > Got it. Thanks for pointing this out.
> > >
> > > >
> > > > > +          used as a pool of device swiotlb buffers for a given device. When
> > > > > +          using this, the no-map and reusable properties must not be set, so the
> > > > > +          operating system can create a virtual mapping that will be used for
> > > > > +          synchronization. Also, there must be a restricted-dma property in the
> > > > > +          device node to specify the indexes of reserved-memory nodes. One can
> > > > > +          specify two reserved-memory nodes in the device tree. One with
> > > > > +          shared-dma-pool to handle the coherent DMA buffer allocation, and
> > > > > +          another one with device-swiotlb-pool for regular DMA to/from system
> > > > > +          memory, which would be subject to bouncing. The main purpose for
> > > > > +          restricted DMA is to mitigate the lack of DMA access control on
> > > > > +          systems without an IOMMU, which could result in the DMA accessing the
> > > > > +          system memory at unexpected times and/or unexpected addresses,
> > > > > +          possibly leading to data leakage or corruption. The feature on its own
> > > > > +          provides a basic level of protection against the DMA overwriting buffer
> > > > > +          contents at unexpected times. However, to protect against general data
> > > > > +          leakage and system memory corruption, the system needs to provide a
> > > > > +          way to restrict the DMA to a predefined memory region.
> > > >
> > > > I'm pretty sure we already support per device carveouts and I don't
> > > > understand how this is different.
> > > We use this to bounce streaming DMA in and out of a specially allocated region.
> > > I'll try to merge this with the existing one (i.e., shared-dma-pool)
> > > to see if that
> > > makes things clearer.
> > >
> >
> > Indeed, from the firmware point of view, this is just a carveout, for
> > which we have the "shared-dma-pool" compatible string defined already.
> >
> > However, depending on the device and firmware setup, the way the
> > carevout is used may change. I can see the following scenarios:
> >
> > 1) coherent DMA (dma_alloc_*) within a reserved pool and no
> > non-coherent DMA (dma_map_*).
> >
> > This is how the "memory-region" property is handled today in Linux for
> > devices which can only DMA from/to the given memory region. However,
> > I'm not sure if no non-coherent DMA is actually enforced in any way by
> > the DMA subsystem.
> >
> > 2) coherent DMA from a reserved pool and non-coherent DMA from system memory
> >
> > This is the case for the systems which have some dedicated part of
> > memory which is guaranteed to be coherent with the DMA, but still can
> > do non-coherent DMA to any part of the system memory. Linux handles it
> > the same way as 1), which is what made me believe that 1) might not
> > actually be handled correctly.
> >
> > 3) coherent DMA and bounced non-coherent DMA within a reserved pool
> > 4) coherent DMA within one pool and bounced non-coherent within another pool
> >
> > These are the two cases we're interested in. Basically they make it
> > possible for non-coherent DMA from arbitrary system memory to be
> > bounced through a reserved pool, which the device has access to. The
> > current series implements 4), but I'd argue that it:
> >
> > - is problematic from the firmware point of view, because on most of
> > the systems, both pools would be just some carveouts and the fact that
> > Linux would use one for coherent and the other for non-coherent DMA
> > would be an OS implementation detail,
> > - suffers from the static memory split between coherent and
> > non-coherent DMA, which could either result in some wasted memory or
> > the DMA stopped working after a kernel update if the driver changes
> > its allocation pattern,
> >
> > and so we should rather go with 3).
> >
> > Now, from the firmware point of view, it doesn't matter how the OS
> > uses the carveout, but I think it's still necessary to tell the OS
> > about the device DMA capability. Right now we use "memory-region" for
> > any kind of reserved memory, but looking at the above scenarios, there
> > are 2 cases:
> >
> > a) the memory region is preferred for the device, e.g. it enables
> > coherency, but the device can still DMA across the rest of the system
> > memory. This is the case in scenario 2) and is kind of assumed in the
> > Linux DMA subsystem, although it's certainly not the case for a lot of
> > hardware, even if they use the "memory-region" binding.
> >
> > b) the memory region is the only region that the device can access.
> > This is the case in scenarios 1), 3) and 4).
> >
> > For this, I'd like to propose a "restricted-dma-region" (feel free to
> > suggest a better name) binding, which is explicitly specified to be
> > the only DMA-able memory for this device and make Linux use the given
> > pool for coherent DMA allocations and bouncing non-coherent DMA.
> >
> > What do you think?
>
> Rob, Robin, we'd appreciate your feedback on this when you have a
> chance to take a look again. Thanks!

Gentle ping.

>
> Best regards,
> Tomasz
>
> >
> > Best regards,
> > Tomasz
> >
> > > >
> > > > What is the last sentence supposed to imply? You need an IOMMU?
> > > The main purpose is to mitigate the lack of DMA access control on
> > > systems without an IOMMU.
> > > For example, we plan to use this plus a MPU for our PCIe WiFi which is
> > > not behind an IOMMU.
> > >
> > > >
> > > > >          - vendor specific string in the form <vendor>,[<device>-]<usage>
> > > > >  no-map (optional) - empty property
> > > > >      - Indicates the operating system must not create a virtual mapping
> > > > > @@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > > >                       compatible = "acme,multimedia-memory";
> > > > >                       reg = <0x77000000 0x4000000>;
> > > > >               };
> > > > > +
> > > > > +             wifi_coherent_mem_region: wifi_coherent_mem_region {
> > > > > +                     compatible = "shared-dma-pool";
> > > > > +                     reg = <0x50000000 0x400000>;
> > > > > +             };
> > > > > +
> > > > > +             wifi_device_swiotlb_region: wifi_device_swiotlb_region {
> > > > > +                     compatible = "device-swiotlb-pool";
> > > > > +                     reg = <0x50400000 0x4000000>;
> > > > > +             };
> > > > >       };
> > > > >
> > > > >       /* ... */
> > > > > @@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > > >               memory-region = <&multimedia_reserved>;
> > > > >               /* ... */
> > > > >       };
> > > > > +
> > > > > +     pcie_wifi: pcie_wifi@0,0 {
> > > > > +             memory-region = <&wifi_coherent_mem_region>,
> > > > > +                      <&wifi_device_swiotlb_region>;
> > > > > +             restricted-dma = <0>, <1>;
> > > > > +             /* ... */
> > > > > +     };
> > > > >  };
> > > > > --
> > > > > 2.28.0.rc0.142.g3c755180ce-goog
> > > > >
