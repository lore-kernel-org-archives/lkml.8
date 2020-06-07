Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424FFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D56420663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAbNhmk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFGQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgFGQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:08:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D69C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:08:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so4720854pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzUoklbK7Eukv6/PNPZJXTpT3tdzTdsZ6qoWGHNAsxw=;
        b=WAbNhmk2nt4AFPtXtRWKr203kkfV/UebTaYpm8xPoXupiHZReQRYAdxqf7216KgRWG
         1d+bK74g963NU9dQ6G4hoFEyxnKynRIXzsU8CoE5w/ud/ok1fpyIx6VbtgH6oA0+0iBC
         LcjaPDA7YpJk1jTV7ShPAtH01mDjlJKEHcdOpNwa7Rydb8yUtLRsIzgmtTjmsES5qVBV
         eARUCyjsXte6DBKvQ7aeILM6aoPPPZ+RRhVvb3Z9Ud5QWQpOjjj6HMAkL3UD6WN/VrHT
         DkQOugokSCOQoa/vSlapno2YJYZXHJMI75byrl4qKSTlGp25uYoMQrWy/beTzimUIJql
         NDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzUoklbK7Eukv6/PNPZJXTpT3tdzTdsZ6qoWGHNAsxw=;
        b=FC2McVEhuscR3MpAjZ4D3DMBBpZy00cIW6WCwcbUQe/TkVpoYRNXriKE5ERmjnmPiY
         7m+Bx78g279uMkJzz0+I3iBCm/czkUEff/YzaiPS6UAodWEzgxTIJz9j9g0OmTrQG2JJ
         HlX4NlH7iNMH6xDfkG63xR8InzEOoOBiOU5YP+lvfalvF157NZPHLnzsNu0P3/Iq0Zra
         MybB2HnhYPXiugqklJufNfZOM6kBU6dImuqeG8VGPfzG7e6Ng/zFhilSrTtq++BqWcM/
         LOXDUXWeevNZyUoVicsvbvQw3hX5WYfbDB2H2b0Whfs4PBCEkIrtUnFXVAE0u69MOM/j
         /BdA==
X-Gm-Message-State: AOAM531Sqce7wzHmPwbVgwLc2stonKT9+l31keVZLqQhu1FaaoH1wfND
        QWdLdOmIECfmAuYvEDOdvJAV
X-Google-Smtp-Source: ABdhPJz28hATPXaURsoJzVC294o3cmZWGDP1+s9JH3ouDSQ1vrAbtFx9hspjnmbzJ8JX/wPitoi+9g==
X-Received: by 2002:a17:90a:218c:: with SMTP id q12mr11949631pjc.116.1591546105790;
        Sun, 07 Jun 2020 09:08:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e9a:8b0a:3d5e:1902:f17d:d125])
        by smtp.gmail.com with ESMTPSA id r202sm4739449pfr.185.2020.06.07.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:08:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v4 1/3] usb: serial: Add MaxLinear/Exar USB to Serial driver
Date:   Sun,  7 Jun 2020 21:38:07 +0530
Message-Id: <20200607160809.20192-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607160809.20192-1-mani@kernel.org>
References: <20200607160809.20192-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MaxLinear/Exar USB to Serial converters. This driver
only supports XR21V141X series but it can be extended to other series
from Exar as well in future.

This driver is inspired from the initial one submitted by Patong Yang:

https://patchwork.kernel.org/patch/10543261/

While the initial driver was a custom tty USB driver exposing whole
new serial interface ttyXRUSBn, this version is completely based on USB
serial core thus exposing the interfaces as ttyUSBn. This will avoid
the overhead of exposing a new USB serial interface which the userspace
tools are unaware of.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/usb/serial/Kconfig     |   9 +
 drivers/usb/serial/Makefile    |   1 +
 drivers/usb/serial/xr_serial.c | 650 +++++++++++++++++++++++++++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 drivers/usb/serial/xr_serial.c

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 25d7e0c36d38..8f6ad9f94735 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -644,6 +644,15 @@ config USB_SERIAL_UPD78F0730
 	  To compile this driver as a module, choose M here: the
 	  module will be called upd78f0730.
 
