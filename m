Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0722C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F2F2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgHZK2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:28:17 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:30003 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728366AbgHZK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:28:10 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:28:04 +0800
Received: from localhost.localdomain (61.148.243.98) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:28:02 +0800
From:   FelixCuioc <FelixCui-oc@zhaoxin.com>
To:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@lists.01.org>
CC:     <kbuild-all@lists.01.org>, <CobeChen-oc@zhaoxin.com>,
        <RaymondPang-oc@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH 2/3] iommu/vt-d:Add support for probing ACPI device in RMRR
Date:   Wed, 26 Aug 2020 06:27:51 -0400
Message-ID: <20200826102752.3776-3-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
References: <20200826102752.3776-1-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [61.148.243.98]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After acpi device in RMRR is detected,it is necessary
to establish a mapping for these devices.
In acpi_device_create_direct_mappings(),create a mapping
for the acpi device in RMRR.
Add a helper to achieve the acpi namespace device can
access the RMRR region.

Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 drivers/iommu/intel/iommu.c | 27 +++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  6 ++++++
 include/linux/iommu.h       |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f774ef63d473..b31f02f41c96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4797,6 +4797,20 @@ static int __init platform_optin_force_iommu(void)
 
 	return 1;
 }
+static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
+{
+	struct iommu_group *group;
+
+	acpi_device->bus->iommu_ops = &intel_iommu_ops;
+	group = iommu_group_get(pn_dev);
+	if (!group) {
+		pr_warn("ACPI name space devices create direct mappings wrong!\n");
+		return -1;
+	}
+	__acpi_device_create_direct_mappings(group, acpi_device);
+
+	return 0;
+}
 
 static int __init probe_acpi_namespace_devices(void)
 {
@@ -4812,6 +4826,7 @@ static int __init probe_acpi_namespace_devices(void)
 			struct acpi_device_physical_node *pn;
 			struct iommu_group *group;
 			struct acpi_device *adev;
+			struct device *pn_dev = NULL;
 
 			if (dev->bus != &acpi_bus_type)
 				continue;
@@ -4822,6 +4837,7 @@ static int __init probe_acpi_namespace_devices(void)
 					    &adev->physical_node_list, node) {
 				group = iommu_group_get(pn->dev);
 				if (group) {
+					pn_dev = pn->dev;
 					iommu_group_put(group);
 					continue;
 				}
@@ -4830,7 +4846,18 @@ static int __init probe_acpi_namespace_devices(void)
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
+				pn_dev = pn->dev;
+			}
+			if (pn_dev == NULL) {
+				dev->bus->iommu_ops = &intel_iommu_ops;
+				ret = iommu_probe_device(dev);
+				if (ret) {
+					pr_err("acpi_device probe fail! ret:%d\n", ret);
+					return ret;
+				}
+				return 0;
 			}
+			ret = acpi_device_create_direct_mappings(pn_dev, dev);
 			mutex_unlock(&adev->physical_node_lock);
 
 			if (ret)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..4f714a2d5ef7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 	return false;
 }
 
+void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
+{
+	iommu_create_device_direct_mappings(group, acpi_device);
+}
+EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..9be134775886 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -514,6 +514,9 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
+extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
+						struct device *acpi_device);
+
 static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
 {
 	if (domain->ops->flush_iotlb_all)
-- 
2.17.1

