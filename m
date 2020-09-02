Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E109BC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00BD2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvZ2lRWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIBHBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:01:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFEC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:01:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so2321232pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2VBp7Lpbc9ICyEZOh+PAo/PTYbf1ofIuaPW1FlGuW60=;
        b=cvZ2lRWS/K1mePpg+qzSYqqi1cRElv6vuYDkCfonKlKHO89DzNH/KqMbGv6t1Hcl3b
         jBMiROk7dmO+zLsKzXhUOkPUR365CPCEEpd72j5fNU0xy8A36MxcyFaIcQUVuKEi185R
         XmMbv6KrZolva+sbow2V5bbf4wy3d9fFgMias3gaOGFMdinYTLyeOMR1+7DLTgNKsKnY
         cfkUdths5gFvqpjj2jPdq+76IE0Q0JfQ7hth2oSC4LYICEJe7SMmqbNgHxCg/B4Gw5sX
         k52zJui/62CWfQSlT4Sx5vW2t+bubaowOMzduS+xyJNgrNtalz79ebkKMku7z4RxnBeS
         G9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2VBp7Lpbc9ICyEZOh+PAo/PTYbf1ofIuaPW1FlGuW60=;
        b=MsU9U/npq/1858SaylRwnJ+DlY5rrjZfWsB+QtIALqa3rpgQCTAMVlDTRvaCBiKp72
         UP0WdBT2QM1vFL1Wll8KLP5UE8a798hY9pXJL8wcimSenRlEZERQkPczbNTn8dTJNSz0
         KbYByRVZ9tA89nu3EmkwKmlyJ1HCqGEO8vBZcvdqDbDjUvkGMa6xINog532eJJYFyzN9
         RTtDXwrJbNv/l15qUXuh5GCZuIaBtpA1cvFU6dFdCUiAh6UAT9XDSrVwQqkelSCAJcWL
         VX2NKQszeV4uFuaErRpynYHwexdLHEd/dA//ESDuj+4OoH34KcAS5Sq/hlFy9npro+RN
         KMfg==
X-Gm-Message-State: AOAM533Yvd7YOOSfBrYuEG8FWj+nJzWKLCq4LTnh/yfqaVRB9z8ArZ9D
        zwBx4cMslQxfzrHZvuYbrDNDw9gaQ2gdC5+fpIA=
X-Google-Smtp-Source: ABdhPJzyLrQWUInqU1HwkAEDX0M48D0ehobZk/DCp1+yTXFpbVCgHzovoVjqrhhEXk+moMSbkqf3tWhOekSGKTIyNQ0=
X-Received: by 2002:a63:1402:: with SMTP id u2mr823991pgl.400.1599030088244;
 Wed, 02 Sep 2020 00:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220305.6809-1-jernej.skrabec@siol.net>
In-Reply-To: <20200901220305.6809-1-jernej.skrabec@siol.net>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Wed, 2 Sep 2020 10:01:17 +0300
Message-ID: <CAGphcdnT4U8AztL_B_B2HYskQSAYKRgCQcnO3Q8Qj+UFO082hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Fix DE2 YVU handling
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, irlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 2 =D1=81=D0=B5=D0=BD=D1=82. 2020 =D0=B3. =D0=B2 00:58, Jernej=
 Skrabec <jernej.skrabec@siol.net>:
>
> Function sun8i_vi_layer_get_csc_mode() is supposed to return CSC mode
> but due to inproper return type (bool instead of u32) it returns just 0
> or 1. Colors are wrong for YVU formats because of that.
>
> Fixes: daab3d0e8e2b ("drm/sun4i: de2: csc_mode in de2 format struct is mo=
stly redundant")
> Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 22c8c5375d0d..c0147af6a840 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -211,7 +211,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
>         return 0;
>  }
>
> -static bool sun8i_vi_layer_get_csc_mode(const struct drm_format_info *fo=
rmat)
> +static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *for=
mat)
>  {
>         if (!format->is_yuv)
>                 return SUN8I_CSC_MODE_OFF;
> --
> 2.28.0
>

Hi Jernej,

Thank you for the fix.
I can confirm this patch fixes the issue with wrong colors.

Let me share my thoughts:
I've looked into csc code, and it seems to me reordering U, V offsets
should be a much simpler solution than applying
color transformation matrices.It should also simplify adding more
color encodings in the future.

Regards,
Roman
