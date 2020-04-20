Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8359C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7625920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FK5ufNXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgDTXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727787AbgDTXQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:16:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15320C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ng8so566872pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpsOJZL+ZU4RTGqMsf0NvSnMAMglq/aHlmJWyZVItPk=;
        b=FK5ufNXVpujVoE0t/Y/YeaigrOO4bjzfV53ejd/HM0R8r256r6kgoz3efJ3iulaXFe
         h12IwO+wVWpj2nTXVT0Z/Fr8Ia2SsPD9iffjIVsMOmlpPiWb93gEVminTjLby3cBV+vR
         hiUZnzk+/Wj/aTH8HYyrFDcbwo2lO7F4k4QH/a+SeazDRCH6G4vgsqzN++LfXqRn1AWN
         XpLqL/OVRIidsO7fVO5XCyXVvZysmiNrnl/D1AWIYpAd95ftDTnu2vOTsg5Unzi98aNY
         GFq80muzU/AW8pnqoC/sDtWgUMWem0TPHHfcbNVRbe0XkMiZG8R2KsQcXNHReODgGCtU
         g0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpsOJZL+ZU4RTGqMsf0NvSnMAMglq/aHlmJWyZVItPk=;
        b=hcE3OCoxxg6BXhzj5i7r6o6L4lecw7i+X8c/+nBJxQA8iRJLV7c824lUsNCdMGtOif
         IzB0ErG50AB5rGwkvsApmwBRU5VE7txZa4LW6KhbdN1ULIZYsF+LZG+3iNudtj83yCxh
         o9/0d6JA2hUeh8pNhRasyUIcH7KpoCLzuhRHybjLXEJ0TkAqFzaYVBaKXzFJqIAB8gCd
         dgA5N/duk3Ge20NbOfrHOJFjVNNRVGKYw3ghOCQaFh5j3ViUGl0gZ1Qt/e5TgMa5majY
         3s8axtvLz5INN9pLzgu07Tfvmzsl/dNIWaf8k34acDSmCn/Se39BXKMPHKWwr1hy7tB8
         wLyw==
X-Gm-Message-State: AGi0PuZMSSau7JReX5pkWefHcXt9IVfY2NWVd0bPFejVY2GmAHfgNeHv
        BXIjVmhvbFr2FdD98wFRi3Z97g==
X-Google-Smtp-Source: APiQypJdQApqSjhbDtcAZmALy8nxBP+m5Mq2RV1NphXt2SqGc3jSLBDsS/GWxBgJ99jQ4RpPdzal6g==
X-Received: by 2002:a17:90a:e7cf:: with SMTP id kb15mr2128820pjb.146.1587424567620;
        Mon, 20 Apr 2020 16:16:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l15sm435354pgk.59.2020.04.20.16.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:16:07 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     elder@linaro.org, s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] remoteproc: Get rid of tedious error path
Date:   Mon, 20 Apr 2020 17:16:01 -0600
Message-Id: <20200420231601.16781-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420231601.16781-1-mathieu.poirier@linaro.org>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of tedious error management by moving firmware and operation
allocation after calling device_initialize().  That way we take advantage
of the automatic call to rproc_type_release() to cleanup after ourselves
when put_device() is called.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 15318507aedb..6fca4e2c0dd7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2084,12 +2084,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc)
 		return NULL;
 
-	if (rproc_alloc_firmware(rproc, name, firmware))
-		goto free_rproc;
-
-	if (rproc_alloc_ops(rproc, ops))
-		goto free_firmware;
-
 	rproc->name = name;
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
@@ -2103,12 +2097,17 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	rproc->dev.driver_data = rproc;
 	idr_init(&rproc->notifyids);
 
+	if (rproc_alloc_firmware(rproc, name, firmware))
+		goto put_device;
+
+	if (rproc_alloc_ops(rproc, ops))
+		goto put_device;
+
 	/* Assign a unique device index and name */
 	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
 	if (rproc->index < 0) {
 		dev_err(dev, "ida_simple_get failed: %d\n", rproc->index);
-		put_device(&rproc->dev);
-		return NULL;
+		goto put_device;
 	}
 
 	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
@@ -2130,10 +2129,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 
 	return rproc;
 
-free_firmware:
-	kfree_const(rproc->firmware);
-free_rproc:
-	kfree(rproc);
+put_device:
+	put_device(&rproc->dev);
 	return NULL;
 }
 EXPORT_SYMBOL(rproc_alloc);
-- 
2.20.1

