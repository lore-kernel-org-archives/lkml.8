Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C62420656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRDw4SqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGHHiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgGHHiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:38:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B594C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:30:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so1839330wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cG2EeSiNmVnVaZPbJg0dA9qERe7hr1Vw8tX5Dp6lxwc=;
        b=LRDw4SqZ/Xjjp8Jg8dzYrO8CN8Pp8Gz2nDHG/juEa75dwOFt3gyUpGglGZ8ydO8iEd
         ibmHyVON+8qa3WpOFcdpFIlstgH7dQ+sVVu3BXZ2NvKnUbN9P/Olv0fyfxaLCtS8Ak5c
         wa8gF0CRvE6MscGW2dqohuRo0BqmjZq/oKlMMxu3/pbbAvBQpy/wyrKPk7x+HRNiCCn1
         Qy7EZhAcSMxPTbhloJ0vvUfLtFe2jhr+ouuxQQ2VkM+x52/wx/q/8R5gsBYP1y2VpjIA
         y3wkYHiMSr4QL8u7b6Jgc8PByUi7CWxvW90l8MrzHPw8Sdm7pG9L6WR7xiy1uhWkpGHt
         F1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cG2EeSiNmVnVaZPbJg0dA9qERe7hr1Vw8tX5Dp6lxwc=;
        b=tdC70DhF6ObaSUXAhS6p7i+PrbyMtk8cBv8ivdRhwFh6J0RBgPDP4EkPOp1HGHwXww
         xZkOCh+wo6RvWJkzUtOExfvBVYeQ3gvP+OYUNVteVAb0I/GyxrCM8LtqgpFZLuzmmCkL
         csKbicbavTH8ZSWdJN6iWC9RNVkEHqrC22W7YkRpttP9/Ro67KO9TK6jqj58vetKxO6P
         rDom3DCJrFzBtXxmz3toHNhRswo7ipP2re9Cd7Lbekad1Ial8SLYUcK38EeZnsgv+Noc
         upIEU9NQGa2pv2oWNW1dCVBcqVvlP9e6XkPE73VXBURQ+9iyToL3pKDPHIyKuxYs8PXG
         aRew==
X-Gm-Message-State: AOAM532/6SiHiSSwuDuxvKFqcgpSC/0i9F/JvwhpXcZ0yDrSK95sknxj
        maKkw5jW0fYVnOnlQCn7dBCOe1G+F7s=
X-Google-Smtp-Source: ABdhPJzjvkf/p3Lm9nHa/KlWWqk7KcbAXk1MxDzQAPXoHG5QHDZUnEUtHF1mwLlpHWzxqL+71ouV5w==
X-Received: by 2002:a7b:cd18:: with SMTP id f24mr8304983wmj.40.1594193432117;
        Wed, 08 Jul 2020 00:30:32 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id 1sm4381699wmf.0.2020.07.08.00.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:30:31 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:30:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd/axp20x-i2c: Fix "CONFIG_ACPI" is not defined warning
Message-ID: <20200708073029.GO3500@dell>
References: <20200707110058.976371-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707110058.976371-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jul 2020, Axel Lin wrote:

> Fix below build warning:
> 
> drivers/mfd/axp20x-i2c.c:82:5: warning: "CONFIG_ACPI" is not defined, evaluates to 0 [-Wundef]
>    82 | #if CONFIG_ACPI
>       |     ^~~~~~~~~~~
> 
> Fixes: 20f359cb236b ("mfd: axp20x-i2c: Do not define 'struct acpi_device_id' when !CONFIG_ACPI")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should already be fixed.

Thanks anyway Axel.

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
