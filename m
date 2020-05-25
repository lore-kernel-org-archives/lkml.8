Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B21C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBC72070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sQRXsKLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbgEYNYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:24:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:40125 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388685AbgEYNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:24:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590413090; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Z6M6zOHgv5Mz3vquD9glzltuXPL2ESOK8Uo9Xh9Nvfc=;
 b=sQRXsKLL+URfU+qsS0At6yDelkDgDx7nwyUppWlVXCKgiTnZbcuMirBIzLJhgtCveHJ6Ir8M
 qS0y6KsT2qf4NMwnjoq8QIqZWasK5oGRp8oiaOmEWQt8m6XvibB+N9vOIEabCqVQWr0gyrHC
 Pf+EG5ucZ+zSfGgEvg/Kir6svUc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ecbc712.7f1840388768-smtp-out-n05;
 Mon, 25 May 2020 13:24:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91314C433CB; Mon, 25 May 2020 13:24:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 796AFC433C6;
        Mon, 25 May 2020 13:24:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 May 2020 18:54:33 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH] iommu: Don't take group reference in
 iommu_alloc_default_domain()
In-Reply-To: <20200525130122.380-1-joro@8bytes.org>
References: <20200525130122.380-1-joro@8bytes.org>
Message-ID: <4a9382b1a79ee7ac46abfe8b84601576@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020-05-25 18:31, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_alloc_default_domain() function takes a reference to an IOMMU
> group without releasing it. This causes the group to never be released,
> with undefined side effects.
> 
> The function has only one call-site, which takes a group reference on
> its own, so to fix this leak, do not take another reference in
> iommu_alloc_default_domain() and pass the group as a function parameter
> instead.
> 
> Reference:
> https://lore.kernel.org/lkml/20200522130145.30067-1-saiprakash.ranjan@codeaurora.org/
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Fixes: 6e1aa2049154 ("iommu: Move default domain allocation to
> iommu_probe_device()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 374b34fd6fac..bf20674769e0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -80,7 +80,8 @@ static bool iommu_cmd_line_dma_api(void)
>  	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
>  }
> 
> -static int iommu_alloc_default_domain(struct device *dev);
> +static int iommu_alloc_default_domain(struct iommu_group *group,
> +				      struct device *dev);
>  static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  						 unsigned type);
>  static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -251,17 +252,17 @@ int iommu_probe_device(struct device *dev)
>  	if (ret)
>  		goto err_out;
> 
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		goto err_release;
> +
>  	/*
>  	 * Try to allocate a default domain - needs support from the
>  	 * IOMMU driver. There are still some drivers which don't
>  	 * support default domains, so the return value is not yet
>  	 * checked.
>  	 */
> -	iommu_alloc_default_domain(dev);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		goto err_release;
> +	iommu_alloc_default_domain(group, dev);
> 
>  	if (group->default_domain)
>  		ret = __iommu_attach_device(group->default_domain, dev);
> @@ -1478,15 +1479,11 @@ static int
> iommu_group_alloc_default_domain(struct bus_type *bus,
>  	return 0;
>  }
> 
> -static int iommu_alloc_default_domain(struct device *dev)
> +static int iommu_alloc_default_domain(struct iommu_group *group,
> +				      struct device *dev)
>  {
> -	struct iommu_group *group;
>  	unsigned int type;
> 
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return -ENODEV;
> -
>  	if (group->default_domain)
>  		return 0;

Tested this out and it works for me.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
