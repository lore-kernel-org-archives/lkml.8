Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F83C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE88822574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGc8yYLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGNRRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgGNRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:17:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00918C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:17:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so1921585pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hnEFouxs+we3yCbXczH8V8BowgDMhEQabzvQ7VTQSUs=;
        b=fGc8yYLs91rKUbePsXS8Omz/SMuyt3n7nXMuiwyo9zE3Ttv+pAC1IlQwkpIya38CCW
         HByWzm4683r8rMc8n+GzW4h2LZ8swZqnWuNU6Ybv9BdUQs6ZFacZYFwf0rdGOTIuJyfd
         9UTCtvrp4sFnv+ZLM40jX5XQe3WKr52/JZtxUzR7QDuLglqIJADP62Fftgh7oNEOfLka
         sDNtNXfPLX026CAeZ6mevAW3L0KtJN4i9DI66mI7vesoVIZHooLFuiVAIvFUo7K3F5gE
         t/YCDb/zIDIigaun2Mac91nNtYR5wATCIGbXxBdKSsu29Upd/6MxQmcs0WfbuHzOloFr
         V85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnEFouxs+we3yCbXczH8V8BowgDMhEQabzvQ7VTQSUs=;
        b=k+CIcI4/0/iqkf12cFN3LeToCuF2y3EGPnP2+FEgSNNyzVmg6VhaR7JeUN1fLO0n+W
         a7mFxnyxAs3hqd8qHv9Swi38ngYXeOw0ACDHWmovOZG69A3hpA9xwkBWoZ79M8KkpSlE
         zLAuSjv3odEECqKMURs3nn/CcPjftEZgFWzymw5uFwTwuvXDMFQL9+1aDUkBBSsI1zkn
         b12OMVmLBurOYFyxidmrssCn7qhXyq9eeF8QU7mgo6FFUXaYscg+OoYPXNWCfLVjs6Tc
         xrqE3H0Kv4pKORJU3yf7Y3KpElw+BwKmS84N6T2FvRNAia+6tQN2k5n+0xVkmY1rSTIm
         lT0A==
X-Gm-Message-State: AOAM532OBpuhDXDyx+fKU9j+te/3dkeunwdcOhBdR/6m/b370tW7BmwR
        IHlAsaGjjwFiQnN2GTSRpBy8
X-Google-Smtp-Source: ABdhPJwp8WPJacRREeYurMSXd2PZPgxhOF/urNM0WAhQhjFkuxyGfC5yfSDtHEpTWWQOC95UvhFyEA==
X-Received: by 2002:a17:902:7e01:: with SMTP id b1mr4839837plm.310.1594747068418;
        Tue, 14 Jul 2020 10:17:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d83:a4f:d:a14d:ca62:5c15])
        by smtp.gmail.com with ESMTPSA id c27sm17191410pfj.163.2020.07.14.10.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 10:17:47 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:47:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 18/25] pinctrl: pinctrl-bm1880: Rename ill documented
 struct attribute entries
Message-ID: <20200714171742.GA7260@Mani-XPS-13-9360>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-19-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713144930.1034632-19-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:49:23PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/pinctrl-bm1880.c:40: warning: Function parameter or member 'pctrldev' not described in 'bm1880_pinctrl'
>  drivers/pinctrl/pinctrl-bm1880.c:40: warning: Function parameter or member 'pinconf' not described in 'bm1880_pinctrl'
> 
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pinctrl/pinctrl-bm1880.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-bm1880.c b/drivers/pinctrl/pinctrl-bm1880.c
> index d1a7d98367870..a8e267237435f 100644
> --- a/drivers/pinctrl/pinctrl-bm1880.c
> +++ b/drivers/pinctrl/pinctrl-bm1880.c
> @@ -22,12 +22,12 @@
>  /**
>   * struct bm1880_pinctrl - driver data
>   * @base:	Pinctrl base address
> - * @pctrl:	Pinctrl device
> + * @pctrldev:	Pinctrl device
>   * @groups:	Pingroups
>   * @ngroups:	Number of @groups
>   * @funcs:	Pinmux functions
>   * @nfuncs:	Number of @funcs
> - * @pconf:	Pinconf data
> + * @pinconf:	Pinconf data
>   */
>  struct bm1880_pinctrl {
>  	void __iomem *base;
> -- 
> 2.25.1
> 
