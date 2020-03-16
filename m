Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56BDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0820679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl6bstE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgCPPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:52:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41711 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgCPPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:52:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id f11so5090892wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQWUEVlXfznSczAKyGpDi3T2t4zubClSxzSzuBgyOmY=;
        b=yl6bstE+aSegQ4PSIZwfpkI4xv5zEpFCHJTeJOmkwQSJ+I34mLp8AxYTWZ9rJT3sc2
         lfVn74R8N/A5/RlriKIwFzgnhIdRpYphZB/RGS2V7TiOu9jBnvyS/vVHkhpcG/UCkclI
         /Xe8pirR3stVSJMCZatixqgD5qeqsOrizxVPTp5NmPJGHiiNFTlr2SrOO2kgOC4/0W9m
         TaePqXQ0F0j8GjfwG6eC/pF625lANh0WVdHPpEVzOMwvBPZshj8wKu9LXxVj1/SPB9LL
         CEn13SHypRSkWd4ThtiGgPM4UZhcVfHP1IHQBtjQSqNt8bUgTV5XgO5/lnNRElqlP+4y
         Bdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQWUEVlXfznSczAKyGpDi3T2t4zubClSxzSzuBgyOmY=;
        b=b4GhOYmcm1NvUQzVVBkxb2AxoWLguHHxlsXub8zCRH5EL1K6YTFFfnIXna1v/ddS8S
         H5Uv+XrJrzpOYJpniYPPStJucBBVdRmEy4lj58v3LsKzsEGbAmxF4IiWuxB//pk74c2u
         NcklAx/cYvuQkfUYuT6Zr+/XtURT83Ecqwj2aqdUa2+JaH7cGTRzS4vLiNaQ7pPfDB5H
         +W9KeEdsShQmuClBawIPAV8QHeYioMM5hw5vf4shV5G/eUlrPdz+lScQcYCwjp3dF+ao
         PbollZk6I/h3eT/M7Q+HvQROXZ9dxRYlbV9pKK1EVfYBFYwZW9/nIgwV8iSGpKWqk93P
         VCDw==
X-Gm-Message-State: ANhLgQ15PdStOlK/pD6B/sR051n0QUOpkESxFo7KoTdnizt18TnCsxwN
        Y27X4xOhGqMMH5m8sq4nuZ2f3w==
X-Google-Smtp-Source: ADFU+vttr8+4jXiTPQnlMs6N4KDj9oq3qIoO+BGp44KMN8sfSjRCTINbImPpFYK6LbM8TzaWqB/nSA==
X-Received: by 2002:adf:f289:: with SMTP id k9mr37838wro.220.1584373951194;
        Mon, 16 Mar 2020 08:52:31 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id t1sm509263wrq.36.2020.03.16.08.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:52:30 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:52:23 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 13/15] iommu/qcom: Use accessor functions for iommu
 private data
Message-ID: <20200316155223.GM304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-14-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-14-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:12:27AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/qcom_iommu.c | 61 ++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 4328da0b0a9f..80147f82d427 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -74,16 +74,19 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>  
>  static const struct iommu_ops qcom_iommu_ops;
>  
> -static struct qcom_iommu_dev * to_iommu(struct iommu_fwspec *fwspec)
> +static struct qcom_iommu_dev * to_iommu(struct device *dev)
>  {
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
>  	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
>  		return NULL;

Following other drivers, I think this test could move to add_device() (and
remove_device()?), but this is probably good enough for now.

> -	return fwspec->iommu_priv;
> +
> +	return dev_iommu_priv_get(dev);
>  }
[...]
>  static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct qcom_iommu_dev *qcom_iommu;
>  	struct platform_device *iommu_pdev;
>  	unsigned asid = args->args[0];
> @@ -583,14 +594,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	    WARN_ON(asid > qcom_iommu->num_ctxs))
>  		return -EINVAL;
>  
> -	if (!fwspec->iommu_priv) {
> -		fwspec->iommu_priv = qcom_iommu;
> +	if (dev_iommu_priv_get(dev)) {

Should be:

	if (!dev_iommu_priv_set(dev))

Thanks,
Jean

> +		dev_iommu_priv_set(dev, qcom_iommu);
>  	} else {
>  		/* make sure devices iommus dt node isn't referring to
>  		 * multiple different iommu devices.  Multiple context
>  		 * banks are ok, but multiple devices are not:
>  		 */
> -		if (WARN_ON(qcom_iommu != fwspec->iommu_priv))
> +		if (WARN_ON(qcom_iommu != dev_iommu_priv_get(dev)))
>  			return -EINVAL;
>  	}
>  
> -- 
> 2.17.1
> 
