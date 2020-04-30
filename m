Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145BFC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6132076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588249079;
	bh=Jxl7X4/2xHZsq2VoerxXMaWQ7OlOsC6VeBsNq81l13I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LxDPvG7zaKreRbLGz6ZOS+e+5QPpo3lO1WfPWqIQIbiFsNFMvtXCiDsW4qQYHK8Tr
	 K4hExirPfWwumJJ2FttzpFm0f0ocvx6xskXGQ+kr3xsbifGA5ME2N5tCRMnBmYg3RK
	 pZjfxMCb1NO6Xi8YRNCAK3oXBKPK219URsDbBzGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3MR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3MR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:17:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 532902078D;
        Thu, 30 Apr 2020 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588249078;
        bh=Jxl7X4/2xHZsq2VoerxXMaWQ7OlOsC6VeBsNq81l13I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIub6Ac+iYrS/qJmT8E2550S9CwB8sr7irDEUjXVh5qpdHc+Kd87zf7zzd98jcv7e
         0yJp37EYJxQQwPvtPgIktgpo8QUIMfTSTUwJiC9W9nqeWRQ8UJLuiZmJRO9lakYCbE
         PWghczXzDkJMiZtGZ4G7IMyxSoCFP0mLsTNNT6i4=
Date:   Thu, 30 Apr 2020 13:17:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] drivers/iommu: properly export iommu_group_get_for_dev
Message-ID: <20200430121753.GA22842@willie-the-truck>
References: <20200430120120.2948448-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430120120.2948448-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 02:01:20PM +0200, Greg Kroah-Hartman wrote:
> In commit a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to
> permit modular drivers") a bunch of iommu symbols were exported, all
> with _GPL markings except iommu_group_get_for_dev().  That export should
> also be _GPL like the others.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: John Garry <john.garry@huawei.com>
> Fixes: a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to permit modular drivers")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2b471419e26c..1ecbc8788fe7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1428,7 +1428,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  
>  	return group;
>  }
> -EXPORT_SYMBOL(iommu_group_get_for_dev);
> +EXPORT_SYMBOL_GPL(iommu_group_get_for_dev);
>  
>  struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
>  {

Thanks, not sure how I managed to screw this up in the original patch!

Acked-by: Will Deacon <will@kernel.org>

Joerg -- can you pick this one up please?

Cheers,

Will
