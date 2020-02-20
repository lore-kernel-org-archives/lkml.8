Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7531C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D112467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyP1f/a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBTJ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:59:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40933 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgBTJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:59:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so1674992pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/MbaH1wYfToAAtK7qMJbBONL10BhSFsDsGorAAfsgPk=;
        b=hyP1f/a/9yXtn01r4yT/NIPtZoEuwJpDPJArbwhGirMRyJK6fyKE8kz5t8hxx6BJSi
         xsL1sGLNVMyuMSZn6DzIdCmQPvIM+JPMVsqz733NZl8QtulsFHQuottSK697drms6BNC
         9BxGqOzxkIyqk1zIvTa4zbuw4R9fSwBEEcGLZ+TQ9t5QMlOyzf94RZsBk/fmeCvJDGSp
         uoc9c/yZmL/v5HEagkO2wRFnD6v2v0tVljFV0YQ2XE8F4agbyDv6jcUmQwcOhCYVNj56
         OD225F8iHKCUVkTZKGEa4/aH8VzuMPiA63DWmYXQS82Bplz0elSS5T7ZPuu2J9kNmGQe
         8pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/MbaH1wYfToAAtK7qMJbBONL10BhSFsDsGorAAfsgPk=;
        b=BDgmOEWC/RDMrvh85PSbBVILANtFNJG7/VHJ6cRgqxv26oIQbvEHIwmNU/f7qBK9ld
         qsWvOSJuOw1EvwpETtPIdaPQE+rQLzMl+RIpcSQvI2xRG6XNUVm4sPmISXrah3XdOWGl
         rIDQ1u8canF7wGUDr/5etV54uaGlxtXwxYwoTW4JkHoJ+mLcZjzaqeKJMYk2MnqmBkRa
         JWg+sxZB6xMOLm5MCoTzjlvBM/Br7MSgSvBKJSX8jHoDRESGrWicPf6RqKTZYShnJgBW
         tKcXFOEAOXXoEZOq0doqO052wJ1Kk55meOeHvEW4tEUmYkGC29tOPHxqmGV5ycZSthnS
         KE0g==
X-Gm-Message-State: APjAAAU9GyvLIZyuPaPwVZL4MFYZExN4lWf3OqdSANeaUnabCn0zi6gN
        aj1h8zs+qk6g5XWAEULGZnJr
X-Google-Smtp-Source: APXvYqz98iJpFzSq7+axs+6qTaqlUXtO1NObgDfeSlMgFatt/T6I9BJW6ovBsOAcdlkb8GHJ8kFRYg==
X-Received: by 2002:a63:fe14:: with SMTP id p20mr30459395pgh.94.1582192760132;
        Thu, 20 Feb 2020 01:59:20 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:edda:4222:88ae:442f])
        by smtp.gmail.com with ESMTPSA id b3sm2678644pjo.30.2020.02.20.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 01:59:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 03/16] bus: mhi: core: Add support for registering MHI client drivers
Date:   Thu, 20 Feb 2020 15:28:41 +0530
Message-Id: <20200220095854.4804-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for registering MHI client drivers with the
MHI stack. MHI client drivers binds to one or more MHI devices inorder
to sends and receive the upper-layer protocol packets like IP packets,
modem control messages, and diagnostics messages over MHI bus.

This is based on the patch submitted by Sujeev Dias:
https://lkml.org/lkml/2018/7/9/987

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
[mani: splitted and cleaned up for upstream]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 149 ++++++++++++++++++++++++++++++++++++
 include/linux/mhi.h         |  39 ++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 6f24c21284ec..12e386862b3f 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -374,8 +374,157 @@ struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
 	return mhi_dev;
 }
 
