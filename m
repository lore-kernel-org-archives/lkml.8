Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32725C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1EA20702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHkY2YMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgGALYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:24:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730196AbgGALYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593602658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0yfRNSZH7jw3LwxF/5C1mFfotPxZcAA3DmkNVF3agc=;
        b=iHkY2YMUGWFd7ZNtKJ7Id2PJLB2moD8F8n4g+aam2oVKkVoRSxyt9B3NzsMTgE59kOiZp4
        bt0vtzJ8Xm6ene7xaolTNotM4BxFS1zZrmoAWfWt5rW1w6wNjS4Y+7QPvWVYLL1oMQ2vSd
        kaXAwqpsWaKXjE0axAVciPUFCeUInmg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-PxuC8yTYPvi4S1yXQDL6_Q-1; Wed, 01 Jul 2020 07:24:11 -0400
X-MC-Unique: PxuC8yTYPvi4S1yXQDL6_Q-1
Received: by mail-qt1-f198.google.com with SMTP id c22so16620391qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 04:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0yfRNSZH7jw3LwxF/5C1mFfotPxZcAA3DmkNVF3agc=;
        b=Y/jzj81epR/J/wmm+B+44v4hEbzd2pVWvPDFwpv2lmFxThYKdyTBr1iukIoS1udl6E
         PNDsAPka3lhcutI9TXrccKWc63/8W3G92BMBZFHXcaYVAWlMaP/vYswLx7/yAG/g/pfF
         YS1UXJiR0Xgq1JUhBJcqYog+Mk8vyHQJAdJdRMv+bCI7YxPbrduBDvheb98uARYhtwTH
         Cjf8SRby7s01s/9aoIkr6XyniUEwn/Ai8ijCQiSCjd4KyF7oGFFSnMDRHODUeoTvgEJt
         0oNQbtwg6Vt8rBBAqYJJ24OWsPKqlht2+0nU51n8frbxBGckMHaGMATr1aURZc6K/YwG
         SCdw==
X-Gm-Message-State: AOAM533RR8AtKBBBD1YnlUXrDPxMmmlbquE5JGUoWUhGAvHP/Icb2Qbv
        jFk3Qq278Sx3bd4BMTiSRLcLDN6w7gZN6PWDV8nJ4F08iqpuBBCR+dSeDfmhNRUw0mh0ga9dAjH
        3g6efNbqwhBZzMl2uNxIc07IRIaLyfxXLcSSDB4En
X-Received: by 2002:aed:208c:: with SMTP id 12mr25653170qtb.286.1593602651313;
        Wed, 01 Jul 2020 04:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbe3/mk0yAROfKDdFroQfk3ZID3DtTYPB35Q69fjTtOuyoXNweu61AJE29nOxb7iqVnZIUltP//HI7XwvB/DM=
X-Received: by 2002:aed:208c:: with SMTP id 12mr25653150qtb.286.1593602650968;
 Wed, 01 Jul 2020 04:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box> <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
In-Reply-To: <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 1 Jul 2020 13:24:00 +0200
Message-ID: <CACO55tvT0fOMai7k7oAP1TL42YAuMwJocxk2seNgjYibs+h5oA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     James Jones <jajones@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ben Skeggs <bskeggs@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:45 AM James Jones <jajones@nvidia.com> wrote:
>
> This implies something is trying to use one of the old
> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
> first checking whether it is supported by the kernel.  I had tried to
> force an Xorg+Mesa stack without my userspace patches to hit this error
> when testing, but must have missed some permutation.  If the stalled
> Mesa patches go in, this would stop happening of course, but those were
> held up for a long time in review, and are now waiting on me to make
> some modifications.
>

that's completely irrelevant. If a kernel change breaks userspace,
it's a kernel bug.

> Are you using the modesetting driver in X?  If so, with glamor I
> presume?  What version of Mesa?  Any distro patches?  Any non-default
> xorg.conf options that would affect modesetting, your X driver if it
> isn't modesetting, or glamour?
>
> Thanks,
> -James
>
> On 6/30/20 4:08 PM, Kirill A. Shutemov wrote:
> > On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
> >> James Jones (4):
> > ...
> >>        drm/nouveau/kms: Support NVIDIA format modifiers
> >
> > This commit is the first one that breaks Xorg startup for my setup:
> > GTX 1080 + Dell UP2414Q (4K DP MST monitor).
> >
> > I believe this is the crucial part of dmesg (full dmesg is attached):
> >
> > [   29.997140] [drm:nouveau_framebuffer_new] Unsupported modifier: 0x300000000000014
> > [   29.997143] [drm:drm_internal_framebuffer_create] could not create framebuffer
> > [   29.997145] [drm:drm_ioctl] pid=3393, ret = -22
> >
> > Any suggestions?
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

