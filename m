Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50F920737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="V08GEdlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGQQyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:54:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC24C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:54:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so11540411ejd.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/tcpiEgnv1Vg5/I/OqgwYTF2aG01fzIys/jsiwnsBI=;
        b=V08GEdlJqw4cSc4CYRXDay4U2O0xjmQgoh0OxThxGSd8zlyBOJCSG0LvDkG+BS5q1U
         WQv0Rec190mcxfeNnx9LuXQbIcPLoGhH9X8bLpMg7FMUa8CJ4BFRAVr21oo/Ux4WjiXV
         XQP26ElmfuVKTXFD2k5+sr7XL8I08MHgj8irONWZb+auOwjrSAvavYNSxJaAwRtE+8rV
         44qJWazIJ97dD/JSmF3tSb5TPixZ3QkjOHRwMoYqP2y9Yrp9oLo51Wc+hHjAOh1KK9S2
         PQSr2dtMbPXRDKC1aEq87RcfJ3uV/RCo9mYd7hZGPLwFVaPb4Z3ZGA6AC1NARDnv5O43
         rNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/tcpiEgnv1Vg5/I/OqgwYTF2aG01fzIys/jsiwnsBI=;
        b=dC4JN+HdQyh54gDAjc8JzIGq405aILbDD1RruedGWoTJ9tsgSDPxMfPw7Pl6ZdCqeP
         oo5YoEj0xptj1sWYBxAkGV3bYCDmkuponeMThwqNus2a5ltZxq9dUjl5BHyoyaoPrKIH
         AYLW5dL/n/9S9/ApitZsCb5Q3Mj8hWBaDGpBrnW6+EDrMJC0mcM9aaYquaMSBnMJ2Mgt
         ylWwktIj+3a9hHlbg75e/Y4XMd4UMpu5bPznlve9sdtcRRGRwMAFQbElknq2/Gc/6B2z
         zDcu9pBCTPMusUGQFWIVAV8PckjNER41YUk0Ag651jt6G839OIBJGDXIFt/a8195KTql
         c8dA==
X-Gm-Message-State: AOAM531F2QYICHbeSfz+cp9fms2IEaXVtusdYM6DX2Qlv2K78pULde5c
        jtRvppr9aE3NWOpLam7nDN8NyhPgVwDec4UANwheyQ==
X-Google-Smtp-Source: ABdhPJxeMxUiEad3F5pqF1zmMQCX7DX5YW7te/oFGx5apYjlR/tGaK2csLBqusCu4S1I2ioC55TIZ0IM57TEY9PInGA=
X-Received: by 2002:a17:906:1751:: with SMTP id d17mr9220665eje.140.1595004850955;
 Fri, 17 Jul 2020 09:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200716144927.7193-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200716144927.7193-1-nsaenzjulienne@suse.de>
From:   Eric Anholt <eric@anholt.net>
Date:   Fri, 17 Jul 2020 09:54:00 -0700
Message-ID: <CADaigPWN9fJS2YB3Ly3bBTj8ur=F8_Li+hBzbDuSN0ig3mOiiA@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Use platform_get_irq_optional() to get optional IRQs
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Dave Emett <david.emett@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 7:51 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Aside from being more correct, the non optional version of the function
> prints an error when failing to find the IRQ.
>
> Fixes: eea9b97b4504 ("drm/v3d: Add support for V3D v4.2")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/gpu/drm/v3d/v3d_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index c88686489b88..0be2eb7876be 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -217,7 +217,7 @@ v3d_irq_init(struct v3d_dev *v3d)
>                 V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS);
>         V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS);
>
> -       irq1 = platform_get_irq(v3d_to_pdev(v3d), 1);
> +       irq1 = platform_get_irq_optional(v3d_to_pdev(v3d), 1);
>         if (irq1 == -EPROBE_DEFER)
>                 return irq1;
>         if (irq1 > 0) {
> --

Reviewed-by: Eric Anholt <eric@anholt.net>
