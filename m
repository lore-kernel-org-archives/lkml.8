Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85338C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DE620708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8NhgYa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHNHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:50:02 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D16BC061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:50:02 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id r21so6912938ota.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Fs3fI55T620G7RUHx4Z8MRHOXcmdrTyik5fDdnH7MY=;
        b=S8NhgYa/Q2mxawDJWveoTzRMUDtNptaMz+MKJVLmLoZbC2xtxQHZ4iCvlXFacHZdIn
         9B4qUGNKKNzICGjO9G6TJRx6Rgg2WyfWdcbFiTXrZT/dqOFOTPUMoFu2w9Wuxv7T3ics
         1AmC69wTcW7oGDAUoxYA7SHL3o39UgHOLEiWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Fs3fI55T620G7RUHx4Z8MRHOXcmdrTyik5fDdnH7MY=;
        b=OffwM+6YavSPLQPhZ/GaDehdE6TRzxYeQ0om+jNTgZvuBY+EJ39nPkaPhcUYV+1yfU
         wlF/nUo7KAKIeHR8JcjJict7ybid1k9uZ3dMR/okPsxf13gCrZ69tzzgstMyTXTwIxXn
         mzUTXGkDwQekl0yTAnnVNlXsAb4vXMpGmX2+C9hZ/a7BUbeeYAf2vZ6ltOH9eGi/HSm7
         8rE+0+B8TIr5QI1RW+8tEUTfqkA2zc0K010x4FKm8FOpGBG8RkPGPSqxAT/x1CzJ7lq6
         yj7iK6ThwWuPglx/XfGqVwAunfeEYKkomfsYpFkizbPuFCOb2oeEhGVNfI8B8NyL8FSa
         XtUg==
X-Gm-Message-State: AOAM53222VfJOMHelKotM91FnaVvul4tr8KOf9DpOsehpPK7319Nw3Fr
        oatf0P/5mDMf//ZPZajrjNCWKYqGbotiHA==
X-Google-Smtp-Source: ABdhPJxwg/FkabdL7SCOf3D7TajrXrKY7U66Yrq9MEVX5A6xmepgA5BFOfE6NjsYMotDx+giPb3Wvw==
X-Received: by 2002:a9d:a65:: with SMTP id 92mr1090946otg.282.1597391399809;
        Fri, 14 Aug 2020 00:49:59 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id 91sm1654915otn.18.2020.08.14.00.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 00:49:58 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id k12so6957508otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:49:58 -0700 (PDT)
X-Received: by 2002:a9d:170c:: with SMTP id i12mr1059302ota.36.1597391397791;
 Fri, 14 Aug 2020 00:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200804192939.2251988-1-helen.koike@collabora.com> <20200804192939.2251988-5-helen.koike@collabora.com>
In-Reply-To: <20200804192939.2251988-5-helen.koike@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 14 Aug 2020 16:49:46 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW4zbhfkrG0P8VA-xgMMt0Wt7+mo6SZRDekRKiS0Q1xhA@mail.gmail.com>
Message-ID: <CAPBb6MW4zbhfkrG0P8VA-xgMMt0Wt7+mo6SZRDekRKiS0Q1xhA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] media: mediabus: Add helpers to convert a ext_pix
 format to/from a mbus_fmt
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com,
        narmstrong@baylibre.com, LKML <linux-kernel@vger.kernel.org>,
        frkoenig@chromium.org, Maxime Jourdan <mjourdan@baylibre.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:32 AM Helen Koike <helen.koike@collabora.com> wrote:
>
> Just a new version of v4l2_fill_mbus_format() and v4l2_fill_ext_pix_format()
> to deal with the new v4l2_ext_pix_format struct.
> This is needed to convert the VIMC driver to the EXT_FMT/EXT_BUF iocts.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> Changes in v4:
> - Add helper v4l2_fill_ext_pix_format()
> - Rebased on top of media/master (post 5.8-rc1)
>
> Changes in v3:
> - Rebased on top of media/master (post 5.4-rc1)
>
> Changes in v2:
> - New patch
> ---
>  include/media/v4l2-mediabus.h | 42 +++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
> index 45f88f0248c4e..8133407377f7d 100644
> --- a/include/media/v4l2-mediabus.h
> +++ b/include/media/v4l2-mediabus.h
> @@ -119,6 +119,26 @@ v4l2_fill_pix_format(struct v4l2_pix_format *pix_fmt,
>         pix_fmt->xfer_func = mbus_fmt->xfer_func;
>  }
>
> +/**
> + * v4l2_fill_ext_pix_format - Ancillary routine that fills a &struct

I feel the names of these functions are maybe too generic - maybe they
should carry the fact that the source is a mbus or ext_pix format?


> + *     v4l2_ext_pix_format fields from a &struct v4l2_mbus_framefmt.
> + *
> + * @pix_fmt:   pointer to &struct v4l2_ext_pix_format to be filled
> + * @mbus_fmt:  pointer to &struct v4l2_mbus_framefmt to be used as model
> + */
> +static inline void
> +v4l2_fill_ext_pix_format(struct v4l2_ext_pix_format *pix_fmt,
> +                    const struct v4l2_mbus_framefmt *mbus_fmt)
> +{
> +       pix_fmt->width = mbus_fmt->width;
> +       pix_fmt->height = mbus_fmt->height;
> +       pix_fmt->field = mbus_fmt->field;
> +       pix_fmt->colorspace = mbus_fmt->colorspace;
> +       pix_fmt->ycbcr_enc = mbus_fmt->ycbcr_enc;
> +       pix_fmt->quantization = mbus_fmt->quantization;
> +       pix_fmt->xfer_func = mbus_fmt->xfer_func;
> +}
> +
>  /**
>   * v4l2_fill_pix_format - Ancillary routine that fills a &struct
>   *     v4l2_mbus_framefmt from a &struct v4l2_pix_format and a
> @@ -182,4 +202,26 @@ v4l2_fill_mbus_format_mplane(struct v4l2_mbus_framefmt *mbus_fmt,
>         mbus_fmt->xfer_func = pix_mp_fmt->xfer_func;
>  }
>
> +/**
> + * v4l2_fill_mbus_format_ext - Ancillary routine that fills a &struct
> + *     v4l2_mbus_framefmt from a &struct v4l2_ext_pix_format.
> + *
> + * @mbus_fmt:  pointer to &struct v4l2_mbus_framefmt to be filled
> + * @pix_fmt:   pointer to &struct v4l2_ext_pix_format to be used as model
> + * @code:      data format code (from &enum v4l2_mbus_pixelcode)
> + */
> +static inline void
> +v4l2_fill_mbus_format_ext(struct v4l2_mbus_framefmt *mbus_fmt,
> +                         const struct v4l2_ext_pix_format *pix_fmt, u32 code)
> +{
> +       mbus_fmt->width = pix_fmt->width;
> +       mbus_fmt->height = pix_fmt->height;
> +       mbus_fmt->field = pix_fmt->field;
> +       mbus_fmt->colorspace = pix_fmt->colorspace;
> +       mbus_fmt->ycbcr_enc = pix_fmt->ycbcr_enc;
> +       mbus_fmt->quantization = pix_fmt->quantization;
> +       mbus_fmt->xfer_func = pix_fmt->xfer_func;
> +       mbus_fmt->code = code;
> +}
> +
>  #endif
> --
> 2.28.0.rc2
>
