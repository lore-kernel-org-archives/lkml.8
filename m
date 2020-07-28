Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F0C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E62207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jqMplwp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgG1PBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbgG1PBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:01:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5329C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:01:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so202730wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7U1Q9zeroE/yPznt2D4XGJyQI13I8758w9wiJAiJy0=;
        b=jqMplwp4VEt7NK46p9DKah2lRF0mHZAS3/mKudshZMy8FcXvLybfAOfggbp9fNABQB
         qdQQrywnrwpr5DVhoAhfpSeN+ncqAgJtbISGMwiO6YiTK8PCRZHkJzwpW2kB8dXRo3F6
         IBtN14ZY0oRy51onC4wkHrXX2Y1HiC/3g3u0qWtxUma2C/vqF0vc9RHpTheV1xzp2TwQ
         tGxBRYBqe4wlQ+B9ML2ck5jheJgA0cFOd86MZN4vaAJkGxaj1/EZAyKBj0Vyvq1n5HqP
         dVtkcScjBUvdltbqg66XgcZowjJlsIO05W8ARbU60uZK/a5nFMjopidVmfwmeDt4r6EX
         kRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7U1Q9zeroE/yPznt2D4XGJyQI13I8758w9wiJAiJy0=;
        b=szvCBk85SEnh0Wxh0oxv/FVOFu//Y8vjuEcI6ueL4zt7SzBkC7KqcjNX1i8FGSqPTL
         LTIfFvgzpygTwliQbmRTDkcgMS+VTZZf+dvG6+J7ha5McJE4lFAzlRzI5pcXIhuRrP8N
         niLW0NL4f4u8OhxmXDqaIoWe9r6ez7A4CZ8aV0iAf4dI6jWA+k+JCU1Pdvy1VtGnUad2
         VnjOOcF5b1OVamjUayfojKAug0+iYoOtF5RTjoc89dmnyf5TyodiaUqVl7qntXg3u+YU
         iPIJuVPQBfEpUnDYKJdqvKLo+rWpe8lPcMJOiZGFMQwNMDJsB98ZTxW4upf/WUvOc2UY
         i/hw==
X-Gm-Message-State: AOAM530yHqqSYAaKi7jHD4awn9As5+13MQiRlx473rUr0BoWOHkTqgPJ
        xZV6vFIVsqshOhxG5jT3M4awqo5D3M7FGgIVyXhKgg==
X-Google-Smtp-Source: ABdhPJwtZsESR7WdQs9vZjByKfImYo4n+KjVPXTXmg/4Xny0qvN0mdHnW9DUz8VR/jWrvijgch9md6yvGN2RFYNjzxM=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr4091054wmh.96.1595948465354;
 Tue, 28 Jul 2020 08:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <7d4c17db4a1214b7665375aa83fe1f8b4f0fbdfb.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <7d4c17db4a1214b7665375aa83fe1f8b4f0fbdfb.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 16:00:50 +0100
Message-ID: <CAPY8ntBJriBEa4ORW5Ns0zc0ma=7HoooCPKTQb9cfiVQe02uCw@mail.gmail.com>
Subject: Re: [PATCH v4 68/78] drm/vc4: hdmi: Deal with multiple ALSA cards
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The HDMI driver was registering a single ALSA card so far with the name
> vc4-hdmi.
>
> Obviously, this is not going to work anymore when will have multiple HDMI

s/will/we

> controllers since we will end up trying to register two files with the same
> name.
>
> Let's use the variant to avoid that name conflict.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

With that change
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 3 ++-
>  drivers/gpu/drm/vc4/vc4_hdmi.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 1b6f51849d6c..0a9a323e03d8 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1044,7 +1044,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
>
>         card->dai_link = dai_link;
>         card->num_links = 1;
> -       card->name = "vc4-hdmi";
> +       card->name = vc4_hdmi->variant->card_name;
>         card->dev = dev;
>
>         /*
> @@ -1503,6 +1503,7 @@ static int vc4_hdmi_dev_remove(struct platform_device *pdev)
>  static const struct vc4_hdmi_variant bcm2835_variant = {
>         .encoder_type           = VC4_ENCODER_TYPE_HDMI0,
>         .debugfs_name           = "hdmi_regs",
> +       .card_name              = "vc4-hdmi",
>         .max_pixel_clock        = 162000000,
>         .cec_available          = true,
>         .registers              = vc4_hdmi_fields,
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 4aea5ee8a91d..34138e0dd4a6 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -30,6 +30,9 @@ struct vc4_hdmi_variant {
>         /* Encoder Type for that controller */
>         enum vc4_encoder_type encoder_type;
>
> +       /* ALSA card name */
> +       const char *card_name;
> +
>         /* Filename to expose the registers in debugfs */
>         const char *debugfs_name;
>
> --
> git-series 0.9.1
