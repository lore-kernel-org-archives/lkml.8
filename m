Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68242C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400462075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="MCP5blea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgG1Mcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgG1Mcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B2CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:32:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so14560209wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nmyno9CIxd/+eR+0JKHQRxoaOxegsT0ZP95p/Ej5zhc=;
        b=MCP5bleaKYrlAN1Lt4mDE2kQD8VpsyxWB+Hndi9o1BryiarY15foTB/dA1WicT9wLG
         7etihHMIFMAjmm9cqjfTg4hf4wLJ1pMwAXUI58wJ1I6oMBZ5QAtdDgRv3AlfANEvusOs
         fAkrJs6xv7vNJ1Qve1vNBPxs96Pap0ztLSYnSvC37Lz4/vEwT+k0LbRpOvwKZi00m3lZ
         eHsX1fA1Md9ybVcg5++BzaK+w2dbMvger7ga6u5/3WndtHO46QNDctwduobrcIdcnL04
         9vLNlFo6RLte5WHWiHF+rhUQawdhq9VCT2dsDrEdC/NRhiYq0U8JMyhl+03UOHEW8vGJ
         KN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nmyno9CIxd/+eR+0JKHQRxoaOxegsT0ZP95p/Ej5zhc=;
        b=g8o+77qiJo2PuIsjwRd31QeCa15y4Z/WSpB5yQJf+W3osxxrzVs/QQklN0bYBifGx0
         EkMAC4i68hR22XW74w5BnmjCbOaS0ABsMftK/07RGDMf7WpV/yv7PS+LE2XyvZNOC9yJ
         W4D2JBqnnzO7dV/Ef4vqt5MAExut/YDHUW2NQKasCCYglHH2F+S2rqdSCML5rF/l1xfv
         atLus1vbnJP/h5PUjdgot7VpRwhngwI/4qr2dfcswFhDP4uvl0UqybxVJjxXwklA1QGf
         Nim4pJkniS5WXV22ztqFY738mOtTdiNyLsFQ4ns1TnO1h74zc2gy1FrJf3VKR4xrFDIR
         /J+g==
X-Gm-Message-State: AOAM530v/uizKqZTLUipQFKv8gT4ELv3HR7ltmbusDeYBS3ClKFqXVgT
        GomyFcrNNImAqdj0NyRB0FbXw9YLMWCHgE2mLoLkGg==
X-Google-Smtp-Source: ABdhPJyv9CCzW7zYuKRzEQvuf9ZaMdt+mIXn+QTeMAahyGfeWLb6vZtQBtj8lQ4/s+nClbbntdq9WWfdIK3um6CrEIg=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr23678224wru.47.1595939559697;
 Tue, 28 Jul 2020 05:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <0fc40024f73b3bc6d9eba0b47da217ed130c3374.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <0fc40024f73b3bc6d9eba0b47da217ed130c3374.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 13:32:22 +0100
Message-ID: <CAPY8ntAWq_3=K_=zHVRmBqgA-ZKMbjKwrWvg+Y6FtSjBjc_DvA@mail.gmail.com>
Subject: Re: [PATCH v4 47/78] drm/vc4: hdmi: Retrieve the vc4_hdmi at unbind
 using our device
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

On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The unbind function needs to retrieve a vc4_hdmi structure pointer through
> the struct device that we're given since we want to support multiple HDMI
> controllers.
>
> However, our optional ASoC support doesn't make that trivial since it will
> overwrite the device drvdata if we use it, but obviously won't if we don't
> use it.
>
> Let's make sure the fields are at the proper offset to be able to cast
> between the snd_soc_card structure and the vc4_hdmi structure
> transparently so we can support both cases.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++++++++++++++++-
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  4 ++--
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 09b297a1b39d..7cd1394c10fa 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1200,6 +1200,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         if (!vc4_hdmi)
>                 return -ENOMEM;
>
> +       dev_set_drvdata(dev, vc4_hdmi);
>         encoder = &vc4_hdmi->encoder.base.base;
>         vc4_hdmi->encoder.base.type = VC4_ENCODER_TYPE_HDMI0;
>         vc4_hdmi->pdev = pdev;
> @@ -1362,7 +1363,28 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
>  {
>         struct drm_device *drm = dev_get_drvdata(master);
>         struct vc4_dev *vc4 = drm->dev_private;
> -       struct vc4_hdmi *vc4_hdmi = vc4->hdmi;
> +       struct vc4_hdmi *vc4_hdmi;
> +
> +       /*
> +        * ASoC makes it a bit hard to retrieve a pointer to the
> +        * vc4_hdmi structure. Registering the card will overwrite our
> +        * device drvdata with a pointer to the snd_soc_card structure,
> +        * which can then be used to retrieve whatever drvdata we want
> +        * to associate.
> +        *
> +        * However, that doesn't fly in the case where we wouldn't
> +        * register an ASoC card (because of an old DT that is missing
> +        * the dmas properties for example), then the card isn't
> +        * registered and the device drvdata wouldn't be set.
> +        *
> +        * We can deal with both cases by making sure a snd_soc_card
> +        * pointer and a vc4_hdmi structure are pointing to the same
> +        * memory address, so we can treat them indistinctly without any
> +        * issue.
> +        */
> +       BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) != 0);
> +       BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) != 0);
> +       vc4_hdmi = dev_get_drvdata(dev);
>
>         cec_unregister_adapter(vc4_hdmi->cec_adap);
>         vc4_hdmi_connector_destroy(&vc4_hdmi->connector.base);
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 749a807cd1f3..d43462789450 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -53,13 +53,13 @@ struct vc4_hdmi_audio {
>
>  /* General HDMI hardware state. */
>  struct vc4_hdmi {
> +       struct vc4_hdmi_audio audio;
> +
>         struct platform_device *pdev;
>
>         struct vc4_hdmi_encoder encoder;
>         struct vc4_hdmi_connector connector;
>
> -       struct vc4_hdmi_audio audio;
> -
>         struct i2c_adapter *ddc;
>         void __iomem *hdmicore_regs;
>         void __iomem *hd_regs;
> --
> git-series 0.9.1
