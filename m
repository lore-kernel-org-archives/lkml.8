Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9159C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30E4207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbbSKgJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgA0Rac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:30:32 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42720 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Rab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:30:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id b81so2906657ywe.9;
        Mon, 27 Jan 2020 09:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oZHC1+WaNyQ1RQmD8lDg7R2NyPlPBpATeNYas3dE1z8=;
        b=gbbSKgJDMd+Dc0wdYQ+B3QvoLZ0SmdoRbKcwOGdhB3xVko+9BtlBFYwu4iEgCQ25mS
         fRu/ATOTok5y+oPPglN39WgYGYSELWA3qDpU0QAw4cTqyEuQyhugnl9l+eAc3k7lMHpy
         v7v5TBQa0bhq6hcqZqDBO+Ws7/U6LNN/voCozfM03R956FSNJ/HpfUDNDqpFb502BGZB
         QHz/uztWHG5EJ9mvFX4U8xH7d3R28ncmR+LdtBgHeGmMN2aZxUrVm0t30jhDJc6GyISJ
         9pZ/AS8MOta7ngR0U6PKFOmLhIFGiA4HLdof5JjvEYQBkWaUYk26MIG0fwOz59Gdxv9g
         qD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oZHC1+WaNyQ1RQmD8lDg7R2NyPlPBpATeNYas3dE1z8=;
        b=rqarTuGERSVn/WpzJ+WFPPUoYlMAzoxiY/raKBniAEAMKNaklvRifz6O8LnMK/BgRK
         m88A3TomNddOclAYCN+meR0uz9Ikb95y6iGC22erZJBE261Br8r7qKORlBwnE6JTGuGK
         NJqsFoeHg7kpBW9Xclvr9nSmACrEW5LMgrNiX4zT6MOcvYu9Fknwv/gLPJFLPPEa6oYE
         j08Gc/G6STUM/2Co2tPe0bmM4dkvn2CvDyadcweUseAj97fmTDztUrnWgJPu0O+/d1LF
         cKu8o56thDzE9OF9UUfpcod0GgezEWrP1qHPxvJpcdIA3xG3gWVRq/MGGozVKwfkA+vV
         1A9w==
X-Gm-Message-State: APjAAAXs34N7poXtwKf9pZ9SaWT0+q9+v8pfcIJSWFAPOuqH83tLNnH2
        M8eqB6xWXXooZiWuRA9H9oQ=
X-Google-Smtp-Source: APXvYqzkShbWVxRKSEyOSDpGxKW8vNiN/4DbCdTnjruNWa6WquVtJjN8C9Qn67xdTMWxVFq1lrxtjw==
X-Received: by 2002:a81:bb41:: with SMTP id a1mr12449625ywl.253.1580146230905;
        Mon, 27 Jan 2020 09:30:30 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id q62sm6898824ywg.76.2020.01.27.09.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:30:30 -0800 (PST)
Subject: Re: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc
To:     Michael Ellerman <mpe@ellerman.id.au>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, ulf.hansson@linaro.org, chzigotzky@xenosoft.de,
        linuxppc-dev@ozlabs.org
References: <20200126115247.13402-1-mpe@ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7cc13334-2765-c800-2242-cb7d2edcc608@gmail.com>
Date:   Mon, 27 Jan 2020 11:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200126115247.13402-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Frank (me)

On 1/26/20 5:52 AM, Michael Ellerman wrote:
> There's an OF helper called of_dma_is_coherent(), which checks if a
> device has a "dma-coherent" property to see if the device is coherent
> for DMA.
> 
> But on some platforms devices are coherent by default, and on some
> platforms it's not possible to update existing device trees to add the
> "dma-coherent" property.
> 
> So add a Kconfig symbol to allow arch code to tell
> of_dma_is_coherent() that devices are coherent by default, regardless
> of the presence of the property.
> 
> Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
> when the system has a coherent cache.
> 
> Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
> Cc: stable@vger.kernel.org # v3.16+
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/of/Kconfig   | 4 ++++
>  drivers/of/address.c | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1ec34e16ed65..19f5aa8ac9a3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -238,6 +238,7 @@ config PPC
>  	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
>  	select NEED_SG_DMA_LENGTH
>  	select OF
> +	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
>  	select OF_EARLY_FLATTREE
>  	select OLD_SIGACTION			if PPC32
>  	select OLD_SIGSUSPEND
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 37c2ccbefecd..d91618641be6 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -103,4 +103,8 @@ config OF_OVERLAY
>  config OF_NUMA
>  	bool
>  
> +config OF_DMA_DEFAULT_COHERENT
> +	# arches should select this if DMA is coherent by default for OF devices
> +	bool
> +
>  endif # OF
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 99c1b8058559..e8a39c3ec4d4 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -995,12 +995,16 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>   * @np:	device node
>   *
>   * It returns true if "dma-coherent" property was found
> - * for this device in DT.
> + * for this device in the DT, or if DMA is coherent by
> + * default for OF devices on the current platform.
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
>  	struct device_node *node = of_node_get(np);
>  
> +	if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> +		return true;
> +
>  	while (node) {
>  		if (of_property_read_bool(node, "dma-coherent")) {
>  			of_node_put(node);
> 

