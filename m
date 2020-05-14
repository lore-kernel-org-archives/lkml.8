Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF03C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93AF205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqCVdH0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgENFEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENFEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:04:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:04:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r22so749859pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNdxFa4QrJqUAslQvvR1Ej1cwVVNap3hxsxBpwJX/qw=;
        b=lqCVdH0DG85s8XFJt9av2MXGj4T0fHmhnth6+GRm+5czdRqg8SzBo2fQ21tg1rxbfq
         ybLI+gAxenyU/ClGQd8AtxvFhpjbe1tbt6kJAnKL/bd0dS68CmkA7mq5eH9L9TSGDrMR
         VkkhDRMMe9q7JnDfleItdIjOZct4RM8rkFMF1Vau754MBefsmOgaaL2EC45dM9rMH+DX
         FQ5s8c6EdI5CuKqkwCjloSg/VfMW1NclEAcN9p/0fE0vK46R7hpg69BrKVKABEoEZbTm
         wFyI5aqlBVjQ7dxOJu3SullzfZWFlNhN7VvBOR5MZCUZmYap5y2gjqrU88xQDANavc5S
         ZF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNdxFa4QrJqUAslQvvR1Ej1cwVVNap3hxsxBpwJX/qw=;
        b=DhcSrf0viES+fplmJf2bDky2Ab90UEel+OJDurTL6Tn0F7ROF3t+J634qG+Oi5FTIc
         h8jXepXtEkcG45I7jBWPcdufiF9lg31JQULDkho8fnZ2bpDbnlG1wYXz8Go6sUCXTRmV
         Jsjb2ou+4FUIU15xBqMN2OzK7sNMSe608mQKkxnpQce2FP0KlLhyQk8g7+/t9fMuYBF2
         YNbJCI6q4xE3XEkTS7g5XqMNe5IHBhMrymXxcWkvB0NJOGjs/DLC+SpFdPSxMO+216zI
         pG3z5lE3yPkSxh69g5/nLFoHafuBm1n+PQALmut/t1C1FjICpo58XBURlfAolfMNLhPW
         5wLA==
X-Gm-Message-State: AOAM531RBWwfZNu4/P7Z636L+gkHlVrY/0G4ZPNEwr33GnsI80tyn+gR
        fWscnJV1pR/AOVy3keUexHrcGQ==
X-Google-Smtp-Source: ABdhPJwRiy8/1HoO7DTnCtfH18KWXNfvYdwz4V9uPRi2+kFUWIXvo1uANQsWfdxgpLZtpPG2rO77WA==
X-Received: by 2002:aa7:8658:: with SMTP id a24mr2765320pfo.135.1589432678189;
        Wed, 13 May 2020 22:04:38 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v3sm1073113pfv.186.2020.05.13.22.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 22:04:37 -0700 (PDT)
Date:   Wed, 13 May 2020 22:03:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] remoteproc: stm32: Remove memory translation
 from DT parsing
Message-ID: <20200514050307.GJ16107@builder.lan>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-5-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424202505.29562-5-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:24 PDT 2020, Mathieu Poirier wrote:

> Other than one has to be done after the other, there is no correlation
> between memory translation and DT parsing.  As move function
> stm32_rproc_of_memory_translations() to stm32_rproc_probe() so that
> stm32_rproc_parse_dt() can be extended to look for synchronisation
> related binding in a clean way.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Loic Pallardy <loic.pallardy@st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/stm32_rproc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 57a426ea620b..658439d4b00a 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev,
>  
>  	*auto_boot = of_property_read_bool(np, "st,auto-boot");
>  
> -	return stm32_rproc_of_memory_translations(pdev, ddata);
> +	return 0;
>  }
>  
>  static int stm32_rproc_probe(struct platform_device *pdev)
> @@ -634,6 +634,10 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> +	ret = stm32_rproc_of_memory_translations(pdev, ddata);
> +	if (ret)
> +		goto free_rproc;
> +
>  	rproc->auto_boot = auto_boot;
>  	rproc->has_iommu = false;
>  	ddata->workqueue = create_workqueue(dev_name(dev));
> -- 
> 2.20.1
> 
