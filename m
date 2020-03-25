Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B66C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EB32078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+QXF+nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCYNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:19:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:19:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so3077128wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFOVOtrZ01pj6hSocPjM35JnfOnvMPtu5TdY/nfBCCo=;
        b=b+QXF+nnBsNnm/VfEik6yhkqYzb6VsEAS4kz2eOKiqqzTd4iABcqV/eGOq2nPpf03m
         oBw6MNPw7YyP4GOa1tN+grKfyKuR0BPJKWL9ZCQ256NH6OwNdyl9u3L+Sk+DKwR6SaVP
         T4wRd8fflNsQEYHofD93zZE7cLh8hvXAcQMGYLP1fZVToDXgSC4hr/zzygq8IKPCvM3B
         U8L1MljgwaGOURfoTBClBYkFYmgMVod08WQPnKkO7yx4PPSBvmKE3gtjefGlqqiEYJnA
         vsNxLflQHKQgMwO3BdvLT8x4ErM+ehYpdDRykFjg/r+dcPf4UJFD7ZQtKPpEC7dWLosv
         VApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFOVOtrZ01pj6hSocPjM35JnfOnvMPtu5TdY/nfBCCo=;
        b=m2oMzbChjjHZjssNtgjYvnBeIsx8axmQjxorL7gFb6WsyEu5q890JvE3rDjBxOipjf
         GKTiHFlFTncMmxLSLy1dDBA4WaOyDzs6zOh7XKmuEeG0Y7vNq3w4Dqt4/RuZlF6CxwCo
         pkb+30xq1nITgtY3x0nfRteIbVVctTnEdApsbH6ZsZfNy5hy/uYCm5Ra/y6Ep2/Ww+8+
         6Bn05sTBrAgDHbAK7z/WMMjHeTL7yeDV6Sr0O4LzP0ehV0cMbwNC/JQ5/Di8ipBbbbqk
         efrdR86yX7OOkjPyUlO7OJfWKDVhWTMLjYKBnaxYeFW53seV4VXZnYhFtwVCzN2LoLnX
         x7FA==
X-Gm-Message-State: ANhLgQ0R5Thi5n+BD/ghWWmCPVO2zczp8UtBWo4xrUHjwmdlQImi1rYS
        WTUATqcTr6IzlOkbOVNUF+auDg==
X-Google-Smtp-Source: ADFU+vtdtbmzLefiKGZtzNOPyDEzHjF7Sd3v/TwYGmFJMSgbdsA6IIYDx8GhpSv1feCpDlnbzeBEMw==
X-Received: by 2002:adf:df82:: with SMTP id z2mr3299364wrl.46.1585142395045;
        Wed, 25 Mar 2020 06:19:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d21sm33558302wrb.51.2020.03.25.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:19:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/2] nvmem: core: use is_bin_visible for permissions
Date:   Wed, 25 Mar 2020 13:19:50 +0000
Message-Id: <20200325131951.31887-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
References: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using is_bin_visible callback to set permissions will remove a
large list of attribute groups. These group permissions can be
dynamically derived in the callback.

Also add checks for read/write callbacks and set permissions accordingly.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c        |  2 +-
 drivers/nvmem/nvmem-sysfs.c | 89 +++++++++++++------------------------
 drivers/nvmem/nvmem.h       |  8 +---
 3 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7d28e1cca4e0..477085208957 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -396,7 +396,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	nvmem->dev.groups = nvmem_sysfs_get_groups();
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 8759c4470012..b1bb3e5d1221 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -104,6 +104,28 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
+static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
+					 struct bin_attribute *attr, int i)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+	umode_t mode = 0400;
+
+	if (!nvmem->root_only)
+		mode |= 0044;
+
+	if (!nvmem->read_only)
+		mode |= 0200;
+
+	if (!nvmem->reg_write)
+		mode &= ~0200;
+
+	if (!nvmem->reg_read)
+		mode &= ~0444;
+
+	return mode;
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -114,18 +136,19 @@ static struct bin_attribute bin_attr_rw_nvmem = {
 	.write	= bin_attr_nvmem_write,
 };
 
