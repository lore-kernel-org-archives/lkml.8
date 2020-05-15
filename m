Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B382065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rsKsZZ1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgEOKoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:44:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41614 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589539427; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2enx25OHMxJRV8d0e92z5OcDw0AoyF4T4mup2oaf0E=;
        b=rsKsZZ1lH5vNaoK7mhO8SCgf1PLm3/AetvD5wi+Q0AH+XQTImAI1guiykBhgWzQ+d6tmsK
        mUoJHtV5kCv/IE1aNksNJDDXrIaLq7ReBSS2IY82EmPu74uayashNMbvJ1s2WJGp3eeaF9
        FRVdMv4XLh2L6YV59lnhAMouNSE/NEQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 3/5] remoteproc: Add support for runtime PM
Date:   Fri, 15 May 2020 12:43:38 +0200
Message-Id: <20200515104340.10473-3-paul@crapouillou.net>
In-Reply-To: <20200515104340.10473-1-paul@crapouillou.net>
References: <20200515104340.10473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pm_runtime_get_sync() before the firmware is loaded, and
pm_runtime_put() after the remote processor has been stopped.

Even though the remoteproc device has no PM callbacks, this allows the
parent device's PM callbacks to be properly called.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2-v4: No change
    v5: Move calls to prepare/unprepare to rproc_fw_boot/rproc_shutdown
    v6: Instead of prepare/unprepare callbacks, use PM runtime callbacks
    v7: Check return value of pm_runtime_get_sync()

 drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a7f96bc98406..e33d1ef27981 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -29,6 +29,7 @@
 #include <linux/devcoredump.h>
 #include <linux/rculist.h>
 #include <linux/remoteproc.h>
+#include <linux/pm_runtime.h>
 #include <linux/iommu.h>
 #include <linux/idr.h>
 #include <linux/elf.h>
@@ -1382,6 +1383,12 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
+		return ret;
+	}
+
 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
 
 	/*
@@ -1391,7 +1398,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	ret = rproc_enable_iommu(rproc);
 	if (ret) {
 		dev_err(dev, "can't enable iommu: %d\n", ret);
-		return ret;
+		goto put_pm_runtime;
 	}
 
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
@@ -1435,6 +1442,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	rproc->table_ptr = NULL;
 disable_iommu:
 	rproc_disable_iommu(rproc);
+put_pm_runtime:
+	pm_runtime_put(dev);
 	return ret;
 }
 
@@ -1840,6 +1849,8 @@ void rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	pm_runtime_put(dev);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
@@ -2118,6 +2129,9 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	rproc->state = RPROC_OFFLINE;
 
+	pm_runtime_no_callbacks(&rproc->dev);
+	pm_runtime_enable(&rproc->dev);
+
 	return rproc;
 }
 EXPORT_SYMBOL(rproc_alloc);
@@ -2133,6 +2147,7 @@ EXPORT_SYMBOL(rproc_alloc);
  */
 void rproc_free(struct rproc *rproc)
 {
+	pm_runtime_disable(&rproc->dev);
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_free);
-- 
2.26.2