+config USB_SERIAL_XR
+	tristate "USB MaxLinear/Exar USB to Serial driver"
+	help
+	  Say Y here if you want to use MaxLinear/Exar USB to Serial converter
+	  devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called xr_serial.
+
 config USB_SERIAL_DEBUG
 	tristate "USB Debugging Device"
 	help
diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
index 2d491e434f11..4f69c2a3aff3 100644
--- a/drivers/usb/serial/Makefile
+++ b/drivers/usb/serial/Makefile
@@ -62,4 +62,5 @@ obj-$(CONFIG_USB_SERIAL_VISOR)			+= visor.o
 obj-$(CONFIG_USB_SERIAL_WISHBONE)		+= wishbone-serial.o
 obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
 obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
+obj-$(CONFIG_USB_SERIAL_XR)			+= xr_serial.o
 obj-$(CONFIG_USB_SERIAL_XSENS_MT)		+= xsens_mt.o
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
new file mode 100644
index 000000000000..bb7df79cc129
--- /dev/null
+++ b/drivers/usb/serial/xr_serial.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MaxLinear/Exar USB to Serial driver
+ *
+ * Based on initial driver written by Patong Yang <patong.mxl@gmail.com>
+ *
+ * This driver claims both data and control interfaces but only registers tty
+ * device for data interface.
+ *
+ * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/usb.h>
+#include <linux/usb/serial.h>
+
+static void xr_set_termios(struct tty_struct *tty,
+			   struct usb_serial_port *port,
+			   struct ktermios *old_termios);
+
+struct xr_uart_regs {
+	u8 enable;
+	u8 format;
+	u8 flow_ctrl;
+	u8 xon_char;
+	u8 xoff_char;
+	u8 loopback;
+	u8 tx_break;
+	u8 rs485_delay;
+	u8 gpio_mode;
+	u8 gpio_dir;
+	u8 gpio_int_mask;
+	u8 gpio_set;
+	u8 gpio_clr;
+	u8 gpio_status;
+};
+
+struct xr_port_private {
+	const struct xr_uart_regs *regs;
+	bool port_open;
+};
+
+struct xr_txrx_clk_mask {
+	u16 tx;
+	u16 rx0;
+	u16 rx1;
+};
+
+#define XR21V141X_ID			0x1410
+#define XR_INT_OSC_HZ			48000000U
+#define XR21V141X_MIN_SPEED		46U
+#define XR21V141X_MAX_SPEED		XR_INT_OSC_HZ
+
+/* USB Requests */
+#define XR_SET_XR21V141X		0
+#define XR_GET_XR21V141X		1
+
+#define XR21V141X_CLOCK_DIVISOR_0	0x4
+#define XR21V141X_CLOCK_DIVISOR_1	0x5
+#define XR21V141X_CLOCK_DIVISOR_2	0x6
+#define XR21V141X_TX_CLOCK_MASK_0	0x7
+#define XR21V141X_TX_CLOCK_MASK_1	0x8
+#define XR21V141X_RX_CLOCK_MASK_0	0x9
+#define XR21V141X_RX_CLOCK_MASK_1	0xa
+
+/* XR21V141X register blocks */
+#define XR21V141X_UART_REG_BLOCK		0
+#define XR21V141X_UART_MANAGER_REG_BLOCK	4
+#define XR21V141X_UART_CUSTOM_BLOCK		0x66
+
+/* XR21V141X UART Manager Registers */
+#define XR21V141X_UART_MANAGER_FIFO_ENABLE_REG	0x10
+#define XR21V141X_UART_MANAGER_ENABLE_TX_FIFO	0x1
+#define XR21V141X_UART_MANAGER_ENABLE_RX_FIFO	0x2
+
+#define XR21V141X_UART_MANAGER_RX_FIFO_RESET	0x18
+#define XR21V141X_UART_MANAGER_TX_FIFO_RESET	0x1c
+
+#define UART_ENABLE_TX			0x1
+#define UART_ENABLE_RX			0x2
+
+#define UART_MODE_RI			BIT(0)
+#define UART_MODE_CD			BIT(1)
+#define UART_MODE_DSR			BIT(2)
+#define UART_MODE_DTR			BIT(3)
+#define UART_MODE_CTS			BIT(4)
+#define UART_MODE_RTS			BIT(5)
+
+#define UART_BREAK_ON			0xff
+#define UART_BREAK_OFF			0
+
+#define UART_DATA_MASK			GENMASK(3, 0)
+#define UART_DATA_7			0x7
+#define UART_DATA_8			0x8
+
+#define UART_PARITY_MASK		GENMASK(6, 4)
+#define UART_PARITY_SHIFT		0x4
+#define UART_PARITY_NONE		0x0
+#define UART_PARITY_ODD			0x1
+#define UART_PARITY_EVEN		0x2
+#define UART_PARITY_MARK		0x3
+#define UART_PARITY_SPACE		0x4
+
+#define UART_STOP_MASK			BIT(7)
+#define UART_STOP_SHIFT			0x7
+#define UART_STOP_1			0x0
+#define UART_STOP_2			0x1
+
+#define UART_FLOW_MODE_NONE		0x0
+#define UART_FLOW_MODE_HW		0x1
+#define UART_FLOW_MODE_SW		0x2
+
+#define UART_MODE_GPIO_MASK		GENMASK(2, 0)
+#define UART_MODE_RTS_CTS		0x1
+#define UART_MODE_DTR_DSR		0x2
+#define UART_MODE_RS485			0x3
+#define UART_MODE_RS485_ADDR		0x4
+
+static const struct xr_uart_regs xr21v141x_regs = {
+	.enable = 0x03,
+	.format = 0x0b,
+	.flow_ctrl = 0x0c,
+	.xon_char = 0x10,
+	.xoff_char = 0x11,
+	.loopback = 0x12,
+	.tx_break = 0x14,
+	.rs485_delay = 0x15,
+	.gpio_mode = 0x1a,
+	.gpio_dir = 0x1b,
+	.gpio_int_mask = 0x1c,
+	.gpio_set = 0x1d,
+	.gpio_clr = 0x1e,
+	.gpio_status = 0x1f,
+};
+
+static int xr_set_reg(struct usb_serial_port *port, u8 block, u8 reg,
+		      u8 val)
+{
+	struct usb_serial *serial = port->serial;
+	int ret;
+
+	ret = usb_control_msg(serial->dev,
+			      usb_sndctrlpipe(serial->dev, 0),
+			      XR_SET_XR21V141X,
+			      USB_DIR_OUT | USB_TYPE_VENDOR, val,
+			      reg | (block << 8), NULL, 0,
+			      USB_CTRL_SET_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&port->dev, "Failed to set reg 0x%02x: %d\n", reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xr_get_reg(struct usb_serial_port *port, u8 block, u8 reg,
+		      u8 *val)
+{
+	struct usb_serial *serial = port->serial;
+	u8 *dmabuf;
+	int ret;
+
+	dmabuf = kmalloc(1, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	ret = usb_control_msg(serial->dev,
+			      usb_rcvctrlpipe(serial->dev, 0),
+			      XR_GET_XR21V141X,
+			      USB_DIR_IN | USB_TYPE_VENDOR, 0,
+			      reg | (block << 8), dmabuf, 1,
+			      USB_CTRL_GET_TIMEOUT);
+	if (ret == 1) {
+		*val = *dmabuf;
+		ret = 0;
+	} else {
+		dev_err(&port->dev, "Failed to get reg 0x%02x: %d\n", reg, ret);
+		if (ret >= 0)
+			ret = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return ret;
+}
+
+/* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
+static const struct xr_txrx_clk_mask xr21v141x_txrx_clk_masks[] = {
+	{ 0x000, 0x000, 0x000 },
+	{ 0x000, 0x000, 0x000 },
+	{ 0x100, 0x000, 0x100 },
+	{ 0x020, 0x400, 0x020 },
+	{ 0x010, 0x100, 0x010 },
+	{ 0x208, 0x040, 0x208 },
+	{ 0x104, 0x820, 0x108 },
+	{ 0x844, 0x210, 0x884 },
+	{ 0x444, 0x110, 0x444 },
+	{ 0x122, 0x888, 0x224 },
+	{ 0x912, 0x448, 0x924 },
+	{ 0x492, 0x248, 0x492 },
+	{ 0x252, 0x928, 0x292 },
+	{ 0x94a, 0x4a4, 0xa52 },
+	{ 0x52a, 0xaa4, 0x54a },
+	{ 0xaaa, 0x954, 0x4aa },
+	{ 0xaaa, 0x554, 0xaaa },
+	{ 0x555, 0xad4, 0x5aa },
+	{ 0xb55, 0xab4, 0x55a },
+	{ 0x6b5, 0x5ac, 0xb56 },
+	{ 0x5b5, 0xd6c, 0x6d6 },
+	{ 0xb6d, 0xb6a, 0xdb6 },
+	{ 0x76d, 0x6da, 0xbb6 },
+	{ 0xedd, 0xdda, 0x76e },
+	{ 0xddd, 0xbba, 0xeee },
+	{ 0x7bb, 0xf7a, 0xdde },
+	{ 0xf7b, 0xef6, 0x7de },
+	{ 0xdf7, 0xbf6, 0xf7e },
+	{ 0x7f7, 0xfee, 0xefe },
+	{ 0xfdf, 0xfbe, 0x7fe },
+	{ 0xf7f, 0xefe, 0xffe },
+	{ 0xfff, 0xffe, 0xffd },
+};
+
+static int xr_set_baudrate(struct tty_struct *tty,
+			   struct usb_serial_port *port)
+{
+	u32 divisor, baud, idx;
+	u16 tx_mask, rx_mask;
+	int ret;
+
+	baud = clamp(tty->termios.c_ospeed, XR21V141X_MIN_SPEED,
+		     XR21V141X_MAX_SPEED);
+	divisor = XR_INT_OSC_HZ / baud;
+	idx = (32 * divisor) & 0x1f;
+	tx_mask = xr21v141x_txrx_clk_masks[idx].tx;
+
+	if (divisor & 1)
+		rx_mask = xr21v141x_txrx_clk_masks[idx].rx1;
+	else
+		rx_mask = xr21v141x_txrx_clk_masks[idx].rx0;
+
+	dev_dbg(&port->dev, "Setting baud rate: %u\n", baud);
+	/*
+	 * XR21V141X uses fractional baud rate generator with 48MHz internal
+	 * oscillator and 19-bit programmable divisor. So theoretically it can
+	 * generate most commonly used baud rates with high accuracy.
+	 */
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_CLOCK_DIVISOR_0, (divisor & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_CLOCK_DIVISOR_1, ((divisor >>  8) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_CLOCK_DIVISOR_2, ((divisor >> 16) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_TX_CLOCK_MASK_0, (tx_mask & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_TX_CLOCK_MASK_1, ((tx_mask >>  8) & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_RX_CLOCK_MASK_0, (rx_mask & 0xff));
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 XR21V141X_RX_CLOCK_MASK_1, ((rx_mask >>  8) & 0xff));
+
+	tty_encode_baud_rate(tty, baud, baud);
+
+	return ret;
+}
+
+/*
+ * According to datasheet, below is the recommended sequence for enabling UART
+ * module in XR21V141X:
+ *
+ * Enable Tx FIFO
+ * Enable Tx and Rx
+ * Enable Rx FIFO
+ */
+static int xr_uart_enable(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
+			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG,
+			 XR21V141X_UART_MANAGER_ENABLE_TX_FIFO);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->enable,
+			 UART_ENABLE_TX | UART_ENABLE_RX);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
+			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG,
+			 XR21V141X_UART_MANAGER_ENABLE_TX_FIFO |
+			 XR21V141X_UART_MANAGER_ENABLE_RX_FIFO);
+
+	return ret;
+}
+
+static int xr_uart_disable(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->enable, 0);
+	if (ret)
+		return ret;
+
+	ret = xr_set_reg(port, XR21V141X_UART_MANAGER_REG_BLOCK,
+			 XR21V141X_UART_MANAGER_FIFO_ENABLE_REG, 0);
+
+	return ret;
+}
+
+static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
+{
+	int ret;
+	struct device *dev = &port->dev;
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	ret = xr_uart_enable(port);
+	if (ret) {
+		dev_err(&port->dev, "Failed to enable UART\n");
+		return ret;
+	}
+
+	/* Setup termios */
+	if (tty)
+		xr_set_termios(tty, port, NULL);
+
+	ret = usb_serial_generic_open(tty, port);
+	if (ret) {
+		dev_err(dev, "usb_serial_generic_open failed: %d\n", ret);
+		xr_uart_disable(port);
+		return ret;
+	}
+
+	port_priv->port_open = true;
+
+	return ret;
+}
+
+static void xr_close(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	usb_serial_generic_close(port);
+	port_priv->port_open = false;
+	xr_uart_disable(port);
+}
+
+static void xr_set_flow_mode(struct tty_struct *tty,
+			     struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	unsigned int cflag = tty->termios.c_cflag;
+	int ret;
+	u8 flow, gpio_mode;
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_mode, &gpio_mode);
+	if (ret)
+		return;
+
+	/*
+	 * RTS/CTS is the default flow control mode, so set GPIO mode
+	 * for controlling the pins manually by default.
+	 */
+	gpio_mode &= ~UART_MODE_GPIO_MASK;
+	if (cflag & CRTSCTS) {
+		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
+		flow = UART_FLOW_MODE_HW;
+		gpio_mode |= UART_MODE_RTS_CTS;
+	} else if (I_IXOFF(tty)) {
+		u8 start_char = START_CHAR(tty);
+		u8 stop_char = STOP_CHAR(tty);
+
+		dev_dbg(&port->dev, "Enabling sw flow ctrl\n");
+		flow = UART_FLOW_MODE_SW;
+
+		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			   port_priv->regs->xon_char, start_char);
+		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			   port_priv->regs->xoff_char, stop_char);
+	} else {
+		dev_dbg(&port->dev, "No flow ctrl\n");
+		flow = UART_FLOW_MODE_NONE;
+	}
+
+	/*
+	 * As per the datasheet, UART needs to be disabled while writing to
+	 * FLOW_CONTROL register.
+	 */
+	xr_uart_disable(port);
+	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->flow_ctrl,
+		   flow);
+	xr_uart_enable(port);
+
+	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->gpio_mode,
+		   gpio_mode);
+}
+
+static void xr_set_termios(struct tty_struct *tty,
+			   struct usb_serial_port *port,
+			   struct ktermios *old_termios)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	struct ktermios *termios = &tty->termios;
+	int ret;
+	u8 bits = 0;
+
+	if (old_termios &&
+	    tty->termios.c_ospeed != old_termios->c_ospeed)
+		xr_set_baudrate(tty, port);
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+	/* fall through */
+	case CS6:
+		dev_warn(&port->dev, "requested CSIZE setting not supported\n");
+
+		/* CS5 and CS6 are not supported, so just restore old setting */
+		termios->c_cflag &= ~CSIZE;
+		if (old_termios)
+			termios->c_cflag |= old_termios->c_cflag & CSIZE;
+		break;
+	case CS7:
+		bits |= UART_DATA_7;
+		break;
+	case CS8:
+	/* fall through */
+	default:
+		bits |= UART_DATA_8;
+		break;
+	}
+
+	if (C_PARENB(tty)) {
+		if (C_CMSPAR(tty)) {
+			if (C_PARODD(tty)) {
+				bits |= (UART_PARITY_MARK <<
+					 UART_PARITY_SHIFT);
+			} else {
+				bits |= (UART_PARITY_SPACE <<
+					 UART_PARITY_SHIFT);
+			}
+		} else {
+			if (C_PARODD(tty)) {
+				bits |= (UART_PARITY_ODD <<
+					 UART_PARITY_SHIFT);
+			} else {
+				bits |= (UART_PARITY_EVEN <<
+					 UART_PARITY_SHIFT);
+			}
+		}
+	}
+
+	if (C_CSTOPB(tty))
+		bits |= (UART_STOP_2 << UART_STOP_SHIFT);
+	else
+		bits |= (UART_STOP_1 << UART_STOP_SHIFT);
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->format, bits);
+	if (ret)
+		return;
+
+	xr_set_flow_mode(tty, port);
+}
+
+static int xr_tiocmset_port(struct usb_serial_port *port,
+			    unsigned int set, unsigned int clear)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret = 0;
+	u8 gpio_set = 0;
+	u8 gpio_clr = 0;
+
+	/* Modem control pins are active low, so set & clr are swapped */
+	if (set & TIOCM_RTS)
+		gpio_clr |= UART_MODE_RTS;
+	if (set & TIOCM_DTR)
+		gpio_clr |= UART_MODE_DTR;
+	if (clear & TIOCM_RTS)
+		gpio_set |= UART_MODE_RTS;
+	if (clear & TIOCM_DTR)
+		gpio_set |= UART_MODE_DTR;
+
+	/* Writing '0' to gpio_{set/clr} bits has no effect, so no need to do */
+	if (gpio_clr) {
+		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+				 port_priv->regs->gpio_clr, gpio_clr);
+	}
+
+	if (gpio_set) {
+		ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+				 port_priv->regs->gpio_set, gpio_set);
+	}
+
+	return ret;
+}
+
+static int xr_tiocmset(struct tty_struct *tty,
+		       unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+
+	return xr_tiocmset_port(port, set, clear);
+}
+
+static int xr_attach(struct usb_serial *serial)
+{
+	/* Do not register tty device for the control interface */
+	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
+		return 1;
+
+	return 0;
+}
+
+static void xr_dtr_rts(struct usb_serial_port *port, int on)
+{
+	if (on)
+		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
+	else
+		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
+}
+
+static int xr_tiocmget(struct tty_struct *tty)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+	u8 status;
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_status, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * Modem control pins are active low, so reading '0' means it is active
+	 * and '1' means not active.
+	 */
+	ret = ((status & UART_MODE_DTR) ? 0 : TIOCM_DTR) |
+	      ((status & UART_MODE_RTS) ? 0 : TIOCM_RTS) |
+	      ((status & UART_MODE_CTS) ? 0 : TIOCM_CTS) |
+	      ((status & UART_MODE_DSR) ? 0 : TIOCM_DSR) |
+	      ((status & UART_MODE_RI) ? 0 : TIOCM_RI) |
+	      ((status & UART_MODE_CD) ? 0 : TIOCM_CD);
+
+	return ret;
+}
+
+static void xr_break_ctl(struct tty_struct *tty, int break_state)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	u8 state;
+
+	if (break_state == 0)
+		state = UART_BREAK_OFF;
+	else
+		state = UART_BREAK_ON;
+
+	dev_dbg(&port->dev, "Turning break %s\n",
+		state == UART_BREAK_OFF ? "off" : "on");
+	xr_set_reg(port, XR21V141X_UART_REG_BLOCK, port_priv->regs->tx_break,
+		   state);
+}
+
+static int xr_port_probe(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv;
+
+	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
+	if (!port_priv)
+		return -ENOMEM;
+
+	/* XR21V141X specific settings */
+	port_priv->regs = &xr21v141x_regs;
+
+	usb_set_serial_port_data(port, port_priv);
+
+	return 0;
+}
+
+static int xr_port_remove(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	kfree(port_priv);
+
+	return 0;
+}
+
+static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x04e2, 0x1410) }, /* XR21V141X */
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static struct usb_serial_driver xr_device = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name =	"xr_serial",
+	},
+	.id_table		= id_table,
+	.num_ports		= 1,
+	.open			= xr_open,
+	.close			= xr_close,
+	.break_ctl		= xr_break_ctl,
+	.set_termios		= xr_set_termios,
+	.tiocmget		= xr_tiocmget,
+	.tiocmset		= xr_tiocmset,
+	.attach			= xr_attach,
+	.port_probe		= xr_port_probe,
+	.port_remove		= xr_port_remove,
+	.dtr_rts		= xr_dtr_rts
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&xr_device, NULL
+};
+
+module_usb_serial_driver(serial_drivers, id_table);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <mani@kernel.org>");
+MODULE_DESCRIPTION("MaxLinear/Exar USB to Serial driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

