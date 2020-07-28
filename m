Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C3C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDEF206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="l/a67glz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgG1NXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgG1NXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:23:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:23:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so8309421wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVbcnjfZmdkWTayIDxfBVMqVlu5cuT3hIbVqa5TR/1k=;
        b=l/a67glzcc5AQ6/acG9FVfC2RJtuuPIoD5fiBv6VDXxVCxLzRofZr6tYMAwi+RVHqm
         LGGNIJtTApsfJEtkxt8+co8EYg8e5E96j18GWe26DOsYoViYehCeJJ/1iS5JJYTbd//5
         IEHnkwXARfBE2T/UoQK5VCeWULGDKZJogO5bgWkg99ghHE/mD0VbeKmM1lubsgCGG9B6
         1AyJ43cy0a2fFoMAzNjN2mfE5sgSwzaDeVq8KfcpD20QumElze+rGxRJAwHC4+0iLN4Y
         us/t3V0t9pz59c2lhHJ4wpguDVfuP87u6b6FmOac7lDFRT2jzv7X/TiNWfZOkDYf37mR
         KB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVbcnjfZmdkWTayIDxfBVMqVlu5cuT3hIbVqa5TR/1k=;
        b=fdhb1csUvl5YTjaX0HkS1Se5C3Y1CNluq/8OhRtUxjD0xS4Y5CCf3bLhUuDmO6Y7VX
         SHHq0eq0/nnvXGv0OlA0nNsBdf9Rj4McScJQBdAt/fAJQLahLQuFPWWN0ui8oRNQx+tE
         D7ekd5rGsXlH4Og1dkTvmNU1U3cFTiauo7+Chn9qyepD9rmq5i/qI4gFutGG5mzgD3ZC
         kyXyffIVMMRB6p3RQkWHVOCyxY2YBFlWnwtbkhoUYAEZdgudMx0YqvQ3nU3jqxFXkbCQ
         LMBxhoOOwLr/RXhl8fal2Cyfr/MSg46NTsCorp0++m8DB4QdzomFzF0w7BDJr2x4cJEE
         BuBQ==
X-Gm-Message-State: AOAM531z0pJ/BPKFRUPOwJhcrcLarbTjf8YORRpUFtWUo6W2i6GkEgV2
        ktUBlIfx1HqVUQQKtoe9iUMRAR2EuDnmfb+wC2lc3A==
X-Google-Smtp-Source: ABdhPJwKPzvOdxA6F4ifxZqzfCce2ctRWLCLhUEwv66hHxbniZKHfhme5B/iZKhFoSzPnF3OSINLAaKUATFpgkpPCWE=
X-Received: by 2002:adf:fe50:: with SMTP id m16mr7606176wrs.27.1595942613862;
 Tue, 28 Jul 2020 06:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <1b459f691ed99dcae2cea07e23ec1f5dd39837be.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <1b459f691ed99dcae2cea07e23ec1f5dd39837be.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:23:17 +0100
