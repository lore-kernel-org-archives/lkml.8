Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E3FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21939206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yer1qMkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHRSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:02:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F427C061389;
        Tue, 18 Aug 2020 11:02:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so10121328pgb.2;
        Tue, 18 Aug 2020 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L20P8403jh7NaEreRJgQf0yI/PQY6TdtSRpvsWG1Nwg=;
        b=Yer1qMkSot94NSN4We9/UMGJGz6Cg7NRQaxKJxV7iYiYKLKtlSGavf+K3EMgnBXTc3
         j3TCP39h7pwMEj0trIMxUoSvcunUbAnWFEaA1sQFA7yhAjo+ag0fZYoeZc5r2ZrBGRy+
         85ljPI7wc9UO5ZQ/SZRBWvVdItO4UYZKhUeO7Kxm1oWV2W3myBAu/cMSbnsZ2cOk19At
         yR3K5oHHR2Ciz0/QSMYfQWaFZH4ewxjVha8a0ymwpmkNOBUZ7CcNi6IhaU4hzTozqReU
         1444ylgliXlhZojNAKg2sNkXGW9G2F3QqRDGrVTrOtoclwRbeckcshvf9Re9rMegNPkj
         N9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L20P8403jh7NaEreRJgQf0yI/PQY6TdtSRpvsWG1Nwg=;
        b=r4b25D1Yt/BzvLQWmRPx+CVpwpmEG/HQvlrbogrMpWiWM97P1sFoXLILdydFSG54eP
         c96QACBfrLSx/J/wsVH70gHQMdf3utGq70CwGT3wLC91fKOO3KaeT2B40pxxr506Kf4D
         LCLM+z1fdDqJ7+83pSRllkvFH+3kZeqQxDai13PXbWlE18Qbz4/Nq/+G8TcmFYnPG1EM
         hKLaSn71obLrHTSfxdx0QaqjeuWFe4mFPob0+kD6m5gP38PdpvVPnVgOkvdThaAIY2f2
         GRGtGCp2JfFO5UaKwINBVfNJHSHDq51F3CR/Diaqty94v3SvFhEpQETVXeFnWOO9cqwM
         qvdw==
X-Gm-Message-State: AOAM533a7WauvZoVLt8eraAsnBE1N9wuph1w4lgQopqsK71C3cAknmVe
        h6GaRdkQpkn/SYt/0S+hVSkxqukm4+nKyQ==
X-Google-Smtp-Source: ABdhPJzsoVtgNS4J2yvA+ECu5N7RmiiGUKPVa9FaUApgrczZQ7GbR1dFi1um7AOTSjeuKU5oGyyLiw==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr15630674pfd.184.1597773748960;
        Tue, 18 Aug 2020 11:02:28 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id 2sm542583pjg.32.2020.08.18.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:02:28 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH] add support for battery charging threshold, mute. correctly save ac/dc brightness to hardware registers
Date:   Wed, 19 Aug 2020 02:02:23 +0800
Message-Id: <20200818180223.14282-1-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/platform/x86/panasonic-laptop.c | 576 +++++++++++++++++++++---
 1 file changed, 518 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 59e38a1d2830..55b6d6527f20 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -12,6 +12,19 @@
  *---------------------------------------------------------------------------
  *
  * ChangeLog:
+ *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *		-v0.98	add support for battery charging threshold (eco mode)
+ *			add write support for ac/dc brightness to hardware
+ *
+ *	Mar.12, 2018	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *		-v0.97	add support for cdpower switch
+ *			call CDDR instead of CDDI when switching off optical
+ *			drive to avoid a wrong arg error
+ *			add write support to mute
+ *
+ *	Jan.13, 2009	Martin Lucina <mato@kotelna.sk>
+ *		-v0.96	add support for optical drive power in Y and W series
+ *
  *	Sep.23, 2008	Harald Welte <laforge@gnumonks.org>
  *		-v0.95	rename driver from drivers/acpi/pcc_acpi.c to
  *			drivers/misc/panasonic-laptop.c
@@ -115,14 +128,10 @@
 #include <linux/acpi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
+#include <linux/platform_device.h>
 
-#ifndef ACPI_HOTKEY_COMPONENT
-#define ACPI_HOTKEY_COMPONENT	0x10000000
-#endif
 
-#define _COMPONENT		ACPI_HOTKEY_COMPONENT
-
-MODULE_AUTHOR("Hiroshi Miura, David Bronaugh and Harald Welte");
+MODULE_AUTHOR("Hiroshi Miura, David Bronaugh, Harald Welte, Martin Lucina and Kenneth Chan");
 MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Let's Note laptops");
 MODULE_LICENSE("GPL");
 
