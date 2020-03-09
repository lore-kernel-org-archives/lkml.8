Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C81BC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526282051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f3VVqLpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCILMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:12:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36384 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgCILMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:12:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id a13so11553165edh.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QpS5itn0u26AAxu+mVL7gUK3pzWKtpjp1N+DGFNKDfw=;
        b=f3VVqLpGO18yT42U5ykshy+AydIKUGfJKNSRK8ER0EiONaoAcUVvHWbdT4dcW0PtEL
         YUelyc+dCnFIAS+nJlPV4nO7yJHR2RO5P08nF9q+0Ijl5wUYwER4khHTRAtSJQezlwcI
         DYkbwF3p9Z5YSRzhRzyqcUL80e3oSvMKg+rn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QpS5itn0u26AAxu+mVL7gUK3pzWKtpjp1N+DGFNKDfw=;
        b=jDOINrDObulYfOnX0XG6XA6FKt41D1pxHFtq8yG0s+FKC6dHvps5NmKneUo5NDSlN4
         s7VMJKd2+PXIZoWl6tEet89DUsuRLEe9b2HQLnx9QQtsg/8YtMERhDCftGq1aP6RVDv3
         md3BhUa8roTNaOCwdahWuZ6zuQ37hDB5b6gzzlKjM+Dn/Weh6iLIOMCnMcYwaH3fting
         oXU0M5mzYeeIOsad2CLKTtebdTC1htlgJNY8JhteAcgzkFprllUTs87phVvqjr5KoIN2
         mbVMQmXxPY65Ofsyga3LRU8WF4r4yrCKdsdOqcm9eGAjj3HUlG+kOGOmK1QCZGOcNdH2
         zf4Q==
X-Gm-Message-State: ANhLgQ2EgqvCiIROAaLowpzJG1XNthN3iIreI6rom1vlxHQzDC/wHHLO
        PjPdAupZMrf0RkUuYjkndw0DFIHHMk017Q==
X-Google-Smtp-Source: ADFU+vvkahOT8SDuDoRWnW0oDiwP8Ml8GlYipHp7p81q0diVbb+ETu5UzjTZ7zVjTY1LkzAr2uIKhg==
X-Received: by 2002:a17:906:e094:: with SMTP id gh20mr14417700ejb.230.1583752320391;
        Mon, 09 Mar 2020 04:12:00 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id y4sm2177422ejm.77.2020.03.09.04.11.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 04:11:59 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id t11so10527233wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:11:59 -0700 (PDT)
X-Received: by 2002:adf:f545:: with SMTP id j5mr10560181wrp.295.1583752318515;
 Mon, 09 Mar 2020 04:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191113175603.24742-1-ezequiel@collabora.com>
 <74fea061a52ee3f8e25793bf9e47eba90a52c3e3.camel@ndufresne.ca>
 <CAAFQd5A8Y3C64NozqXjMDV0CQ5==dW9Y-6KtFigYFmO3EDd3+A@mail.gmail.com>
 <f3b8c40fa84f9819959bf60cc9a1f4951bcda36a.camel@ndufresne.ca>
 <9655c8b0cf58c93e26159503120f37890731f313.camel@ndufresne.ca>
 <CAAFQd5Dh0SxrXjF2co16OYR_u_EekQ+0cad=waXOzWVFsv91mQ@mail.gmail.com> <f93e810f32136e7667c3c413e43f6cebda084fec.camel@ndufresne.ca>
In-Reply-To: <f93e810f32136e7667c3c413e43f6cebda084fec.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 9 Mar 2020 20:11:46 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BaZXUTCvd8hbGtiEBmnS9C1gYD=4ojB=VLPCmWULHLUw@mail.gmail.com>
Message-ID: <CAAFQd5BaZXUTCvd8hbGtiEBmnS9C1gYD=4ojB=VLPCmWULHLUw@mail.gmail.com>
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

