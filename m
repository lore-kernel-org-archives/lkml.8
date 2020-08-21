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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA47520738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUDQUij0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHUSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgHUSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF46C061575;
        Fri, 21 Aug 2020 11:16:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so1456922pfw.9;
        Fri, 21 Aug 2020 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkHJdE2VcmpLQqH+RtK+9/dxv/7LUSL6cyAWHiVjmy8=;
        b=gUDQUij0oT+kBmYLm+WjUvjHrt8SwisqPBedrbisGwI6NRWFlayLlny6QMwPnqWZno
         LGjWmdJAMhsUS9i8DXBNhATlch3BdOH5t9hlKlZE5iGaVUpVyJm2ci34AORjJ+Waujue
         3HgCnmgj1Bw65CjPsh11GApzvNpm2FRduwV/rg7gw+cNezs78EnnuSn9zLLpfwODKcbi
         oZ7wfnJ6Xz68/mu5Y1OI3r6tVUiPzHXP6mkCYCNkZ0m9hupKUTAA/jTt2ovXo9cLkl1f
         fEK2zO+kMNHy9KketzyQj7lpDDNQZlpqpt8cIwKqOvMHKnVjQS1j2I/qkGSeE037SG87
         89FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkHJdE2VcmpLQqH+RtK+9/dxv/7LUSL6cyAWHiVjmy8=;
        b=HtNq1uthX0RJBkxvmSF+bex4hyb/oEN3J7UW2FFZZ7tL4GrgAim4as7vMNK/SJvKTj
         kpPUcvXuFmUd7yJphWUPcD3c6Nrp2ez/N/gLLi71S5XRIOALCzzMy7DIFHwy0UcOn8WQ
         2S6jkPaNvYfJFVw8mKxLw/867UL5wBpy23MTcfCvgFQ+R7aDIlt0dSano4fxl7zQjfr7
         W01TZ1ePmW4Kc0yb8gpIvZAtYtSn8oTcoMIu2qpQAz4hsS3GyQrkzwtKdtPSbn+mLM6s
         E4zbksEPQOTNUdBb9VfIv6MBWFXJs/PZ6gOAbolwtpCUPf3Hgl4FiM2i+WSDAKcI1qpU
         AHYw==
X-Gm-Message-State: AOAM532k+isaLXz1WXxZLZHR5idmNq2ePzGpuQlEh/WFR1g5wlo2PW/R
        9tdMfd/kQu4z8Qf++zvUKlEgklR/KupcYg==
X-Google-Smtp-Source: ABdhPJx8kp6S2r2hKp3qpHkxmVoYcvylACTRB6ylATOqGJsn1L1lB7SBgLt17XduMRNSNleWg/wFDQ==
X-Received: by 2002:a62:fcc6:: with SMTP id e189mr3387551pfh.25.1598033806694;
        Fri, 21 Aug 2020 11:16:46 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:46 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 9/9] add platform devices for firmware brightness registers
Date:   Sat, 22 Aug 2020 02:14:33 +0800
Message-Id: <20200821181433.17653-10-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panasonic laptops (at least from CF-W4 onwards) have dedicated firmware
registers for saving ac/dc and current brightness. They are a bit confusing
so here's some explanations:

AC_MIN_BRIGHT, AC_MAX_BRIGHT, DC_MIN_BRIGHT, DC_MAX_BRIGHT:
Read-only. Values: 0x01 and 0x15 respectively.

AC_CUR_BRIGHT, DC_CUR_BRIGHT:
Read-Write. 0x00-0xFF. Store user-defined AC/DC brightness. However, they do
not represent current brightness so they should be named AC_BRIGHT and
DC_BRIGHT instead.

CUR_BRIGHT (present since CF-W4):
Read-Write. 0x00-0xFF. It sets the current brightness. It won't update itself
if brightness is changed via other means, e.g. acpi_video0.

