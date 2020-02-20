Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA5C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyLIrdO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:48:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44569 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:48:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so1488091pfb.11;
        Wed, 19 Feb 2020 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Nh/sE8E54kbhANiaxeyQqh/Z69sM3wG9T1CQJH+T/g=;
        b=pyLIrdO+jGm3rWDrw8+RXNSnRWdzwqooDeTQM/Vl15MWauTMvhfEkHqrtjzON3Xo9b
         Mhh1dnHOx95TuPKcGqpK+ljwzagp1PDmEznxVPCg+TFx2zDGeZaBRqvQbtCgCpLsYPGS
         KOaiDpDYmvcS52HYa5we3fHc0p87CxjL/g9qA2yv5BQgRNIrTLnff8Mw4MdNQtyrqTkJ
         561AbDQIjup3MO4btGVNRFK1qc2A86YnD9O8+MNMwIN+kh8oqZKnYdaR02V8XP1Lm7iX
         KuJDr2hOjQtcdiHoV+GNjtyGrBWiH7CV3vJVFV+q2JhcN6h3heeE0Oz9oztnyMd99cFb
         Zx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Nh/sE8E54kbhANiaxeyQqh/Z69sM3wG9T1CQJH+T/g=;
        b=P0bUL1LgoLpuaCQgXMzCbFjzoAvNfmYmFD0P3UEYJ7qC98SI5vLufrJYF48coWWcnz
         IA5ab+95CYXV+LCGX2lzp0JVmUUaczS0C3punCCIy24tpUyMBlVfEBKZ0PwKS+9T0YM9
         83Q4hMY8eH9e493s77S6XCBOK589eyIYZkA9R0UlJAjqlDl1virp+6gyZNPt3E8hNu8I
         AK6ZaB8gQKNCl6wBrX+3to3OK5zYKBMWwHcmmYAMuE6LblPQjX8AkNUEYujqgrmAIKSk
         Nwqz1O3tptpEcmFXOMv5NsOYKUg1w633OUJsWwrD9v8kYbnt6j9kTpfL+7He9jKkKBx9
         8A4A==
X-Gm-Message-State: APjAAAU72g9qMf6tAvrPfMSmOfEV9gnziU6wzsc2feUrGvy5O/XuEwiK
        +TOFD7ESBCHFeyNmAKlf68VCyGeFEQc=
X-Google-Smtp-Source: APXvYqxlCtyB86Ooqiyzts60VCTpGoJB+aPumZ9gFPM8JdSAmdddh+dyZpWV3awZaSuGJYoBKXgwjg==
X-Received: by 2002:a63:ed01:: with SMTP id d1mr29060024pgi.95.1582184880930;
        Wed, 19 Feb 2020 23:48:00 -0800 (PST)
Received: from nitin-ThinkPad-X1-Yoga-4th.lenovo.com ([120.138.48.130])
        by smtp.gmail.com with ESMTPSA id fz21sm2004889pjb.15.2020.02.19.23.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:48:00 -0800 (PST)
From:   Nitin Joshi <nitjoshi@gmail.com>
X-Google-Original-From: Nitin Joshi <njoshi1@lenovo.com>
To:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, mpearson@lenovo.com,
        linux-kernel@vger.kernel.org, Nitin Joshi <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>
Subject: [PATCH] thinkpad_acpi: Add sysfs entry for lcdshadow feature
Date:   Thu, 20 Feb 2020 16:46:37 +0900
Message-Id: <20200220074637.7578-1-njoshi1@lenovo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This feature is supported on some Thinkpad products like T490s, Thinkpad
  X1 yoga 4th Gen etc . The lcdshadow feature can be enabled and disabled
  when user press "Fn" + "D" key. Currently, no user feedback is given for
  this action. Adding as sysfs entry allows userspace to show an On Screen
  Display whenever the setting changes.

  Summary of changes is mentioned below :

 - Added TP_HKEY_EV_LCDSHADOW_CHANGED for consistency inside the driver
 - Added unmapped LCDSHADOW to keymap
 - Added lcdshadow_get function to read value using ACPI
 - Added lcdshadow_refresh function to re-read value and send notification
 - Added sysfs group creation to tpaci_lcdshadow_init
 - Added lcdshadow_exit to remove sysfs group again
 - Implemented lcdshadow_enable_show/lcdshadow_enable_store
 - Added handler to tpacpi_driver_event to update refresh lcdshadow
 - Explicitly call tpacpi_driver_event for extended keyset

 Patch is tested on kernel 5.5 on Thinkpad X1 Yoga 4th Gen.

Co-developed-by: Benjamin Berg <bberg@redhat.com>
Signed-off-by: Benjamin Berg <bberg@redhat.com>
Reviewed-by: Mark Pearson <mpearson@lenovo.com>
Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 117 +++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index da794dcfdd92..bd137cc7baee 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -155,6 +155,7 @@ enum tpacpi_hkey_event_t {
 	TP_HKEY_EV_VOL_UP		= 0x1015, /* Volume up or unmute */
 	TP_HKEY_EV_VOL_DOWN		= 0x1016, /* Volume down or unmute */
 	TP_HKEY_EV_VOL_MUTE		= 0x1017, /* Mixer output mute */
+	TP_HKEY_EV_LCDSHADOW_CHANGED	= 0x130f, /* Eprivacy status changed */
 
 	/* Reasons for waking up from S3/S4 */
 	TP_HKEY_EV_WKUP_S3_UNDOCK	= 0x2304, /* undock requested, S3 */
@@ -1925,6 +1926,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
 
 	/* Lenovo extended keymap, starting at 0x1300 */
 	TP_ACPI_HOTKEYSCAN_EXTENDED_START,
+	TP_ACPI_HOTKEYSCAN_LCDSHADOW = 67,
 	/* first new observed key (star, favorites) is 0x1311 */
 	TP_ACPI_HOTKEYSCAN_STAR = 69,
 	TP_ACPI_HOTKEYSCAN_CLIPPING_TOOL2,
@@ -3342,7 +3344,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-		KEY_UNKNOWN, KEY_UNKNOWN
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 
 		},
 
