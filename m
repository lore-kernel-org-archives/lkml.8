Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF8C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9403F20784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itp8ed87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502928AbgDPIuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502808AbgDPIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:46:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92869C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:45:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so3783207wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7CCjqYtV5rZ1BPnB8xJbE2LOaBB1/4i0WAcySTW6iW4=;
        b=itp8ed87fWGbopVCacBwE3FdVL41GEKkFYSZwG2nBvg1yeGIFZDWITbHGxX+ZIc4++
         VIJYGeSbiOfjOQmSJI5J7y2+8QHmqlWFHnvdlAI1iJXxH6aJl09AvLpCHN72RC0/v73z
         rPNW/RviGMAZUAEVu+bLyRzexUY3dg/QaXeotAFdcnexqly7yj+rXOq2Cx3d0VmkOyd8
         Xv07Clm5SPK9NY+6HHuCKkw4sx/I9MwBANvuA1+yA3fE6mPbdtgxAL3obfE9Znh4IYPu
         so+60k1dtngnXw/obk3frg1N9vfu8bFB1d/nO1kEQoiDni9gxWZUEzZopQOoOVisxda9
         mwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7CCjqYtV5rZ1BPnB8xJbE2LOaBB1/4i0WAcySTW6iW4=;
        b=AO9qpfziGtA/3NlsB3kK449eC9y/cy0j08VSRLF84bILB/wWi4bofigIiIOpvOoxNc
         GJRB9xAdjTTNByyxNr9d9xxBzLA91kCYiUAL6T+wA3qsbLDY5NIgxF1wf6AeQiC7JD7i
         X5eydgvwPqcodZjn+/g1FSXKRzU7vFBijbbLsx907wvTOSAoSOKIpNOdDX5oyJBzuyok
         O5Z1vthib0unIDSpQp4EjSTH1s0roGPGwQI8lyoJF0V/ddrZ5uDU0q8MdAbx0H57kXLr
         byzvmLXie2cXRmcp8Wo4VUXCLr/G89jt5+vF1fX+wLUQDjH/DCpv61zVcptDFGo9/bSh
         70nA==
X-Gm-Message-State: AGi0PubhKjgUDyqYdzGxJAoEzmniB9Q5FNKcQNe3VYwbPCtn6DKJAQ/v
        Eik92FQYcobA/eO1roAXvnqs0A==
X-Google-Smtp-Source: APiQypKwaGysG2hGUewJA7EWz2Xers7oN6ox2nLU1AuZfQ6/AeW4VTV34p40rICyZXOGugtKZ8RQdw==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr3148011wrq.306.1587026751319;
        Thu, 16 Apr 2020 01:45:51 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id n11sm28218236wrg.72.2020.04.16.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:45:50 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:46:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, vkoul@kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: stm32-timers: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200416084651.GW2167633@dell>
References: <20200107105959.18920-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107105959.18920-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020, Peter Ujfalusi wrote:

> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Fall back to PIO mode only in case of ENODEV and report all other errors
> 
> Regards,
> Peter
> 
>  drivers/mfd/stm32-timers.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)

Apologies for not spotting this patch sooner, it had slipped through
the net.  If this happens again, please just submit a [RESEND].

> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index efcd4b980c94..add603359124 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -167,10 +167,11 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>  }
>  
> -static void stm32_timers_dma_probe(struct device *dev,
> +static int stm32_timers_dma_probe(struct device *dev,
>  				   struct stm32_timers *ddata)
>  {
>  	int i;
> +	int ret = 0;
>  	char name[4];
>  
>  	init_completion(&ddata->dma.completion);
> @@ -179,14 +180,23 @@ static void stm32_timers_dma_probe(struct device *dev,
>  	/* Optional DMA support: get valid DMA channel(s) or NULL */
>  	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
>  		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
> -		ddata->dma.chans[i] = dma_request_slave_channel(dev, name);
> +		ddata->dma.chans[i] = dma_request_chan(dev, name);
>  	}
> -	ddata->dma.chans[STM32_TIMERS_DMA_UP] =
> -		dma_request_slave_channel(dev, "up");
> -	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =
> -		dma_request_slave_channel(dev, "trig");
> -	ddata->dma.chans[STM32_TIMERS_DMA_COM] =
> -		dma_request_slave_channel(dev, "com");
> +	ddata->dma.chans[STM32_TIMERS_DMA_UP] = dma_request_chan(dev, "up");
> +	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] = dma_request_chan(dev, "trig");
> +	ddata->dma.chans[STM32_TIMERS_DMA_COM] = dma_request_chan(dev, "com");
> +
> +	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++) {
> +		if (IS_ERR(ddata->dma.chans[i])) {
> +			/* Save the first error code to return */
> +			if (PTR_ERR(ddata->dma.chans[i]) != -ENODEV && !ret)
> +				ret = PTR_ERR(ddata->dma.chans[i]);
> +
> +			ddata->dma.chans[i] = NULL;
> +		}
> +	}

In my mind, it doesn't make sense to keep requesting channels if an
error has occurred.  Please remove all of the added complexity caused
by the for() loop and simply check the return value after each call to
dma_request_chan(), returning immediately on error.

> +	return ret;
>  }

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
