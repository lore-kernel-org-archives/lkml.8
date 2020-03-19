Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263AC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A472920724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCSHjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:39:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSHjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:39:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B36FB20979CB64AEA57E;
        Thu, 19 Mar 2020 15:39:29 +0800 (CST)
Received: from huawei.com (10.67.133.63) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Mar 2020
 15:39:24 +0800
From:   Qiang Su <suqiang4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <suqiang4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] UIO: make maximum memory and port regions configurable
Date:   Thu, 19 Mar 2020 15:39:23 +0800
Message-ID: <20200319073923.51812-1-suqiang4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now each uio device can only support 5 memory regions and
5 port regions. It may be far from enough for some big system.
On the other hand, the hard-coded style is not flexible.
So make these values configurable by menuconfig, thus users
can easily expand them according to their actual situation.

Consider the marco is used as array index, so a range for
the config is set in menuconfig. The range is set as 1 to 512.
The default value is still set as 5 to keep consistent with
current code.

Signed-off-by: Qiang Su <suqiang4@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Greg KH <gregkh@linuxfoundation.org>
---
Changes since v1:
also make port regions configurable in menuconfig.
fix kbuild errors.
---
Changes since v2:
provide more information in the help texts.
---
 drivers/uio/Kconfig        | 28 ++++++++++++++++++++++++++++
 include/linux/uio_driver.h |  4 ++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..669000df80df 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,32 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config MAX_UIO_MAPS
+	depends on UIO
+	int "Maximum of memory nodes each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of memory regions in uio device configurable.
+	  For some big system, you may need to map more memory regions
+	  than the default 5. For example, your driver need to access 10
+	  discontinuous address space, thus you need to set this value.
+	  to 10 or greater.
+
+	  If you do not understand, just keep the default value.
+
+config MAX_UIO_PORT_REGIONS
+	depends on UIO
+	int "Maximum of port regions each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of port regions in uio device configurable.
+	  For some big system, you may need to use more port regions than
+	  the default 5. For example, your driver need to use 10 port regions
+	  of gpio type, then you need to set this value to 10 or greater.
+
+	  If you do not understand, just keep the default value.
+
 endif
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..5dc60088834c 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -44,7 +44,7 @@ struct uio_mem {
 	struct uio_map		*map;
 };
 
-#define MAX_UIO_MAPS	5
+#define MAX_UIO_MAPS	CONFIG_MAX_UIO_MAPS
 
 struct uio_portio;
 
@@ -64,7 +64,7 @@ struct uio_port {
 	struct uio_portio	*portio;
 };
 
-#define MAX_UIO_PORT_REGIONS	5
+#define MAX_UIO_PORT_REGIONS	CONFIG_MAX_UIO_PORT_REGIONS
 
 struct uio_device {
         struct module           *owner;
-- 
2.12.3

