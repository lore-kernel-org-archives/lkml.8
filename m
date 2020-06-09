Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43181C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183EE2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="xghB3yGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8IaE8ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgFIDxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:53:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56809 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbgFIDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:53:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 61B2D77D;
        Mon,  8 Jun 2020 23:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 23:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=2OJ7q9XBx4ZlW
        ZcE1YPyTXVaOzdZWcK7ysnEQ+5usds=; b=xghB3yGY1gpIOZLtLmKQDYW/H++ii
        k3e3jMXeiwoO36zSNssTAUo4dMGZsBp4+UzWKGT928PE/HASecr7/4HS0VWrp3ni
        F6viFDzIwZSEoI78+97Gy7gOkNj6kCwfMXNTiNUZmmr3ZVzyekaU6YNNxl1pBSRT
        hxQ5VbaXNBh0FL2+ktBEi2t1t0N7iEb9zLPaYkHfzlrJtPfauPmPEokybNoDiW1N
        ZFDUBTG3QLfiRrUX8qaKAW1qF6Sg73EN78U/utioJSZF9HDbhNNzWu6KxmoP2TYF
        xQMTsagpNJlTVD7AXhx64BN6WWJKtrOiIfeb2dUeNaEsh8JhLxO2RA4yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2OJ7q9XBx4ZlWZcE1YPyTXVaOzdZWcK7ysnEQ+5usds=; b=Q8IaE8ak
        00I8yxl1z7/3Qxukx0LSrvlPNrpJ+EdQJ0w5PByM+PJWzmoRobtTLN7fKTRqawQa
        1umVoomvA/jCN2zPMiotIHI3bQa0QczgHlMMTngDDHH9/6n6kteWEu4CgjAUk9RN
        HzPwV/DQDWqPQdwYrNbyuDTaWCL91hnHec4Ua0qM3/h2H+vM7QuZ798Ik9lkdCJs
        lS2WG6ZjnDNN4AGinbpS59E9U0aWMUobFHRhcRq1U+ZNpRHwQA/xuSKa5o4dLatL
        LaQjdwUO4wyLSPZ+xWBCfwuXj7ETxInko9dhZgLf6BtC90VFbxhlU2k3cUJwQ7hS
        ysqrVcpI6ydVCw==
X-ME-Sender: <xms:pgffXr7E8fOL-IWUQ9wDleawmc0oV5SDZtXkthgQIoK3qw-XO9RJdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghr
    ihhttghhvghruceohidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrf
    grthhtvghrnhepjeegfeetleeuleevteejteetieffgffgfedvffffvddtvddvveevhffh
    tdehudeknecukfhppeeijedrkeegrdduleegrddujeehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgv
    rhdrtghomh
X-ME-Proxy: <xmx:pgffXg6V0X9JT9AzhjQxsZlaE9gs8l4uMSHbV32fflbN-lH6zbZ9Gw>
    <xmx:pgffXidjbzyc-HeROn2dEry4ePTGA0W-N0uELocnfb_JD5s5qUB1Xw>
    <xmx:pgffXsKtWU2VGWWUNWDmaSZz93QXAhHUHibXwU7TlnU1B70x-uub2g>
    <xmx:pwffXljv22F2C9koR27_sT5Z7nykVa3IS7pOnsYk61VdDczB7mDzjg>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACBEA3280066;
        Mon,  8 Jun 2020 23:53:10 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 3/3] platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
Date:   Mon,  8 Jun 2020 23:52:54 -0400
Message-Id: <e2f6b5ee27a3a6142a2f8806be8dfbce442548da.1591673143.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591673143.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591673143.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks to be a special value for some sort of custom scancode.
This code could not be triggered for any keypress and is included
from the 0xB2 DMI table.

This prevents the following messages from being logged at startup on a
Dell Inspiron 5593:

    dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
    dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff

as per this code comment:

   Log if we find an entry in the DMI table that we don't
   understand.  If this happens, we should figure out what
   the entry means and add it to bios_to_linux_keycode.

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index e3bc2601e631..bbdb3e860892 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -506,7 +506,7 @@ static void handle_dmi_entry(const struct dmi_header *dm, void *opaque)
 		u16 keycode = (bios_entry->keycode <
 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
 			bios_to_linux_keycode[bios_entry->keycode] :
-			KEY_RESERVED;
+			(bios_entry->keycode == 0xffff ? KEY_UNKNOWN : KEY_RESERVED);
 
 		/*
 		 * Log if we find an entry in the DMI table that we don't
-- 
2.27.0

