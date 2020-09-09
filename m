Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A172145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gXYo0Fht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIICz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:55:59 -0400
Received: from m12-16.163.com ([220.181.12.16]:57114 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgIICzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:55:53 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 22:55:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=F18fFmXeWeRjmTAsVn
        9Hw6fZGsQLMSIvu+VR4xb46lc=; b=gXYo0FhtfRYvU4N7psfjOxF6ahDA5Iq+1w
        TJ9OvuK/XJuKwtCTKhTX2x5+MHi+uADJYJ1TpWDNeDcRKOnurEMR0iEM6LgVw0Iw
        483xEq+TKC8QgrxniDr0f3B6Y7dBm3toQmKfmuWj4YxsggzYVpnmN/4x8MNPRNQ4
        B805H/3FE=
Received: from localhost.localdomain (unknown [222.211.191.110])
        by smtp12 (Coremail) with SMTP id EMCowACXmCyVQFhfurHUUg--.29631S4;
        Wed, 09 Sep 2020 10:40:23 +0800 (CST)
From:   Sheng Long Wang <china_shenglong@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: [PATCH v4] usb-serial:cp210x: add support to software flow control
Date:   Wed,  9 Sep 2020 10:39:30 +0800
Message-Id: <20200909023931.19530-1-china_shenglong@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowACXmCyVQFhfurHUUg--.29631S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF45Jw18Jr45Gw48Jr1kXwb_yoW7KryrpF
        48trWFyrWqva17Wa1rAF4UZwnxZan7XFyIyFW3G39ayr13Jr1fKF1Ika4Yyr1UArW8Gry5
        Jrn0yayDuF4jqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6OJnUUUUU=
X-Originating-IP: [222.211.191.110]
X-CM-SenderInfo: xfkl0tpbvkv0xjor0wi6rwjhhfrp/xtbBdReaslaD8hrIWgAAsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Sheng Long <shenglong.wang.ext@siemens.com>

When data is transmitted between two serial ports,
the phenomenon of data loss often occurs. The two kinds
of flow control commonly used in serial communication
are hardware flow control and software flow control.

In serial communication, If you only use RX/TX/GND Pins, you
can't do hardware flow. So we often used software flow control
and prevent data loss. The user sets the software flow control
through the application program, and the application program
sets the software flow control mode for the serial port
chip through the driver.

For the cp210 serial port chip, its driver lacks the
software flow control setting code, so the user cannot set
the software flow control function through the application
program. This adds the missing software flow control.

Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>

Changes in v3:
- fixed code style, It mainly adjusts the code style acccording
  to kernel specification.

Changes in v4:
- It mainly adjusts the patch based on the last usb-next branch
  of the usb-serial and optimized the relevant code.
---
 drivers/usb/serial/cp210x.c | 125 ++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d0c05aa8a0d6..bcbf8da99ebb 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -412,6 +412,15 @@ struct cp210x_comm_status {
 	u8       bReserved;
 } __packed;
 
+struct cp210x_special_chars {
+	u8	bEofChar;
+	u8	bErrorChar;
+	u8	bBreakChar;
+	u8	bEventChar;
+	u8	bXonChar;
+	u8	bXoffChar;
+};
+
 /*
  * CP210X_PURGE - 16 bits passed in wValue of USB request.
  * SiLabs app note AN571 gives a strange description of the 4 bits:
@@ -675,6 +684,69 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	return result;
 }
 
+static int cp210x_get_chars(struct usb_serial_port *port, void *buf, int bufsize)
+{
+	struct usb_serial *serial = port->serial;
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	void *dmabuf;
+	int result;
+
+	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				usb_sndctrlpipe(serial->dev, 0),
+				CP210X_GET_CHARS, REQTYPE_DEVICE_TO_HOST, 0,
+				port_priv->bInterfaceNumber,
+				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);
+
+	if (result == bufsize) {
+		memcpy(buf, dmabuf, bufsize);
+		result = 0;
+	} else {
+		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
+			CP210X_GET_CHARS, bufsize, result);
+		if (result >= 0)
+			result = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return result;
+}
+
+static int cp210x_set_chars(struct usb_serial_port *port, void *buf, int bufsize)
+{
+	struct usb_serial *serial = port->serial;
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+	void *dmabuf;
+	int result;
+
+	dmabuf = kmemdup(buf, bufsize, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				usb_sndctrlpipe(serial->dev, 0),
+				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
+				port_priv->bInterfaceNumber,
+				dmabuf, bufsize, USB_CTRL_SET_TIMEOUT);
+
+	if (result == bufsize) {
+		result = 0;
+	} else {
+		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
+			CP210X_SET_CHARS, bufsize, result);
+		if (result >= 0)
+			result = -EIO;
+	}
+
+	kfree(dmabuf);
+
+	return result;
+}
+
 /*
  * Writes any 16-bit CP210X_ register (req) whose value is passed
  * entirely in the wValue field of the USB request.
@@ -1356,11 +1428,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct device *dev = &port->dev;
-	unsigned int cflag, old_cflag;
+	unsigned int cflag, old_cflag, iflag;
+	struct cp210x_special_chars charsres;
+	struct cp210x_flow_ctl flow_ctl;
 	u16 bits;
+	int result;
+	u32 ctl_hs;
+	u32 flow_repl;
 
 	cflag = tty->termios.c_cflag;
 	old_cflag = old_termios->c_cflag;
+	iflag = tty->termios.c_iflag;
 
 	if (tty->termios.c_ospeed != old_termios->c_ospeed)
 		cp210x_change_speed(tty, port, old_termios);
@@ -1434,10 +1512,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	}
 
 	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
-		struct cp210x_flow_ctl flow_ctl;
-		u32 ctl_hs;
-		u32 flow_repl;
-
 		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 				sizeof(flow_ctl));
 		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
@@ -1474,6 +1548,47 @@ static void cp210x_set_termios(struct tty_struct *tty,
 				sizeof(flow_ctl));
 	}
 
+	if ((iflag & IXOFF) || (iflag & IXON)) {
+
+		result = cp210x_get_chars(port, &charsres, sizeof(charsres));
+		if (result < 0)
+			dev_err(dev, "failed to get character: %d\n", result);
+
+		charsres.bXonChar  = START_CHAR(tty);
+		charsres.bXoffChar = STOP_CHAR(tty);
+
+		result = cp210x_set_chars(port, &charsres, sizeof(charsres));
+		if (result < 0)
+			dev_err(dev, "failed to set character: %d\n", result);
+
+		result = cp210x_read_reg_block(port,
+					CP210X_GET_FLOW,
+					&flow_ctl,
+					sizeof(flow_ctl));
+		if (result)
+			dev_err(dev, "failed to read flow_ctl reg: %d\n", result);
+
+		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
+
+		if (iflag & IXOFF)
+			flow_repl |= CP210X_SERIAL_AUTO_RECEIVE;
+		else
+			flow_repl &= ~CP210X_SERIAL_AUTO_RECEIVE;
+
+		if (iflag & IXON)
+			flow_repl |= CP210X_SERIAL_AUTO_TRANSMIT;
+		else
+			flow_repl &= ~CP210X_SERIAL_AUTO_TRANSMIT;
+
+		flow_ctl.ulFlowReplace = cpu_to_le32(flow_repl);
+		result = cp210x_write_reg_block(port,
+					CP210X_SET_FLOW,
+					&flow_ctl,
+					sizeof(flow_ctl));
+		if (result)
+			dev_err(dev, "failed to write flow_ctl reg: %d\n", result);
+	}
+
 	/*
 	 * Enable event-insertion mode only if input parity checking is
 	 * enabled for now.
-- 
2.17.1


