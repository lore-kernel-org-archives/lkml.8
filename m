Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13275206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EVZTX8pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGXP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:27:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72DBC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:27:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so162721wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=btolEu+oBZ4e5G3BsfMzehyCFgYxasskNysgu6TkP7Y=;
        b=EVZTX8pdmQ7xRZx1Ep7GH7aaZzHEryY0gbe7OGRyxIVmLrW+13jSRkbeBY3YObc/fz
         GLVyOJuL6spgU5CenG8oa4r6PNC5tSXYyiliO3zFOLPLvCkkYMz3EtGcsheDycg7rsrg
         XGim9MKQNp37fNbDOqzZTaVav5Ydu+K1ZLXVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=btolEu+oBZ4e5G3BsfMzehyCFgYxasskNysgu6TkP7Y=;
        b=Kr9/W42RG9UHRafhmBmANsiJOPPgSPssBTaLSMP7obBI2ZbKFQ8ozHjeJ1sKhoqoZf
         zvWMFasWalBII7Nhez2Rkhwl9LEOpF+UM8ZpeIcAVdAcYhNGs1+PWAinpFupXfoMwMuP
         gN2PvJ9+nyLuIw6bdRmWzcZxCfmtunMWIT8LF96BxTXllD5MZM+mHEH9LsDf3+XRxfco
         Cy0fmTpN/QGIkU6+KcY7G+Tb1Ro1EmotQ3dUs5YOr7INGWs6j/2FOlC62UFHAmGkRhg2
         lAzsk9mBiQBN9mj0Qn3FzrdOeOptoEEkoz1y2fllwVAMDF3y3pmHp0PLLJZGC3LtO9oZ
         r6qA==
X-Gm-Message-State: AOAM532HS2NR1dpQ8GTZKE/PNims35yN4kjPBJLqvXhQaIumwtTket9j
        UbSc8NYSI6LkDVXGJW6bF6u/Xg==
X-Google-Smtp-Source: ABdhPJxmP6qLdy+uHYizxgbTFvILG+JdEPeE9P2WqStVt0R8TI+fyQFIT89R7AeGgp6PRKA01T3tgA==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr402360wmd.182.1595604438321;
        Fri, 24 Jul 2020 08:27:18 -0700 (PDT)
Received: from [10.136.8.246] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d18sm1647051wrj.8.2020.07.24.08.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 08:27:17 -0700 (PDT)
Subject: Re: [PATCH v4] pwm: bcm-iproc: handle clk_get_rate() return
To:     Scott Branden <scott.branden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200718044606.18739-1-scott.branden@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <17848399-2b2d-b4f9-706b-94b3471c1e76@broadcom.com>
Date:   Fri, 24 Jul 2020 08:27:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718044606.18739-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry/Uwe,

Do you have any further comment on this patch? If not, could you please
help to pick it up?

Thanks,

Ray

On 7/17/2020 9:46 PM, Scott Branden wrote:
> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> 
> Handle clk_get_rate() returning 0 to avoid possible division by zero.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> 
> ---
> Changes from v3: fixed typo in commit message: Reviewed-off-by.
> Hopefully everything clean now.
> Changes from v2: update commit message to remove <= condition
> as clk_get_rate only returns value >= 0
> ---
>  drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> index 1f829edd8ee7..d392a828fc49 100644
> --- a/drivers/pwm/pwm-bcm-iproc.c
> +++ b/drivers/pwm/pwm-bcm-iproc.c
> @@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	u64 tmp, multi, rate;
>  	u32 value, prescale;
>  
> -	rate = clk_get_rate(ip->clk);
> -
>  	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
>  
>  	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
> @@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	else
>  		state->polarity = PWM_POLARITY_INVERSED;
>  
> +	rate = clk_get_rate(ip->clk);
> +	if (rate == 0) {
> +		state->period = 0;
> +		state->duty_cycle = 0;
> +		return;
> +	}
> +
>  	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
>  	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
>  	prescale &= IPROC_PWM_PRESCALE_MAX;
> 
