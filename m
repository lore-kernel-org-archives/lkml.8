Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C195DC4345B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F45E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hPNIvNvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgG0JHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgG0JHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:01 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6BC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:07:00 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id t6so3016361ooh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYKgToXHXhx0gJz2aTB9SU//eyR38G50GGbzq2n5Ipw=;
        b=hPNIvNvpFOTTuiyz1gtUwXItKh0lDha0D8yxF72PrmXRN/3g7ABWPSATcOBc0/4qQ+
         Oi/jJNcK71J61tBAoBRZSwlh2A8FEOKUZc+dPww7gaiKNe6LU+hwXFjbVFcVKeuGUK+n
         qNlAEZxVzu9wK21hZVA2GI93Vf63+n9BtOuwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYKgToXHXhx0gJz2aTB9SU//eyR38G50GGbzq2n5Ipw=;
        b=Wx2+3GpjNwws7J8tDtXOJB4ptnAYj5GIK13wJ9p+HU45TXC04bcbdjPwG+m4Av5os6
         YRddVjeTNGgg7sHvvjYufj2ClFCQDbot11pGe8ss0XZ+nXzZt2/Ik9rBM2Gp4bCDgxjX
         g6j1IDk8LTtZpwrXCcGgkof8aLKNjQ39buEhjLe1ylPfJI9PyYIZUFp4uoWb2ro9t3SJ
         zJClZ4eeJTqU+asHByVFiGtorJgxS6WX6b0KSZs32cqkT1LwWXg8IlU8wo77MEUfUgcp
         tT04gnDde+uwABAkVSePXa456sqh28NFb0av6s2GJG0ttOMojRXmmqTvE1tl6+a/J31G
         ne+Q==
X-Gm-Message-State: AOAM530xLsmggzpjkWokU2NwSeixuZpt4Ua28snmLfrhjiCNSYaSMsWt
        m0o7Mu90OiNAMRJdQogK4BcUZ3FlhPk=
X-Google-Smtp-Source: ABdhPJzHA5y/zxzGyK+HZHpJulILTUnESIidR2QYBCHP05sGB3wuOCWo/oC2gnszrcUBMou4EO6H4w==
X-Received: by 2002:a4a:947:: with SMTP id 68mr18305482ooa.47.1595840819061;
        Mon, 27 Jul 2020 02:06:59 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id z2sm3236670otq.17.2020.07.27.02.06.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 02:06:57 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id r21so1264727ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:06:56 -0700 (PDT)
X-Received: by 2002:a9d:5609:: with SMTP id e9mr18648943oti.141.1595840815529;
 Mon, 27 Jul 2020 02:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200713060842.471356-1-acourbot@chromium.org>
 <20200713060842.471356-8-acourbot@chromium.org> <CAAEAJfA4Po9R25CzBxiFAV=7-7rPujLc79zLnXyXWk7xNbBtYA@mail.gmail.com>
In-Reply-To: <CAAEAJfA4Po9R25CzBxiFAV=7-7rPujLc79zLnXyXWk7xNbBtYA@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Jul 2020 18:06:42 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUsSzrZAZdeH+at+9pf5sVa0ghE982ktnPW8rB91pYt6Q@mail.gmail.com>
Message-ID: <CAPBb6MUsSzrZAZdeH+at+9pf5sVa0ghE982ktnPW8rB91pYt6Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] media: mtk-vcodec: venc: specify supported
 formats per-chip
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:29 PM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Hi Alexandre,
>
> Last review on my side, this series looks mostly good.

Thanks for taking the time to look at it! I know it's not the best
looking code out there. ^_^;

>
> On Mon, 13 Jul 2020 at 03:09, Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > Different chips have different supported bitrate ranges. Move the list
>
> s/bitrate ranges/formats

Ack.

>
> > of supported formats to the platform data, and split the output and
> > capture formats into two lists to make it easier to find the default
> > format for each queue.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> > ---
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |   8 ++
> >  .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 122 +++++++-----------
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  40 ++++++
> >  3 files changed, 95 insertions(+), 75 deletions(-)
> >
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > index b8f913de8d80..59b4b750666b 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > @@ -313,6 +313,10 @@ enum mtk_chip {
> >   * @has_lt_irq: whether the encoder uses the LT irq
> >   * @min_birate: minimum supported encoding bitrate
> >   * @max_bitrate: maximum supported encoding bitrate
> > + * @capture_formats: array of supported capture formats
> > + * @num_capture_formats: number of entries in capture_formats
> > + * @output_formats: array of supported output formats
> > + * @num_output_formats: number of entries in output_formats
> >   */
> >  struct mtk_vcodec_enc_pdata {
> >         enum mtk_chip chip;
> > @@ -321,6 +325,10 @@ struct mtk_vcodec_enc_pdata {
> >         bool has_lt_irq;
> >         unsigned long min_bitrate;
> >         unsigned long max_bitrate;
> > +       const struct mtk_video_fmt *capture_formats;
> > +       size_t num_capture_formats;
> > +       const struct mtk_video_fmt *output_formats;
> > +       size_t num_output_formats;
> >  };
> >
> >  /**
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > index 50ba9da59153..05743a745a11 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > @@ -23,47 +23,9 @@
> >  #define DFT_CFG_WIDTH  MTK_VENC_MIN_W
> >  #define DFT_CFG_HEIGHT MTK_VENC_MIN_H
> >  #define MTK_MAX_CTRLS_HINT     20
> > -#define OUT_FMT_IDX            0
> > -#define CAP_FMT_IDX            4
> > -
> >
> >  static void mtk_venc_worker(struct work_struct *work);
> >
> > -static const struct mtk_video_fmt mtk_video_formats[] = {
> > -       {
> > -               .fourcc = V4L2_PIX_FMT_NV12M,
> > -               .type = MTK_FMT_FRAME,
> > -               .num_planes = 2,
>
> Again, not an issue with your patch, so feel free to ignore this.
>
> You may avoid keeping track of num_planes (or any other
> property of the pixel format) and use v4l2_fill_pixfmt_mp
> to get all the information you need.

That's a good idea. Let's see if I can come with an extra patch in a
way that does not prevent the already acked patches from being merged.
:)
