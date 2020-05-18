Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE4C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIdzmN5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgERKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:51:52 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8FC061A0C;
        Mon, 18 May 2020 03:51:52 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id v192so2279734vkd.3;
        Mon, 18 May 2020 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpjSkkn7ApK5Yq+n7OuT8kXvOD7uu7gT865+wNXuHVM=;
        b=TIdzmN5Zyod2KpKoraBArfu7HJ/dEL5tffIucTv8YuRzLkeoU8FiBg7P7XovUQxL/D
         PNj0R8Ys14RDTqKJWOpbotZAsy2DF9HvMohwoUIcrtsRtdZ1KhYQRu5S1a3jtL2keuQ9
         n01+J9BhdUvlIGWd3QV7N8Ct+r8CCv5twPyzFL9jzrRF8UIlaU90fZAB11X4PCvWuvCs
         HuJ3DiC7taPGk51xKRGbeKVrv1LRbWsxwT5zP8w20Oqj/OPmx8/wp4OrKUkO3aBtzmtG
         dByNMjEIU75bxzxx5lR95RTEk8A9XIQ80QnpUDh4BaEbvqGlAoOTnd8U+zSTQZ6gIxx4
         fkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpjSkkn7ApK5Yq+n7OuT8kXvOD7uu7gT865+wNXuHVM=;
        b=GEcT5+nVu9wKVn1vTu5i8SRHuEeAjD8YMZ7iYWGasdXGEL0TTvIx0U3Q+eaIeIkNvt
         7f7lZSTTqA0JPrUPUav1We0XjyPMQPNPmSo3+SiewOYelX9cBWaZ5oGBb5Ow8/2raxuK
         lPXVHinb+1S+BdmyPhhvBMwe6psj7vzG8vu7tC+TeBbQ9BQSGWDvxpbLZCIZRcI4enOp
         1lB5SKP/92Gsj/S8FoD1piAy2Sm5q2TvF40Q7/wxp1tC5rrUMBr36kDTqbXkxUuJfDf/
         CKgB/OO3VfFf9w+YJOW98mT+JzrxtKW86qg2GX/1vZsZJ4u+KwLYC6yoNBlM2SjwleqC
         miEw==
X-Gm-Message-State: AOAM531Ze3WRKsvdVM9Ox94/k7S3vpewWf9MZn6EQu4R5eRMgtHnTSDN
        a9K1CduxbGnKHECf+8o2DXtFmBqevqqFyn8UBn8=
X-Google-Smtp-Source: ABdhPJyJoE3DeUp5mRCR4/NwPKcB+0c9bpy1Jfu2Pe+bafT+c8kQlQDsW0FnkxaYd3hr8PrATmPVX23jWINoG1EwtPc=
X-Received: by 2002:a1f:2bd7:: with SMTP id r206mr790067vkr.28.1589799110526;
 Mon, 18 May 2020 03:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200516215057.392609-1-paul@crapouillou.net> <20200516215057.392609-11-paul@crapouillou.net>
In-Reply-To: <20200516215057.392609-11-paul@crapouillou.net>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 18 May 2020 11:48:59 +0100
Message-ID: <CACvgo50q=qJXk3nFSCm+S6JHBMxpY0C_HwH8KGB2EAcKwgL0oQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] gpu/drm: Ingenic: Add support for the IPU
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, od@zcrc.me,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Disclaimer: I don't know much about the hardware :-P

On Sun, 17 May 2020 at 00:31, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add support for the Image Processing Unit (IPU) found in all Ingenic
> SoCs.
>
Since the IPU is present on all devices supported, does it make sense
to have it as separate module?
Didn't check closely although I suspect doing that will remove the
need for the component patch.

> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -50,7 +50,7 @@ struct jz_soc_info {
>
>  struct ingenic_drm {
>         struct drm_device drm;
> -       struct drm_plane f0, f1;
> +       struct drm_plane f0, f1, *ipu_plane;
>         struct drm_crtc crtc;
>         struct drm_encoder encoder;
>
> @@ -186,13 +186,16 @@ static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
>         regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
>                            JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16,
>                            JZ_LCD_CTRL_OFUP | JZ_LCD_CTRL_BURST_16);
> +
> +       regmap_write(priv->map, JZ_REG_LCD_IPUR, JZ_LCD_IPUR_IPUREN |
> +                    (ht * vpe / 3) << JZ_LCD_IPUR_IPUR_LSB);

This hunk also indicates that it may be better to merge the IPU within
the existing driver.

-Emil
