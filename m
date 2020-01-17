Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B632087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:57492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgAQOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7C65AC7D;
        Fri, 17 Jan 2020 14:39:03 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 06/15] coresight: combine bus and PMU init calls
Date:   Fri, 17 Jan 2020 15:40:01 +0100
Message-Id: <20200117144010.11149-7-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize coresight bus at postcore level since
coresight API is private now. Moreover, call etm_perf_init() from
coresight_init() to combine bus and PMU into a single module. There
are circular dependencies between them.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-bus.c      | 41 ++++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm-perf.c |  3 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-bus.c b/drivers/hwtracing/coresight/coresight-bus.c
index ef20f74c85fa..c2eaeeea98cd 100644
--- a/drivers/hwtracing/coresight/coresight-bus.c
+++ b/drivers/hwtracing/coresight/coresight-bus.c
@@ -1142,16 +1142,6 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 	return -EAGAIN;
 }
 
-struct bus_type coresight_bustype = {
-	.name	= "coresight",
-};
-
-static int __init coresight_init(void)
-{
-	return bus_register(&coresight_bustype);
-}
-postcore_initcall(coresight_init);
-
 /*
  * coresight_release_platform_data: Release references to the devices connected
  * to the output port of this device.
@@ -1336,3 +1326,34 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	return name;
 }
 EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
+
+struct bus_type coresight_bustype = {
+	.name	= "coresight",
+};
+
+static int __init coresight_init(void)
+{
+	int ret;
+
+	ret = bus_register(&coresight_bustype);
+	if (ret)
+		return ret;
+
+	ret = etm_perf_init();
+	if (ret)
+		bus_unregister(&coresight_bustype);
+
+	return ret;
+}
+
+static void __exit coresight_exit(void)
+{
+	/* TODO: perf_pmu_unregister() */
+	bus_unregister(&coresight_bustype);
+}
+
+module_init(coresight_init);
+module_exit(coresight_exit);
+
+MODULE_DESCRIPTION("Coresight bus and pmu driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 84f1dcb69827..1bd71c2f6802 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -579,7 +579,7 @@ void etm_perf_del_symlink_sink(struct coresight_device *csdev)
 	csdev->ea = NULL;
 }
 
-static int __init etm_perf_init(void)
+int __init etm_perf_init(void)
 {
 	int ret;
 
@@ -606,4 +606,3 @@ static int __init etm_perf_init(void)
 
 	return ret;
 }
-device_initcall(etm_perf_init);
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 015213abe00a..4b1c1f55fb46 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -82,4 +82,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 
 #endif /* CONFIG_CORESIGHT */
 
+int __init etm_perf_init(void);
+
 #endif
-- 
2.16.4

