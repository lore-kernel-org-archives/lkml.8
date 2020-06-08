Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55088C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE220760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 04:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="Gs9PR26V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILdOhKpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgFHEWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 00:22:49 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49369 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgFHEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 00:22:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F86F5C00C7;
        Mon,  8 Jun 2020 00:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 00:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Jm7oie8tshtIW
        I2PTX1JoPPNOW2IXpp24a+IngzjS3M=; b=Gs9PR26VlflbL3gvDXfu9+rfj71QY
        JDu5Qq7Q7r+29byhP+yzLWGP+Ni05LEPjmkgGI41/eccrDzoLvnuJ4KkKXj7QoJm
        PAXamito1K574dJOk96kekSMga2dRTE3jtemNCDPbPoNC/xoy0fx92BNIiNLOByE
        tYmnJ3/GczquOrGPWOSq5lUY9xhAzz/aDElrzsTrOtG9cX0M5QEtGXpwWRzxHlG1
        DC97PvST8WFJ7jf/RaAyvoEfrRsYXg860P3WZh8GKBDUUOumy+3+DqXzzNWty2xZ
        LZAeJXuwWHV5Jq8E8a10p17/BLVeoRucS/WWpKnVL5BBlZr+dtjm2WP3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Jm7oie8tshtIWI2PTX1JoPPNOW2IXpp24a+IngzjS3M=; b=ILdOhKpM
        1tEuMxh/8kuw/9qbQqMIvScR+Z3dXiODEihmwG3GwuP9qLFMeOeo7FJSSDnb6Yah
        Tq2jQAeb0xS1A4dU7L5PP8eJLmcxBSJBGlsrwKkR06+RabKe5WFoS41cnf/Rlfql
        46cW6gcfQARZEEr+SPpa6g57hNSSsEOs8QeS5LbnDciU65IXDx/sbGmKXTmFngYr
        QyN1qGji4pbLV1LSmX6JKd5RgOaySPTd0dwSi+2mOFFZKMo7p957DCLnAAngys8K
        mV2B82Q1n1lWmFQva5xTjR2ymrhWoJg+VbEU3pheRGL6f5OA7ChwS06DO3zqRZMp
        kOdbQgCPd51KgQ==
X-ME-Sender: <xms:Eb3dXtY7bI--zmeBFYj4WTH_LF2v9Hew9Ct9CgXljEKx7qHvCIbpMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhephffvufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinh
    hugiesphgrrhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfeetleeu
    leevteejteetieffgffgfedvffffvddtvddvveevhffhtdehudeknecukfhppeeijedrke
    egrdduleegrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephidrlhhinhhugiesphgrrhhithgthhgvrhdrtghomh
X-ME-Proxy: <xmx:Eb3dXkbaFVRPCjWIb8VXc1Z0F_Ccsaeg1Q4Baq_S5hOx2c_wrYekbg>
    <xmx:Eb3dXv8rUVO6wefQeu7dli_6ChtiNQgCWcbmsWgSo8g6HH0VK8oq3w>
    <xmx:Eb3dXrpBDl0ZUThLMZ8gd-8PMSV4ABessWt7wCt8dpcyKNZC_fa7LA>
    <xmx:Er3dXvQp8gyBK-fMpf46m10hJ8l7Z7k5qgpCx7T8peKJXMP72XbF_w>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id B85583280064;
        Mon,  8 Jun 2020 00:22:41 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 3/3] platform/x86: dell-wmi: add keys to bios_to_linux_keycode
Date:   Mon,  8 Jun 2020 00:22:26 -0400
Message-Id: <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
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

Increase length of bios_to_linux_keycode to 2 bytes to allow for a new
keycode 0xffff, this silences the following messages being logged at
startup on a Dell Inspiron 5593

dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff

Signed-off-by: Y Paritcher <y.linux@paritcher.com>
---
 drivers/platform/x86/dell-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index f37e7e9093c2..5ef716e3034f 100644
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
-- 
2.27.0

