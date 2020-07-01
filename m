Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8092EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6498520780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QT+y11q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgGAQBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgGAQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:01:23 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34005C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:01:23 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so11154113otw.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opIAV5Btwy4qujYY2tne4EOq5x9GaN0PdpZUvrVNkEg=;
        b=QT+y11q+fYPFoAgRaAVqtnp2UhXVmkS8TQepM4N+CnM8Eqh4tOB/OZ3EwtiKn9g+lK
         28OMY5L1KPgIyYVgEhHV7Xm6n/rKzq/macN2yL9YjySCTQf9efk+j1ElSFbeYbCr4Yzi
         DQgMyLDBENz/wlx86OjeD+Lg+Hp1/gwyGynr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opIAV5Btwy4qujYY2tne4EOq5x9GaN0PdpZUvrVNkEg=;
        b=Mcnmz4KY2AhbRmQHNNobf3sGB+19sRGS/otYXvz27DKwyOVeE/uIdbuhwjU9VlpBft
         +pIPay0kbprnH0J0vRnB0mWU3lYiorsQK8ZxKT5HB4JqYhu53rPHxAd5Trt0X97ZLVEu
         0fkPxP1PaMtyQkobqJiUvIhujvMn2xYqQ5jIALSY0FMAR4wb7ZB9PVOcV0hb9udVwVNu
         dH6iI7BPZ6Q2OXk91RHujd3tNkCQQEic3m8nVlONji4snbpnAMweAc7YKProKL2PkDW/
         pppg3brLW7PX782OqekojyWlfXbLU5DJN9DotoaRuH8MC0afM0cw6jsEROT/77JZb+n2
         qIbg==
X-Gm-Message-State: AOAM533AG8WtzEeUDfFQBjK7MseAlk4fdXL+Jf9BYCi+IGDOF/eYKQKs
        QZ84Jz0sowrqhKO2rKCy8zozZz363JadngaVyu5ooA==
X-Google-Smtp-Source: ABdhPJzdd+BhqVEmNutlYxCfKiqBwqfoMHuSEqyxghVO1Q29gOqOuPefP5pTioX762sMqposCOg2Vs3EH3LhN0G8A9k=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr10443362otr.303.1593619282388;
 Wed, 01 Jul 2020 09:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
 <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com> <11e5ee1d-8b5e-2721-091e-ffbf9e1271d1@nvidia.com>
In-Reply-To: <11e5ee1d-8b5e-2721-091e-ffbf9e1271d1@nvidia.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 1 Jul 2020 18:01:10 +0200
Message-ID: <CAKMK7uEzoFyW6o1gP6xszWH7fKHrVSR32JLs73KeFfYgD=BHPQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     James Jones <jajones@nvidia.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
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

On Wed, Jul 1, 2020 at 5:51 PM James Jones <jajones@nvidia.com> wrote:
>
> On 7/1/20 4:24 AM, Karol Herbst wrote:
> > On Wed, Jul 1, 2020 at 6:45 AM James Jones <jajones@nvidia.com> wrote:
> >>
> >> This implies something is trying to use one of the old
> >> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
> >> first checking whether it is supported by the kernel.  I had tried to
> >> force an Xorg+Mesa stack without my userspace patches to hit this error
> >> when testing, but must have missed some permutation.  If the stalled
> >> Mesa patches go in, this would stop happening of course, but those were
> >> held up for a long time in review, and are now waiting on me to make
> >> some modifications.
> >>
> >
> > that's completely irrelevant. If a kernel change breaks userspace,
> > it's a kernel bug.
>
> Agreed it is unacceptable to break userspace, but I don't think it's
> irrelevant.  Perhaps the musings on pending userspace patches are.
>
> My intent here was to point out it appears at first glance that
> something isn't behaving as expected in userspace, so fixing this would
> likely require some sort of work-around for broken userspace rather than
> straight-forward fixing of a bug in the kernel logic.  My intent was not
> to shift blame to something besides my code & testing for the
> regression, though I certainly see how it could be interpreted that way.
>
> Regardless, I'm looking in to it.

If we do need to have a kernel workaround I'm happy to help out, I've
done a bunch of these and occasionally it's good to get rather
creative :-)

Ideally we'd also push a minimal fix in userspace to all stable
branches and make sure distros upgrade (might need releases if some
distro is stuck on old horrors), so that we don't have to keep the
hack in place for 10+ years or so. Definitely if the hack amounts to
disabling modifiers on nouveau, that would be kinda sad.
-Daniel

>
> Thanks,
> -James
>
> >> Are you using the modesetting driver in X?  If so, with glamor I
> >> presume?  What version of Mesa?  Any distro patches?  Any non-default
> >> xorg.conf options that would affect modesetting, your X driver if it
> >> isn't modesetting, or glamour?
> >>
> >> Thanks,
> >> -James
> >>
> >> On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
> >>> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
> >>>> James Jones (4):
> >>> ...
> >>>>         drm/nouveau/kms: Support NVIDIA format modifiers
> >>>
> >>> This commit is the first one that breaks Xorg startup for my setup:
> >>> GTX 1080 + Dell UP2414Q (4K DP MST monitor).
> >>>
> >>> I believe this is the crucial part of dmesg (full dmesg is attached):
> >>>
> >>> [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
> >>> [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
> >>> [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
> >>>
> >>> Any suggestions?
> >>>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >



--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
