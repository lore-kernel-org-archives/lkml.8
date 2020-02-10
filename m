Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F5C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566FE208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 02:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="njnDO0Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgBJCps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 21:45:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43123 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBJCpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 21:45:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so6871260edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 18:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6BOdkflw0F8fh+pcm/A4VGksRSh2LmfGqE8fze11kVU=;
        b=njnDO0Uw5pFBphWZ/lxyvTRoVa7n6/kAPMJL9leHs+YzGd4xAYvyTCkF1pX8jVsgo3
         bHc65ricH3IhK/A0wqAq61TdAaybVTqbd3XMm0JJ+OcwZh39jG0HfeWwQvckWxPkFlhW
         OmnnEbCY7oSgyU/kbvF39WlCDe4C/TRk4xTqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6BOdkflw0F8fh+pcm/A4VGksRSh2LmfGqE8fze11kVU=;
        b=qJygqPGKrcqcUiMWGjZ6rVoKQiaQu9qgoU1I6BRg7c2qjKNW37kBoUfFJdqpv4rlIV
         zJnPObut58sMTrZW6D+1WiFWgxoq9cLe7a2+SIWh6j74pjdf40hGV25mhc6wHzGVb5O/
         gjCiKJohrfz2WQ8pbR1Dw8kk7F8OFboBPsBRWSuOqSMUEPD+bFciFIfYiayKSCMV71nv
         x/qZ5ZpYRK3MLMA5bh3sQ5a7FFCFYaXptjRZizCu3OZmC/tXrBQ02G7Ux3HQqMbXjnAi
         ZDIPt9OD/oqVxe9gR0hB+PoA3kvPl+1WDINnalPBfLfvcHkPm/wpo20HALUxS+SfHjlX
         OwlQ==
X-Gm-Message-State: APjAAAW7emWR6/5g8IyhTKsa2TpLWUPqRrVU3CuUE2IcZ2n6thnC+dhE
        fv+6S+y7CYl3qZykvclfhTgZC9350dEAxw==
X-Google-Smtp-Source: APXvYqzuEcr1ezYr2hsSK4ano8BrKD86rJHNORbexxj0iwsf2VLYQC132C+VPUHmQvXN6NqTXR2heg==
X-Received: by 2002:a50:d59b:: with SMTP id v27mr7964540edi.169.1581302744235;
        Sun, 09 Feb 2020 18:45:44 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ly13sm1497714ejb.22.2020.02.09.18.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 18:45:42 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id w12so5645618wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 18:45:42 -0800 (PST)
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr13652670wrp.17.1581302741582;
 Sun, 09 Feb 2020 18:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20191113175603.24742-1-ezequiel@collabora.com> <74fea061a52ee3f8e25793bf9e47eba90a52c3e3.camel@ndufresne.ca>
In-Reply-To: <74fea061a52ee3f8e25793bf9e47eba90a52c3e3.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 10 Feb 2020 11:45:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A8Y3C64NozqXjMDV0CQ5==dW9Y-6KtFigYFmO3EDd3+A@mail.gmail.com>
Message-ID: <CAAFQd5A8Y3C64NozqXjMDV0CQ5==dW9Y-6KtFigYFmO3EDd3+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Enable Hantro G1 post-processor
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 4:52 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mercredi 13 novembre 2019 =C3=A0 14:56 -0300, Ezequiel Garcia a =C3=A9=
crit :
> > Hi all,
> >
> > The Hantro G1 VPU post-processor block can be pipelined with
> > the decoder hardware, allowing to perform operations such as
> > color conversion, scaling, rotation, cropping, among others.
> >
> > When the post-processor is enabled, the decoder hardware
> > needs its own set of NV12 buffers (the native decoder format),
> > and the post-processor is the owner of the CAPTURE buffers,
> > allocated for the post-processed format.
> >
> > This way, applications obtain post-processed
> > (scaled, converted, etc) buffers transparently.
> >
> > This feature is implemented by exposing the post-processed pixel
> > formats on ENUM_FMT, ordered as "preferred pixelformat first":
> >
> > v4l2-ctl -d 1 --list-formats
> > ioctl: VIDIOC_ENUM_FMT
> >       Type: Video Capture Multiplanar
> >
> >       [0]: 'NV12' (Y/CbCr 4:2:0)
> >       [1]: 'YUYV' (YUYV 4:2:2)
> >
> > The order of preference in ENUM_FMT can be used as a hint
> > by applications. This series updates the uAPI specification
> > accordingly.
>
> As I'm implementing this, I realize that there may me a gap in being
> able to implement both IPP and non-IPP support in a generic framework.
> Unlike the above comment, we for non-IPP decoder we cannot naively pick
> the first format. In fact we parse the chroma and depth information
> from the headers (like pps from H264), and we pick a matching pixel
> format. This way, if we have a 10bit stream, and our IP supports 10bit,
> we will pick a 10bit pixel formats, otherwise decoding will just fail.
>
> None of this information is passed to the driver prior to the first
> Request being made, so there is no way (as of current spec) that the
> driver can validate this in try_fmt ahead of time. Unless I set picture
> parameters without a request_fd for that purpose. If this is the way,
> then we should document this.