Another CUR_BRIGHT (added since CF-W5):
Read-Write. 0x01-0x15. Its value always synchronizes with current brightness.
Not implemented in this version.

Currently the backlight API interacts with AC_CUR_BRIGHT (probably because
it's the only bl register available in earlier models?). This patch adds
platform devices for AC_CUR_BRIGHT, DC_CUR_BRIGHT and CUR_BRIGHT.

It also fixes the error of https://lkml.org/lkml/2020/8/19/1264.


PS: I think the backlight API should interact with CUR_BRIGHT instead of
AC_CUR_BRIGHT. But it involves complications like mapping between 0x01-0x15
or 0x00-0x14 (the backlight API) and 0x00-0xFF (CUR_BRIGHT). I'll leave the
discussion for a later version.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 109 ++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 6355d60dc3eb..6388c3c705a6 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *		-v0.98	add platform devices for firmware brightness registers
  *			add support for battery charging threshold (eco mode)
  *			resolve hotkey double trigger
  *			add write support to mute
@@ -132,6 +133,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/platform_device.h>
 
+
 MODULE_AUTHOR("Hiroshi Miura <miura@da-cha.org>");
 MODULE_AUTHOR("David Bronaugh <dbronaugh@linuxboxen.org>");
 MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
@@ -173,6 +175,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 		 SINF_MUTE,
 		 SINF_RESERVED,
 		 SINF_ECO_MODE = 0x0A,
+		 SINF_CUR_BRIGHT = 0x0D,
 		 SINF_STICKY_KEY = 0x80,
 	};
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
@@ -228,6 +231,9 @@ struct pcc_acpi {
 	int			sticky_key;
 	int			eco_mode;
 	int			mute;
+	int			ac_brightness;
+	int			dc_brightness;
+	int			current_brightness;
 	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
@@ -610,6 +616,97 @@ static ssize_t eco_mode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t ac_brightness_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
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
+				   const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val >= 0 && val <= 255) {
+		acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, val);
+		pcc->ac_brightness = val;
+	}
+
+	return count;
+}
+
+static ssize_t dc_brightness_show(struct device *dev, struct device_attribute *attr,
+				  char *buf)
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
+				   const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+	if (val >= 0 && val <= 255) {
+		acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, val);
+		pcc->dc_brightness = val;
+	}
+
+	return count;
+}
+
+static ssize_t current_brightness_show(struct device *dev, struct device_attribute *attr,
+				       char *buf)
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
+					const char *buf, size_t count)
+{
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+	int err, val;
+
+	err = kstrtoint(buf, 0, &val);
+	if (err)
+		return err;
+
+	if (val >= 0 && val <= 255) {
+		err = acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, val);
+		pcc->current_brightness = val;
+	}
+
+	return count;
+}
+
 static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -633,6 +730,9 @@ static DEVICE_ATTR_RO(lcdtype);
 static DEVICE_ATTR_RW(mute);
 static DEVICE_ATTR_RW(sticky_key);
 static DEVICE_ATTR_RW(eco_mode);
+static DEVICE_ATTR_RW(ac_brightness);
+static DEVICE_ATTR_RW(dc_brightness);
+static DEVICE_ATTR_RW(current_brightness);
 static DEVICE_ATTR_RW(cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
@@ -641,6 +741,9 @@ static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_mute.attr,
 	&dev_attr_sticky_key.attr,
 	&dev_attr_eco_mode.attr,
+	&dev_attr_ac_brightness.attr,
+	&dev_attr_dc_brightness.attr,
+	&dev_attr_current_brightness.attr,
 	&dev_attr_cdpower.attr,
 	NULL,
 };
@@ -794,6 +897,9 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
 	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
+	acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, pcc->ac_brightness);
+	acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, pcc->dc_brightness);
+	acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
 
 	return 0;
 }
@@ -865,6 +971,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
 	pcc->mute = pcc->sinf[SINF_MUTE];
+	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
+	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
+	result = pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
-- 
2.17.5

