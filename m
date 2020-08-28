Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA19EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB9220848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXX08sNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgH1NEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgH1NEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:04:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A93C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:04:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so422677pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PE8MD8kwekEL9Z0XSU3pdc+yEYrZR0wZcfz7tEycv0c=;
        b=IXX08sNM4ek8rgeN0bVQyCZy5HnTLWHhrN3TvGcHhbTKbQqjyuPDDPZJEyL8UYojeo
         12NqYxJQmekVK9Vj7VrbCUNwDPTc4fezaOk6a9OdxtBW1s9i+p+xyZReFC7Aac9CamWN
         T0Nq8rFK+I9XkAYlFOOb/a1eQhsy8ECYXHGT31co3Wz7mvBUp7t6CckamgiSEjv+RqnP
         zq0+pQGgSvDMqVZs1yobeLB0zA0331gA/lUYklTXIoLvz+Hf2nMdMhvqrBJAEg68SuYg
         ykBkDnJWLEEtlkzYCRmVtAx1wJmyFWmxkVYe2yv8qUXjGE5WiOpzwKCmbmoT/3DZmHyY
         Ht1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PE8MD8kwekEL9Z0XSU3pdc+yEYrZR0wZcfz7tEycv0c=;
        b=DgDRZZG7GpMNGa6QOZckQ3Sh1S7R4X8CSwLm0DFiOAsAKCCn91lM8RS2HisQKGw2eW
         ZEO/ek3ILjAkrJSG4tY2AjYhUPEOACXp476jQrtTHLYdOxg77bUhxV80Y5CvxoCQpKS/
         vNOfEmpIBc23eOgI8z2QF+f2WTzaJeh1bnelM5RnSFXd420rjzqMJRVq3qdbT7lrqKn1
         uSWLRYF/WAHrb/3GTIOht49MKqRz1TBDSIF9tE1W9gIDh5rFiK0mnNTIUF6rdfFNmUut
         UPL11QxrP0JqJ2BITUU6r1iru4grAqlBdk+DXqtM6E1Edmq/VNMRg74pWAbJzSlozYsy
         1ySw==
X-Gm-Message-State: AOAM532FWdPz+6KrE0yqthskC1SZ2FLcBXUREq4z0uLKDysSFjuhf9ez
        79CnydQ9CdoHB6syZEgP2DAU
X-Google-Smtp-Source: ABdhPJwYd005ketMKQ12FBg07eRO96W/Qc6IZUnAvBrFABVTS9KWlkkM8+tbO1PBzSeRr1pYGuVoKA==
X-Received: by 2002:a17:902:9a93:: with SMTP id w19mr1178164plp.297.1598619852871;
        Fri, 28 Aug 2020 06:04:12 -0700 (PDT)
Received: from mani ([2409:4072:6d87:4cd4:5db4:99cb:1fe6:fc86])
        by smtp.gmail.com with ESMTPSA id u8sm1723828pfm.133.2020.08.28.06.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 06:04:12 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:34:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/1] i2c: busses: Add support for atomic transfers in
 Actions Semi Owl driver
