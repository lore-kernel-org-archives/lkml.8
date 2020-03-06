Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD262C3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF18620848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgCFHLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:11:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbgCFHLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12B0DF2D68E79AE1DDCC;
        Fri,  6 Mar 2020 15:11:33 +0800 (CST)
Received: from huawei.com (10.67.133.63) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 15:11:23 +0800
From:   Qiang Su <suqiang4@huawei.com>
To:     <gregkh@linuxfoundation.org>, <suqiang4@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH] UIO: make MAX_UIO_MAPS configurable by menuconfig
Date:   Fri, 6 Mar 2020 15:11:22 +0800
Message-ID: <20200306071122.71838-1-suqiang4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now each uio device can only support 5 memory entry. It is
far from enough for some big system. On the other hand, the
hard-coded style is not flexible.
Consider the marco is used as array index, so we set a range
for the config in menuconfig. The range is set as 1 to 512.
The default value is still 5 to keep consistent with current
code.

Signed-off-by: Qiang Su <suqiang4@huawei.com>
---
 drivers/uio/Kconfig        | 9 +++++++++
 include/linux/uio_driver.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..31c53f1dd86a 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,13 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config UIO_MAX_UIO_MAPS
+	depends on UIO
+	int "Maximum of memory nodes each uio device support(1-512)"
+	range 1 512
+	default 5
+	help
+	  make the max number of uio device configurable.
+
 endif
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 01081c4726c0..efdf8f6bf8bf 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -44,7 +44,7 @@ struct uio_mem {
 	struct uio_map		*map;
 };
 
-#define MAX_UIO_MAPS	5
+#define MAX_UIO_MAPS	CONFIG_MAX_UIO_MAPS
 
 struct uio_portio;
 
-- 
2.12.3

