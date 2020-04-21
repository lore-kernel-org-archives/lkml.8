Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56CC54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D322070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoVazIEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDUCAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgDUCAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:00:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99CC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:00:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g6so6020723pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4InmVO6JKy8jWT/SB4bH3XMPT/5NR1hz4LJU1BqRqK4=;
        b=EoVazIEbZWDIkaVVsJ3u5wYWUkrrx16Lbe1FXgnTlf3Ld2rKWU9bK95gJo2LGSbHrG
         IH+dT2m1vtGQ/7FpdAhZFoCJ+Eofk9VENEJuZZVHHz9OoLljtnO9nmdfwKMAUnU2PbHB
         3S6239y11kzhs92gNt0Z5AvTH6xS0m1i3AeRdHMoEVAjcIWqQ9vMq/rPfuCoTkwPtFm7
         dYsnILrYARE0HhJkJugi6BSpGx7vw/Ob6dremKOPRzZcmqPa9FK49794i/B3ERXTJXdC
         POfk625K4XbY2v1GPd2WO4cVJcurralOyseLMSRN+dnnHHEZ57xa+QDFLx0SebQC8SnR
         fIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4InmVO6JKy8jWT/SB4bH3XMPT/5NR1hz4LJU1BqRqK4=;
        b=ox1aV8arQZ1TTrLzQKHNkeaRMKykKMmYsEmTbm3YF1Q1O5I18hf9Ruks4fEDBKqJ9x
         fWwksQ96XgzVYaU08JoVGvzR8v1Jbgl1FzS5/W9OKDO6YtIkXEflj+s3ltWto9yUkm3S
         QdIeSDEWnNAqznwLYh5IM9RPWhrWMDAxRfHlgtiIPA7FKZ8+TSXHwMKUZdlKpXB5Q1xH
         kuCya0H2gNr2i8idW2qIA2TSvHntURw4/ZfffDhrF66k6wPTOBAbU9Ui2zR4PW8dhOSf
         5dvz54PnjhT5HE/MWb2olP+ZgwFCbcqp8KWFipzOnlMeBlYtyTNJVJL9MiShZBWfARlU
         epXQ==
X-Gm-Message-State: AGi0PuZ7JAo+dg9fwYPv4e+8Yq4nFV0dCCCua352zZE9MVjRJgbvhPSs
        w33MTIqzzatCIYBffMsSdKLl0g==
X-Google-Smtp-Source: APiQypLMxhePouG/X61twJMb0pOD1F3n0uDB0sDZzQP92Vq5peJt53bbT5TtL64T11DWthkyuFGrRw==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr19957617pgm.322.1587434443829;
        Mon, 20 Apr 2020 19:00:43 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p19sm813729pfn.19.2020.04.20.19.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 19:00:43 -0700 (PDT)
Date:   Mon, 20 Apr 2020 19:01:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, elder@linaro.org, s-anna@ti.com,
        Markus.Elfring@web.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] remoteproc: Get rid of tedious error path
Message-ID: <20200421020107.GJ1868936@builder.lan>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
 <20200420231601.16781-5-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420231601.16781-5-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Apr 16:16 PDT 2020, Mathieu Poirier wrote:

> Get rid of tedious error management by moving firmware and operation
> allocation after calling device_initialize().  That way we take advantage
> of the automatic call to rproc_type_release() to cleanup after ourselves
> when put_device() is called.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Acked-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_core.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 15318507aedb..6fca4e2c0dd7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2084,12 +2084,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	if (!rproc)
>  		return NULL;
>  
> -	if (rproc_alloc_firmware(rproc, name, firmware))
> -		goto free_rproc;
> -
> -	if (rproc_alloc_ops(rproc, ops))
> -		goto free_firmware;
> -
>  	rproc->name = name;
>  	rproc->priv = &rproc[1];
>  	rproc->auto_boot = true;
> @@ -2103,12 +2097,17 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  	rproc->dev.driver_data = rproc;
>  	idr_init(&rproc->notifyids);
>  
> +	if (rproc_alloc_firmware(rproc, name, firmware))
> +		goto put_device;
> +
> +	if (rproc_alloc_ops(rproc, ops))
> +		goto put_device;
> +
>  	/* Assign a unique device index and name */
>  	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
>  	if (rproc->index < 0) {
>  		dev_err(dev, "ida_simple_get failed: %d\n", rproc->index);
> -		put_device(&rproc->dev);
> -		return NULL;
> +		goto put_device;
>  	}
>  
>  	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
> @@ -2130,10 +2129,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  
>  	return rproc;
>  
> -free_firmware:
> -	kfree_const(rproc->firmware);
> -free_rproc:
> -	kfree(rproc);
> +put_device:
> +	put_device(&rproc->dev);
>  	return NULL;
>  }
>  EXPORT_SYMBOL(rproc_alloc);
> -- 
> 2.20.1
> 
