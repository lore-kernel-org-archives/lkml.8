Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801BAC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570A8206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDtG40OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgDMLjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgDMLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:39:42 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:39:42 EDT
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8616C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:33:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so8944546ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5U6Bj9i0gIdPLwBp8umxYd6pZYRi0c0EHgLRbpxB/0g=;
        b=GDtG40OM3G/EoT7QXGL3chbN9AWZSWjjq58w7Ef6mKvOI4jF2oYjTEIUk0ru20aldK
         /lSfgXoAfrTHq2/Zo9Q7f/ysCmGmtaOqrTu7fMAFtiOLwN/fqMu4qk55reZNLOvr8Rj1
         qJaLn/09uXRJQVNh5TV8BxPepfyJfHB5lmzbYaZFvfgJa9gTI/RlP+z2USb4mT764Cea
         CdmShFIkekf/BGQ7gKW2h5UxBdaSvPcOnFIJVNJCaXR1/8/vsgMlUxzOCxIFQI6a51YL
         2UoCHKs5jI0D6Z6rluRrFAZaEZwt1F6TbqORC9VlcQoqqHm7ck19SyxR07sAflaAX9bq
         Kc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5U6Bj9i0gIdPLwBp8umxYd6pZYRi0c0EHgLRbpxB/0g=;
        b=n14yMkf7B0uFgDSEWoWVIBM/K0aPhx2QJvkzWekewLJpDWx5p+MG/RE0Ddrgz4kqfS
         WLMz3lfkcuoghDPtwSvH4thcz0hr5+EHwRq+GWgoBIkhOkAiMLDuUO0GqdmQIEOOx0wg
         YxX0TirLjiZEnR90ldhAW/MUYBsD8Q/cy8DA6u+p6e9DZ82Z6KNLM0Nf9KRmC2nhp3r2
         dWEU+xbPwLXG54qRtkcSEU+NpJLgjL+476KwOh7LseEzHXQyd/702C2ZR+e7UQqzOTuw
         IvX69FcK4z/7N1mcXHSMdEu6aNSFqZ1dJV2XoUxYGou/PlnnTq70KbpzQKAn5oVa4Rig
         yrhg==
X-Gm-Message-State: AGi0PubNYT15jqiKcV0nvMRMFBzVg6Qtub0z/F2aD5RfucQng2d1XhGr
        jnvJ2PhktEbXHKV44rUwiVnb9NoOsluX9WTR6js=
X-Google-Smtp-Source: APiQypJzjdhs6nLAwZfjeWYqnN0hdrSRFvDI0iSrW/3hMiqbzXHO6BNDEmKxFnIy8YsoiHy2E7nMG3suuYfOou9mllE=
X-Received: by 2002:a02:6a5c:: with SMTP id m28mr15207535jaf.144.1586777632939;
 Mon, 13 Apr 2020 04:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
In-Reply-To: <20200411200632.4045-2-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 13 Apr 2020 13:33:41 +0200
Message-ID: <CAJiuCcfOOwxSQkPg7MicKQovweSNu-VMpK3Ek4tJd1z4Jv6Jnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Panfrost and OPP Maintainers,

On Sat, 11 Apr 2020 at 22:06, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> OPP table can defined both frequency and voltage.
>
> Register the mali regulator if it exist.

After this patch, Panfrost update properly both voltage and frequency.
But the GPU is still not properly down-clocked when temperature is high.

I try to add a cooling map like this :
https://github.com/clementperon/linux/commit/955961c7c035abbf44e74f608fe8f0=
59c06a2fbe

But got the following error:
[    2.712082] panfrost 1800000.gpu: [drm:panfrost_devfreq_init
[panfrost]] Failed to register cooling device

Do you see what I'm missing?

Thanks for your help,
Clement



>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 34 ++++++++++++++++++---
>  drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index 62541f4edd81..2dc8e2355358 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,12 +78,26 @@ int panfrost_devfreq_init(struct panfrost_device *pfd=
ev)
>         struct device *dev =3D &pfdev->pdev->dev;
>         struct devfreq *devfreq;
>         struct thermal_cooling_device *cooling;
> +       const char *mali =3D "mali";
> +       struct opp_table *opp_table =3D NULL;
> +
> +       /* Regulator is optional */
> +       opp_table =3D dev_pm_opp_set_regulators(dev, &mali, 1);
> +       if (IS_ERR(opp_table)) {
> +               ret =3D PTR_ERR(opp_table);
> +               if (ret !=3D -ENODEV) {
> +                       DRM_DEV_ERROR(dev, "Failed to set regulator: %d\n=
", ret);
> +                       return ret;
> +               }
> +       }
> +       pfdev->devfreq.opp_table =3D opp_table;
>
>         ret =3D dev_pm_opp_of_add_table(dev);
> -       if (ret =3D=3D -ENODEV) /* Optional, continue without devfreq */
> -               return 0;
> -       else if (ret)
> -               return ret;
> +       if (ret) {
> +               if (ret =3D=3D -ENODEV) /* Optional, continue without dev=
freq */
> +                       ret =3D 0;
> +               goto err_opp_reg;
> +       }
>
>         panfrost_devfreq_reset(pfdev);
>
> @@ -119,6 +133,12 @@ int panfrost_devfreq_init(struct panfrost_device *pf=
dev)
>  err_opp:
>         dev_pm_opp_of_remove_table(dev);
>
> +err_opp_reg:
> +       if (pfdev->devfreq.opp_table) {
> +               dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> +               pfdev->devfreq.opp_table =3D NULL;
> +       }
> +
>         return ret;
>  }
>
> @@ -126,7 +146,13 @@ void panfrost_devfreq_fini(struct panfrost_device *p=
fdev)
>  {
>         if (pfdev->devfreq.cooling)
>                 devfreq_cooling_unregister(pfdev->devfreq.cooling);
> +
>         dev_pm_opp_of_remove_table(&pfdev->pdev->dev);
> +
> +       if (pfdev->devfreq.opp_table) {
> +               dev_pm_opp_put_regulators(pfdev->devfreq.opp_table);
> +               pfdev->devfreq.opp_table =3D NULL;
> +       }
>  }
>
>  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index 06713811b92c..f6b0c779dfe5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -86,6 +86,7 @@ struct panfrost_device {
>         struct {
>                 struct devfreq *devfreq;
>                 struct thermal_cooling_device *cooling;
> +               struct opp_table *opp_table;
>                 ktime_t busy_time;
>                 ktime_t idle_time;
>                 ktime_t time_last_update;
> --
> 2.20.1
>
