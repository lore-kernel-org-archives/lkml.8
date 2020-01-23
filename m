Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4789C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968F22467F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDgW9PTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAWLTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43020 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgAWLTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so1383013pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5kiBZvmyuxYyEDeoHZDMOfXNytOnuRRE2t4tnTLS+A=;
        b=wDgW9PTTBIprQOzDpnxtIhxh+xwNqH2FZocK+pBX+dieFPNM3t4a9SEfDVqnnm0lRM
         G/fNJ61c64GxFVKsarDaD/juXPh/XUlEsNGHEfMb7cU4tgd6yPa+SSQe0lOsUF/g719m
         DzUWHcbQaFVcfU1f++SLf9Yo1ijScUjC0YpWYwtiXgI38EQyn9Fcii5RJqqEaEwCFNn3
         ok6zqK/givp1KV8COd/+x/Be6DbcRdpshPWDymwF9S5PfzbGoEkzTMBFAniaEyoatMww
         lPUN4qGcjgrIlG3i+EhsgfsP97icIhFFeJ36OeHquATBgkI+Y39I2z0LbjVfdoIOsC7Z
         thEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5kiBZvmyuxYyEDeoHZDMOfXNytOnuRRE2t4tnTLS+A=;
        b=rW+TgpziDU87FiHRwfZkKsBQC0jfC5GV2AFRmENYAVlpVLzcuijK2SoaNb44Od3pq1
         Z0dCk7TODKG1ZsuIE3mWkOlT6guqWYsIydP3MCYUOI/hocXh7bv1MThNMC2JyVD5LLK3
         9d//yKlsRQa4+4UvFwP89Tg1HnOD9n+NYIyNIOHmyLq9OHKG0sro9pxwLzLo3/wzxMBU
         168Lxzsc5jyQ64wXSV+keT/jduyYIa0Wx1n28yjdlirX9bWSYQfnm//W88N3c2vUM51m
         zrucLtXSCSQri+egKYXOals7qde1+SdG7WSl2lXcn5bm9hIZgioSYxXxWWO4R1i2nvAg
         4KlQ==
X-Gm-Message-State: APjAAAW4+WDapMzJ7x7Zk3n0UasjbxOtGJzH0cec8TFqXnnp25Z4glQv
        Ef8JJyDX8Sj1Sq7ee+95I69F
X-Google-Smtp-Source: APXvYqwPCLeINqE3jnx81UWtk4G1qb5KtrS/bVSD4BboVF/QMqHqsKHEmfgXkl6Hps7BSFLVso4zSQ==
X-Received: by 2002:a62:3343:: with SMTP id z64mr6726769pfz.150.1579778339810;
        Thu, 23 Jan 2020 03:18:59 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:18:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/16] bus: mhi: core: Add support for creating and destroying MHI devices
Date:   Thu, 23 Jan 2020 16:48:24 +0530
Message-Id: <20200123111836.7414-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for creating and destroying MHI devices. The
MHI devices binds to the MHI channels and are used to transfer data
between MHI host and client device.

This is based on the patch submitted by Sujeev Dias:
https://lkml.org/lkml/2018/7/9/989

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
[mani: splitted from pm patch and cleaned up for upstream]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/Makefile   |   2 +-
 drivers/bus/mhi/core/internal.h |   1 +
 drivers/bus/mhi/core/main.c     | 123 ++++++++++++++++++++++++++++++++
 include/linux/mhi.h             |   6 ++
 4 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/mhi/core/main.c

diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
index 2db32697c67f..77f7730da4bf 100644
--- a/drivers/bus/mhi/core/Makefile
+++ b/drivers/bus/mhi/core/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_MHI_BUS) := mhi.o
 
