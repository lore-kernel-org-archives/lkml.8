Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2604C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8857E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g0+5ViLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgF3W1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgF3W1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:27:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EDC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:27:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so21103805wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJMDWi4rVdnlXtHH3FEEBs4ZVPxpgSB+nPYBkDaztWY=;
        b=g0+5ViLx5xhv7QmSHuJ0gdETRPLWxYOqYl3T1moYSb8ZkhOwPrvz8EQ7WPUHcwZMBR
         +baNnqiEkYHKhOUCBB4yhTPYhk7KtNJHItMhcXWUoyAVhaHdqXqQHoQFtyPYmhf1IQGv
         6vvHb8RJLXC4SrSNne5U0UjpnIOv8Wp6x07Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJMDWi4rVdnlXtHH3FEEBs4ZVPxpgSB+nPYBkDaztWY=;
        b=i1No/hS+6+LHzU1Qry6MuWBzZZR/w2yiGfACtEBjBMUGeEo5md/iRXbZW7oQEg7SF2
         ojMBY7H3otbhMzewi0C3OR/Rwfj13Zd0NWVzQfLKeJmqNxaN312gLd0LsI62pyn9/3eJ
         DFk1xyEMvGLwWka+r4FRq+wR+ja4eaGcJgz3GQeYlmnOFY93HCtvCY6/VDg5N9mM1B6+
         QN3yqIvIEGnwR7tcFT8FujZwfnpoibrcO30Pg1rndThoveQFV2GP2Z3SvECww2fhqsAb
         VHpCsIlCxWT3gQ/GaTFZOV+JlWJl1g+n11R2aMOBGh0TPZAtleNaW5oUj7Zk8VodY+s1
         CHnQ==
X-Gm-Message-State: AOAM530IvqX2pjbZZYiLNPG3hvel6L+p9jrh9i0coKGzsT7zVJSoyeHx
        DMVFFJXrxTRf/00JMT9fRRRYQZvDuE+rnE+4F1mwUxIczfSEu7rbrVESh+kAA7rL7oy9pMTh0Vx
        /4uglYWmsmp49BVQpo1+zadXJffLgk2wIsfg6ITbm128OuwHQkur28sK9DED8tti59f2GxkVrfh
        Mb
X-Google-Smtp-Source: ABdhPJwLDuL7dsch52OEz43Vnb+/wc9UWTMLbW6RREjm/xJ670fR0aYqcK6lMpp4NWS+oCn7O3qqnQ==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr22638463wms.109.1593556022584;
        Tue, 30 Jun 2020 15:27:02 -0700 (PDT)
Received: from [10.230.182.181] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id f12sm5145719wrj.48.2020.06.30.15.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 15:27:01 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: nsp: Set irq handler based on trig type
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200630204704.17736-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <bc6c62f7-1ae5-4f7d-43ba-efae057e8cb7@broadcom.com>
Date:   Tue, 30 Jun 2020 15:26:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630204704.17736-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 6/30/2020 1:47 PM, Mark Tomlinson wrote:
> Rather than always using handle_simple_irq() as the gpio_irq_chip
> handler, set a more appropriate handler based on the IRQ trigger type
> requested. This is important for level triggered interrupts which need
> to be masked during handling. Also, always acknowledge the interrupt
> regardless of whether it is edge or level triggered.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> index bed0124388c0..349fb384113e 100644
> --- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> @@ -174,11 +174,8 @@ static void nsp_gpio_irq_ack(struct irq_data *d)
>  	struct nsp_gpio *chip = gpiochip_get_data(gc);
>  	unsigned gpio = d->hwirq;
>  	u32 val = BIT(gpio);
> -	u32 trigger_type;
>  
> -	trigger_type = irq_get_trigger_type(d->irq);
> -	if (trigger_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> -		nsp_set_bit(chip, REG, NSP_GPIO_EVENT, gpio, val);
> +	nsp_set_bit(chip, REG, NSP_GPIO_EVENT, gpio, val);


I have a question here. I assume writing a bit to this register will
result in clearing that bit, is that true?

Based on the driver, the 'nsp_gpio_irq_handler' seems to rely on
'NSP_GPIO_EVENT' register to figure out which GPIO the interrupt is for.
And if so, and if this is cleared here that is invoked before the actual
IRQ handler, how does this work?

I could be missing something here, so please help to explain it in more
details here.

Thanks,

Ray
