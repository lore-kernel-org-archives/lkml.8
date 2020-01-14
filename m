Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DABF20728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579046122;
	bh=j97HhDHhrFtB/nEHEEHmgqcJ1dKWPifh1Skfr0SnF7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohbSJ0zD9Yg4zpplrLQj0k10SND07p9KltbsPb9OgE7yMWn7zdK/gU2CAGkMz1V3A
	 4ymQKlbIoSc+P3Z1RQYa0+FuRmI151zkFeCs7zCMx6aVsi9OHgNkqz9ohbK5COJx1X
	 Vu+e6aLpwMzXtFzSbhzT5ZgK1RPS4sEvbd5F/vhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANXzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:55:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33304 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANXzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:55:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so13716816oie.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=odqqUFTuUS3R752w1Ono+r4G/xaTNWl9voQP5TwOR8o=;
        b=Ij2LwYuErLkKt2la6uRhhPs/yNoDuSg50RrK+PDk8v8rMoIgLs9YCirUBpK6HX2WcS
         jKwqIwAOf1lb/bvC5TJpvzxNYqQhNdtk8Hu7l0ztSEizSi6i55FlDKQQRRYcJA846tO4
         zmUxWTj+IX8aTZ7PovhkdEUEFjX563KqKRjGAm6pIs6SIUpV6StZPavdqDgiJpSaN0dR
         v/p1cyhBzhhEwtZWH9LDzRwhoV39vUyrPWyXW/VrvHpwyAjbYeABFdMRxdF/0W9LSCFF
         UpdDt2VTSK2QG/9NsB8ZKGRg3I4w0jcxFSRR/+frsqNFwJhaHgNNHwSeD6+P7dITTcVr
         RbGg==
X-Gm-Message-State: APjAAAUTDphWci5Q3G41ihq+/ISoRDfVJW0oXxMVr5eDN+mBM+r5LrV1
        v3aPJUGF3N3nqps7bHFfoMJ7MvQ=
X-Google-Smtp-Source: APXvYqwpPf9QpqpPBXzAeALiNixzMDJcsTkM90VDA3hkQFh8R6ExBH+0+Ff7we+EoAJng8WIu/TDZw==
X-Received: by 2002:a54:4896:: with SMTP id r22mr18989470oic.30.1579046120419;
        Tue, 14 Jan 2020 15:55:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h1sm5949713otn.6.2020.01.14.15.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:55:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:55:18 -0600
Date:   Tue, 14 Jan 2020 17:55:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jyri Sarha <jsarha@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] of: add more dummy helper functions
Message-ID: <20200114235518.GA11575@bogus>
References: <20200108134936.3617013-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108134936.3617013-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:49:28PM +0100, Arnd Bergmann wrote:
> The new phy-j721e-wiz driver causes a link failure without CONFIG_OF:
> 
> drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
> phy-j721e-wiz.c:(.text+0x40): undefined reference to `of_platform_device_destroy'
> 
> Add a dummy version of of_platform_device_destroy to avoid having to add
> Kconfig dependencies for the driver. As there are a few other functions
> without dummy implementations, add those as well for completeness.
> 
> Fixes: 42440de5438a ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/of_platform.h | 39 ++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
> index 84a966623e78..f5dea3de4856 100644
> --- a/include/linux/of_platform.h
> +++ b/include/linux/of_platform.h
> @@ -48,28 +48,49 @@ struct of_dev_auxdata {
>  
>  extern const struct of_device_id of_default_bus_match_table[];
>  
> +#ifdef CONFIG_OF
>  /* Platform drivers register/unregister */
>  extern struct platform_device *of_device_alloc(struct device_node *np,
>  					 const char *bus_id,
>  					 struct device *parent);
> -#ifdef CONFIG_OF
>  extern struct platform_device *of_find_device_by_node(struct device_node *np);
> -#else
> -static inline struct platform_device *of_find_device_by_node(struct device_node *np)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  /* Platform devices and busses creation */
>  extern struct platform_device *of_platform_device_create(struct device_node *np,
>  						   const char *bus_id,
>  						   struct device *parent);
> -
>  extern int of_platform_device_destroy(struct device *dev, void *data);
>  extern int of_platform_bus_probe(struct device_node *root,
>  				 const struct of_device_id *matches,
>  				 struct device *parent);
> +#else
> +static inline struct platform_device *of_device_alloc(struct device_node *np,
> +						      const char *bus_id,
> +						      struct device *parent)
> +{
> +	return NULL;
> +}
> +static inline struct platform_device *of_find_device_by_node(struct device_node *np)
> +{
> +	return NULL;
> +}
> +static inline struct platform_device *of_platform_device_create(struct device_node *np,
> +								const char *bus_id,
> +								struct device *parent)
> +{
> +	return NULL;
> +}
> +static inline int of_platform_device_destroy(struct device *dev, void *data)
> +{
> +	return 0;
> +}
> +static inline int of_platform_bus_probe(struct device_node *root,
> +					const struct of_device_id *matches,
> +					struct device *parent)
> +{
> +	return -ENODEV;
> +}

This and of_device_alloc are pretty much only powerpc functions, so I 
want things to break if there are new users. There's one user of 
of_device_alloc() and a couple for of_platform_bus_probe() which is 
deprecated in favor of of_platform_populate(). I think we can get rid of 
the remaining x86 callers.

(I have the same opinion on of_platform_device_create too, but I've 
given up on that).

Rob

