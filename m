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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004A321D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOjqfLof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIITeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:34:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16EDC061573;
        Wed,  9 Sep 2020 12:34:44 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l4so3474171ilq.2;
        Wed, 09 Sep 2020 12:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyNnJ/ORWt19mYZwXhNeGZixJ8qXb9id936qJJ9it9Q=;
        b=rOjqfLof+Y/bvSwkGf6kdEjBg9ZUuevrxm1QEsA8ZsmcBDWBCvfY6ts0rZBacwJ5nR
         A49DHNw38JGfZc5aJ9q9JMRgq2NfhZOCHAU5SSmakPsnNcIdi6QHV4Nwj/4Uq4aXqrz4
         tvmbw83UXuPQjGplh36h0/ZzSUd5PIoS3tyIeBsv4ejjGdSfsB+qB4PXz1w+Efaqdzyu
         +Vd9qz/iKwst0AbBCdU8Od68Tdf46KjMRV6MqCSbK4SpDWa9pv4vtuM/KY1LCOp3aF9T
         QQ9RGmWMD5G68cjt2k5WUG42wr4FGQyjbyZ203MsIe7Ta3c3qe1EcV6e/YWl1I3Bw9PO
         zgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HyNnJ/ORWt19mYZwXhNeGZixJ8qXb9id936qJJ9it9Q=;
        b=RttHZc7LjLx0c/FzCnPKZSORFgikWvJIitp0zEpKSeWoSGzTQyntUQS60sp/DO7nBV
         QBx0cJOcJGOWcuM8Mnt/lJanhkL+cG7i9XCHaLuS2Fv923feMVkuoZbSMSg7WvyKhWRL
         mWqAFCssPnQ2p1C3LavAvK5eucf7LFYteWt5YieURyCN/gkT0CkNd3r3kmNrIoL4VfkB
         Ma8jeS/1oSbWPf6uuXPqin7WRCVvVZp6k0aRDQ0Y7mwKH7rZk4ZDxRwsDj5Rm6iOZay8
         /rZWvYX4vvirL5d8z/DPYzCdhDilYbImkjU/vJMevp0hxh3rD1sxI35bDITbsdrePGOO
         TOWA==
X-Gm-Message-State: AOAM530mQM6WJuAem1gs0e9mO7wFxVPnVCp0GnOr20HO5Dtbatx6xKf3
        endXvxpsl00+9gmV56lzucY0iB3oX64=
X-Google-Smtp-Source: ABdhPJyqYBbUKL3KLe68lgpQyTjLs0vfece3S0yXF09QQF/wk3OS87JPRpz1vbKKn9Xvk4HmSS+tXw==
X-Received: by 2002:a05:6e02:ed2:: with SMTP id i18mr3729535ilk.124.1599680079720;
        Wed, 09 Sep 2020 12:34:39 -0700 (PDT)
Received: from james-x399.localdomain (71-218-238-150.hlrn.qwest.net. [71.218.238.150])
        by smtp.gmail.com with ESMTPSA id e4sm1610567iom.14.2020.09.09.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:34:38 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Subject: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
Date:   Wed,  9 Sep 2020 13:34:18 -0600
Message-Id: <20200909193419.2006744-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch detects and reverses the effects of the malicious FTDI
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
Changes v1 -> v2:
  - Move ftdi_read_eeprom and ftdi_write_eeprom outside #ifdef CONFIG_GPIOLIB
---
 drivers/usb/serial/ftdi_sio.c | 181 +++++++++++++++++++++++++++-------
 drivers/usb/serial/ftdi_sio.h |   4 +
 2 files changed, 152 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 871cdccf3a5f..85324e2ea107 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1062,6 +1062,9 @@ static const char *ftdi_chip_name[] = {
 /* function prototypes for a FTDI serial converter */
 static int  ftdi_sio_probe(struct usb_serial *serial,
 					const struct usb_device_id *id);
+static int  ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
+					u16 nbytes);
+static int  ftdi_write_eeprom(struct usb_serial_port *port, u8 addr, u16 data);
 static int  ftdi_sio_port_probe(struct usb_serial_port *port);
 static int  ftdi_sio_port_remove(struct usb_serial_port *port);
 static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port);
@@ -1996,39 +1999,6 @@ static int ftdi_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
 	return result;
 }
 
-static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
-				u16 nbytes)
-{
-	int read = 0;
-
-	if (addr % 2 != 0)
-		return -EINVAL;
-	if (nbytes % 2 != 0)
-		return -EINVAL;
-
-	/* Read EEPROM two bytes at a time */
-	while (read < nbytes) {
-		int rv;
-
-		rv = usb_control_msg(serial->dev,
-				     usb_rcvctrlpipe(serial->dev, 0),
-				     FTDI_SIO_READ_EEPROM_REQUEST,
-				     FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
-				     0, (addr + read) / 2, dst + read, 2,
-				     WDR_TIMEOUT);
-		if (rv < 2) {
-			if (rv >= 0)
-				return -EIO;
-			else
-				return rv;
-		}
-
-		read += rv;
-	}
-
-	return 0;
-}
-
 static int ftdi_gpio_init_ft232h(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -2234,10 +2204,149 @@ static int ftdi_sio_probe(struct usb_serial *serial,
 	return 0;
 }
 
+static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
+				u16 nbytes)
+{
+	int read = 0;
+
+	if (addr % 2 != 0)
+		return -EINVAL;
+	if (nbytes % 2 != 0)
+		return -EINVAL;
+
+	/* Read EEPROM two bytes at a time */
+	while (read < nbytes) {
+		int rv;
+
+		rv = usb_control_msg(serial->dev,
+				     usb_rcvctrlpipe(serial->dev, 0),
+				     FTDI_SIO_READ_EEPROM_REQUEST,
+				     FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
+				     0, (addr + read) / 2, dst + read, 2,
+				     WDR_TIMEOUT);
+		if (rv < 2) {
+			if (rv >= 0)
+				return -EIO;
+			else
+				return rv;
+		}
+
+		read += rv;
+	}
+
+	return 0;
+}
+
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
+	/* Skip if no preimage attack against target address 62 */
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
@@ -2255,6 +2364,12 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
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

