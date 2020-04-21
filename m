Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49087C54FCB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242A92078C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRhpwjcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgDUB42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgDUB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:56:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D941C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:56:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so5876193pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAjH16kQBGAeeywXkaMxFLlfcw0obRf/vrgqobiQeqo=;
        b=KRhpwjcMGn2Yt8er4JmgUaUzxSwEjOMFXp38EI/0ELCU5mLnqO6llZZPJQgsUv4feB
         0KG3FijZW4qcsFf/NKgxJg+KQP0grSUkMyOFcVcmKfF3ONVf8UKXifWSQkFqldHPtmyA
         W0ijChGCbfIumqlHlllOhI594BuRIQK85NMCyzfJUUYxbZ37KySKqzXG6z52tTncHAUC
         KBnXSB5zO8iNTyMF/7FwQYgDnZZAA6Wyv2NLwmgbmytVi/DRQcggMh9RnGLdb7MEgJi8
         o1x5BloRSxAP+VQhKNepgmCoW7/MFOa/868J3ZQc4BseJ+C1yjg21/cKJ7BXd/lGpgw3
         mLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAjH16kQBGAeeywXkaMxFLlfcw0obRf/vrgqobiQeqo=;
        b=Ngyi+MYUpm3zn7J8d7Vd+CwB5SGZ4K7GLjkXYL7pBaDVjtjifm7kZakrS3JyZ0J+ik
         j5xUMpicyl2nLlUS7s25t6xO1GAXNFHNWGc6pD9vSe8i9mfjs9FEI7nUuMa2tV4/93Jd
         kNfY9JG3O6Fw+xuPp2I2W7Y8Oc2WMYtgyYOTh1WcnHl7kDvdMtEr2gtMEcXNm2OO5qnx
         DKi/Ofz5ARCloH5vMdhVeuCfyGeSBQJr12LVbWWBn9/vRUWWcs//KOP2okxcWtSRJ0x7
         p3OgRzRrzqm102ft0Ihs8mk2ERJoK9Hrt78BVRigjUZD5cV56xMjIiJhNms4KjY3T1N0
         grDA==
X-Gm-Message-State: AGi0PuYBA6j0Syx51VkwEbFptmZAXZnC3IYi7KV5nWNDD+P5248inoP2
        MMbAKyDLROSFdXNCtSchXow2Ig==
X-Google-Smtp-Source: APiQypJAJwaTaJDXtAQzmLZzuBaUW0DygL2RNry9w7rGIzAT6qkP1GaaWf9xyQ6CNSsJu4bRRmgHRg==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr4929416pfi.193.1587434187059;
        Mon, 20 Apr 2020 18:56:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 62sm802499pfu.181.2020.04.20.18.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 18:56:26 -0700 (PDT)
Date:   Mon, 20 Apr 2020 18:56:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, elder@linaro.org, s-anna@ti.com,
        Markus.Elfring@web.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remoteproc: Restructure firmware name allocation
Message-ID: <20200421015650.GH1868936@builder.lan>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
 <20200420231601.16781-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420231601.16781-3-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Apr 16:15 PDT 2020, Mathieu Poirier wrote:

> Improve the readability of function rproc_alloc_firmware() by using
> a non-negated condition and moving the comment out of the conditional
> block
> 
> Suggested-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>

Looks better, thanks for respinning.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index db8a15fc1e4a..45529d40342f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2011,14 +2011,14 @@ static int rproc_alloc_firmware(struct rproc *rproc,
>  {
>  	const char *p;
>  
> -	if (!firmware)
> -		/*
> -		 * If the caller didn't pass in a firmware name then
> -		 * construct a default name.
> -		 */
> -		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> -	else
> +	/*
> +	 * Allocate a firmware name if the caller gave us one to work
> +	 * with.  Otherwise construct a new one using a default pattern.
> +	 */
> +	if (firmware)
>  		p = kstrdup_const(firmware, GFP_KERNEL);
> +	else
> +		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
>  
>  	if (!p)
>  		return -ENOMEM;
> -- 
> 2.20.1
> 
