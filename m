Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B57C4725E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448A1206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 04:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/KtkBuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEFEuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgEFEup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 00:50:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E7EC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 21:50:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so17507plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xeD4fhXXLKw695JxM+Psz6fMHOU1+fBrBm0clKJ80mY=;
        b=G/KtkBuKiEjsfoatkD/ZeVYejX0UZTvibW3Zcw5Jvdo/xcB7IV2KiYHlCfb18ZrWLE
         6Xgkg/e0KdUbtyAisRfZFduyr8HIfztgL+jjlYM0dRj/pc+w8q0JE0VAhseEiNgS1zUQ
         dYwl0G2JZKeEkaSPKv1oiCnESeKvobB/d/Z37Sa+FLMhhRawK30hhA96LeIE4n8CYFwX
         qwGg4DIvR6wgr0RV3CUqRC59idX5t6vO9wcdVW0NejyBxNQ6JMYRWtvh4J08l5qIFAmG
         1tM/BW6R/YSnCZXj5SUNXK6nRa1nHkxGxk5IAqB6zP//dLTfRAOk6Efo9TP8mTiaAxHp
         A8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xeD4fhXXLKw695JxM+Psz6fMHOU1+fBrBm0clKJ80mY=;
        b=Ts4iFrmNN00Gz82TKsuqY89IbKSLXp8py5kDt/UVNw7CYnyftnVdrbaZPs1HfTsyQF
         vFnROa7oiiXd459CrCmaT4CAXrjlLi2YuMEz0aWxDNsUR3PxPg8kHc0z+t+uyaoID5yC
         hUpl/sgJ0Vb+P6bP5MU/5W2xD9jx4bZPWs5JaffCota3ogCA6P/ThASVHCsrqdv1WkVs
         KqS7zV2YEkBz4hTZ8H9fM/oZ+yzbbG/06sfALGneDMIpED+f1s2CH3vb4yeAA3vLiTeD
         o+NQVLTYVcL0p5VM62EGNm2kTVAsGOph5vbY685xPEZuzOrz7g1V93uoLVDCZFaSjPNl
         1lZg==
X-Gm-Message-State: AGi0PubiAx7blFTZfxiax16c4n5NLUZo7SzAp8zmGUUiKE8yokOdfIFg
        aDQtl5QnJjaI+PfBNaYhr+He
X-Google-Smtp-Source: APiQypItLRlwJgfdazvZv/g+NPME6wtexg28p0c+2zudmwz7W9rjo94AVwGAnad/TY2AGuOXzAEJJQ==
X-Received: by 2002:a17:90a:23ad:: with SMTP id g42mr6809422pje.35.1588740643613;
        Tue, 05 May 2020 21:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e88:ac9a:a18c:3139:9aa9:bb73])
        by smtp.gmail.com with ESMTPSA id n69sm3491840pjc.8.2020.05.05.21.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 21:50:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net
Cc:     kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] net: qrtr: Add MHI transport layer
Date:   Wed,  6 May 2020 10:20:14 +0530
Message-Id: <20200506045015.13421-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI is the transport layer used for communicating to the external modems.
Hence, this commit adds MHI transport layer support to QRTR for
transferring the QMI messages over IPC Router.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/Kconfig  |   7 +++
 net/qrtr/Makefile |   2 +
 net/qrtr/mhi.c    | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 net/qrtr/mhi.c

diff --git a/net/qrtr/Kconfig b/net/qrtr/Kconfig
index 63f89cc6e82c..8eb876471564 100644
--- a/net/qrtr/Kconfig
+++ b/net/qrtr/Kconfig
@@ -29,4 +29,11 @@ config QRTR_TUN
 	  implement endpoints of QRTR, for purpose of tunneling data to other
 	  hosts or testing purposes.
 
+config QRTR_MHI
+	tristate "MHI IPC Router channels"
+	depends on MHI_BUS
+	help
+	  Say Y here to support MHI based ipcrouter channels. MHI is the
+	  transport used for communicating to external modems.
+
 endif # QRTR
