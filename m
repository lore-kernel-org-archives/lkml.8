Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A7E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH5zB2sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFPHHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgFPHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:06:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A15C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so19567204wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=S6Wt2049xOyn9uDBo8RtO0TmdMtlWUY24rAkQY/ouSI=;
        b=jH5zB2sl5+QcbiTOlHEBYBJ5vMNw9h/Hu8/Q/WEvwbj4Xt+SONwj0Ppd7fh90BM0tT
         Hp3sfHy3IVyWzMSLyGu+k1OIJ6ma1DlcfUSDapcAbZeSUH9tyVMMA8SQzqMulzp1Kt3d
         fvQz79e35Zb+AzwR0jFx8+bCiM6L9/rWBZhlCy0Rb2ZaUY7FKU1tY3oC+qgcODyEqvxo
         DcHJFVViyExCkxevk0UEBlUOHoAblTD3Rkc6pL0QvjGA0QoWnaO1KIbUWByQ0JgPixsX
         CzLA+ByKo8IhJysdlKawbnk+SPhUyylISdd+xf8uicFILiScM4a9RY6qVrhbplhLgOf1
         ZZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=S6Wt2049xOyn9uDBo8RtO0TmdMtlWUY24rAkQY/ouSI=;
        b=UeUsksCoET0kB8JlMIbymLPFBesWxod9nuj8VBmHF3a1nE0vRO+v8KFDYYtpHjd+En
         aAxUFW13MHAqTE7Px7+AhK0ytwdEQqtbnjw7nsyUey7I2VDFE7MzUeI61Y3mloGUCGbz
         0WdhMdOE8YOujUclPx4qvuFqIp8Z0/k/t9EjkVvRQO+dU7zw5SJ3CCPCgPj+tPBNi0b4
         FaI8PytSB2O4jRb7uBhYw6fiDuLl2GB+g4Z8yTCzp8vriOYFaMe3fa2yWj+18R1xRWTZ
         q85WZ5cOSf0piRpG9v8J2jCsMtfLKBlsbTU9GYnlQV8hejlbJsraNk3+MLfHplILSpsF
         9EZQ==
X-Gm-Message-State: AOAM531/MLb5A8zGsEdlza2wW2/I/ZN1+V8CJFwnJN55hvb1aMyb4rVD
        iuqp2urnu4QPAfNo3/N4K2XPzg==
X-Google-Smtp-Source: ABdhPJxTcyWzB10Tj4UoI0tMy/u3LqUlapmPnhWb4IqpH0dhk1/y3mG9xdwdxvPulRAXR8aBPGJpnQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr1425261wrs.223.1592291217037;
        Tue, 16 Jun 2020 00:06:57 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id a81sm2809160wmd.25.2020.06.16.00.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:06:56 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:06:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Message-ID: <20200616070654.GC2608702@dell>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Thierry Reding wrote:

> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
