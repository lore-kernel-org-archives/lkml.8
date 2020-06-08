Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEA2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FF72078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="65qAa+8M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaC2b8pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgFHXG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:06:29 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38535 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbgFHXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 28EC2893;
        Mon,  8 Jun 2020 19:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 19:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=AELJZh/EU6f2U
        BkhqjDLJhUQN+SlucJC+NrGqLu0VFs=; b=65qAa+8MeEhDmsyRiCwqcDCn3Bf5K
        TnIgcDpoMvBtgO4yDTzKjPEz63HXTYXVi1E5n1xuMkOID6z4vQZ4Amh5iY8Daa0O
        hO1BbHs8CmwmeakQQ8h9wZ5bdG5G6PhrsEI7V1QEwc6qrX7vkXFOclsH5XvEE0pr
        1lTYmRT8NhN2T3SJPiMwfqak9J4puMqikW+t96K9vcfRBu2bjyegitMdXTC6LfV4
        L40/SS9aQp1jPdYocmMg3L6AgIafaGXZGMjS43Fz/RfynSKXyhjNfNqLm7XFw5Rr
        RGgjvNl8XYpYXkS6/QZo2BAWPDCPvZCDTGOsgjVpCur3tNizGtJ/eK+OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AELJZh/EU6f2UBkhqjDLJhUQN+SlucJC+NrGqLu0VFs=; b=oaC2b8pD
        DRlTHxDh2MUF0qyEtVV+RcyQbZQSi/SIefyj+c0DQWqvvaIOORGWA33J4OZBKXzW
        zLedE6RfKtI0SCkt/c1q7SWYWddu2Ww0MS5onv/DOpvGaAv4ElR2GYIUU9zXQH3m
        YTKnuGM3IW9bX5gNDuQHFZqY1jHwPGUr5ud152+xqsLuP3QqWNrYQ0kZpS0o2q+D
        YZAbhBQ6tY5AZRAtweC0toWHobDn2VNyNIMzgcy16kvA3xDDGbwdL6WdIhoowAwW
        +yRcU8yiuD4+m/l8zN67q6+sKInFfdAvinAt9MmiucY15w3Y5DPXkvrOUUV1cd1u
        ebOuReachZCMUg==
X-ME-Sender: <xms:ZsTeXu8x8hax-ueDR5QLYaxVfICNQl7tlar1pQ5eknaYqKs46giknw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:ZsTeXusYRvCijjCSKpryjIOlHcGrOOZ9ndqpu7VWUXZ5lYYbvTb5qQ>
    <xmx:ZsTeXkAWQALsQ0XFyC1lw9qaFh-qllNDqKQkZCcFTVReMnT6HIBMKg>
    <xmx:ZsTeXmdlKtFODnVp3bEdW1QOJKub3owGpMDeyqhGwRT2jzYqxqdZzQ>
    <xmx:ZsTeXp0WrAc438IOMW8p1bk-gQ0_EQ2_MZOXh-5v6vKLtG0nxOHCsA>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69755328006B;
        Mon,  8 Jun 2020 19:06:14 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to bios_to_linux_keycode
Date:   Mon,  8 Jun 2020 19:05:30 -0400
Message-Id: <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591656154.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591656154.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase length of bios_to_linux_keycode to 2 bytes (the true size of a
keycode) to allow for a new keycode 0xffff, this silences the following
messages being logged at startup on a Dell Inspiron 5593:

    dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
    dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff

as per this code comment:

   Log if we find an entry in the DMI table that we don't
   understand.  If this happens, we should figure out what
   the entry means and add it to bios_to_linux_keycode.

These are keycodes included in the 0xB2 DMI table, for which the
corosponding keys are not known.

Now when a user will encounter this key, a proper message wil be printed:

    dell_wmi: Unknown key with type 0xXXXX and code 0xXXXX pressed

This will then allow the key to be identified properly.

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 6b510f8431a3..dae1db96b5a0 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -196,7 +196,7 @@ struct dell_dmi_results {
 };
 
 /* Uninitialized entries here are KEY_RESERVED == 0. */
-static const u16 bios_to_linux_keycode[256] = {
+static const u16 bios_to_linux_keycode[65536] = {
 	[0]	= KEY_MEDIA,
 	[1]	= KEY_NEXTSONG,
 	[2]	= KEY_PLAYPAUSE,
@@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] = {
 	[37]	= KEY_UNKNOWN,
 	[38]	= KEY_MICMUTE,
 	[255]	= KEY_PROG3,
+	[65535]	= KEY_UNKNOWN,
 };
 
 /*
@@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct dmi_header *dm, void *opaque)
 					&table->keymap[i];
 
 		/* Uninitialized entries are 0 aka KEY_RESERVED. */
-		u16 keycode = (bios_entry->keycode <
-			       ARRAY_SIZE(bios_to_linux_keycode)) ?
-			bios_to_linux_keycode[bios_entry->keycode] :
-			KEY_RESERVED;
+		u16 keycode = bios_to_linux_keycode[bios_entry->keycode];
 
 		/*
 		 * Log if we find an entry in the DMI table that we don't
-- 
2.27.0

