Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98701C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565DB2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 02:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScIMSWfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390422AbgDCC0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 22:26:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbgDCC0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 22:26:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so6751066wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 19:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qP4HMBtgJcP3marxCvlPQM9EFvKm/v0Fyiot+R1GsA=;
        b=ScIMSWfMnsrla8uAenHK1uo9zA/AEmGHi707UQmAtVeQVmrHa9Qsl/p2yb0UfP5R2A
         fm74AxgyRryOoRv+MCk2i+dBZmcBjHww2+tPdSGF+d7CgouoObzQZeFL6ecfXd4d8UqV
         1mnIXA/V8NFYMY9oa0THwurtkBKi355Lcv2QJ9e72p55LimTZWkc+A5OKDqFUMg5hy/h
         gIGen7WC/oY+KEGyFROi3ejILIotOdhbqWT2t42ZooFwZ1yWN/lzbpvC8sNColkimABE
         zU9uGEzvL0Es9e7KoIrWH6gjSblkqXOXmuwbdSovIrBfO5gMzmIfWMAP4XRqahwDt97y
         oM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qP4HMBtgJcP3marxCvlPQM9EFvKm/v0Fyiot+R1GsA=;
        b=OUrbUkBRyH5spR61Ar+79e6KiobtijDZPntIID6HCrjOSoN3SIzkgi/I1TeMTDATnp
         SNEH47pSxL5/utin8rva8Hk8CrhAAa0H8FJP/V1Qx482myMD55pRPUemPIT/ysr/f/Rz
         L13ceoDdoDutHct1rOMfZr5zr8wy7NfYuTMLDFgaCMwWty2K00zT7M4BXPs2QRsR9Pqo
         ZCGNDAuheloTAQOY4ngmBcLJZK6JJhzGYat3K0IBQ3Vz4pCYZopQMIcDigVExqnTndff
         Zes/pAlftqnolKdGa4b1r4eKmcunoYhbB71Jdrs3OUbBrfsgnMiJG/E7mKt72WWUuDNk
         V9Wg==
X-Gm-Message-State: AGi0PubDXmuvdhXB24eRZr60QLnr376oyDtFpqTSCOLg0wDPLw67iIbP
        iB68lvr6ZmgczY3YqBONjySSHZp/YpyYb7sHouwqRg==
X-Google-Smtp-Source: APiQypKNqjpq5zsdm7paTTwT5mrYSRaq+pPFJWnICDZB81b6LKwVd2z7s8iLBVPLFkgKpwY0frAVE0e2jJKwM9HNlTU=
X-Received: by 2002:a5d:5112:: with SMTP id s18mr6550112wrt.306.1585880773030;
 Thu, 02 Apr 2020 19:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <1583466184-7060-1-git-send-email-tiantao6@hisilicon.com> <1583466184-7060-5-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1583466184-7060-5-git-send-email-tiantao6@hisilicon.com>
From:   Xinliang Liu <xinliang.liu@linaro.org>
Date:   Fri, 3 Apr 2020 10:26:01 +0800
Message-ID: <CAKoKPbwgiFdvfLHXoD9wPJvJ5yzMMrxNEEJUArSEvNdx46+m9Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/hisilicon: Code cleanup for hibmc_drv_vdac
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Fri, 6 Mar 2020 at 11:44, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> code cleanup for hibmc_drv_vdac.c, no actual function changes.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 49 ++++++++----------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 678ac2e..f0e6bb8 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -52,32 +52,6 @@ static const struct drm_connector_funcs hibmc_connector_funcs = {
>         .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>
> -static struct drm_connector *
> -hibmc_connector_init(struct hibmc_drm_private *priv)
> -{
> -       struct drm_device *dev = priv->dev;
> -       struct drm_connector *connector;
> -       int ret;
> -
> -       connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
> -       if (!connector) {
> -               DRM_ERROR("failed to alloc memory when init connector\n");
> -               return ERR_PTR(-ENOMEM);
> -       }
> -
> -       ret = drm_connector_init(dev, connector,
> -                                &hibmc_connector_funcs,
> -                                DRM_MODE_CONNECTOR_VGA);
> -       if (ret) {
> -               DRM_ERROR("failed to init connector: %d\n", ret);
> -               return ERR_PTR(ret);
> -       }
> -       drm_connector_helper_add(connector,
> -                                &hibmc_connector_helper_funcs);
> -
> -       return connector;
> -}
> -
>  static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
>                                    struct drm_display_mode *mode,
>                                    struct drm_display_mode *adj_mode)
> @@ -109,13 +83,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>         struct drm_connector *connector;
>         int ret;
>
> -       connector = hibmc_connector_init(priv);
> -       if (IS_ERR(connector)) {
> -               DRM_ERROR("failed to create connector: %ld\n",
> -                         PTR_ERR(connector));
> -               return PTR_ERR(connector);
> -       }
> -
>         encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>         if (!encoder) {
>                 DRM_ERROR("failed to alloc memory when init encoder\n");
> @@ -131,6 +98,22 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>         }
>
>         drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
> +       connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
> +       if (!connector) {
> +               DRM_ERROR("failed to alloc memory when init connector\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = drm_connector_init(dev, connector,
> +                                &hibmc_connector_funcs,
> +                                DRM_MODE_CONNECTOR_VGA);
> +       if (ret) {
> +               DRM_ERROR("failed to init connector: %d\n", ret);
> +               return ret;
> +       }
> +
> +       drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
> +       drm_connector_register(connector);

You don't need to register a non-hotplug connector as it will be
registered at drm_dev_register automatically.

See function definition:

 488 /**
 489  * drm_connector_register - register a connector
 490  * @connector: the connector to register
 491  *
 492  * Register userspace interfaces for a connector. Only call this
for connectors
 493  * which can be hotplugged after drm_dev_register() has been
called already,
 494  * e.g. DP MST connectors. All other connectors will be
registered automatically
 495  * when calling drm_dev_register().
 496  *
 497  * Returns:
 498  * Zero on success, error code on failure.
 499  */
 500 int drm_connector_register(struct drm_connector *connector)
 501 {


Besides, I don't think this patch cleans much things.

-Xinliang

>         drm_connector_attach_encoder(connector, encoder);
>
>         return 0;
> --
> 2.7.4
>
