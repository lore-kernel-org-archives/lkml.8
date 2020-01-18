Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6AC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454CC24699
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="igvr2dE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgARNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:31:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46685 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgARNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:31:27 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so12728181qtr.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5YxsjwffX9TUC1iOdqN5ynD4NWa9IcR8dkHqJbAF8kc=;
        b=igvr2dE4tFGDDSG9IfuJJTa+LQ6gBHOYZVtwcTa1EVk2pXDWghwaMukEFiuBAsiJxC
         awiw39lFSOUZugA6CZd72hN2o1zIYLC6BP2HqZeB0WvUgnIbqvZjVPDc5lRUPxFR0N9o
         1R9SczDarkvhm5iC0ZJu4CN1nCCrDClmOmzr8+4oNVX8V8KM0h1PVVeDVl0n1lZ0yqJP
         GRqCHLHhufl3/HN2f38fJ+f5dAOxoctwm7/E5cMuAwb9k2dOGLdNhtBPr59UvvHtGtVf
         lRV+lxcSBNf4Sp85dAT04HnH8At+8I7m1Bihm0R0aq6esLfZhlBnI2hQwfoEdsk66OQa
         wBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5YxsjwffX9TUC1iOdqN5ynD4NWa9IcR8dkHqJbAF8kc=;
        b=fYtiQ81dQHdxvXPCTGBU9U/bcjRaYJ7RsmF/hoAqcpyU0TFo1DiCf3khvnunnNwJOU
         kMLd1reDfCk1boWuTCJWNd+9fPDEJfE45O29W46pASbiBoOcUEXPxvrJElCbDitMPXmO
         RKKBizgtujFtqLDZpV5Y9pj4IJG2UyRSbODJum0n/G4QafKZ5AgJ7pDHJ//zFT9DdCWk
         rmn8+2i1oSU5LAXp8o2NddGIZCIc1HvsHttnKcEh3D2arqrSs/Vm4WXMnOZ8WSNJUDIg
         pXc5vNRerJGWSTi15RoQiBmk2SQW543vRPXZ2Qkns6nMVeEJK/JYTDP+5p1mezmPuQYl
         N5tg==
X-Gm-Message-State: APjAAAUM/77fN8kaqUYtnI0E5BzFH7uWhq+f/yDFhV6Dqy//7K2qBcEl
        kvsIxAvarw7iRAUaWKawseATwg==
X-Google-Smtp-Source: APXvYqyvWy2BCgLFuugmUzP2XR9m0gX8NeEj+EG8BQTvuGNbWU/DVrIHfL8tymbnGFBbc6yADiKuiQ==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr12324308qte.327.1579354285798;
        Sat, 18 Jan 2020 05:31:25 -0800 (PST)
Received: from nicolas-tpx395 ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id e3sm14434223qtj.30.2020.01.18.05.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 05:31:25 -0800 (PST)
Message-ID: <8b10414a1c198a6e3bd5e131a72bd6f68466bea5.camel@ndufresne.ca>
Subject: Re: [PATCH] media: hantro: Support H264 profile control
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Cc:     Hirokazu Honda <hiroh@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 18 Jan 2020 08:31:22 -0500
In-Reply-To: <c88b2822-0dd2-8ea3-eb0b-262df5a30830@xs4all.nl>
References: <20191122051608.128717-1-hiroh@chromium.org>
         <767528be59275265072896e5c679e97575615fdd.camel@ndufresne.ca>
         <CAAFQd5D3OpAAtX7_0ktz4-aAgWN_G4YBQMR=Vwp7JPopjvRkRA@mail.gmail.com>
         <f5341ed837529bd38d466d4b655e261d64065912.camel@ndufresne.ca>
         <CAAFQd5Cpk8qG+VgE6+aznBmXu11YG0gNQyCRanZghds-TPKvyg@mail.gmail.com>
         <c88b2822-0dd2-8ea3-eb0b-262df5a30830@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 10 janvier 2020 à 13:31 +0100, Hans Verkuil a écrit :