@@ -134,7 +143,10 @@ MODULE_LICENSE("GPL");
 #define METHOD_HKEY_SQTY	"SQTY"
 #define METHOD_HKEY_SINF	"SINF"
 #define METHOD_HKEY_SSET	"SSET"
-#define HKEY_NOTIFY		 0x80
+#define METHOD_ECWR		"\\_SB.ECWR"
+#define HKEY_NOTIFY		0x80
+#define ECO_MODE_OFF		0x00
+#define ECO_MODE_ON		0x80
 
 #define ACPI_PCC_DRIVER_NAME	"Panasonic Laptop Support"
 #define ACPI_PCC_DEVICE_NAME	"Hotkey"
@@ -143,7 +155,7 @@ MODULE_LICENSE("GPL");
 #define ACPI_PCC_INPUT_PHYS	"panasonic/hkey0"
 
 /* LCD_TYPEs: 0 = Normal, 1 = Semi-transparent
-   ENV_STATEs: Normal temp=0x01, High temp=0x81, N/A=0x00
+   ECO_MODEs: 0x03 = off, 0x83 = on
 */
 enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 		 SINF_LCD_TYPE,
@@ -155,7 +167,8 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 		 SINF_DC_CUR_BRIGHT,
 		 SINF_MUTE,
 		 SINF_RESERVED,
-		 SINF_ENV_STATE,
+		 SINF_ECO_MODE = 0x0A,
+		 SINF_CUR_BRIGHT = 0x0D,
 		 SINF_STICKY_KEY = 0x80,
 	};
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
@@ -208,13 +221,25 @@ static const struct key_entry panasonic_keymap[] = {
 struct pcc_acpi {
 	acpi_handle		handle;
 	unsigned long		num_sifr;
-	int			sticky_mode;
+	int			sticky_key;
+	int			eco_mode;
+	int			mute;
+	int			ac_brightness;
+	int			dc_brightness;
+	int			current_brightness;
 	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
 	struct backlight_device	*backlight;
+	struct platform_device	*platform;
 };
 
+/* Map brightness from 0-100% to 0x00-0xFF */
+static int backlight_map[] = { 0x08, 0x14, 0x20, 0x2D, 0x39, 0x45,
+			       0x52, 0x5E, 0x6A, 0x77, 0x83, 0x8F,
+			       0x9C, 0xA8, 0xB4, 0xC1, 0xCD, 0xD9,
+			       0xE6, 0xF2, 0xFF };
+
 /* method access functions */
 static int acpi_pcc_write_sset(struct pcc_acpi *pcc, int func, int val)
 {
@@ -246,8 +271,7 @@ static inline int acpi_pcc_get_sqty(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		return s;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SQTY\n"));
+		pr_err("evaluation error HKEY.SQTY\n");
 		return -EINVAL;
 	}
 }
@@ -262,21 +286,19 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SINF\n"));
+		pr_err("evaluation error HKEY.SINF\n");
 		return 0;
 	}
 
 	hkey = buffer.pointer;
 	if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
+		pr_err("Invalid HKEY.SINF\n");
 		status = AE_ERROR;
 		goto end;
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "SQTY reports bad SINF length\n"));
+		pr_err("SQTY reports bad SINF length\n");
 		status = AE_ERROR;
 		goto end;
 	}
@@ -286,8 +308,7 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 		if (likely(element->type == ACPI_TYPE_INTEGER)) {
 			pcc->sinf[i] = element->integer.value;
 		} else
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					 "Invalid HKEY.SINF data\n"));
+			pr_err("Invalid HKEY.SINF data\n");
 	}
 	pcc->sinf[hkey->package.count] = -1;
 
@@ -303,14 +324,37 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
  * logic to receive events in case a power supply is plugged in
  * or removed */
 
+/* Helper function to map brightness value (0x1-0x15) to brightness
+ * level (0x0 to 0xFF)
+ */
+static int pcc_bl_val_to_level(int val)
+{
+	int level;
+
+	for (level = 0; level < ARRAY_SIZE(backlight_map); level++) {
+		if (backlight_map[level] >= val) {
+			pr_debug("Current backlight level: 0x%X - index: %d\n",
+				backlight_map[level], level);
+			break;
+		}
+	}
+	return level;
+}
+
 static int bl_get(struct backlight_device *bd)
 {
+	int level;
 	struct pcc_acpi *pcc = bl_get_data(bd);
 
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return pcc->sinf[SINF_AC_CUR_BRIGHT];
+	if (pcc->num_sifr < 0xe)
+		level = pcc->sinf[SINF_AC_CUR_BRIGHT];
+	else
+		level = pcc_bl_val_to_level(pcc->sinf[SINF_CUR_BRIGHT]);
+
+	return level;
 }
 
 static int bl_set_status(struct backlight_device *bd)
