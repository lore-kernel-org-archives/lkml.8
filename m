Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DBFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26CD2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="Vn2ST55J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHpGeJxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFJR5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:57:22 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59491 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbgFJR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:57:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 571AB793;
        Wed, 10 Jun 2020 13:57:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jun 2020 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Lw/1IiHHO7tB2
        teVnWxdii7xEm1PsRJYbtGvx1aqdvg=; b=Vn2ST55J27PaTTL2FjGGAO4o2JoZ8
        me0GOb06k6tZsJPsB8HC8G+42QQSxuB0q+WwkwYM1E8onkEgtnUDdgzm+bIiTPH4
        MUzhuFef60Zl78CGoTDnO4B2pwLXYAY7F81/u/ZdisWG/uyfioLDKqqXdlSfJ8Cw
        GS9xo4yiw6y3L7mqoKsG6uvOLwDUy1Zm+ZxueTYUFfS/zW5YTze5PhzCS0dfpVvS
        PzX3RIINe06gyESKdTL/gj6tmbek0th4S6wcm0EjoKH/fwvWU+UfJwV9GIuyQczu
        xPO8QUJYUl8zSWGOzueNrjHQ9KT1ee1rF0Jo5t1GjuuXjUKPuQ9imneGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lw/1IiHHO7tB2teVnWxdii7xEm1PsRJYbtGvx1aqdvg=; b=CHpGeJxZ
        Vq2Ckrd+kYhRfNiGKFfSI/1epxbXjX0BKq9MYSeiull2ho+Ckhv3d6yjVy8WuwzR
        yVkBplrVv88YMX9Rf9HNRBQlm5wrnLu94xj41P5ntVc9oygRC7Im5VHrPxw1C8zR
        qvxHG9c4yq3FcdR2XphHel4VFZglPkLsEwoJ16Q121aEoymKNRkXEX2mkBe6ku1D
        uFPGkjXkJRwok0CgR0JUuU35oyvf2IaG6ikNK3T48fMV+abk9S7aMcnbon2bJaot
        kvZyjvCoUYvN4hh5S+AgoPvR9nvGsOrVVbQRxytr1Sz+npG5hfwZYasD8EcgksVw
        wX1bEfnETHusUQ==
X-ME-Sender: <xms:-x7hXujBDY9hF3maswazChe7B_gVLOCtAPYe8PmkMDQBXY5xIx9Vcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejgeefteelueelveetjeetteeifffggfefvdffffdvtddvvdevvefh
    hfdthedukeenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:-x7hXvAb6H5xxCYTPtrPY8EZCnoQzYx8r4k-vJItzUGpqPybwrrWMg>
    <xmx:-x7hXmHdjWo-Xs1MRq6tOwraVTy6FTlLI9bD10vM3fx7TQTeziIssQ>
    <xmx:-x7hXnTUm0sNl2IoMGX9wHMANH2Oc_MejmS4GldfFD6frgmWj3XFzQ>
    <xmx:-x7hXkp6JWRysGz4aJTM8n6lTMJxRq-9uEO7ZjNC4bd1thmO3nFHkw>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 970E33061CCB;
        Wed, 10 Jun 2020 13:57:15 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v4 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Date:   Wed, 10 Jun 2020 13:56:57 -0400
Message-Id: <b2efc80238424ffe5f97422f3e59e9689a327a28.1591811549.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591811549.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591811549.git.y.linux@paritcher.com>
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

