Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5B3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958B722B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTCsXLZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHDXAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHDXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:00:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71931C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 16:00:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so24196213pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPtMZKmLTopKVwyOb7vCqjxfLQb6r3iyX4JHWlc1XlI=;
        b=gTCsXLZbFlT6GOSx43JoQ4Za744BysbA2eiR/WI8YQS99OWv2cmkz6gCBhhxa8ycft
         M6hm0YeQofXLRZ3n10RA0L/S8EHs1X4VVqFTvFHqVluDF4jWTsDF0M09RFRt4g5mRr/Z
         vLAc4LN0y9c752CQveNZQDdIg9i7dPSAQKH5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPtMZKmLTopKVwyOb7vCqjxfLQb6r3iyX4JHWlc1XlI=;
        b=rSpBjsuHlPcPeXZOzqC8Ud/2KHDSSEb718mA5oE7h5I7FPFFe8ssVy2dXJxZ6MBqU1
         Pr/Ymi0f+Tpl2a520HBua30/42YnCPI46ddsp42Ztuu1mzfOU8idYK9zO7uyqEbSJfpR
         zZf0ivWSJfd7eFJzGe2QMgsRNC9ftSyzTEhhptcmmAr8eEwvvdQaO7eKpx4d0g09d5KO
         whfE+Y8sJhywUBGd2UFvMSt0h9SphCOV6gMczNP/NrWbFr+BtbxS07XjKCVtBkNxgjpv
         JyvLHr34fO+Eo5w12CCTdRL+TvrrIu+v+YrmgZPvCH3ad7xDl219xo+kW3mhprHV3rjo
         zRhA==
X-Gm-Message-State: AOAM531wjscpKIS/4pPTg80tvTJKL6m/RP6IEyAzsOwfUf7/faF/9SuN
        PvIhjyvKoaSKb1pPDh4ULKarRYcNRz4=
X-Google-Smtp-Source: ABdhPJxsMCYH43m75e8hpP7f705uJ2qlLn90oEAs20gpQrp8yYtvBghOjpbfz6VqsRVG3kEUkontfw==
X-Received: by 2002:a17:902:eb14:: with SMTP id l20mr498969plb.104.1596582001966;
        Tue, 04 Aug 2020 16:00:01 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id y4sm247141pgb.16.2020.08.04.16.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 16:00:01 -0700 (PDT)
From:   Bhanu Prakash Maiya <bhanumaiya@chromium.org>
X-Google-Original-From: Bhanu Prakash Maiya <bhanumaiya@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Duncan Laurie <dlaurie@google.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eric Peers <epeers@google.com>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Subject: [PATCH v5 1/2] platform/chrome: cros_ec_uart: Add cros-ec-uart transport layer
Date:   Tue,  4 Aug 2020 15:59:56 -0700
Message-Id: <20200804155833.v5.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

This patch does following:
1. Adds a new cros-ec-uart driver. This driver can send EC requests on
   UART and process response packets received on UART transport.
2. Once probed, this driver will initialize the serdev device based on
   the underlying information in the ACPI resource. After serdev device
   properties are set, this driver will register itself cros-ec.
3. High level driver can use this implementation to talk to ChromeOS
   Embedded Controller device in case it supports UART as transport.
4. When cros-ec driver initiates a request packet, outgoing message is
   processed in buffer and sent via serdev. Once bytes are sent, driver
   enables a wait_queue.
5. Since ChromeOS EC device sends response asynchronously, AP's TTY
   driver accumulates response bytes and calls the registered callback.
   TTY driver can send multiple callback for bytes ranging from 1 to MAX
   bytes supported by EC device.
6. Driver waits for EC_MSG_DEADLINE_MS to collect and process received
   bytes. It wakes wait_queue if expected bytes are received or else
   wait_queue timeout. Based on the error condition, driver returns
   data_len or error to cros_ec.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
---

Changes in v5:
- Fixed checkpatch.pl warnings.

Changes in v4:
- Change EC_MSG_DEADLINE_MS from 3 secs to 1 sec. 3 secs timeout prevents
  driver from intercepting EC in RO stage. In case of request failure, 1
  sec allows driver to retry and send HC when EC is in RO.
- Add more information in commit message.

Changes in v3:
- checkpatch.pl script warns about char len 80 even though we have
  relaxed view guideline for line below 100 chars. Currently sticking
  with 80 chars in v3.
- Fixed style issues

Changes in v2:
- Fixed build error on v1.
- Changed EC timeout for response packet to 3 Sec and added comments.
- Fixed cros_ec_uart_rx_bytes function to handle rx buffer < size of response header.

 MAINTAINERS                            |   6 +
 drivers/platform/chrome/Kconfig        |  10 +
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_ec_uart.c | 415 +++++++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_uart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e8232c65da9..1603efb897a18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4133,6 +4133,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC UART DRIVER
+M:	Bhanu Prakash Maiya <bhanumaiya@chromium.org>
+R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+S:	Maintained
+F:	drivers/platform/chrome/cros_ec_uart.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index cf072153bdc5d..88b1b7b277ba3 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -118,6 +118,16 @@ config CROS_EC_SPI
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
index 41baccba033f7..47d8d0f890ca2 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
+obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
new file mode 100644
index 0000000000000..6b4510e26bd12
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -0,0 +1,415 @@
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
+ * function. Byte count can range from 1 to MAX bytes supported by EC.
+ * This driver should wait for long time for all callbacks to be processed.
+ * Considering the worst case scenario, wait for ~1 sec. This timeout should
+ * account for max latency and some additional guard time.
+ * Best case: Entire packet is received in ~1 ms, wait queue will be released
+ * and packet will be processed.
+ * Worst case: TTY driver sends bytes in multiple callbacks. In this case this
+ * driver will wait for ~1 sec beyond which it will timeout.
+ * This timeout value should not exceed ~1.2 secs because in case if
+ * EC_CMD_REBOOT_EC sent, high level driver should be able to intercept EC
+ * in RO.
+ */
+#define EC_MSG_DEADLINE_MS		1000
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
+	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
+	struct cros_ec_uart *ec_uart = ec_dev->priv;
+
+	/* Check if bytes were sent out of band */
+	if (!ec_uart->response.data)
+		/* Discard all bytes */
+		return count;
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
2.26.2

