Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405D9206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPo65ZsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgETPPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:15:09 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3979C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:15:07 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id m18so844741vkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUX13WphyqqA1JYWe4oPUl+D3hHWw+xab91ouObbZCg=;
        b=yPo65ZsZDmcGgXTMi8Zqn0vHf1QG5fau+JxpzprjaOHvXkYuRozdlqhT1xnYpP3ElV
         AH0AB254mavFDsnn2ENcVcOZo/i+jaiA8B26CT1PKNPrgPOn9diSl13x4dWfCXDRLaCo
         FO/s4hnEWdDEAPFj94khHQh7zIV79YGGhR80YKxGHVNNW9zrj1/jay/T8aTiMhKRmVPr
         VmvpivF4+6x+2tu+YKaDn74EgFPwa2trf7Bk0NrKRCJokMzVpROLKtR/nt8paUG1/dJs
         GBKbJweqAbEdfF2vx2h/M5AKbzGDwcK0+fuAaL4OGudDbhf2FaOfkvKf07ABltXdoPMP
         Q+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUX13WphyqqA1JYWe4oPUl+D3hHWw+xab91ouObbZCg=;
        b=CNzJbvAKKuJxJz8CQsEdOY7uo8ZE6EThxXpV8fd+F1Y4H3EGWAFKZA+uXMnPhMMicY
         q9oJKFZzUrU8IriMfQQnPVxlqPR94MRU9LHIyylDc8EAT1aUN3lzOTw21wsYiXE8xDS8
         8Pn4YhaxQu3+lgVHclGkAEo/G6Wl5Bm/torvYnNxwoFQzFzX27p6pPlayG9pwh8u/EHD
         TKK54eJOycszEZyBOkgN8ysjdYPP/6wju1XlCoGdwxoLVWGEwD8ZPDUFSlgmfVH79WfB
         FtZF92OzchUnZhTTNIjLGogNK5SCqTRqPr2fT/wJL/cVuWA0yU6HDZrfxHeLZGuAJbun
         3mSA==
X-Gm-Message-State: AOAM530ryjx+qjlgqtCUOIDpoO0vrpfMOF9zf3YqO2e60BevUhvTPL3T
        /+kRzdYSvTP7Hu7xK9hl6n1UvlUXUKFJZBou/J910w==
X-Google-Smtp-Source: ABdhPJxekvSrdTElq3vFqtOcb6dmQQbXPtS/x9d4e/JTZmJYMgPMlxOkOALq3DqJ5j0N09VRyGqEGXK1aiqfYw7b8QE=
X-Received: by 2002:a1f:fc06:: with SMTP id a6mr4095706vki.101.1589987706806;
 Wed, 20 May 2020 08:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200520090109eucas1p17270805f81f6958cd5084a7b910efc6c@eucas1p1.samsung.com>
 <a9df7155-dd7a-752b-6d1c-3426837756b1@ti.com> <e9674719-0c86-63be-04a3-ee98bd884901@samsung.com>
 <f3c58dcd-b806-95ef-2434-3084e65e1afb@ti.com> <e3fa0b35-7cca-1e37-c2fa-63cc07e6bfda@samsung.com>
 <227465a5-c6e6-5b4d-abbd-7789727843a6@ti.com> <29a21e64-a63f-6721-c938-d713488767c1@samsung.com>
 <CAPDyKFq8-JYA_tKZmUZOY3mT-jeoWMHNpdj8SDGkqYmX7jJHVQ@mail.gmail.com> <9f72aeab-8d63-7fc1-d5ff-7d5c4f11012b@samsung.com>
