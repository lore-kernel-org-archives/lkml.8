Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795A2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5UWG/uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbgFWQfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgFWQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:35:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D5C061573;
        Tue, 23 Jun 2020 09:35:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so24161731ljn.6;
        Tue, 23 Jun 2020 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEg6d25UGfcPYY7V+Hk1VnYd/BQrvpNa49hlVGHxeMA=;
        b=e5UWG/uq7VlzVdXxW7H1FtNuYg9CuE0jZ+f195RVA75WoKMrBfXE99E0IyqjmT6B93
         CVUcGT3+r/Y7uGMiJXh8wn7+nX1Juwa+379k82vm9KCjn1MtgLexvNJW8KKAS83NdTfq
         bvEzIPJi0wmZ2GKpd5bvXa3XLMLI1ms5+Ppn2c/m/oRNuLtUTDaWUt6zQIp6oMTey0fH
         xHzwX1EmVIu6qDUGQkwT/NrSTVq8+IOgAwnkJt5Qe2uIx++GLGEY7OZEPSsjvftBl0Te
         R+Xe18DrNiV/eJ2GI5BYFGNnKTlCBjirbxqWeXJuH61OlvJ2WQXaF9VDvMzhOt8L4rVN
         iPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEg6d25UGfcPYY7V+Hk1VnYd/BQrvpNa49hlVGHxeMA=;
        b=Va3slSk2tX16JRkFtYQdw+WUuagnyLq3SPZ/xjkWdsIGimxCOa7U3ZXVzw0KBr05GA
         /tQ/a5ktoFx2YxUspvQ5evqoCTakZno8khNXb4X2qaYb2AR0k6mmxtbwSSCevB2LUKmz
         oZ2lm8nL5O8iB2Xz3lfX43xLDXjjeRxrVqnvofjnMbSbF4ihKsI2b2z9TM95M3f/ERdy
         UITsz0OQagF34HSIqZRwbjteWfo3SRRyw1uxCLNJWGCt3p5a/hWwbCVB0+RNzs62sNI4
         wMO5Z1s1iCanbmLxkUDYfSPSxbIALY/XdEhpOEYvClKwynNNiZ4yn4VS9xx1HTb05Mky
         +bow==
X-Gm-Message-State: AOAM5328mJ5Che2Dxo6ZgGQeoKYdt9JFR16lFVpVNNlodfcIZ/rBbW2k
        I4i++Gj3Ui3XQMXbCwmBKp7Ibgu+aiav5XdN2PcwUgD/i6Q=
X-Google-Smtp-Source: ABdhPJx7RZSTdg9v9+N1buYRGoXyIHiqxid7CrjNsjgZq8odaQKJBKeuXj1I1etNdvQWsOzD471lJ9LYfU2F7bphppQ=
X-Received: by 2002:a2e:8783:: with SMTP id n3mr6787289lji.224.1592930151040;
 Tue, 23 Jun 2020 09:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200622204537.26792-1-efremov@linux.com>
In-Reply-To: <20200622204537.26792-1-efremov@linux.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 23 Jun 2020 18:35:40 +0200
Message-ID: <CAMeQTsYAomJnjc6eVnDxQL+FC3nG+n1ZDqUPGgDpU=tt9d+JMA@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Fix direction check in psb_accel_2d_copy()
To:     Denis Efremov <efremov@linux.com>
Cc:     Alan Cox <alan@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:45 PM Denis Efremov <efremov@linux.com> wrote:
>
> psb_accel_2d_copy() checks direction PSB_2D_COPYORDER_BR2TL twice.
> Based on psb_accel_2d_copy_direction() results, PSB_2D_COPYORDER_TL2BR
> should be checked instead in the second direction check.
>
> Fixes: 4d8d096e9ae8 ("gma500: introduce the framebuffer support code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/gpu/drm/gma500/accel_2d.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/accel_2d.c b/drivers/gpu/drm/gma500/accel_2d.c
> index adc0507545bf..8dc86aac54d2 100644
> --- a/drivers/gpu/drm/gma500/accel_2d.c
> +++ b/drivers/gpu/drm/gma500/accel_2d.c
> @@ -179,8 +179,8 @@ static int psb_accel_2d_copy(struct drm_psb_private *dev_priv,
>                 src_x += size_x - 1;
>                 dst_x += size_x - 1;
>         }
> -       if (direction == PSB_2D_COPYORDER_BR2TL ||
> -           direction == PSB_2D_COPYORDER_BL2TR) {
> +       if (direction == PSB_2D_COPYORDER_BL2TR ||
> +           direction == PSB_2D_COPYORDER_TL2BR) {

Hi Denis,

Sorry, I don't follow. The code seems already correct to me.

src_x and dst_x gets adjusted when going from right to left
src_y and dst_y gets adjusted when going from bottom to top.

PSB_2D_COPYORDER_TL2BR needs no adjustment because it is the normal
blit direction.

Thanks
Patrik

>                 src_y += size_y - 1;
>                 dst_y += size_y - 1;
>         }
> --
> 2.26.2
>
