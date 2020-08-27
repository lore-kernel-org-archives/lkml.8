Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867DDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6336C22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CUujgUZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0Nih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgH0Naj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:30:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70831C061237
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:30:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so5395464wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p33Zl85F48xSFFwh9Fvb6fYwVy/Jt4DGVFmz86MHbko=;
        b=CUujgUZRienGvENy9ZeNSE4OLq/gTozkw9vqhnndn3e+Pp27upZYxzcOy348qWT4x6
         fZ9HzhrGd6ok0/lpV6XJMXIHbIrfSS3H2kc5d+JTd1lletPZjVOkUQ8WZMoDnSSylgRw
         zOHH0JLxrQJsHR8v5+SGQOGgwwu7dIE6xp9Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p33Zl85F48xSFFwh9Fvb6fYwVy/Jt4DGVFmz86MHbko=;
        b=ulZsgmRD+9d1uG8rpq8MhI2yrTPv55NTWqvjxN6HU1mKOpyereX1GZvLDffo50/wGe
         kyt1FUwNT9hqRB+8JTWkhhDQQKF392m+7aKnthAJDA5VTj7+9NO56hh9uaXl7opi9dQV
         5PgRdEUXm1R8B41682ypBnEhLZSIt/fnIOFMxOQYkUWC/z0gwuPtTxRmqTLkhXZqYruj
         Z1A5fd/pJhHyqHV3EufmeVgCjGr9sTUwCw2jTq4tnwsz4MPqFSTkKdTfM5M/tcF3ej4r
         9ciPfggyhcUv4NVMcavmbJIPSofioHa0h0mp/UWrrKHI0I1iTzOJuix2mkVldokeygfC
         6gNg==
X-Gm-Message-State: AOAM530JR57cK5n6lcDNNjpi1cNq+CNFue7t9p1DmpmL+wa4zseT67rE
        KJvfbToOXuKp+eyG4xZnxuHMy8ZP5CmonSiujSr9wQ==
X-Google-Smtp-Source: ABdhPJyMtaFishcwtzNCj7DHN/faPMoK+tSF7O0vKJaBGS+gpAIRdF6geUez9pCQeleah1w6P5SJ7nzMgTS0KKpMqRI=
X-Received: by 2002:adf:bb54:: with SMTP id x20mr19609148wrg.413.1598535011238;
 Thu, 27 Aug 2020 06:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com> <20200827063517.GA4637@lst.de>
In-Reply-To: <20200827063517.GA4637@lst.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 27 Aug 2020 09:29:59 -0400
Message-ID: <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
To:     Christoph Hellwig <hch@lst.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Julien Grall <julien.grall@arm.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 2:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> > Hi,
> >
> > On 8/24/2020 12:30 PM, Jim Quinlan wrote:
> >>
> >> Patchset Summary:
> >>    Enhance a PCIe host controller driver.  Because of its unusual design
> >>    we are foced to change dev->dma_pfn_offset into a more general role
> >>    allowing multiple offsets.  See the 'v1' notes below for more info.
> >
> > We are version 11 and counting, and it is not clear to me whether there is
> > any chance of getting these patches reviewed and hopefully merged for the
> > 5.10 merge window.
> >
> > There are a lot of different files being touched, so what would be the
> > ideal way of routing those changes towards inclusion?
>
> FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
> I have a bit of a backlog, but plan to review and if Jim is ok with that
> apply the current version.
Sounds good to me.
Thanks, Jim
