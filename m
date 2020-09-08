Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD0C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E9E20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8/Cm5SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgIHSfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbgIHSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:35:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF06C061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:35:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so11680660pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=E2vQ4j8MCVU3HUG4FesnKAfpUPuoFei5xwviweF/Jkc=;
        b=A8/Cm5SAiCk+X9euHqXmlnVbhDyvM43YhtgFOH45nnhE128vdpoyhX6fLIWQjxkPPj
         Ghj5bkGAU3n0c8di9QFlbAuhND9e3zEA8qPROVlslGptxicwtozSNWntZKBoLt9UkxUS
         6xtyTmw6h1dzYydv9Z1EGSrwJR8kE5ekSrki0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=E2vQ4j8MCVU3HUG4FesnKAfpUPuoFei5xwviweF/Jkc=;
        b=FqxX3eQdC327AQkoix6UZS1mHiQf5uAURGyXuwDPN8DNzc1idpfTlt7jJobyNrOaoB
         Csq2CwimJi2VOAJrl2YJMu6db2UyH87prFATl8hlpul/NE1p52EWRo0uLONv6U7/iC5z
         AGPwRnHo624ncUaFqC3CRDcPq5gLdSmt/3/7ASQSvUZKbbvb5Z7L82IzjZ6LvABiVRsQ
         5pxalUe07PpP8H3aRKcYfNEysvyIspf+7+uTCiknSj07+3RVmM0CfbtaKgTbaTa7TYe0
         aLwx1uDfDP18yjDWXokE5Yirj2JpNhE1djH62BKv7pN8cEH036FWuSclzcFQvLCyO1v9
         dS/g==
X-Gm-Message-State: AOAM532+IQ7mIcbfybE/YxoYL4INEgw9ehivUgAbTum9yqJ5M3naadqj
        +ES4Q4XbR83bmC7lZM8034S/zbc1sB0ccA==
X-Google-Smtp-Source: ABdhPJxagMwsWahh7Pg0UcI3i2Yd33Y3kBmfW2ArSA5YslR0vvVLJV0PZRIvG78rkdJDqbMA1gF6cA==
X-Received: by 2002:a17:902:6902:b029:d0:cb2d:f26d with SMTP id j2-20020a1709026902b02900d0cb2df26dmr447444plk.6.1599590110647;
        Tue, 08 Sep 2020 11:35:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q4sm122755pfs.193.2020.09.08.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:35:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1599536645-4593-1-git-send-email-mansur@codeaurora.org>
References: <1599536645-4593-1-git-send-email-mansur@codeaurora.org>
Subject: Re: [PATCH 1/2] venus: core: change clk enable and disable order in resume and suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Tue, 08 Sep 2020 11:35:08 -0700
Message-ID: <159959010893.454335.18221321331314189759@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mansur Alisha Shaik (2020-09-07 20:44:05)
> Currently video driver is voting after clk enable and un voting
> before clk disable. Basically we should vote before clk enable
> and un vote after clk disable.
>=20
> Corrected this by changing the order of clk enable and clk disable.
>=20
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---

Any Fixes: tag?

>  drivers/media/platform/qcom/venus/core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/pla=
tform/qcom/venus/core.c
> index c5af428..4857bbd 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -363,13 +363,16 @@ static __maybe_unused int venus_runtime_suspend(str=
uct device *dev)
>         if (ret)
>                 return ret;
> =20
> +       if (pm_ops->core_power) {
> +               ret =3D pm_ops->core_power(dev, POWER_OFF);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         ret =3D icc_set_bw(core->cpucfg_path, 0, 0);
>         if (ret)
>                 return ret;

Shouldn't we power it back up if this fails during suspend?

> =20
> -       if (pm_ops->core_power)
> -               ret =3D pm_ops->core_power(dev, POWER_OFF);
> -
>         return ret;
>  }
>