On Thu, Feb 20, 2020 at 6:06 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> On mer, 2020-02-12 at 16:06 +0900, Tomasz Figa wrote:
> > On Wed, Feb 12, 2020 at 1:22 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > On lun, 2020-02-10 at 23:16 -0500, Nicolas Dufresne wrote:
> > > > Le lundi 10 f=C3=A9vrier 2020 =C3=A0 11:45 +0900, Tomasz Figa a =C3=
=A9crit :
> > > > > On Mon, Feb 10, 2020 at 4:52 AM Nicolas Dufresne <nicolas@ndufres=
ne.ca>
> > > > > wrote:
> > > > > > Le mercredi 13 novembre 2019 =C3=A0 14:56 -0300, Ezequiel Garci=
a a =C3=A9crit :
> > > > > > > Hi all,
> > > > > > >
> > > > > > > The Hantro G1 VPU post-processor block can be pipelined with
> > > > > > > the decoder hardware, allowing to perform operations such as
> > > > > > > color conversion, scaling, rotation, cropping, among others.
> > > > > > >
> > > > > > > When the post-processor is enabled, the decoder hardware
> > > > > > > needs its own set of NV12 buffers (the native decoder format)=
,
> > > > > > > and the post-processor is the owner of the CAPTURE buffers,
> > > > > > > allocated for the post-processed format.
> > > > > > >
> > > > > > > This way, applications obtain post-processed
> > > > > > > (scaled, converted, etc) buffers transparently.
> > > > > > >
> > > > > > > This feature is implemented by exposing the post-processed pi=
xel
> > > > > > > formats on ENUM_FMT, ordered as "preferred pixelformat first"=
:
> > > > > > >
> > > > > > > v4l2-ctl -d 1 --list-formats
> > > > > > > ioctl: VIDIOC_ENUM_FMT
> > > > > > >       Type: Video Capture Multiplanar
> > > > > > >
> > > > > > >       [0]: 'NV12' (Y/CbCr 4:2:0)
> > > > > > >       [1]: 'YUYV' (YUYV 4:2:2)
> > > > > > >
> > > > > > > The order of preference in ENUM_FMT can be used as a hint
> > > > > > > by applications. This series updates the uAPI specification
> > > > > > > accordingly.
> > > > > >
> > > > > > As I'm implementing this, I realize that there may me a gap in =
being
> > > > > > able to implement both IPP and non-IPP support in a generic fra=
mework.
> > > > > > Unlike the above comment, we for non-IPP decoder we cannot naiv=
ely
> > > > > > pick
> > > > > > the first format. In fact we parse the chroma and depth informa=
tion
> > > > > > from the headers (like pps from H264), and we pick a matching p=
ixel
> > > > > > format. This way, if we have a 10bit stream, and our IP support=
s
> > > > > > 10bit,
> > > > > > we will pick a 10bit pixel formats, otherwise decoding will jus=
t fail.
> > > > > >
> > > > > > None of this information is passed to the driver prior to the f=
irst
> > > > > > Request being made, so there is no way (as of current spec) tha=
t the
> > > > > > driver can validate this in try_fmt ahead of time. Unless I set
> > > > > > picture
> > > > > > parameters without a request_fd for that purpose. If this is th=
e way,
> > > > > > then we should document this.
> > > > >
> > > > > +Alexandre Courbot
> > > > >
> > > > > It was suggested in the very early RFC stage, but it looks like i=
t
> > > > > didn't make it to the final spec.
> > > > > https://patchwork.kernel.org/patch/10583233/#22209555
> > > >
> > > > Ok, maybe we should revive it, it would fill that gap. Again, only =
an
> > > > issue if you have a post processor. I'm still surprised we didn't
> > > > expose the IPP functions through the topology, it would make so muc=
h
> > > > sense to me, and I can make better code with that knowledge.
> > > >
> > > > I found while coding this, that even if it's more difficult,
> > > > classification of device by looking at the topology and the entity
> > > > functions is much nicer, less of a guess.
> > > >
> > > > Though, we lack some documentation (or clarification) for how to
> > > > properly handle formats, size and selection in order to configure t=
he
> > > > IPP. Ezequiel was saying that we don't implement selection in Hanto=
, so
> > > > I guess the scaling is a bit ambiguous then in regard to coded/disp=
lay
> > > > sizes. Though we pass a size to the OUTPUT side, so the driver can
> > > > always control a little bit.
> > >
> > > Re-reading the "initialization process", it's actually still there:
> > >
> > > "Call VIDIOC_S_EXT_CTRLS() to set all the controls (parsed headers, e=
tc.)
> > > required by the OUTPUT format to enumerate the CAPTURE formats."
> > >
> >
> > Oh, so it did make it to the final spec. Sorry, my bad. Should have
> > checked better.
> >
> > > And then it suggest to use G_FMT to retreive the optimal format as se=
lected
> > > by
> > > the driver. So I guess this is a false alarm. And we probably don't n=
eed to
> > > play
> > > with the subsampling to filter the formats, as the driver is expected=
 to do