> On 11/29/19 1:16 AM, Tomasz Figa wrote:
> > On Sat, Nov 23, 2019 at 1:52 AM Nicolas Dufresne <nicolas@ndufresne.ca>
> > wrote:
> > > Le samedi 23 novembre 2019 à 01:00 +0900, Tomasz Figa a écrit :
> > > > On Sat, Nov 23, 2019 at 12:09 AM Nicolas Dufresne <nicolas@ndufresne.ca>
> > > > wrote:
> > > > > Le vendredi 22 novembre 2019 à 14:16 +0900, Hirokazu Honda a écrit :
> > > > > > The Hantro G1 decoder supports H.264 profiles from Baseline to High,
> > > > > > with
> > > > > > the exception of the Extended profile.
> > > > > > 
> > > > > > Expose the V4L2_CID_MPEG_VIDEO_H264_PROFILE control, so that the
> > > > > > applications can query the driver for the list of supported
> > > > > > profiles.
> > > > > 
> > > > > Thanks for this patch. Do you think we could also add the LEVEL
> > > > > control
> > > > > so the profile/level enumeration becomes complete ?
> > > > > 
> > > > > I'm thinking it would be nice if the v4l2 compliance test make sure
> > > > > that codecs do implement these controls (both stateful and stateless),
> > > > > it's essential for stack with software fallback, or multiple capable
> > > > > codec hardware but with different capabilities.
> > > > > 
> > > > 
> > > > Level is a difficult story, because it also specifies the number of
> > > > macroblocks per second, but for decoders like this the number of
> > > > macroblocks per second it can handle depends on things the driver
> > > > might be not aware of - clock frequencies, DDR throughput, system
> > > > load, etc.
> > > > 
> > > > My take on this is that the decoder driver should advertise the
> > > > highest resolution the decoder can handle due to hardware constraints.
> > > > Performance related things depend on the integration details and
> > > > should be managed elsewhere. For example Android and Chrome OS manage
> > > > expected decoding performance in per-board configuration files.
> > > 
> > > When you read datasheet, the HW is always rated to maximum level (and
> > > it's a range) with the assumption of a single stream. It seems much
> > > easier to expose this as-is, statically then to start doing some math
> > > with data that isn't fully exposed to the user. This is about filtering
> > > of multiple CODEC instances, it does not need to be rocket science,
> > > specially that the amount of missing data is important (e.g. usage of
> > > tiles, compression, IPP all have an impact on the final performance).
> > > All we want to know in userspace is if this HW is even possibly capable
> > > of LEVEL X, and if not, we'll look for another one.
> > > 
> > 
> > Agreed, one could potentially define it this way, but would it be
> > really useful for the userspace and the users? I guess it could enable
> > slightly faster fallback to software decoding in the extreme case of
> > the hardware not supporting the level at all, but I suspect that the
> > majority of cases would be the hardware just being unusably slow.
> > 
> > Also, as I mentioned before, we already return the range of supported
> > resolutions, which in practice should map to the part of the level
> > that may depend on hardware capabilities rather than performance, so
> > exposing levels as well would add redundancy to the information
> > exposed.
> 
> There is a lot of discussion here, but it all revolves around a potential
> LEVEL control.
> 
> So I gather everyone is OK with merging this patch?

I'm ok with this. For me, the level reflects the real time performance
capability as define in the spec, while the width/height constraints usually
represent an addressing capabicity, which may or may not operate real-time.

> 
> If not, let me know asap.
> 
> Regards,
> 
> 	Hans
> 
> > > > > > Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> > > > > > ---
> > > > > >  drivers/staging/media/hantro/hantro_drv.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/staging/media/hantro/hantro_drv.c
> > > > > > b/drivers/staging/media/hantro/hantro_drv.c
> > > > > > index 6d9d41170832..9387619235d8 100644
> > > > > > --- a/drivers/staging/media/hantro/hantro_drv.c
> > > > > > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > > > > > @@ -355,6 +355,16 @@ static const struct hantro_ctrl controls[] = {
> > > > > >                       .def =
> > > > > > V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
> > > > > >                       .max =
> > > > > > V4L2_MPEG_VIDEO_H264_START_CODE_ANNEX_B,
> > > > > >               },
> > > > > > +     }, {
> > > > > > +             .codec = HANTRO_H264_DECODER,
> > > > > > +             .cfg = {
> > > > > > +                     .id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> > > > > > +                     .min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
> > > > > > +                     .max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
> > > > > > +                     .menu_skip_mask =
> > > > > > +                     BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
> > > > > > +                     .def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
> > > > > > +             }
> > > > > >       }, {
> > > > > >       },
> > > > > >  };