@@ -332,7 +376,10 @@ static int bl_set_status(struct backlight_device *bd)
 	    bright > pcc->sinf[SINF_AC_MAX_BRIGHT])
 		return -EINVAL;
 
-	rc = acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, bright);
+	if (pcc->num_sifr >= 0xe)
+		rc = acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, backlight_map[bright]);
+	else
+		rc = acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, bright);
 	if (rc < 0)
 		return rc;
 
@@ -345,9 +392,101 @@ static const struct backlight_ops pcc_backlight_ops = {
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
 
-static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
+static ssize_t numbatt_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -359,7 +498,7 @@ static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
 }
 
-static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
+static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -371,7 +510,7 @@ static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
 }
 
-static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
+static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -383,8 +522,26 @@ static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
 }
 
-static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t mute_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val == 0 || val == 1) {
+		acpi_pcc_write_sset(pcc, SINF_MUTE, val);
+		pcc->mute = val;
+	}
+
+	return count;
+}
+
+static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
 	struct pcc_acpi *pcc = acpi_driver_data(acpi);
@@ -392,35 +549,263 @@ static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_STICKY_KEY]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sticky_key);
 }
 
-static ssize_t set_sticky(struct device *dev, struct device_attribute *attr,
+static ssize_t sticky_key_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
 	struct pcc_acpi *pcc = acpi_driver_data(acpi);
-	int val;
+	int err, val;
 
-	if (count && sscanf(buf, "%i", &val) == 1 &&
-	    (val == 0 || val == 1)) {
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val == 0 || val == 1) {
 		acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, val);
-		pcc->sticky_mode = val;
+		pcc->sticky_key = val;
+	}
+
+	return count;
+}
+
+static ssize_t eco_mode_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int result;
+
+	if (!acpi_pcc_retrieve_biosdata(pcc))
+		return -EIO;
+
+	switch (pcc->sinf[SINF_ECO_MODE]) {
+	case (ECO_MODE_OFF + 3):
+		result = 0;
+		break;
+	case (ECO_MODE_ON + 3):
+		result = 1;
+		break;
+	default:
+		result = -EIO;
+		break;
+	}
+	return snprintf(buf, PAGE_SIZE, "%u\n", result);
+}
+
+static ssize_t eco_mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, rc, state;
+
+	union acpi_object param[2];
+	struct acpi_object_list input;
+	acpi_status status;
+
+	param[0].type = ACPI_TYPE_INTEGER;
+	param[0].integer.value = 0x15;
+	param[1].type = ACPI_TYPE_INTEGER;
+	input.count = 2;
+	input.pointer = param;
+
+	err = kstrtoint(buf, 0, &state);
+	if (err)
+		return err;
+
+	switch (state) {
+	case 0:
+		param[1].integer.value = ECO_MODE_OFF;
+		pcc->sinf[SINF_ECO_MODE] = 0;
+		pcc->eco_mode = 0;
+		break;
+	case 1:
+		param[1].integer.value = ECO_MODE_ON;
+		pcc->sinf[SINF_ECO_MODE] = 1;
+		pcc->eco_mode = 1;
+		break;
+	default:
+		/* nothing to do */
+		rc = -EIO;
+		break;
+	}
+
+	status = acpi_evaluate_object(NULL, METHOD_ECWR,
+				       &input, NULL);
+	if (ACPI_FAILURE(status)) {
+		pr_err("%s evaluation failed\n", METHOD_ECWR);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t ac_brightness_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (!acpi_pcc_retrieve_biosdata(pcc))
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_AC_CUR_BRIGHT]);
+}
+
+static ssize_t ac_brightness_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val >= 0 || val <= 255) {
+		acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, val);
+		pcc->ac_brightness = val;
 	}
 
 	return count;
 }
 
