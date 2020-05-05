Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45179C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1574820746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ipNtgkcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgEEN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729202AbgEEN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:56:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBBC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:56:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r16so1848158edw.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kByI+w+1r3yVREOJZ6z093OJKNl72Y1CH8ahM0Q63XY=;
        b=ipNtgkcPwQaCd/KFAKKCzEcUcKFCfb7x3z4NEVWMwUh94Bu54C4AbN3A72Y5hKnJ+n
         oiStdLca3s0SQIKFEVG/KxqF9OkQx3cbrCDG4u9U3+xQz/xE655gmDYg1+OJeblGE2Iu
         Y38P1mTpYn7m6tr5ZZYBBkCmxVOIAJ/Cck6YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kByI+w+1r3yVREOJZ6z093OJKNl72Y1CH8ahM0Q63XY=;
        b=VC7LZ8xhyJeGc5QOzSn5Lo1MTPpqWplJ/AyEL3wcXcAQLV42CxYtjcDEmDzcxMsHXh
         hxA8oWl+pHnCauOrokXEUzfVD2uagRICfXiIBTusLV4/IuSYpy21UB1trHTuVfdLfCqn
         EaRJ9iIhTUORagw4UNLW3553lt7qFH9NfOLstrIG5EOhIV9VgKjZRtIM0ZCelclIBNAI
         wSPSqFjbOr5+M+5GRr0C10GJszzliFi5i6Llng3JyeChm/IMTduuqu/I9fRVUgZpP5yQ
         pwjHXQzrqyA05waaabxtipZMP5HXF2H+diNchEGDjHAOQuPWKaqvSQNgrKUPiOJ1X299
         I7Nw==
X-Gm-Message-State: AGi0PuYOTMm0bMN14gGJ6AyKJI+ETTeGLut1N6094XqmZnl6fWlcdfNM
        Tn3kf/r2EifFLLMRvrOapZJXBUa6uM1mPQ==
X-Google-Smtp-Source: APiQypLpClg/LDKjwG9N3bEcMExDk79HPejzsHiEr5UWEdWny8X2Kt91gMsZy0BLHXVL7m7QV67z9w==
X-Received: by 2002:aa7:cb43:: with SMTP id w3mr2651240edt.95.1588686975283;
        Tue, 05 May 2020 06:56:15 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o17sm332460ejr.76.2020.05.05.06.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 06:56:14 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id y3so2900694wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:56:14 -0700 (PDT)
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr3809161wrh.295.1588686973780;
 Tue, 05 May 2020 06:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134110.3435-1-ezequiel@collabora.com> <20200505134110.3435-2-ezequiel@collabora.com>
In-Reply-To: <20200505134110.3435-2-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 5 May 2020 15:56:02 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AWZFoPk2YTp2k8M7LvJshxw46-z+wK2VoM9EzB2CqiFA@mail.gmail.com>
Message-ID: <CAAFQd5AWZFoPk2YTp2k8M7LvJshxw46-z+wK2VoM9EzB2CqiFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: rkvdec: Fix .buf_prepare
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Tue, May 5, 2020 at 3:41 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> The driver should only set the payload on .buf_prepare
> if the buffer is CAPTURE type, or if an OUTPUT buffer
> has a zeroed payload.

Thanks for the patch. Just one question below.

Where does the requirement to set OUTPUT buffer bytesused to sizeimage
if the original bytesused is 0 come from?

Best regards,
Tomasz

>
> Fix it.
>
> Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 225eeca73356..4df2a248ab96 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -456,7 +456,15 @@ static int rkvdec_buf_prepare(struct vb2_buffer *vb)
>                 if (vb2_plane_size(vb, i) < sizeimage)
>                         return -EINVAL;
>         }
> -       vb2_set_plane_payload(vb, 0, f->fmt.pix_mp.plane_fmt[0].sizeimage);
> +
> +       /*
> +        * Buffer's bytesused is written by the driver for CAPTURE buffers,
> +        * or if the application passed zero bytesused on an OUTPUT buffer.
> +        */
> +       if (!V4L2_TYPE_IS_OUTPUT(vq->type) ||
> +           (V4L2_TYPE_IS_OUTPUT(vq->type) && !vb2_get_plane_payload(vb, 0)))
> +               vb2_set_plane_payload(vb, 0,
> +                                     f->fmt.pix_mp.plane_fmt[0].sizeimage);
>         return 0;
>  }
>
> --
> 2.26.0.rc2
>
