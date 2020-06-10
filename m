Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA64EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A652C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="NGEgssEg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2RXWORA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgFJR5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:57:18 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52057 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbgFJR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:57:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5689E789;
        Wed, 10 Jun 2020 13:57:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jun 2020 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=SNYfQnNJHBNL+
        mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=NGEgssEgv5DNIP1IxpsgR0Ju5kr6m
        4Cj9gN0IsUl2M8ddNmbyCtEIMi7xsA0a7aSmX5h3AscnvIE1uBacjE8WcWRYBn+g
        JjXI9uH93e5TFaWH9TnTox6C7pFIvnkQe/LUKAqKu5hPhEnXEm9+wbLpWtglylJW
        4nxqImHE1VJQcMtqKOzprdPAnpXU+cmu1hsl9dmcvWplzwf5hD+27CHQ4dOS77vl
        G/peBCB7beoANLCx6o8U/+dauNFcgrxcTlXizFUM0jTaP12AHhGa1/08ADilC4Up
        79Bw9xfOI1FfXsd+ddxHn7oiOszOVUtyH4CnJ+T4g9/x55cuffz82vv1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=SNYfQnNJHBNL+mznkaHt3WrMBC/udR8ETUg333Vw1Nc=; b=U2RXWORA
        cYCr+w2Jva8BjjLTqJfZS2Ojdh59TLbt28wpxm6hB82cDjaoiOc7ocperxnrWywK
        9KJN+sIYh+BrX2vbH2mYiZp6dSSBR57TR78uWsQDJGai4hfQyfBRAl94zru3vcho
        QSNjhjA9xsnqAAEToAMY1i9G9f4P+pBgJKZKtAjutUM7o9e0ckFd/9hLkyy23fwF
        l6n9oaUKKqqWMjK5UsLR4nq6Pql/UAxhb/OjhgUjpmsQ5RhQNYqGxa0NZ/oNYNoA
        lG0dtwctyBlPDmXap0WeMZpRIienqgVFMC5vEygiiSoSFZzR6IG/kIeRzuRwuHyO
        xtoyV4mUBzmL5Q==
X-ME-Sender: <xms:-x7hXgHfBgj0vnoJ5lAH7MQS1EbQbjp9reCPn6AOLlMGzO3yNhlMuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejgeefteelueelveetjeetteeifffggfefvdffffdvtddvvdevvefh
    hfdthedukeenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:-x7hXpX1KVI7m1VWoDMiKHFn7Oy8s4WNze_60neA6Rqz2-xyrUem8g>
    <xmx:-x7hXqLGPUE9wIDLamw8baPxJ07OzzMKlV8-Iig1iX1CIV6GH1zO2w>
    <xmx:-x7hXiGL_iUvuosOHO48jYl-TYb0ewteLALVstqeqTNMIzmB6JhiZg>
    <xmx:-x7hXpd5VbSBNTYZ2KPBL8LbyNigogl47y5FLqHNpYltlOU2ZJzsnQ>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BC7630614FA;
        Wed, 10 Jun 2020 13:57:15 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v4 1/3] platform/x86: dell-wmi: add new backlight events
Date:   Wed, 10 Jun 2020 13:56:56 -0400
Message-Id: <50885a0c51c6fb31d20ddeb7434572448f1453be.1591811549.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591811549.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591811549.git.y.linux@paritcher.com>
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

