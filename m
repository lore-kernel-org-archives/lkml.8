Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06823C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE198206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3u7bcKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCYKBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:01:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39662 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:01:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so2131923wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gx4EE9OBLJ7veyQKGIImHsl9VG0kRX7m0DFlU107z/c=;
        b=I3u7bcKDdm/amtuqpbxsryQiy0qwLpntm14heC+WTC5sotYRV06lid8qNOiPR+Nc5M
         39i0gQ/fLAnVztvAWKXSht0FqAKEsZ/Br8a+eumL2FbaVowUXeVjTYSLs/p++6EU2IVR
         /myr2ByzCldbkeooziCU8mvgTVAwZoZ90HpqZ6bkrCL7y+SDovMaMB5krpt0YlyLE1pi
         e46215NzN0csqUKrLsQE2AiXCW9mkMZMxJLBkNDvlyFeu3yAXfNxJewYtwgSyMM7cYY4
         dxZt6aLfMbC48QuR/jYF9L+GWrDWzqz8ghNCbHXWoQGDHST82Du7WzGompe6rSYquPQq
         gCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gx4EE9OBLJ7veyQKGIImHsl9VG0kRX7m0DFlU107z/c=;
        b=Gii3oo9QLVbEwRZYAX95WJS0A/Ao4godKPZREZQV1b5zHa2jJL2ZKrxMHoP4e9Ir6u
         BjzP9dJid1QFf4GZ5VmYXTkHQKKV9jiK4Df9vgSj5xaeXrODHBOPoJNwuyd6LUBzkh7t
         BaWAVMMmbjUimSoogjsdPOM1R1XAqJlsscvCASppVqTkl/x+IVBF37qbdtxC01ne4IjF
         mD5UvqVRAnqE7RKJP8d/dATiyhvwWBtOqmVHDBXfHfQql4xqSE2gPBHypAj6qM5dXa91
         PsC2CBFp6+e7z5+YJkK03Dth6rVbHUo9FZTAgGj0481mi1wgDN3KawjOb9aA/Oj80Q+V
         M4qA==
X-Gm-Message-State: ANhLgQ3GaKQGi8WJAnt8eGlzWg3J2jlJWu18SEfqY/YJ6J5q3K0n/Qcu
        8O2H1Kx3rVSNMudEf/oA1q1smg==
X-Google-Smtp-Source: ADFU+vsG6FkW0t3H3fi3008OTmTBHa5+5XdTivxCq0k+4sh/qYuhu8dKMdSfVT60SUk0HLJYDYTA+Q==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr2739538wrc.116.1585130504161;
        Wed, 25 Mar 2020 03:01:44 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k9sm34489672wrd.74.2020.03.25.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 03:01:43 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] nvmem: core: use is_bin_visible for permissions
Date:   Wed, 25 Mar 2020 10:01:38 +0000
Message-Id: <20200325100138.17854-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
References: <20200325100138.17854-1-srinivas.kandagatla@linaro.org>
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
Changes since v1:
	- Updated permissions setup logic as suggested by Greg
	- Added checks for callbacks.

 drivers/nvmem/nvmem-sysfs.c | 85 +++++++++++++------------------------
 1 file changed, 29 insertions(+), 56 deletions(-)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 8759c4470012..68ad8aef79d4 100644
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
@@ -187,31 +180,11 @@ static struct bin_attribute bin_attr_ro_root_nvmem = {
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
 const struct attribute_group **nvmem_sysfs_get_groups(
 					struct nvmem_device *nvmem,
 					const struct nvmem_config *config)
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
-- 
2.21.0

