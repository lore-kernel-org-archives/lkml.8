Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02A9C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85377208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6Nbi0Et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDBGPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:15:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:15:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id b1so1367891pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07RUzSF98HDlKkHMcwTokc6D2qHFZsro2icdPsGci64=;
        b=J6Nbi0EtdSwrriubNlSp++jvgCp+itwBO6E1gZlhnp1tqF3mpnr5T6tnBxeaQwrDEa
         giI0ImC5VpXAIy8zfGbzpjDr/l3dAiTdfGSI3QMbNeQSE5TXyE+3l7hNihvkcY8jZILo
         t+qiWU0ey10SDTqykpvJn7jZuTzOTUqpDrgCydLj+pZjAJUT61dRXlW8USCKduGyb6jx
         T7Vx5+Roal6VuMiEflOOlYvBElMDBA3C5ZH/i8eDFiR7pPrEOJ8EMqeWo/ON3iuOVvNY
         6gM3ys92xRR5cp8mW3CDEF6e29ywWZLSypipsA6y/QFglFGJZKvW5Ov6ZhiqAob6BVd4
         RRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07RUzSF98HDlKkHMcwTokc6D2qHFZsro2icdPsGci64=;
        b=KyHdQtQ9nhyJ5fSywZDU6f97noWhkPDEkBThp955XMn7YkvNcpHr898kamwkYadkRW
         j7VOSv8ofBlp3qQewIysUOy4UJSxLFLzkaFRIOKQH0OkF+J35fgjheOAMBFd53f15PKL
         9BTcMYiZKw4xy8VmMP6qz6RLoN/f5cjTKv4aqZegrfcij1Hi7lA5x5KZi+0ehnspUbnY
         1P9bGw9kzsHz625+op9Vva0zQ+VW8DMhjbZftCd8b9RIuYTTNUmvLZQxb5irOmk0Jop9
         imZnlm5Os60h4cwJz6M3eK4UqperJ/iO6RXGWoqqltYWgLD7LqGd517mI4WcIEsCpepx
         O+9A==
X-Gm-Message-State: AGi0PuZ2HZG5HGvb4tEq/qeNy1+eyw0raHWDvrBSn/5X6Yd9ZfWuFkIL
        Mbx83A6ULlDzeFyDRcO4TcslNhg5ZgU=
X-Google-Smtp-Source: APiQypKKGvDjseFizAmJpesEiYx7AGhcOrNqdIFHPsRABhrQ3IMWfXS6wrqqHdpRN9Xq3gst+TB1Bg==
X-Received: by 2002:a62:2f01:: with SMTP id v1mr1615968pfv.136.1585808109592;
        Wed, 01 Apr 2020 23:15:09 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id fa16sm2942071pjb.39.2020.04.01.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:15:09 -0700 (PDT)
Date:   Wed, 1 Apr 2020 23:15:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     robdclark@gmail.com, agross@kernel.org, joro@8bytes.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2]iommu/qcom:fix local_base status check
Message-ID: <20200402061506.GF663905@yoga>
References: <20200402060333.9156-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402060333.9156-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Apr 23:03 PDT 2020, Tang Bin wrote:

> ------v2-----------------
> As requested, add some {} around this chunk.
> 
> ------v1-----------------

The changelog typically goes after the ---, as it doesn't add value to
the resulting git log. So please drop the above 4 lines from the commit
message. And please use ./scripts/get_maintainer.pl to find your
recipient list.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Release resources when exiting on error.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/iommu/qcom_iommu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0..c08aa9651 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -813,8 +813,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	qcom_iommu->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res)
> +	if (res) {
>  		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(qcom_iommu->local_base))
> +			return PTR_ERR(qcom_iommu->local_base);
> +	}
>  
>  	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
>  	if (IS_ERR(qcom_iommu->iface_clk)) {
> -- 
> 2.20.1.windows.1
> 
> 
> 