@@ -3444,7 +3446,8 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
-		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
+		KEY_RESERVED,         /* LCD Shadow/ePrivacy */
 		KEY_UNKNOWN,
 
 		KEY_BOOKMARKS,       /* Favorite app, 0x311 */
@@ -3921,6 +3924,7 @@ static bool hotkey_notify_hotkey(const u32 hkey,
 		scancode -= (0x300 - TP_ACPI_HOTKEYSCAN_EXTENDED_START);
 		if (scancode >= TP_ACPI_HOTKEYSCAN_EXTENDED_START &&
 		    scancode < TPACPI_HOTKEY_MAP_LEN) {
+			tpacpi_driver_event(hkey);
 			tpacpi_input_send_key(scancode);
 			return true;
 		}
@@ -9717,6 +9721,12 @@ static struct ibm_struct battery_driver_data = {
 
 static int lcdshadow_state;
 
+static void lcdshadow_notify_change(void)
+{
+	sysfs_notify(&tpacpi_pdev->dev.kobj, NULL,
+		     "lcdshadow_enable");
+}
+
 static int lcdshadow_on_off(bool state)
 {
 	acpi_handle set_shadow_handle;
@@ -9731,6 +9741,7 @@ static int lcdshadow_on_off(bool state)
 		return -EIO;
 
 	lcdshadow_state = state;
+	lcdshadow_notify_change();
 	return 0;
 }
 
@@ -9743,27 +9754,90 @@ static int lcdshadow_set(bool on)
 	return lcdshadow_on_off(on);
 }
 
-static int tpacpi_lcdshadow_init(struct ibm_init_struct *iibm)
+static int lcdshadow_get(void)
 {
 	acpi_handle get_shadow_handle;
 	int output;
 
-	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "GSSS", &get_shadow_handle))) {
-		lcdshadow_state = -ENODEV;
-		return 0;
-	}
+	if (ACPI_FAILURE(acpi_get_handle(hkey_handle, "GSSS",
+					&get_shadow_handle)))
+		return -ENODEV;
 
-	if (!acpi_evalf(get_shadow_handle, &output, NULL, "dd", 0)) {
-		lcdshadow_state = -EIO;
+	if (!acpi_evalf(get_shadow_handle, &output, NULL, "dd", 0))
 		return -EIO;
+
+	if (!(output & 0x10000))
+		return -ENODEV;
+
+	return output & 0x1;
+}
+
+static void lcdshadow_refresh(void)
+{
+	int new_state;
+
+	new_state = lcdshadow_get();
+
+	if (lcdshadow_state != new_state) {
+		lcdshadow_state = new_state;
+		lcdshadow_notify_change();
 	}
-	if (!(output & 0x10000)) {
-		lcdshadow_state = -ENODEV;
-		return 0;
-	}
-	lcdshadow_state = output & 0x1;
+}
 
-	return 0;
+
+/* sysfs lcdshadow entry */
+static ssize_t lcdshadow_enable_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	if (lcdshadow_state < 0)
+		return lcdshadow_state;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", lcdshadow_state);
+}
+
+static ssize_t lcdshadow_enable_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	unsigned long t;
+	int res;
+
+	if (parse_strtoul(buf, 1, &t))
+		return -EINVAL;
+
+	tpacpi_disclose_usertask(attr->attr.name, "set to %ld\n", t);
+
+	res = lcdshadow_set(!!t);
+
+	return (res < 0) ? res : count;
+}
+
+static DEVICE_ATTR_RW(lcdshadow_enable);
+
+static struct attribute *lcdshadow_attributes[] = {
+	&dev_attr_lcdshadow_enable.attr,
+	NULL
+};
+
+static const struct attribute_group lcdshadow_attr_group = {
+	.attrs = lcdshadow_attributes,
+};
+
+
+static int tpacpi_lcdshadow_init(struct ibm_init_struct *iibm)
+{
+	int res;
+
+	lcdshadow_state = lcdshadow_get();
+
+	if (lcdshadow_state < 0 && lcdshadow_state != -ENODEV)
+		return lcdshadow_state;
+
+	res = sysfs_create_group(&tpacpi_pdev->dev.kobj,
+				  &lcdshadow_attr_group);
+
+	return res;
 }
 
 static void lcdshadow_resume(void)
@@ -9805,11 +9879,18 @@ static int lcdshadow_write(char *buf)
 	return lcdshadow_set(state);
 }
 
+static void lcdshadow_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			   &lcdshadow_attr_group);
+}
+
 static struct ibm_struct lcdshadow_driver_data = {
 	.name = "lcdshadow",
 	.resume = lcdshadow_resume,
 	.read = lcdshadow_read,
 	.write = lcdshadow_write,
+	.exit = lcdshadow_exit,
 };
 
 /****************************************************************************
@@ -9859,6 +9940,12 @@ static void tpacpi_driver_event(const unsigned int hkey_event)
 
 		mutex_unlock(&kbdlight_mutex);
 	}
+	if (lcdshadow_state >= 0) {
+		switch (hkey_event) {
+		case TP_HKEY_EV_LCDSHADOW_CHANGED:
+			lcdshadow_refresh();
+		}
+	}
 }
 
 static void hotkey_driver_event(const unsigned int scancode)
-- 
2.17.1

