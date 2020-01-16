Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D00C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9168A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knhaeNzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgAPNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:51:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAPNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:51:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3860416wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sBKxZFH898/wPXV71wW0NyyNDJwLXVbTXicYkvKmNzw=;
        b=knhaeNzYZRByMT3EqSacj4ghD3nw5vQsUBx1AqPb8euhdVIB1Z4ZH8ElmhGTh7PbPh
         7a1OTTEm8stqQ0bR9UTXryeNamhmrOFZXuAuOUeSqg6/tAhH42XDGcVOLC9wuJ2g6ZgP
         nGnCrL4P5inu+bXJ3IIRdceGtstCvs5c6I+M0RL/1+zSVAqhB8WekD1+fM3RrrN7DYF8
         HhVLSXIzxg/aKsUSbbceUohZVKTRN7//Pt5OqoiA4Lx4qq65igHAHVA//N9zB8l60s2B
         V+bVA2rVWoDYJKU4Hf9fCwOyjrxaRsBLpc2i+hNVnOx5bgTEzELbih+/wplrv/Qmzi1G
         TFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sBKxZFH898/wPXV71wW0NyyNDJwLXVbTXicYkvKmNzw=;
        b=RzFx4QyJrenscE6/YGnKFYOwsCYE9MCANpPw3CuQ2TJL7TynsHgNun5G6fcJDcd5sX
         zeVBGc76JKkuyHywmm2sipwY4BENE1GSlbD1/9Huv8xmThYiWpqdqpgkhxq0kY9nYyvP
         aZXMuMRIrEeaPa0WTqP8QlklYlDtNYDeDbMVU1s7bPQnBFu8p7r1Qf6j7ccaNZLSCAF5
         eEq9VpR/MoI+Os9hQ5pem74pmimaWGpoR2ipibMpsGZcTYE4D7uqr8BtTU4DJtQRMSyt
         sz1datUxnPsO+9zpvUpkYK9lYNHVwrXTM5r0ZymGBPh3Bo+okCBBFJDluAoczM0OXCIu
         mIWg==
X-Gm-Message-State: APjAAAXSfWOpGgawEs+Oxu4bPa+qXIbBgGsCIHKS+BKM3/MhAxR2M3oy
        q5u8PboB+FPo5lWoepz2WbfyFfFOFtg=
X-Google-Smtp-Source: APXvYqymU0divr8VXpn633DmpUyOARV/tjLHEZgmWE7iKEiJ2OiS2xYXbP6ESjULa9Jhz6g8/11sJg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr6004751wmi.178.1579182709462;
        Thu, 16 Jan 2020 05:51:49 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id l17sm28172234wro.77.2020.01.16.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:51:48 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:52:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, baolin.wang@unisoc.com,
        kevin.tang@unisoc.com, chunyan.zhang@unisoc.com,
        liangcai.fan@unisoc.com
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200116135207.GS325@dell>
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Orson Zhai wrote:

> There are a lot of similar global registers being used across multiple SoCs
> from Unisoc. But most of these registers are assigned with different offset
> for different SoCs. It is hard to handle all of them in an all-in-one
> kernel image.
> 
> Add a helper function to get regmap with arguments where we could put some
> extra information such as the offset value.
> 
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> ---
>  drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h | 14 ++++++++++++++
>  2 files changed, 43 insertions(+)

Something really odd is happening when I try to apply this patch.

Patchwork doesn't like it either.

Could you please rebase it and re-send using `git send-mail`, thanks.

Also apply my and Arnd's Ack when re-sending.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index e22197c..2918b05 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -224,6 +224,35 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
> 
> +struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args)
> +{
> +       struct device_node *syscon_np;
> +       struct of_phandle_args args;
> +       struct regmap *regmap;
> +       unsigned int index;
> +       int rc;
> +
> +       rc = of_parse_phandle_with_fixed_args(np, property, arg_count,
> +                       0, &args);
> +       if (rc)
> +               return ERR_PTR(rc);
> +
> +       syscon_np = args.np;
> +       if (!syscon_np)
> +               return ERR_PTR(-ENODEV);
> +
> +       regmap = syscon_node_to_regmap(syscon_np);
> +       for (index = 0; index < arg_count; index++)
> +               out_args[index] = args.args[index];
> +       of_node_put(syscon_np);
> +
> +       return regmap;
> +}
> +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
> +
>  static int syscon_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index 112dc66..714cab1 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -23,6 +23,11 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
>  extern struct regmap *syscon_regmap_lookup_by_phandle(
>                                         struct device_node *np,
>                                         const char *property);
> +extern struct regmap *syscon_regmap_lookup_by_phandle_args(
> +                                       struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args);
>  #else
>  static inline struct regmap *device_node_to_regmap(struct device_node *np)
>  {
> @@ -45,6 +50,15 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
>  {
>         return ERR_PTR(-ENOTSUPP);
>  }
> +
> +static struct regmap *syscon_regmap_lookup_by_phandle_args(
> +                                       struct device_node *np,
> +                                       const char *property,
> +                                       int arg_count,
> +                                       unsigned int *out_args)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
>  #endif
> 
>  #endif /* __LINUX_MFD_SYSCON_H__ */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
