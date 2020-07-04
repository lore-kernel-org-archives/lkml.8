Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648EE20870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YhkyxlMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGDMgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 08:36:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52397C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 05:36:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c25so10830021otf.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6mV9hDq5aLUv1ieVsH3l3iusJ1iXEPBM/Wq8VobGV4=;
        b=YhkyxlMIzlrMbZCMkgw8ZZ4xFQQWRbvOrg/cac0SP6UAL+dKYfgTmikrEVyuEu+Fa0
         0hea00p6nJ0gX1I4pX7X6WL7xukKfMQvdRH90jKY660TTeTESN8r3Cm8Dcg0VaHrnbBP
         oYyZedahnsh5lSgyTssOpM4B7MeOYQN9Zd7mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6mV9hDq5aLUv1ieVsH3l3iusJ1iXEPBM/Wq8VobGV4=;
        b=JzcAjw68Tbic3M7jItHLWaI+9I9Gzt48Im8wREFlkOIkP23C0/gGun1CEtYhZoUuE/
         gBM1WkTczeL22mKN0lT92UxfUhJGhtbT0sfpMARKwSY6RIFvXqP+jk1riBQfPWOL10Dx
         nQ+hM7GuMKW3gjL4o/DWaBBZyzJZouK5l33ivdfSQILDKdRRdOR24ypHCBfM8Qj3MyRw
         rniX+F+qKgB42raQE0AqG0zFZwGr5pvWoKRc3W8yzCHC6s3wR1AO/9ciqzYloJyUM1BZ
         8pN4manweiIPjLuuTYz8KjXOJg9boniNPP0gWmb0ET6+2bjlaq0Qr9xz8RoBhtTRmuj3
         lZbg==
X-Gm-Message-State: AOAM530sfDCiX013ZD+D4Z0UG+INGHS0aTCi/HWxhoh2qmQPWEPJu2yK
        9skAfTkrKjT2G270khDDgoXfWZhWZv0=
X-Google-Smtp-Source: ABdhPJyuvbRHLJNS/TATwpAFeVWMgP/PR6eHdYLZ+qZ5b3cgtpcwsyfHaFplhLI+VGS3h+MOzH1g4w==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr36150833ots.143.1593866199920;
        Sat, 04 Jul 2020 05:36:39 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id f10sm217786ote.38.2020.07.04.05.36.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 05:36:38 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id v188so1328303ooa.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 05:36:38 -0700 (PDT)
X-Received: by 2002:a4a:1d83:: with SMTP id 125mr35500480oog.18.1593866197876;
 Sat, 04 Jul 2020 05:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200630062711.4169601-1-acourbot@chromium.org>
 <20200630062711.4169601-5-acourbot@chromium.org> <d2c15fbf-0076-37b7-7b87-9ef51e0357d9@xs4all.nl>
In-Reply-To: <d2c15fbf-0076-37b7-7b87-9ef51e0357d9@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Sat, 4 Jul 2020 21:36:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWZC8j45r5yhGFJJe+gF_aHdwLWb5pUNR7jVoOBeihntA@mail.gmail.com>
Message-ID: <CAPBb6MWZC8j45r5yhGFJJe+gF_aHdwLWb5pUNR7jVoOBeihntA@mail.gmail.com>
Subject: Re: [PATCH 4/9] media: add Mediatek's MM21 format
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

On Fri, Jul 3, 2020 at 5:39 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 30/06/2020 08:27, Alexandre Courbot wrote:
> > Add Mediatek's non-compressed 8 bit block video mode. This format is
> > produced by the MT8183 codec and can be converted to a non-proprietary
> > format by the MDP3 component.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
> >  include/uapi/linux/videodev2.h       | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> > index 02bfef0da76d..612be602bf76 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1398,6 +1398,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >       case V4L2_META_FMT_UVC:         descr = "UVC Payload Header Metadata"; break;
> >       case V4L2_META_FMT_D4XX:        descr = "Intel D4xx UVC Metadata"; break;
> >       case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
> > +     case V4L2_PIX_FMT_MM21:         descr = "Mediatek 8-bit block format"; break;
>
> Can you move this up so it comes after V4L2_PIX_FMT_KONICA420?

Sure.

>
> This format should also be added to Documentation/userspace-api/media/v4l/pixfmt-reserved.rst.

Added a description right next to the related MT21C format.

Thanks for the review!
Alex.
