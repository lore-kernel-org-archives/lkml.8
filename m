Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8002177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV2KhJ9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgIHGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgIHGgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:36:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D246C061755;
        Mon,  7 Sep 2020 23:36:16 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w5so6418576ilo.5;
        Mon, 07 Sep 2020 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGqCKR+oi7f83mYcMwbSlRNW02PpemrpYhf3i5/jzuk=;
        b=pV2KhJ9SrtmvbmUsAtr12ux66l1lf2l1xIIR7iWMPEtJg/V5E7J+tpgdAyLBXGAjze
         pJm7vS13OQSHj7Q8yV8mXipXHc3PrAThoQtDL8prqMGJAp/cZvhFbJ5pn3v9NSk6JNOI
         fSEP+EMs6wV5Gumgebx/YEizGrvOh+tzvD3o2E+2a3O7ZQ51WvDZHhRhw0THZc+RqgA1
         tjEve8VLOrW5yNLxIYz9BcgTIc7OwBLqEewl90tbTbTp9REBV966xz+9VnVvQ2Ztwbkd
         wqLL+GjPhj+mrC9Kf1VfAmKBq8OrmXaBqNQcRz7pjJImt+a4HZWxFrJ6H9E90/GtcoJ3
         iXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PGqCKR+oi7f83mYcMwbSlRNW02PpemrpYhf3i5/jzuk=;
        b=E4knjikESt8WvnurtQXTTWIXczCr/HJ7x9rS/dIAlKyxb/NFDGG3q8n6xa289kINWa
         JOa9dg2Js+4yOiJUI1zNCmuUj4n9gi9yevh/MGFuPIEAlv8Z3b98zgZ8C41K7RLk7KMK
         g2JRsoQq46xiiFgIciNeKTujljdMWF/GzR+jmhN3ONtPZYGXURsRXGUHsv8BDUYT0myt
         9UEL5ZxVf/we6w75dmQOFWr9OeEw3cqF/CWAsiW28Hcs6ANpqDcFT8YTLzo1CjbHPG3C
         zsIYCBzBrsLvukFTI3AClH831gjqRz/Z9rLBU0041JCTTKdcEroQyVjA4JfHz+67zFGf
         bD6Q==
X-Gm-Message-State: AOAM533XX6j1Q+swuVdRX7BTH2Fqx4bsZxxua0EUVLbrgZWYb3u0wnAX
        QRzEz5ofHdtywR3MSV7PjzEiraRKA64=
X-Google-Smtp-Source: ABdhPJyywHMU5J1meOxViJPUjSThzVAlURHRxBO5Lg6H7Nu6CjX2zr0HrDy55LVpcNYfDaogYfIz5w==
X-Received: by 2002:a92:9992:: with SMTP id t18mr22908981ilk.170.1599546974392;
        Mon, 07 Sep 2020 23:36:14 -0700 (PDT)
Received: from james-x399.localdomain (71-218-238-150.hlrn.qwest.net. [71.218.238.150])
        by smtp.gmail.com with ESMTPSA id i10sm1350814ioi.39.2020.09.07.23.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:36:13 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Subject: [PATCH] usb: serial: Repair FTDI FT232R bricked eeprom
Date:   Tue,  8 Sep 2020 00:36:09 -0600
Message-Id: <20200908063609.2817032-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch detects end reverses the effects of the malicious FTDI
Windows driver version 2.12.00(FTDIgate).

While we currently load the ftdi_sio driver for devices with
FTDI_BRICK_PID(0x0000) userspace applications that expect the
appropriate FTDI_8U232AM_PID(0x6001) PID may not work properly.

Since the malicious FTDI driver modifies the PID without modifying
the normal checksum field we can detect and limit the unbricking
to devices that were bricked specifically using the FTDI checksum
preimage attack technique used by the official Windows drivers.

This should have no effect on devices where the PID was deliberately
set to FTDI_BRICK_PID(0x0000) as the checksum would normally change
and the preimage target(address 62) should be 0. We validate that
the preimage target is not 0 before attempting to unbrick.

Since we only write to even addresses this should have no effect at
all on non-counterfeit FTDI hardware due to the hardware only
committing EEPROM writes when odd addresses are written.

References:
https://marcan.st/transf/detect_ftdi_clone.py
https://hackaday.com/2014/10/22/watch-that-windows-update-ftdi-drivers-are-killing-fake-chips/
https://www.eevblog.com/forum/reviews/ftdi-driver-kills-fake-ftdi-ft232/msg535270/#msg535270
https://lkml.org/lkml/2014/10/23/266
https://lore.kernel.org/patchwork/patch/509929/
https://lore.kernel.org/patchwork/patch/510097/

Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Cc: Hector Martin <hector@marcansoft.com>
---
 drivers/usb/serial/ftdi_sio.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio.h |   4 ++
 2 files changed, 116 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 871cdccf3a5f..39fc14af6185 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2029,6 +2029,22 @@ static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
 	return 0;
 }
 
