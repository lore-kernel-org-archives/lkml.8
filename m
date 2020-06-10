Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E31C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33C220734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgFJPiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:38:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43200 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgFJPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:38:01 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jj2ne-0003Cl-R4; Wed, 10 Jun 2020 15:37:59 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alex.hung@canonical.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:INTEL HID EVENT DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP platforms
Date:   Wed, 10 Jun 2020 23:37:47 +0800
Message-Id: <20200610153747.27040-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wireless hotkey on HP platforms can trigger two events, if both
hp-wireless and intel-hid are supported. Two events at the same time
renders wireless hotkey useless.

HP confirmed that hp-wireless (HPQ6001) should always be the canonical
source of wireless hotkey event, so skip registering rfkill hotkey if
HPQ6001 is present.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/intel-hid.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 9ee79b74311c..31091c8faf70 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -25,6 +25,8 @@ static const struct acpi_device_id intel_hid_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
 
+static bool hp_wireless_present;
+
 /* In theory, these are HID usages. */
 static const struct key_entry intel_hid_keymap[] = {
 	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
@@ -49,6 +51,29 @@ static const struct key_entry intel_hid_keymap[] = {
 	{ KE_END },
 };
 
+static const struct key_entry intel_hid_no_rfkill_keymap[] = {
+	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
+	/* 2: Toggle SW_ROTATE_LOCK -- easy to implement if seen in wild */
+	{ KE_KEY, 3, { KEY_NUMLOCK } },
+	{ KE_KEY, 4, { KEY_HOME } },
+	{ KE_KEY, 5, { KEY_END } },
+	{ KE_KEY, 6, { KEY_PAGEUP } },
+	{ KE_KEY, 7, { KEY_PAGEDOWN } },
+	/* 8: rfkill -- use hp-wireless instead */
+	{ KE_KEY, 9, { KEY_POWER } },
+	{ KE_KEY, 11, { KEY_SLEEP } },
+	/* 13 has two different meanings in the spec -- ignore it. */
+	{ KE_KEY, 14, { KEY_STOPCD } },
+	{ KE_KEY, 15, { KEY_PLAYPAUSE } },
+	{ KE_KEY, 16, { KEY_MUTE } },
+	{ KE_KEY, 17, { KEY_VOLUMEUP } },
+	{ KE_KEY, 18, { KEY_VOLUMEDOWN } },
+	{ KE_KEY, 19, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY, 20, { KEY_BRIGHTNESSDOWN } },
+	/* 27: wake -- needs special handling */
+	{ KE_END },
+};
+
 /* 5 button array notification value. */
 static const struct key_entry intel_array_keymap[] = {
 	{ KE_KEY,    0xC2, { KEY_LEFTMETA } },                /* Press */
@@ -317,7 +342,8 @@ static int intel_hid_input_setup(struct platform_device *device)
 	if (!priv->input_dev)
 		return -ENOMEM;
 
-	ret = sparse_keymap_setup(priv->input_dev, intel_hid_keymap, NULL);
+	ret = sparse_keymap_setup(priv->input_dev, hp_wireless_present ?
+			intel_hid_no_rfkill_keymap : intel_hid_keymap, NULL);
 	if (ret)
 		return ret;
 
@@ -575,6 +601,9 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 			dev_info(&dev->dev,
 				 "intel-hid: created platform device\n");
 
+	if (!strcmp(acpi_device_hid(dev), "HPQ6001"))
+		hp_wireless_present = true;
+
 	return AE_OK;
 }
 
-- 
2.17.1

