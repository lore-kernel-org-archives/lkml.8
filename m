Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F900C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6271A206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OiPrZ6cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgGFSHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgGFSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:07:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13890C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:07:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so39146431wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6v9FIWCIeOzcFoSiEjxVT32PHdVCjUSSD17GJl3wu48=;
        b=OiPrZ6cjcKidg6tXPuhtFQBOdB7fY7SgMHE5cuBBvB3cwbQMCkvHK47FDz/c4SX0Jn
         paBZsWa0lEt3te/bij/kWz+kg/9jTtw+OqOXGf5xwHjPvpSkK6KVbXEMqxSJF0kPY4hg
         YvkwuKFXao4a959aH8UrtX1yI2v01oShnKMls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6v9FIWCIeOzcFoSiEjxVT32PHdVCjUSSD17GJl3wu48=;
        b=AIfSJbY9AJuBD1QmAbQ0tvBxwzUVO2mXPRuVcg+DJ5JnIUbO4pUOkzt4rQZdWQLNa6
         Ugg5logv3RUZbRt6yqUvFaMihryVnejkf3LSSHs5PGDGXlYvRkFsXzncMpOXvBdQqJ21
         Vppmhy7LuSpX71htQ2MxJsS7L2+o65Y8DD9OOh3TRJPqy7RNEqUVP55itIk6m67CA0Yd
         1ASWdjfA/M5Uu9FflRZCKZo0+mVsYNGD2QDyoQH8dWUeqE0G52YVu6FfUt4u0xijujQy
         5QoEgdQ01oNfOZCaegLkhTLiwGYdO/wO+yZkY62BUtmq+obOuWg49St1u/g6GYpnlNn2
         BpuQ==
X-Gm-Message-State: AOAM531u6NMRX2P/ZgaYcMILecLqdof+Px0JQodg8wz/5lJ9LdBxYqN2
        B0YS5kBfPGA3nErJ/AN6EVwC5O08g33N+GeofNo+1WKW9qYK6I7GOOuFTmBI1yLHCCEfuvw/rok
        JekyaCHgOQ06OCCfg4EZMaC790PoNfSkdR5sxdfBr5fwT8eS5hAYpgi4keP9YDHBDdfWF/5aHhV
        NO
X-Google-Smtp-Source: ABdhPJzFnxPliCsryeT/J807tHklpeb0GWEWo23lO9wsVURKfYEeHbUhT8twrbhf0fyRttn3Jnko0w==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr49278068wrq.319.1594058836757;
        Mon, 06 Jul 2020 11:07:16 -0700 (PDT)
Received: from [192.168.1.201] (d162-156-48-252.bchsia.telus.net. [162.156.48.252])
        by smtp.gmail.com with ESMTPSA id v5sm24572554wre.87.2020.07.06.11.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:07:15 -0700 (PDT)
Subject: Re: [PATCH v2] pinctrl: nsp: Set irq handler based on trig type
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, sbranden@broadcom.com
Cc:     linux-kernel@vger.kernel.org
References: <20200703011830.15655-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <900a32bf-9c8c-eafd-fb04-08b4eeac4428@broadcom.com>
Date:   Mon, 6 Jul 2020 11:07:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703011830.15655-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 7/2/2020 6:18 PM, Mark Tomlinson wrote:
> Rather than always using handle_simple_irq() as the gpio_irq_chip
> handler, set a more appropriate handler based on the IRQ trigger type
> requested. This is important for level triggered interrupts which need
> to be masked during handling. Also, fix the interrupt acknowledge so
> that it clears only one interrupt instead of all interrupts which are
> currently active. Finally there is no need to clear the interrupt during
> the interrupt handler, since the edge-triggered handler will do that for
> us.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - Don't perform unnecessary acks.
> 
>  drivers/pinctrl/bcm/pinctrl-nsp-gpio.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> index bed0124388c0..a00a42a61a90 100644
> --- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> +++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
> @@ -154,15 +154,9 @@ static irqreturn_t nsp_gpio_irq_handler(int irq, void *data)
>  		level &= readl(chip->base + NSP_GPIO_INT_MASK);
>  		int_bits = level | event;
>  
> -		for_each_set_bit(bit, &int_bits, gc->ngpio) {
> -			/*
> -			 * Clear the interrupt before invoking the
> -			 * handler, so we do not leave any window
> -			 */
> -			writel(BIT(bit), chip->base + NSP_GPIO_EVENT);
> +		for_each_set_bit(bit, &int_bits, gc->ngpio)
>  			generic_handle_irq(
>  				irq_linear_revmap(gc->irq.domain, bit));
> -		}
>  	}
>  
>  	return  int_bits ? IRQ_HANDLED : IRQ_NONE;
> @@ -178,7 +172,7 @@ static void nsp_gpio_irq_ack(struct irq_data *d)
>  
>  	trigger_type = irq_get_trigger_type(d->irq);
>  	if (trigger_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> -		nsp_set_bit(chip, REG, NSP_GPIO_EVENT, gpio, val);
> +		writel(val, chip->base + NSP_GPIO_EVENT);
>  }
>  
>  /*
> @@ -262,6 +256,12 @@ static int nsp_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  
>  	nsp_set_bit(chip, REG, NSP_GPIO_EVENT_INT_POLARITY, gpio, falling);
>  	nsp_set_bit(chip, REG, NSP_GPIO_INT_POLARITY, gpio, level_low);
> +
> +	if (type & IRQ_TYPE_EDGE_BOTH)
> +		irq_set_handler_locked(d, handle_edge_irq);
> +	else
> +		irq_set_handler_locked(d, handle_level_irq);
> +
>  	raw_spin_unlock_irqrestore(&chip->lock, flags);
>  
>  	dev_dbg(chip->dev, "gpio:%u level_low:%s falling:%s\n", gpio,
> @@ -691,7 +691,7 @@ static int nsp_gpio_probe(struct platform_device *pdev)
>  		girq->num_parents = 0;
>  		girq->parents = NULL;
>  		girq->default_type = IRQ_TYPE_NONE;
> -		girq->handler = handle_simple_irq;
> +		girq->handler = handle_bad_irq;
>  	}
>  
>  	ret = devm_gpiochip_add_data(dev, gc, chip);
> 

This change looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
