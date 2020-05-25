Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36969C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F22073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390727AbgEYNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:02:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbgEYNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:02:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17DBFACDB;
        Mon, 25 May 2020 13:02:58 +0000 (UTC)
Date:   Mon, 25 May 2020 15:02:53 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iommu: Fix group refcount in iommu_alloc_default_domain()
Message-ID: <20200525130253.GH5075@suse.de>
References: <20200522130145.30067-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522130145.30067-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 22, 2020 at 06:31:45PM +0530, Sai Prakash Ranjan wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a4c2f122eb8b..05f7b77c432f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1491,6 +1491,7 @@ static int iommu_alloc_default_domain(struct device *dev)
>  {
>  	struct iommu_group *group;
>  	unsigned int type;
> +	int ret;
>  
>  	group = iommu_group_get(dev);
>  	if (!group)
> @@ -1501,7 +1502,11 @@ static int iommu_alloc_default_domain(struct device *dev)
>  
>  	type = iommu_get_def_domain_type(dev);
>  
> -	return iommu_group_alloc_default_domain(dev->bus, group, type);
> +	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
> +
> +	iommu_group_put(group);
> +
> +	return ret;
>  }
>  
>  /**

Thanks for the report and the fix. I think it is better to fix this by
not taking a group reference in iommu_alloc_default_domain() at all and
pass group as a parameter. Please see the patch I just sent out.

Regards,

	Joerg
