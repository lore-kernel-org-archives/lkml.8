Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAD3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7245920720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsF9o9xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgHUSRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgHUSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA1AC061574;
        Fri, 21 Aug 2020 11:16:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1249689plp.4;
        Fri, 21 Aug 2020 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rrXqn/Nnp8BSXqOYScOzQKkOfIWsG/Knwu9MHSScBA=;
        b=GsF9o9xfr8FDw/R6n6zOj7C09YaM+xalH233m8eLhoQo/p0qEjxHUrZu/cFUkoLL0I
         sV2TWHfeGGcGrgkR92y0aixRI+3drFp9AlUQVdeRJh13DxRyOQmA/8dvIw/Efk1DJueS
         XugcmqjFW0PVJCnX5bGbPvYjd1wchfHGBQ3Nc/IuZjqJt/LBi4B4CVz+vC7GmMM7hFGC
         vlFFXAJOp3QOJbmuO7QHjeIPCZxbwffmccG/JiuLd88zFpBEdwJ4l+rZ6BupcrY5xM9k
         XZ5aLiHuN4J6X3QLrIu5Tbc5Aj6Id91Gzss5/uSVhbNGIx/cPaiEue/8c1Ug/WDYVRfJ
         6YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rrXqn/Nnp8BSXqOYScOzQKkOfIWsG/Knwu9MHSScBA=;
        b=W815JMCRV3evffnNHm4gZedemL4q41Pv9tuaa47QFlfaR1cuomg7EpvRXsg3UfE/9L
         1X3lOx1JlcQHgj0vtQTccyQ4A4ZDD1EnqXYkGw0DLzYwGMRP2CqHW1LNpm7mdzK/iN1S
         bYofZdf/fGyhleNDKebBc4dKdOCs4Nl8Q8cSOsizxxTkXJfFQSJ1t//R6xexdKBkK9Lj
         oceKG/M+vQ08LM4cAyMYxX6o9p+cxGJLC+aKJ5qvvWDktUTcO6LpWpUyJYmn5H3P4bk6
         lyBIPAPGCJ428xH0o5l4ZljRB2K9nem/pl/ZVhQ0TIOZ70TI9u2kQpGKelXV8X+GYlaC
         dv5g==
X-Gm-Message-State: AOAM531/j7r4yfuQXcvfMoWxWXOrcV4Vo+DXYThg/f9ZKN4DX77Adm3a
        Dr8w6F2xNloO5CLHrGosZXPSl/iP0jYVAA==
X-Google-Smtp-Source: ABdhPJwMy89UFJig3sjuLjybMJDFx0WjXE+Iurqp24mjf988jstnnlEulvBdROYzD9qrgl+82eREEA==
X-Received: by 2002:a17:90b:4ac9:: with SMTP id mh9mr3399384pjb.40.1598033804689;
        Fri, 21 Aug 2020 11:16:44 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:44 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 8/9] add support for battery charging threshold (eco mode)
Date:   Sat, 22 Aug 2020 02:14:32 +0800
Message-Id: <20200821181433.17653-9-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add battery charging threshold (aka ECO mode) support.

NOTE: The state of ECO mode is persistent until the next POST cycle which reset
it to previous state.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 86 ++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 6779099a3ec9..6355d60dc3eb 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			add support for battery charging threshold (eco mode)
  *			resolve hotkey double trigger
  *			add write support to mute
  *			fix sticky_key init bug
@@ -147,7 +148,10 @@ MODULE_LICENSE("GPL");
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
@@ -156,7 +160,7 @@ MODULE_LICENSE("GPL");
 #define ACPI_PCC_INPUT_PHYS	"panasonic/hkey0"
 
 /* LCD_TYPEs: 0 = Normal, 1 = Semi-transparent
-   ENV_STATEs: Normal temp=0x01, High temp=0x81, N/A=0x00
+   ECO_MODEs: 0x03 = off, 0x83 = on
 */
 enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 		 SINF_LCD_TYPE,
@@ -168,7 +172,7 @@ enum SINF_BITS { SINF_NUM_BATTERIES = 0,
 		 SINF_DC_CUR_BRIGHT,
 		 SINF_MUTE,
 		 SINF_RESERVED,
-		 SINF_ENV_STATE,
+		 SINF_ECO_MODE = 0x0A,
 		 SINF_STICKY_KEY = 0x80,
 	};
 /* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
@@ -222,6 +226,7 @@ struct pcc_acpi {
 	acpi_handle		handle;
 	unsigned long		num_sifr;
 	int			sticky_key;
+	int			eco_mode;
 	int			mute;
 	u32			*sinf;
 	struct acpi_device	*device;
@@ -534,6 +539,77 @@ static ssize_t sticky_key_store(struct device *dev, struct device_attribute *att
 	return count;
 }
 
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
+	int err, state;
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
+		return count;
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
 static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -556,6 +632,7 @@ static DEVICE_ATTR_RO(numbatt);
 static DEVICE_ATTR_RO(lcdtype);
 static DEVICE_ATTR_RW(mute);
 static DEVICE_ATTR_RW(sticky_key);
+static DEVICE_ATTR_RW(eco_mode);
 static DEVICE_ATTR_RW(cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
@@ -563,6 +640,7 @@ static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_lcdtype.attr,
 	&dev_attr_mute.attr,
 	&dev_attr_sticky_key.attr,
+	&dev_attr_eco_mode.attr,
 	&dev_attr_cdpower.attr,
 	NULL,
 };
@@ -714,6 +792,7 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 		return -EINVAL;
 
 	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
+	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
 
 	return 0;
@@ -784,6 +863,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
 	pcc->sticky_key = 0;
 
+	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
 	pcc->mute = pcc->sinf[SINF_MUTE];
 
 	/* add sysfs attributes */
-- 
2.17.5

