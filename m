Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19605C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD08E20723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV1tCEjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFGQIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:08:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC4C08C5C5
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:08:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so6087839pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=85AbGi9fTcBRS9rJ1LbFriCr652B+ElOdhlmIsvw78I=;
        b=mV1tCEjtK2WfwbkjMn+O9/leokFKWa4AZ3IgcLqJqduK/fMmC9hS7wX/Hr+J8ts3H7
         xSmUBhnn4oAKxx7G3iCx8WYCr6o1Fq3Hv3S9EC+MGpG1xz6gS1BENk5k0K9gZu039+Mk
         YgyLG5hrPFC6fECDn3rv/9qDgBnW+bdvpRv/j9QlybA/OU9bzAkLUfBmr4Q39pYs0nB+
         Gl0v8ZajwaKcoidO/Cu2q58A+jJPdH3humlPnhJcDCTiYiu7nIGgFqdocBRTzLAGUQNt
         ZypWJpVocWAXS9n7xtH3YKdcU/KPAmTpvWTS6PYUtD4Ty16l1XZ4QYqPVO2O9B+aTb+r
         kG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=85AbGi9fTcBRS9rJ1LbFriCr652B+ElOdhlmIsvw78I=;
        b=NRsD+1odvgow7lsYeZue2DJBA25nQ2zQ+jFTrQK5Vtu4NRZlRqY7OP4hIT4rNEAWnJ
         AHuN/gPWsS3LORa54lrS0s+SHyoltO4zwaUUWICJ/C6qfKX5CmUUncd+UfxaJDuxblyW
         A7Iz7ja3yh+CjExWKNDPZW+lkabkUGSLuQ1nQjJJlV0fmy5ZAHKF36NarYFXGrRTdX4j
         mEhKxGi96k/R54dt0tP/z/EDFYhHzwjoV1mCnq7xq8OT2iRk/y12+mAdt3UgPEuJz1T4
         EIEMdGWvakv3OoUOlK8lC8FqDmfFYH0izeexoRAa8nvytCNpbUscRMpjHr12qX5nI1YK
         dx8w==
X-Gm-Message-State: AOAM532jgf96AyhJJjOcfBjtdjSD6sOUcUY3cqoHlQ8H/wk+mPHm/CTr
        EVRTwi1c4uI3mO+Lgu8C0hC/
X-Google-Smtp-Source: ABdhPJyoJrIzaCh/9XI3Un7SpZfUxgSnOl2+Hf6dHRKZYYKl7kZ2V3dTHDUBCiQFvoYlmJPgSURAaw==
X-Received: by 2002:a63:5a66:: with SMTP id k38mr16840647pgm.240.1591546110573;
        Sun, 07 Jun 2020 09:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e9a:8b0a:3d5e:1902:f17d:d125])
        by smtp.gmail.com with ESMTPSA id r202sm4739449pfr.185.2020.06.07.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 09:08:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/3] usb: serial: xr_serial: Add gpiochip support
Date:   Sun,  7 Jun 2020 21:38:08 +0530
Message-Id: <20200607160809.20192-3-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200607160809.20192-1-mani@kernel.org>
References: <20200607160809.20192-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpiochip support for Maxlinear/Exar USB to serial converter
for controlling the available gpios.

Inspired from cp210x usb to serial converter driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/usb/serial/xr_serial.c | 209 ++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index bb7df79cc129..2240fbc9ea7f 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -10,6 +10,7 @@
  * Copyright (c) 2020 Manivannan Sadhasivam <mani@kernel.org>
  */
 
+#include <linux/gpio/driver.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -17,6 +18,18 @@
 #include <linux/usb.h>
 #include <linux/usb/serial.h>
 
+#ifdef CONFIG_GPIOLIB
+enum gpio_pins {
+	GPIO_RI = 0,
+	GPIO_CD,
+	GPIO_DSR,
+	GPIO_DTR,
+	GPIO_CTS,
+	GPIO_RTS,
+	GPIO_MAX,
+};
+#endif
+
 static void xr_set_termios(struct tty_struct *tty,
 			   struct usb_serial_port *port,
 			   struct ktermios *old_termios);
@@ -39,6 +52,11 @@ struct xr_uart_regs {
 };
 
 struct xr_port_private {
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gc;
+	bool gpio_registered;
+	enum gpio_pins pin_status[GPIO_MAX];
+#endif
 	const struct xr_uart_regs *regs;
 	bool port_open;
 };
