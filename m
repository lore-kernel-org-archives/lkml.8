Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7FAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C850206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F2JXAsYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgGZNew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 09:34:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E0C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 06:34:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 95so10386955otw.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8GYXiEv1VAJE5ju24W+SW1RqnGVVigc1mueXD+1VnI=;
        b=F2JXAsYGGtp08i9I6dJEi0Zgff2MdZtmpjw5ylNgbv0RHj2o9jg3fv9QUiFcTtZ++v
         yrxYC9Y7FQfa9uc6MI+c/IW2jrIY1wFEKbwyGtxaJ5CBNMrtgKownrhvakfoGvyGkwDa
         NbroDDw2tpNNO1yZddNcxIFXsMfg4HUFRm7mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8GYXiEv1VAJE5ju24W+SW1RqnGVVigc1mueXD+1VnI=;
        b=hxyfe47moXATJelXF1IXSaDPeLBKTaxcmLxkPl6ENIUn2j8nkeczSC3vKDIVls6jZS
         oDAAhEgTDyK7M3oEvPCnOW9drBOcojcrSOHgIAVx87IWuSYzPpTomVMh3Ah+jzulxH/e
         c3TlNfblR2FR/DLU6to0nBws5dInns+HR2OUCQSV8VJPBi0Lbim5rtbjYUdDGoNJhtBu
         ssGWLsSyq3GSKJW6zaOkWlHkBDpnnVdJdlF7lzyV3gJNzdBBuHrR5acJqDfHvKp7vWgp
         H/7Lf7DaEiQJvsGt1APIP5sSwt9r3EkU81MuPyjgU2QZ+PAsYQn0yD5vOuOPxsCnpKBO
         Qh9A==
X-Gm-Message-State: AOAM530ksWssxqOsNog0vWCuDsrD+u3cRIFj63CgXmINPPSgjwEN/kSz
        1TDYNQOyV6PwfTpAMYdTdR9+ZSpjlIY=
X-Google-Smtp-Source: ABdhPJx+0QIqggLqwm5Vyra5XxNgwgUjEt92ie+U69sDujW5lQg15DgAojygiTvkEEFFB21+zLTNhQ==
X-Received: by 2002:a9d:7f8d:: with SMTP id t13mr16790123otp.67.1595770490011;
        Sun, 26 Jul 2020 06:34:50 -0700 (PDT)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id d10sm1571839oia.18.2020.07.26.06.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 06:34:47 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id n21so1787621ooj.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 06:34:46 -0700 (PDT)
X-Received: by 2002:a05:6820:1015:: with SMTP id v21mr16808381oor.50.1595770486325;
 Sun, 26 Jul 2020 06:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com>
 <20200715202233.185680-10-ezequiel@collabora.com> <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
In-Reply-To: <CAPBb6MWG5aXuc7ExiaKvgtLL0o=HDYKFa4D4-v8hfvyGiNFBdA@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sun, 26 Jul 2020 22:34:32 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUz6q7GALpnB2caWkWdrE4D7rKC=BdhnD-0b91RQNJQ+g@mail.gmail.com>
Message-ID: <CAPBb6MUz6q7GALpnB2caWkWdrE4D7rKC=BdhnD-0b91RQNJQ+g@mail.gmail.com>
Subject: Re: [PATCH 09/10] media: hantro: Don't require unneeded H264_SLICE_PARAMS
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 11:45 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
>
> On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >
> > Now that slice invariant parameters have been moved,
> > the driver no longer needs this control, so drop it.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  drivers/staging/media/hantro/hantro_drv.c  | 5 -----
> >  drivers/staging/media/hantro/hantro_h264.c | 5 -----
> >  drivers/staging/media/hantro/hantro_hw.h   | 2 --
> >  3 files changed, 12 deletions(-)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
> > index 34797507f214..3cd00cc0a364 100644
> > --- a/drivers/staging/media/hantro/hantro_drv.c
> > +++ b/drivers/staging/media/hantro/hantro_drv.c
> > @@ -306,11 +306,6 @@ static const struct hantro_ctrl controls[] = {
> >                 .cfg = {
> >                         .id = V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS,
> >                 },
> > -       }, {
> > -               .codec = HANTRO_H264_DECODER,
> > -               .cfg = {
> > -                       .id = V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS,
> > -               },
>
> Isn't this going to make the driver reject (as opposed to just ignore)
> this control altogether? Also, even though the control is not required
> anymore, don't we want to check that it is provided in order to ensure
> user-space follows the spec (granted, this would be better done in a
> common framework shared by all drivers).

I kind of forgot about the previous discussion about frame-based vs
slice-based decoders, and since Hantro is frame-based this makes my
point above moot. Please ignore.

>
> I'd also suggest this patch (and the following one) to be merged into
> the previous one as they are just removing fields that have become
> unneeded because of it.
