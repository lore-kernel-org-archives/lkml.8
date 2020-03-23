Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD80C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240FC20732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODkKSuVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCWH2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:28:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45295 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgCWH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:28:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so242658pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 00:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WaFqY08yZDTNOOqFJJ4Ka9dG2R6CvdNBmfw+UsXwFw=;
        b=ODkKSuVJ6S52gPucNInkRRtmLi5CEwf3sUUvBlHuALvNerRafu3JZIPE//8XHMJcC+
         Y0q0+nK9uhrEji65AzpxQv/UIT/ZXG0m+ynbKrKAl3Q5nyyj7MXmBArfQ/nAvEIsx/ea
         24HV2oo0THO9Ki5w+CbrCEWerUT5NZLE1q9As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WaFqY08yZDTNOOqFJJ4Ka9dG2R6CvdNBmfw+UsXwFw=;
        b=uHUXARaMhQ/bnFep501BJE0d6m5AgUlAThJ/TlonxYMVRnf+K9y6eUP9E0kdns/DK+
         5hEePhKwVWWZMR75/ArL09+7rHGmO6yIW/hqC+6gSdaegfLxLYOxQu6OAXKjhq6RCWNp
         1UKN1iJX1etCGK4WvUb5947jX6QGuHsHYXMLdJ3/wZw+oE5dd1nXL9rMv6qDgaNMoM7m
         +YEQVjfyw9/iix0MBBQrmnQdIbRx+43Vv6kpp8uvM+Ae4lPZtMRxg+bGxyqFPlcjnTFD
         aT+9k7x5wleYA97dzy5+pFEefwo3s5X7dnDukqqtYrJgjtdOILLbQuHkbfpiGfI7JVW0
         uM/Q==
X-Gm-Message-State: ANhLgQ0r5JzO+uXhimlgt9Zn6X87dYdiohbnXh0ze2z3Utlsi9KmFRRk
        ywogtnLGJEZvMAl+NKSbjAr7ew==
X-Google-Smtp-Source: ADFU+vuUDpsPfjd1HQWxTTC81WLH16iAkSLvmvkYp+NLO7JpHFuipUoXl00u8X8y9FJsnkBWcmeH0A==
X-Received: by 2002:aa7:814c:: with SMTP id d12mr14344986pfn.70.1584948515681;
        Mon, 23 Mar 2020 00:28:35 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id z16sm12645399pfr.138.2020.03.23.00.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 00:28:34 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: btusb: Indicate Microsoft vendor extension for Intel 9460/9560 and 9160/9260
Date:   Mon, 23 Mar 2020 00:28:23 -0700
Message-Id: <20200323002820.v1.1.I0e975833a6789e8acc74be7756cd54afde6ba98c@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323072824.254495-1-mcchou@chromium.org>
References: <20200323072824.254495-1-mcchou@chromium.org>
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
about the extension. This was verified with Intel ThunderPeak BT controller
where msft_vnd_ext_opcode is 0xFC1E.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v1:
- Add a bit mask of driver_info for Microsoft vendor extension.
- Indicates the support of Microsoft vendor extension for Intel
9460/9560 and 9160/9260.
- Add fields to struct hci_dev to facilitate the support of Microsoft
vendor extension.

 drivers/bluetooth/btusb.c        | 18 ++++++++++++++++--
 include/net/bluetooth/hci.h      |  2 ++
 include/net/bluetooth/hci_core.h |  4 ++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..5eb27d1c4ac7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,6 +58,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
+#define BTUSB_MSFT_VND_EXT	0x800000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -335,7 +336,8 @@ static const struct usb_device_id blacklist_table[] = {
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_MSFT_VND_EXT },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
@@ -348,7 +350,8 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
-						     BTUSB_WIDEBAND_SPEECH },
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_MSFT_VND_EXT },
 
 	/* Other Intel Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x8087, 0xe0, 0x01, 0x01),
@@ -3734,6 +3737,11 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 
+	hdev->msft_vnd_ext_opcode = HCI_OP_NOP;
+	hdev->msft_vnd_ext_features = 0;
+	hdev->msft_vnd_ext_evt_prefix_len = 0;
+	hdev->msft_vnd_ext_evt_prefix = NULL;
+
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -3800,6 +3808,12 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		if (id->driver_info & BTUSB_MSFT_VND_EXT &&
+			(id->idProduct == 0x0025 || id->idProduct == 0x0aaa)) {
+			hdev->msft_vnd_ext_opcode =
+				hci_opcode_pack(HCI_VND_DEBUG_CMD_OGF, 0x001E);
+		}
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..b85e95454367 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -38,6 +38,8 @@
 
 #define HCI_MAX_CSB_DATA_SIZE	252
 
+#define HCI_VND_DEBUG_CMD_OGF	0x3f
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..15daf3b2d4f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -315,6 +315,10 @@ struct hci_dev {
 	__u8		ssp_debug_mode;
 	__u8		hw_error_code;
 	__u32		clock;
+	__u16		msft_vnd_ext_opcode;
+	__u64		msft_vnd_ext_features;
+	__u8		msft_vnd_ext_evt_prefix_len;
+	void		*msft_vnd_ext_evt_prefix;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
-- 
2.24.1

