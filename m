Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C47C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9774520704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eBRo3SW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgGQRWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgGQRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:22:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4BC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so16087165wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AoGGlbrqDdPdAt7SZnkfIe6cI/q8MK4oBz8zz9M/acQ=;
        b=eBRo3SW05EhHdbRiObyZVkdToB+SfnAgfcwfG1UziRDO9imQP66XiFEiflsyu7G768
         FmF/sg++nQJp84LORbbmQkWzuXcpIJyVD/dBxXCSOTueCiV5pr6ULXJoxaOpjCogUSbo
         liKDKgBvilIpKfw9Z9uzB7iI6If0J1WJpzaWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoGGlbrqDdPdAt7SZnkfIe6cI/q8MK4oBz8zz9M/acQ=;
        b=hKEH76BbcAYfqyG6DKD5/WmC/X6FZNBojM4k/qsiyI9kDGHfGAB29naX8zkCZnITCg
         DbiyM9EfdNHt52CLzmQyu+coONsLnYp3R6HUv6lMo5hMFNOPgFb8GyN846nhUY3c5IEB
         iUlf+Ag7E0qWDXzOt6J7gvD07DNw8J5siwrgdMjv4tdtvHt0LuxVne2S1ZWz3sV6SAJE
         B4opD+0hQKmBwHZtyGbWZB0e5KykXbP5mZwvaQsysiqfA9AKLX4+Juj5qI+NhpIl8Fzw
         9DSkRy0pERCO/hvbGm3ttgciRJgQ4iyRVQ1y0xmzs1L/vHsoWDOUDVJXmy9bdKHKQufl
         xcpQ==
X-Gm-Message-State: AOAM533fdGDI9L+eak8p0rIXUroKc1TSu3oakdufZgw+Q2TggC2NWSB0
        wp/Aua6ouD9Ffj4pQrcsZH/E3Q==
X-Google-Smtp-Source: ABdhPJx5HuoCQvje9YbfNYXj5ZyRp/BF5z5HnFlrq0fsNt7tkJM1VBsvb8LP25MSY4X9JxW4ybylpA==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr10210755wmi.98.1595006539117;
        Fri, 17 Jul 2020 10:22:19 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id g13sm15986896wro.84.2020.07.17.10.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 10:22:18 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
To:     Scott Branden <scott.branden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717170743.25466-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <94f2aed1-d88d-3ee0-6e57-917f665951f2@broadcom.com>
Date:   Fri, 17 Jul 2020 10:22:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717170743.25466-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 10:07 AM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning <= 0 condition to avoid
> possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..72a8607b6c8d 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u32 value, prescale;
>  
>  	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}

Based on the pwm core code, 'get_state' expects the following fields to
be populated: 'polarity', 'enabled', 'period', and 'duty cycle'.

The above logic will leave 'polarity' and 'enabled' completely
unpopulated when clock rate is zero.

>  
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
> 
