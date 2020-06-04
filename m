Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F01C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B40A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VXb0tquW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgFDJgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgFDJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:36:37 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFBC03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:36:37 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id e8so1110639ooi.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z9Gmt7c5N9Wuf1xRRCeQ6LGP+x2nsJ1lC3QXqc/8Dhc=;
        b=VXb0tquWgjUAVrjUQvBFkjElO+us0sp63/gsGT4muxVdIPXG+oOFyRdt5aJn92ZJCE
         JEx8kDimDYdhzsWhF2WmVH5MN3MfzCxv74ky6abUFQGxx1keKlESVewu1Qc/kd4r6C/w
         DTSeetaURTCVMFTRo+qfVX0P6p2YnA4RabcrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z9Gmt7c5N9Wuf1xRRCeQ6LGP+x2nsJ1lC3QXqc/8Dhc=;
        b=ciAqzKj0vZ6HGq987re1gIyMugAMiNKwVl7NoqZEWhjq4aMZ9X+GbIGvzJIWx983oe
         21ZecIuzodSMy7msqyUg4d44t/x4Xu61gxLxh8b7mDoA7fSk+P3oyll2CXs0GVK5PTvP
         TVz3ntm7ojz5veGPjk8DiwPF9ww62Q4bh7r02YXqLLwJ7j6aO80cb/ieJV1HgB+Fo4pg
         c3vagW5WQIuubW9LUYWGE58ovPJOJzhnQc/8pS41Dt8fbucoJQLn8DwIe158VTbaHNxo
         unt32GGtmybValeEVRxaEGQkonPP4TMsMoJbH0ssjbnF8MaHzovUc4zeSyNFVk+npfDL
         cZhg==
X-Gm-Message-State: AOAM530SYym1diJEeDjnYuRACgsMeqTNoasT8D5KhHqFTJBS9T65Rdvc
        +qt8KRMzL3hhGR8h0iaq4TQm+bZpm4FoXJSVW3D+LQ==
X-Google-Smtp-Source: ABdhPJxAG9oiM1c1QpEnWLT/EWRbfMWy2gQklxD/IkomQ4LgpvxeJOMC+BW+nd+79+C1K6VQUmsFQCXuYgbPlpehCRs=
X-Received: by 2002:a4a:311d:: with SMTP id k29mr3016059ooa.89.1591263396299;
 Thu, 04 Jun 2020 02:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
 <CAKMK7uGLAPvvgHCCZhg0cea3Fz=Zqhf-GKS2OC3mZudYe3mKhw@mail.gmail.com> <159126281827.25109.3992161193069793005@build.alporthouse.com>
In-Reply-To: <159126281827.25109.3992161193069793005@build.alporthouse.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 4 Jun 2020 11:36:24 +0200
Message-ID: <CAKMK7uHOcH+rWhor7zzqqcjCUtxz_-5stLAOVD=4_ED+QjN8oQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 11:27 AM Chris Wilson <chris@chris-wilson.co.uk> wro=
te:
>
> Quoting Daniel Vetter (2020-06-04 10:21:46)
> > On Thu, Jun 4, 2020 at 10:57 AM Thomas Hellstr=C3=B6m (Intel)
> > <thomas_os@shipmail.org> wrote:
> > >
> > >
> > > On 6/4/20 10:12 AM, Daniel Vetter wrote:
> > > ...
> > > > Thread A:
> > > >
> > > >       mutex_lock(A);
> > > >       mutex_unlock(A);
> > > >
> > > >       dma_fence_signal();
> > > >
> > > > Thread B:
> > > >
> > > >       mutex_lock(A);
> > > >       dma_fence_wait();
> > > >       mutex_unlock(A);
> > > >
> > > > Thread B is blocked on A signalling the fence, but A never gets aro=
und
> > > > to that because it cannot acquire the lock A.
> > > >
> > > > Note that dma_fence_wait() is allowed to be nested within
> > > > dma_fence_begin/end_signalling sections. To allow this to happen th=
e
> > > > read lock needs to be upgraded to a write lock, which means that an=
y
> > > > other lock is acquired between the dma_fence_begin_signalling() cal=
l and
> > > > the call to dma_fence_wait(), and still held, this will result in a=
n
> > > > immediate lockdep complaint. The only other option would be to not
> > > > annotate such calls, defeating the point. Therefore these annotatio=
ns
> > > > cannot be sprinkled over the code entirely mindless to avoid false
> > > > positives.
> > >
> > > Just realized, isn't that example actually a true positive, or at lea=
st
> > > a great candidate for a true positive, since if another thread reente=
rs
> > > that signaling path, it will block on that mutex, and the fence would
> > > never be signaled unless there is another signaling path?
> >
> > Not sure I understand fully, but I think the answer is "it's complicate=
d".
>
> See cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
>
> dma_fence usage here is nothing but another name for a completion.

Quoting from my previous cover letter:

"I've dragged my feet for years on this, hoping that cross-release lockdep
would do this for us, but well that never really happened unfortunately.
So here we are."

I discussed this with Peter, cross-release not getting in is pretty
final it seems. The trouble is false positives without explicit
begin/end annotations reviewed by humans - ime from just these few
examples you just can't guess this stuff by computeres, you need real
brains thinking about all the edge cases, and where exactly the
critical section starts and ends. Without that you're just going to
drown in a sea of false positives and yuck.

So yeah I had hopes for cross-release too, unfortunately that was
entirely in vain and a distraction.

Now I guess it would be nice if there's a per-class
completion_begin/end annotation for the more generic problem. But then
also most people don't have a cross-driver completion api contract
like dma_fence is, with some of the most ridiculous over the top
constraints of what's possible and what's not possible on each side of
the cross-release. We do have a bit an outsized benefit (in pain
reduction) vs cost ratio here.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