Message-ID: <CAPY8ntC6=QO1wsEOj+c-nnJ4EHPaeUhRgAvE9gcWVv9KQbniKA@mail.gmail.com>
Subject: Re: [PATCH v4 58/78] drm/vc4: hdmi: Move CEC init to its own function
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
> The CEC init code was put directly into the bind function, which was quite
> inconsistent with how the audio support was done, and would prevent us from
> further changes to skip that initialisation entirely.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 108 +++++++++++++++++++++-------------
>  1 file changed, 67 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index ef51eedaf75a..8cd08b541c14 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1171,6 +1171,67 @@ static const struct cec_adap_ops vc4_hdmi_cec_adap_ops = {
>         .adap_log_addr = vc4_hdmi_cec_adap_log_addr,
>         .adap_transmit = vc4_hdmi_cec_adap_transmit,
>  };
> +
> +static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
> +{
> +       struct cec_connector_info conn_info;
> +       struct platform_device *pdev = vc4_hdmi->pdev;
> +       u32 value;
> +       int ret;
> +
> +       vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
> +                                                 vc4_hdmi, "vc4",
> +                                                 CEC_CAP_DEFAULTS |
> +                                                 CEC_CAP_CONNECTOR_INFO, 1);
> +       ret = PTR_ERR_OR_ZERO(vc4_hdmi->cec_adap);
> +       if (ret < 0)
> +               return ret;
> +
> +       cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
> +       cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
> +
> +       HDMI_WRITE(HDMI_CEC_CPU_MASK_SET, 0xffffffff);
> +       value = HDMI_READ(HDMI_CEC_CNTRL_1);
> +       value &= ~VC4_HDMI_CEC_DIV_CLK_CNT_MASK;
> +       /*
> +        * Set the logical address to Unregistered and set the clock
> +        * divider: the hsm_clock rate and this divider setting will
> +        * give a 40 kHz CEC clock.
> +        */
> +       value |= VC4_HDMI_CEC_ADDR_MASK |
> +                (4091 << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
> +       HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
> +       ret = devm_request_threaded_irq(&pdev->dev, platform_get_irq(pdev, 0),
> +                                       vc4_cec_irq_handler,
> +                                       vc4_cec_irq_handler_thread, 0,
> +                                       "vc4 hdmi cec", vc4_hdmi);
> +       if (ret)
> +               goto err_delete_cec_adap;
> +
> +       ret = cec_register_adapter(vc4_hdmi->cec_adap, &pdev->dev);
> +       if (ret < 0)
> +               goto err_delete_cec_adap;
> +
> +       return 0;
> +
> +err_delete_cec_adap:
> +       cec_delete_adapter(vc4_hdmi->cec_adap);
> +
> +       return ret;
> +}
> +
> +static void vc4_hdmi_cec_exit(struct vc4_hdmi *vc4_hdmi)
> +{
> +       cec_unregister_adapter(vc4_hdmi->cec_adap);
> +}
> +#else
> +static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
> +{
> +       return 0;
> +}
> +
> +static void vc4_hdmi_cec_exit(struct vc4_hdmi *vc4_hdmi) {};
> +
>  #endif
>
>  static int vc4_hdmi_build_regset(struct vc4_hdmi *vc4_hdmi,
> @@ -1250,9 +1311,6 @@ static int vc4_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
>
>  static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  {
> -#ifdef CONFIG_DRM_VC4_HDMI_CEC
> -       struct cec_connector_info conn_info;
> -#endif
>         const struct vc4_hdmi_variant *variant = of_device_get_match_data(dev);
>         struct platform_device *pdev = to_platform_device(dev);
>         struct drm_device *drm = dev_get_drvdata(master);
> @@ -1332,43 +1390,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         if (ret)
>                 goto err_destroy_encoder;
>
> -#ifdef CONFIG_DRM_VC4_HDMI_CEC
> -       vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
> -                                                 vc4_hdmi, "vc4",
> -                                                 CEC_CAP_DEFAULTS |
> -                                                 CEC_CAP_CONNECTOR_INFO, 1);
> -       ret = PTR_ERR_OR_ZERO(vc4_hdmi->cec_adap);
> -       if (ret < 0)
> -               goto err_destroy_conn;
> -
> -       cec_fill_conn_info_from_drm(&conn_info, &vc4_hdmi->connector);
> -       cec_s_conn_info(vc4_hdmi->cec_adap, &conn_info);
> -
> -       HDMI_WRITE(HDMI_CEC_CPU_MASK_SET, 0xffffffff);
> -       value = HDMI_READ(HDMI_CEC_CNTRL_1);
> -       value &= ~VC4_HDMI_CEC_DIV_CLK_CNT_MASK;
> -       /*
> -        * Set the logical address to Unregistered and set the clock
> -        * divider: the hsm_clock rate and this divider setting will
> -        * give a 40 kHz CEC clock.
> -        */
> -       value |= VC4_HDMI_CEC_ADDR_MASK |
> -                (4091 << VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
> -       HDMI_WRITE(HDMI_CEC_CNTRL_1, value);
> -       ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
> -                                       vc4_cec_irq_handler,
> -                                       vc4_cec_irq_handler_thread, 0,
> -                                       "vc4 hdmi cec", vc4_hdmi);
> +       ret = vc4_hdmi_cec_init(vc4_hdmi);
>         if (ret)
> -               goto err_delete_cec_adap;
> -       ret = cec_register_adapter(vc4_hdmi->cec_adap, dev);
> -       if (ret < 0)
> -               goto err_delete_cec_adap;
> -#endif
> +               goto err_destroy_conn;
>
>         ret = vc4_hdmi_audio_init(vc4_hdmi);
>         if (ret)
> -               goto err_destroy_encoder;
> +               goto err_free_cec;
>
>         vc4_debugfs_add_file(drm, variant->debugfs_name,
>                              vc4_hdmi_debugfs_regs,
> @@ -1376,12 +1404,10 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>
>         return 0;
>
> -#ifdef CONFIG_DRM_VC4_HDMI_CEC
> -err_delete_cec_adap:
> -       cec_delete_adapter(vc4_hdmi->cec_adap);
> +err_free_cec:
> +       vc4_hdmi_cec_exit(vc4_hdmi);
>  err_destroy_conn:
>         vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
> -#endif
>  err_destroy_encoder:
>         drm_encoder_cleanup(encoder);
>  err_unprepare_hsm:
> @@ -1422,7 +1448,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
>         kfree(vc4_hdmi->hdmi_regset.regs);
>         kfree(vc4_hdmi->hd_regset.regs);
>
> -       cec_unregister_adapter(vc4_hdmi->cec_adap);
> +       vc4_hdmi_cec_exit(vc4_hdmi);
>         vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
>         drm_encoder_cleanup(&vc4_hdmi->encoder.base.base);
>
> --
> git-series 0.9.1
