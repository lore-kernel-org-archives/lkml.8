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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D439C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B7720720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA38+m0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgHUSRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHUSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D21C061574;
        Fri, 21 Aug 2020 11:16:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so571212pjv.0;
        Fri, 21 Aug 2020 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ie1DNxnbAGFQ8kcBJszfbH4xa37Nyh4u1vGt+9RF3E=;
        b=uA38+m0ZkgscbnshlSSh47kxQeeTcOHjewS3D+tSoGPN9aLkONxTYPYslI6qQhnC37
         f0j8NaQ9nnCtxEqt+7A5RRXvf8U21JoxsJq4J4RSSsHp29uaEo5pWCKrTzecPkK9Mz9q
         e5v6b3toPio3w49+ABYYfskiOEQZXwdnyeHWh76FARNZRh8RFvOug4b4zZ/QNBohfPQW
         VInXoui7QkQecY3tnr0c75KLhNyLWGfsDisNePeNWF8Y/+ilQYY88PkcrOrQ8cxznJVy
         mzAhAEpANlrs9oReq5QWeCXc9omIvSN2tKSjKjaB51UlHyv9Uv+7A9SuSM5boTIe0obb
         SUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ie1DNxnbAGFQ8kcBJszfbH4xa37Nyh4u1vGt+9RF3E=;
        b=YdYlHeKJFa5Bh5LJNkNysiwzmO0CQ5+YBFjwD2kzvxrSIbLtnKKF9kXq83YxY+dow7
         pKOjmObeN4xJm1Otcm0TahbMqExgCZonrPuCrdbe2NCVr1p37Lfx5hcj9tiCce2fqgbQ
         WimSRCBrPY2+6/Mj+cXjg9asE9y7uaOLtw15XPkEQm7W3BNO6geLWZBzTLgH/QsKoBKL
         eT6IFDU487/1cucx9o9fGos0j2noamrO7WXt+4YmV17xjWllBOBGOtdO5oi6Efxs/asW
         K7U4s54o8uh3dagQsNdBP+i+qmZbVP5D+mshBaTv0laRMJQnCN88yiHf0bFZYlZ53Sww
         CeOw==
X-Gm-Message-State: AOAM531cF63B65Jq3lTfIrxpkBi7zGPEpmJhkg1R/lc2aUoapAJaGTLT
        HyGJo45mHU/Wu37CvjwjjEJIaKiQn6FN8g==
X-Google-Smtp-Source: ABdhPJxc4EtLJXq23IAhcxz/zGDYENJ1uMJv5IB2Z1W70WPHhned/1MUfh9aPcXs0qFn1cwEW10aYQ==
X-Received: by 2002:a17:90a:f286:: with SMTP id fs6mr3399341pjb.221.1598033800793;
        Fri, 21 Aug 2020 11:16:40 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:40 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 6/9] add write support to mute
Date:   Sat, 22 Aug 2020 02:14:30 +0800
Message-Id: <20200821181433.17653-7-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add write support to the mute platform device


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index c77292588a8a..3b0294ee9d3e 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			add write support to mute
  *			fix sticky_key init bug
  *			fix naming of platform files for consistency with other
  *			modules
@@ -220,6 +221,7 @@ struct pcc_acpi {
 	acpi_handle		handle;
 	unsigned long		num_sifr;
 	int			sticky_key;
+	int			mute;
 	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
@@ -483,6 +485,24 @@ static ssize_t mute_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_MUTE]);
 }
 
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
 static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -533,7 +553,7 @@ static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(numbatt);
 static DEVICE_ATTR_RO(lcdtype);
-static DEVICE_ATTR_RO(mute);
+static DEVICE_ATTR_RW(mute);
 static DEVICE_ATTR_RW(sticky_key);
 static DEVICE_ATTR_RW(cdpower);
 
@@ -690,6 +710,7 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
+	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
 
 	return 0;
@@ -760,6 +781,8 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
 	pcc->sticky_key = 0;
 
+	pcc->mute = pcc->sinf[SINF_MUTE];
+
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
 	if (result)
-- 
2.17.5

