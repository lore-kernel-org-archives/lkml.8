Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C610C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E45E2078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvC6qmV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgGAREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:04:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47299 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732124AbgGAREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593623075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiOy7ZAOZwRJYpQTDCr66D5MQt2g8hiPsepvJGe2kJ4=;
        b=NvC6qmV+u+kDchGWDWBaKVYu+bM0WMpQVgOdE3CCzEpHY7blZ3js5zmH8wnc+/6fIqiPgv
        mXn7CThID/cDACfRM1eZH80fZo3CAACNITKIZs6CUf6UeGglCGzZQ/xYBKHrmhEW82hqfE
        VIyUeD9kgeDEd9UOh+aIHxEYKOvZ/cw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-oRhJNQn6P5CIwgxrm82oKQ-1; Wed, 01 Jul 2020 13:04:27 -0400
X-MC-Unique: oRhJNQn6P5CIwgxrm82oKQ-1
Received: by mail-qk1-f197.google.com with SMTP id 204so17512085qki.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiOy7ZAOZwRJYpQTDCr66D5MQt2g8hiPsepvJGe2kJ4=;
        b=P113SoeoZus4xI26NzyyrbIUIJah4q8nS0Cr17YsEh10HETl304dXkQpqUSGLdCV4l
         F/P5GfrW4+L3hyEWNCZrqV8Z9KPwGHZTq7Ueow+t9SoWxlXbsG43Nt1jfatrbp6jwnjg
         +Tpe8LrTKULSMGsrCqiKvgZyTJ4jqM2tz7AF2+4A9/RrBvdkH/iTposVTAn/39l9zY36
         +5aVFNnuI8fKc5L6GsH1Yk4ABJHZue30p7w240IyBKC917kLLg826rC4hDCpAuuszmtz
         iyBqyyObUzAJHGJCRKB81z3iovgV4JQ0ldfpcBcs7jAry2sgJ68Rh8J0IQDWwcltrBIC
         6Kyw==
X-Gm-Message-State: AOAM532HFH7p0w5XZtf/ZXpPAp0We862x0wv3sFJKXMTrLswSm56jY/4
        /wPkytderifcYu42tqynpaLrxhCrNFjV7xC3toI77L5mj/qKmEwureb3906s1B4cmZiG4fOhrcj
        LV9Yz+X1zunhCEj9qCBIBq36td+0iaU5IfkKn9Zta
X-Received: by 2002:a37:6d4:: with SMTP id 203mr25884089qkg.62.1593623067104;
        Wed, 01 Jul 2020 10:04:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2SUbbP+OsUxjyYRtHACYvHGVw89nPS0TjNrzdSgrgE8daRe/4deg3Lx3x6BzmbwLwLKGzVpZhckvrDz9TsIE=
X-Received: by 2002:a37:6d4:: with SMTP id 203mr25884064qkg.62.1593623066788;
 Wed, 01 Jul 2020 10:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com>
 <11e5ee1d-8b5e-2721-091e-ffbf9e1271d1@nvidia.com> <CAKMK7uEzoFyW6o1gP6xszWH7fKHrVSR32JLs73KeFfYgD=BHPQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEzoFyW6o1gP6xszWH7fKHrVSR32JLs73KeFfYgD=BHPQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 1 Jul 2020 19:04:15 +0200
Message-ID: <CACO55tu8z_Rt50QXUr+MBKV_vtxZfVgz8Cfoj2xbinbtTYM3WQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     James Jones <jajones@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:01 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Wed, Jul 1, 2020 at 5:51 PM James Jones <jajones@nvidia.com> wrote:
> >
> > On 7/1/20 4:24 AM, Karol Herbst wrote:
> > > On Wed, Jul 1, 2020 at 6:45 AM James Jones <jajones@nvidia.com> wrote:
> > >>
> > >> This implies something is trying to use one of the old
> > >> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
> > >> first checking whether it is supported by the kernel.  I had tried to
> > >> force an Xorg+Mesa stack without my userspace patches to hit this error
> > >> when testing, but must have missed some permutation.  If the stalled
> > >> Mesa patches go in, this would stop happening of course, but those were
> > >> held up for a long time in review, and are now waiting on me to make
> > >> some modifications.
> > >>
> > >
> > > that's completely irrelevant. If a kernel change breaks userspace,
> > > it's a kernel bug.
> >
> > Agreed it is unacceptable to break userspace, but I don't think it's
> > irrelevant.  Perhaps the musings on pending userspace patches are.
> >
> > My intent here was to point out it appears at first glance that
> > something isn't behaving as expected in userspace, so fixing this would
> > likely require some sort of work-around for broken userspace rather than
> > straight-forward fixing of a bug in the kernel logic.  My intent was not
> > to shift blame to something besides my code & testing for the
> > regression, though I certainly see how it could be interpreted that way.
> >
> > Regardless, I'm looking in to it.
>

I assume the MR you were talking about is
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/3724 ? I am
also aware of the tegra driver being broken on my jetson nano and I am
now curious if this MR could fix this bug as well... and sorry for the
harsh reply, I was just a annoyed by the fact that "everything
modifier related is just breaking things", first tegra and that nobody
is looking into fixing it and then apparently the userspace code being
quite broken as well :/

Anyway, yeah I trust you guys on figuring out the keeping "broken"
userspace happy from a kernel side and maybe I can help out with
reviewing the mesa bits. I am just wondering if it could help with the
tegra situation giving me more reasons to look into it as this would
solve other issues I should be working on :)

> If we do need to have a kernel workaround I'm happy to help out, I've
> done a bunch of these and occasionally it's good to get rather
> creative :-)
>
> Ideally we'd also push a minimal fix in userspace to all stable
> branches and make sure distros upgrade (might need releases if some
> distro is stuck on old horrors), so that we don't have to keep the
> hack in place for 10+ years or so. Definitely if the hack amounts to
> disabling modifiers on nouveau, that would be kinda sad.
> -Daniel
>
> >
> > Thanks,
> > -James
> >
> > >> Are you using the modesetting driver in X?  If so, with glamor I
> > >> presume?  What version of Mesa?  Any distro patches?  Any non-default
> > >> xorg.conf options that would affect modesetting, your X driver if it
> > >> isn't modesetting, or glamour?
> > >>
> > >> Thanks,
> > >> -James
> > >>
> > >> On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
> > >>> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
> > >>>> James Jones (4):
> > >>> ...
> > >>>>         drm/nouveau/kms: Support NVIDIA format modifiers
> > >>>
> > >>> This commit is the first one that breaks Xorg startup for my setup:
> > >>> GTX 1080 + Dell UP2414Q (4K DP MST monitor).
> > >>>
> > >>> I believe this is the crucial part of dmesg (full dmesg is attached):
> > >>>
> > >>> [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
> > >>> [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
> > >>> [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
> > >>>
> > >>> Any suggestions?
> > >>>
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >>
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>

