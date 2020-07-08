Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8752067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOT6/9IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgGHHaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgGHHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:30:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012EC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:30:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so25470998wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pLG17Nn5WyQtC4oBA5Y9UasPSCr2B8Qexry/ZQlo3J0=;
        b=ZOT6/9IRhGIKRrutRMFUQw/yT2iO+XQRJWMcO1SXgq61tcKju0aQdZnDZXSRsPQ0yJ
         dBbpZ/5mEphDo7zt8Xkcgx0XAPasfzkGRinamc6d6mwV1lmcuXb0zrAIx9Yhi7jtXtkx
         wOiOluDUoLay2cuho43p3p6CLrc3pw0aAbMF5loiTHjzWots2ZcOFJKsgSnfHjLEgi83
         QHKZSde6HgwuM+mhIGei+E8SobHzfgcQzQ08kidYmySJVJ4w0Qy5RDnnCMpAtyjpVrr6
         J4lvgPRREbi5HCatI2nkDdDn8NdPtbFI+OrWNQsbqgI2Nj5LtRiCnc22N5KL97X//2Fu
         rsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pLG17Nn5WyQtC4oBA5Y9UasPSCr2B8Qexry/ZQlo3J0=;
        b=kqSloWfkmtXK2ZL9LyRo9vXrkSIRVjF9DbrKKpk/caUl5Qx2gE10xio7c3pky/iElo
         lQcPRw9jDEsjG4g1E9TaGo+Nf/2POIQza4VNkRQFWBzQ52VKH/QawrnQlX5fH0sFrwPy
         mWdLGoM6Bz46Frx2ny5/V6Sf1x5aoVm7eCr6rtgZnzpCCgpUDYehp3I0LBh8mjzaD40t
         f3TyrNJx39zpVR+55jTCuvnRSOefyOQ02W7U/h63EE90Hle906qzbKNTZOKel56ycWZI
         Uk7LTpEsOxdtyNi0gXQfuegkbF01e6gea3QQC2fl4Bau0q5C1kyXb5hsFaKN50N9BbbV
         7GVg==
X-Gm-Message-State: AOAM530UiIsjhr29kpwg0dYRzUbspoILVbijxID/MXKA1/RmhsrGLEdD
        RjoHV3jE0QZjWl2lw3qUT14teg==
X-Google-Smtp-Source: ABdhPJwTcA8SXwUVb2FYAt1pdgeglSrLHAJEjn6czrnSEyx5rgOoUmqgJol9MR04SsLlC5RGDY3JmA==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr62480961wrw.213.1594193400034;
        Wed, 08 Jul 2020 00:30:00 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m16sm4763255wro.0.2020.07.08.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:29:59 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:29:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Use #ifdef for checking CONFIG_ACPI
Message-ID: <20200708072957.GN3500@dell>
References: <20200708070725.6318-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708070725.6318-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Krzysztof Kozlowski wrote:

> Use #ifdef directive to check whether config symbol is defined and to
> fix warning:
> 
>     drivers/mfd/axp20x-i2c.c:82:5: warning: "CONFIG_ACPI" is not defined [-Wundef]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is already fixed (3 times now). :)

Thanks anyway.

> diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
> index bd271fbe1ec1..3c930316d48b 100644
> --- a/drivers/mfd/axp20x-i2c.c
> +++ b/drivers/mfd/axp20x-i2c.c
> @@ -79,7 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
>  
> -#if CONFIG_ACPI
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
>  	{
>  		.id = "INT33F4",

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