> > > so.
> > >
> >
> > The question that this raises then is whether the merged drivers do
> > so. Hantro G1 supports only 8-bit YUV 4:2:0, so there is no problem,
> > although the driver doesn't seem to validate that in the headers. I'd
> > also say the CAPTURE resolution should be determined by the headers,
> > rather than the OUTPUT queue, consistently to the stateful decoders.
> > Resolution changes should be also signaled if controls are set to
> > headers that contain different resolutions than previously set.
> >
> > > So what could be improve, is have in the per-codec documentation the =
list of
> > > controls that are "required by the OUTPUT format to enumerate the CAP=
TURE
> > > formats.". Could just be a comment in the control doc so say, "this c=
ontrol
> > > is
> > > needed to allow enumerationg of the CAPTURE formats".
> > >
> >
> > I wouldn't limit this to the format enumeration. The drivers may also
> > need to check for things like profile, some stream features or even
> > just whether the resolution doesn't exceed the maximum supported by
> > the decoder.
>
> Yes, I came to similar conclusion. As an example, an H264 should validate=
 the
> SPS (and I think for H264 that is sufficient ?) based on it's hardware sp=
ecific
> constraint. Using the SPS for format and size numeration is also what mak=
es the
> most sense when there is an IPP. An IPP could support crop, and the drive=
r could
> select the default cropping to matcht the display resolution. Driver shou=
ld be
> enhanced, but it seems to be part of normal refine.
>
> To come back to the spec, shall we document a return value for the case w=
here
> the control is supported, but the stream isn't supported ?
>

I think the answer is yes. :) I'll leave the details to others, though.

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> > > > > > Is this the intended way to negotiation IPP functions with the =
driver
> > > > > > ?
> > > > > >
> > > > >
> > > > > In theory, if the userspace knows whether the stream is 4:2:0 or =
4:2:2
> > > > > and 8-bit or 10-bit, it can still select the first format from th=
e top
> > > > > that matches these properties.
> > > >
> > > > That's exactly what I do, I have a map of the formats and their
> > > > chroma/depth, and take the first one that match. If that fails, I j=
ust
> > > > fallback to the first one. It's something you need to do anyway, as=
 we
> > > > prefer the native format first (even if there is an IPP).
> > > >
> > > > > That's not how format handling in V4L2 works, though. ENUM_FMT is
> > > > > expected to return a list of valid formats and if we forget about=
 the
> > > > > image processor for a moment, a stateless decoder would always re=
turn
> > > > > any possible format, including ones invalid for the stream.
> > > > >
> > > > > Now back to the image processor, if it handles conversions from a=
ny to
> > > > > any format listed by ENUM_FMT, we kind of regain the V4L2 complia=
nce,
> > > > > but if the conversions are limited, the above requirement still
> > > > > doesn't hold and we're not implementing V4L2 correctly.
> > > > >
> > > > > Perhaps we can still amend the spec and require controls that
> > > > > determine the stream properties to be set before starting the
> > > > > streaming? I can imagine it could also help the driver filter out=
 some
