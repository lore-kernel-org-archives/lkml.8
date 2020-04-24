Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45957C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B8B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSDEm3dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDXILn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDXILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:11:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36647C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:11:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so9424537wmk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hiE27VPhmZb7xhRucKTopRYedmpv9Tlk0yQXbcKINMo=;
        b=SSDEm3dhHrERptiGlqEfdVxgtY6zgNxL1VHMMmjQ/ueete9/H30cRCznUKkCBJsX7S
         r0ykQfWgh04nFs/p2IUrMidZvjFD8Ejzd/u3NUJO9212/06rsl8YcMBUqMsJ241q/gjC
         yXpXPIuvAG9auH6zJ996EgF18J3+Dinar7k/kbBsJsrxkdPaDLYIp3+3/h/BZIFAxmEv
         654ldb3F5rYoJwRGNLaOD3S3f1ssqI1t2bX/ar6esZnMSk1y3qtl+hvJUplJoE6YlIlf
         8e40gJpLxNKcYznfh6fZeEHTq4kAR9+tzjaGa8+J0GlFu4ZWCcg1xnzdoNKcIjtC8P4X
         awYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hiE27VPhmZb7xhRucKTopRYedmpv9Tlk0yQXbcKINMo=;
        b=mFBeuegsymuWBkc9w5JQ7Qm8ArxfHcrJVbIBlwUpOBPJJxxony6/7IcKmYEkGW+Rbi
         GD8j7fHRks9RVj7hWipP6wfc/M2z7MfQNKCbh+nq7lZ1a4qKQfg1Xv1qB5Yv8arCglzv
         ZN/THOJ5PzAf3t33DxW6jq5wNDFunXaeG2rMyadOFK6j0vCxjgTW/UYiSukuhww8vfG+
         U32iocvIzIdAqEBE49x2k0kVlEtbLuuSDavACUzmCo5GOKQ3PpKc5aAjcppzUWnlxTC1
         3O2RE7AsVTYvsuDXRsPIpwqwYHxC0G88dQ9r8NJzN0HK0ZxrZbckiCflJtNpX1VyJM0m
         z4yg==
X-Gm-Message-State: AGi0PuZZoRQIxVNJvw8u4a++Ll4BpZVb38oif/6mLtfgDgxcFYrgcqbx
        2m2P9aKvw21xIm9+botR+uRPTw==
X-Google-Smtp-Source: APiQypLrTlKKZ8zXDk4KIpM41QEUlUP+Pm0BiB7DNUGh0rJ/FzMU38AY95jrng1fM/1iZMrZRyKjHw==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr8443479wmi.44.1587715900759;
        Fri, 24 Apr 2020 01:11:40 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id j68sm7335309wrj.32.2020.04.24.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 01:11:39 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:11:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     arnd@arndb.de, broonie@kernel.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: syscon: Support physical regmap bus
Message-ID: <20200424081138.GP3612@dell>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
 <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Baolin Wang wrote:

> Some platforms such as Spreadtrum platform, define a special method to
> update bits of the registers instead of reading and writing, which means
> we should use a physical regmap bus to define the reg_update_bits()
> operation instead of the MMIO regmap bus.
> 
> Thus add a new helper for the syscon driver to allow to register a physical
> regmap bus to support this new requirement.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/syscon.c       | 23 +++++++++++++++++++++--
>  include/linux/mfd/syscon.h |  7 +++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 3a97816d0cba..92bfe87038ca 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  
>  static struct platform_driver syscon_driver;
> +static struct regmap_bus *syscon_phy_regmap_bus;
>  
>  static DEFINE_SPINLOCK(syscon_list_slock);
>  static LIST_HEAD(syscon_list);
> @@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
>  	syscon_config.val_bits = reg_io_width * 8;
>  	syscon_config.max_register = resource_size(&res) - reg_io_width;
>  
> -	regmap = regmap_init_mmio(NULL, base, &syscon_config);
> +	 /*
> +	  * The Spreadtrum syscon need register a real physical regmap bus
> +	  * with new atomic bits updating operation instead of using
> +	  * read-modify-write.
> +	  */
> +	if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> +	    of_device_is_compatible(np, "sprd,atomic-syscon") &&

Please find a more generic way of supporting your use-case.  This is a
generic driver, and as such I am vehemently against adding any sort of
vendor specific code in here.

> +	    syscon_phy_regmap_bus)
> +		regmap = regmap_init(NULL, syscon_phy_regmap_bus, base,
> +				     &syscon_config);
> +	else
> +		regmap = regmap_init_mmio(NULL, base, &syscon_config);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
