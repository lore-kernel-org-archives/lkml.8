Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E86C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9D32070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEOQOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:14:03 -0400
Received: from 8bytes.org ([81.169.241.247]:43514 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgEOQOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:14:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C35FA3C3; Fri, 15 May 2020 18:14:01 +0200 (CEST)
Date:   Fri, 15 May 2020 18:14:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        jsnitsel@redhat.com
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200515161400.GZ18353@8bytes.org>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:42:23PM +0100, Robin Murphy wrote:
> >   struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> >   {
> > -	return dev->iommu_group->default_domain;
> > +	struct iommu_domain *domain = dev->iommu_group->default_domain;
> > +
> > +	if (__iommu_is_attach_deferred(domain, dev))
> > +		__iommu_attach_device_no_defer(domain, dev);
> 
> This raises a red flag, since iommu-dma already has explicit deferred attach
> handling where it should need it, immediately after this is called to
> retrieve the domain. The whole thing smells to me like we should have an
> explicit special-case in iommu_probe_device() rather than hooking
> __iommu_attach_device() in general then having to bodge around the fallout
> elsewhere.

Good point, I missed that. But it didn't work for its only user, the
AMD IOMMU driver, the reason is that it calls iommu_attach_device(),
which in its code-path checks for deferred attaching again and bails
out, without do the real attachment.

But below updated fix should work. Jerry, could you please test it
again?

From 4e262dedcd36c7572312c65e66416da74fc78047 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Fri, 15 May 2020 11:25:03 +0200
Subject: [PATCH] iommu: Fix deferred domain attachment

The IOMMU core code has support for deferring the attachment of a domain
to a device. This is needed in kdump kernels where the new domain must
not be attached to a device before the device driver takes it over.

When the AMD IOMMU driver got converted to use the dma-iommu
implementation, the deferred attaching got lost. The code in
dma-iommu.c has support for deferred attaching, but it calls into
iommu_attach_device() to actually do it. But iommu_attach_device()
will check if the device should be deferred in it code-path and do
nothing, breaking deferred attachment.

Provide a function in IOMMU core code to reliably attach a device to a
domain without any deferred checks and also without other safe-guards.

Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Tom Murphy <murphyt7@tcd.ie>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 795bbbb9b6f8 ("iommu/dma-iommu: Handle deferred devices")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/dma-iommu.c |  4 ++--
 drivers/iommu/iommu.c     | 37 ++++++++++++++++++++++++++++++++-----
 include/linux/iommu.h     |  2 ++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ba128d1cdaee..403fda04ea98 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -362,8 +362,8 @@ static int iommu_dma_deferred_attach(struct device *dev,
 		return 0;
 
 	if (unlikely(ops->is_attach_deferred &&
-			ops->is_attach_deferred(domain, dev)))
-		return iommu_attach_device(domain, dev);
+		     ops->is_attach_deferred(domain, dev)))
+		return iommu_attach_device_no_defer(domain, dev);
 
 	return 0;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..91dbdbc6d640 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/crash_dump.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -1889,13 +1890,19 @@ void iommu_domain_free(struct iommu_domain *domain)
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
@@ -1903,9 +1910,29 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
+int iommu_attach_device_no_defer(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	/* Safe-Guard to only call this when needed */
+	if (!is_kdump_kernel())
+		return -ENODEV;
+
+	return __iommu_attach_device_no_defer(domain, dev);
+}
+
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7cfd2dddb49d..f82b20a61d0b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -449,6 +449,8 @@ extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
 extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
+extern int iommu_attach_device_no_defer(struct iommu_domain *domain,
+					struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
-- 
2.25.1

