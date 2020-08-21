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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56826C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3155920720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flkfq6LG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHUSQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHUSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FEEC061574;
        Fri, 21 Aug 2020 11:16:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so1170937pjb.4;
        Fri, 21 Aug 2020 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8hyRclC+HKYvxgCtKXwPHRBVmbPAJqIPR/vH5lUYTk=;
        b=flkfq6LG781RQcBi8FmPLs6PtQjf53j71d5qsIlSZDXmHkgLswlIrWtwEivmHkNGGS
         VMLUTTvLXnbr3hB8/hc7J1EWMuNZainCdHRL93sRoqSMe2pJRyg9PiB6cBErDmF5HhMw
         ZXAlPJH82sK7pYb5FF2PFGYu7ki2IhQ4ywt8J+cLt0dsKpLHvOgoMnebJal8i7nhIddZ
         965ZHorRXaVcO8EJtsjtr2OHYjJrFI8h5IhZHSKNz9cpqjuRyZ2C86VSAjBiHDq9m87v
         UEqQd6I9xvLIxhdiDT+iP8n7WucdCA+JkZapJ0xTS1DFB5MXNT2o009jmWDm7PLtxZST
         5RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8hyRclC+HKYvxgCtKXwPHRBVmbPAJqIPR/vH5lUYTk=;
        b=b9fMd9LbbIjwySEePQIsoe1r4GGCouvtBrmbSLlINxvT3q5axGpOTQsDZRFBgGXVNx
         LacT2e/7Rk2aF1PWGfN2C75yjZF08TzjKDdcRDxpUCUmBJcY9/ImHFGAoCgKQRf9zSaC
         5ncc1ahBKyPPcxFECdvuYtthQ4CXQBiaZD7Y96V1f4IERHEfA5brLzP1npeM/vBipfRV
         i591F+qCE/V4krUcJGCaOGtr7IdVY6rCP4FehBFyePJz96idEEemaasDZfBCaUzm73eG
         2nWS5XIC67v+AWCLtZGY3J6LIf9M7lwAOVSMiWGXILbHSL3uJNSKzX+V92En1rUBQwEJ
         iWBA==
X-Gm-Message-State: AOAM532G8rKbB6XPlISYaW2fjhwgRwM8LvDm/y/TUtYIUsYzWuXsusxE
        catO2R62TbkDaFzC/eougiTmrU9SZphKKA==
X-Google-Smtp-Source: ABdhPJwWYALigU71ohdgtDhoE8HYurRrYCmNoS2qcWpr33ejfqAt448ia9zKHlaPeczY60fsenIiwQ==
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr3213832plg.120.1598033795113;
        Fri, 21 Aug 2020 11:16:35 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:34 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 4/9] fix naming of platform files for consistency with other modules
Date:   Sat, 22 Aug 2020 02:14:28 +0800
Message-Id: <20200821181433.17653-5-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change platform device function names for consistency with other modules

Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 162b6c560af1..abf70e6e6578 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,8 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			fix naming of platform files for consistency with other
+ *			modules
  *			split MODULE_AUTHOR() by one author per macro call
  *			replace ACPI prints with pr_*() macros
  *		-v0.97	add support for cdpower hardware switch
@@ -444,7 +446,7 @@ static int set_optd_power_state(int new_state)
 
 /* sysfs user interface functions */
 
-static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
+static ssize_t numbatt_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -456,7 +458,7 @@ static ssize_t show_numbatt(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_NUM_BATTERIES]);
 }
 
-static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
+static ssize_t lcdtype_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -468,7 +470,7 @@ static ssize_t show_lcdtype(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_LCD_TYPE]);
 }
 
-static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
+static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -480,7 +482,7 @@ static ssize_t show_mute(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
 }
 
-static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
+static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -492,7 +494,7 @@ static ssize_t show_sticky(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_STICKY_KEY]);
 }
 
-static ssize_t set_sticky(struct device *dev, struct device_attribute *attr,
+static ssize_t sticky_key_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
@@ -526,10 +528,10 @@ static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(numbatt, S_IRUGO, show_numbatt, NULL);
-static DEVICE_ATTR(lcdtype, S_IRUGO, show_lcdtype, NULL);
-static DEVICE_ATTR(mute, S_IRUGO, show_mute, NULL);
-static DEVICE_ATTR(sticky_key, S_IRUGO | S_IWUSR, show_sticky, set_sticky);
+static DEVICE_ATTR_RO(numbatt);
+static DEVICE_ATTR_RO(lcdtype);
+static DEVICE_ATTR_RO(mute);
+static DEVICE_ATTR_RW(sticky_key);
 static DEVICE_ATTR_RW(cdpower);
 
 static struct attribute *pcc_sysfs_entries[] = {
-- 
2.17.5

