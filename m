Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42845C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEA920656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgqabAXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgBTAFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:05:40 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54528 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBTAFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:05:40 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so77711pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=10lwg6uQFk9Fjbej0HWmFQxET16K1NofvVmMfuiw36Q=;
        b=lgqabAXOogpxmjlTPgJ/ZaVRlPIrbrYTEsDdU+AnT8v2wpjkFg/v6Ypr5hqqtCnNfz
         MM40vKyxgop8NzvE8PavjFbEH/+jYeDsRho2gUvShOIbdJVAvXwVxB9QVZ2+F+MwYbwi
         y+MowmEPQ0/uK9tlbl06j+wC6MTWucooZa4Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=10lwg6uQFk9Fjbej0HWmFQxET16K1NofvVmMfuiw36Q=;
        b=AL11WGaGJbMS1vEwTHe5QQ5LAzutwseGNoEAmuom3Gm4O2ZgjidB9qcK5mM5Vdga/l
         2pVnaS0MZak3yamO6Q2+IbyFtSO8Oa8cM4l28QJx5cjavto35A7kvk5GBNl26I/jN+1Y
         aZCrAn1AUWvEX9Fjwyca1KD0a2WwY2cCZyIS+ZYUIMPbIASCdVzOTBpkb9BBQgojeQgZ
         RDosLw0ERv3PHJJzGQQubujoSy7s7V4pyiP4qnlIxmLXCED7byPVDrD6yBAJdwpM+Ywr
         iiB2KBSUAoCv+fODA/25L+KeWOSsS31t0Sx3X9EXnmqphosmZGyVQbDsXZ0dXDw96E+7
         ncPQ==
X-Gm-Message-State: APjAAAWB7GQSIF3PRAAXQPdAGWJtQoGAu06Qo6p6+PP2uqzXzvnFypWr
        JtE+Rzkxm2uFm+hbSD2MPxSGyQ==
X-Google-Smtp-Source: APXvYqwZ8NgitDiitBhs6lgWgsYhTMQOwCdChYmIJHoXhKewLFums+ZzthZpPWhqFNhpzDH6sUkmXw==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr28811680pls.258.1582157138446;
        Wed, 19 Feb 2020 16:05:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r7sm774111pfg.34.2020.02.19.16.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:05:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4f5a4175371ac7973061cd4f9d19674ac308672c.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <4f5a4175371ac7973061cd4f9d19674ac308672c.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 5/8] drivers: thermal: tsens: Add critical interrupt support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 16:05:36 -0800
Message-ID: <158215713699.184098.4863049384855658604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:09)
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 0e7cf5236932..5b003d598234 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -125,6 +125,28 @@ static int tsens_register(struct tsens_priv *priv)
>                 goto err_put_device;
>         }
> =20
> +       if (priv->feat->crit_int) {
> +               irq_crit =3D platform_get_irq_byname(pdev, "critical");
> +               if (irq_crit < 0) {
> +                       ret =3D irq_crit;
> +                       /* For old DTs with no IRQ defined */
> +                       if (irq_crit =3D=3D -ENXIO)
> +                               ret =3D 0;
> +                       goto err_crit_int;
> +               }
> +               ret =3D devm_request_threaded_irq(&pdev->dev, irq_crit,
> +                                               NULL, tsens_critical_irq_=
thread,
> +                                               IRQF_ONESHOT,
> +                                               dev_name(&pdev->dev), pri=
v);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "%s: failed to get critical i=
rq\n", __func__);
> +                       goto err_crit_int;
> +               }
> +
> +               enable_irq_wake(irq_crit);
> +       }
> +
> +err_crit_int:

Why use a goto? Can't this be done with if-else statements?

       if (priv->feat->crit_int) {
               irq_crit =3D platform_get_irq_byname(pdev, "critical");
               if (irq_crit < 0) {
                       ...
               } else {
                       ret =3D devm_request_threaded_irq(&pdev->dev, irq_cr=
it,
                                                       NULL, tsens_critical=
_irq_thread,
                                                       IRQF_ONESHOT,
                                                       dev_name(&pdev->dev)=
, priv);
                       if (ret)
                               dev_err(&pdev->dev, "%s: failed to get criti=
cal irq\n", __func__);
                       else
                               enable_irq_wake(irq_crit);
               }
       }

Or if the nesting is so deep that we need goto labels then perhaps it
needs to be another function.

>         enable_irq_wake(irq);
> =20
>  err_put_device:
