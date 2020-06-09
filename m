Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F42207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="UnQvwBoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1b0QufF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgFIDxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:53:14 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33683 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbgFIDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:53:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 37A8976F;
        Mon,  8 Jun 2020 23:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 23:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Lw/1IiHHO7tB2
        teVnWxdii7xEm1PsRJYbtGvx1aqdvg=; b=UnQvwBoZwVxn+HY6e87wP57RUkXyc
        NT1OxS2NXSJYncpmU3C12hZ6ogHduRMmVwH5m4KdBjxoyn8rt25k39m3+0MKmB/I
        ZzHB3vN87vj8AJWxB1ApwovGpzzmCb7K91AMfPcBYiV5BVUy13fzZvydW95t9C6O
        o2fm/6wwgjOmdgCOcQcGBBLeHIg90ib2Qy4cWcrAJ6iUNzkmJFJ5f5pFbCBsyh1f
        T3Y6nOPC9GCRvG0Z66jbuflSVKyl0O0lDDdR0O6xi1Fpfcs0mumV17X86VJX+ROI
        +73hg31LInYUE8rMyxPu2IGWoZJe5APbDxr8dnEozYe2/sZlTKeKtZEjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lw/1IiHHO7tB2teVnWxdii7xEm1PsRJYbtGvx1aqdvg=; b=G1b0QufF
        UfMJ76ICngSv3YyCMq/o3epnimQpGoR1dJHPcQT1RNhlMzr0+Ao0O4mEdNjqzf+Z
        Skyj24gxBydvQ8B/OmD+IKuAN7yp8c6AwRptOyt7bB1mwjAa4E7l2MAJOQyfpIMw
        g90owfQrYR8aWpKFGgeFmR1O0RUCzgpvZ7XBP9VaR+f8z8Pq6uUKFslYgn/owI5p
        qcqUrrl+/gZqKnB2vk3Vp6M9XB1mONq22+RS0xeiBusB+dYTRMITB5wGRT5dFTQo
        anLtgSKgK9vc8sxaUpY3iOZmdHi4OKqtDoJy9Nf/yFrqspz2oOEcRcI5+TiV5+NC
        7+wpMO1+iYLj0w==
X-ME-Sender: <xms:pgffXs299e9sZh_gWlLKT5WLQTd4oh5-TD9BUdIYPdqPoXjw5xk3Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghr
    ihhttghhvghruceohidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrf
    grthhtvghrnhepjeegfeetleeuleevteejteetieffgffgfedvffffvddtvddvveevhffh
    tdehudeknecukfhppeeijedrkeegrdduleegrddujeehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgv
    rhdrtghomh
X-ME-Proxy: <xmx:pgffXnEaGvsy-UQW0f17lAfG-eUfq5HFiSOwOcsI2yDMWvD8kKVsUg>
    <xmx:pgffXk4ga7PCU4awV9zv_0AlqOxt_UxDnq63-DG75mLnAPp1txDhMQ>
    <xmx:pgffXl1BblQLanGSurtQ23JI1xplDopWNVvQHtyJX846I9qnSR5S9g>
    <xmx:pgffXlM7l63V6UZv8s9mW6CPnoQ4eVd0Uq3q7EPGilNLbGzJc8Ap_w>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 815053280064;
        Mon,  8 Jun 2020 23:53:10 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Date:   Mon,  8 Jun 2020 23:52:53 -0400
Message-Id: <b2efc80238424ffe5f97422f3e59e9689a327a28.1591673143.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591673143.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591673143.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are events with extended data. The extended data is
currently ignored as userspace does not have a way to deal
it.

Ignore event with a type of 0x0012 and a code of 0xe035, as
the keyboard controller takes care of Fn lock events by itself.
This silences the following messages being logged when
pressing the Fn-lock key on a Dell Inspiron 5593:

dell_wmi: Unknown WMI event type 0x12
dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed

This is consistent with the behavior for the Fn-lock key
elsewhere in this file.

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0b2edfe2767d..e3bc2601e631 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -334,6 +334,15 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
 	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
 };
 
+/*
+ * Keymap for WMI events of type 0x0012
+ * They are events with extended data
+ */
+static const struct key_entry dell_wmi_keymap_type_0012[] = {
+	/* Fn-lock button pressed */
+	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
+};
+
 static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
 {
 	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
@@ -418,10 +427,11 @@ static void dell_wmi_notify(struct wmi_device *wdev,
 
 		switch (buffer_entry[1]) {
 		case 0x0000: /* One key pressed or event occurred */
+		case 0x0012: /* Event with extended data occurred */
 			if (len > 2)
-				dell_wmi_process_key(wdev, 0x0000,
+				dell_wmi_process_key(wdev, buffer_entry[1],
 						     buffer_entry[2]);
-			/* Other entries could contain additional information */
+			/* Extended data is currently ignored */
 			break;
 		case 0x0010: /* Sequence of keys pressed */
 		case 0x0011: /* Sequence of events occurred */
@@ -556,6 +566,7 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
 			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
+			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
 			 1,
 			 sizeof(struct key_entry), GFP_KERNEL);
 	if (!keymap) {
@@ -600,6 +611,13 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
 		pos++;
 	}
 
+	/* Append table with events of type 0x0012 */
+	for (i = 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
+		keymap[pos] = dell_wmi_keymap_type_0012[i];
+		keymap[pos].code |= (0x0012 << 16);
+		pos++;
+	}
+
 	/*
 	 * Now append also table with "legacy" events of type 0x0000. Some of
 	 * them are reported also on laptops which have scancodes in DMI.
-- 
2.27.0

