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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E909A20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KlMoSwm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGMR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgGMR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:59:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B9C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:59:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so17588232wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=E18MAc0nkNbRTaxZd2OKURgPcHFN+ctVoY0tSbowupY=;
        b=KlMoSwm5GaRFwhGjudQHPHcNvOf6igTkPDH8EHdajH4zxPSjFP5rWmd17z1bcVLsm7
         LkOYqJqhFKEuhZnCPZ22PWInbkhdW8r2Bozugx2h0/3rPCcTYBlXacgOO2+Rirf0kffM
         EktHYj9Gzh4+L0aTBpPZAYuSEFVF0wqPMq/O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E18MAc0nkNbRTaxZd2OKURgPcHFN+ctVoY0tSbowupY=;
        b=SXjs49hcj1K324EaRjqsuzb8U/MXmznhdG/VfcJx7o/ZBiq0+o8+wZLe6zDhppd6ya
         dD3rdKcMBwdHvu+vZSmSdzCkUyDueujUu6zNPVyp4UitJ1ITRKlfiXNl9+K/BHN0oHmI
         VwWqqKaB7aL3igjIfaLlEWGq9rAzFHGRPzI3KtnnNDFvAa6WFgEXwxgqtrZMk9+lU96q
         oHKoDDiHq+ZO404pYeVqg9IPz1XN0K0/PAMX6osENjPMLnmFUR+tHrOP9hhQNDf54evF
         lA+x4dwnrgfI4vxh7mk/GrOn4+HKgaVT2XAYEgi6YSuJ023cFR9/cv7Dw9EP2k+Bbs3Y
         R3Uw==
X-Gm-Message-State: AOAM530/en23ToBSX+AJjF6Zz0yISjokvG5HtS2/OK5xB2TnvQTBABiB
        b2SBdC5NsEmIUmmYOw+FblUoHA==
X-Google-Smtp-Source: ABdhPJwwageRyXNotoFdi435qR8tmlg2BgI5l+TGsSxD9nhW3MH9X1s0J4ee+M52L6C+NqBGu+nVZQ==
X-Received: by 2002:adf:8091:: with SMTP id 17mr586143wrl.13.1594663143216;
        Mon, 13 Jul 2020 10:59:03 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f197sm510542wme.33.2020.07.13.10.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 10:59:02 -0700 (PDT)
Subject: Re: [PATCH 04/25] pinctrl: bcm: pinctrl-iproc-gpio: Rename
 incorrectly documented function param
To:     Lee Jones <lee.jones@linaro.org>, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-5-lee.jones@linaro.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <61bf1345-be78-a303-1199-7275fa5c6d89@broadcom.com>
Date:   Mon, 13 Jul 2020 10:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713144930.1034632-5-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks.

On 2020-07-13 7:49 a.m., Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:141: warning: Function parameter or member 'chip' not described in 'iproc_set_bit'
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:141: warning: Excess function parameter 'iproc_gpio' description in 'iproc_set_bit'
>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> index a38f0d5f47ce9..e2bd2dce6bb41 100644
> --- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> @@ -131,7 +131,7 @@ static inline unsigned iproc_pin_to_gpio(unsigned pin)
>    *  iproc_set_bit - set or clear one bit (corresponding to the GPIO pin) in a
>    *  Iproc GPIO register
>    *
> - *  @iproc_gpio: Iproc GPIO device
> + *  @chip: Iproc GPIO device
>    *  @reg: register offset
>    *  @gpio: GPIO pin
>    *  @set: set or clear

