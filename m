Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A456C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA25420658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMX3EfSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0JS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgG0JS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:18:58 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3AC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:18:57 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id g18so2167822ooa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc3ux+IsWbWWoLKJHkKGARI75ZF/T808eZJbHvIF1VM=;
        b=eMX3EfSoC71BJ468HuVnT4tHiHT+kZc9Rf5BLBGRmdbnX625br9/ZgrTVBIs9VkvxM
         h/NhtF6V+Z3r49dXCdhoqeoPsS6BbCAMMQSjziQVUeGaC+Ssn1F1wbxFkcVDpyMkMAJT
         TfGtlT4eQc8JuVia9jsB/3H03cpkXx//owQQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc3ux+IsWbWWoLKJHkKGARI75ZF/T808eZJbHvIF1VM=;
        b=Dk13JKtWKTIQkxlOoZzzQ6yXJddc7XJAuHLsP57rgNpA3jDa2e2VBfzIC55/LT28Bs
         K0STM4jkjbDFSfdXKVDWyw2T7DV4JNHr8R5wukSQPrShg49vxBmCIr+HNvjzjze5cZB4
         u/qs9QTbTaVS0mUG0EY3W7kYBkn1PImmldf0idKERHDf3JQG+LOfuS1LFBr3I9kZrH/0
         Kt6OSGfVMEFa32kMNj0RRXir/DtpcKhG4ez12ZOJuZCvcQAGwpAYlty6F16ezwrgcpf4
         ecSRTqejfTz6fAuIqyUqg2VTWffH29C1qudjfWWpV4fOmocFPNdKTjm4NXoIiFaIjMGn
         b7Ig==
X-Gm-Message-State: AOAM530L2/I0d/oPn2OxGvAkr9igRpGaevE0Tme8Rv5itIBqe2+tsN8W
        OcuHHN/j+fBjlcXxpmIsODXUz5YjlKM=
X-Google-Smtp-Source: ABdhPJwIREfkBMI5CXfaCfA9q0WAphSYKXQLoUzUbom6Jh+LubonCsAxk1IXVtngkSZfHGAFSsDm/w==
X-Received: by 2002:a4a:de49:: with SMTP id z9mr11771699oot.6.1595841536442;
        Mon, 27 Jul 2020 02:18:56 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id b11sm1576847oii.48.2020.07.27.02.18.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 02:18:55 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id n24so459722ooc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:18:55 -0700 (PDT)
X-Received: by 2002:a4a:1d83:: with SMTP id 125mr20003757oog.18.1595841534527;
 Mon, 27 Jul 2020 02:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092933.2089288-1-jjsu@chromium.org> <91e92ed1-5364-884d-79ab-20d64594deb2@koikeco.de>
In-Reply-To: <91e92ed1-5364-884d-79ab-20d64594deb2@koikeco.de>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Jul 2020 18:18:41 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW4qD8+1vW4HYb5Fg0Q-kMsHcQebRE-_4a4CSHpNcEFMw@mail.gmail.com>
Message-ID: <CAPBb6MW4qD8+1vW4HYb5Fg0Q-kMsHcQebRE-_4a4CSHpNcEFMw@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-dev/ioctl: Fix document for VIDIOC_QUERYCAP
To:     Helen Koike <helen@koikeco.de>
Cc:     Jian-Jia Su <jjsu@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 4:45 AM Helen Koike <helen@koikeco.de> wrote:
>
> Hi,
>
> On 7/20/20 6:29 AM, Jian-Jia Su wrote:
> > V4L2_CAP_VIDEO_M2M is documented as 0x00004000
> > V4L2_CAP_VIDEO_M2M_MPLANE is documented as 0x00008000
> > This is different from the definition in include/uapi/linux/videodev2.h
> >
>
> Nice catch, they are swapped in the docs indeed.
>
> From videodev2.h:
>
> /* Is a video mem-to-mem device that supports multiplanar formats */
> #define V4L2_CAP_VIDEO_M2M_MPLANE       0x00004000
> /* Is a video mem-to-mem device */
> #define V4L2_CAP_VIDEO_M2M              0x00008000
>
> > Signed-off-by: Jian-Jia Su <jjsu@chromium.org>
>
> Reviewed-by: Helen Koike <helen.koike@collabora.com>

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>

>
> Regards,
> Helen
>
> > ---
> >  Documentation/userspace-api/media/v4l/vidioc-querycap.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> > index 666ac4d420519..90347367ef06a 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> > @@ -168,11 +168,11 @@ specification the ioctl returns an ``EINVAL`` error code.
> >        - The device supports the :ref:`multi-planar API <planar-apis>`
> >       through the :ref:`Video Output <output>` interface.
> >      * - ``V4L2_CAP_VIDEO_M2M``
> > -      - 0x00004000
> > +      - 0x00008000
> >        - The device supports the single-planar API through the Video
> >       Memory-To-Memory interface.
> >      * - ``V4L2_CAP_VIDEO_M2M_MPLANE``
> > -      - 0x00008000
> > +      - 0x00004000
> >        - The device supports the :ref:`multi-planar API <planar-apis>`
> >       through the Video Memory-To-Memory interface.
> >      * - ``V4L2_CAP_VIDEO_OVERLAY``
> >
