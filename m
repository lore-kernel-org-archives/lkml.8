Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5526C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8BCE20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csVCNsb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMImR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:42:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:42:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z20so2329801plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLumMv32BeXkjDSmCSCfzv64I6KOcubFlQAnOBbQLHk=;
        b=csVCNsb/O6GNaQuqDG/6pQTHaBxFMmUH+HNd8tBVt3o1oYYoahhUoR+zPRfRsHeC53
         W5RiwuVQcQYezemmi7mrz9Gt1ewdaWgPeZbVH1glbExQs7ev2LnIdr5rd6oGyJSUXTUH
         XE2KyPEseLoBPEgcdTPLzYLrOGBDqC5EPqOAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLumMv32BeXkjDSmCSCfzv64I6KOcubFlQAnOBbQLHk=;
        b=QNibWihKt4fBEUZSqJ8mSkDZQs3ieMrshE+rGToUZfJOxpGemNDnC/Sym+Fm00QNc8
         BESLrQIxmhOjlG+Wo/Lt7ckKsJ73Gtzurrx1YOWIah46m6L+HZmr5iAe/fL/oO+CqMi/
         ED5gU2xflo1u8duXt/poKltcLPjCZG1MRRRKcBiFAzfRWbB/M4FDiAp3vBfP8km9dEHw
         sW6v18GihsYwOFx+eC/+50alQah8vKAbHI+uK8r9F+diRbEXegZmw26s6qOPYXtNTZze
         MiJEx7uZIAV7hgpat8YDZ0dBd2EnwZbb2c96pKNv+DBwRhEmqEKSCxzryclvf0niEIWR
         BA1A==
X-Gm-Message-State: AOAM5327gRvQ9VZpQA5IxK8NtDLAmDiw7umrfNQ2rATEO/0e38m3rrgv
        qr0w5FOy5WN6+ZcW55JjJX0FXw==
X-Google-Smtp-Source: ABdhPJyzjTuLImgoE0a6KvLgH//MuZxi67QVY9MCW+hO3+K/A//viL/LFBbLPVK4l/SIBGJEjHMpJw==
X-Received: by 2002:a17:90a:a65:: with SMTP id o92mr4072981pjo.104.1597308135142;
        Thu, 13 Aug 2020 01:42:15 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id y29sm5032035pfr.11.2020.08.13.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:42:14 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: btusb: define HCI packet sizes of USB Alts
Date:   Thu, 13 Aug 2020 16:41:28 +0800
Message-Id: <20200813164059.v1.1.I56de28ec171134cb9f97062e2c304a72822ca38b@changeid>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200813084129.332730-1-josephsih@chromium.org>
References: <20200813084129.332730-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is desirable to define the HCI packet payload sizes of
USB alternate settings so that they can be exposed to user
space.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 drivers/bluetooth/btusb.c        | 43 ++++++++++++++++++++++++--------
 include/net/bluetooth/hci_core.h |  1 +
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d2608ddfd0875..df7cadf6385868 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -459,6 +459,22 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_WAKEUP_DISABLE	14
 #define BTUSB_USE_ALT1_FOR_WBS	15
 
+/* Per core spec 5, vol 4, part B, table 2.1,
+ * list the hci packet payload sizes for various ALT settings.
+ * This is used to set the packet length for the wideband speech.
+ * If a controller does not probe its usb alt setting, the default
+ * value will be 0. Any clients at upper layers should interpret it
+ * as a default value and set a proper packet length accordingly.
+ *
+ * To calculate the HCI packet payload length:
+ *   for alternate settings 1 - 5:
+ *     hci_packet_size = suggested_max_packet_size * 3 (packets) -
+ *                       3 (HCI header octets)
+ *   for alternate setting 6:
+ *     hci_packet_size = suggested_max_packet_size - 3 (HCI header octets)
+ */
+static const int hci_packet_size_usb_alt[] = { 0, 24, 48, 72, 96, 144, 60 };
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -3958,6 +3974,15 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->notify = btusb_notify;
 	hdev->prevent_wake = btusb_prevent_wake;
 
+	if (id->driver_info & BTUSB_AMP) {
+		/* AMP controllers do not support SCO packets */
+		data->isoc = NULL;
+	} else {
+		/* Interface orders are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
+		data->isoc_ifnum = ifnum_base + 1;
+	}
+
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
@@ -4021,6 +4046,10 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+
+		if (btusb_find_altsetting(data, 6))
+			hdev->sco_pkt_len = hci_packet_size_usb_alt[6];
+
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4062,15 +4091,6 @@ static int btusb_probe(struct usb_interface *intf,
 		btusb_check_needs_reset_resume(intf);
 	}
 
-	if (id->driver_info & BTUSB_AMP) {
-		/* AMP controllers do not support SCO packets */
-		data->isoc = NULL;
-	} else {
-		/* Interface orders are hardcoded in the specification */
-		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
-		data->isoc_ifnum = ifnum_base + 1;
-	}
-
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
 		hdev->setup = btrtl_setup_realtek;
@@ -4082,9 +4102,10 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
-		if (btusb_find_altsetting(data, 1))
+		if (btusb_find_altsetting(data, 1)) {
 			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
-		else
+			hdev->sco_pkt_len = hci_packet_size_usb_alt[1];
+		} else
 			bt_dev_err(hdev, "Device does not support ALT setting 1");
 	}
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8caac20556b499..0624496328fc09 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -417,6 +417,7 @@ struct hci_dev {
 	unsigned int	acl_pkts;
 	unsigned int	sco_pkts;
 	unsigned int	le_pkts;
+	unsigned int	sco_pkt_len;
 
 	__u16		block_len;
 	__u16		block_mtu;
-- 
2.28.0.236.gb10cc79966-goog

