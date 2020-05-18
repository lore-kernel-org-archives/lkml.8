Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C5E2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERN1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:27:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DDB2ACE3;
        Mon, 18 May 2020 13:27:01 +0000 (UTC)
Date:   Mon, 18 May 2020 15:26:56 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200518132656.GL8135@suse.de>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
> But that's not what this is; this is (supposed to be) the exact same "don't
> actually perform the attach yet" logic as before, just restricting it to
> default domains in the one place that it actually needs to be, so as not to
> fundamentally bugger up iommu_attach_device() in a way that prevents it from
> working as expected at the correct point later.

You are right, that is better. I tested it and it seems to work. Updated
diff attached, with a minor cleanup included. Mind sending it as a
proper patch I can send upstream?

Thanks,

	Joerg

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b375421afba..a9d02bc3ab5b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -693,6 +693,15 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
+static bool iommu_is_attach_deferred(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	if (domain->ops->is_attach_deferred)
+		return domain->ops->is_attach_deferred(domain, dev);
+
+	return false;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -705,6 +714,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	int ret, i = 0;
 	struct group_device *device;
+	struct iommu_domain *domain;
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
@@ -747,7 +757,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
+	domain = group->domain;
+	if (domain  && !iommu_is_attach_deferred(domain, dev))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
@@ -1653,9 +1664,6 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
@@ -1727,8 +1735,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(domain, dev))
 		return;
 
 	if (unlikely(domain->ops->detach_dev == NULL))
