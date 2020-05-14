Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C482C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D98205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0CuyR16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgENE6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgENE6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:58:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25061C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:58:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u35so756048pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fy4YBkk4dKPrXz1Sz6in3rq8QZwklEzzdmUHwWz7Vts=;
        b=q0CuyR167W+2BNBNi9zP/2Uo5HLrTYi02yqX2gsXiURJvGny1sZnBQuNVC6dB+Jenn
         dZo0jdexaxmCbJxntzQ/rQy2sTYrHnzssTzyjed7H5gwHO623LSN8LsLakEmtj47rYRT
         i1CDdwGC9jd5kU/aYeV0kVUSns/5vIOUKeo3yf/Bq6od7L5fq+tfAq6AT4tm5+Jc03xG
         Hlo7QzEcyYCrZbt90ZrcrjBvV9d9kjnD+KPmpTwQpYOioy8QqwnkPf8ZPcuVwlEzw5I6
         HACuCYW1LIqjhZh2oS5Rw+ibKfvsRuoFElx50bxhm7tFpljDv5VHFZdvXIttrYReFJRN
         P8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fy4YBkk4dKPrXz1Sz6in3rq8QZwklEzzdmUHwWz7Vts=;
        b=rnHOiqwFlDeLPoj0bSG70Wk6b2kZU+Ajh07BxEbZQsRLC4jPicA2EDnpKrJ00bnf1Z
         4ksifhEuUgrZhQBcIF5ahGcsx4FYFKlqaLPei6Kz7XCqH4lmw8dFm/nDJkztVc8JkCJt
         W6zQJm1VpZtfiJfiBSHfNkfjxdbWnVuEpPPcWTZ1YjyxjKD4wtcO70Z0hR4NwcdOqlLW
         gHsZN4pranWuL0dSfbVSEKAPS5KiH420kgBkeNmIfskYJDHkYqjJdHz39J7jz1HbSMbo
         MRLwA0yrEnMFc9DTzD98HWk5yzef8jmYRrysFLPgpPWbSkVWXt+/ymeiuZGMbquskGzo
         bu+w==
X-Gm-Message-State: AOAM533sc5GlN6jv2+mlJIH/zz3Ies0BIYpNAcBk/ahuHyvXkFBGKuyc
        1uc5ez0tul4gQdPhRZf1vRZrbg==
X-Google-Smtp-Source: ABdhPJxyjBQaF0IbDv+oDp7VWgasXey2FK6oPgo+5su8LZ7HawcQevb3Y0t9Ukgg2sHbL3dWhdsSNg==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr2403501pgh.279.1589432314389;
        Wed, 13 May 2020 21:58:34 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x12sm1056388pfq.209.2020.05.13.21.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 21:58:33 -0700 (PDT)
Date:   Wed, 13 May 2020 21:57:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] remoteproc: stm32: Decouple rproc from memory
 translation
Message-ID: <20200514045703.GG16107@builder.lan>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424202505.29562-2-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:24 PDT 2020, Mathieu Poirier wrote:

> Remove the remote processor from the process of parsing the memory
> ranges since there is no correlation between them.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Loic Pallardy <loic.pallardy@st.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/stm32_rproc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 0f9d02ca4f5a..91fd59af0ffe 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -127,10 +127,10 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
>  	return 0;
>  }
>  
> -static int stm32_rproc_of_memory_translations(struct rproc *rproc)
> +static int stm32_rproc_of_memory_translations(struct platform_device *pdev,
> +					      struct stm32_rproc *ddata)
>  {
> -	struct device *parent, *dev = rproc->dev.parent;
> -	struct stm32_rproc *ddata = rproc->priv;
> +	struct device *parent, *dev = &pdev->dev;
>  	struct device_node *np;
>  	struct stm32_rproc_mem *p_mems;
>  	struct stm32_rproc_mem_ranges *mem_range;
> @@ -606,7 +606,7 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
>  
>  	rproc->auto_boot = of_property_read_bool(np, "st,auto-boot");
>  
> -	return stm32_rproc_of_memory_translations(rproc);
> +	return stm32_rproc_of_memory_translations(pdev, ddata);
>  }
>  
>  static int stm32_rproc_probe(struct platform_device *pdev)
> -- 
> 2.20.1
> 
