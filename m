Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F574207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgFDJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgFDJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:39:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C7C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:39:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7562426F; Thu,  4 Jun 2020 11:39:38 +0200 (CEST)
Date:   Thu, 4 Jun 2020 11:39:36 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Check for deferred attach in
 iommu_group_do_dma_attach()
Message-ID: <20200604093936.GK14598@8bytes.org>
References: <20200604091944.26402-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604091944.26402-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:19:44AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_group_do_dma_attach() must not attach devices which have
> deferred_attach set. Otherwise devices could cause IOMMU faults when
> re-initialized in a kdump kernel.
> 
> Fixes: deac0b3bed26 ("iommu: Split off default domain allocation from group assignment")
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b5ea203f6c68..5a6d509f72b6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>  static int iommu_group_do_dma_attach(struct device *dev, void *data)
>  {
>  	struct iommu_domain *domain = data;
> +	int ret = 0;
>  
> -	return __iommu_attach_device(domain, dev);
> +	if (!iommu_is_attach_deferred(group->domain, dev))
> +		ret = __iommu_attach_device(group->domain, dev);

And of course with the same bug as my original diff. Fixed that up
before applying it. (group->domain -> domain).


	Joerg