+Alexandre Courbot

It was suggested in the very early RFC stage, but it looks like it
didn't make it to the final spec.
https://patchwork.kernel.org/patch/10583233/#22209555

>
> Is this the intended way to negotiation IPP functions with the driver ?
>

In theory, if the userspace knows whether the stream is 4:2:0 or 4:2:2
and 8-bit or 10-bit, it can still select the first format from the top
that matches these properties.

That's not how format handling in V4L2 works, though. ENUM_FMT is
expected to return a list of valid formats and if we forget about the
image processor for a moment, a stateless decoder would always return
any possible format, including ones invalid for the stream.

Now back to the image processor, if it handles conversions from any to
any format listed by ENUM_FMT, we kind of regain the V4L2 compliance,
but if the conversions are limited, the above requirement still
doesn't hold and we're not implementing V4L2 correctly.

Perhaps we can still amend the spec and require controls that
determine the stream properties to be set before starting the
streaming? I can imagine it could also help the driver filter out some
unsupported streams early, before allocating buffers and attempting to
decode.

Best regards,
Tomasz

> >
> > When the application sets a pixel format other than NV12,
> > the post-processor is transparently enabled.
> >
> > Patch 1 is a cleanups needed to easier integrate the post-processor.
> > Patch 2 introduces the post-processing support.
> > Patch 3 updates the uAPI specification.
> >
> > This is tested on RK3288 platforms with MPEG-2, VP8 and
> > H264 streams, decoding to YUY2 surfaces. For now, this series
> > is only adding support for NV12-to-YUY2 conversion.
> >
> > Applies to media/master.
> >
> > Future plans
> > ------------
> >
> > It seems to me that we should start moving this driver to use
> > regmap-based access to registers. However, such move is out of scope
> > and not entirely related to this post-processor enablement.
> >
> > We'll work on that as follow-up patches.
> >
> > Changelog
> > ---------
> >
> > Changes v3:
> >
> > * After discussing with Hans and Tomasz during the media summit
> > in ELCE, we decided to go back on the MC changes. The MC topology
> > is now untouched. This means the series is now similar to v1,
> > except we explicitly use the ENUM_FMT to hint about the post-processed
> > formats.
> >
> > Changes v2:
> >
> > * The decoder->post-processor topology is now exposed
> >   explicitly and applications need to configure the pipeline.
> >   By default, the decoder is enabled and the post-processor
> >   is disabled.
> >
> > * RGB post-processing output has been dropped. We might
> >   add this in the future, but for now, it seems it would
> >   make the code more complex without a use-case in mind.
> >   RGB is much more memory-consuming so less attractive
> >   than YUV, and modern GPUs and display controllers support YUV.
> >
> > * The post-processor implementation still supports RK3288
> >   only. However, a generic register infrastructure is introduced
> >   to make addition of other variants such as RK3399 really easy.
> >
> > Ezequiel Garcia (3):
> >   media: hantro: Cleanup format negotiation helpers
> >   media: hantro: Support color conversion via post-processing
> >   media: vidioc-enum-fmt.rst: clarify format preference
> >
> >  .../media/uapi/v4l/vidioc-enum-fmt.rst        |   4 +-
> >  drivers/staging/media/hantro/Makefile         |   1 +
> >  drivers/staging/media/hantro/hantro.h         |  64 +++++++-
> >  drivers/staging/media/hantro/hantro_drv.c     |   8 +-
> >  .../staging/media/hantro/hantro_g1_h264_dec.c |   2 +-
> >  .../media/hantro/hantro_g1_mpeg2_dec.c        |   2 +-
> >  drivers/staging/media/hantro/hantro_g1_regs.h |  53 +++++++
> >  .../staging/media/hantro/hantro_g1_vp8_dec.c  |   2 +-
> >  drivers/staging/media/hantro/hantro_h264.c    |   6 +-
> >  drivers/staging/media/hantro/hantro_hw.h      |  13 ++
> >  .../staging/media/hantro/hantro_postproc.c    | 141 ++++++++++++++++++
> >  drivers/staging/media/hantro/hantro_v4l2.c    | 105 ++++++++-----
> >  drivers/staging/media/hantro/rk3288_vpu_hw.c  |  10 ++
> >  13 files changed, 366 insertions(+), 45 deletions(-)
> >  create mode 100644 drivers/staging/media/hantro/hantro_postproc.c
> >
>
