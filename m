Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07545C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF2E2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="CGhp6TNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgCDQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:41:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40450 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgCDQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:41:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id a13so3066735edu.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ySiSOnqcuA6nNk8c0jQCBZCPf0dSfXosbzJcm8d2dZY=;
        b=CGhp6TNsRBfRwAxiBCYBK+2j2pYnrWkcFtf+MnmaID1ngwxqdlKRJ6FfdxB35Sa+ID
         Og7cAaCnPcGGkMbb9DNd4/GpvNZ0RAupTytTiQZBUPb56W4J0gv+vo2Tp7BqLGM/Wa92
         eNYypwTywpd6WelSB6qAzgraAMaAT725rtlK3vF1oavPqVDtvB5gSUb0EfMWRpOZfXb+
         w86CuJRAP20QEzeMX0DYwE9Xonf5xONmLXLnGqGepmA5OWHvlRbe0HQGvlyYICbwVwdC
         7+2JjcXKhUoM3R4bnp3PLB7ijlZe/D7JyaTO6/lTKOH8JikLCLkg/7X0szhBZCXyU3Mu
         IvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ySiSOnqcuA6nNk8c0jQCBZCPf0dSfXosbzJcm8d2dZY=;
        b=nUUmFusbq7s18bRvktn59lU7gwxHcFIznIa6/DxVkFu8CnnRpuusxpiJ0tn4ggUKaO
         USl4Of1Xj9PginZgUUx/Id9QRU7Zl35VfOw3dmKaOzxXC0fUSaSnEMRs+hrxPIuDS2xu
         yT9zAj9jzhZo6tEObIu93FKFcAMt/KdPWQogjXHq27M8//oWcI3ZuvpG/jCY4cyNuRGm
         nlmQhLWWOTSTIucw+dyBvSX9ZbgIX5JuKW2TXN9cvuoIF2P7b6me1zYNN8m/hHjrJkYa
         I7MKKL2Jd9SLcRYV8iVOVZiPeUHOxkQ7wIHTr5PsuevagktmzBm2QwmyQ0bz4gK7Fydc
         zukQ==
X-Gm-Message-State: ANhLgQ3nWeG/yyFuAlERIeVwrTgYQjyhNqlnBbC+szBTtPZizW8+1o9O
        Yx5Mp0rSLSA08hVY9jSHiNl1SMP9zTudaKQnaFohcw==
X-Google-Smtp-Source: ADFU+vt2Ptn+2fuU7L5gaFz0uxQGB+VvuZ4/Df2PK08OKaAQBCL6bfkBEoaOGk9rhadFD/j7RFC6f9y4mgdpei2KZt8=
X-Received: by 2002:aa7:c983:: with SMTP id c3mr3441099edt.98.1583340099330;
 Wed, 04 Mar 2020 08:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20200225235856.975366-1-jason@jlekstrand.net> <8066d8b2-dd6a-10ef-a7bb-2c18a0661912@amd.com>
 <20200226100523.GQ2363188@phenom.ffwll.local> <CAOFGe94O66HL212aXqhi9tdYqw---Xm-fwNSV4pxHyPmpSGpbg@mail.gmail.com>
 <CAP+8YyEUz29fXDW5kO_0ZG6c849=TuFWCK8ynT3LuM+Tn+rMzw@mail.gmail.com>
 <810a26e7-4294-a615-b7ee-18148ac70641@amd.com> <CAOFGe96namyeQXTvdrduM+=wkJuoWWx34CxcsJHS3fcCaKDadw@mail.gmail.com>
 <21aeacc0-f3ae-c5dd-66df-4d2f3d73f73e@amd.com> <CAOFGe95Gx=kX=sxwhx1FYmXQuPtGAKwt2V5YodQBwJXujE3WwA@mail.gmail.com>
In-Reply-To: <CAOFGe95Gx=kX=sxwhx1FYmXQuPtGAKwt2V5YodQBwJXujE3WwA@mail.gmail.com>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Wed, 4 Mar 2020 10:41:28 -0600
Message-ID: <CAOFGe97XSxgzCViOH=2+B2_d5P3vGifKmvAw-JrzRQbbRMRbcg@mail.gmail.com>
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

On Wed, Mar 4, 2020 at 10:27 AM Jason Ekstrand <jason@jlekstrand.net> wrote=
:
>
> On Wed, Mar 4, 2020 at 2:34 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> > Am 03.03.20 um 20:10 schrieb Jason Ekstrand:
> > > On Thu, Feb 27, 2020 at 2:28 AM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> [SNIP]
> > >>> However, I'm not sure what the best way is to do garbage collection=
 on
> > >>> that so that we don't get an impossibly list of fence arrays.
> > >> Exactly yes. That's also the reason why the dma_fence_chain containe=
r I
> > >> came up with for the sync timeline stuff has such a rather sophistic=
ated
> > >> garbage collection.
> > >>
> > >> When some of the included fences signal you need to free up the
> > >> array/chain and make sure that the memory for the container can be r=
eused.
> > > Currently (as of v2), I'm using dma_fence_array and being careful to
> > > not bother constructing one if there's only one fence in play.  Is
> > > this insufficient?  If so, maybe we should consider improving
> > > dma_fence_array.
> >
> > That still won't work correctly in all cases. See the problem is not
> > only optimization, but also avoiding situations where userspace can
> > abuse the interface to do nasty things.
> >
> > For example if userspace just calls that function in a loop you can
> > create a long chain of dma_fence_array objects.
> >
> > If that chain is then suddenly released the recursive dropping of
> > references can overwrite the kernel stack.
> >
> > For reference see what dance is necessary in the dma_fence_chain_releas=
e
> > function to avoid that:
> > >         /* Manually unlink the chain as much as possible to avoid
> > > recursion
> > >          * and potential stack overflow.
> > >          */
> > >         while ((prev =3D rcu_dereference_protected(chain->prev, true)=
)) {
> > ....
> >
> > It took me quite a while to figure out how to do this without causing
> > issues. But I don't see how this would be possible for dma_fence_array.
>
> Ah, I see the issue now!  It hadn't even occurred to me that userspace
> could use this to build up an infinite recursion chain.  That's nasty!
>  I'll give this some more thought and see if can come up with
> something clever.
>
> Here's one thought:  We could make dma_fence_array automatically
> collapse any arrays it references and instead directly reference their
> fences.  This way, no matter how much the client chains things, they
> will never get more than one dma_fence_array.  Of course, the
> difficulty here (answering my own question) comes if they ping-pong
> back-and-forth between something which constructs a dma_fence_array
> and something which constructs a dma_fence_chain to get
> array-of-chain-of-array-of-chain-of-...  More thought needed.

Answering my own questions again...  I think the
array-of-chain-of-array case is also solvable.

For array-of-chain, we can simply add all unsignaled dma_fences in the
chain to the array.  The array won't signal until all of them have
which is exactly the same behavior as if we'd added the chain itself.

For chain-of-array, we can add all unsignaled dma_fences in the array
to the same point in the chain.  There may be some fiddling with the
chain numbering required here but I think we can get it so the chain
won't signal until everything in the array has signaled and we get the
same behavior as if we'd added the dma_fence_array to the chain.

In both cases, we end up with either a single array or a single and
destruction doesn't require recursion.  Thoughts?

--Jason
