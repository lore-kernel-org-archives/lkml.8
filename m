Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65DC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6ED21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jlekstrand-net.20150623.gappssmtp.com header.i=@jlekstrand-net.20150623.gappssmtp.com header.b="sw2i/fR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgBZP3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:29:10 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34621 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgBZP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:29:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id dm3so3426694edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=898Q2WKYV18ycUsGUQ5fpkphxz5nLnP3Wgq4DGZP9R8=;
        b=sw2i/fR6Ri3cLKW9UUkrWGrIJWjxqMBvsuzPoeo0kSO4h3mWI2HM8uOu4WJwo9XtbW
         XHiAnbHkK7QNIlrKKcNFcKjtIvdGbg7WtFi5d7cm+/NBatkK7o1YXejtVUhNnSyS6myF
         G0ext9Mrjfe7yXyCZLHUja9LmyVu/2RBa0ycOEhUJhfV8lBgy5qkcDiF+Y0kbfz3UU40
         IAb0Wo5v5teoIeBaqjgDcX+/r7YNKEo6SwfCUSMv23jzQIh07KaznLlr1+Tc1sNcG1jk
         ZfjpWwRiICbLbSkfnrPS+htGwSFfQuZP+UqV130hTxFneqXibXs5LqbszGkScGEBRKPb
         6Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=898Q2WKYV18ycUsGUQ5fpkphxz5nLnP3Wgq4DGZP9R8=;
        b=l+RSRP6NhUNoECqaXNKWvuESk3KF4FLJBAblOq9TFTGI4F5098RFzPPYNAOgziQFij
         0Ua6u7wn9pX0P2ZP+mfT+1Gc8Z3V4RKiiRl8hQ4Ol0xhoN3RuFSJiT6Y4dUrJrdBuEGh
         R2RFoB4O2sKZ6FWfS6xcFpPFmQluXMC0h/nlhfRPN0OsyEU9lflBEKtBZ3M1DIu2W5zo
         qxgxtZvNtPOxiJSlsn8u5qd8g5WPJc2Rf1cAWcqLywehA9p1lV29cuBPg3G0UCWj8XNx
         ANMg9YSBeyUnqn/Muh8nn1g/17mZzGLhUM+MGdDCWlEzMuhvTCli7QrM+MNTYQqOl9nf
         vSTA==
X-Gm-Message-State: APjAAAXSCu+HHlra51BT4UmE7JfnCPsUlD80PZA73pEZ17JicCA9cX1k
        fP2+HdYRepIQu+yRpyFJg3CyWAFTLiDSTP1eZS2Qqg==
X-Google-Smtp-Source: APXvYqz/rN46995i2IEGv1eDqy8bGhlYQNvH8+xnc+9pcOxJ65YAYzlSyQCZ40CdyVlYBY6gxX6F2FeTa8NemOeymaU=
X-Received: by 2002:a05:6402:6c2:: with SMTP id n2mr5186320edy.241.1582730946258;
 Wed, 26 Feb 2020 07:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20200225235856.975366-1-jason@jlekstrand.net> <8066d8b2-dd6a-10ef-a7bb-2c18a0661912@amd.com>
 <20200226100523.GQ2363188@phenom.ffwll.local>
In-Reply-To: <20200226100523.GQ2363188@phenom.ffwll.local>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Wed, 26 Feb 2020 09:28:55 -0600
Message-ID: <CAOFGe94O66HL212aXqhi9tdYqw---Xm-fwNSV4pxHyPmpSGpbg@mail.gmail.com>
Subject: Re: [PATCH] RFC: dma-buf: Add an API for importing and exporting sync files
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Airlie <airlied@redhat.com>,
        Jesse Hall <jessehall@google.com>,
        James Jones <jajones@nvidia.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Daniel Stone <daniels@collabora.com>,
        =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chenbo Feng <fengc@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        linux-media@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 4:05 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Feb 26, 2020 at 10:16:05AM +0100, Christian K=C3=B6nig wrote:
> > Hi Jason,
> >
> > Am 26.02.20 um 00:58 schrieb Jason Ekstrand:
> > > Explicit synchronization is the future.  At least, that seems to be w=
hat
> > > most userspace APIs are agreeing on at this point.  However, most of =
our
> > > Linux APIs (both userspace and kernel UAPI) are currently built aroun=
d
> > > implicit synchronization with dma-buf.  While work is ongoing to chan=
ge
> > > many of the userspace APIs and protocols to an explicit synchronizati=
on
> > > model, switching over piecemeal is difficult due to the number of
> > > potential components involved.  On the kernel side, many drivers use
> > > dma-buf including GPU (3D/compute), display, v4l, and others.  In
> > > userspace, we have X11, several Wayland compositors, 3D drivers, comp=
ute
> > > drivers (OpenCL etc.), media encode/decode, and the list goes on.
> > >
> > > This patch provides a path forward by allowing userspace to manually
> > > manage the fences attached to a dma-buf.  Alternatively, one can thin=
k
> > > of this as making dma-buf's implicit synchronization simply a carrier
> > > for an explicit fence.  This is accomplished by adding two IOCTLs to
> > > dma-buf for importing and exporting a sync file to/from the dma-buf.
> > > This way a userspace component which is uses explicit synchronization=
,
> > > such as a Vulkan driver, can manually set the write fence on a buffer
> > > before handing it off to an implicitly synchronized component such as=
 a
