Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC87C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6509A20720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irQ94+XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHUSQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHUSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548DC061573;
        Fri, 21 Aug 2020 11:16:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so1167284pjr.0;
        Fri, 21 Aug 2020 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vj0RNYwnTuSjxkhXGkQhasxC4eymCZqsHb+a4UD3Lmc=;
        b=irQ94+XIlNv/6fNWJi1uqqJlMb8/cQcpcol8Pe1T+1mDL8ihnHJ8usgpjseA6oKtnJ
         cRsLk/ickn0vCysLW+B4n2jltPQ6d2nEUqJTi3Mid+4x8kV/7O6htIA/iA8QI8ratLQu
         VNiAPsC4JZ5sGEGnlzTimKvuuNlG9kKmFTve9XrFGsZ7j+0hBG4FnDJWjCj8ms5FzSd5
         S8/79xCLU+hUJqNJu9ujtX5WNqQhZr3byqnxvJHMRH6WXyLysLTqTHDhi4rNJ6bJowE7
         gtw6z2Kwdft69FcDvEznSEXX8QNr/9rZPHU0fVSgMwSg5QNHTTojWnZSgTLBCukEd4U6
         +z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vj0RNYwnTuSjxkhXGkQhasxC4eymCZqsHb+a4UD3Lmc=;
        b=m0tUUgtdObvX9PuEEt9G9e/s0wwMyyLibbRQwkI4TP0lNEB6ChHFalVxPYZKuON1lN
         KFrqT3vujEk5SIqDNUGIdUJKl+Sc3yfxzn+ZeFg9WZG5wRUIJ3YxfpQixbs8bprAhm+u
         CZT0Z9XU1+WqOVUk6uAL3Xoq1UYcU/bEb1iNLPhe7eNwGbVKFw4hxVWUxcML2fjjm026
         77CQu6xfl9DgVVWaqsPSTODUobM7aZkWjBfDK1565skuXaeM9JCcOPcJVcXVFlzXYiYQ
         JDlDS9qRDig5cDigdHfR9OPKk45fYjg3q0z6cbSfOiJ2+4zTHNdNgVS8qo9ZEaAr+FMa
         Dnsw==
X-Gm-Message-State: AOAM532s26KzZr6s6/MVrDD3mFUnxmoaLKWrmOpXcxhziECl3mI1Bib1
        /V5ixrGwf7qh7eV2sti6FuYJe9r9YFI3IQ==
X-Google-Smtp-Source: ABdhPJxo5lJpHeks8W+Ehi1DAE+kDcpm+SXDNRgmpNrkP/EH94vkHX4svUQe65FBGl4n1sM0DLcl4Q==
X-Received: by 2002:a17:90a:630c:: with SMTP id e12mr3293065pjj.17.1598033780253;
        Fri, 21 Aug 2020 11:16:20 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:19 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 1/9] add support for optical driver power in Y and W series
Date:   Sat, 22 Aug 2020 02:14:25 +0800
Message-Id: <20200821181433.17653-2-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The physical optical drive switch is present in Y and W series that switches
on the drive but fails to turn it off. The idea is to be able to toggle the
drive power by software and/or hardware. This patch merges Martin Lucina
<mato@kotelna.sk>'s work that took care of the software part.

Code is also added for the physical switch to power off the drive.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 190 ++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 59e38a1d2830..21cdc2149a10 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -12,6 +12,13 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
+ *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *		-v0.97	add support for cdpower hardware switch
+ *		-v0.96	merge Lucina's enhancement
+ *			Jan.13, 2009 Martin Lucina <mato@kotelna.sk>
+ *				- add support for optical driver power in
+ *				  Y and W series
+ *
  *	Sep.23, 2008	Harald Welte <laforge@gnumonks.org>
  *		-v0.95	rename driver from drivers/acpi/pcc_acpi.c to
  *			drivers/misc/panasonic-laptop.c
@@ -115,6 +122,7 @@
 #include <linux/acpi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/platform_device.h>
 
 #ifndef ACPI_HOTKEY_COMPONENT
 #define ACPI_HOTKEY_COMPONENT	0x10000000
@@ -213,6 +221,7 @@ struct pcc_acpi {
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
 	struct backlight_device	*backlight;
+	struct platform_device	*platform;
 };
 
 /* method access functions */
@@ -345,6 +354,98 @@ static const struct backlight_ops pcc_backlight_ops = {
 };
 
 
