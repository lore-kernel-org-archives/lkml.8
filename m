Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700F5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3273D206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYTp9ksr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgDAXgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:36:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34038 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAXgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:36:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so627219plm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sQjK7qegajNFKiTPiHQ5Z456M8UVRRDL3FiaA3tyTGs=;
        b=LYTp9ksrfOguPgd3XflLQaiRWyQXN2zGAWee6altMkkc2NYCumREpFdzZpExQW1Qq6
         H8ZK7mzZ37Z7HLmx7GiNCrpchU54WVA51+coaid+eY4HnF3doY4Bz6inL0koZuy2NFm+
         myL0WIcVxF+sjBOXLcspklxcfpViozESXgSbwrR6fXFLGxxXOmGleluSQRGL4ByE3r2Z
         iTfxXwBN81CuR21mLL2wMwJpZBiOM5UYcYhp4lAdlLa+DdMXxsp1ligXXoRMqRrzzeYn
         HZcOLvEQ+CKuDVUiZoqRasDJnI/9VYQ1xXn48wUYREmgLpyrAXI4xbbEXqXfYwFJnCYa
         hb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sQjK7qegajNFKiTPiHQ5Z456M8UVRRDL3FiaA3tyTGs=;
        b=WMutjvechzkkhD9cyjhQRo2x7cnmLxmfvm3+68eF0D0JChEQILfRE/N6jZjk5LH2Wd
         pErgYRdqtWToBHFSQ+2JFmXnyHh21COgHnwbpu7Q1/OHu04wxzMvr5qmedjZoibjlckk
         ZfcorNV/oLnfS+JcIqvnw/olyMEyotIQV3r2NToKPrWLRzU3bovMLw36J1Cx8E+1Qq0v
         ZTO4L95J73dbUMlWGEVOUfWKX8WyviingM25hmPh24YyzKVbP+CLDBiXdo1sllbIWVI9
         I7YE0PI2pq6LM5btRbpMJ398JEED95Ckeep0pO1tXQ5GZXvdOvIRtmVQY0kGw2doKuD8
         YyMA==
X-Gm-Message-State: AGi0PuYaCsp0PhDKn9a8SpkSM4gWBwHOPdugptgLTjXEz4akqxLupxUY
        waJd/YxFoYa0r5NMXotvvs0K0A==
X-Google-Smtp-Source: APiQypIJCdx4hNppaFM2XL2D9B8R+4Fnma25HLV1H6qHB+zBdia/d//vCt3FUseVJwiQZfZ1RwBbVw==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr275281plv.297.1585784205324;
        Wed, 01 Apr 2020 16:36:45 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a15sm2369442pfg.77.2020.04.01.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 16:36:44 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:36:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     robdclark@gmail.com, agross@kernel.org, joro@8bytes.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom:fix local_base status check
Message-ID: <20200401233642.GI254911@minitux>
References: <20200401152008.16740-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401152008.16740-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Apr 08:20 PDT 2020, Tang Bin wrote:

> Release resources when exiting on error.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/iommu/qcom_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0..d4ec38b1e 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -815,6 +815,8 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res)
>  		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(qcom_iommu->local_base))

Good catch! But while it works, this is not under the if (res). So
please add some {} around this chunk.

Regards,
Bjorn

> +			return PTR_ERR(qcom_iommu->local_base);
>  
>  	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
>  	if (IS_ERR(qcom_iommu->iface_clk)) {
> -- 
> 2.20.1.windows.1
> 
> 
> 
