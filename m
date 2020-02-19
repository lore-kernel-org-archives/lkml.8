Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D162C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B92465A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f/+P0S8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBSAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:21:00 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42544 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbgBSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23916C00A0;
        Wed, 19 Feb 2020 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582071650; bh=wRaHT6OlsAkBw+1g6iSX8HH400srvvpxsxuJTkRgCvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=f/+P0S8VgEGpfYNSAGkhdi19uDzy08MkSLKyxwHR5cSMOUixTc9U1Jc15m92Jyaeb
         CBDUV+rzIdoNjxPH9zaX90K64a3vqKn2b6nMWa02Y4FUxUl6oC92XHTysFCFfkHs7K
         uvkoP+Dw86Hn8AEINxMQk4aerrujUXyJVgAD3kPLWl7QyXiT9xHWeBH4J1dS//jZSr
         QxvwuywjPYhG7sKbgIETQTv/VPB6SimRr3BSlseH4NBxFg8+Oeds/Y+rOIupCkjHlN
         e92W7kYmJXfutNVgq5yxedN6BIiJnx0eG48Fp/ZVRfDGSqmcD5IcFX+fMmyaF5No3O
         2Y+XkrXl3cmhA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9EA83A007D;
        Wed, 19 Feb 2020 00:20:47 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 4FFBC3D255;
        Wed, 19 Feb 2020 01:20:47 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        corbet@lwn.net, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 5/5] add i3cdev documentation
Date:   Wed, 19 Feb 2020 01:20:43 +0100
Message-Id: <a6f65d23947070f52c43fee4a1427745ea675ae0.1582069402.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add documentation for the userspace API of i3cdev module.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 Documentation/userspace-api/i3c/i3cdev.rst | 116 +++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst

diff --git a/Documentation/userspace-api/i3c/i3cdev.rst b/Documentation/userspace-api/i3c/i3cdev.rst
new file mode 100644
index 0000000..ada269f
--- /dev/null
+++ b/Documentation/userspace-api/i3c/i3cdev.rst
@@ -0,0 +1,116 @@
+====================
+I3C Device Interface
+====================
+
+I3C devices have the flexibility of being accessed from userspace, as well
+through the conventional use of kernel drivers. Userspace access, although
+limited to private SDR I3C transfers, provides the advantage of simplifying
+the implementation of straightforward communication protocols, applicable to
+scenarios where transfers are dedicated such for sensor bring-up scenarios
+(prototyping environments) or for microcontroller slave communication
+implementation.
+
+The major device number is dynamically attributed and it's all reserved for
+the i3c devices. By default, the i3cdev module only exposes the i3c devices
+without device driver bind and aren't of master type in sort of character
+device file under /dev/bus/i3c/ folder. They are identified through its
+<bus id>-<Provisional ID> same way they can be found in /sys/bus/i3c/devices/.
+::
+
+# ls -l /dev/bus/i3c/
+total 0
+crw-------    1 root     root      248,   0 Jan  1 00:22 0-6072303904d2
+crw-------    1 root     root      248,   1 Jan  1 00:22 0-b7405ba00929
+
+The simplest way to use this interface is to not have an I3C device bound to
+a kernel driver, this can be achieved by not have the kernel driver loaded or
+using the Sysfs to unbind the kernel driver from the device.
+
+BASIC CHARACTER DEVICE API
+===============================
+For now, the API has only support private SDR read and write transfers.
+Those transaction can be achieved by the following:
+
+``read(file, buffer, sizeof(buffer))``
+  The standard read() operation will work as a simple transaction of private
+  SDR read data followed a stop.
+  Return the number of bytes read on success, and a negative error otherwise.
+
+``write(file, buffer, sizeof(buffer))``
+  The standard write() operation will work as a simple transaction of private
+  SDR write data followed a stop.
+  Return the number of bytes written on success, and a negative error otherwise.
+
+``ioctl(file, I3C_IOC_PRIV_XFER(nxfers), struct i3c_ioc_priv_xfer *xfers)``
+  It combines read/write transactions without a stop in between.
+  Return 0 on success, and a negative error otherwise.
+
+NOTES:
+  - According to the MIPI I3C Protocol is the I3C slave that terminates the read
+    transaction otherwise Master can abort early on ninth (T) data bit of each
+    SDR data word.
+
+  - Normal open() and close() operations on /dev/bus/i3c/<bus>-<provisional id>
+    files work as you would expect.
+
+  - As documented in cdev_del() if a device was already open during
+    i3cdev_detach, the read(), write() and ioctl() fops will still be callable
+    yet they will return -EACCES.
+
+C EXAMPLE
+=========
+Working with I3C devices is much like working with files. You will need to open
+a file descriptor, do some I/O operations with it, and then close it.
+
+The following header files should be included in an I3C program::
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/i3c/i3cdev.h>
+
+To work with an I3C device, the application must open the driver, made
+available at the device node::
+
+  int file;
+
+  file = open("/dev/bus/i3c/0-6072303904d2", O_RDWR);
+  if (file < 0)
+  exit(1);
+
+Now the file is opened, we can perform the operations available::
+
+  /* Write function */
+  uint_t8  buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef}
+  if (write(file, buf, 5) != 5) {
+    /* ERROR HANDLING: I3C transaction failed */
+  }
+
+  /*  Read function */
+  ret = read(file, buf, 5);
+  If (ret < 0) {
+    /* ERROR HANDLING: I3C transaction failed */
+  } else {
+    /* Iterate over buf[] to get the read data */
+  }
+
+  /* IOCTL function */
+  struct i3c_ioc_priv_xfer xfers[2];
+
+  uint8_t tx_buf[] = {0x00, 0xde, 0xad, 0xbe, 0xef};
+  uint8_t rx_buf[10];
+
+  xfers[0].data = (uintptr_t)tx_buf;
+  xfers[0].len = 5;
+  xfers[0].rnw = 0;
+  xfers[1].data = (uintptr_t)rx_buf;
+  xfers[1].len = 10;
+  xfers[1].rnw = 1;
+
+  if (ioctl(file, I3C_IOC_PRIV_XFER(2), xfers) < 0)
+    /* ERROR HANDLING: I3C transaction failed */
+
+The device can be closed when the open file descriptor is no longer required::
+
+  close(file);
\ No newline at end of file
-- 
2.7.4

