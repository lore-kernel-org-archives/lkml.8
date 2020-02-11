Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5488AC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE620848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LuPg/Ywc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgBKO0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:26:43 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44884 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbgBKO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581431191; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owSzTXcFUumlvCbrX+D8MqPMN4JcxxIBLcFb/OPdfLI=;
        b=LuPg/YwcH66qQIkbrJrDG5EHiYlkOueGrEPlvLwgJB0ilhhKRYRQqFVaqBiYfe9/Zvq9AD
        Ra0OmPldDW1mgDnTJ49+lw1vpkJ8Z4saWeEFr1WTgfWtRyBMaeeaOUcvDNCQ3nlk2cvak7
        SyFNAqUCZuXQ5fjbwnVF/QJ44ZVPly4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 3/5] remoteproc: Add prepare/unprepare callbacks
Date:   Tue, 11 Feb 2020 11:26:11 -0300
Message-Id: <20200211142614.13567-3-paul@crapouillou.net>
In-Reply-To: <20200211142614.13567-1-paul@crapouillou.net>
References: <20200211142614.13567-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .prepare() callback is called before the firmware is loaded to
memory. This is useful for instance in the case where some setup is
required for the memory to be accessible.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2-v4: No change
    v5: Move calls to prepare/unprepare to rproc_fw_boot/rproc_shutdown

 drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
 include/linux/remoteproc.h           |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fe5c7a2f9767..022b927e176b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1373,6 +1373,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 
 	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
 
+	if (rproc->ops->prepare) {
+		ret = rproc->ops->prepare(rproc);
+		if (ret) {
+			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * if enabling an IOMMU isn't relevant for this rproc, this is
 	 * just a nop
@@ -1380,7 +1388,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	ret = rproc_enable_iommu(rproc);
 	if (ret) {
 		dev_err(dev, "can't enable iommu: %d\n", ret);
-		return ret;
+		goto unprepare_rproc;
 	}
 
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
@@ -1424,6 +1432,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	rproc->table_ptr = NULL;
 disable_iommu:
 	rproc_disable_iommu(rproc);
+unprepare_rproc:
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
 	return ret;
 }
 
@@ -1823,6 +1834,9 @@ void rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 5f201f0c86c3..a6272d1ba384 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -355,6 +355,8 @@ enum rsc_handling_status {
 
 /**
  * struct rproc_ops - platform-specific device handlers
+ * @prepare:	prepare the device for power up (before the firmware is loaded)
+ * @unprepare:	unprepare the device after it is stopped
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
@@ -371,6 +373,8 @@ enum rsc_handling_status {
  * @get_boot_addr:	get boot address to entry point specified in firmware
  */
 struct rproc_ops {
+	int (*prepare)(struct rproc *rproc);
+	void (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-- 
2.25.0