-mhi-y := init.o
+mhi-y := init.o main.o
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 21f686d3a140..ea7f1d7b0129 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -140,6 +140,7 @@ struct mhi_chan {
 	bool offload_ch;
 	bool pre_alloc;
 	bool auto_start;
+	bool wake_capable;
 	int (*gen_tre)(struct mhi_controller *mhi_cntrl,
 		       struct mhi_chan *mhi_chan, void *buf, void *cb,
 		       size_t len, enum mhi_flags flags);
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
new file mode 100644
index 000000000000..216fd8691140
--- /dev/null
+++ b/drivers/bus/mhi/core/main.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#define dev_fmt(fmt) "MHI: " fmt
+
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/mhi.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+int mhi_destroy_device(struct device *dev, void *data)
+{
+	struct mhi_device *mhi_dev;
+	struct mhi_controller *mhi_cntrl;
+
+	if (dev->bus != &mhi_bus_type)
+		return 0;
+
+	mhi_dev = to_mhi_device(dev);
+	mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	/* Only destroy virtual devices thats attached to bus */
+	if (mhi_dev->dev_type ==  MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	dev_dbg(mhi_cntrl->dev, "destroy device for chan:%s\n",
+		 mhi_dev->chan_name);
+
+	/* Notify the client and remove the device from MHI bus */
+	device_del(dev);
+	put_device(dev);
+
+	return 0;
+}
+
+static void mhi_notify(struct mhi_device *mhi_dev, enum mhi_callback cb_reason)
+{
+	struct mhi_driver *mhi_drv;
+
+	if (!mhi_dev->dev.driver)
+		return;
+
+	mhi_drv = to_mhi_driver(mhi_dev->dev.driver);
+
+	if (mhi_drv->status_cb)
+		mhi_drv->status_cb(mhi_dev, cb_reason);
+}
+
+/* Bind MHI channels to MHI devices */
+void mhi_create_devices(struct mhi_controller *mhi_cntrl)
+{
+	int i;
+	struct mhi_chan *mhi_chan;
+	struct mhi_device *mhi_dev;
+	int ret;
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		if (!mhi_chan->configured || mhi_chan->mhi_dev ||
+		    !(mhi_chan->ee_mask & BIT(mhi_cntrl->ee)))
+			continue;
+		mhi_dev = mhi_alloc_device(mhi_cntrl);
+		if (!mhi_dev)
+			return;
+
+		mhi_dev->dev_type = MHI_DEVICE_XFER;
+		switch (mhi_chan->dir) {
+		case DMA_TO_DEVICE:
+			mhi_dev->ul_chan = mhi_chan;
+			mhi_dev->ul_chan_id = mhi_chan->chan;
+			break;
+		case DMA_FROM_DEVICE:
+			/* We use dl_chan as offload channels */
+			mhi_dev->dl_chan = mhi_chan;
+			mhi_dev->dl_chan_id = mhi_chan->chan;
+			break;
+		default:
+			dev_err(mhi_cntrl->dev, "Direction not supported\n");
+			mhi_dealloc_device(mhi_cntrl, mhi_dev);
+			return;
+		}
+
+		mhi_chan->mhi_dev = mhi_dev;
+
+		/* Check next channel if it matches */
+		if ((i + 1) < mhi_cntrl->max_chan && mhi_chan[1].configured) {
+			if (!strcmp(mhi_chan[1].name, mhi_chan->name)) {
+				i++;
+				mhi_chan++;
+				if (mhi_chan->dir == DMA_TO_DEVICE) {
+					mhi_dev->ul_chan = mhi_chan;
+					mhi_dev->ul_chan_id = mhi_chan->chan;
+				} else {
+					mhi_dev->dl_chan = mhi_chan;
+					mhi_dev->dl_chan_id = mhi_chan->chan;
+				}
+				mhi_chan->mhi_dev = mhi_dev;
+			}
+		}
+
+		/* Channel name is same for both UL and DL */
+		mhi_dev->chan_name = mhi_chan->name;
+		dev_set_name(&mhi_dev->dev, "%04x_%s", mhi_chan->chan,
+			     mhi_dev->chan_name);
+
+		/* Init wakeup source if available */
+		if (mhi_dev->dl_chan && mhi_dev->dl_chan->wake_capable)
+			device_init_wakeup(&mhi_dev->dev, true);
+
+		ret = device_add(&mhi_dev->dev);
+		if (ret)
+			mhi_dealloc_device(mhi_cntrl, mhi_dev);
+	}
+}
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 0fdad987dd70..cb6ddd23463c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -166,6 +166,7 @@ enum mhi_db_brst_mode {
  * @doorbell_mode_switch: Channel switches to doorbell mode on M0 transition
  * @auto_queue: Framework will automatically queue buffers for DL traffic
  * @auto_start: Automatically start (open) this channel
+ * @wake-capable: Channel capable of waking up the system
  */
 struct mhi_channel_config {
 	u32 num;
@@ -184,6 +185,7 @@ struct mhi_channel_config {
 	bool doorbell_mode_switch;
 	bool auto_queue;
 	bool auto_start;
+	bool wake_capable;
 };
 
 /**
@@ -365,6 +367,8 @@ struct mhi_controller {
  * struct mhi_device - Structure representing a MHI device which binds
  *                     to channels
  * @dev: Driver model device node for the MHI device
+ * @ul_chan_id: MHI channel id for UL transfer
+ * @dl_chan_id: MHI channel id for DL transfer
  * @tiocm: Device current terminal settings
  * @id: Pointer to MHI device ID struct
  * @chan_name: Name of the channel to which the device binds
@@ -376,6 +380,8 @@ struct mhi_controller {
  */
 struct mhi_device {
 	struct device dev;
+	int ul_chan_id;
+	int dl_chan_id;
 	u32 tiocm;
 	const struct mhi_device_id *id;
 	const char *chan_name;
-- 
2.17.1

