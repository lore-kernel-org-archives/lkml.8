Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C03C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED512492C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+3Sl6qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgELWP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731298AbgELWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:15:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C911C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:15:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so10075213pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJod+5fsMtd+dim7jslclOHDOoBqhHl7EZkBRegzADo=;
        b=f+3Sl6qy2CRnMf6GngaO3H/TZjAI09QFRJK+1k+MA5BNIQS8cRco0hTCN2qeBUXE2T
         7OA/6gdgd0jjGBAjjRrNAC9PDUmfA1egurpHUStsw9qdMa0E3NbSqs6fH+EhBV1isYmD
         d+jl0+cG1ziI0uOi5IcZ7SPycTIfpia9SqiJyi7vZJRfV24Kjjt2m8n4Ik67cR15nxvm
         +JOb0fBvS0clxK8p7aDkJepS8uoxqg4QU9IC3rvtJ9VsI5815PlxUvmgQR/8xlWlypLM
         wjzRX0le8ul7/7tknreRr0yDV1KMOu2Pc2Pf/tlDcCVZ6no1gya6FUAdyi9SBy7jfftx
         H4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJod+5fsMtd+dim7jslclOHDOoBqhHl7EZkBRegzADo=;
        b=t1sBNR0zBaH6GquIHO7Gqm/UKKthCY46OIAYW63WI6dauDkRsMrF30BK7E7DIBVKEj
         e+RS+6Qy0VXhsZ/Jt0xLRLo+alb/EKCLUr9KVmMcoHSHEuBZTKbupmYbc7PBGDtGNRt9
         5pvtYFwBzRZK+zIjk7Z8AD/GW6NVQzj457lr1WjbZEIdwjQQjhLoHEl/8A+ESInboHwE
         fiTMPW4vm7XrQt+86Kor/CNE75H+GRb/n2RAbIUydavWyoOsjM7DeamecHLVh+0pzfHc
         Yr1zXwTXiCF0TfWjyT9KB4jTy8bEEbieiaEI/tVpsI8AUfQzsMVwv6v45ywX++gAu0vJ
         JT9Q==
X-Gm-Message-State: AOAM533GZLZAovLpa+mNgeSomNrl3xqOltHUI1dLhXxSy4f768Ts96QZ
        M391VcrJcB/lf8usZ/Pe5TF6tA==
X-Google-Smtp-Source: ABdhPJz/xduW9nZ527Fik6xhdXdq9tt5M3Y34P1RiUnTpI2h/2tjofka+6/m3Okpm9jXomYYXEyDaQ==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr4892744plt.264.1589321727569;
        Tue, 12 May 2020 15:15:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v64sm13005215pfb.20.2020.05.12.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:15:26 -0700 (PDT)
Date:   Tue, 12 May 2020 15:13:54 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add entry for Qualcomm IPCC driver
Message-ID: <20200512221354.GO2165@builder.lan>
References: <20200508182703.29021-1-manivannan.sadhasivam@linaro.org>
 <20200508182703.29021-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508182703.29021-4-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 May 11:27 PDT 2020, Manivannan Sadhasivam wrote:

> Add MAINTAINERS entry for Qualcomm IPCC driver and its binding.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..cc2fb991cc0d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14013,6 +14013,14 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/iommu/qcom_iommu.c
>  
> +QUALCOMM IPCC MAILBOX DRIVER
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +F:	drivers/mailbox/qcom-ipcc.c
> +F:	include/dt-bindings/mailbox/qcom-ipcc.h
> +
>  QUALCOMM RMNET DRIVER
>  M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
>  M:	Sean Tranchetti <stranche@codeaurora.org>
> -- 
> 2.17.1
> 