-static struct bin_attribute *nvmem_bin_rw_attributes[] = {
+static struct bin_attribute *nvmem_bin_attributes[] = {
 	&bin_attr_rw_nvmem,
 	NULL,
 };
 
-static const struct attribute_group nvmem_bin_rw_group = {
-	.bin_attrs	= nvmem_bin_rw_attributes,
+static const struct attribute_group nvmem_bin_group = {
+	.bin_attrs	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
+	.is_bin_visible = nvmem_bin_attr_is_visible,
 };
 
-static const struct attribute_group *nvmem_rw_dev_groups[] = {
-	&nvmem_bin_rw_group,
+static const struct attribute_group *nvmem_dev_groups[] = {
+	&nvmem_bin_group,
 	NULL,
 };
 
@@ -138,21 +161,6 @@ static struct bin_attribute bin_attr_ro_nvmem = {
 	.read	= bin_attr_nvmem_read,
 };
 
-static struct bin_attribute *nvmem_bin_ro_attributes[] = {
-	&bin_attr_ro_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_ro_group = {
-	.bin_attrs	= nvmem_bin_ro_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_ro_dev_groups[] = {
-	&nvmem_bin_ro_group,
-	NULL,
-};
-
 /* default read/write permissions, root only */
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
@@ -163,21 +171,6 @@ static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.write	= bin_attr_nvmem_write,
 };
 
-static struct bin_attribute *nvmem_bin_rw_root_attributes[] = {
-	&bin_attr_rw_root_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_rw_root_group = {
-	.bin_attrs	= nvmem_bin_rw_root_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
-	&nvmem_bin_rw_root_group,
-	NULL,
-};
-
 /* read only permission, root only */
 static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.attr	= {
@@ -187,31 +180,9 @@ static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.read	= bin_attr_nvmem_read,
 };
 
-static struct bin_attribute *nvmem_bin_ro_root_attributes[] = {
-	&bin_attr_ro_root_nvmem,
-	NULL,
-};
-
-static const struct attribute_group nvmem_bin_ro_root_group = {
-	.bin_attrs	= nvmem_bin_ro_root_attributes,
-	.attrs		= nvmem_attrs,
-};
-
-static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
-	&nvmem_bin_ro_root_group,
-	NULL,
-};
-
-const struct attribute_group **nvmem_sysfs_get_groups(
-					struct nvmem_device *nvmem,
-					const struct nvmem_config *config)
+const struct attribute_group **nvmem_sysfs_get_groups(void)
 {
-	if (config->root_only)
-		return nvmem->read_only ?
-			nvmem_ro_root_dev_groups :
-			nvmem_rw_root_dev_groups;
-
-	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
+	return nvmem_dev_groups;
 }
 
 /*
diff --git a/drivers/nvmem/nvmem.h b/drivers/nvmem/nvmem.h
index 16c0d3ad6679..478b796bd637 100644
--- a/drivers/nvmem/nvmem.h
+++ b/drivers/nvmem/nvmem.h
@@ -36,17 +36,13 @@ struct nvmem_device {
 #define FLAG_COMPAT		BIT(0)
 
 #ifdef CONFIG_NVMEM_SYSFS
-const struct attribute_group **nvmem_sysfs_get_groups(
-					struct nvmem_device *nvmem,
-					const struct nvmem_config *config);
+const struct attribute_group **nvmem_sysfs_get_groups(void);
 int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 			      const struct nvmem_config *config);
 void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 			      const struct nvmem_config *config);
 #else
-static inline const struct attribute_group **nvmem_sysfs_get_groups(
-					struct nvmem_device *nvmem,
-					const struct nvmem_config *config)
+static inline const struct attribute_group **nvmem_sysfs_get_groups(void)
 {
 	return NULL;
 }
-- 
2.21.0

