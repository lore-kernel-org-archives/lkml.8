Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D02C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BD7207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="qrF/8kfO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZHmgc7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgFHEWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:22:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46629 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgFHEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:22:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 022385C005D;
        Mon,  8 Jun 2020 00:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 00:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ZX7j0sscd9FWU
        Y+DCFa2yrCLEJZofaSejuWgpW7dvE4=; b=qrF/8kfO5IDjqvtkhbBhNwX6w5e7F
        WlGI616/42W6jkelcJd01dNy5zEa8fFIfOZlG24TaUeqj7hvwXyvTPemGrhAZpot
        ug+xW7FWLbV+V05IQ1rNhtPvRX7B2CUfKQY8h/dPF+gXx9XX4K3Yf79ZpJ7DWTpr
        ryycrVJ4WVZGnCiRwoiqOnZ7MBrraSirscgBN5YW3foIgf/RYVGfofDtcFb7Ijke
        UIjKboolFeLAE0p0XVv77SbTS/6b0zPvHi/LtKN3zRMTer8U10FYG5w91qmpTY3m
        kxIt+GT8F6cbXN4PCZ5MJ84J/ki+HESnSJCcqbjZBnnVnKvT5+2m1h8fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZX7j0sscd9FWUY+DCFa2yrCLEJZofaSejuWgpW7dvE4=; b=FZHmgc7c
        /Gb6zce8lJ2AHZAJ0uT76BAPJcHa3crmpAAkwsXO+4kjZ5pAIlIJdA3hwl41hQ8p
        RZCIN/3Ws6i4frH22bprwcDYllUruZAu20aMnUS9weVvgX0KApsXN96x/6Iy3PlF
        k9EI0mDZMEKrJctTIKEifmvgqigSy/qkeG3cvGVCmmdVuwppeohKWqyjQ8AGIf+3
        QWY6DOzebAo7kHUNmgqg3rzqtQGCQheCXvcdVOgoGdjbTqHZuITD4+WWTlOd9QSL
        GIsRBq/7TyQHy9iXQreUJ2x3ubdnMFeGmCiytq32XU1OP97uzOpUDRga7hKBa7rK
        O+lxrmt1X8lT1g==
X-ME-Sender: <xms:Eb3dXuYvzonj_AJ2qCi56cgNE6z4nU4Wai--WCMG46xw8UZ_UJUeng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:Eb3dXhYl0c80f1WH0710yHbxqxGCVd2-bk4_FS9gvtRqfd-Kd_aSsQ>
    <xmx:Eb3dXo_mBp9hxkvmx1SLK1ZGP0zmIj7SzkyTDISumWsOC9-_UHzY2A>
    <xmx:Eb3dXgoRzLv57_ysEU3WaooIvnY_Sd-cwFTIU-t5_ssQIdsCJwb0-Q>
    <xmx:Eb3dXoSmDhWMw8okXQaOly7jL2JYhNJ170mHyyQyTzIwYuQYodDjfA>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68BBD328005E;
        Mon,  8 Jun 2020 00:22:41 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Date:   Mon,  8 Jun 2020 00:22:24 -0400
Message-Id: <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
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

Ignore events with a type of 0x0010 and a code of 0x57 / 0x58,
this silences the following messages being logged on a
Dell Inspiron 5593:

dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index c25a4286d766..0b4f72f923cd 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -252,6 +252,10 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/* Fn-lock switched to multimedia keys */
 	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
 
+	/* Backlight brightness level */
+	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
+
 	/* Keyboard backlight change notification */
 	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
 
-- 
2.27.0

