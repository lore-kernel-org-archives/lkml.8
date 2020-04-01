Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A3CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743D4206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dyq4yoaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbgDAGpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:45:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbgDAGpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:45:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so9228909plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZS0gV3JBjWbOHO4SSLHlOaSzVZMHP224dHQ2VsyE36o=;
        b=Dyq4yoaAKxGZ5yi7tLEzc7Zhbnl32RgPdEkSrJLTrVCi+Znc89whhNYx/2VYrzl9YR
         kd8VmkDosoR4IEx1BWxfLoi0a3i21RJ669v6XS11EGQyGDy8UC2EHsXGG7bW2NFOXAlm
         2lJwCASsW79c97dNmvZH3UsntBPC/pxgnXxHmn24TjGDviA6DzzyeHAUOg/9TKx7ph3i
         dkPgiuzZEjy2A/MFHzY1hggrmMnFSFT28soKAlwcLy5sdJWsiU8xsnsww5RqYvI6YBAN
         tEtxPvQ0Y7nZUoJ+Ph/Ua9+2QNMIsWEs44apeWHBzmEYwhahfGmLLdGI5YKrPJtc56Ls
         /25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZS0gV3JBjWbOHO4SSLHlOaSzVZMHP224dHQ2VsyE36o=;
        b=mnZx+Q+r9u+UGoXr65f46EAARq61h3ArSb0QndbIbbJcRISlI+AMYY56VMnnXUDo5Z
         imXXg2ITJ25rAJBxZw9zz7t6auIVkDdqu6WLGwObuzlQ1e2tYqIh8ZT4dNwfGjfiVuHz
         aQ+oMQN7AOJk7kpO2wXjl6xbaqPAlx5tXYfUfoCZlyfYyEDNyb7FbS9ABcDoH0Neab1h
         OPZwAa0tOG/ni37mopuAQXqKL1dxQrk/JVcTmD5o/PMzYHk/09H58O9Bx0nnwKTRUoTP
         QhDjXTvIg5yMiSpwoahOu3+2VUCd1YyB/kkyeA0HsnexdsQ9rrj8zuR43ku2v/om047T
         gi1w==
X-Gm-Message-State: AGi0Pua074sMcf32+oHeWaVgIvEf6GTaj0aTTd0094iVflAAQUdSZzNi
        DLDGPwuhCH8ETij59iYB+oX3VCAtRsO6
X-Google-Smtp-Source: APiQypK4eGP+7x2mrl7B51TEphI6p2811HMmD1e4xIxdzJhBWe7ymqIF3tW/pkPWZ1wTD44OqX3EXA==
X-Received: by 2002:a17:90a:2103:: with SMTP id a3mr3063641pje.181.1585723518792;
        Tue, 31 Mar 2020 23:45:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:648c:592d:60f5:6f58:e46:db78])
        by smtp.gmail.com with ESMTPSA id w24sm831962pjn.14.2020.03.31.23.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 23:45:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
Subject: [PATCH 2/3] net: qrtr: Add MHI transport layer
Date:   Wed,  1 Apr 2020 12:14:34 +0530
Message-Id: <20200401064435.12676-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401064435.12676-1-manivannan.sadhasivam@linaro.org>
References: <20200401064435.12676-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI is the transport layer used for communicating to the external modems.
Hence, this commit adds MHI transport layer support to QRTR for
transferring the QMI messages over IPC Router.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/Kconfig  |   7 +++
 net/qrtr/Makefile |   2 +
 net/qrtr/mhi.c    | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+)
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
index 1c6d6c120fb7..3dc0a7c9d455 100644
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
index 000000000000..d4f877f3d1eb
--- /dev/null
+++ b/net/qrtr/mhi.c
@@ -0,0 +1,126 @@
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
+	consume_skb(skb);
+	if (skb->sk)
+		sock_put(skb->sk);
+}
+
+/* Send data over MHI */
+static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
+{
+	struct qrtr_mhi_dev *qdev = container_of(ep, struct qrtr_mhi_dev, ep);
+	int rc;
+
+	rc = skb_linearize(skb);
+	if (rc) {
+		kfree_skb(skb);
+		return rc;
+	}
+
+	rc = mhi_queue_skb(qdev->mhi_dev, DMA_TO_DEVICE, skb, skb->len,
+			   MHI_EOT);
+	if (rc) {
+		kfree_skb(skb);
+		return rc;
+	}
+
+	if (skb->sk)
+		sock_hold(skb->sk);
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

