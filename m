Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8272C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98606214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om0YOmPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEJMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:24:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56632 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728874AbgEJMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589113479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jiDyRnN1GpR8mrfv5e1QlJJqEG97qcE0l4S/3QO1NY=;
        b=Om0YOmPZ5QbLA9ga/PMpB6FClt7RFpkVxDS1tVS3vmkt5mqMnGVqmTSZfq/Q7sBGPhsqZP
        kwyazOwKkrjZmNAP9BVjvcxPLFtGOaGA6uWULo14lWPYftXnpOIL3iMHGp7S2+yeWcF5Rk
        u21kW1lTi2md8QLMRgZccXVt74anu7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-roNam2wLMF643auX-Eam0Q-1; Sun, 10 May 2020 08:24:37 -0400
X-MC-Unique: roNam2wLMF643auX-Eam0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D548835B40;
        Sun, 10 May 2020 12:24:36 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 259885D9C9;
        Sun, 10 May 2020 12:24:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: asus-wmi: Add support for SW_TABLET_MODE
Date:   Sun, 10 May 2020 14:24:31 +0200
Message-Id: <20200510122432.123751-2-hdegoede@redhat.com>
In-Reply-To: <20200510122432.123751-1-hdegoede@redhat.com>
References: <20200510122432.123751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Asus 2-in-1s with a detachable keyboard the Asus WMI interface
reports if the tablet is attached to the keyboard or not.

Report if the 2-in-1 is in tablet or clamshell mode to userspace
by reporting SW_TABLET_MODE events to userspace.

This has been tested on a T100TA, T100CHI, T100HA and T200TA.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/asus-wmi.c            | 24 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  3 +++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 25ec821dae21..1ab07fa9b08a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -57,6 +57,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_BRNDOWN_MIN		0x20
 #define NOTIFY_BRNDOWN_MAX		0x2e
 #define NOTIFY_FNLOCK_TOGGLE		0x4e
+#define NOTIFY_KBD_DOCK_CHANGE		0x75
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
@@ -346,7 +347,7 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
-	int err;
+	int err, result;
 
 	asus->inputdev = input_allocate_device();
 	if (!asus->inputdev)
@@ -362,6 +363,14 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 	if (err)
 		goto err_free_dev;
 
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
+	if (result >= 0) {
+		input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
+		input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
+	} else if (result != -ENODEV) {
+		pr_err("Error checking for keyboard-dock: %d\n", result);
+	}
+
 	err = input_register_device(asus->inputdev);
 	if (err)
 		goto err_free_dev;
@@ -2055,9 +2064,9 @@ static int asus_wmi_get_event_code(u32 value)
 
 static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 {
-	int orig_code;
 	unsigned int key_value = 1;
 	bool autorelease = 1;
+	int result, orig_code;
 
 	orig_code = code;
 
@@ -2102,6 +2111,17 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
+	if (code == NOTIFY_KBD_DOCK_CHANGE) {
+		result = asus_wmi_get_devstate_simple(asus,
+						      ASUS_WMI_DEVID_KBD_DOCK);
+		if (result >= 0) {
+			input_report_switch(asus->inputdev, SW_TABLET_MODE,
+					    !result);
+			input_sync(asus->inputdev);
+		}
+		return;
+	}
+
 	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
 		fan_boost_mode_switch_next(asus);
 		return;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index d39fc658c320..897b8332a39f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -85,6 +85,9 @@
 /* Maximum charging percentage */
 #define ASUS_WMI_DEVID_RSOC		0x00120057
 
+/* Keyboard dock */
+#define ASUS_WMI_DEVID_KBD_DOCK		0x00120063
+
 /* DSTS masks */
 #define ASUS_WMI_DSTS_STATUS_BIT	0x00000001
 #define ASUS_WMI_DSTS_UNKNOWN_BIT	0x00000002
-- 
2.26.0

