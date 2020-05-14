Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39570206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwlycLhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgENQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:42:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4782AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:42:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so12676996pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gI4bnmYByKweNdOuC96IFyqWNlMnscAaT5flyQkPlhk=;
        b=hwlycLhjl3Zy0ym+AnHUqfZB31rzNjTYpMednXHwi4fGgP65w3Yf29T4IfS6e5+8pJ
         jmjjQBSr+qQN03jn8j6Vpow+sc2H3a9TmyOeaPO3BnXeL2BPQZ0UGuYVxpo57/6JfvGk
         Gb21LtcDUGV03K+iyAdsM28y55kR6nwOjlJ2sykT+SfNVf0ZrtWD3xUMv0fBhrDt6kAL
         ngJxysQtmSovQ3X/W+1AH840CV37o4p+G80sNhxq9oUj5d4jRXH14EympBG49iNRPTGK
         i1x7U/Y7F1JKb497I7OiNkq4vXjFi8ozPdOlJ7y3d9k251QS8+Gcu5lT+620cnbmK9Lh
         DNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gI4bnmYByKweNdOuC96IFyqWNlMnscAaT5flyQkPlhk=;
        b=MIKYUs9zqHP1cKjhDM7QtctMUWN7pP/kuLppv4/GVgEF26TV9apznm9BqCwtXsanVH
         9BkPPt7FZijEISeaiaTdQyX36pRr0/i2UqFsxCdcTH9j0i/XyXCvbklaUxlP/b6TNcyx
         4NGVJxLmLU4L1cmRWs/9+UwlZ9GK6Np0/t9FI1rt31KVbAFKnNwfgEAHIMe/CrI1GlRE
         H60bconSB9tBbDfsonqZ5eZtLDI0Fdxm0508MyaiaeMa7kaUmRo5UEIWeL+K0yAzJ/Du
         oBUK9d8SPnBt2A92kiwiqfz0OFnyiWh5ujzMOu+BItICNQiSY5z2e2EEx4EFVurRskqC
         m4qg==
X-Gm-Message-State: AGi0PubdOZr6RqStyLWTuOYC12HqaUFMUCwoFJIDt9IRfMZtWAvZvpBv
        t3Xd7F2jTx5XjZSZjVrg9lcEjw==
X-Google-Smtp-Source: APiQypKcBn/dTi9vlw5udVYzRQb66ceMl4/mLWeRkf3GwkUH67LPC3vtNGaSakFINRCjAbv7h9NgQw==
X-Received: by 2002:a17:90a:5648:: with SMTP id d8mr41607573pji.163.1589474527502;
        Thu, 14 May 2020 09:42:07 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w11sm2651105pfq.100.2020.05.14.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:42:06 -0700 (PDT)
Date:   Thu, 14 May 2020 09:40:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCH] firmware: qcom_scm: Prefer initialisation during the
 descriptor declaration
Message-ID: <20200514164037.GB279327@builder.lan>
References: <9dac309d985931a02b198714a5ae64fdce8c47ff.1589438283.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dac309d985931a02b198714a5ae64fdce8c47ff.1589438283.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 May 23:40 PDT 2020, Amit Kucheria wrote:

> qcom_scm_iommu_secure_ptbl_init() initialises the args twice, once while
> declaring the struct, and then again by assignment. Remove the duplicate
> assignment.
> 

Seems like a leftover from the refactoring, thanks for spotting this.

> Similarly, move arginfo initialisation to the declaration in
> __qcom_scm_is_call_available for consistency with other .arginfo
> initialisation in the file.
> 

Looks better.

> Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 6ba132be1b6e..eae9c28679cc 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -228,10 +228,10 @@ static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
>  		.svc = QCOM_SCM_SVC_INFO,
>  		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
>  		.owner = ARM_SMCCC_OWNER_SIP,
> +		.arginfo = QCOM_SCM_ARGS(1),
>  	};
>  	struct qcom_scm_res res;
>  
> -	desc.arginfo = QCOM_SCM_ARGS(1);
>  	switch (__get_convention()) {
>  	case SMC_CONVENTION_ARM_32:
>  	case SMC_CONVENTION_ARM_64:
> @@ -742,12 +742,6 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>  	};
>  	int ret;
>  
> -	desc.args[0] = addr;
> -	desc.args[1] = size;
> -	desc.args[2] = spare;
> -	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
> -				     QCOM_SCM_VAL);
> -
>  	ret = qcom_scm_call(__scm->dev, &desc, NULL);
>  
>  	/* the pg table has been initialized already, ignore the error */
> -- 
> 2.20.1
> 
