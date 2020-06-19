Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91236C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D492080D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 03:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFSDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 23:02:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbgFSDCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:02:34 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 82E8437C03955A74C75B;
        Fri, 19 Jun 2020 11:02:32 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.53) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 19 Jun 2020 11:02:21 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Prime Zeng <prime.zeng@hisilicon.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Subject: [PATCH v3] driver core: platform: expose numa_node to users in sysfs
Date:   Fri, 19 Jun 2020 15:00:45 +1200
Message-ID: <20200619030045.81956-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platform devices like ARM SMMU are memory-mapped and populated by ACPI/IORT.
In this case, NUMA topology of those platform devices are exported by firmware as
well. Software might care about the numa_node of those devices in order to achieve
NUMA locality.
This patch will show the numa_node for this kind of devices in sysfs. For those
platform devices without numa, numa_node won't be visible.

Cc: Prime Zeng <prime.zeng@hisilicon.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3: rebase to 5.8-rc1; refine commit log

 Documentation/ABI/testing/sysfs-bus-platform | 10 ++++++++
 drivers/base/platform.c                      | 26 +++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
index 5172a6124b27..194ca700e962 100644
--- a/Documentation/ABI/testing/sysfs-bus-platform
+++ b/Documentation/ABI/testing/sysfs-bus-platform
@@ -18,3 +18,13 @@ Description:
 		devices to opt-out of driver binding using a driver_override
 		name such as "none".  Only a single driver may be specified in
 		the override, there is no support for parsing delimiters.
+
+What:		/sys/bus/platform/devices/.../numa_node
+Date:		June 2020
+Contact:	Barry Song <song.bao.hua@hisilicon.com>
+Description:
+		This file contains the NUMA node to which the platform device
+		is attached. It won't be visible if the node is unknown. The
+		value comes from an ACPI _PXM method or a similar firmware
+		source. Initial users for this file would be devices like
+		arm smmu which are populated by arm64 acpi_iort.
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0d0a5490ac6..4369dfd57815 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1076,13 +1076,37 @@ static ssize_t driver_override_show(struct device *dev,
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


