Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFA3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725322073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAQOjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:57430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgAQOjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6624AC4A;
        Fri, 17 Jan 2020 14:39:01 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 03/15] coresight: remove multiple init calls from replicator driver
Date:   Fri, 17 Jan 2020 15:39:58 +0100
Message-Id: <20200117144010.11149-4-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic-replicator uses module_amba_driver to register. Whereas
static-replicator uses builtin_platform_driver. Combine these init
calls into a single module_init/exit pair in preparation to make the
driver modular.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 30 ++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index cc14c3696be0..137328a7f27e 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -340,7 +340,6 @@ static struct platform_driver static_replicator_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(static_replicator_driver);
 
 static int dynamic_replicator_probe(struct amba_device *adev,
 				    const struct amba_id *id)
@@ -370,7 +369,34 @@ static struct amba_driver dynamic_replicator_driver = {
 	.probe		= dynamic_replicator_probe,
 	.id_table	= dynamic_replicator_ids,
 };
-module_amba_driver(dynamic_replicator_driver);
+
+static int __init replicator_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&static_replicator_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
+	ret = amba_driver_register(&dynamic_replicator_driver);
+	if (ret) {
+		pr_info("Error registering amba driver\n");
+		platform_driver_unregister(&static_replicator_driver);
+	}
+
+	return ret;
+}
+
+static void __exit replicator_exit(void)
+{
+	platform_driver_unregister(&static_replicator_driver);
+	amba_driver_unregister(&dynamic_replicator_driver);
+}
+
+module_init(replicator_init);
+module_exit(replicator_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Replicator driver");
-- 
2.16.4

