Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6628520838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cilwx1I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFLFLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgFLFLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:11:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C973C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:11:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a21so7618111oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8V+bxbj5WCvzCnxozwhnhcY6TUJ/xexRHaQJ/PDvKQU=;
        b=cilwx1I8Xw8l4cOfCtUN5yHqBSWj+Ms0FUPp+RDFC2UUkvd9G/tKIonAgnCPmV7ju7
         ytE8iPnQdG6xCmbt2X4xyBjcOKSUmiTKGphnksjQ2SRiZLT5IbW006hcE7QfZHx6BSiX
         vrqTUkoSTB5lgrB2uyXPGdQVfa22TxwaFK1IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8V+bxbj5WCvzCnxozwhnhcY6TUJ/xexRHaQJ/PDvKQU=;
        b=VzX+UmoWridBGQed+b0GlW+hlUeefi8xSZ9yikFfyheI3zlgp/qE3CbI+lb2FI0CK0
         F2bvHNMC/mokBDCGwlWY/HsulmJU55NYwHy9WrqQ8aG81fANOsr90a//dVJEfYG2dKdX
         DjaiVtMQjo9vyjXnvR9i3mqwhSPEkNc4s3lswmpUG6uJ7oHWMoLhnF6BmZo4sx9USgPt
         Jmg9ppad9yO0q5e22xXT4YZFMN6FGBz3z+CF+Lfls7Fc49DeXRaEKgE2CqQroyUHIJLf
         WqN2/U42WFRoxYhxqeGs9L4BDKfssRZtyFnjvaiw266QqqwhDqvlA8lLOiN4Dvl0B/lZ
         MX3w==
X-Gm-Message-State: AOAM531o/PfEdTjk9kGutHtmw1EUac1Njyi12bgvY0GLLmFJBCPaCQxL
        sQfKmYpO9iD5ywP9Vxum0k8Md61i3TfKIvUYAVQUxw==
X-Google-Smtp-Source: ABdhPJzrYoClOB8B8OguvLlFrj2m7W+GxCU2S2r//wrUh7MPNfSE//K6chPjLrBcT0Xc1X5J0GrxFt1X3IqO0jmAaSg=
X-Received: by 2002:a05:6808:6d7:: with SMTP id m23mr980424oih.14.1591938678473;
 Thu, 11 Jun 2020 22:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch> <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca> <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
In-Reply-To: <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 12 Jun 2020 07:11:07 +0200
Message-ID: <CAKMK7uFE0uc5GNU49dYYQLNWbMFmQPcz_dAHHQT-dNe+Zzva-A@mail.gmail.com>
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

Well amdgpu already has dma_fence waits in the hmm callbacks, so
nothing new. But since you start using these in amdkfd ... perfect
opportunity to annotate the amdkfd paths for fence signalling critical
sections? Especially the preempt-ctx fence should be an interesting
case to annotate and see whether lockdep finds anything. Not sure what
else there is.
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
