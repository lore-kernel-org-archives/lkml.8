Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F5C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B0A20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgBbs3ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEKOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730473AbgEKOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:50:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99FEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so5428219wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfF2YPGcuLc+yjRcJmn6zAGknAHXsr6VgBJi89nudKM=;
        b=HgBbs3ZEFF+fOdhZvBTDR02hPSloI6p3r2g1nWVkO+gEvtNg16AwNDoLJFCRiQt+qW
         x5NJTrfb4RjRacLRjT13BvaFyjpqGtQqqrDXatssdWOivslVDi7BDOTSp8AfZLQmazno
         FbLxSDkDV7FQbQE9pQAOqMU3PWzNrN8q9PpIDeF1kNjNIEzCMUwu27MYu1ZtSwdozDY8
         dStGOzrZ7RUp3TpnKfVcEnIVJpdlNJyBiR8z5UODUfYXa/xIOEqs/WdfVUjCQMXGlz9+
         vvrghBwiIq1/AjP3e5FCd8DKuEPc0J+O/9FXT4nreP1C201LG8obT+IE8hBcc5Yu8WgH
         nIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfF2YPGcuLc+yjRcJmn6zAGknAHXsr6VgBJi89nudKM=;
        b=UluKCTFfhJUC5oKpog1Pbhd8ImX0373kONxSFcRv5uWgni8H7l9OpoChfR39CcvBfL
         SE2T1tAcINqrLJw4GETNBno9bB3EWe7COST/5XN4IigIb/YGdk3aFLwAu/ZMrdcpaSou
         BgBG3ppc3kLhxcu6I7/ugwbSMAebWnwN5W71rPNAaTssh0b9wTxAq7sBg+QPh3MfzM6H
         u7Mtt/LJzh/sSuXguIFrpkcOaqU56tLNznoiLn9QJSju3fHUhpcAa1Liz1xr+JNxNzu5
         q7BsUcd4frkYWF7cBx3cAXxAthmfsI3KlIFLt7j9tfIxUEcdD/OSnM1B0Ln5gfTefhkE
         M/DQ==
X-Gm-Message-State: AGi0PuaNscNudoPrvR2e44kvRMNX3XYNi0EgRC/Zs01afWak+MAvf6Oy
        qv7RHAV2D/qt8qEK7/wR/XxvRg==
X-Google-Smtp-Source: APiQypKaoEFpXRcTrxQyK+EfuwHRmSOUjkeLfDz1d1d+0iw0YpHk0PSZk7rDFopcBc5F44+6lHdFog==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr14356903wrt.202.1589208657511;
        Mon, 11 May 2020 07:50:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 33sm18512983wrk.61.2020.05.11.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:50:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Auchter <michael.auchter@ni.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] nvmem: ensure sysfs writes handle write-protect pin
Date:   Mon, 11 May 2020 15:50:41 +0100
Message-Id: <20200511145042.31223-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
References: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Auchter <michael.auchter@ni.com>

Commit 2a127da461a9 ("nvmem: add support for the write-protect pin")
added support for handling write-protect pins to the nvmem core, and
Commit 1c89074bf850 ("eeprom: at24: remove the write-protect pin support")
retrofitted the at24 driver to use this support.

These changes broke write() on the nvmem sysfs attribute for eeproms
which utilize a write-protect pin, as the write callback invokes the
nvmem device's reg_write callback directly which no longer handles
changing the state of the write-protect pin.

Change the read and write callbacks for the sysfs attribute to invoke
nvmme_reg_read/nvmem_reg_write helpers which handle this, rather than
calling reg_read/reg_write directly.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Signed-off-by: Michael Auchter <michael.auchter@ni.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad6e55a75bdb..927eb5f6003f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -66,6 +66,30 @@ static LIST_HEAD(nvmem_lookup_list);
 
 static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
 
+static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
+			  void *val, size_t bytes)
+{
+	if (nvmem->reg_read)
+		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
+
+	return -EINVAL;
+}
+
+static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	int ret;
+
+	if (nvmem->reg_write) {
+		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
+		ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
+		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
 #ifdef CONFIG_NVMEM_SYSFS
 static const char * const nvmem_type_str[] = {
 	[NVMEM_TYPE_UNKNOWN] = "Unknown",
@@ -122,7 +146,7 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_read)
 		return -EPERM;
 
-	rc = nvmem->reg_read(nvmem->priv, pos, buf, count);
+	rc = nvmem_reg_read(nvmem, pos, buf, count);
 
 	if (rc)
 		return rc;
@@ -159,7 +183,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 	if (!nvmem->reg_write)
 		return -EPERM;
 
-	rc = nvmem->reg_write(nvmem->priv, pos, buf, count);
+	rc = nvmem_reg_write(nvmem, pos, buf, count);
 
 	if (rc)
 		return rc;
@@ -287,30 +311,6 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
 
 #endif /* CONFIG_NVMEM_SYSFS */
 
-static int nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
-			  void *val, size_t bytes)
-{
-	if (nvmem->reg_read)
-		return nvmem->reg_read(nvmem->priv, offset, val, bytes);
-
-	return -EINVAL;
-}
-
-static int nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
-			   void *val, size_t bytes)
-{
-	int ret;
-
-	if (nvmem->reg_write) {
-		gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
-		ret = nvmem->reg_write(nvmem->priv, offset, val, bytes);
-		gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
-		return ret;
-	}
-
-	return -EINVAL;
-}
-
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
-- 
2.21.0

