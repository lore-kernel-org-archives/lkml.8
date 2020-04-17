Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB43C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E2B2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ep4RIh3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgDQMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:13:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE72C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:13:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so2798163wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNnMIm7y3TLbgC2SKE2kyFsJgudqeSj0Bi2fpMoZRKY=;
        b=ep4RIh3tIW1VzAtQKToY7ctgjSYgXbhztPYJlZNR4C5EqQkwqb8PSP9YEkRC7cIzvz
         UdnmWGlYyi9b1q3FNaRm4bEwgvcS/bIHUtnlLgdcl+EyDzdbDWeMC7IbKtOwSww+nQig
         gFa8UmAl0eIduQC+u+mHu8eptQ8OYhRIoSGhdXwYEGXFA2SrgKgbR5+rRo9uPg7z70lB
         0LtAffXccIHxhXctwDAu0d8Q2TfYuDNt3HJeD4qiH61Lccw746STX4kk1K6MJfxwuZ5m
         hSx/cuAWTdUxDQogUYTnJ+dytA6yqCskZgMo5QWWnUcjGO6rHGUGVxM3CDa+abBk/Rco
         y/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mNnMIm7y3TLbgC2SKE2kyFsJgudqeSj0Bi2fpMoZRKY=;
        b=VPT4VzeBld/iH1cdHo0a1TmCwzJyJuvGFQs8VkGkA8zD9XBnq0aaRmDKF6sOdcPosU
         MEx+Fq1ewFQRlLNHqF/4NAaa8BcvgJQOip+Rv3CVxNwXB4v/so2rYFOmEYc3Ng7tY86L
         LuyEYef8O0fSWC8+CpJlnm4o2/KHzEHv3IKpDudMalVGGarYvq4Ackl07s3J4B3/JJWo
         HJTKDTRe8h2t9gTwEhXqjvPMwL9WmEBJOpOfvZv16eJO77raKRZzYOIs/IyRE7QyMwmj
         ndfPpJLDEpXljAMYN/l8exe4VHm4WJ8G2wGKHWE7kJNNljMIWIkEvQeTBX2UollOLZ6+
         LiiQ==
X-Gm-Message-State: AGi0Pua+iy0QkibFV/2BvubG/vV8RqLItMyna5KW3+INKirSNOAkRGx5
        dQpoEAZn0b/dZyeNtWPXveZ2vg==
X-Google-Smtp-Source: APiQypLc3p+t7zActzehUoScSbYCET/ikWMq4tb12lSyG/I1Bw/fTisncRsfnx3PKbnDZ7rB5IsIJg==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr3503857wrs.32.1587125614348;
        Fri, 17 Apr 2020 05:13:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id a20sm9416375wra.26.2020.04.17.05.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 05:13:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org, gregkh@linuxfoundation.org
Cc:     andrew@lunn.ch, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: cleanup old eeprom compat entry attributes
Date:   Fri, 17 Apr 2020 13:13:06 +0100
Message-Id: <20200417121306.23121-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file permission are derived based on various configs for
default nvmem sysfs file, reuse it to create the eeprom
compat file too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 52 ++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 05c6ae4b0b97..ad6e55a75bdb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -167,11 +167,8 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
-					 struct bin_attribute *attr, int i)
+static umode_t nvmem_bin_attr_get_umode(struct nvmem_device *nvmem)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct nvmem_device *nvmem = to_nvmem_device(dev);
 	umode_t mode = 0400;
 
 	if (!nvmem->root_only)
@@ -189,6 +186,15 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
 	return mode;
 }
 
+static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
+					 struct bin_attribute *attr, int i)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+	return nvmem_bin_attr_get_umode(nvmem);
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -215,34 +221,14 @@ static const struct attribute_group *nvmem_dev_groups[] = {
 	NULL,
 };
 
-/* read only permission */
-static struct bin_attribute bin_attr_ro_nvmem = {
+static struct bin_attribute bin_attr_nvmem_eeprom_compat = {
 	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0444,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
-/* default read/write permissions, root only */
-static struct bin_attribute bin_attr_rw_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0600,
+		.name	= "eeprom",
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
 };
 
-/* read only permission, root only */
-static struct bin_attribute bin_attr_ro_root_nvmem = {
-	.attr	= {
-		.name	= "nvmem",
-		.mode	= 0400,
-	},
-	.read	= bin_attr_nvmem_read,
-};
-
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
  * drivers sys directory, to be backwards compatible with the older
@@ -259,18 +245,8 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only) {
-		if (config->root_only)
-			nvmem->eeprom = bin_attr_ro_root_nvmem;
-		else
-			nvmem->eeprom = bin_attr_ro_nvmem;
-	} else {
-		if (config->root_only)
-			nvmem->eeprom = bin_attr_rw_root_nvmem;
-		else
-			nvmem->eeprom = bin_attr_rw_nvmem;
-	}
-	nvmem->eeprom.attr.name = "eeprom";
+	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
+	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	nvmem->eeprom.attr.key = &eeprom_lock_key;
-- 
2.21.0

