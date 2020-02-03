Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368CBC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079CE20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bp83Pi2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBCSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:05:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34646 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:05:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so6169023plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKuFB5E1oxEAAV+N9k0A26pCTgfaStT9oN6zKZCrLv8=;
        b=bp83Pi2dgb5hRetlS7exSO9BmknI8Hu/DMqkw7DZL9xAz0wLy+eg7JzfM3kO6bgZSh
         HFm91d1X6Aj/HVWmbkP+w9sWz6v6sG/6yCbf3h3zHlerHsJtXup08CbrmyJEhIm22XQa
         AXxS8CEXEXMys6Opvh0A55noAXE7KSr24Pfz3sGicZYkQ3rO5LMZbqM3aSUOAOaOM0bH
         YkUVvnGhkJUYbK4zbAbdfvPsGK6Tnz8rjNWtXjMK3DFILNdNsa5u6I8uu+C2yKmJ943V
         oz5rw0ViLz8/6syqhjrBW8CyAgHNARZ16xgtXiwGj7bX89RA1+vyCFnu+0nZyk1adk5D
         F78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKuFB5E1oxEAAV+N9k0A26pCTgfaStT9oN6zKZCrLv8=;
        b=E88d8wOPBHX9C0ymRVpDHnotR3wotYs7cQA5PWPNiUhvVhqd82vPqmAzBXXcuEe0Jw
         ldCS2sWWb2P9BXI9+qztFagRphDbQIYoDhpQFay476p8oaOli48patZxn6ZEyYlJZIv1
         di8yj34j201nIcVs8GcepkkAMOs84ZF5NNmm5iE3//AKBQ0oj2YMHiT3qPjRGHth2aan
         Z4xeVVWjKAw9KcOcpD3QC5dsYJ7UqyoaSIg6HfJTpZgCPmNYFC9CudVozjWcDHwu3NNf
         NnKNOZ4gEGdclszQ+1iVu0DGa2H2pJHCxakCgIVFfxN+ju+MAo7hV51RDoGsLKNpil2K
         uy3g==
X-Gm-Message-State: APjAAAU6WDSzQw7G0MkDtmTW4kuSj6ul7xFb2yIpnMDyPLW5cFuzqig9
        N43f8XIFDiPuLlsQOd2Kshdo+g==
X-Google-Smtp-Source: APXvYqxZIxDYwXggwmD/lgCeaDGAzEZKvP0x6vKPSzZerdydE/cCyw/jeeN+8rnbZOA2VoW8Z1SncQ==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr24370224plj.184.1580753151209;
        Mon, 03 Feb 2020 10:05:51 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm127434pjn.2.2020.02.03.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:05:50 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:05:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/7] drivers: thermal: tsens: Release device in
 success path
Message-ID: <20200203180548.GE3948@builder>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <332d79312d2618c96adaa0f125ea033e49f0af5d.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332d79312d2618c96adaa0f125ea033e49f0af5d.1580390127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:

> We don't currently call put_device in case of successfully initialising
> the device.
> 
> Allow control to fall through so we can use same code for success and
> error paths to put_device.
> 
> As a part of this fixup, change devm_ioremap_resource to act on the same
> device pointer as that used to allocate regmap memory. That ensures that
> we are free to release op->dev after examining its resources.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 1cbc5a6e5b4f..013750fff8b2 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -602,7 +602,7 @@ int __init init_common(struct tsens_priv *priv)
>  		/* DT with separate SROT and TM address space */
>  		priv->tm_offset = 0;
>  		res = platform_get_resource(op, IORESOURCE_MEM, 1);
> -		srot_base = devm_ioremap_resource(&op->dev, res);
> +		srot_base = devm_ioremap_resource(dev, res);
>  		if (IS_ERR(srot_base)) {
>  			ret = PTR_ERR(srot_base);
>  			goto err_put_device;
> @@ -620,7 +620,7 @@ int __init init_common(struct tsens_priv *priv)
>  	}
>  
>  	res = platform_get_resource(op, IORESOURCE_MEM, 0);
> -	tm_base = devm_ioremap_resource(&op->dev, res);
> +	tm_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(tm_base)) {
>  		ret = PTR_ERR(tm_base);
>  		goto err_put_device;
> @@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
>  	tsens_enable_irq(priv);
>  	tsens_debug_init(op);
>  
> -	return 0;
> -
>  err_put_device:
>  	put_device(&op->dev);
>  	return ret;
> -- 
> 2.20.1
> 