-static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
-static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
-static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
-static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
+static ssize_t dc_brightness_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (!acpi_pcc_retrieve_biosdata(pcc))
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_DC_CUR_BRIGHT]);
+}
+
+static ssize_t dc_brightness_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val >= 0 || val <= 255) {
+		acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, val);
+		pcc->dc_brightness = val;
+	}
+
+	return count;
+}
+
+static ssize_t current_brightness_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (!acpi_pcc_retrieve_biosdata(pcc))
+		return -EIO;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_CUR_BRIGHT]);
+}
+
+static ssize_t current_brightness_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val >= 0 || val <= 255) {
+		err = acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, val);
+		pcc->current_brightness = val;
+	}
+
+	return count;
+}
+
+static ssize_t brightness_level_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int level;
+
+	if (!acpi_pcc_retrieve_biosdata(pcc))
+		return -EIO;
+
+	level = pcc_bl_val_to_level(pcc->sinf[SINF_CUR_BRIGHT]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", level);
+}
+
+static ssize_t brightness_level_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val >= pcc->sinf[SINF_AC_MIN_BRIGHT] || val <= pcc->sinf[SINF_AC_MAX_BRIGHT]) {
+		err = acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, val);
+		pcc->current_brightness = val;
+	}
+
+	return count;
+}
+
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
+static DEVICE_ATTR_RO(numbatt);
+static DEVICE_ATTR_RO(lcdtype);
+static DEVICE_ATTR_RW(mute);
+static DEVICE_ATTR_RW(sticky_key);
+static DEVICE_ATTR_RW(eco_mode);
+static DEVICE_ATTR_RW(ac_brightness);
+static DEVICE_ATTR_RW(dc_brightness);
+static DEVICE_ATTR_RW(current_brightness);
+static DEVICE_ATTR_RW(brightness_level);
+static DEVICE_ATTR_RW(cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
 	&dev_attr_lcdtype.attr,
 	&dev_attr_mute.attr,
 	&dev_attr_sticky_key.attr,
+	&dev_attr_eco_mode.attr,
+	&dev_attr_ac_brightness.attr,
+	&dev_attr_dc_brightness.attr,
+	&dev_attr_current_brightness.attr,
+	&dev_attr_brightness_level.attr,
+	&dev_attr_cdpower.attr,
 	NULL,
 };
 
@@ -442,8 +827,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
 	if (ACPI_FAILURE(rc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "error getting hotkey status\n"));
+		pr_err("error getting hotkey status\n");
 		return;
 	}
 
@@ -456,10 +840,11 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 					result & 0xf, 0x80, false);
 	}
 
-	if (!sparse_keymap_report_event(hotk_input_dev,
-					result & 0xf, result & 0x80, false))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unknown hotkey event: %d\n", result));
+	if ((result & 0xf) == 0x7 || (result & 0xf) == 0x9 || (result & 0xf) == 0xa) {
+		if (!sparse_keymap_report_event(hotk_input_dev,
+						result & 0xf, result & 0x80, false))
+			pr_err("Unknown hotkey event: 0x%04llx\n", result);
+	}
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
@@ -476,6 +861,50 @@ static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
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
@@ -494,15 +923,13 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 
 	error = sparse_keymap_setup(input_dev, panasonic_keymap, NULL);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to setup input device keymap\n"));
+		pr_err("Unable to setup input device keymap\n");
 		goto err_free_dev;
 	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to register input device\n"));
+		pr_err("Unable to register input device\n");
 		goto err_free_dev;
 	}
 
@@ -528,10 +955,14 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
-			  pcc->sticky_mode));
+	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
+	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
+	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
+	acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, pcc->ac_brightness);
+	acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, pcc->dc_brightness);
+	acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
 
-	return acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_mode);
+	return 0;
 }
 #endif
 
@@ -547,14 +978,13 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	if (num_sifr < 0 || num_sifr > 255) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr out of range"));
+		pr_err("num_sifr out of range");
 		return -ENODEV;
 	}
 
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Couldn't allocate mem for pcc"));
+		pr_err("Couldn't allocate mem for pcc");
 		return -ENOMEM;
 	}
 
@@ -573,14 +1003,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing keyinput handler\n"));
+		pr_err("Error installing keyinput handler\n");
 		goto out_sinf;
 	}
 
 	if (!acpi_pcc_retrieve_biosdata(pcc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "Couldn't retrieve BIOS data\n"));
+		pr_err("Couldn't retrieve BIOS data\n");
 		result = -EIO;
 		goto out_input;
 	}
@@ -598,16 +1026,42 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	/* read the initial brightness setting from the hardware */
 	pcc->backlight->props.brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
 
-	/* read the initial sticky key mode from the hardware */
-	pcc->sticky_mode = pcc->sinf[SINF_STICKY_KEY];
+	/* Reset initial sticky key mode since the hardware register state is not consistent */
+	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
+	pcc->sticky_key = 0;
+
+	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
+	pcc->mute = pcc->sinf[SINF_MUTE];
+	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
+	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
+	result = pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
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
@@ -627,6 +1081,12 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
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

Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
