Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23496C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DA020771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xYaAzoSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgDQRBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:01:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52832 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgDQRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587142846; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jnFrNHMJwYTRfGU+bxklpH8fY874eOvwZEWt6NCZZM=;
        b=xYaAzoSuObd/ydytGqBUBmjqrbvJAXHDUZvE8cA7wGGfTu3m82DOx4XdnQ3jfS8v54wuj8
        GGhtJpSwyJWSVo3nbSwy0MBQM2Fj9FJgxPqmduDc7GO3tSZsT4PFyA/5cw/C+okjws+xom
        bMnrpv6IkoNPpqO1e9CC4YoxFe3Xp8g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 3/5] remoteproc: Add support for runtime PM
Date:   Fri, 17 Apr 2020 19:00:38 +0200
Message-Id: <20200417170040.174319-3-paul@crapouillou.net>
In-Reply-To: <20200417170040.174319-1-paul@crapouillou.net>
References: <20200417170040.174319-1-paul@crapouillou.net>
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

 drivers/remoteproc/remoteproc_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a7f96bc98406..d391b054efd8 100644
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
@@ -1384,6 +1385,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 
 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
 
+	pm_runtime_get_sync(dev);
+
 	/*
 	 * if enabling an IOMMU isn't relevant for this rproc, this is
 	 * just a nop
@@ -1391,7 +1394,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	ret = rproc_enable_iommu(rproc);
 	if (ret) {
 		dev_err(dev, "can't enable iommu: %d\n", ret);
-		return ret;
+		goto put_pm_runtime;
 	}
 
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
@@ -1435,6 +1438,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	rproc->table_ptr = NULL;
 disable_iommu:
 	rproc_disable_iommu(rproc);
+put_pm_runtime:
+	pm_runtime_put(dev);
 	return ret;
 }
 
@@ -1840,6 +1845,8 @@ void rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	pm_runtime_put(dev);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
@@ -2118,6 +2125,9 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	rproc->state = RPROC_OFFLINE;
 
+	pm_runtime_no_callbacks(&rproc->dev);
+	pm_runtime_enable(&rproc->dev);
+
 	return rproc;
 }
 EXPORT_SYMBOL(rproc_alloc);
@@ -2133,6 +2143,7 @@ EXPORT_SYMBOL(rproc_alloc);
  */
 void rproc_free(struct rproc *rproc)
 {
+	pm_runtime_disable(&rproc->dev);
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_free);
-- 
2.25.1

