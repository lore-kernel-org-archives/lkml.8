Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58614C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2541B2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uy7n/9Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCXRQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51431 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgCXRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id c187so4097709wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNCOW9v2LJpxTzkezjzdYan/Qow8ukjHWizHnsEFt8w=;
        b=Uy7n/9QuBGclxlJkPSkG2+4aWIAGdwaVC3V3c65zKIo4biiCJlaOE0d1eyjYEruJGO
         Cyuttehm5d+TywNg08a+jRVw/B9unVLI/ukfIpATGYVLyPZ/XuhNlzdCkinNpYN9vpLT
         8YXlQNtg7BSDG2deZWFXHe8gDhGXo9l3JLGQ0cGu6bVAPBbm9b2eKaTP9bGNV/RaFElq
         fXSl29AqF5QZ1iMLTX301K5eJ+WNIJBjjKvLVY3mviVJJzvl8dy6kOdUcsMQnYNojcLo
         a6ZSMrt/Kjzi3c9+K+l3IiSJlZUUl06CUAnu4sI4U0iBJZAXxGvmE/PfsOHZvyw8Hmtb
         KfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNCOW9v2LJpxTzkezjzdYan/Qow8ukjHWizHnsEFt8w=;
        b=DiZXF75HmuWsp5+Eieqrb4I9+VDtvgBM5uztbPHBFldQEmqXLxWsDgu8UT/x42cSTe
         SVs+o2OYBV3lSlWfobPZO+3Yv5mqmH1t5hagMrGIwS4fOBs7ao/tjWHPDtXjqUjAGeGa
         gq8usdKuxwjgKk9K5bmtklkoWD0zaZHKPN4hBnbhvhcc6A1j4A7ec6Hz6kHV0mBUBatM
         vb3/++IPsre3l13AjPxEVGD2nbkAoBktuPybmT+JrClhQAFwC6h89N4juUM+9TRxhRTv
         kjT5ckXEleNUZgdqae/asXl1MmGNu7nM5KXBmlVLVSqy/OA3VBYjdpOU+JHbEI9I8TCM
         W/tg==
X-Gm-Message-State: ANhLgQ3U7OuYRMN3YDfy9aj+ndyuBsUiSe5H98fNmjx9Nn2/JBaNVzx/
        Y61XeugIaW/YNxDUnV3V006z7Q==
X-Google-Smtp-Source: ADFU+vslTSoPM/JeHsDXyk2sojlGb5BEd7ouURHT+HPzu6zW9u4eprropMKzkbR/SY2JjWbWx5tI5g==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr6554773wmu.38.1585070177481;
        Tue, 24 Mar 2020 10:16:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m11sm5269514wmf.9.2020.03.24.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:16:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
Date:   Tue, 24 Mar 2020 17:16:00 +0000
Message-Id: <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using is_bin_visible callback to set permissions will remove a large list
of attribute groups. These group permissions can be dynamically derived in
the callback.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
 1 file changed, 18 insertions(+), 56 deletions(-)

diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 8759c4470012..1ff1801048f6 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -103,6 +103,17 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
+static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
+					 struct bin_attribute *attr, int i)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	if (nvmem->root_only)
+		return nvmem->read_only ? 0400 : 0600;
+
+	return nvmem->read_only ? 0444 : 0644;
+}
 
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
@@ -114,18 +125,19 @@ static struct bin_attribute bin_attr_rw_nvmem = {
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
 
@@ -138,21 +150,6 @@ static struct bin_attribute bin_attr_ro_nvmem = {
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
@@ -163,21 +160,6 @@ static struct bin_attribute bin_attr_rw_root_nvmem = {
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
@@ -187,31 +169,11 @@ static struct bin_attribute bin_attr_ro_root_nvmem = {
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

