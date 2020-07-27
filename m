Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDDC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A042083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595857148;
	bh=K+Hvt4TqrFnW+IvY4RgwiyQKoPSqYctqgba73myhUgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=otAdT8RC3r0Ipg4alalnjgbQ/7olpjFjzfNs3M41z1Ii3/rivKM5eEcLCHNP0cTEg
	 wG3X33H2fkUxrbHJJk+QqTFovROotmoEijtxwtsaqy/GpSQKsURqrnVTjhxnG+fjbi
	 tXnSsZRVF12LrwjQ4qD4PGDvHjqLShOcGFt7F0CQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgG0NjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgG0Niy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:54 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0AE2086A;
        Mon, 27 Jul 2020 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595857134;
        bh=K+Hvt4TqrFnW+IvY4RgwiyQKoPSqYctqgba73myhUgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwBpFoHwZw2PYdcYYok127rFZRsljWuwtHWcNBm7ExZrdGJVgUZW2ptjBA54L6i5Q
         2sWwvN22fh4K7doul17ivG2XSHY/YFusrZjUMq00hy2VgsXuPCE7zcQUpdCaYfJx84
         f//aDzQZ+qagMRiMNvIi5f5Kca8x2D6zKYKbxrQs=
Received: by pali.im (Postfix)
        id 58D67CB2; Mon, 27 Jul 2020 15:38:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: sdio: Extend sdio_config_attr macro and use it also for modalias
Date:   Mon, 27 Jul 2020 15:38:36 +0200
Message-Id: <20200727133837.19086-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
References: <20200727133837.19086-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplify code for generating sdio config attributes and allows easily
define new sdio attributes.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/core/sdio_bus.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 3cc928282af7..2384829c8fb2 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -28,29 +28,21 @@
 #define to_sdio_driver(d)	container_of(d, struct sdio_driver, drv)
 
 /* show configuration fields */
-#define sdio_config_attr(field, format_string)				\
+#define sdio_config_attr(field, format_string, args...)			\
 static ssize_t								\
 field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct sdio_func *func;						\
 									\
 	func = dev_to_sdio_func (dev);					\
-	return sprintf (buf, format_string, func->field);		\
+	return sprintf(buf, format_string, args);			\
 }									\
 static DEVICE_ATTR_RO(field)
 
-sdio_config_attr(class, "0x%02x\n");
-sdio_config_attr(vendor, "0x%04x\n");
-sdio_config_attr(device, "0x%04x\n");
-
-static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct sdio_func *func = dev_to_sdio_func (dev);
-
-	return sprintf(buf, "sdio:c%02Xv%04Xd%04X\n",
-			func->class, func->vendor, func->device);
-}
-static DEVICE_ATTR_RO(modalias);
+sdio_config_attr(class, "0x%02x\n", func->class);
+sdio_config_attr(vendor, "0x%04x\n", func->vendor);
+sdio_config_attr(device, "0x%04x\n", func->device);
+sdio_config_attr(modalias, "sdio:c%02Xv%04Xd%04X\n", func->class, func->vendor, func->device);
 
 static struct attribute *sdio_dev_attrs[] = {
 	&dev_attr_class.attr,
-- 
2.20.1

