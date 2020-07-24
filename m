Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDA1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F8E2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="STmmjqhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGXKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:30:41 -0400
Received: from m12-17.163.com ([220.181.12.17]:58917 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGXKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4dflDOrAqQmVXppU0j
        BwTka3UlUGFsKY0391HvT87Vg=; b=STmmjqhUEUE4byWnDgdfvbGHe3zy23AWd0
        M0uJTAUn7fzKZ1lR6wygFZCvOqFo7ZRjvMXH3V6VyVF0Scsf8NVrar0+opiz6C+9
        726S7Mis+gTWY1O58lVVjUdBdLA0d7l3dYF5uACfyQi5UuSx/b8Vp4434u81WxnB
        GI9ANeDPw=
Received: from localhost.localdomain (unknown [118.113.11.27])
        by smtp13 (Coremail) with SMTP id EcCowABnOLQhuBpf+hZ9AA--.62427S4;
        Fri, 24 Jul 2020 18:29:54 +0800 (CST)
From:   Sheng Long Wang <china_shenglong@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: [PATCH] usb-serial:cp210x: add CP210x support to software flow control
Date:   Fri, 24 Jul 2020 18:29:46 +0800
Message-Id: <20200724102946.15404-1-china_shenglong@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowABnOLQhuBpf+hZ9AA--.62427S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4DtFW8JF43tr4DAF45Awb_yoW7uF48pF
        4Utay3tFWqvr47Wa1rAF4Uu39xuan7XryIvFy3G39aya13Krn3KF18Ca4Yvr1UAa4xGry5
        Jrs8t3yUuw4UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bFnQUUUUUU=
X-Originating-IP: [118.113.11.27]
X-CM-SenderInfo: xfkl0tpbvkv0xjor0wi6rwjhhfrp/1tbiyQJrslQHKutUlgAAsC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Sheng Long <shenglong.wang.ext@siemens.com>

  The cp210x driver lacks soft-flow function,so need and
  this function.

Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
---
 drivers/usb/serial/cp210x.c | 110 +++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index e732949f65..ad5db0e2ae 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -380,6 +380,9 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CP210X_PARTNUM_CP2102N_QFN20	0x22
 #define CP210X_PARTNUM_UNKNOWN	0xFF
 
+#define CP210X_VSTART  0x11
+#define CP210X_VSTOP   0x13
+
 /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
 struct cp210x_comm_status {
 	__le32   ulErrors;
@@ -391,6 +394,15 @@ struct cp210x_comm_status {
 	u8       bReserved;
 } __packed;
 
+struct cp210x_chars_respones{
+	u8       bEofchar;
+	u8       bErrochar;
+	u8       bBreakchar;
+	u8       bEventchar;
+	u8       bXonchar;
+	u8       bXoffchar;
+} __packed;
+
 /*
  * CP210X_PURGE - 16 bits passed in wValue of USB request.
  * SiLabs app note AN571 gives a strange description of the 4 bits:
@@ -624,6 +636,43 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
 	return result;
 }
 
+/*
+ * Read and Write Characrters Respones operate
+ * Register SET_CHARS/GET_CHATS
+ */
+static int cp210x_operate_chars_block(struct usb_serial_port *port, u8 req, u8 type,
+		void *buf, int bufsize)
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
+	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
+			req, type, 0, port_priv->bInterfaceNumber, dmabuf, bufsize,
+			USB_CTRL_SET_TIMEOUT);
+	if (result == bufsize) {
+		if (type == REQTYPE_DEVICE_TO_HOST)
+			memcpy(buf, dmabuf, bufsize);
+
+		result = 0;
+	} else {
+		dev_err(&port->dev, "failed get req 0x%x size %d status: %d\n",
+				req, bufsize, result);
+		if (result >= 0)
+			result = -EIO;
+
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
@@ -650,8 +699,8 @@ static int cp210x_write_u16_reg(struct usb_serial_port *port, u8 req, u16 val)
  * Writes a variable-sized block of CP210X_ registers, identified by req.
  * Data in buf must be in native USB byte order.
  */
-static int cp210x_write_reg_block(struct usb_serial_port *port, u8 req,
-		void *buf, int bufsize)
+static int cp210x_write_reg_block(struct usb_serial_port *port,
+				u8 req, void *buf, int bufsize)
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
@@ -1134,11 +1183,17 @@ static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
 	struct device *dev = &port->dev;
-	unsigned int cflag, old_cflag;
+	struct cp210x_chars_respones CharsRes;
+	struct cp210x_flow_ctl flow_ctl;
+	unsigned int cflag, old_cflag, iflag;
 	u16 bits;
+	int result;
+	u32 ctl_hs;
+	u32 flow_repl;
 
 	cflag = tty->termios.c_cflag;
 	old_cflag = old_termios->c_cflag;
+	iflag = tty->termios.c_iflag;
 
 	if (tty->termios.c_ospeed != old_termios->c_ospeed)
 		cp210x_change_speed(tty, port, old_termios);
@@ -1212,10 +1267,6 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	}
 
 	if ((cflag & CRTSCTS) != (old_cflag & CRTSCTS)) {
-		struct cp210x_flow_ctl flow_ctl;
-		u32 ctl_hs;
-		u32 flow_repl;
-
 		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl,
 				sizeof(flow_ctl));
 		ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
@@ -1252,6 +1303,51 @@ static void cp210x_set_termios(struct tty_struct *tty,
 				sizeof(flow_ctl));
 	}
 
+	/* Set Software  Flow  Control
+	 * Xon/Xoff code
+	 * Check the IXOFF/IXON status in the iflag component of the
+	 * termios structure.
+	 *
+	 */
+	if  ((iflag & IXOFF) || (iflag & IXON)) {
+		/*set vstart/vstop chars */
+		result = cp210x_operate_chars_block(port, CP210X_GET_CHARS,
+					  REQTYPE_DEVICE_TO_HOST, &CharsRes, sizeof(CharsRes));
+		dev_dbg(dev, "%s -  bXonchar=0x%x   bXoffchar=0x%x   \n",
+				__func__, CharsRes.bXonchar, CharsRes.bXoffchar);
+		if (result < 0) {
+			dev_err(dev, "Read Characrters Respones  failed "
+					"xon/xoff software flow control\n");
+			return;
+		}
+		CharsRes.bXonchar  = CP210X_VSTART;
+		CharsRes.bXoffchar = CP210X_VSTOP;
+		result = cp210x_operate_chars_block(port, CP210X_SET_CHARS,
+					 REQTYPE_HOST_TO_INTERFACE, &CharsRes, sizeof(CharsRes));
+		if (result < 0) {
+			memset(&CharsRes, 0, sizeof(CharsRes));
+			dev_err(dev, "Write Characrters Respones  failed"
+					"xon/xoff software flow control\n");
+			return;
+		}
+		/*Set  Rx/Tx Flow Contrl  Flag in ulFlowReplace*/
+		cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl, sizeof(flow_ctl));
+		flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
+		dev_dbg(dev, "%s - read ulControlHandshake=0x%08x, ulFlowReplace=0x%08x\n",
+				__func__, ctl_hs, flow_repl);
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
+		cp210x_write_reg_block(port, CP210X_SET_FLOW, &flow_ctl, sizeof(flow_ctl));
+       }
 }
 
 static int cp210x_tiocmset(struct tty_struct *tty,
-- 
2.17.1


