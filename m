Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529CEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F87207FB
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="SsP5F7dT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZ920Xh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgFIBKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:10:13 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56317 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgFHXGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 133F6889;
        Mon,  8 Jun 2020 19:06:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 19:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SNYfQnNJHBNL+
        mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=SsP5F7dTwaaGH06XzPjCbw3Z3icH2
        Z8JOBHnbPVJnjYewIsOVvdtnXsb38S2a/tR8JpslgHQEJfXxh4cJcgLuDi07lIgi
        vlkX7Xq6WsLkeIWyUOEC8Uk7gmnAvkWlfGlCGvaUUuB7H18FfQ9LUyQO8cybaSew
        wCKK1U4SFupG7Ts2eOQa3Okau+B9q6omwOGbHQDauikJHGFvluMC+ibkmxWmCLZ4
        a7UzPfKyCC5bfiNNHEFHCYXq1MiBF1W8zuBisft8LOD8wujck9SfgVLwWbSwrcUI
        UrUwZPIJs3Lgr4s6ZL36nj5ylSX4rhW+7n5de5Eofqy5LbHFEBUwslDvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SNYfQnNJHBNL+mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=SZ920Xh9
        ZdtCjq10lUTu90DMVu7T5EcTjF/8U/rUbFHCLGFWf3PzwdeyplAG3DxY2a0Lif8G
        RUaBCteftLnhCFfAu0bll5SUNAHOcJ4eaFLMa40WPMltzbuC9PKRCmetZuMJaGVD
        BZeXj79U/0m4+rIUG6W/j4TEQOIeojLMo4RywuZZhQel1sLJGQKhb1YpX7RnjzC4
        NDLgKEenwFWToP+W53a8HV7Y1aADgTJzoCtj6Y+7VmedccRvwGT3NpiIzZcvd21+
        sV2rj4E7S4Y3CrOTtJOEjnCDy+b6rEQspPj6PsYh8s87WrswaWZ6XQVwovP36hCS
        rpIDms3yY8SgrA==
X-ME-Sender: <xms:ZsTeXkNHoCWCtlXA16hySSCxppcTj8ofvpL9A6f5eAycmMv8L6BMPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:ZsTeXq-l_hiWAYeG1uCtrlUR1vNFMBDNZ67RTlzDQIFLEmd8FB7XJg>
    <xmx:ZsTeXrQd_OOOJM44b4N1HI_YQCrXj5oTdPQunbR_zEsH_flHOuMLJQ>
    <xmx:ZsTeXsvJ21PEv9v9xSKj9oUDOtx4Op6f1jVuOKcOjVScXrf9_62sGw>
    <xmx:ZsTeXoEjWKyHnXqx5KResPPmVU4WGWLyKzMG3dGVIEiWuEkllycL6A>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2A18328005A;
        Mon,  8 Jun 2020 19:06:13 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v2 1/3] platform/x86: dell-wmi: add new backlight events
Date:   Mon,  8 Jun 2020 19:05:28 -0400
Message-Id: <1ddd0496403199130532923e4ccb30481ff167b6.1591656154.git.y.linux@paritcher.com>
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