@@ -390,6 +408,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	 */
 	gpio_mode &= ~UART_MODE_GPIO_MASK;
 	if (cflag & CRTSCTS) {
+#ifdef CONFIG_GPIOLIB
+		/* Check if the CTS/RTS pins are occupied */
+		if (port_priv->pin_status[GPIO_RTS] ||
+		    port_priv->pin_status[GPIO_CTS])
+			return;
+#endif
+
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
 		flow = UART_FLOW_MODE_HW;
 		gpio_mode |= UART_MODE_RTS_CTS;
@@ -497,6 +522,17 @@ static int xr_tiocmset_port(struct usb_serial_port *port,
 	u8 gpio_set = 0;
 	u8 gpio_clr = 0;
 
+#ifdef CONFIG_GPIOLIB
+	/* Check if the RTS/DTR pins are occupied */
+	if (set & TIOCM_RTS || clear & TIOCM_RTS)
+		if (port_priv->pin_status[GPIO_RTS])
+			return -EBUSY;
+
+	if (set & TIOCM_DTR || clear & TIOCM_DTR)
+		if (port_priv->pin_status[GPIO_DTR])
+			return -EBUSY;
+#endif
+
 	/* Modem control pins are active low, so set & clr are swapped */
 	if (set & TIOCM_RTS)
 		gpio_clr |= UART_MODE_RTS;
@@ -589,9 +625,175 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 		   state);
 }
 
+#ifdef CONFIG_GPIOLIB
+
+static int xr_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	/*
+	 * Do not proceed if the port is open. This is done to avoid changing
+	 * the GPIO configuration used by the serial driver.
+	 */
+	if (port_priv->port_open)
+		return -EBUSY;
+
+	/* Mark the GPIO pin as busy */
+	port_priv->pin_status[offset] = true;
+
+	return 0;
+}
+
+static void xr_gpio_free(struct gpio_chip *gc, unsigned int offset)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	/* Mark the GPIO pin as free */
+	port_priv->pin_status[offset] = false;
+}
+
+static int xr_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+	u8 gpio_status;
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_status, &gpio_status);
+	if (ret)
+		return ret;
+
+	return !!(gpio_status & BIT(gpio));
+}
+
+static void xr_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	if (val)
+		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			   port_priv->regs->gpio_set, BIT(gpio));
+	else
+		xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			   port_priv->regs->gpio_clr, BIT(gpio));
+}
+
+static int xr_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+	u8 gpio_dir;
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_dir, &gpio_dir);
+	if (ret)
+		return ret;
+
+	/* Logic 0 = input and Logic 1 = output */
+	return !(gpio_dir & BIT(gpio));
+}
+
+static int xr_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+	u8 gpio_dir;
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_dir, &gpio_dir);
+	if (ret)
+		return ret;
+
+	gpio_dir &= ~BIT(gpio);
+
+	return xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			  port_priv->regs->gpio_dir, gpio_dir);
+}
+
+static int xr_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
+				    int val)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret;
+	u8 gpio_dir;
+
+	xr_gpio_set(gc, gpio, val);
+
+	ret = xr_get_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_dir, &gpio_dir);
+	if (ret)
+		return ret;
+
+	gpio_dir |= BIT(gpio);
+
+	ret = xr_set_reg(port, XR21V141X_UART_REG_BLOCK,
+			 port_priv->regs->gpio_dir, gpio_dir);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int xr_gpio_init(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+	int ret = 0;
+
+	port_priv->gc.ngpio = 6;
+	port_priv->gc.label = "xr_gpios";
+	port_priv->gc.request = xr_gpio_request;
+	port_priv->gc.free = xr_gpio_free;
+	port_priv->gc.get_direction = xr_gpio_direction_get;
+	port_priv->gc.direction_input = xr_gpio_direction_input;
+	port_priv->gc.direction_output = xr_gpio_direction_output;
+	port_priv->gc.get = xr_gpio_get;
+	port_priv->gc.set = xr_gpio_set;
+	port_priv->gc.owner = THIS_MODULE;
+	port_priv->gc.parent = &port->dev;
+	port_priv->gc.base = -1;
+	port_priv->gc.can_sleep = true;
+
+	ret = gpiochip_add_data(&port_priv->gc, port);
+	if (!ret)
+		port_priv->gpio_registered = true;
+
+	return ret;
+}
+
+static void xr_gpio_remove(struct usb_serial_port *port)
+{
+	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
+
+	if (port_priv->gpio_registered) {
+		gpiochip_remove(&port_priv->gc);
+		port_priv->gpio_registered = false;
+	}
+}
+
+#else
+
+static int xr_gpio_init(struct usb_serial_port *port)
+{
+	return 0;
+}
+
+static void xr_gpio_remove(struct usb_serial_port *port)
+{
+}
+
+#endif
+
 static int xr_port_probe(struct usb_serial_port *port)
 {
 	struct xr_port_private *port_priv;
+	int ret;
 
 	port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
 	if (!port_priv)
@@ -602,13 +804,18 @@ static int xr_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, port_priv);
 
-	return 0;
+	ret = xr_gpio_init(port);
+	if (ret)
+		kfree(port_priv);
+
+	return ret;
 }
 
 static int xr_port_remove(struct usb_serial_port *port)
 {
 	struct xr_port_private *port_priv = usb_get_serial_port_data(port);
 
+	xr_gpio_remove(port);
 	kfree(port_priv);
 
 	return 0;
-- 
2.17.1

