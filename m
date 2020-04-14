Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBA2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41EF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OqkFAcjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403974AbgDNCKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728785AbgDNCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:10:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E2CC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 19:10:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l9so11688748pjq.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YHR3wLSj0M6BuUX/ipe64SAlKpucYOALnl0bw9GVsCk=;
        b=OqkFAcjncMFLHI/UNUK8qcvtRfUYyM8YNCWg5A9aOvs5rMmWYjmzs6UmPpAmPV//xt
         naAfYZIcJFHBIwfU86vDOojKFwUtH68H7quwzPEfX7/QgjcculvnUAH1IqzLMmQ4VBi6
         YIbO51AsZFJRtu+cJJZBmPiwguAIxtLPjKoJCTXKrWfXz4EagT5epD6P35PC4LTnfWmi
         A9Z8l8DLtloQsE1OGXBU9lPcnquzTTE/YQoon+g+R+/SBx6R0yO500wWpESGalcyM9av
         1JvFMAVBilWOtRjPhMSjqfiVwUEvp8MHJINx2hjT9Nu4BaW0qMR/W4eIMgeXIQfZHmjX
         LsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHR3wLSj0M6BuUX/ipe64SAlKpucYOALnl0bw9GVsCk=;
        b=Y2cShyP6L0yo50py4dSan9SF36+p2KJvDhbfbYAYEBPUI3du7hQoYUcGkkd8gEJoYc
         2XPF/ehaubmt0sTghk11ZECW8rewLMlr4g4PDgBcELPnH7r3KQKxWpcVkzaY1RsmETP5
         GIkdYy6l2aShY37P9XUFqAk4pyLdMw8J+c3TF0dc0rI6/BaXLVH+2ZR0NsWOvv/KLGWP
         5pWFtu7VGY5C3DoacU9kSl1uo2ve3WjN+qsLJPfx9bNeRyTnYQa4HTUzQ2/w68WnBbwX
         CXdW6n0qKIljINPixLeDYTgnp1hBmcrzCHX828T/jvjZYbxTn3QvTLOUmbCfU5ZXh9K1
         hh+A==
X-Gm-Message-State: AGi0PuauR7BvaQ4oHNZiKGkzSKYqUstKQJuz7hPYBaefe32TJj5/c4Tw
        J/H1mK9F9iFgFljV6z1Z3iCftLpwwJEEt2/VPpwhXViv3WSyIZAQEaENAl7R/d+U/PVSEggPge4
        W95YJMY+FYPrhmp9V/A409X97VRG5PRSj9mXZMxewtCQe0+LD8e9DZLX/4VQ1MJEotcoi/b5tH4
        KWEAGcp7/LFzjyneU=
X-Google-Smtp-Source: APiQypKIH4SbR/v8HfyOjpSGIpJ8JHSb5NCuk2cLc0PWMCcKvfXTimCbze7nJveA0VBep7ccJChZv9TM63tU0O9F1LvJdQ==
X-Received: by 2002:a17:90a:3268:: with SMTP id k95mr23984813pjb.185.1586830201490;
 Mon, 13 Apr 2020 19:10:01 -0700 (PDT)
Date:   Mon, 13 Apr 2020 19:09:52 -0700
In-Reply-To: <20200414020953.255364-1-matthewgarrett@google.com>
Message-Id: <20200414020953.255364-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20200414020953.255364-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH V2 2/3] thermal/int340x_thermal: Export OEM vendor variables
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com,
        nisha.aram@intel.com, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

The platform vendor may expose an array of OEM-specific values to be used
in determining DPTF policy. These are obtained via the ODVP method, and
then simply exposed in sysfs. In addition, they are updated when a
notification is received or when the DPTF policy is changed by userland.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 132 +++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 00a7732724cd0..3919098a73b47 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -13,6 +13,7 @@
 #include "acpi_thermal_rel.h"
 
 #define INT3400_THERMAL_TABLE_CHANGED 0x83
+#define INT3400_ODVP_CHANGED 0x88
 
 enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
@@ -41,8 +42,11 @@ static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"BE84BABF-C4D4-403D-B495-3128FD44dAC1",
 };
 