+static int mhi_driver_probe(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct device_driver *drv = dev->driver;
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	struct mhi_event *mhi_event;
+	struct mhi_chan *ul_chan = mhi_dev->ul_chan;
+	struct mhi_chan *dl_chan = mhi_dev->dl_chan;
+
+	if (ul_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (ul_chan->lpm_notify && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!ul_chan->offload_ch && !mhi_drv->ul_xfer_cb)
+			return -EINVAL;
+
+		ul_chan->xfer_cb = mhi_drv->ul_xfer_cb;
+	}
+
+	if (dl_chan) {
+		/*
+		 * If channel supports LPM notifications then status_cb should
+		 * be provided
+		 */
+		if (dl_chan->lpm_notify && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		/* For non-offload channels then xfer_cb should be provided */
+		if (!dl_chan->offload_ch && !mhi_drv->dl_xfer_cb)
+			return -EINVAL;
+
+		mhi_event = &mhi_cntrl->mhi_event[dl_chan->er_index];
+
+		/*
+		 * If the channel event ring is managed by client, then
+		 * status_cb must be provided so that the framework can
+		 * notify pending data
+		 */
+		if (mhi_event->cl_manage && !mhi_drv->status_cb)
+			return -EINVAL;
+
+		dl_chan->xfer_cb = mhi_drv->dl_xfer_cb;
+	}
+
+	/* Call the user provided probe function */
+	return mhi_drv->probe(mhi_dev, mhi_dev->id);
+}
+
+static int mhi_driver_remove(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(dev->driver);
+	struct mhi_chan *mhi_chan;
+	enum mhi_ch_state ch_state[] = {
+		MHI_CH_STATE_DISABLED,
+		MHI_CH_STATE_DISABLED
+	};
+	int dir;
+
+	/* Skip if it is a controller device */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	/* Reset both channels */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		/* Wake all threads waiting for completion */
+		write_lock_irq(&mhi_chan->lock);
+		mhi_chan->ccs = MHI_EV_CC_INVALID;
+		complete_all(&mhi_chan->completion);
+		write_unlock_irq(&mhi_chan->lock);
+
+		/* Set the channel state to disabled */
+		mutex_lock(&mhi_chan->mutex);
+		write_lock_irq(&mhi_chan->lock);
+		ch_state[dir] = mhi_chan->ch_state;
+		mhi_chan->ch_state = MHI_CH_STATE_SUSPENDED;
+		write_unlock_irq(&mhi_chan->lock);
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	mhi_drv->remove(mhi_dev);
+
+	/* De-init channel if it was enabled */
+	for (dir = 0; dir < 2; dir++) {
+		mhi_chan = dir ? mhi_dev->ul_chan : mhi_dev->dl_chan;
+
+		if (!mhi_chan)
+			continue;
+
+		mutex_lock(&mhi_chan->mutex);
+
+		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
+
+		mutex_unlock(&mhi_chan->mutex);
+	}
+
+	return 0;
+}
+
+int mhi_driver_register(struct mhi_driver *mhi_drv)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_bus_type;
+	driver->probe = mhi_driver_probe;
+	driver->remove = mhi_driver_remove;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL_GPL(mhi_driver_register);
+
+void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL_GPL(mhi_driver_unregister);
+
 static int mhi_match(struct device *dev, struct device_driver *drv)
 {
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	const struct mhi_device_id *id;
+
+	/*
+	 * If the device is a controller type then there is no client driver
+	 * associated with it
+	 */
+	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
+		return 0;
+
+	for (id = mhi_drv->id_table; id->chan[0]; id++)
+		if (!strcmp(mhi_dev->chan_name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
 	return 0;
 };
 
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index a34aa50120c8..7e6b7743c705 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -354,6 +354,8 @@ struct mhi_controller {
  * @dl_chan: DL channel for the device
  * @dev: Driver model device node for the MHI device
  * @dev_type: MHI device type
+ * @ul_chan_id: MHI channel id for UL transfer
+ * @dl_chan_id: MHI channel id for DL transfer
  * @dev_wake: Device wakeup counter
  */
 struct mhi_device {
@@ -364,6 +366,8 @@ struct mhi_device {
 	struct mhi_chan *dl_chan;
 	struct device dev;
 	enum mhi_device_type dev_type;
+	int ul_chan_id;
+	int dl_chan_id;
 	u32 dev_wake;
 };
 
@@ -381,6 +385,29 @@ struct mhi_result {
 	int transaction_status;
 };
 
+/**
+ * struct mhi_driver - Structure representing a MHI client driver
+ * @probe: CB function for client driver probe function
+ * @remove: CB function for client driver remove function
+ * @ul_xfer_cb: CB function for UL data transfer
+ * @dl_xfer_cb: CB function for DL data transfer
+ * @status_cb: CB functions for asynchronous status
+ * @driver: Device driver model driver
+ */
+struct mhi_driver {
+	const struct mhi_device_id *id_table;
+	int (*probe)(struct mhi_device *mhi_dev,
+		     const struct mhi_device_id *id);
+	void (*remove)(struct mhi_device *mhi_dev);
+	void (*ul_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*dl_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*status_cb)(struct mhi_device *mhi_dev, enum mhi_callback mhi_cb);
+	struct device_driver driver;
+};
+
+#define to_mhi_driver(drv) container_of(drv, struct mhi_driver, driver)
 #define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
 
 /**
@@ -397,4 +424,16 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
  */
 void mhi_unregister_controller(struct mhi_controller *mhi_cntrl);
 
+/**
+ * mhi_driver_register - Register driver with MHI framework
+ * @mhi_drv: Driver associated with the device
+ */
+int mhi_driver_register(struct mhi_driver *mhi_drv);
+
+/**
+ * mhi_driver_unregister - Unregister a driver for mhi_devices
+ * @mhi_drv: Driver associated with the device
+ */
+void mhi_driver_unregister(struct mhi_driver *mhi_drv);
+
 #endif /* _MHI_H_ */
-- 
2.17.1