In-Reply-To: <9f72aeab-8d63-7fc1-d5ff-7d5c4f11012b@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 17:14:29 +0200
Message-ID: <CAPDyKFpgzYJzWR3mc-4XQDijtHVibDrFXazY0=P7TUs6rvE_hQ@mail.gmail.com>
Subject: Re: Bad kfree of dma_parms in v5.7-rc5
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 at 15:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Ulf,
>
> On 20.05.2020 15:12, Ulf Hansson wrote:
> > + Greg
> >
> > On Wed, 20 May 2020 at 14:54, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> On 20.05.2020 14:43, Tomi Valkeinen wrote:
> >>> On 20/05/2020 12:22, Marek Szyprowski wrote:
> >>>> On 20.05.2020 11:18, Tomi Valkeinen wrote:
> >>>>> On 20/05/2020 12:13, Marek Szyprowski wrote:
> >>>>>> On 20.05.2020 11:00, Tomi Valkeinen wrote:
> >>>>>>> Commit 9495b7e92f716ab2bd6814fab5e97ab4a39adfdd ("driver core:
> >>>>>>> platform: Initialize dma_parms for platform devices") v5.7-rc5 causes
> >>>>>>> at least some v4l2 platform drivers to break when freeing resources.
> >>>>>>>
> >>>>>>> E.g. drivers/media/platform/ti-vpe/cal.c uses
> >>>>>>> vb2_dma_contig_set_max_seg_size() and
> >>>>>>> vb2_dma_contig_clear_max_seg_size() to manage the dma_params, and
> >>>>>>> similar pattern is seen in other drivers too.
> >>>>>>>
> >>>>>>> After 9495b7e92f716ab2, vb2_dma_contig_set_max_seg_size() will not
> >>>>>>> allocate anything, but vb2_dma_contig_clear_max_seg_size() will still
> >>>>>>> kfree the dma_params.
> >>>>>>>
> >>>>>>> I'm not sure what's the proper fix here. A flag somewhere to indicate
> >>>>>>> that vb2_dma_contig_set_max_seg_size() did allocate, and thus
> >>>>>>> vb2_dma_contig_clear_max_seg_size() must free?
> >>>>>>>
> >>>>>>> Or drop the kzalloc and kfree totally, if dma_params is now supposed
> >>>>>>> to always be there?
> >>>>>> Thanks for reporting this issue!
> >>>>>>
> >>>>>> Once the mentioned commit has been merged, the code should assume that
> >>>>>> the platform devices does have a struct dma_params allocated, so the
> >>>>>> proper fix is to alloc dma_params only if the bus is not a platform
> >>>>>> bus:
> >>>>>>
> >>>>>> if (!dev_is_platform(dev) && !dev->dma_parms) {
> >>>>>>         dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
> >>>>>>
> >>>>>> same check for the free path.
> >>>>> There is also "amba: Initialize dma_parms for amba devices". And the
> >>>>> commit message says PCI devices do this too.
> >>>>>
> >>>>> Guessing this based on the device type doesn't sound like a good idea
> >>>>> to me.
> >>>> Indeed. Then replace the allocation with a simple check for NULL
> >>>> dma_parms and return an error in such case. This should be enough for
> >>>> v5.8. Later we can simply get rid of those helpers and inline setting
> >>>> max segment size directly to the drivers.
> > That seems like a good idea, in the long run.
> >
> >>> Is that valid either? Then we assume that dma_parms is always set up
> >>> by someone else. That's true for platform devices and apparently some
> >>> other devices, but is it true for all devices now?
> >> # git grep vb2_dma_contig_set_max_seg_size | wc -l
> >>
> >> 18
> >>
> >> I've checked all clients of the vb2_dma_contig_set_max_seg_size
> >> function. There are only 9 drivers, all of them are platform device
> >> drivers. We don't care about off-tree users, so the proposed approach is
> >> imho fine.
> > Thanks for reporting and for looking into this. I apologize for the mess!
> >
> > There is one case, where the above solution could be a problem (unless
> > I am wrong). That is, s5p_mfc_configure_2port_memory() that calls
> > s5p_mfc_alloc_memdev(), which allocates/initializes an internal struct
> > *device. Thus, this doesn't have the dev->dma_parms
> > allocated/assigned.
> Indeed, this one will fail.
> > In other words, we would need to manage alloc/free for the
> > dev->dma_parms to have a complete fix. Maybe in
> > s5p_mfc_configure|unconfigure_2port_memory()!?
> That would be the best place to allocate it.
> > Additionally, I think reverting the offending commit, as discussed
> > above, could cause even more issues, as it's even included for
> > v5.6-stable kernels. I will go through all cases, more carefully this
> > time, of how ->dma_parms is managed, to be sure there are no more
> > conflicting cases.
>
> I've already posted a fix for ExynosDRM driver, which is also affected:
> https://patchwork.kernel.org/patch/11559965/

Alright, thanks for helping out!

Please add a fixes/stable tag to it.

Fixes: 9495b7e92f71 ("driver core: platform: Initialize dma_parms for
platform devices")
Cc: stable@vger.kernel.org

Kind regards
Uffe