Message-ID: <20200828130404.GB17309@mani>
References: <b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b086ef6d355d9730c839359e15eb06175283e323.1596485741.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0803, Cristian Ciocaltea wrote:
> Atomic transfers are required to properly power off a machine through
> an I2C controlled PMIC, such as the Actions Semi ATC260x series.
> 
> System shutdown may happen with interrupts being disabled and, as a
> consequence, the kernel may hang if the driver does not support atomic
> transfers.
> 
> This functionality is essentially implemented by polling the FIFO
> Status register until either Command Execute Completed or NACK Error
> bits are set.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/i2c/busses/i2c-owl.c | 80 ++++++++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 672f1f239bd6..90dd2e814313 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -14,6 +14,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  
> @@ -76,6 +77,7 @@
>  #define OWL_I2C_FIFOCTL_TFR	BIT(2)
>  
>  /* I2Cc_FIFOSTAT Bit Mask */
> +#define OWL_I2C_FIFOSTAT_CECB	BIT(0)
>  #define OWL_I2C_FIFOSTAT_RNB	BIT(1)
>  #define OWL_I2C_FIFOSTAT_RFE	BIT(2)
>  #define OWL_I2C_FIFOSTAT_TFF	BIT(5)
> @@ -83,7 +85,8 @@
>  #define OWL_I2C_FIFOSTAT_RFD	GENMASK(15, 8)
>  
>  /* I2C bus timeout */
> -#define OWL_I2C_TIMEOUT		msecs_to_jiffies(4 * 1000)
> +#define OWL_I2C_TIMEOUT_MS	(4 * 1000)
> +#define OWL_I2C_TIMEOUT		msecs_to_jiffies(OWL_I2C_TIMEOUT_MS)
>  
>  #define OWL_I2C_MAX_RETRIES	50
>  
> @@ -161,29 +164,25 @@ static void owl_i2c_set_freq(struct owl_i2c_dev *i2c_dev)
>  	writel(OWL_I2C_DIV_FACTOR(val), i2c_dev->base + OWL_I2C_REG_CLKDIV);
>  }
>  
> -static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +static int owl_i2c_xfer_data(struct owl_i2c_dev *i2c_dev)
>  {
> -	struct owl_i2c_dev *i2c_dev = _dev;
>  	struct i2c_msg *msg = i2c_dev->msg;
> -	unsigned long flags;
>  	unsigned int stat, fifostat;
>  
> -	spin_lock_irqsave(&i2c_dev->lock, flags);
> -
>  	i2c_dev->err = 0;
>  
>  	/* Handle NACK from slave */
>  	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
>  	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
>  		i2c_dev->err = -ENXIO;
> -		goto stop;
> +		return 1;

This looks odd! And moreover you're not making use of this return value
anywhere.

Thanks,
Mani

>  	}
>  
>  	/* Handle bus error */
>  	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
>  	if (stat & OWL_I2C_STAT_BEB) {
>  		i2c_dev->err = -EIO;
> -		goto stop;
> +		return 1;
>  	}
>  
>  	/* Handle FIFO read */
> @@ -196,18 +195,30 @@ static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
>  	} else {
>  		/* Handle the remaining bytes which were not sent */
>  		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> -			 OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
> +			OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>  			writel(msg->buf[i2c_dev->msg_ptr++],
>  			       i2c_dev->base + OWL_I2C_REG_TXDAT);
>  		}
>  	}
>  
> -stop:
> +	return 0;
> +}
> +
> +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> +{
> +	struct owl_i2c_dev *i2c_dev = _dev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&i2c_dev->lock, flags);
> +
> +	owl_i2c_xfer_data(i2c_dev);
> +
>  	/* Clear pending interrupts */
>  	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
>  			   OWL_I2C_STAT_IRQP, true);
>  
>  	complete_all(&i2c_dev->msg_complete);
> +
>  	spin_unlock_irqrestore(&i2c_dev->lock, flags);
>  
>  	return IRQ_HANDLED;
> @@ -235,8 +246,8 @@ static int owl_i2c_check_bus_busy(struct i2c_adapter *adap)
>  	return 0;
>  }
>  
> -static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> -			       int num)
> +static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			       int num, bool atomic)
>  {
>  	struct owl_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
>  	struct i2c_msg *msg;
> @@ -280,11 +291,12 @@ static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  		goto err_exit;
>  	}
>  
> -	reinit_completion(&i2c_dev->msg_complete);
> +	if (!atomic)
> +		reinit_completion(&i2c_dev->msg_complete);
>  
> -	/* Enable I2C controller interrupt */
> +	/* Enable/disable I2C controller interrupt */
>  	owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> -			   OWL_I2C_CTL_IRQE, true);
> +			   OWL_I2C_CTL_IRQE, !atomic);
>  
>  	/*
>  	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
> @@ -352,20 +364,33 @@ static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  
>  	spin_unlock_irqrestore(&i2c_dev->lock, flags);
>  
> -	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> -						adap->timeout);
> +	if (atomic) {
> +		/* Wait for Command Execute Completed or NACK Error bits */
> +		ret = readl_poll_timeout_atomic(i2c_dev->base + OWL_I2C_REG_FIFOSTAT,
> +						val, val & (OWL_I2C_FIFOSTAT_CECB |
> +							    OWL_I2C_FIFOSTAT_RNB),
> +						10, OWL_I2C_TIMEOUT_MS * 1000);
> +	} else {
> +		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
> +							adap->timeout);
> +		if (!time_left)
> +			ret = -ETIMEDOUT;
> +	}
>  
>  	spin_lock_irqsave(&i2c_dev->lock, flags);
> -	if (time_left == 0) {
> +
> +	if (ret) {
>  		dev_err(&adap->dev, "Transaction timed out\n");
>  		/* Send stop condition and release the bus */
>  		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
>  				   OWL_I2C_CTL_GBCC_STOP | OWL_I2C_CTL_RB,
>  				   true);
> -		ret = -ETIMEDOUT;
>  		goto err_exit;
>  	}
>  
> +	if (atomic)
> +		owl_i2c_xfer_data(i2c_dev);
> +
>  	ret = i2c_dev->err < 0 ? i2c_dev->err : num;
>  
>  err_exit:
> @@ -379,9 +404,22 @@ static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	return ret;
>  }
>  
> +static int owl_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			int num)
> +{
> +	return owl_i2c_xfer_common(adap, msgs, num, false);
> +}
> +
> +static int owl_i2c_xfer_atomic(struct i2c_adapter *adap,
> +			       struct i2c_msg *msgs, int num)
> +{
> +	return owl_i2c_xfer_common(adap, msgs, num, true);
> +}
> +
>  static const struct i2c_algorithm owl_i2c_algorithm = {
> -	.master_xfer    = owl_i2c_master_xfer,
> -	.functionality  = owl_i2c_func,
> +	.master_xfer	     = owl_i2c_xfer,
> +	.master_xfer_atomic  = owl_i2c_xfer_atomic,
> +	.functionality	     = owl_i2c_func,
>  };
>  
>  static const struct i2c_adapter_quirks owl_i2c_quirks = {
> -- 
> 2.28.0
> 