+/* returns ACPI_SUCCESS if methods to control optical drive are present */
+
+static acpi_status check_optd_present(void)
+{
+	acpi_status status = AE_OK;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB.STAT", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+	status = acpi_get_handle(NULL, "\\_SB.FBAY", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+	status = acpi_get_handle(NULL, "\\_SB.CDDI", &handle);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+out:
+	return status;
+}
+
+/* get optical driver power state */
+
+static int get_optd_power_state(void)
+{
+	acpi_status status;
+	unsigned long long state;
+	int result;
+
+	status = acpi_evaluate_integer(NULL, "\\_SB.STAT", NULL, &state);
+	if (ACPI_FAILURE(status)) {
+		pr_err("evaluation error _SB.STAT\n");
+		result = -EIO;
+		goto out;
+	}
+	switch (state) {
+	case 0: /* power off */
+		result = 0;
+		break;
+	case 0x0f: /* power on */
+		result = 1;
+		break;
+	default:
+		result = -EIO;
+		break;
+	}
+
+out:
+	return result;
+}
+
+/* set optical drive power state */
+
+static int set_optd_power_state(int new_state)
+{
+	int result;
+	acpi_status status;
+
+	result = get_optd_power_state();
+	if (result < 0)
+		goto out;
+	if (new_state == result)
+		goto out;
+
+	switch (new_state) {
+	case 0: /* power off */
+		/* Call CDDR instead, since they both call the same method
+		 * while CDDI takes 1 arg and we are not quite sure what it is.
+		 */
+		status = acpi_evaluate_object(NULL, "\\_SB.CDDR", NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			pr_err("evaluation error _SB.CDDR\n");
+			result = -EIO;
+		}
+		break;
+	case 1: /* power on */
+		status = acpi_evaluate_object(NULL, "\\_SB.FBAY", NULL, NULL);
+		if (ACPI_FAILURE(status)) {
+			pr_err("evaluation error _SB.FBAY\n");
+			result = -EIO;
+		}
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+
+out:
+	return result;
+}
+
+
 /* sysfs user interface functions */
 
 static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
@@ -411,16 +512,36 @@ static ssize_t set_sticky(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", get_optd_power_state());
+}
+
+static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	int err, val;
+
+	err = kstrtoint(buf, 10, &val);
+	if (err)
+		return err;
+	set_optd_power_state(val);
+	return count;
+}
+
 static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
 static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
 static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
 static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
+static DEVICE_ATTR_RW(cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
 	&dev_attr_lcdtype.attr,
 	&dev_attr_mute.attr,
 	&dev_attr_sticky_key.attr,
+	&dev_attr_cdpower.attr,
 	NULL,
 };
 
@@ -476,6 +597,50 @@ static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
 	}
 }
 
+static void pcc_optd_notify(acpi_handle handle, u32 event, void *data)
+{
+	if (event != ACPI_NOTIFY_EJECT_REQUEST)
+		return;
+
+	set_optd_power_state(0);
+}
+
+static int pcc_register_optd_notifier(struct pcc_acpi *pcc, char *node)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, node, &handle);
+
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_install_notify_handler(handle,
+				ACPI_SYSTEM_NOTIFY,
+				pcc_optd_notify, pcc);
+		if (ACPI_FAILURE(status))
+			pr_err("Failed to register notify on %s\n", node);
+	} else
+		return -ENODEV;
+
+	return 0;
+}
+
+static void pcc_unregister_optd_notifier(struct pcc_acpi *pcc, char *node)
+{
+	acpi_status status = AE_OK;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, node, &handle);
+
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_remove_notify_handler(handle,
+				ACPI_SYSTEM_NOTIFY,
+				pcc_optd_notify);
+		if (ACPI_FAILURE(status))
+			pr_err("Error removing optd notify handler %s\n",
+					node);
+	}
+}
+
 static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 {
 	struct input_dev *input_dev;
@@ -606,8 +771,27 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	if (result)
 		goto out_backlight;
 
+	/* optical drive initialization */
+	if (ACPI_SUCCESS(check_optd_present())) {
+		pcc->platform = platform_device_register_simple("panasonic",
+			-1, NULL, 0);
+		if (IS_ERR(pcc->platform)) {
+			result = PTR_ERR(pcc->platform);
+			goto out_backlight;
+		}
+		result = device_create_file(&pcc->platform->dev,
+			&dev_attr_cdpower);
+		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
+		if (result)
+			goto out_platform;
+	} else {
+		pcc->platform = NULL;
+	}
+
 	return 0;
 
+out_platform:
+	platform_device_unregister(pcc->platform);
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
 out_input:
@@ -627,6 +811,12 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
 	if (!device || !pcc)
 		return -EINVAL;
 
+	if (pcc->platform) {
+		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
+		platform_device_unregister(pcc->platform);
+	}
+	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
+
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
 	backlight_device_unregister(pcc->backlight);
-- 
2.17.5

