Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29E020809
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejEGGvg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgG1I3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgG1I3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:29:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BC7C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:29:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so10537427pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yZsNfus+6QxB/2Q1/ypFJuiPTGp9cOvML6i0dLAUdac=;
        b=ejEGGvg9afWN+1y9f+oMsCwu34xhvRkvayj6gOjnrHe4jy2EJmceBZ2vFQgag+khsr
         7ca5BnlFiO+UHKZ0RNKBKkA1WHQpIHiOKR/m0ToBWXQYAxkklg2OlXj3fMIQVtqKE3lD
         JI++O+B2lfF/GMviF5c2JM+7LUjRI2SElFT/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yZsNfus+6QxB/2Q1/ypFJuiPTGp9cOvML6i0dLAUdac=;
        b=ZlXWeHA22U6Yq4/h/RuPl7QzZiNlea3+/D2INSfZmBfc2CP6ZXSitaWdvqYBhjUgPg
         TT3uNfP5CYff1Mz9x6w6jtz7wiLuAGqV9VtGu0LlhKH0CT+M/fD24XynL/GM1ZZH8v1H
         r6Cel4pMDqj84sx0QTZcjlFuMr/fKVd1CXi438JXrEoksP1m+2P4tlg8QgTY8Ewebm7v
         Yba/lwk8BokNfkeO+Jtq8Hstx/IVYGeDHxc9gMo13mqxiILEXtxSYGFjF0+X7WYvq9FL
         xxuWB8FhMGzwZZ1SaVPR38ke5VIrVnIZMUulqKTLU94Ex5Rzx+JNAycezeiPt76e5cDI
         p8Vg==
X-Gm-Message-State: AOAM533hB4FPG5M06za3yy28Gewf+Ew4KUJB9IfrE8Km6Ql8/peHm8QT
        G2kNDvMruKyNkghuxTX8YHf/Ow==
X-Google-Smtp-Source: ABdhPJyW9jUuaOyVc/e8KZvS6QCn6ltABXxe0vW3hPZVBAQOy7+lfoVizNyt8xrxJoHZ7VqHTpvdsg==
X-Received: by 2002:aa7:91cd:: with SMTP id z13mr24700924pfa.133.1595924948476;
        Tue, 28 Jul 2020 01:29:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id v28sm18481742pgn.81.2020.07.28.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:29:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728075102.30807-1-saiprakash.ranjan@codeaurora.org>
References: <20200728075102.30807-1-saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2] coresight: etm4x: Fix etm4_count race by moving cpuhp callbacks to init
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Date:   Tue, 28 Jul 2020 01:29:06 -0700
Message-ID: <159592494608.1360974.13925720722764973592@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-07-28 00:51:02)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtr=
acing/coresight/coresight-etm4x.c
> index 6d7d2169bfb2..adb71987a1e3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -48,8 +48,6 @@ module_param(pm_save_enable, int, 0444);
>  MODULE_PARM_DESC(pm_save_enable,
>         "Save/restore state on power down: 1 =3D never, 2 =3D self-hosted=
");
> =20
> -/* The number of ETMv4 currently registered */
> -static int etm4_count;
>  static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
>  static void etm4_set_default_config(struct etmv4_config *config);
>  static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
> @@ -1403,12 +1401,9 @@ static int etm4_pm_setup_cpuslocked(void)

Is this only called from __init now? If so please mark it as __init
then.

>  {
>         int ret;
> =20
> -       if (etm4_count++)
> -               return 0;
> -
>         ret =3D cpu_pm_register_notifier(&etm4_cpu_pm_nb);
>         if (ret)
> -               goto reduce_count;
> +               return ret;
> =20
>         ret =3D cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ARM_CORESIG=
HT_STARTING,
>                                                    "arm/coresight4:starti=
ng",
> @@ -1432,17 +1427,11 @@ static int etm4_pm_setup_cpuslocked(void)
> =20
>  unregister_notifier:
>         cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
> -
> -reduce_count:
> -       --etm4_count;
>         return ret;
>  }
> =20
>  static void etm4_pm_clear(void)

This is __init too?

>  {
> -       if (--etm4_count !=3D 0)
> -               return;
> -
>         cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
>         cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
>         if (hp_online) {
> @@ -1598,4 +1576,29 @@ static struct amba_driver etm4x_driver =3D {
>         .probe          =3D etm4_probe,
>         .id_table       =3D etm4_ids,
>  };
> -builtin_amba_driver(etm4x_driver);
> +
> +static int __init etm4x_init(void)
> +{
> +       int ret;
> +
> +       cpus_read_lock();
> +       ret =3D etm4_pm_setup_cpuslocked();
> +       cpus_read_unlock();
> +
> +       /* etm4_pm_setup_cpuslocked() does its own cleanup - exit on erro=
r */
> +       if (ret)
> +               return ret;
> +
> +       ret =3D amba_driver_register(&etm4x_driver);
> +       if (ret) {
> +               pr_info("Error registering etm4x driver\n");

Use pr_err() please.

> +               goto err_init;
> +       }
> +
> +       return ret;
> +
> +err_init:

Why is this a goto?

> +       etm4_pm_clear();
> +       return ret;

Instead of just putting this in the if (ret) arm?

> +}
> +module_init(etm4x_init);

It was device_initcall before with builtin_amba_driver(), best to not
change that.
