Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF6C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C538E20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwkwjMkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCTR7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:59:21 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56712 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCTR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:59:20 -0400
Received: by mail-pg1-f201.google.com with SMTP id k67so5022713pga.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BFKQlA+rN199Va5nr23TqQIycC+OcxA0r1dVNGT3ndc=;
        b=WwkwjMkfWqynU21gEP781F/xVflZE/NNYGlclPqx9ywAgFasUK5BRdkXiEO/2xQ/51
         2Xk+I1WmJSTBxZiaAzPm3nOr365l+PvdkDSfwjOffNT14H0bSUgVbnqgzdLZBbSUtblu
         2+q3FcoYntWBHEqeBZX0kD3P3w8IFRnrL/yzHF8z2OC5mIdPjHvKW49zgEFueK/7tqn3
         ivhbjPu2byo3GLM7K29s3buNddcau6QtYP6Ct5Kb20HEE86ZUHq2pmykK4Zq1snArdQC
         W2Z3eKS9C+DQ6DwdtmMUc9IVpbSyWXWGW6upL7+iaciknJSb47en+Syvht6qk55+takl
         4yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BFKQlA+rN199Va5nr23TqQIycC+OcxA0r1dVNGT3ndc=;
        b=WTZ97LuoGLj8ItPmPrs2tvhyOPWtu3fqodrwLLvzSgh/9bUZU3IgBHE/n40IDT7nQj
         0/qbiOAjaYWbvwLEM+Ey0nHYy5img2xU8L/3fNeinRkCFeJ3QW+TlAOKy8RIUI6IZlxd
         uF2JWS7/F60GdhiXy0ZQy0RDntKlotZv7EA6W9NrJPl0J5J3L2Yh7ZfvHIbzoQFRiwTR
         rG2Ebb5spjHTbONWiywZyyaiehM68fff/lW0wN2+VOCYNLDIwcapgOthIXOcQdEJM/tY
         MKoeoYz3OhCZZQysD9hu6AXkzXCsikUYG3pneJi70tusT2bvvIv8tGqYdTlItSswSpnx
         nChQ==
X-Gm-Message-State: ANhLgQ1boMpWASbNp2O3ZHK0CvaditqA/K73+JiNDSyG5cC7OFh36Lal
        iqkYAWiZH9qbkdISMl4ztwef0eSjbFK9qQ==
X-Google-Smtp-Source: ADFU+vs8Z2St3JcTr4qu4OOe01NMcgpT5FDfG+os5ZS9ricqsq1zYpSsmAAH0fUB4R4FqDOC2oN6QmtHff8a8w==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr10592978pju.46.1584727157226;
 Fri, 20 Mar 2020 10:59:17 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:59:10 -0700
Message-Id: <20200320175910.180266-1-yonghyun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] vfio-mdev: support mediated device creation in kernel
From:   Yonghyun Hwang <yonghyun@google.com>
To:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Moritz Fischer <mdf@kernel.org>
Cc:     Yonghyun Hwang <yonghyun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable a mediated device, a device driver registers its device to VFIO
MDev framework. Once the mediated device gets enabled, UUID gets fed onto
the sysfs attribute, "create", to create the mediated device. This
additional step happens after boot-up gets complete. If the driver knows
how many mediated devices need to be created during probing time, the
additional step becomes cumbersome. This commit implements a new function
to allow the driver to create a mediated device in kernel.

Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
---
 drivers/vfio/mdev/mdev_core.c | 45 +++++++++++++++++++++++++++++++++++
 include/linux/mdev.h          |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4cfd082..a6d32516de42 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -350,6 +350,51 @@ int mdev_device_create(struct kobject *kobj,
 	return ret;
 }
 
+/*
+ * mdev_create_device : Create a mdev device
+ * @dev: device structure representing parent device.
+ * @uuid: uuid char string for a mdev device.
+ * @group: index to supported type groups for a mdev device.
+ *
+ * Create a mdev device in kernel.
+ * Returns a negative value on error, otherwise 0.
+ */
+int mdev_create_device(struct device *dev,
+			const char *uuid, int group)
+{
+	struct mdev_parent *parent = NULL;
+	struct mdev_type *type = NULL;
+	guid_t guid;
+	int i = 1;
+	int ret;
+
+	ret = guid_parse(uuid, &guid);
+	if (ret) {
+		dev_err(dev, "Failed to parse UUID");
+		return ret;
+	}
+
+	parent = __find_parent_device(dev);
+	if (!parent) {
+		dev_err(dev, "Failed to find parent mdev device");
+		return -ENODEV;
+	}
+
+	list_for_each_entry(type, &parent->type_list, next) {
+		if (i == group)
+			break;
+		i++;
+	}
+
+	if (!type || i != group) {
+		dev_err(dev, "Failed to find mdev device");
+		return -ENODEV;
+	}
+
+	return mdev_device_create(&type->kobj, parent->dev, &guid);
+}
+EXPORT_SYMBOL(mdev_create_device);
+
 int mdev_device_remove(struct device *dev)
 {
 	struct mdev_device *mdev, *tmp;
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 0ce30ca78db0..b66f67998916 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -145,4 +145,7 @@ struct device *mdev_parent_dev(struct mdev_device *mdev);
 struct device *mdev_dev(struct mdev_device *mdev);
 struct mdev_device *mdev_from_dev(struct device *dev);
 
+extern int mdev_create_device(struct device *dev,
+			const char *uuid, int group_idx);
+
 #endif /* MDEV_H */
-- 
2.25.1.696.g5e7596f4ac-goog

