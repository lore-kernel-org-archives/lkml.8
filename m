Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B281C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0302E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WPUYVKre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgGMR7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgGMR7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:59:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:59:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so17572955wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z7pEtA5iBAOAbSW9+7JuABPqZcvxnVfZbw6mRnzxJ9E=;
        b=WPUYVKreDkf9yZMNMiDL5g6kVqFWZrvS3YFLZ1NOCtcnJ6+GNJR08CXlJtYXuNxZY7
         yC7bXj/XqZ7RXv3VBUUYYAOXIaUZcY8CCOxK3BQV4xYBKG8nbNx1bVjoxxQp0swraKzV
         SGt+WqKlPgmNRiyEBxYFFTM8PbRGheqZFmIb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z7pEtA5iBAOAbSW9+7JuABPqZcvxnVfZbw6mRnzxJ9E=;
        b=e6nL3eTiD79W8KJAxy1jnub0f94Sk0qt41hV+1Gdm5Zec0npiWJdTrLVSMhDjiKFry
         PP318SZcUN/LkmA1eIgD6euacx0PyFau5lS6saGGNSPCVTRJzxSN8nRo2bt5X7kK5Pgr
         GVd0l4udS85CoVL379Zj7jYlQShxn8DHoAsCOt5h7Lg1t0luIgTMqeZ/1pcg0k5tkVJI
         EYB5HLpE5NJLdgIPU5MIyTrTzITl2YcQVl4mAFJrudiRUxN6LQEOrY7vQoQWOuWA9nCB
         cue7C3D1SDEaQL43Wx3l9O6AoCSwLbwVlpeyHpOtphuEpkEPo04a8pleNqrf6yarmsgE
         c+mw==
X-Gm-Message-State: AOAM5319IfH5Gt3LioPd3ojXcAi5wWJAhJY3eVspedbio77cSVYbschV
        bMZCGPd3Ab+likALTEtkshWOFw==
X-Google-Smtp-Source: ABdhPJxytEog4tJTCrdDFG3RCmZbbR4xRA/Mc59ogBaI4ze5XCZJrx0bTcdW+mmLhfgjFEbK3B3kVw==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr618419wrp.412.1594663180760;
        Mon, 13 Jul 2020 10:59:40 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b10sm444242wmj.30.2020.07.13.10.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:59:40 -0700 (PDT)
Subject: Re: [PATCH 03/25] pinctrl: bcm: pinctrl-bcm281xx: Demote obvious
 misuse of kerneldoc to standard comment blocks
To:     Lee Jones <lee.jones@linaro.org>, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        YueHaibing <yuehaibing@huawei.com>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-4-lee.jones@linaro.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <62d7a3e7-c96d-8cf9-da22-16f8eae05def@broadcom.com>
Date:   Mon, 13 Jul 2020 10:59:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713144930.1034632-4-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks.

On 2020-07-13 7:49 a.m., Lee Jones wrote:
> There has been little to no attempt to document any of the demoted
> structures here.  These are obviously not kerneldoc headers.
>
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/pinctrl/bcm/pinctrl-bcm281xx.c:65: warning: cannot understand function prototype: 'enum bcm281xx_pin_type '
>   drivers/pinctrl/bcm/pinctrl-bcm281xx.c:79: warning: cannot understand function prototype: 'struct bcm281xx_pin_function '
>   drivers/pinctrl/bcm/pinctrl-bcm281xx.c:89: warning: cannot understand function prototype: 'struct bcm281xx_pinctrl_data '
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pinctrl/bcm/pinctrl-bcm281xx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
> index 71e6661783006..9ab1f427286a7 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
> @@ -59,7 +59,7 @@
>   #define BCM281XX_HDMI_PIN_REG_MODE_MASK		0x0010
>   #define BCM281XX_HDMI_PIN_REG_MODE_SHIFT	4
>   
> -/**
> +/*
>    * bcm281xx_pin_type - types of pin register
>    */
>   enum bcm281xx_pin_type {
> @@ -73,7 +73,7 @@ static enum bcm281xx_pin_type std_pin = BCM281XX_PIN_TYPE_STD;
>   static enum bcm281xx_pin_type i2c_pin = BCM281XX_PIN_TYPE_I2C;
>   static enum bcm281xx_pin_type hdmi_pin = BCM281XX_PIN_TYPE_HDMI;
>   
> -/**
> +/*
>    * bcm281xx_pin_function- define pin function
>    */
>   struct bcm281xx_pin_function {
> @@ -82,7 +82,7 @@ struct bcm281xx_pin_function {
>   	const unsigned ngroups;
>   };
>   
> -/**
> +/*
>    * bcm281xx_pinctrl_data - Broadcom-specific pinctrl data
>    * @reg_base - base of pinctrl registers
>    */

