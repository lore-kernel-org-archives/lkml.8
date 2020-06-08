Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B938206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662954;
	bh=bo6hTaU0KUVde9fRpgkiN2cbwe68KbW08+C5HgKmd04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dfVNPeMRKN/zixbXsNux8gnciTNQvSENCdaLk7XYhGyovj9Mk2Sjo4WSlfyrkm+ne
	 7V0NA/4A1BlGi63CUcKHaRtXZHAiAbQF+49Z7f9iYl0xICDQtcw4sZdsv3bjxYp4Tg
	 6IejeuTHIPA8mXxKzCaiZVmZVJS6luj86CbbdveM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgFIAfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbgFHXOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B9320B80;
        Mon,  8 Jun 2020 23:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658058;
        bh=bo6hTaU0KUVde9fRpgkiN2cbwe68KbW08+C5HgKmd04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pa6IxtfXKEHoiaJXLj1jm43Dux7aDuBiUqzLEgR0LUsTitEarWhk41RxLgnFVk503
         lPbWJx4fVQekrC0wkwXiXxST0+ZxAKNGI/YmgEg1c9uO24gixpBbA+TfEjOQQI8Yof
         uj2AthcbpQxyTv9Wf9eT/OI3jBP46fpXvExOjS+Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 105/606] HID: logitech: Add support for Logitech G11 extra keys
Date:   Mon,  8 Jun 2020 19:03:50 -0400
Message-Id: <20200608231211.3363633-105-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabian Schindlatz <fabian.schindlatz@fau.de>

[ Upstream commit b1bd0f75288f60e8d142a1b3e979ed0192c04931 ]

The Logitech G11 keyboard is a cheap variant of the G15 without the LCD
screen. It uses the same layout for its extra and macro keys (G1 - G18,
M1-M3, MR) and - from the input subsystem's perspective - behaves just
like the G15, so we can treat it as such.

Tested it with my own keyboard.

Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-lg-g15.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 309510a72c5e..40697af0ca35 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -756,6 +756,7 @@
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
 #define USB_DEVICE_ID_LOGITECH_G15_LCD		0xc222
+#define USB_DEVICE_ID_LOGITECH_G11		0xc225
 #define USB_DEVICE_ID_LOGITECH_G15_V2_LCD	0xc227
 #define USB_DEVICE_ID_LOGITECH_G510		0xc22d
 #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index ad4b5412a9f4..ef0cbcd7540d 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -872,6 +872,10 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 
 static const struct hid_device_id lg_g15_devices[] = {
+	/* The G11 is a G15 without the LCD, treat it as a G15 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_G11),
+		.driver_data = LG_G15 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_G15_LCD),
 		.driver_data = LG_G15 },
-- 
2.25.1

