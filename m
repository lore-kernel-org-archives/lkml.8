Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFFAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C973120757
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="LMOdDWoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHaAVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:21:13 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:21:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id u1so3884732edi.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6HdyqHVivfNhnk9ly+FjwTjY3Zt8AbJh2F7cbnVyVc=;
        b=LMOdDWoQGNE2uyzaedKQQWP2tHcoCrFluG08SN5bbkrv10x8OTCVH+m25Ptvi4rDM+
         a22uk70z55teG3MocVShxLP2fDFBcLpD6OB/C3LFooGcTfuG0DJ575RdjTRQTxCibXnE
         tXBfyBH/8HqCUrkWA/aQIeu1B3PMrIIACItjwVolp9EOiwGMQALQCV48lSQikT+L9jjm
         82T8jH37489THJS1X6JYDBgucIOKQiTtHlyU+npJL0Enx3ZNpYE0CFfX3g6WI4ReJEdj
         3ovR4cR2/t2x0OSr5kTFLCH5cgbpnRAw0DF7EVTEiL2bK3RjZVppaX36v91XHhnQ6lWP
         HIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6HdyqHVivfNhnk9ly+FjwTjY3Zt8AbJh2F7cbnVyVc=;
        b=bN46QsXx/OW4FS+YYdSzNgZ5GG2AkUDnFhU4Fu1TkeVOMKkSiYdhx86iD0jnbHJg3c
         DxlQOcFftQu3tRkzBR0I08PWCAsl3elegn1UxOkGZeLk5FPQ6GUgmausVdM2XdjfV50f
         hcNew3rsIRcuqWSxqu0S8zZgLRewkjbs5He+TrNrcLBtr3UR7j1iHfqGzYglVrwX1ctA
         kfcSytP4LEE/pdTpIBzxflB7monNmPibtWejXJ7rb/OfnSM4beJqvZFTZizDocn92mSp
         PvWI0TUhVedatpAyo+cLYsd561aqO5Z8XErb0C88Edyiwp9XU9TqEmGEuQne/T70UW9i
         f4GQ==
X-Gm-Message-State: AOAM532BNc/XEvrla/G5HMgsyYSQFZdpZb9ewuaNHVx/JNn0RcOi/lk0
        GW+ovHP6QpauGBFk6HtNGkLNiXIDH8NFPe97ebyWKg==
X-Google-Smtp-Source: ABdhPJxBx79VPUZ+zhpNJRIiCaZl+CvY32kO0H0ZQycTNjI9576Bq2IhyrK530mkgPAXNSOU4P/Y6sQuNAkz0jVYgXg=
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr4309729edx.213.1598833271172;
 Sun, 30 Aug 2020 17:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114404.36748-1-paul@crapouillou.net> <20200827114404.36748-2-paul@crapouillou.net>
In-Reply-To: <20200827114404.36748-2-paul@crapouillou.net>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 30 Aug 2020 21:21:00 -0300
Message-ID: <CAAEAJfD9q-iB9iCgCBWdA0_77=T1zsk9DFh-qvVtLHWqEnOWbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/ingenic: Fix driver not probing when IPU port
 is missing
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 27 Aug 2020 at 09:04, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Even if support for the IPU was compiled in, we may run on a device
> (e.g. the Qi LB60) where the IPU is not available, or simply with an old
> devicetree without the IPU node. In that case the ingenic-drm refused to
> probe.
>
> Fix the driver so that it will probe even if the IPU node is not present
> in devicetree (but then IPU support is disabled of course).
>
> v2: Take a different approach
>
> Fixes: fc1acf317b01 ("drm/ingenic: Add support for the IPU")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index c1bcb93aed2d..b7074161ccf0 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -673,7 +673,7 @@ static void ingenic_drm_unbind_all(void *d)
>         component_unbind_all(priv->dev, &priv->drm);
>  }
>
> -static int ingenic_drm_bind(struct device *dev)
> +static int ingenic_drm_bind(struct device *dev, bool has_components)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         const struct jz_soc_info *soc_info;
> @@ -808,7 +808,7 @@ static int ingenic_drm_bind(struct device *dev)
>                         return ret;
>                 }
>
> -               if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
> +               if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU) && has_components) {
>                         ret = component_bind_all(dev, drm);
>                         if (ret) {
>                                 if (ret != -EPROBE_DEFER)
> @@ -939,6 +939,11 @@ static int ingenic_drm_bind(struct device *dev)
>         return ret;
>  }
>
> +static int ingenic_drm_bind_with_components(struct device *dev)
> +{
> +       return ingenic_drm_bind(dev, true);
> +}
> +
>  static int compare_of(struct device *dev, void *data)
>  {
>         return dev->of_node == data;
> @@ -957,7 +962,7 @@ static void ingenic_drm_unbind(struct device *dev)
>  }
>
>  static const struct component_master_ops ingenic_master_ops = {
> -       .bind = ingenic_drm_bind,
> +       .bind = ingenic_drm_bind_with_components,
>         .unbind = ingenic_drm_unbind,
>  };
>
> @@ -968,14 +973,12 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>         struct device_node *np;
>
>         if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
> -               return ingenic_drm_bind(dev);
> +               return ingenic_drm_bind(dev, false);
>
>         /* IPU is at port address 8 */
>         np = of_graph_get_remote_node(dev->of_node, 8, 0);

How about we get rid of this (seems a bit odd to rely on port address) ?
Rockchip-drm driver has a nice approach, and I think we might need
something like that going forward, to support dw-hdmi.

Thanks,
Ezequiel
