Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0294E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgkJ70E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgGOIZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgGOIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:25:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97132C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:25:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so2089631plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yq/Lo2MWK3oHARHGDYy41ZMRluzNQZqup/FRtSoOyNg=;
        b=cgkJ70E4t73CsT+qttw81U4am3YJk5pgiH3XME7r8vMkz1PPeuSViN5TQaFj1N4K81
         pmH9m60Q4IM5sD7wX6Yfk7fCJ2xX26aNUoVAlnBnw6zk+mOKcUNECZpFMQd1yEns4owf
         Di5Ias0ulypricP9hxiY67+kBK9tP2wvh426w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yq/Lo2MWK3oHARHGDYy41ZMRluzNQZqup/FRtSoOyNg=;
        b=IvUnJSxItGlbAPQY3yc2k0JMSkZVhtS7N0OSVvmENyaTPhmsFu1E8wsqYTHpIUFH/s
         jTGgeUuP30YmK4/ZLGgZ0rkG5/YqSivn6JD+u1IoBnyckDUz+dC3nDeiH8jsDHMGkN0R
         z8En3AJpbbR65WQlER1MNbRLKZDCHM/rP92G3RZqLR2SEGFjer7ZahuN3fsLECue4Ct2
         WA8tiaWocJpUJ7EoBYvOL/Ctk2pc52TwYA91xNYXkp/BSmDXG2JKe+dKIOVMDQSuSGRv
         UQFCtxukihIqcWui8JwM6jx7xd4tDcHR7Ht08g++G0h6o2v/wcHTGb3BwNbAluffk9Ro
         tDyQ==
X-Gm-Message-State: AOAM530cmuw82bA+NYCs1fafvpKOXMF1UeklBVcSszdQfYG4Te8kDjLE
        eqD4/N2XqGYZxfu51IybG7AdMw==
X-Google-Smtp-Source: ABdhPJzbfqdKsoPjbraM6X12/CzCQIIRfDMjCVXXxG80SPTTDz2CeilTNOxBdrA5WHI3iv0Vv4egdQ==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr7518271pls.266.1594801539903;
        Wed, 15 Jul 2020 01:25:39 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id y7sm1093627pfq.69.2020.07.15.01.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:25:38 -0700 (PDT)
From:   Bhanu Prakash Maiya <bhanumaiya@chromium.org>
X-Google-Original-From: Bhanu Prakash Maiya <bhanumaiya@google.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org,
        kernel test robot <lkp@intel.com>,
        Bhanu Prakash Maiya <bhanumaiya@google.com>
Subject: [PATCH v2 1/2] cros: platform/chrome: Add cros-ec-uart driver for uart support
Date:   Wed, 15 Jul 2020 01:25:25 -0700
Message-Id: <20200715082526.1760426-1-bhanumaiya@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

This patch enables uart transport layer for cros_ec framework.
The cros-ec-uart binds with EC device working on uart transport to
send request and receive response.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Change-Id: Icb23b633700f1ef4d123e3f21fd26fad21a3f207
Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@google.com>
---
Changes in v2:
1: Fixed build error on v1.
2: Changed EC timeout for response packet to 3 Sec and added comments.
3: Fixed cros_ec_uart_rx_bytes function to handle rx buffer < size of response header.

 MAINTAINERS                            |   1 +
 drivers/platform/chrome/Kconfig        |  10 +
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_ec_uart.c | 411 +++++++++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_uart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b7..aa8e1d121c1d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4036,6 +4036,7 @@ F:	sound/soc/codecs/cros_ec_codec.*
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+M:	Bhanu Prakash Maiya <bhanumaiya@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
 S:	Maintained
 F:	drivers/power/supply/cros_usbpd-charger.c
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 3822e5e111caa..2082fafe08a6a 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -125,6 +125,16 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_UART
+	tristate "ChromeOS Embedded Controller (UART)"
+	depends on CROS_EC && ACPI && SERIAL_DEV_BUS
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through a UART, using a byte-level protocol.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_uart.
+
 config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
 	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 8ed1e33033b38..fc449351fc794 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
+obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
new file mode 100644
index 0000000000000..9a0ba884b6812
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UART interface for ChromeOS Embedded Controller
+ *
+ * Copyright 2020 Google LLC.
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <uapi/linux/sched/types.h>
+
+#include "cros_ec.h"
+
+/*
+ * EC sends contiguous bytes of response packet on UART AP RX.
+ * TTY driver in AP accumulates incoming bytes and calls the registered callback
+ * function. Byte count can range from 1 to Max count supported by TTY driver.
+ * This driver should wait for long time for all callbacks to be processed.
+ * Considering the worst case scenario, wait for ~3 secs. This timeout should
+ * account for max latency and some additional guard time.
+ * In case the packet is received in ms, wait queue will be released and packet
+ * will be processed.
+ */
+#define EC_MSG_DEADLINE_MS		(300 * 10)
+
+/**
+ * struct response_info - Encapsulate EC response related
+ *			information for passing between function
+ *			cros_ec_uart_pkt_xfer() and cros_ec_uart_rx_bytes()
+ *			callback.
+ * @data:		Copy the data received from EC here.
+ * @max_size:		Max size allocated for the @data buffer. If the
+ *			received data exceeds this value, we log an error.
+ * @size:		Actual size of data received from EC. This is also
+ *			used to accumulate byte count with response is received
+ *			in dma chunks.
+ * @exp_len:		Expected bytes of response from EC including header.
+ * @error:		0 for success, negative error code for a failure.
+ * @received:		Set to true on receiving a valid EC response.
+ * @wait_queue:		Wait queue EC response where the cros_ec sends request
+ *			to EC and waits
+ */
+struct response_info {
+	void *data;
+	size_t max_size;
+	size_t size;
+	int error;
+	size_t exp_len;
+	bool received;
+	wait_queue_head_t wait_queue;
+};
+
+/**
+ * struct cros_ec_uart - information about a uart-connected EC
+ *
+ * @serdev_device:	serdev uart device we are connected to.
+ * @baudrate:		UART baudrate of attached EC device.
+ * @flowcontrol:	UART flowcontrol of attached device.
+ * @irq:		Linux IRQ number of associated serial device.
+ * @response:		Response info passing between cros_ec_uart_pkt_xfer()
+ *			and cros_ec_uart_rx_bytes()
+ */
+struct cros_ec_uart {
+	struct serdev_device *serdev;
+	u32 baudrate;
+	u8  flowcontrol;
+	u32 irq;
+	struct response_info response;
+};
+
+static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
+				 const u8 *data,
+				 size_t count)
+{
+	struct ec_host_response *response;
+	struct cros_ec_device *ec_dev =   serdev_device_get_drvdata(serdev);
+	struct cros_ec_uart *ec_uart = ec_dev->priv;
+
+	/* Check if bytes were sent out of band */
+	if (!ec_uart->response.data) {
+		/* Discard all bytes */
+		return count;
+	}
+
+	/*
+	 * Check if incoming bytes + response.size are less than allocated
+	 * buffer in din by cros_ec. This will ensure that if EC sends more
+	 * bytes than max_size, waiting process will be notified with an error.
+	 */
+	if (ec_uart->response.size + count <= ec_uart->response.max_size) {
+		/* Copy bytes in data in buffer */
+		memcpy((void *)ec_uart->response.data + ec_uart->response.size,
+		       (void *)data, count);
+
+		/* Add incoming bytes in size */
+		ec_uart->response.size += count;
+
+		/*
+		 * Read data_len if we received response header and if exp_len
+		 * was not read before.
+		 */
+		if (ec_uart->response.size >= sizeof(*response) &&
+		    ec_uart->response.exp_len == 0) {
+			/* Get expected response length from response header */
+			response = (struct ec_host_response *)
+							ec_uart->response.data;
+
+			ec_uart->response.exp_len = response->data_len +
+				sizeof(*response);
+		}
+
+		/*
+		 * If driver received response header and payload from EC,
+		 * Wake up the wait queue.
+		 */
+		if (ec_uart->response.size >= sizeof(*response) &&
+		    ec_uart->response.size == ec_uart->response.exp_len) {
+			/* Set flag before waking up the caller */
+			ec_uart->response.received = true;
+
+			/* Wake the calling thread */
+			wake_up_interruptible(&ec_uart->response.wait_queue);
+		}
+	} else {
+		/* Received bytes are more the allocated buffer*/
+		ec_uart->response.error = -EMSGSIZE;
+
+		/* Wake the calling thread */
+		wake_up_interruptible(&ec_uart->response.wait_queue);
+	}
+
+	return count;
+}
+
+static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
+				 struct cros_ec_command *ec_msg)
+{
+	struct cros_ec_uart *ec_uart = ec_dev->priv;
+	struct serdev_device *serdev = ec_uart->serdev;
+	struct ec_host_response *response;
+	unsigned int len;
+	int ret, i;
+	u8 sum = 0;
+
+	/* Prepare an outgoing message in the output buffer */
+	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	dev_dbg(ec_dev->dev, "Prepared len=%d\n", len);
+
+	/* Setup for incoming response */
+	ec_uart->response.data = ec_dev->din;
+	ec_uart->response.max_size = ec_dev->din_size;
+	ec_uart->response.size = 0;
+	ec_uart->response.error = 0;
+	ec_uart->response.exp_len = 0;
+	ec_uart->response.received = false;
+
+	/* Write serial device buffer */
+	ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
+	if (ret < len) {
+		dev_err(&serdev->dev,
+			"Unable to write data to serial device %s",
+			dev_name(&serdev->dev));
+
+		/* Return EIO as controller had issues writing buffer */
+		ret = -EIO;
+		goto exit;
+	}
+
+	/* Once request is successfully sent to EC, wait to wait_queue */
+	wait_event_interruptible_timeout(ec_uart->response.wait_queue,
+					 ec_uart->response.received,
+					 msecs_to_jiffies(EC_MSG_DEADLINE_MS));
+
+	/* Check if wait_queue was interrupted due to an error */
+	if (ec_uart->response.error < 0) {
+		dev_warn(&serdev->dev, "Response error detected.\n");
+
+		ret = ec_uart->response.error;
+		goto exit;
+	}
+
+	/* Check if valid response was received or there was a timeout */
+	if (!ec_uart->response.received) {
+		dev_warn(&serdev->dev, "EC failed to respond in time.\n");
+
+		ret = -ETIMEDOUT;
+		goto exit;
+	}
+
+	/* Check response error code */
+	response = (struct ec_host_response *)ec_dev->din;
+	ec_msg->result = response->result;
+
+	/* Check if received response is longer than expected */
+	if (response->data_len > ec_msg->insize) {
+		dev_err(ec_dev->dev, "Resp too long (%d bytes, expected %d)",
+			response->data_len,
+			ec_msg->insize);
+		ret = -ENOSPC;
+		goto exit;
+	}
+
+	/* Copy response packet to ec_msg data buffer */
+	memcpy(ec_msg->data,
+	       ec_dev->din + sizeof(*response),
+	       response->data_len);
+
+	/* Add all response header bytes for checksum calculation */
+	for (i = 0; i < sizeof(*response); i++)
+		sum += ec_dev->din[i];
+
+	/* Copy response packet payload and compute checksum */
+	for (i = 0; i < response->data_len; i++)
+		sum += ec_msg->data[i];
+
+	if (sum) {
+		dev_err(ec_dev->dev,
+			"Bad packet checksum calculated %x\n",
+			sum);
+		ret = -EBADMSG;
+		goto exit;
+	}
+
+	/* Return data_len to cros_ec */
+	ret = response->data_len;
+
+exit:
+	/* Reset ec_uart */
+	ec_uart->response.data = NULL;
+	ec_uart->response.max_size = 0;
+	ec_uart->response.size = 0;
+	ec_uart->response.error = 0;
+	ec_uart->response.exp_len = 0;
+	ec_uart->response.received = false;
+
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
+	return ret;
+}
+
+static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
+{
+	struct cros_ec_uart *ec_uart = data;
+	struct acpi_resource_uart_serialbus *sb;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
+		sb = &ares->data.uart_serial_bus;
+		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
+			ec_uart->baudrate = sb->default_baud_rate;
+			dev_dbg(&ec_uart->serdev->dev, "Baudrate %d\n",
+				ec_uart->baudrate);
+
+			ec_uart->flowcontrol = sb->flow_control;
+			dev_dbg(&ec_uart->serdev->dev, "Flow control %d\n",
+				ec_uart->flowcontrol);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
+{
+	LIST_HEAD(resources);
+	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+	int ret;
+
+	/* Retrieve UART ACPI info */
+	ret = acpi_dev_get_resources(adev, &resources,
+				     cros_ec_uart_resource, ec_uart);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&resources);
+
+	/* Retrieve GpioInt and translate it to Linux IRQ number */
+	ret = acpi_dev_gpio_irq_get(adev, 0);
+	if (ret < 0)
+		return ret;
+
+	ec_uart->irq = ret;
+	dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
+
+	return 0;
+}
+
+static const struct serdev_device_ops cros_ec_uart_client_ops = {
+	.receive_buf = cros_ec_uart_rx_bytes,
+};
+
+static int cros_ec_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_uart *ec_uart;
+	int ret;
+
+	ec_uart = devm_kzalloc(dev, sizeof(*ec_uart), GFP_KERNEL);
+	if (!ec_uart)
+		return -ENOMEM;
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	ec_uart->serdev = serdev;
+
+	/* Open the serial device */
+	ret = devm_serdev_device_open(dev, ec_uart->serdev);
+	if (ret) {
+		dev_err(dev, "Unable to open UART device %s",
+			dev_name(&serdev->dev));
+		return ret;
+	}
+
+	serdev_device_set_drvdata(serdev, ec_dev);
+
+	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
+
+	/* Initialize wait queue */
+	init_waitqueue_head(&ec_uart->response.wait_queue);
+
+	ret = cros_ec_uart_acpi_probe(ec_uart);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get ACPI info (%d)", ret);
+		return ret;
+	}
+
+	/* Set baud rate of serial device */
+	ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set up host baud rate (%d)", ret);
+		return ret;
+	}
+
+	/* Set flow control of serial device */
+	serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
+
+	/* Initialize ec_dev for cros_ec  */
+	ec_dev->phys_name = dev_name(&ec_uart->serdev->dev);
+	ec_dev->dev = dev;
+	ec_dev->priv = ec_uart;
+	ec_dev->irq = ec_uart->irq;
+	ec_dev->cmd_xfer = NULL;
+	ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
+	ec_dev->din_size = sizeof(struct ec_host_response) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct ec_host_request);
+
+	/* Register a new cros_ec device */
+	return cros_ec_register(ec_dev);
+}
+
+static void cros_ec_uart_remove(struct serdev_device *serdev)
+{
+	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
+
+	cros_ec_unregister(ec_dev);
+};
+
+static int __maybe_unused cros_ec_uart_suspend(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_suspend(ec_dev);
+}
+
+static int __maybe_unused cros_ec_uart_resume(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_resume(ec_dev);
+}
+
+static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
+			 cros_ec_uart_resume);
+
+static const struct of_device_id cros_ec_uart_of_match[] = {
+	{ .compatible = "google,cros-ec-uart" },
+	{}
+};
+
+static struct serdev_device_driver cros_ec_uart_driver = {
+	.driver	= {
+		.name	= "cros-ec-uart",
+		.of_match_table = cros_ec_uart_of_match,
+		.pm	= &cros_ec_uart_pm_ops,
+	},
+	.probe		= cros_ec_uart_probe,
+	.remove		= cros_ec_uart_remove,
+};
+
+module_serdev_device_driver(cros_ec_uart_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("UART interface for ChromeOS Embedded Controller");
+MODULE_AUTHOR("Bhanu Prakash Maiya <bhanumaiya@chromium.org>");
-- 
2.27.0.389.gc38d7665816-goog