> > > > > unsupported streams early, before allocating buffers and attempti=
ng to
> > > > > decode.
> > > >
> > > > I think it would make sense, so just to make sure, for H264 we coul=
d
> > > > set the V4L2_CID_MPEG_VIDEO_H264_SPS along with the OUTPUT format,
> > > > prior to CAPTURE enumeration.
> > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > > > > When the application sets a pixel format other than NV12,
> > > > > > > the post-processor is transparently enabled.
> > > > > > >
> > > > > > > Patch 1 is a cleanups needed to easier integrate the post-pro=
cessor.
> > > > > > > Patch 2 introduces the post-processing support.
> > > > > > > Patch 3 updates the uAPI specification.
> > > > > > >
> > > > > > > This is tested on RK3288 platforms with MPEG-2, VP8 and
> > > > > > > H264 streams, decoding to YUY2 surfaces. For now, this series
> > > > > > > is only adding support for NV12-to-YUY2 conversion.
> > > > > > >
> > > > > > > Applies to media/master.
> > > > > > >
> > > > > > > Future plans
> > > > > > > ------------
> > > > > > >
> > > > > > > It seems to me that we should start moving this driver to use
> > > > > > > regmap-based access to registers. However, such move is out o=
f scope
> > > > > > > and not entirely related to this post-processor enablement.
> > > > > > >
> > > > > > > We'll work on that as follow-up patches.
> > > > > > >
> > > > > > > Changelog
> > > > > > > ---------
> > > > > > >
> > > > > > > Changes v3:
> > > > > > >
> > > > > > > * After discussing with Hans and Tomasz during the media summ=
it
> > > > > > > in ELCE, we decided to go back on the MC changes. The MC topo=
logy
> > > > > > > is now untouched. This means the series is now similar to v1,
> > > > > > > except we explicitly use the ENUM_FMT to hint about the post-
> > > > > > > processed
> > > > > > > formats.
> > > > > > >
> > > > > > > Changes v2:
> > > > > > >
> > > > > > > * The decoder->post-processor topology is now exposed
> > > > > > >   explicitly and applications need to configure the pipeline.
> > > > > > >   By default, the decoder is enabled and the post-processor
> > > > > > >   is disabled.
> > > > > > >
> > > > > > > * RGB post-processing output has been dropped. We might
> > > > > > >   add this in the future, but for now, it seems it would
> > > > > > >   make the code more complex without a use-case in mind.
> > > > > > >   RGB is much more memory-consuming so less attractive
> > > > > > >   than YUV, and modern GPUs and display controllers support Y=
UV.
> > > > > > >
> > > > > > > * The post-processor implementation still supports RK3288
> > > > > > >   only. However, a generic register infrastructure is introdu=
ced
> > > > > > >   to make addition of other variants such as RK3399 really ea=
sy.
> > > > > > >
> > > > > > > Ezequiel Garcia (3):
> > > > > > >   media: hantro: Cleanup format negotiation helpers
> > > > > > >   media: hantro: Support color conversion via post-processing
> > > > > > >   media: vidioc-enum-fmt.rst: clarify format preference
> > > > > > >
> > > > > > >  .../media/uapi/v4l/vidioc-enum-fmt.rst        |   4 +-
> > > > > > >  drivers/staging/media/hantro/Makefile         |   1 +
> > > > > > >  drivers/staging/media/hantro/hantro.h         |  64 +++++++-
> > > > > > >  drivers/staging/media/hantro/hantro_drv.c     |   8 +-
> > > > > > >  .../staging/media/hantro/hantro_g1_h264_dec.c |   2 +-
> > > > > > >  .../media/hantro/hantro_g1_mpeg2_dec.c        |   2 +-
> > > > > > >  drivers/staging/media/hantro/hantro_g1_regs.h |  53 +++++++
> > > > > > >  .../staging/media/hantro/hantro_g1_vp8_dec.c  |   2 +-
> > > > > > >  drivers/staging/media/hantro/hantro_h264.c    |   6 +-
> > > > > > >  drivers/staging/media/hantro/hantro_hw.h      |  13 ++
> > > > > > >  .../staging/media/hantro/hantro_postproc.c    | 141
> > > > > > > ++++++++++++++++++
> > > > > > >  drivers/staging/media/hantro/hantro_v4l2.c    | 105 ++++++++=
-----
> > > > > > >  drivers/staging/media/hantro/rk3288_vpu_hw.c  |  10 ++
> > > > > > >  13 files changed, 366 insertions(+), 45 deletions(-)
> > > > > > >  create mode 100644 drivers/staging/media/hantro/hantro_postp=
roc.c
> > > > > > >
>
