Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87083C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0592080C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hyiz0iSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCWPAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38910 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCWPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so17493582wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKz+43pYWEKiqemNMbJW8RSxtkKY/tbV+925ZPw1MUM=;
        b=Hyiz0iShcNQgLk81bzvNCYEI3zVhyjb9CTyz7QVnaTUUwwdZyoSweONNSqU8t4qh+f
         UOs+sccBizFvLMiCTflKaNtQt+P5WYcmnC8zhwNkOueu7/vFfD2bwIAQee9gemq1KD21
         kgeJvUVJQIXaktiXb5NmgG0XgHaxN7g4bR/lFzGlJUjAuMpjklkuhiYTF1PhW8bL0OEB
         IxaIfWXrmKbBErhnQJwhZ9DsMUJG1gTYCSQEoUo4QjfMb6TF1JeXokAMSmryppjdRnSD
         g/LJefhbug1b+guiUTrZDn+O4nJgpd+y5YTBER2HXtsBBdgsX840oJ20O6EW+jdNbcpz
         GmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKz+43pYWEKiqemNMbJW8RSxtkKY/tbV+925ZPw1MUM=;
        b=RyD0mGBisMJtaQXeIZcQ020o3MhEyWx1AKNSnDar2VVW1w63OigqfBdOvLEUZsBbDK
         gzziZS1IB9tkQHRNPIf5Kz+DIqXTAeFez8bj67HgtFN7RmRE+lZZWQCjQGtx4txY11Ci
         RAs3SzphDUOuIWJz3+4YU+JT42VwdUYV5MbTZ5QIfim361el97ZjBhKbzgVSDbYvBOVS
         TbF5Id7QcUBUIFjkv5aZhAS6v9kDRruSoxhBmOFV3Ke5sl6ojQjqLlch2ZgAUK+n2SCo
         179NyT+bBHTj8TCltI2eH8w9V2DpzyJE0NLVTKEuvZvlpVEbTGXbC7MrqoAL5pOT7XKD
         KbmQ==
X-Gm-Message-State: ANhLgQ0BR3MKoy1sJOb5KQAhn9R4gKPlK9Vgsp3LqaNKtC2Ho0TD97mM
        21sF6Cks87O19PEhHHrJ1fzo9Q==
X-Google-Smtp-Source: ADFU+vv3/WhwNr1XiGH3+qclsgA002DaA7wInGOVzE4FBnyG31g2jAslkgp+85cvBpSWmJr8PRDWxA==
X-Received: by 2002:a5d:4b52:: with SMTP id w18mr17183476wrs.233.1584975625938;
        Mon, 23 Mar 2020 08:00:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] nvmem: Add support for write-only instances
Date:   Mon, 23 Mar 2020 15:00:07 +0000
Message-Id: <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

There is at least one real-world use-case for write-only nvmem
instances. Refer to 03cd45d2e219 ("thunderbolt: Prevent crash if
non-active NVMem file is read").

Add support for write-only nvmem instances by adding attrs for 0200.

Change nvmem_register() to abort if NULL group is returned from
nvmem_sysfs_get_groups().

Return NULL from nvmem_sysfs_get_groups() in invalid cases.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c        | 10 +++++--
 drivers/nvmem/nvmem-sysfs.c | 56 +++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 77d890d3623d..ddc7be5149d5 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -381,6 +381,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->type = config->type;
 	nvmem->reg_read = config->reg_read;
 	nvmem->reg_write = config->reg_write;
+	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
+	if (!nvmem->dev.groups) {
+		ida_simple_remove(&nvmem_ida, nvmem->id);
+		gpiod_put(nvmem->wp_gpio);
+		kfree(nvmem);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!config->no_of_node)
 		nvmem->dev.of_node = config->dev->of_node;
 
@@ -395,8 +403,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
-
 	device_initialize(&nvmem->dev);
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
index 8759c4470012..9728da948988 100644
--- a/drivers/nvmem/nvmem-sysfs.c
+++ b/drivers/nvmem/nvmem-sysfs.c
@@ -202,16 +202,49 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
 	NULL,
 };
 
+/* write only permission, root only */
+static struct bin_attribute bin_attr_wo_root_nvmem = {
+	.attr	= {
+		.name	= "nvmem",
+		.mode	= 0200,
+	},
+	.write	= bin_attr_nvmem_write,
+};
+
+static struct bin_attribute *nvmem_bin_wo_root_attributes[] = {
+	&bin_attr_wo_root_nvmem,
+	NULL,
+};
+
+static const struct attribute_group nvmem_bin_wo_root_group = {
+	.bin_attrs	= nvmem_bin_wo_root_attributes,
+	.attrs		= nvmem_attrs,
+};
+
+static const struct attribute_group *nvmem_wo_root_dev_groups[] = {
+	&nvmem_bin_wo_root_group,
+	NULL,
+};
+
 const struct attribute_group **nvmem_sysfs_get_groups(
 					struct nvmem_device *nvmem,
 					const struct nvmem_config *config)
 {
-	if (config->root_only)
-		return nvmem->read_only ?
-			nvmem_ro_root_dev_groups :
-			nvmem_rw_root_dev_groups;
+	/* Read-only */
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only))
+		return config->root_only ?
+			nvmem_ro_root_dev_groups : nvmem_ro_dev_groups;
+
+	/* Read-write */
+	if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
+		return config->root_only ?
+			nvmem_rw_root_dev_groups : nvmem_rw_dev_groups;
+
+	/* Write-only, do not honour request for global writable entry */
+	if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only)
+		return config->root_only ? nvmem_wo_root_dev_groups : NULL;
 
-	return nvmem->read_only ? nvmem_ro_dev_groups : nvmem_rw_dev_groups;
+	return NULL;
 }
 
 /*
@@ -230,17 +263,24 @@ int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (nvmem->read_only) {
+	if (nvmem->reg_read && (!nvmem->reg_write || nvmem->read_only)) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_ro_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_ro_nvmem;
-	} else {
+	} else if (!nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
+		if (config->root_only)
+			nvmem->eeprom = bin_attr_wo_root_nvmem;
+		else
+			return -EINVAL;
+	} else if (nvmem->reg_read && nvmem->reg_write && !nvmem->read_only) {
 		if (config->root_only)
 			nvmem->eeprom = bin_attr_rw_root_nvmem;
 		else
 			nvmem->eeprom = bin_attr_rw_nvmem;
-	}
+	} else
+		return -EINVAL;
+
 	nvmem->eeprom.attr.name = "eeprom";
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.21.0

