Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD122C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E5206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rR1Q3rqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgAQN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:27:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40650 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:27:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so7597386wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PIqkqiKX2cwutNpB3IcDLeAmmYCpWIuuH/Xtq02/cXc=;
        b=rR1Q3rqrJ4cKKTCGDv/Z5+Fo1P+ZQtT/d7HqveOFr2Au2QjnsmLyAcKww57wxeyek7
         IDhvOR1mjP1PmvxC24D1g98xZRBLBIs2S3sytFPHpb/HB31VXeCbATmp0zVZcs6pCuMz
         DogN4CFJDVX7+OBllKBz9dv2Nf2d0sjjzfmE74lsXPoLmjab8IYGS5wMq2QujmY5QZvX
         EJod2nowDsluwI78/vmERLmUYCdLQoGGQgIHLOGVsiPdOy/HIGkUNZt4Gv+1ntsjDuny
         M6klJkdgaegyCE96+DWOZI/8TIISXYlYWTYpr0RIDgP8llz6OVRGGke85ZJJUNJWoD3P
         mdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PIqkqiKX2cwutNpB3IcDLeAmmYCpWIuuH/Xtq02/cXc=;
        b=q8V8OtjowjEMAHa25sx+kzPXmAlv4Jcar94ked2wn2fJ5Lm3SgGMLoBO14pZMlUj6/
         cj+kyHi3g4mpJyXRqlDbLj7ZwSbKrbpfibViuY2aC6rGvejykB3GTJTRH2bY41oHYmxU
         9zDbpht5YCMZXWo5nDpwnTRW1zAfwvvd5p/OTpgxvH74QvPM2jsoh68kyXYhQTFpHbTH
         HadGlIJCHEpEY4rGUqQvk3dSeq6BTGHjKmr2zZQjvkceI1gD+SnDvBu1zD6KQbWYTMcl
         NGChYzUez9/jKOBqWjohAAvY1auzWvocUbsCnWvRQaPEQMPF+zFG4qrQl2wh1bFmVeX+
         +KVw==
X-Gm-Message-State: APjAAAUmWYpgMtp++xSoo5l5SRW2HfA0knVG8WIIQgB/vmnL36JEsYpm
        5CUmS3H7nFJ6HxZwqQSwMOT01PiESgU=
X-Google-Smtp-Source: APXvYqwOwlbbeoYqAH3SvpO+tFI2xMgpmJPAmaICIBFYNibgX+0GTdpauHlYEXJ54XlUJtpDo7S+2w==
X-Received: by 2002:a1c:4884:: with SMTP id v126mr4360261wma.64.1579267669959;
        Fri, 17 Jan 2020 05:27:49 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id s128sm9847090wme.39.2020.01.17.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:27:49 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:28:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        baolin.wang@unisoc.com, chunyan.zhang@unisoc.com
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200117132807.GL15507@dell>
References: <1579259812-27186-1-git-send-email-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579259812-27186-1-git-send-email-orson.zhai@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Orson Zhai wrote:

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
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> V3 Change:
>  Rebase on latest kernel v5.5-rc6 for Lee.

Still not applying.

I think it's a problem with the patch itself.

It looks like all of the tabs have been replaced with spaces also.

How are you sending the patch?

Arnd,

  Are you able to apply this?

>  drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h | 14 ++++++++++++++
>  2 files changed, 43 insertions(+)
> 
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
