Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E8720758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj1lurMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgGTFne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:43:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14DC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:43:33 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x13so7828457vsx.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 22:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbLapiGcJOFTbUyK//8Fe9PD8yV2JZi5AG9HjtvvQrA=;
        b=jj1lurMJabflLy5RgODdvDSsqwg4LNBBvV2vJXasXqtYgo0+msjC1M2ABFQX2Hx0S5
         JWRrVYPqvC6wx21kAa9FwFts+z6ojJytWWnpeK0SPmUSZortpePdjvlDiVu2PQnIcM/S
         RsUIgoiQLAjSFOnQgadcWhqlix+fY4oThTwOJ95eghx9hxzF/NUGG347CBv/+2yQSd2v
         ac9XPl9rkZpSEFqgHhK8ffVqcCUvfCEJJrDtuVT7HWHQWYx2YFmBfbM4G/hJweli/Zfn
         ikouE1LntmptRTsrCvV19wZcTWEEsvSGyw+TAA5K/N07kmoqvT275Vq1a5AhRZS47OcC
         FtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbLapiGcJOFTbUyK//8Fe9PD8yV2JZi5AG9HjtvvQrA=;
        b=Ci4BS8YV0ixabw/XIj8+T/rZdBiia9rWHT/NmlSbH/WZaUPdUerozdSGaV7cbi7yBR
         pCI9kAtE6Jsd/rpQzcet46bdNvILxf9wFiIxhGo86oiWe/xOOpccK3bNfcpilV6RqnEn
         oisagquP3BEqOLodb2lqCc73chwTAF/afOHQd1oPEVkeuHBPQZ63tClAAXh+aX8JoZGv
         9OJRbMSNQoEsOUcEarytW7X4OkJacQc4Eqw72UXoft5n+FayRY+iu0oCOlVxCBxHV+xa
         S+mYUElTYpWnyGXmeDKhnv+Zxg+QIB/pPEO+Tq3LqRVVeRT4AaQylWT0FDAAvf6IsIuj
         fSRw==
X-Gm-Message-State: AOAM531YOvSYXB+12xKxzAxKq9KsigKoGLFzibjxuwnWvYWDARY0iCX+
        NKOpgDa1yREdFeaNw1ZhKZegyVCfixWccrKDRWgaqQ==
X-Google-Smtp-Source: ABdhPJyjgOlgkreB2uvU8zXbH7F+KFhG4EFoZL6NjUMOyUv9H1nqnfOF2ArdbefVQmvPiC+CFEQwocwOCYmxkSO99Cg=
X-Received: by 2002:a67:2285:: with SMTP id i127mr14138213vsi.159.1595223812879;
 Sun, 19 Jul 2020 22:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200717164217.18819-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200717164217.18819-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 20 Jul 2020 11:13:21 +0530
Message-ID: <CAHLCerNfKGmEz9g98VA6iMYy7MjfwfH=gaF9KR0o_qpJwFPekA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: netlink: Improve the initcall ordering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The initcalls like to play joke. In our case, the thermal-netlink
> initcall is called after the thermal-core initcall but this one sends
> a notification before the former is initialzed. No issue was spotted,

typo: initialized

> but it could lead to a memory corruption, so instead of relying on the
> core_initcall for the thermal-netlink, let's initialize directly from
> the thermal-core init routine, so we have full control of the init
> ordering.

> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.c    | 4 ++++
>  drivers/thermal/thermal_netlink.c | 3 +--
>  drivers/thermal/thermal_netlink.h | 6 ++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 25ef29123f72..c2e7d7aaa354 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1581,6 +1581,10 @@ static int __init thermal_init(void)
>  {
>         int result;
>
> +       result = thermal_netlink_init();
> +       if (result)
> +               goto error;
> +
>         mutex_init(&poweroff_lock);
>         result = thermal_register_governors();
>         if (result)
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index dd0a3b889674..42eace7401da 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -641,8 +641,7 @@ static struct genl_family thermal_gnl_family __ro_after_init = {
>         .n_mcgrps       = ARRAY_SIZE(thermal_genl_mcgrps),
>  };
>
> -static int __init thermal_netlink_init(void)
> +int __init thermal_netlink_init(void)
>  {
>         return genl_register_family(&thermal_gnl_family);
>  }
> -core_initcall(thermal_netlink_init);
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index 0ec28d105da5..828d1dddfa98 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -6,6 +6,7 @@
>
>  /* Netlink notification function */
>  #ifdef CONFIG_THERMAL_NETLINK
> +int __init thermal_netlink_init(void);
>  int thermal_notify_tz_create(int tz_id, const char *name);
>  int thermal_notify_tz_delete(int tz_id);
>  int thermal_notify_tz_enable(int tz_id);
> @@ -23,6 +24,11 @@ int thermal_notify_cdev_delete(int cdev_id);
>  int thermal_notify_tz_gov_change(int tz_id, const char *name);
>  int thermal_genl_sampling_temp(int id, int temp);
>  #else
> +static inline int thermal_netlink_init(void)
> +{
> +       return 0;
> +}
> +
>  static inline int thermal_notify_tz_create(int tz_id, const char *name)
>  {
>         return 0;
> --
> 2.17.1
>