diff --git a/net/qrtr/Makefile b/net/qrtr/Makefile
index 32d4e923925d..1b1411d158a7 100644
--- a/net/qrtr/Makefile
+++ b/net/qrtr/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_QRTR_SMD) += qrtr-smd.o
 qrtr-smd-y	:= smd.o
 obj-$(CONFIG_QRTR_TUN) += qrtr-tun.o
 qrtr-tun-y	:= tun.o
+obj-$(CONFIG_QRTR_MHI) += qrtr-mhi.o
+qrtr-mhi-y	:= mhi.o
diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
new file mode 100644
index 000000000000..2a2abf5b070d
--- /dev/null
+++ b/net/qrtr/mhi.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/mhi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+#include "qrtr.h"
+
+struct qrtr_mhi_dev {
+	struct qrtr_endpoint ep;
+	struct mhi_device *mhi_dev;
+	struct device *dev;
+};
+
+/* From MHI to QRTR */
+static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
+				      struct mhi_result *mhi_res)
+{
+	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
+	int rc;
+
+	if (!qdev || mhi_res->transaction_status)
+		return;
+
+	rc = qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
+				mhi_res->bytes_xferd);
+	if (rc == -EINVAL)
+		dev_err(qdev->dev, "invalid ipcrouter packet\n");
+}
+
+/* From QRTR to MHI */
+static void qcom_mhi_qrtr_ul_callback(struct mhi_device *mhi_dev,
+				      struct mhi_result *mhi_res)
+{
+	struct sk_buff *skb = (struct sk_buff *)mhi_res->buf_addr;
+
+	if (skb->sk)
+		sock_put(skb->sk);
+	consume_skb(skb);
+}
+
+/* Send data over MHI */
+static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
+{
+	struct qrtr_mhi_dev *qdev = container_of(ep, struct qrtr_mhi_dev, ep);
+	int rc;
+
+	rc = skb_linearize(skb);
+	if (rc)
+		goto free_skb;
+
+	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
+			   MHI_EOT);
+	if (rc)
+		goto free_skb;
+
+	if (skb->sk)
+		sock_hold(skb->sk);
+
+	return rc;
+
+free_skb:
+	kfree_skb(skb);
+
+	return rc;
+}
+
+static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
+			       const struct mhi_device_id *id)
+{
+	struct qrtr_mhi_dev *qdev;
+	int rc;
+
+	qdev = devm_kzalloc(&mhi_dev->dev, sizeof(*qdev), GFP_KERNEL);
+	if (!qdev)
+		return -ENOMEM;
+
+	qdev->mhi_dev = mhi_dev;
+	qdev->dev = &mhi_dev->dev;
+	qdev->ep.xmit = qcom_mhi_qrtr_send;
+
+	dev_set_drvdata(&mhi_dev->dev, qdev);
+	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
+	if (rc)
+		return rc;
+
+	dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
+
+	return 0;
+}
+
+static void qcom_mhi_qrtr_remove(struct mhi_device *mhi_dev)
+{
+	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
+
+	qrtr_endpoint_unregister(&qdev->ep);
+	dev_set_drvdata(&mhi_dev->dev, NULL);
+}
+
+static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
+	{ .chan = "IPCR" },
+	{}
+};
+MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
+
+static struct mhi_driver qcom_mhi_qrtr_driver = {
+	.probe = qcom_mhi_qrtr_probe,
+	.remove = qcom_mhi_qrtr_remove,
+	.dl_xfer_cb = qcom_mhi_qrtr_dl_callback,
+	.ul_xfer_cb = qcom_mhi_qrtr_ul_callback,
+	.id_table = qcom_mhi_qrtr_id_table,
+	.driver = {
+		.name = "qcom_mhi_qrtr",
+	},
+};
+
+module_mhi_driver(qcom_mhi_qrtr_driver);
+
+MODULE_AUTHOR("Chris Lew <clew@codeaurora.org>");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm IPC-Router MHI interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

