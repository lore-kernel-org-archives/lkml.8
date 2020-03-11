Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA2C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92EB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="m2BRj4/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCKI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:59:46 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46970 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:59:46 -0400
Received: by mail-ua1-f67.google.com with SMTP id b2so421427uas.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+zVi+hAGykkkswrTz5Xe5bLUAkAvEDlo5d1jlqeg9c=;
        b=m2BRj4/txpDGqaCLUmLGEPNi9gS2KHP1x6CM1J5hj1cuQjpCip+JzZvcgyDGMmVpW9
         Zt+mGMMdL/OoureU/WAMi36vaoP4kMHmSX2k1YKKvMlxnMCoyUrag6Wh3neZg9zFI6e3
         1oEJlUQW+TdZ+snNkRLo3uh5i6IjJKph2+ILmxnq07E3q3RLeseohWFo4z9a6FNgiCRZ
         WEMA/xyfjjZJcZexIfANydAAa8f9q49nHTblW/CUcgQp+IM0ocOrcvb42zfwS60W+Asi
         nICga+QT5D5H3EHWwbdMdwAioY7G211/dg6Xv9Thr8DXsxATaskhRtJdsSm/qUd5KaKY
         fm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+zVi+hAGykkkswrTz5Xe5bLUAkAvEDlo5d1jlqeg9c=;
        b=o3l32IgXrb30yv/XDXB7YoP3JQO3HDwO+wBG11TulfQBcFEUNx9DWFeCtIdWYr+wnn
         JfWHx6heFh3yi0Z1o6sdAthjq4iecfbyChSzMiIBTaAPCnd325txKSOjZMiURWjdf8fy
         uA/XZMvYuxp9x+EGVu/BHEZF47+yjapBxxc6m1aElrfW7I1h60zs0rdK21xt0OEhX3ST
         M+y9vw6lHJQHgJPaLzbJkgJIFZV4MneKUXnMi7Dp4Oc/nxv/LLBIcdB1HeqzVXk3sY1X
         3CnEuT9PUR7OkSPBk0w6ieKoEO+2wqlzQm7j1JdUqLz+LYr5uYteJYJumYnAt6JlnfjG
         AYGA==
X-Gm-Message-State: ANhLgQ2WuzYAOjBZd98XJDGwSSDbE5ZtONXO4CjsTCj36gXh761Qxjmb
        Pa45WKoe6gzMORH0fjZ8mbSsawfLsT4MPdiypv7gWA==
X-Google-Smtp-Source: ADFU+vtvvedKlu0toUhUkrGSFTRN8Mq11WHrNu2FyqKg7H0jG7F1Sfs4pw5wcYf+d+IIrZAT5cIZ5p8de2pmfQPMytg=
X-Received: by 2002:ab0:1849:: with SMTP id j9mr928295uag.77.1583917183825;
 Wed, 11 Mar 2020 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 11 Mar 2020 14:29:32 +0530
Message-ID: <CAHLCerNQSrNdmPbgLLiTN9_kE-x4xTnBWVnC0-ewQfferG+6Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: qoriq: Use devm_add_action_or_reset() to
 handle all cleanups
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:44 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Use devm_add_action_or_reset() to handle all cleanups of failure in
> .probe and .remove, then .remove callback can be dropped.


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 874bc46..67a8d84 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -228,6 +228,14 @@ static const struct regmap_access_table qoriq_rd_table = {
>         .n_yes_ranges   = ARRAY_SIZE(qoriq_yes_ranges),
>  };
>
> +static void qoriq_tmu_action(void *p)
> +{
> +       struct qoriq_tmu_data *data = p;
> +
> +       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> +       clk_disable_unprepare(data->clk);
> +}
> +
>  static int qoriq_tmu_probe(struct platform_device *pdev)
>  {
>         int ret;
> @@ -278,6 +286,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
> +       if (ret)
> +               return ret;
> +
>         /* version register offset at: 0xbf8 on both v1 and v2 */
>         ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
>         if (ret) {
> @@ -290,35 +302,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>
>         ret = qoriq_tmu_calibration(dev, data); /* TMU calibration */
>         if (ret < 0)
> -               goto err;
> +               return ret;
>
>         ret = qoriq_tmu_register_tmu_zone(dev, data);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to register sensors\n");
> -               ret = -ENODEV;
> -               goto err;
> +               return ret;
>         }
>
>         platform_set_drvdata(pdev, data);
>
>         return 0;
> -
> -err:
> -       clk_disable_unprepare(data->clk);
> -
> -       return ret;
> -}
> -
> -static int qoriq_tmu_remove(struct platform_device *pdev)
> -{
> -       struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
> -
> -       /* Disable monitoring */
> -       regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
> -
> -       clk_disable_unprepare(data->clk);
> -
> -       return 0;
>  }
>
>  static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
> @@ -365,7 +359,6 @@ static struct platform_driver qoriq_tmu = {
>                 .of_match_table = qoriq_tmu_match,
>         },
>         .probe  = qoriq_tmu_probe,
> -       .remove = qoriq_tmu_remove,
>  };
>  module_platform_driver(qoriq_tmu);
>
> --
> 2.7.4
>
