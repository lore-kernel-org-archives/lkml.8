Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5619C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B5920575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgENPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:40:23 -0400
Received: from 8bytes.org ([81.169.241.247]:42986 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgENPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:40:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 87CCC26F; Thu, 14 May 2020 17:40:21 +0200 (CEST)
Date:   Thu, 14 May 2020 17:40:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: amd kdump failure with iommu=nopt
Message-ID: <20200514154020.GN18353@8bytes.org>
References: <20200514031838.2oklmyrc3n5it2ox@cantor>
 <20200514153623.GM18353@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514153623.GM18353@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:36:23PM +0200, Joerg Roedel wrote:
> This commit also removes the deferred attach of the device to its new
> domain. Does the attached diff fix the problem for you?
> +static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
> +					  struct device *dev)
> +{
>  	if (unlikely(domain->ops->attach_dev == NULL))
>  		return -ENODEV;
>  
>  	ret = domain->ops->attach_dev(domain, dev);
>  	if (!ret)
>  		trace_attach_device_to_domain(dev);
> +
>  	return ret;
>  }

Sorry, this didn't compile, here is an updated version that actually
compiles:


diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..f54ebb964271 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev)
+static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	if (!domain->ops->is_attach_deferred)
+		return false;
+
+	return domain->ops->is_attach_deferred(domain, dev);
+}
+
+static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
+					  struct device *dev)
 {
 	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
@@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	ret = domain->ops->attach_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
+
 	return ret;
 }
 
+static int __iommu_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	if (__iommu_is_attach_deferred(domain, dev))
+		return 0;
+
+	return __iommu_attach_device_no_defer(domain, dev);
+}
+
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
  */
 struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 {
-	return dev->iommu_group->default_domain;
+	struct iommu_domain *domain = dev->iommu_group->default_domain;
+
+	if (__iommu_is_attach_deferred(domain, dev))
+		__iommu_attach_device_no_defer(domain, dev);
+
+	return domain;
 }
 
 /*
