Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0177C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3CF2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="krWaNh6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgFVNKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgFVNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:10:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7012C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:10:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 97so12989942otg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+fxtByV8XJfBDQUCtfrNN7N2L9LcG9m+MouCilHhEg=;
        b=krWaNh6mktbYPiJFXjhvO2GGm/lh3IAexn5C5zlaHNYtpbtuX6nEX3dHxttasrcEBQ
         r2Ke+i7ksGb0Zg3OHvJLCRpJCmj5t2cPKaC6n/Bu7vNWbIwo7oyAMpXdzNjOz75YkXz9
         FKnRmUSO+pL/YuFF4vDZJ4m0WKsQyvSwGoT0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+fxtByV8XJfBDQUCtfrNN7N2L9LcG9m+MouCilHhEg=;
        b=E4+D7AdXG8Cr8w1Jr0LYilNn69I6tD4zle0RRCirYxzHJcygn/o4DUjX0EkO7XiQHq
         eFiDHAU4ma/lzQDHgmyw3AMubxpAZ6b0myPje/2S++pD4jjNILwDmqgqbwkycY4CAd4i
         Eu/08psPmAZRfI6jszghSQ3lyX3z70P15TK8CfvItOa2yyw0iZT6I4HFQy0/L+4oQoTR
         +KoCpgoe4uPlo7Iya0H93lht0eKMraFWBucA3sKweTz4BpZMo04B4tcSmyxn+qWFW0Na
         CCPISJHu1xqvfoU1eLZwuOLodinCuep8k1XysqGpM3gu46nwJ+yZX0zGPMGoFXKvICeP
         k4Yg==
X-Gm-Message-State: AOAM53234jAWAWWJ6gwfgLTeDzdO6eU5Cs5Xn2hjRCn6B86mUscl3c+B
        yAVoC+FG2THkep0uf9R2aZH5yEdlNsQ=
X-Google-Smtp-Source: ABdhPJyjusKa9MNNUvgVPN1Brt+5rS5MpDfHDvGY2ZjIvRhWpfbzMm4RN0SawC1O1JKd17C8J/Dg6g==
X-Received: by 2002:a05:6830:2045:: with SMTP id f5mr14747631otp.130.1592831415035;
        Mon, 22 Jun 2020 06:10:15 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id t8sm3354588oor.42.2020.06.22.06.10.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:10:14 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id k36so1079688ooi.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:10:13 -0700 (PDT)
X-Received: by 2002:a4a:3e48:: with SMTP id t69mr1635161oot.38.1592831412617;
 Mon, 22 Jun 2020 06:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200520082723.96136-1-acourbot@chromium.org> <20200520082723.96136-8-acourbot@chromium.org>
 <1592549952.23952.3.camel@mtksdaap41>
In-Reply-To: <1592549952.23952.3.camel@mtksdaap41>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Jun 2020 22:10:00 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUiGtbBhfEoCVeTkQe1XrDea7wRUkybxtqQEThtQmJTwQ@mail.gmail.com>
Message-ID: <CAPBb6MUiGtbBhfEoCVeTkQe1XrDea7wRUkybxtqQEThtQmJTwQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] media: mtk-vcodec: venc: remove redundant code
To:     Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 3:59 PM Tiffany Lin <tiffany.lin@mediatek.com> wrote:
>
> On Wed, 2020-05-20 at 17:27 +0900, Alexandre Courbot wrote:
> > vidioc_try_fmt() does clamp height and width when called on the OUTPUT
> > queue, so clamping them prior to calling this function is redundant. Set
> > the queue's parameters after calling vidioc_try_fmt() so we can use the
> > values it computed.
> >
>
> vidioc_try_fmt clamps height and width only when f->type ==
> V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
>
> Does this cleanup pass v4l2 compliance test?

It doesn't result in more tests failing at least. :) But although I
cannot test with a pristine upstream version, it seems like some tests
are not passing to begin with. If you have different results with a
true upstream I would like to hear about it. Otherwise I am willing to
help with getting all the tests in the green.

Regarding this particular patch, you are right that we may end up
writing an unclamped size in q_data. It's probably better to drop it
for now.

> I recall compliance test will try different fmt and make sure driver
> response enough information?
>
>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  .../media/platform/mtk-vcodec/mtk_vcodec_enc.c   | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > index 05743a745a11..f0af78f112db 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > @@ -449,7 +449,6 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
> >       struct mtk_q_data *q_data;
> >       int ret, i;
> >       const struct mtk_video_fmt *fmt;
> > -     struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
> >
> >       vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
> >       if (!vq) {
> > @@ -474,20 +473,13 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
> >               f->fmt.pix.pixelformat = fmt->fourcc;
> >       }
> >
> > -     pix_fmt_mp->height = clamp(pix_fmt_mp->height,
> > -                             MTK_VENC_MIN_H,
> > -                             MTK_VENC_MAX_H);
> > -     pix_fmt_mp->width = clamp(pix_fmt_mp->width,
> > -                             MTK_VENC_MIN_W,
> > -                             MTK_VENC_MAX_W);
> > -
> > -     q_data->visible_width = f->fmt.pix_mp.width;
> > -     q_data->visible_height = f->fmt.pix_mp.height;
> > -     q_data->fmt = fmt;
> > -     ret = vidioc_try_fmt(f, q_data->fmt);
> > +     ret = vidioc_try_fmt(f, fmt);
> >       if (ret)
> >               return ret;
> >
> > +     q_data->fmt = fmt;
> > +     q_data->visible_width = f->fmt.pix_mp.width;
> > +     q_data->visible_height = f->fmt.pix_mp.height;
> >       q_data->coded_width = f->fmt.pix_mp.width;
> >       q_data->coded_height = f->fmt.pix_mp.height;
> >
>