+static int ftdi_write_eeprom(struct usb_serial_port *port, u8 addr, u16 data)
+{
+	struct usb_device *udev = port->serial->dev;
+	int rv;
+
+	rv = usb_control_msg(udev,
+			     usb_sndctrlpipe(udev, 0),
+			     FTDI_SIO_WRITE_EEPROM_REQUEST,
+			     FTDI_SIO_WRITE_EEPROM_REQUEST_TYPE,
+			     data, addr,
+			     NULL, 0, WDR_TIMEOUT);
+	if (rv < 0)
+		dev_err(&port->dev, "Unable to write EEPROM: %i\n", rv);
+	return rv;
+}
+
 static int ftdi_gpio_init_ft232h(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -2234,10 +2250,100 @@ static int ftdi_sio_probe(struct usb_serial *serial,
 	return 0;
 }
 
+static u16 ftdi_checksum(u16 *data, int n)
+{
+	u16 checksum;
+	int i;
+
+	checksum = 0xaaaa;
+	for (i = 0; i < n - 1; i++) {
+		checksum ^= be16_to_cpu(data[i]);
+		checksum = (checksum << 1) | (checksum >> 15);
+	}
+
+	return cpu_to_be16(checksum);
+}
+
+static int ftdi_repair_brick(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int orig_latency;
+	int rv;
+	u16 *eeprom_data;
+	u16 checksum;
+	int eeprom_size;
+	int result;
+
+	switch (priv->chip_type) {
+	case FT232RL:
+		eeprom_size = 0x40;
+		break;
+	default:
+		/* Unsupported for brick repair */
+		return 0;
+	}
+
+	/* Latency timer needs to be 0x77 to unlock EEPROM programming */
+	if (priv->latency != 0x77) {
+		orig_latency = priv->latency;
+		priv->latency = 0x77;
+		rv = write_latency_timer(port);
+		priv->latency = orig_latency;
+		if (rv < 0)
+			return -EIO;
+	}
+
+	eeprom_data = kmalloc(eeprom_size * 2, GFP_KERNEL);
+	if (!eeprom_data)
+		return -ENOMEM;
+
+	/* Read in EEPROM */
+	result = ftdi_read_eeprom(port->serial, eeprom_data, 0x00, eeprom_size * 2);
+	if (result < 0)
+		goto end_repair_brick;
+
+	/* Verify EEPROM is valid */
+	checksum = ftdi_checksum(eeprom_data, eeprom_size);
+	if (checksum != eeprom_data[eeprom_size - 1])
+		goto end_repair_brick;
+
+	/* FTDI driver checksum preimage attack targets address 62 */
+	if (eeprom_data[62] == 0)
+		goto end_repair_brick;
+
+	/* Attempt to restore Product ID to 0x6001 */
+	eeprom_data[2] = FTDI_8U232AM_PID;
+
+	/* Clear preimage attack target address */
+	eeprom_data[62] = 0;
+
+	/* Calculate and verify new checksum */
+	checksum = ftdi_checksum(eeprom_data, eeprom_size);
+	if (checksum != eeprom_data[eeprom_size - 1])
+		goto end_repair_brick;
+
+	/* Restore EEPROM PID to original pre-brick state */
+	if (ftdi_write_eeprom(port, 2, eeprom_data[2]) < 0)
+		goto end_repair_brick;
+
+	/* Restore EEPROM preimage target address to original pre-brick state */
+	if (ftdi_write_eeprom(port, 62, eeprom_data[62]) < 0)
+		goto end_repair_brick;
+
+	dev_info(&port->dev, "Successfully repaired eeprom bricked by FTDI's malicious Windows driver.\n");
+
+end_repair_brick:
+	kfree(eeprom_data);
+
+	return result;
+}
+
 static int ftdi_sio_port_probe(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv;
 	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
+	u16 vendor_id;
+	u16 product_id;
 	int result;
 
 	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
@@ -2255,6 +2361,12 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	ftdi_set_max_packet_size(port);
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
+	vendor_id = le16_to_cpu(port->serial->dev->descriptor.idVendor);
+	product_id = le16_to_cpu(port->serial->dev->descriptor.idProduct);
+	if (vendor_id == FTDI_VID &&
+		product_id == FTDI_BRICK_PID &&
+		priv->chip_type == FT232RL)
+		ftdi_repair_brick(port);
 	write_latency_timer(port);
 	create_sysfs_attrs(port);
 
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index be1641e0408b..40c6c4372a34 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -39,6 +39,7 @@
 #define FTDI_SIO_SET_BITMODE		0x0b /* Set bitbang mode */
 #define FTDI_SIO_READ_PINS		0x0c /* Read immediate value of pins */
 #define FTDI_SIO_READ_EEPROM		0x90 /* Read EEPROM */
+#define FTDI_SIO_WRITE_EEPROM		0x91 /* Write EEPROM */
 
 /* Interface indices for FT2232, FT2232H and FT4232H devices */
 #define INTERFACE_A		1
@@ -457,6 +458,9 @@ enum ftdi_sio_baudrate {
 #define FTDI_SIO_READ_EEPROM_REQUEST_TYPE 0xc0
 #define FTDI_SIO_READ_EEPROM_REQUEST FTDI_SIO_READ_EEPROM
 
+#define FTDI_SIO_WRITE_EEPROM_REQUEST_TYPE 0x40
+#define FTDI_SIO_WRITE_EEPROM_REQUEST FTDI_SIO_WRITE_EEPROM
+
 #define FTDI_FTX_CBUS_MUX_GPIO		0x8
 #define FTDI_FT232R_CBUS_MUX_GPIO	0xa
 
-- 
2.25.1

