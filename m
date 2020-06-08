Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E88C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9093720823
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="1kh6Kcon";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtX/DKZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFHEWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:22:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52827 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbgFHEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:22:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 046235C0088;
        Mon,  8 Jun 2020 00:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 00:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=oq1SU+NuZfX51
        5UbnWft33v3CP5C/EvGIqEvPDfX/gs=; b=1kh6KconTznsOpWbns8JQzOUW45Cp
        rsAaG8AoowuTLwptBSoleIfc+yThSm86vR/lk6OYr3HiSEFD0PUQUemd1qCXLLIF
        sIh8asALEvXvHXLH4qjWgs/CPn6AFYkOSXbQ3gFdEGRdtcTS7w7VqdvKZEarw0tG
        fOusz9deradrmcr8d0N5gR9y94Zr3hFpWuGa7Nj5TMYJ4wQga/E8FQngayvomltB
        OK83ZaeR6J2YeSSBwNF88KC2M39ptJpBAeoLAh1k3KWMBfGQr5vBl155w0Sd7qzj
        vsNZshuM7XFueYKmV/UEZoCkfMYWZ7OH4rrXjJ2qyjWGzCCvai9AIKTVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=oq1SU+NuZfX515UbnWft33v3CP5C/EvGIqEvPDfX/gs=; b=FtX/DKZ7
        spzC2CIF4H2YOTG/FgDT1nU5euZvTd6Mfz3nl9xHZcNkTEhvb2ZbSRF4rIAvLTem
        RvWbO99xnygpC1dDKQhvKXOKDR3g8PGnHfPriiD+0C3xRWJaMZkEWnodMPBCqKjL
        CGleEN/iYIaNIDvGTUetQh8LakVTHpj2mpmD5QwnDS46gRzcXzAN3ZEipJo6USlL
        geTWkvzm3TKj06S0pEO3BvzznD9IME1jVFDqttdo6l49/216kKC6FmNsYxmd8DU0
        iYi9GQJwbpaNSmV/uV11Xz9vjSKdV9ToVnE0c5OwzB1evSjOijwluAOj9sECCPf2
        dzbBoT8ltaj9Kw==
X-ME-Sender: <xms:Eb3dXqgv2rM9py433w5oyiQYt4zkS3NyA5ro8oMrmnv8HvcpN6Zo4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:Eb3dXrBWjYE6TgUMG7Dnq2v3Dp9TXcHocaJfo30QfRx1FUiCfx-3SQ>
    <xmx:Eb3dXiFhsKbxnrpTD-sPMFJ-mcalgflN96Y_CagWSd2Ta2ic8mOiLQ>
    <xmx:Eb3dXjRtrN2NaEnWcYV4NggKdLpXFHgMxg8r61xYspgvKx5XSE5txw>
    <xmx:Er3dXlYhIrqEDljMWcBTkkdZYRgja7Mv5hXNdbVhEQAv21NZRJkmXQ>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 934583280063;
        Mon,  8 Jun 2020 00:22:41 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Date:   Mon,  8 Jun 2020 00:22:25 -0400
Message-Id: <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591584631.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore events with a type of 0x0012 and a code of 0xe035,
this silences the following messages being logged when
pressing the Fn-lock key on a Dell Inspiron 5593:

dell_wmi: Unknown WMI event type 0x12
dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 0b4f72f923cd..f37e7e9093c2 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -334,6 +334,14 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
 	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
 };
 
+/*
+ * Keymap for WMI events of type 0x0012
+ */
+static const struct key_entry dell_wmi_keymap_type_0012[] = {
+	/* Fn-lock button pressed */
+	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
+};
+
 static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
 {
 	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
@@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
 			break;
 		case 0x0010: /* Sequence of keys pressed */
 		case 0x0011: /* Sequence of events occurred */
+		case 0x0012: /* Sequence of events occurred */
 			for (i = 2; i < len; ++i)
 				dell_wmi_process_key(wdev, buffer_entry[1],
 						     buffer_entry[i]);
@@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
 			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
 			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
+			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
 			 1,
 			 sizeof(struct key_entry), GFP_KERNEL);
 	if (!keymap) {
@@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device *wdev)
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

