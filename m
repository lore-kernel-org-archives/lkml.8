Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B29CC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E6214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAQOjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:57462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgAQOjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69388AC8B;
        Fri, 17 Jan 2020 14:39:02 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 04/15] coresight: make API private
Date:   Fri, 17 Jan 2020 15:39:59 +0100
Message-Id: <20200117144010.11149-5-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no external users of coresight API. Move the function
prototypes to coresight-priv.h.

Not removing the whole file as there are following two users of it:
arch/arm/kernel/hw_breakpoint.c
drivers/misc/habanalabs/goya/goya_coresight.c

Lets clean this in a future patch.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-priv.h | 22 ++++++++++++
 include/linux/coresight.h                    | 50 ----------------------------
 2 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 82e563cdc879..e6eec9f46e13 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -202,4 +202,26 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 
 void coresight_release_platform_data(struct coresight_platform_data *pdata);
 
+extern struct coresight_device *
+coresight_register(struct coresight_desc *desc);
+extern void coresight_unregister(struct coresight_device *csdev);
+extern int coresight_enable(struct coresight_device *csdev);
+extern void coresight_disable(struct coresight_device *csdev);
+extern int coresight_timeout(void __iomem *addr, u32 offset,
+			     int position, int value);
+
+extern int coresight_claim_device(void __iomem *base);
+extern int coresight_claim_device_unlocked(void __iomem *base);
+
+extern void coresight_disclaim_device(void __iomem *base);
+extern void coresight_disclaim_device_unlocked(void __iomem *base);
+extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
+					 struct device *dev);
+
+extern bool coresight_loses_context_with_cpu(struct device *dev);
+
+extern int coresight_get_cpu(struct device *dev);
+
+struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
+
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 44e552de419c..8b39a83732b8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -269,54 +269,4 @@ struct coresight_ops {
 	const struct coresight_ops_helper *helper_ops;
 };
 
-#ifdef CONFIG_CORESIGHT
-extern struct coresight_device *
-coresight_register(struct coresight_desc *desc);
-extern void coresight_unregister(struct coresight_device *csdev);
-extern int coresight_enable(struct coresight_device *csdev);
-extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_timeout(void __iomem *addr, u32 offset,
-			     int position, int value);
-
-extern int coresight_claim_device(void __iomem *base);
-extern int coresight_claim_device_unlocked(void __iomem *base);
-
-extern void coresight_disclaim_device(void __iomem *base);
-extern void coresight_disclaim_device_unlocked(void __iomem *base);
-extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
-					 struct device *dev);
-
-extern bool coresight_loses_context_with_cpu(struct device *dev);
-#else
-static inline struct coresight_device *
-coresight_register(struct coresight_desc *desc) { return NULL; }
-static inline void coresight_unregister(struct coresight_device *csdev) {}
-static inline int
-coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
-static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_timeout(void __iomem *addr, u32 offset,
-				     int position, int value) { return 1; }
-static inline int coresight_claim_device_unlocked(void __iomem *base)
-{
-	return -EINVAL;
-}
-
-static inline int coresight_claim_device(void __iomem *base)
-{
-	return -EINVAL;
-}
-
-static inline void coresight_disclaim_device(void __iomem *base) {}
-static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
-
-static inline bool coresight_loses_context_with_cpu(struct device *dev)
-{
-	return false;
-}
-#endif
-
-extern int coresight_get_cpu(struct device *dev);
-
-struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
-
 #endif
-- 
2.16.4

