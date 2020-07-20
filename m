Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37796C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D00222CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1HO6687"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGTKrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgGTKrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:47:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E56C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:47:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so17340622wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHRAgQoOuo2NrrewNnTyTofto5ZGKZsKC7PlWtRZlsk=;
        b=p1HO6687swYNaesbAFlQr5ER5YLa6Dp61vm/cYxzq5BiwlhW8miLzY1N+ywd4GFtgC
         3XA6WY/XPvOSHgg9TqIxLI5KhvMGnfnTW2NViUu4dlbKJAbl6gnUljRbZeH5RlZkqSzv
         NYIu0hbyjqx5xjOSNxzJHccYaD45O+xLXGTO7OW63sCBqy0HgOh6kbAPFRhNAX4Xaclw
         B52VdQ9mQMWK+HpRptC3d8yoWgLXAMokvcb4zYATNkCHu1X4pdTmk83uqT1FMAPL6v3A
         YqJLtmBJHgx/w5f84ImJux4v1xigy/1ATHGXIcHJWFAv33oMPWxdzgpU6MMgZgGZKwO/
         lHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHRAgQoOuo2NrrewNnTyTofto5ZGKZsKC7PlWtRZlsk=;
        b=h6pdSx8FyJ7W4btLw2qtjNU03Em5rG6BY89BTWj+4YAcz3ev10zABirfEEIQqNQosj
         BV2j4qXzvSaFRYVRUQKXHT1Gw5ZSGA4YZomlMvajb24hClPbQa2V5x4tjG8BBPj+noM1
         Zelh1ikiqV4pvcPPmZxbdO8/aHxpDx3Ohd99rE00pXAuBgLgL7aevXlWd8vB5/mHXbNc
         6uh1qAapH0V8deT6HtvV7IkJGyD1UXrHNLsoNoC+npJL4YRmeVYGfYE0sEkXIdfeWNJS
         V4pw6RgUA92Td+3KwaPyahRXt+PGPpYhv4orDXLIQFUP7UmJw1If+ufw2mhz6P2Fck4S
         WF9w==
X-Gm-Message-State: AOAM5318/4aHeCJI51Cl+K79bUWv1wesUyXsNPgWWHKH0krP0lGvqY0d
        oXsssIq15mJzKKQ2694fpTI2hODxV2Y=
X-Google-Smtp-Source: ABdhPJxum0c+tr6bp3uzQyfxF85Ev6PhOKDV+5JO1aAMnghVrUIm2LoCd/ZltwPRMaLd01KeHiWl7w==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr13083233wrn.307.1595242070556;
        Mon, 20 Jul 2020 03:47:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id 51sm33651621wrc.44.2020.07.20.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 03:47:49 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] clocksource: Add support for i.MX TPM driver with
 ARM64
To:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com, linux-soc@vger.kernel.org
References: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6c80edf0-52ce-7b64-0631-cc52e937f54c@linaro.org>
Date:   Mon, 20 Jul 2020 12:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594178168-13007-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2020 05:16, Anson Huang wrote:
> Allows building and compile-testing the i.MX TPM driver for ARM64.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- select TIMER_OF for CLKSRC_IMX_TPM.
> ---
>  drivers/clocksource/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index be49123..401eac7 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -620,8 +620,9 @@ config CLKSRC_IMX_GPT
>  
>  config CLKSRC_IMX_TPM
>  	bool "Clocksource using i.MX TPM" if COMPILE_TEST
> -	depends on ARM && CLKDEV_LOOKUP
> +	depends on (ARM || ARM64) && CLKDEV_LOOKUP
>  	select CLKSRC_MMIO
> +	select TIMER_OF
>  	help
>  	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
>  	  clocksource.

Applied, but I will let 2/2 applied by the corresponding maintainer.

Thanks
  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
