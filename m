Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F98C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18D520787
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XgEWKJcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDDDbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:31:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44263 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgDDDbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:31:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id 142so4553821pgf.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rL0Rm/lQAGdaWAZMBOVIG8W3bOy5kskSwoybEKdYAI=;
        b=XgEWKJcbVYb7TmhweibqD0bkM2iPPwCNk2hOBqDTGRWd4/EhFLvZ3R8jIUTS6/RKN0
         yqImpO0HDSB5bc4odVnYWUlBWU3Xs07RxSuC8YF/65KjiU3mtAez/a3QndAY8W4FQ7JJ
         dGaT+OpFQ9uQCxCcqwbY3i4xJbEXcmrHrGj/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rL0Rm/lQAGdaWAZMBOVIG8W3bOy5kskSwoybEKdYAI=;
        b=tR0eyJZHnqXLrx6NrW60icqGs3+e83vltVARFim5mWsoGtxbT9rMCcy+xOlZxWPRBF
         rhGboV/eQMw2lFuuoxdp2S3UfrZxT1BIX9MTlgsRwcCQ+/XJgiUVvViXo30jj+Gr/ld8
         ekAIxFriifuoAsTkmmPpTzTnzM+xD9NgSbAULxqFosJx8txsBb1q4g9l7CSZFuHrL6sc
         +eck6rN3xRqLAZCRyi8GJ9+KFabdE9UrS/h+mfTWfEYrKMdv2cJHu1F5U2l5MqAnt8wJ
         LrEa902ileaLw7qPunXpTPnmPox2wCY2iIujSO8o+U0rR9Lbn7QbVKCEdOimb7RsYn41
         y3eg==
X-Gm-Message-State: AGi0PuZoGTnbryUL9ll5HQJoikFwDBDxXti+qQSQrXHc24TMDu8Yf2tX
        BDhBpYVVU3Owf9W5E0rdFU6SoQ==
X-Google-Smtp-Source: APiQypKPhQwTlSAv0HKYk7HrJSfvfdKMVLrCM060ETottRWgNo6xvvPB1ihIrqMJlOuKM9iRmsrrXA==
X-Received: by 2002:a63:a361:: with SMTP id v33mr10906958pgn.324.1585971095462;
        Fri, 03 Apr 2020 20:31:35 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id o184sm6800599pfg.149.2020.04.03.20.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 20:31:34 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] Bluetooth: btusb: Indicate Microsoft vendor extension for Intel 9160/9260
Date:   Fri,  3 Apr 2020 20:31:18 -0700
Message-Id: <20200403203058.v5.3.I56c3ba2ec2bcfaadf57575c5c74a03dd4f8487d0@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404033118.22135-1-mcchou@chromium.org>
References: <20200404033118.22135-1-mcchou@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a bit mask of driver_info for Microsoft vendor extension and
indicates the support for Intel 9160/9260. This was verified with Intel
ThunderPeak BT controller where msft_opcode is 0xFC1E.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v5:
- Extract the changes on btusb as a different commit.

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

 drivers/bluetooth/btusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c96123..f73ad18c04559 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -20,6 +20,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/msft.h>
 
 #include "btintel.h"
 #include "btbcm.h"
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
@@ -3800,6 +3803,12 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+
+		/* All Intel controllers that support the Microsoft
+		 * vendor extension are using 0xFC1E for VsMsftOpCode.
+		 */
+		if (id->driver_info & BTUSB_MSFT_VND_EXT)
+			msft_set_opcode(hdev, 0xFC1E);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.24.1