+struct odvp_attr;
+
 struct int3400_thermal_priv {
 	struct acpi_device *adev;
+	struct platform_device *pdev;
 	struct thermal_zone_device *thermal;
 	int mode;
 	int art_count;
@@ -53,6 +57,17 @@ struct int3400_thermal_priv {
 	int rel_misc_dev_res;
 	int current_uuid_index;
 	char *data_vault;
+	int odvp_count;
+	int *odvp;
+	struct odvp_attr *odvp_attrs;
+};
+
+static int evaluate_odvp(struct int3400_thermal_priv *priv);
+
+struct odvp_attr {
+	int odvp;
+	struct int3400_thermal_priv *priv;
+	struct kobj_attribute attr;
 };
 
 static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
@@ -210,9 +225,110 @@ static int int3400_thermal_run_osc(acpi_handle handle,
 		result = -EPERM;
 
 	kfree(context.ret.pointer);
+
 	return result;
 }
 
+static ssize_t odvp_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct odvp_attr *odvp_attr;
+
+	odvp_attr = container_of(attr, struct odvp_attr, attr);
+
+	return sprintf(buf, "%d\n", odvp_attr->priv->odvp[odvp_attr->odvp]);
+}
+
+static void cleanup_odvp(struct int3400_thermal_priv *priv)
+{
+	int i;
+
+	if (priv->odvp_attrs) {
+		for (i = 0; i < priv->odvp_count; i++) {
+			sysfs_remove_file(&priv->pdev->dev.kobj,
+					  &priv->odvp_attrs[i].attr.attr);
+			kfree(priv->odvp_attrs[i].attr.attr.name);
+		}
+		kfree(priv->odvp_attrs);
+	}
+	kfree(priv->odvp);
+	priv->odvp_count = 0;
+}
+
+static int evaluate_odvp(struct int3400_thermal_priv *priv)
+{
+	struct acpi_buffer odvp = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj = NULL;
+	acpi_status status;
+	int i, ret;
+
+	status = acpi_evaluate_object(priv->adev->handle, "ODVP", NULL, &odvp);
+	if (ACPI_FAILURE(status)) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	obj = odvp.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	if (priv->odvp == NULL) {
+		priv->odvp_count = obj->package.count;
+		priv->odvp = kmalloc_array(priv->odvp_count, sizeof(int),
+				     GFP_KERNEL);
+		if (!priv->odvp) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+	}
+
+	if (priv->odvp_attrs == NULL) {
+		priv->odvp_attrs = kcalloc(priv->odvp_count,
+					   sizeof(struct odvp_attr),
+					   GFP_KERNEL);
+		if (!priv->odvp_attrs) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+		for (i = 0; i < priv->odvp_count; i++) {
+			struct odvp_attr *odvp = &priv->odvp_attrs[i];
+
+			sysfs_attr_init(&odvp->attr.attr);
+			odvp->priv = priv;
+			odvp->odvp = i;
+			odvp->attr.attr.name = kasprintf(GFP_KERNEL,
+							 "odvp%d", i);
+
+			if (!odvp->attr.attr.name) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
+			odvp->attr.attr.mode = 0444;
+			odvp->attr.show = odvp_show;
+			odvp->attr.store = NULL;
+			ret = sysfs_create_file(&priv->pdev->dev.kobj,
+						&odvp->attr.attr);
+			if (ret)
+				goto out_err;
+		}
+	}
+
+	for (i = 0; i < obj->package.count; i++) {
+		if (obj->package.elements[i].type == ACPI_TYPE_INTEGER)
+			priv->odvp[i] = obj->package.elements[i].integer.value;
+	}
+
+	kfree(obj);
+	return 0;
+
+out_err:
+	cleanup_odvp(priv);
+	kfree(obj);
+	return ret;
+}
+
 static void int3400_notify(acpi_handle handle,
 			u32 event,
 			void *data)
@@ -236,6 +352,9 @@ static void int3400_notify(acpi_handle handle,
 		kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE,
 				thermal_prop);
 		break;
+	case INT3400_ODVP_CHANGED:
+		evaluate_odvp(priv);
+		break;
 	default:
 		/* Ignore unknown notification codes sent to INT3400 device */
 		break;
@@ -285,6 +404,9 @@ static int int3400_thermal_set_mode(struct thermal_zone_device *thermal,
 						 priv->current_uuid_index,
 						 enable);
 	}
+
+	evaluate_odvp(priv);
+
 	return result;
 }
 
@@ -336,6 +458,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->pdev = pdev;
 	priv->adev = adev;
 
 	result = int3400_thermal_get_uuids(priv);
@@ -356,6 +479,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	int3400_setup_gddv(priv);
 
+	evaluate_odvp(priv);
+
 	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
 
@@ -390,8 +515,11 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 free_sysfs:
-	if (priv->data_vault)
+	cleanup_odvp(priv);
+	if (priv->data_vault) {
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		kfree(priv->data_vault);
+	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 free_rel_misc:
@@ -414,6 +542,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 			priv->adev->handle, ACPI_DEVICE_NOTIFY,
 			int3400_notify);
 
+	cleanup_odvp(priv);
+
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
-- 
2.26.0.110.g2183baf09c-goog

