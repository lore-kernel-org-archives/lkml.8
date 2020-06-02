Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2658C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A0F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 03:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFBDDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 23:03:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFBDDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 23:03:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77675D6802A5AACA4A96;
        Tue,  2 Jun 2020 11:03:02 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.122) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 2 Jun 2020 11:02:54 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Prime Zeng <prime.zeng@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] driver core: platform: expose numa_node to users in sysfs
Date:   Tue, 2 Jun 2020 15:01:39 +1200
Message-ID: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.122]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some platform devices like iommu, particually ARM smmu, users may
care about the numa locality. for example, if threads and drivers run
near iommu, they may get much better performance on dma_unmap_sg.
For other platform devices, users may still want to know the hardware
topology.

Cc: Prime Zeng <prime.zeng@hisilicon.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/base/platform.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b27d0f6c18c9..7794b9a38d82 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1062,13 +1062,37 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
+static ssize_t numa_node_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
+		int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+
+	if (a == &dev_attr_numa_node.attr &&
+			dev_to_node(dev) == NUMA_NO_NODE)
+		return 0;
+
+	return a->mode;
+}
 
 static struct attribute *platform_dev_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_numa_node.attr,
 	&dev_attr_driver_override.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(platform_dev);
+
+static struct attribute_group platform_dev_group = {
+	.attrs = platform_dev_attrs,
+	.is_visible = platform_dev_attrs_visible,
+};
+__ATTRIBUTE_GROUPS(platform_dev);
 
 static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-- 
2.23.0


