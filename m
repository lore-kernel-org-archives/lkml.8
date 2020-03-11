Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDEC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E718F21D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="nJ8/+eXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgCKDnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:43:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43698 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:43:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id dc19so1109562edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CCpVdCL5A6Oia90+I5IH75I8Yb81GbOHYhkCg0SoRo4=;
        b=nJ8/+eXQLL14Bq3hAfEKaNkcuE0LJoTv4/4MeEEXgzMp4KLSx9aY7HnJZ9UhVp3W9Y
         fXxkd5cNxriEVWhu7CxUFZ/Wk0e50qIqXnTH6Ri9UJZf9mPscvZif0BVieasPbLbv5kb
         GQmVIMXbKASfnhROqiBIDAe48wIKVspe9m4dDZnvUuNZ9UaPD8GcRDiL3X0ldOcZ+pnI
         k2gVgpXexZUSH7fKQ3eFnG3kD3wsPIhFOiRjGQo1kylrAqUGMYwz1s6/jMMNH/ytSVv8
         KQeML8Q5Nqh30BBdkcpyaonvrG4g9J2RN2B//RrG0wjhlVWCt5pZSIHQzypaJKqJS2g5
         rV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCpVdCL5A6Oia90+I5IH75I8Yb81GbOHYhkCg0SoRo4=;
        b=piesGniNnngr/R0l+EwdsfCt5nIso7GoBUOb0QoggdmcvOmZotpYS8Qgx2UeEJegfY
         IKBNqSUfpfAyfeKCR6lO4eXmhPI73mWesO5ebnR0yzB+qMyadJMeicFz7/vG/rkOTj7N
         +K+Ii2lBpNVaHGE/gHlP/kJem+7QvXde20BcgGzyCtd7UONQgT0M+LzxqQeXw5GwAmYp
         Bjzy3Z8Zfjcwt8VlLihCYNArroZqLNxb83S1kyLSh7ybJYxRvFKcDSQBmklHe27AAX6t
         kTsdpFAemTE9OUIgvo15eADd4DpWtmJjMAADyNv0KryL4vL22wn5FWzGXHahCpOE3utu
         x3Cg==
X-Gm-Message-State: ANhLgQ0GhTprwGPOGOeSMSQnqPtCv8b8Xt5t6E7J/ZCfCTqZIETubQb4
        IgHMDGM6byssezbiFuPgt1QjGtZZ9tiLk4v7g5sW2w==
X-Google-Smtp-Source: ADFU+vvpVyJEYOHSvxTt0jv9faPw/cY00LFVDFiLuvXyfzEgv30x/D/c6hrhc0XXqk7qHc23+OeLh0RzP5ZxEyP2RYI=
X-Received: by 2002:a50:f38e:: with SMTP id g14mr958779edm.168.1583898213971;
 Tue, 10 Mar 2020 20:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200225235856.975366-1-jason@jlekstrand.net> <8066d8b2-dd6a-10ef-a7bb-2c18a0661912@amd.com>
 <20200226100523.GQ2363188@phenom.ffwll.local> <CAOFGe94O66HL212aXqhi9tdYqw---Xm-fwNSV4pxHyPmpSGpbg@mail.gmail.com>
 <CAP+8YyEUz29fXDW5kO_0ZG6c849=TuFWCK8ynT3LuM+Tn+rMzw@mail.gmail.com>
 <810a26e7-4294-a615-b7ee-18148ac70641@amd.com> <CAOFGe96namyeQXTvdrduM+=wkJuoWWx34CxcsJHS3fcCaKDadw@mail.gmail.com>
 <21aeacc0-f3ae-c5dd-66df-4d2f3d73f73e@amd.com> <CAOFGe95Gx=kX=sxwhx1FYmXQuPtGAKwt2V5YodQBwJXujE3WwA@mail.gmail.com>
 <CAOFGe97XSxgzCViOH=2+B2_d5P3vGifKmvAw-JrzRQbbRMRbcg@mail.gmail.com>
 <6fb8becf-9e6b-f59e-9c22-2b20069241a7@amd.com> <CAOFGe94gv9N+6n6oEC2aRtsmy7kBfx1D_R6WLQSGq7-8yUM_OQ@mail.gmail.com>
 <203505dc-7b75-1135-587e-cc6e88ade8cd@amd.com>
In-Reply-To: <203505dc-7b75-1135-587e-cc6e88ade8cd@amd.com>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Tue, 10 Mar 2020 22:43:22 -0500
Message-ID: <CAOFGe94DnZcTb51TE3kFYxMgLkEWdNg2Yz3f4BEWNXz4GTOs7Q@mail.gmail.com>
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

On Mon, Mar 9, 2020 at 11:21 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 05.03.20 um 16:54 schrieb Jason Ekstrand:
> > On Thu, Mar 5, 2020 at 7:06 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> [SNIP]
> >> Well as far as I can see this won't work because it would break the
> >> semantics of the timeline sync.
> > I'm not 100% convinced it has to.  We already have support for the
> > seqno regressing and we ensure that we still wait for all the fences.
> > I thought maybe we could use that but I haven't spent enough time
> > looking at the details to be sure.  I may be missing something.
>
> That won't work. The seqno regression works by punishing userspace for
> doing something stupid and undefined.
>
> Be we can't do that under normal circumstances.
>
> >> I can prototype that if you want, shouldn't be more than a few hours o=
f
> >> hacking anyway.
> > If you'd like to, go for it.  I'd be happy to give it a go as well but
> > if you already know what you want, it may be easier for you to just
> > write the patch for the cursor.
>
> Send you two patches for that a few minutes ago. But keep in mind that
> those are completely untested.

No worries.  They were full of bugs but I think I've got them sorted
out now.  The v2's I'm about to send seem to work.  I'm going to leave
a Vulkan demo running all night long just to make sure I'm not leaking
memory like mad.

--Jason

> > Two more questions:
> >
> >   1. Do you want this collapsing to happen every time we create a
> > dma_fence_array or should it be a special entrypoint?  Collapsing all
> > the time likely means doing extra array calculations instead of the
> > dma_fence_array taking ownership of the array that's passed in.  My
> > gut says that cost is ok; but my gut doesn't spend much time in kernel
> > space.
>
> In my prototype implementation that is a dma_resv function you call and
> get either a single fence or a dma_fence_array with the collapsed fences
> in return.
>
> But I wouldn't add that to the general dma_fence_array_init function
> since this is still a rather special case. Well see the patches, they
> should be pretty self explaining.
>
> >   2. When we do the collapsing, should we call dma_fence_is_signaled()
> > to avoid adding signaled fences to the array?  It seems like avoiding
> > adding references to fences that are already signaled would let the
> > kernel clean them up faster and reduce the likelihood that a fence
> > will hang around forever because it keeps getting added to arrays with
> > other unsignaled fences.
>
> I think so. Can't think of a good reason why we would want to add
> already signaled fences to the array.
>
> Christian.
>
> >
> > --Jason
>
