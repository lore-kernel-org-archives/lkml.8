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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BE421741
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPQFqb8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHUSQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgHUSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A32C061573;
        Fri, 21 Aug 2020 11:16:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so1167558pjr.0;
        Fri, 21 Aug 2020 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChipikirAeqxhzEp4RF3ufjdn+NYQXRsxZeDk2bboxU=;
        b=BPQFqb8HdI4vm/jmV78FOqUx+2b9o5SmkSRf3ybsvzNuBDTy3ZRIBnhff50MorbRaH
         lLHRmjFb4IOn9oNPlFnbICUF4M8B4DgKDtSqh4KPRrfCkEGfJOmnuIlTclPhG4330Rrk
         2krl1ThBL6uzMRVcHDZMd6mSN/zeEeM0p6tEw+eobBisKnOsskrjSJYVl5kKdmkIT2jV
         f+VwmfcYSLp4ChFc9v3QcknRBHwnwKMpIialPjnK2lylpAMFUCQAP/k03aQ2+sWJhuIr
         KU/9rZse8r8y1VgiEegg6TaNBleaur5VlIeerjvBmj4uWpo636AcEkkKLE/22alezAiI
         cAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChipikirAeqxhzEp4RF3ufjdn+NYQXRsxZeDk2bboxU=;
        b=AUzqd/29GnQOt1VvXbvb5dZ3vMnJG0uDvLJDIKRft/+c2N+yxypqMKwAggF4p3tf7K
         PtEtF+dvRAH0ledVgOgUdl+0L8ocPsxEm9F5DKh7zUrSypRpyZZXNeLTg+RTAyhdog4Y
         Kwlm2rbHa/LPb7E1VpTNdu+li0f9qWWweBQgFrjhpIDy5UVE++27iOXtoNBKWBK2QOVI
         9yQHg/zVTAD5ey37mvkTFIbKdiyPlRucz/8rPKgWI1mMP1I7GUUEZFV4pSvsEDn17noQ
         nlOENt6h1+KSPvh9kwMoKSsNX60kvh0qguego54eDnVjCmAqeqPnWzzcPNOT+lwaQ1GX
         Zcow==
X-Gm-Message-State: AOAM533CEt0cXf9pAJW7UDDdcx+SMiQeBhpIySwT3/oKj2mKOuRw5L3g
        rKFXJiN7F1P0UKbxhSeuavAex1YBtgP1zw==
X-Google-Smtp-Source: ABdhPJyghNNY2EpIrc0b1a/O1Gkx/mvQwHIRP9vmTOm3a9Slzq3+UMT9M4acTyfAj4vNVUOFNcc4Tw==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr3300766pls.116.1598033798863;
        Fri, 21 Aug 2020 11:16:38 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:38 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 5/9] fix sticky key init bug
Date:   Sat, 22 Aug 2020 02:14:29 +0800
Message-Id: <20200821181433.17653-6-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the sticky key on some models (e.g. CF-W5) do not reflect its
state. How to retrieve its state from firmware is unkown. The safest bet is to reset
it at module init and store its state in pcc struct.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index abf70e6e6578..c77292588a8a 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			fix sticky_key init bug
  *			fix naming of platform files for consistency with other
  *			modules
  *			split MODULE_AUTHOR() by one author per macro call
@@ -218,7 +219,7 @@ static const struct key_entry panasonic_keymap[] = {
 struct pcc_acpi {
 	acpi_handle		handle;
 	unsigned long		num_sifr;
-	int			sticky_mode;
+	int			sticky_key;
 	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
@@ -491,7 +492,7 @@ static ssize_t sticky_key_show(struct device *dev, struct device_attribute *attr
 	if (!acpi_pcc_retrieve_biosdata(pcc))
 		return -EIO;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sinf[SINF_STICKY_KEY]);
+	return snprintf(buf, PAGE_SIZE, "%u\n", pcc->sticky_key);
 }
 
 static ssize_t sticky_key_store(struct device *dev, struct device_attribute *attr,
@@ -499,12 +500,14 @@ static ssize_t sticky_key_store(struct device *dev, struct device_attribute *att
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
 	}
 
 	return count;
@@ -687,7 +690,9 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	return acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_mode);
+	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
+
+	return 0;
 }
 #endif
 
@@ -751,8 +756,9 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	/* read the initial brightness setting from the hardware */
 	pcc->backlight->props.brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
 
-	/* read the initial sticky key mode from the hardware */
-	pcc->sticky_mode = pcc->sinf[SINF_STICKY_KEY];
+	/* Reset initial sticky key mode since the hardware register state is not consistent */
+	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
+	pcc->sticky_key = 0;
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
-- 
2.17.5

