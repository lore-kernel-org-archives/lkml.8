Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E733C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B93E20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNC5deBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgDMVGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbgDMVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:06:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D9C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:06:52 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z9so7633949plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=FNC5deBelKjQu9FQsxeDOLK8dE9RzOssihuoDJkcERxLh1LBzR9As37XDqlykamblH
         H6sOT/wtr0SQv9/3+IXDT1GHWnoT8ecRaYNvy//giJCXMGeGJ3wd/7Ya/Eq3ppTD1a2u
         f8iT3ZcSVqBTzNOvszdjAIWlt1GukNnhAZdmCbEevZXhG6s7079smKzUzbX90zSv8gY0
         e7iwZNYwqtAPweHkrfy9hVFLEl5xw4Pjklvq9cgZrAJMoyr8JDFXl+txh8YK22uDEaXE
         1/3oxX/THgt0KyBGSXepiXq+nLDgl8LqoQ0tTPoUh87+rgezNp/GZkhbggIfvZsNhVKO
         u5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IV0jCGjY4W6KdLiLfKem198qqlhSCntJsgHYVO+E6jU=;
        b=MDMAab+GYMw7bFaSp1j4YlTuZF5YiICBNaKkzr5WrBIf2BydjDQVeg1JWimcUkIM6b
         3djclnXT7ssHCE5ziRxHyU43CmbqLuy0N81traxj0Un2jaUm+Lx0NzDixiW7XyJ/eimi
         9BqR+uMyDzMw+aD+kfNtbappFsBZch5Ijr+wVt9sC9gk2CTDcjZt11scrfOuAt2ncot0
         +so9m4hdogXanYv9ILxb/DmLB731c426p2nRdMPLvxSQDknYaWt4XUVttZGe3DaOVGRZ
         gomG++UCQ0SJ6yjGypbSb+IAblwr111NQM5+Mmb3zCM5v97iHpHsbXTD50D349O3By9b
         jUMA==
X-Gm-Message-State: AGi0PuZcHXnJlGebFFYFsBobmEH9MSVSyZEx/QKFY+ERLFwYZviS5ypl
        dV9P5/kyiNADYvbaspD+LQ6DddTOb6DQCS3G4tsQpBrO9LFHtu543KmHx+cl+UZxmj3CkSqepGY
        N7nfOgiONwGUsk0j6hy5P/q+zbNCs19G8qhMKtUPB4ftPx13KU9rlMEsOcUSGYzxFLoMuUMkB+S
        d32N7OaFToTB658o8=
X-Google-Smtp-Source: APiQypIJh3M/I5cOHqVYEHsnkdDtigtwOiciiePxgVDuJ8OG5dy1ncDxT6Fx/Pgv+rzuviXoXgvVVwmVfpKywghiEC6XQg==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr23517001pjs.156.1586812011717;
 Mon, 13 Apr 2020 14:06:51 -0700 (PDT)
Date:   Mon, 13 Apr 2020 14:06:42 -0700
Message-Id: <20200413210644.201801-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH 1/3] thermal/int340x_thermal: Export GDDV
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

Implementing DPTF properly requires making use of firmware-provided
information associated with the INT3400 device. Calling GDDV provides a
buffer of information which userland can then interpret to determine
appropriate DPTF policy.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index ceef89c956bd4..00a7732724cd0 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -52,6 +52,25 @@ struct int3400_thermal_priv {
 	u8 uuid_bitmap;
 	int rel_misc_dev_res;
 	int current_uuid_index;
+	char *data_vault;
+};
+
+static ssize_t data_vault_read(struct file *file, struct kobject *kobj,
+	     struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	memcpy(buf, attr->private + off, count);
+	return count;
+}
+
+static BIN_ATTR_RO(data_vault, 0);
+
+static struct bin_attribute *data_attributes[] = {
+	&bin_attr_data_vault,
+	NULL,
+};
+
+static const struct attribute_group data_attribute_group = {
+	.bin_attrs = data_attributes,
 };
 
 static ssize_t available_uuids_show(struct device *dev,
@@ -278,6 +297,32 @@ static struct thermal_zone_params int3400_thermal_params = {
 	.no_hwmon = true,
 };
 
+static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = acpi_evaluate_object(priv->adev->handle, "GDDV", NULL,
+				      &buffer);
+	if (ACPI_FAILURE(status) || !buffer.length)
+		return;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
+	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return;
+	}
+
+	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
+				   obj->package.elements[0].buffer.length,
+				   GFP_KERNEL);
+	bin_attr_data_vault.private = priv->data_vault;
+	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;
+	kfree(buffer.pointer);
+}
+
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
@@ -309,6 +354,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	int3400_setup_gddv(priv);
+
 	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
 
@@ -327,6 +374,13 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (result)
 		goto free_rel_misc;
 
+	if (priv->data_vault) {
+		result = sysfs_create_group(&pdev->dev.kobj,
+					    &data_attribute_group);
+		if (result)
+			goto free_uuid;
+	}
+
 	result = acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
@@ -336,6 +390,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 free_sysfs:
+	if (priv->data_vault)
+		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 free_rel_misc:
 	if (!priv->rel_misc_dev_res)
@@ -360,8 +417,11 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
+	if (priv->data_vault)
+		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	thermal_zone_device_unregister(priv->thermal);
+	kfree(priv->data_vault);
 	kfree(priv->trts);
 	kfree(priv->arts);
 	kfree(priv);
-- 
2.26.0.110.g2183baf09c-goog

