Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37717C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F200120890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjBoxNli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGDMgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:36:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750FC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 05:36:31 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so15971993oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiMRaaF7xQe01D0K4G/ajZqNXBnr3GRE68W057m1m6g=;
        b=GjBoxNliBZ5RFYHjAFdw/X8vNki+bVFRUdP3EVTrVWqzBPUj3fwkJPSsDKd/JRXZuE
         Q49HuaNZose82NcMfwNnuIsIyMFvhhpyCkRJWVsKuEMVIdkE0Nn2qAucHoAxZQeceypF
         BS51mfiSCstCD8gn/mUuqCZi1EsXqpZLes6hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiMRaaF7xQe01D0K4G/ajZqNXBnr3GRE68W057m1m6g=;
        b=TnWTF7IPaonz/OOTI1e1RjIIbwkP0anCtR37HqAkztkNfXzvjw1GOxxB8iCK2xgLXy
         MHx8zjxum993EX//8hUPdN3+fPvp45LwcviINYelSbylcjrGwE3gxWZW/INNVRdBFQNy
         qgn7/4mC6H+QDHgwSce6MeZuRhhwBKQg4raYq3IKyQ2yq88jf+HEoQxpho8CIN0UR5te
         iJ7VFkYNIfjxngm7uUAGUQPrpXy/2QbFCLxvz6IYg0mI9QZcr/BKT7DauENq0Jfgl5yY
         R9F6i6XyiegQx7O3kXxFBZblCKsiqHkc9fMjAshmaTTP8kGgb3f214eFskw8XNxawTpR
         1GtA==
X-Gm-Message-State: AOAM530jdhl5oq8+5P6jmgYaVMYseJkXoaiWu+WE1Xgz0hXl7V2XB32D
        Seo6tW3Qg1Rju/YHuL8KEkhVkTSOHLA=
X-Google-Smtp-Source: ABdhPJyo2aHmXkxS2IVbGLiQ3wy+w+cfvvkxpAOEBvc4mA8d3dkl8WVR5Vo4HBqRiGYuy5XH1OAqZQ==
X-Received: by 2002:aca:c0d7:: with SMTP id q206mr16316762oif.21.1593866190328;
        Sat, 04 Jul 2020 05:36:30 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id w17sm4007095oia.16.2020.07.04.05.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 05:36:29 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 12so22076056oir.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 05:36:28 -0700 (PDT)
X-Received: by 2002:a05:6808:646:: with SMTP id z6mr28913132oih.71.1593866188277;
 Sat, 04 Jul 2020 05:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200626080442.292309-1-acourbot@chromium.org>
 <20200626080442.292309-17-acourbot@chromium.org> <84068e20-9a34-6d03-61e6-6c243680749c@xs4all.nl>
In-Reply-To: <84068e20-9a34-6d03-61e6-6c243680749c@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 4 Jul 2020 21:36:15 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW9deo11+YH9Mh3u08sEt7ShAF_a+S0-Jb_VDGhCQot_Q@mail.gmail.com>
Message-ID: <CAPBb6MW9deo11+YH9Mh3u08sEt7ShAF_a+S0-Jb_VDGhCQot_Q@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] media: mtk-vcodec: venc: make S_PARM return
 -ENOTTY for CAPTURE queue
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
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

On Fri, Jul 3, 2020 at 5:30 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 26/06/2020 10:04, Alexandre Courbot wrote:
> > v4l2-compliance expects ENOTTY to be returned when a given queue does
> > not support S_PARM.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > index aae610e6d4e8..346a33c6869d 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> > @@ -200,7 +200,7 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
> >       struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> >
> >       if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > -             return -EINVAL;
> > +             return -ENOTTY;
>
> This doesn't look right: S_PARM *is* supported, just not for this buffer type.
> So -EINVAL is the correct error code.
>
> What is the exact v4l2-compliance failure? It might be a bug in the test.

The error is as follows:

Format ioctls:
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                fail: v4l2-test-formats.cpp(1336): got error 22 when
setting parms for buftype 9
        test VIDIOC_G/S_PARM: FAIL

Maybe we need to check for EINVAL and return ENOTTY in that case, like
what is done on line 1305 of v4l2-test-formats.cpp for VIDIOC_G_PARM?

>
> Regards,
>
>         Hans
>
> >
> >       ctx->enc_params.framerate_num =
> >                       a->parm.output.timeperframe.denominator;
> >
>
