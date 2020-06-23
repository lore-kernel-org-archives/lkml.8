Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AE12073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PwrvE5jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFWHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731217AbgFWHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:39:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D5C061795
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:39:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so15636536otp.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+92MYnF3Gh08MmStig+tCn2Q/L2yjmneEHZzzW7GGvs=;
        b=PwrvE5jS1kTu+fi0Cr9QUPwDbx3xz+X3B7OgQDwGyTKoe9mBLoNsF4PcRQZYhzKOnV
         CkL4lja+OqOY0gBbJB+pER0fYFWMEmKIpSKjbJhfHshefh7JCoDF0Ko4gDHaNPu08gpL
         UTuHeptkXd8ej8TjPFULXiSQ/JHJc7+5RujUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+92MYnF3Gh08MmStig+tCn2Q/L2yjmneEHZzzW7GGvs=;
        b=S4ZZ5RA8T8ItdXDb9lfkFYWbFo+r5rdvHeu9GV9SSbxR1X5hoUY3+pb6CzR9WphGsn
         bngjzAvODsXpSUZSPSwWAqQ8v38JjE7BKdcL56+tAeXddGEuJkD6BTen7PMsl/ABKira
         HMDqxvpdLxO7uFrOydXb1S9v/9X0tvAlvB5qaQI5dyIh1t5ltcvDPbHSbQPMqATuAvJR
         X1THZZF872dEKk2ipJl+cK15uRDSmIVVYyIM4jDLxJdnIpeBPJLHIOFOSPnlrKLVVm4b
         8rKMTfFX8+oQdPcr4fPHbt+2/a/ofAMPjFtA1RFcPxhukqfg/amkengkzgCwvC23mg16
         S3OQ==
X-Gm-Message-State: AOAM532fY/6f2WhbUgWQEgoZRJ+P+zbTeMntiQM3uEIvEQeUn67tkjC3
        7pNBHD2lDqw07ZR+R0+sWKwVi3xfBIsYABMV2kGWTg==
X-Google-Smtp-Source: ABdhPJyuTPn8gHto3Zj0qvtBWFEZww/Nxosv6E4e67PZOhsc7GOGHkoFk1BcCVm2dLP+f9GAnXbuSF6PpstaZHEQELA=
X-Received: by 2002:a4a:d415:: with SMTP id n21mr17485719oos.89.1592897968519;
 Tue, 23 Jun 2020 00:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch> <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca> <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
In-Reply-To: <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Jun 2020 09:39:17 +0200
Message-ID: <CAKMK7uHBKrpDWu+DvtYncDK=LOdGJyMK7t6fpOaGovnYFiBUZw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:35 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-06-11 um 10:15 a.m. schrieb Jason Gunthorpe:
> > On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
> >>> I still have my doubts about allowing fence waiting from within shrinkers.
> >>> IMO ideally they should use a trywait approach, in order to allow memory
> >>> allocation during command submission for drivers that
> >>> publish fences before command submission. (Since early reservation object
> >>> release requires that).
> >> Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
> >> with a mempool to make sure it can handle it's allocations.
> >>
> >>> But since drivers are already waiting from within shrinkers and I take your
> >>> word for HMM requiring this,
> >> Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
> >> one, the shrinker one is a lot less established.
> > I really question if HW that needs something like DMA fence should
> > even be using mmu notifiers - the best use is HW that can fence the
> > DMA directly without having to get involved with some command stream
> > processing.
> >
> > Or at the very least it should not be a generic DMA fence but a
> > narrowed completion tied only into the same GPU driver's command
> > completion processing which should be able to progress without
> > blocking.
> >
> > The intent of notifiers was never to endlessly block while vast
> > amounts of SW does work.
> >
> > Going around and switching everything in a GPU to GFP_ATOMIC seems
> > like bad idea.
> >
> >> I've pinged a bunch of armsoc gpu driver people and ask them how much this
> >> hurts, so that we have a clear answer. On x86 I don't think we have much
> >> of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> >> (but nouveau I think doesn't use dma_fence in there).
>
> Soon nouveau will get company. We're working on a recoverable page fault
> implementation for HMM in amdgpu where we'll need to update page tables
> using the GPUs SDMA engine and wait for corresponding fences in MMU
> notifiers.

Can you pls cc these patches to dri-devel when they show up? Depending
upon how your hw works there's and endless amount of bad things that
can happen.

Also I think (again depending upon how the hw exactly works) this
stuff would be a perfect example for the dma_fence annotations.

The worst case is if your hw cannot preempt while a hw page fault is
pending. That means none of the dma_fence will ever signal (the amdkfd
preempt ctx fences wont, and the classic fences from amdgpu might be
also stall). At least when you're unlucky and the fence you're waiting
on somehow (anywhere in its dependency chain really) need the engine
that's currently blocked waiting for the hw page fault.

That in turn means anything you do in your hw page fault handler is in
the critical section for dma fence signalling, which has far reaching
implications.
-Daniel

>
> Regards,
>   Felix
>
>
> > Right, nor will RDMA ODP.
> >
> > Jason
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
