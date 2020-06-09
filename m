Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97244207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="KfCY5Eog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="icGueE+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFIDxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:53:13 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44329 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbgFIDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:53:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1793B6D1;
        Mon,  8 Jun 2020 23:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 23:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SNYfQnNJHBNL+
        mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=KfCY5EogqLIcRw2MKdcVD4Ht7CBYF
        31qf8HRZ4gp1KfJPqN4mY5j8cZm5uRhzUcy5rcPNLV6AgRjk+ZBasamIZS4xiMXw
        BvvHWosiggxBYNBlV7ypUIlDKVcfn54ojAOTphc162aHagSioL5aYgrxpqLbkXBt
        o7V9ydt6QPKEkvn4+gbENw5oy/92s5N/Q0YghjP9Dnl3VdEuSur4x89AdmiNZYAQ
        G0drILjFp74wvK+XFTo8FtfTt1G+rOHKVvmoVd2GM9DAEXheheabzEHFPeWt5Lmb
        SWg3YcnMSsiXmQBvmIbjiFILrWt3YH5fbGuEZJdOJea4ELFnC7RhDj4zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SNYfQnNJHBNL+mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=icGueE+u
        ZmCEvOCrYnbOrP3/grmkj0k+IJda2R+iAs4CG08CfAnDhXbFsAkpalraF4jxaX3C
        5DaDCmTdd3EZvi67lOTuspqEbDgcTr/iQvEltGRfvbqAECNRezmZ2g+mQ/EvDDIs
        FLOVIyvkaJH4Ntk0NJgtAw+xzS3C6rNGjqtbDv8wXycFrMHLA4euFndM1/w7c20U
        jSKXXOC0Qyyc52ZfMzQCots167efzQKQ99reaVdjFo15tZW49DjUHlV6LLBNLCxs
        cWr5ToQnlbSmzt3gprUE4ELo8KA1+G5n5t1kqqjnD0eJtA9rsyPAodjwKZFeS/sn
        G2umqrsRb/rxeg==
X-ME-Sender: <xms:pgffXncA_8HDE71Qipojp_X2hKfhTSPU4Ll-JzFvdj0WO_Hl4aUYEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghr
    ihhttghhvghruceohidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrf
    grthhtvghrnhepjeegfeetleeuleevteejteetieffgffgfedvffffvddtvddvveevhffh
    tdehudeknecukfhppeeijedrkeegrdduleegrddujeehnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgv
    rhdrtghomh
X-ME-Proxy: <xmx:pgffXtM4qJsLNkkT0Gqojtts9hLHRP_-2E6H4ZGuZQc5TgMuPpQfXg>
    <xmx:pgffXggckr14cUBBGENrIPEvMn42EcgKLZcPRIpaQNrzCOeQvrsY4A>
    <xmx:pgffXo-LqAhJMAyZJPIwtrbNfE3G-wsEcQTNrHpXqy8zXcYjZyVStg>
    <xmx:pgffXsXZaeQdkIlUcX4PME00Ivo51_L98haIAm2I6HcCyukf77N8Ng>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BFA93280060;
        Mon,  8 Jun 2020 23:53:10 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 1/3] platform/x86: dell-wmi: add new backlight events
Date:   Mon,  8 Jun 2020 23:52:52 -0400
Message-Id: <50885a0c51c6fb31d20ddeb7434572448f1453be.1591673143.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591673143.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591673143.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add events with a type of 0x0010 and a code of 0x57 / 0x58,
this silences the following messages being logged on a
Dell Inspiron 5593:

dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed

These are brightness events and will be handled by acpi-video

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index c25a4286d766..0b2edfe2767d 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -255,6 +255,10 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/* Keyboard backlight change notification */
 	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
 
+	/* Backlight brightness level */
+	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
-- 
2.27.0

