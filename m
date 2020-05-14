Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6702DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6B2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgENPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:36:28 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:36:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5B26B26F; Thu, 14 May 2020 17:36:25 +0200 (CEST)
Date:   Thu, 14 May 2020 17:36:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
Subject: Re: amd kdump failure with iommu=nopt
Message-ID: <20200514153623.GM18353@8bytes.org>
References: <20200514031838.2oklmyrc3n5it2ox@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514031838.2oklmyrc3n5it2ox@cantor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Wed, May 13, 2020 at 08:18:38PM -0700, Jerry Snitselaar wrote:
> We've seen kdump failures with recent kernels (5.5, 5.6, 5.7-rc1) on
> amd systems when iommu is enabled in translation mode. In the cases so
> far there has been mpt3sas involved, but I'm also seeing io page
> faults for ahci right before mpt3sas has an io page fault:

Thanks for the report!

>> It was bisected to:
> 
> commit be62dbf554c5b50718a54a359372c148cd9975c7
> Author: Tom Murphy <murphyt7@tcd.ie>
> Date:   Sun Sep 8 09:56:41 2019 -0700
> 
>     iommu/amd: Convert AMD iommu driver to the dma-iommu api

This commit also removes the deferred attach of the device to its new
domain. Does the attached diff fix the problem for you?


	Joerg

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..40df255b6c7a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1889,23 +1889,37 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-static int __iommu_attach_device(struct iommu_domain *domain,
-				 struct device *dev)
+static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
+				       struct device *dev)
 {
-	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
+	if (!domain->ops->is_attach_deferred)
+		return false;
+
+	return domain->ops->is_attach_deferred(domain, dev);
+}
 
+static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
+					  struct device *dev)
+{
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
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
@@ -2023,7 +2037,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
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
