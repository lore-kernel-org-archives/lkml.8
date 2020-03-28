Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06719C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77B4206CC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOTwvg1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgC1Hqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:46:49 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41012 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgC1Hqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:46:47 -0400
Received: by mail-pg1-f178.google.com with SMTP id b1so5822089pgm.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udOjHUuVrYhmjpcD3RfPEn/4AJ+kCTCeCAwVdy3cmzE=;
        b=XOTwvg1q2GtN1U/qnPXTCULtOxjsFTkJ+RaYVY3ArtrTo0vWDo+m6lxr2PDmhtJrvI
         n3C+CEOWHRgiHJd6wuP+jDzZvXbSaKaJ9K2cP0nL+3YoMA6kSema8qVVccM3LxGjshvv
         AHTkZZE1Y0+ZtVGSTV+KZRDRY6+n1u3t19Vro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udOjHUuVrYhmjpcD3RfPEn/4AJ+kCTCeCAwVdy3cmzE=;
        b=J0M3FSBvWADFnUZ1ZHWPlz61zTX4EJx8o5N/y4VTKupMl3N4dnnU+PHNtCFZnZ3R5I
         02+jyaPlTYj59FZvznw1z2z9Q0og/DxZQj2pQ2SyXSi/qDmdVDybntxLmA/ykMe6TGxa
         B5d36AnZOY2Iy5bpWXNlRc3+fpKZ12bRJ1gLo+KG3NXHiQkILUnj6NtK3txvyIq5lLP2
         /XzCIMwmRw/AFnS9KsSV53rbV9z7fn31ybFTJg6vIVwbntfTea23I05iseodTOvb2z9D
         kWSjKUXLTIl3W3DJ+6BrsqRH45HP5vPsKynABrmFeoJydUObwhW9xCDT2JmQZ0uhKsXh
         2DGg==
X-Gm-Message-State: ANhLgQ1bb/a/TlG+ZSG7z8TYJ3AMCsTxXSHP/qMUl0QUXhdC9zRk3tKc
        ohsfMZGyN8vxWw1A5jpuccDMlw==
X-Google-Smtp-Source: ADFU+vuoI5eRA0P1Ibj5ZQlZ2Y3DOnCQSgwffpi2rnk6IQnv72+L+YPHyaCxgF6ovW4HFfYzAeF+RQ==
X-Received: by 2002:a63:d709:: with SMTP id d9mr3168715pgg.82.1585381604560;
        Sat, 28 Mar 2020 00:46:44 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id r59sm5273063pjb.45.2020.03.28.00.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 00:46:43 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: btusb: Indicate Microsoft vendor extension for Intel 9460/9560 and 9160/9260
Date:   Sat, 28 Mar 2020 00:46:31 -0700
Message-Id: <20200328004507.v4.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200328074632.21907-1-mcchou@chromium.org>
References: <20200328074632.21907-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a bit mask of driver_info for Microsoft vendor extension and
indicates the support for Intel 9460/9560 and 9160/9260. See
https://docs.microsoft.com/en-us/windows-hardware/drivers/bluetooth/
microsoft-defined-bluetooth-hci-commands-and-events for more information
about the extension. This also add a kernel config, BT_MSFTEXT, and a
source file to facilitate Microsoft vendor extension functions.
This was verified with Intel ThunderPeak BT controller
where msft_vnd_ext_opcode is 0xFC1E.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
- Introduce CONFIG_BT_MSFTEXT as a starting point of providing a
framework to use Microsoft extension
- Create include/net/bluetooth/msft.h and net/bluetooth/msft.c to
facilitate functions of Microsoft extension.

Changes in v3:
- Create net/bluetooth/msft.c with struct msft_vnd_ext defined internally
and change the hdev->msft_ext field to void*.
- Define and expose msft_vnd_ext_set_opcode() for btusb use.
- Init hdev->msft_ext in hci_alloc_dev() and deinit it in hci_free_dev().

Changes in v2:
- Define struct msft_vnd_ext and add a field of this type to struct
hci_dev to facilitate the support of Microsoft vendor extension.

 drivers/bluetooth/btusb.c        | 11 +++++++++--
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/Kconfig            |  9 ++++++++-
 net/bluetooth/Makefile           |  1 +
 net/bluetooth/msft.c             | 16 ++++++++++++++++
 net/bluetooth/msft.h             | 19 +++++++++++++++++++
 6 files changed, 57 insertions(+), 3 deletions(-)
 create mode 100644 net/bluetooth/msft.c
 create mode 100644 net/bluetooth/msft.h

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..0fe47708d3c8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -21,6 +21,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "../../net/bluetooth/msft.h"
 #include "btintel.h"
 #include "btbcm.h"
 #include "btrtl.h"
@@ -58,6 +59,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
+#define BTUSB_MSFT_VND_EXT	0x800000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -335,7 +337,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_MSFT_VND_EXT },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
@@ -348,7 +351,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_MSFT_VND_EXT },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -3800,6 +3804,9 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		if (id->driver_info & BTUSB_MSFT_VND_EXT)
+			msft_set_opcode(hdev, 0xFC1E);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..239cae2d9998 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -484,6 +484,10 @@ struct hci_dev {
 	struct led_trigger	*power_led;
 #endif
 
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+	__u16			msft_opcode;
+#endif
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 165148c7c4ce..5929ccb02b39 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -30,7 +30,7 @@ menuconfig BT
 		L2CAP (Logical Link Control and Adaptation Protocol)
 		SMP (Security Manager Protocol) on LE (Low Energy) links
 	     HCI Device drivers (Interface to the hardware)
-	     RFCOMM Module (RFCOMM Protocol)  
+	     RFCOMM Module (RFCOMM Protocol)
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
 	     HIDP Module (Human Interface Device Protocol)
@@ -93,6 +93,13 @@ config BT_LEDS
 	  This option selects a few LED triggers for different
 	  Bluetooth events.
 
+config BT_MSFTEXT
+	bool "Enable Microsoft extensions"
+	depends on BT
+	help
+	  This options enables support for the Microsoft defined HCI
+	  vendor extensions.
+
 config BT_SELFTEST
 	bool "Bluetooth self testing support"
 	depends on BT && DEBUG_KERNEL
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index fda41c0b4781..41dd541a44a5 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -19,5 +19,6 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
+bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
new file mode 100644
index 000000000000..7609932c48ca
--- /dev/null
+++ b/net/bluetooth/msft.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2020 Google Corporation */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "msft.h"
+
+void msft_set_opcode(struct hci_dev *hdev, __u16 opcode)
+{
+	hdev->msft_opcode = opcode;
+
+	bt_dev_info(hdev, "Enabling MSFT extensions with opcode 0x%2.2x",
+		    hdev->msft_opcode);
+}
+EXPORT_SYMBOL(msft_set_opcode);
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
new file mode 100644
index 000000000000..7218ea759dde
--- /dev/null
+++ b/net/bluetooth/msft.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2020 Google Corporation */
+
+#ifndef __MSFT_H
+#define __MSFT_H
+
+#include <net/bluetooth/hci_core.h>
+
+#if IS_ENABLED(CONFIG_BT_MSFTEXT)
+
+void msft_set_opcode(struct hci_dev *hdev, __u16 opcode);
+
+#else
+
+static inline void msft_set_opcode(struct hci_dev *hdev, __u16 opcode) {}
+
+#endif
+
+#endif /* __MSFT_H*/
-- 
2.24.1

