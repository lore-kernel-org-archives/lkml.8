Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5DC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAE622522
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="DyjBlh4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgCDQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:28:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46219 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388019AbgCDQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:28:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id y3so2981166edj.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7TRIY9YZNfQ03l0XAD8uITch5RH+qIr9GBOry06eMOI=;
        b=DyjBlh4x8TGTi0/baq7816HKFpJxdmdh2OzVkAZqLMtGgEWsnnRBjUNDbMhLtTxKrm
         qsWwddd2y1HXIShfDo4TTplQmv/XPR48GHuE0B4EBpMcKo7lBNjPYMetgokwrGCaVzdt
         szyOmrwGOGIpQAcwpTf9aaBVdeIg8ZD3/fh2BXXK9eVrI0jWHP8CNvEZWqcKf1R1BHdc
         cGMCQ+mRhLMKzM9MAZpiI7hKFH77iA9jeVil4vAf4z3GX6urUtr5aev2Si1JICBfTk8O
         /pIvKegc01ZP9YmE7S7jfCoWdt1GNU+8mX8o/CwmR/ga8fbT99pHiso1U+mizqMrJQVQ
         rAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7TRIY9YZNfQ03l0XAD8uITch5RH+qIr9GBOry06eMOI=;
        b=hJqlIBi6DS708y1w/rzyPdEtwT2/FZa/UI6u+mModSyO8h1PBt7A/oabxTahHTVlj8
         NAZ7osVRY5g5pXmDNg9MLZyDEcCkwIpjymkabuOcGxuG4ToXfkMFkJIjLvlID2mAQfKy
         /GUWgwFem4zGVn7x22Jl/y8JAaZQphyNREZU4SBGSXdUGlotDZlZGhRdv+UulnIwowbm
         nE6owMl5TtivAFnk2In0bJLEBMD5pJKec+jpZqxhPQrsPl3dO7I6GMBL0XyVZPMGmAGr
         Cq8nWulNIsOBJoMCnf8CE+gQk227z6n1GwhgQ+AbBTtbMpnXKJ8d4y/xekHV2ASlXoST
         2/3g==
X-Gm-Message-State: ANhLgQ3nZWluNB5s0jfmtVgTBlnrwnFnwqPFrIEN/UR578xrCD7t4XJY
        Y1joqh92syJU3AGWUWPkR1EeC3geIOaxngDaIDAfrQ==
X-Google-Smtp-Source: ADFU+vsSyopp0FIj9kIHIXWZFM6m95W5fA7PACVmDDg7Apxr6rZ0+SjUG+P1JsIhCXAPTgAxBiN91lx8DJJ0ecG4TlA=
X-Received: by 2002:a17:906:f258:: with SMTP id gy24mr927151ejb.120.1583339283393;
 Wed, 04 Mar 2020 08:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20200225235856.975366-1-jason@jlekstrand.net> <8066d8b2-dd6a-10ef-a7bb-2c18a0661912@amd.com>
 <20200226100523.GQ2363188@phenom.ffwll.local> <CAOFGe94O66HL212aXqhi9tdYqw---Xm-fwNSV4pxHyPmpSGpbg@mail.gmail.com>
 <CAP+8YyEUz29fXDW5kO_0ZG6c849=TuFWCK8ynT3LuM+Tn+rMzw@mail.gmail.com>
 <810a26e7-4294-a615-b7ee-18148ac70641@amd.com> <CAOFGe96namyeQXTvdrduM+=wkJuoWWx34CxcsJHS3fcCaKDadw@mail.gmail.com>
 <21aeacc0-f3ae-c5dd-66df-4d2f3d73f73e@amd.com>
In-Reply-To: <21aeacc0-f3ae-c5dd-66df-4d2f3d73f73e@amd.com>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Wed, 4 Mar 2020 10:27:51 -0600
Message-ID: <CAOFGe95Gx=kX=sxwhx1FYmXQuPtGAKwt2V5YodQBwJXujE3WwA@mail.gmail.com>
Subject: Re: [PATCH] RFC: dma-buf: Add an API for importing and exporting sync files
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Dave Airlie <airlied@redhat.com>,
        Jesse Hall <jessehall@google.com>,
        James Jones <jajones@nvidia.com>,
        Daniel Stone <daniels@collabora.com>,
        =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chenbo Feng <fengc@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        linux-media@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 2:34 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.03.20 um 20:10 schrieb Jason Ekstrand:
> > On Thu, Feb 27, 2020 at 2:28 AM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> [SNIP]
> >>> However, I'm not sure what the best way is to do garbage collection o=
n
> >>> that so that we don't get an impossibly list of fence arrays.
> >> Exactly yes. That's also the reason why the dma_fence_chain container =
I
> >> came up with for the sync timeline stuff has such a rather sophisticat=
ed
> >> garbage collection.
> >>
> >> When some of the included fences signal you need to free up the
> >> array/chain and make sure that the memory for the container can be reu=
sed.
> > Currently (as of v2), I'm using dma_fence_array and being careful to
> > not bother constructing one if there's only one fence in play.  Is
> > this insufficient?  If so, maybe we should consider improving
> > dma_fence_array.
>
> That still won't work correctly in all cases. See the problem is not
> only optimization, but also avoiding situations where userspace can
> abuse the interface to do nasty things.
>
> For example if userspace just calls that function in a loop you can
> create a long chain of dma_fence_array objects.
>
> If that chain is then suddenly released the recursive dropping of
> references can overwrite the kernel stack.
>
> For reference see what dance is necessary in the dma_fence_chain_release
> function to avoid that:
> >         /* Manually unlink the chain as much as possible to avoid
> > recursion
> >          * and potential stack overflow.
> >          */
> >         while ((prev =3D rcu_dereference_protected(chain->prev, true)))=
 {
> ....
>
> It took me quite a while to figure out how to do this without causing
> issues. But I don't see how this would be possible for dma_fence_array.

Ah, I see the issue now!  It hadn't even occurred to me that userspace
could use this to build up an infinite recursion chain.  That's nasty!
 I'll give this some more thought and see if can come up with
something clever.

Here's one thought:  We could make dma_fence_array automatically
collapse any arrays it references and instead directly reference their
fences.  This way, no matter how much the client chains things, they
will never get more than one dma_fence_array.  Of course, the
difficulty here (answering my own question) comes if they ping-pong
back-and-forth between something which constructs a dma_fence_array
and something which constructs a dma_fence_chain to get
array-of-chain-of-array-of-chain-of-...  More thought needed.

> As far as I can see the only real option to implement this would be to
> change the dma_resv object container so that you can add fences without
> overriding existing ones.
>
> For shared fences that can be done relative easily, but I absolutely
> don't see how to do this for exclusive ones without a larger rework.

Fair enough.  Thanks for taking the time to explain the issue.  I'll
give this some more thought.

--Jason


> >>>    (Note
> >>> the dma_resv has a lock that needs to be taken before adding an
> >>> exclusive fence, might be useful). Some code that does a thing like
> >>> this is __dma_resv_make_exclusive in
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >> Wanted to move that into dma_resv.c for quite a while since there are
> >> quite a few other cases where we need this.
> > I've roughly done that.  The primary difference is that my version
> > takes an optional additional fence to add to the array.  This makes it
> > a bit more complicated but I think I got it mostly right.
> >
> > I've also written userspace code which exercises this and it seems to
> > work.  Hopefully, that will give a better idea of what I'm trying to
> > accomplish.
>
> Yes, that is indeed a really nice to have feature.
>
> Regards,
> Christian.