> > > Wayland compositor or video encoder.  In this way, each of the differ=
ent
> > > components can be upgraded to an explicit synchronization model one a=
t a
> > > time as long as the userspace pieces connecting them are aware of it =
and
> > > import/export fences at the right times.
> > >
> > > There is a potential race condition with this API if userspace is not
> > > careful.  A typical use case for implicit synchronization is to wait =
for
> > > the dma-buf to be ready, use it, and then signal it for some other
> > > component.  Because a sync_file cannot be created until it is guarant=
eed
> > > to complete in finite time, userspace can only signal the dma-buf aft=
er
> > > it has already submitted the work which uses it to the kernel and has
> > > received a sync_file back.  There is no way to atomically submit a
> > > wait-use-signal operation.  This is not, however, really a problem wi=
th
> > > this API so much as it is a problem with explicit synchronization
> > > itself.  The way this is typically handled is to have very explicit
> > > ownership transfer points in the API or protocol which ensure that on=
ly
> > > one component is using it at any given time.  Both X11 (via the PRESE=
NT
> > > extension) and Wayland provide such ownership transfer points via
> > > explicit present and idle messages.
> > >
> > > The decision was intentionally made in this patch to make the import =
and
> > > export operations IOCTLs on the dma-buf itself rather than as a DRM
> > > IOCTL.  This makes it the import/export operation universal across al=
l
> > > components which use dma-buf including GPU, display, v4l, and others.
> > > It also means that a userspace component can do the import/export
> > > without access to the DRM fd which may be tricky to get in cases wher=
e
> > > the client communicates with DRM via a userspace API such as OpenGL o=
r
> > > Vulkan.  At a future date we may choose to add direct import/export A=
PIs
> > > to components such as drm_syncobj to avoid allocating a file descript=
or
> > > and going through two ioctls.  However, that seems to be something of=
 a
> > > micro-optimization as import/export operations are likely to happen a=
t a
> > > rate of a few per frame of rendered or decoded video.
> > >
> > > Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
> > > ---
> > >
> > > This is marked as an RFC because I intend it to start a discussion ab=
out
> > > how to solve a problem.  The current patch compiles but that's it for=
 now.
> > > I'll be writing IGT tests and Vulkan driver patches which exercise it=
 over
> > > the next couple of days.  In the mean time, feel free to tell me why =
you
> > > think this is a great and/or terrible idea. :-)
> >
> > For the exporting part I think it is an absolutely great idea because i=
t
> > simplifies compatibility with explicit sync quite a bit.

Unfortunately, it only helps half of explicit sync and not the half
that's hard to deal with from Vulkan. :-/

> > But for the importing part it is a clear NAK at the moment. See we can'=
t
> > allow userspace to mess with DMA-buf fences in that way because it rips=
 open
> > a security hole you can push an elephant through.

Oh, sure, I'm 100% sure I did that part wrong.  Why else would I send
the patch but to have someone who actually knows what they're doing
tell me how to do it correctly? :-P

> > Just imagine that you access some DMA-buf with a shader and that operat=
ion
> > is presented as a fence on the DMA-bufs reservation object. And now you=
 can
> > go ahead and replace that fence and free up the memory.
> >
> > Tricking the Linux kernel into allocating page tables in that freed mem=
ory
> > is trivial and that's basically it you can overwrite page tables with y=
our
> > shader and gain access to all of system memory :)
> >
> > What we could do is to always make sure that the added fences will comp=
lete
> > later than the already existing ones, but that is also rather tricky to=
 get
> > right. I wouldn't do that if we don't have a rather big use case for th=
is.

Right.  I thought about that but I'm still learning how dma_resv
works.  It'd be easy enough to make a fence array that contains both
the old fence and the new fence and replace the old fence with that.
What I don't know is the proper way to replace the exclusive fence
safely.  Some sort of atomic_cpxchg loop, perhaps?  I presume there's
some way of doing it properly because DRM drivers are doing it all the
time.

> I think the main use-case for adding a fence is adding a write fence for
> vk winsys buffers, which run without any sync at all. So essentially what
> we'd do is promote one of the read fences which are already attached to b=
e
> the write fence.

Correct.  We're effectively doing an import in ANV today but we're
doing it with a dummy execbuf which claims to write the BO and has a
batch that's just MI_BATCH_BUFFER_END.

> But yeah making sure we don't break any of the dma_resv guarantees about
> how these fences works is going to be somewhat tricky. Probably can reuse
> a big chunk of the fence container work we've done for syncobj timelines,
> since they have some of the same issues of having to chain fences to not
> break the world.

Happy to not break the world.  I just don't know how yet. :-)

--Jason
