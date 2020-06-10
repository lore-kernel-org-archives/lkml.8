Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C212C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688F62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="A0iskHp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N81LhWZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFJR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:57:28 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37641 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgFJR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:57:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 39B6F77D;
        Wed, 10 Jun 2020 13:57:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jun 2020 13:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=KFHjFgl8Nl0mN
        4saWbnmKFhbyNQI/P4uhTVdUXtr0Ak=; b=A0iskHp5fuvv3HtbTns7eDJvo3irN
        FMIsIisxbZkZar5+yeZakI4bHgxprgWcmAnido1BakWJHXzqD15lHI9I3NZEbGEE
        ngnpeLSfcfHRqnZYTFfT+ZUlIveAQda8+EfvfQvGgdNO/GQ8pZN/6sFkT2GicGYi
        mXMZ4iouJQJADvhQxW9e2mQvQScqm6p5aeL62NqFnk8HaxRFTBOL9UX/K/NkdJB+
        XcddVBHsM8GQbmPNejew8djpU4pRhgf0ggV1bu7eK4/ABtPSRfjAOU+XRHb79uWo
        I/Mgq34k2MA+TYiXTNCiTyiwK0eQmGVQlvBXiIhqyU4/xZ8DWgVpLF4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=KFHjFgl8Nl0mN4saWbnmKFhbyNQI/P4uhTVdUXtr0Ak=; b=N81LhWZC
        J62xh10oD2/9kN3JbEHvTdsYaah8xtIfbZZPCi9nR2BQwOR2KbyfDjql0etb9e+f
        GpaBAXOXZN1vADXapCS8aGLkx1n9VA1h8qAkxR8iXm2VqwGZK8Q7XbKBiMyC3BT1
        WRZdOCqjDZ1nvyvmf+2gStlRfS6Q940UPVDAyGHztc/n2WxN5Wwpbt9FycbdGO9t
        K1I8Otp5cO5O6lRWtXH8R6YE+hLPPJ9mu+SAq0Nt5VnqatDnl3Uuj/mnAKS4XA/R
        Awv1KBldAODE8/SvCOmmZYOFbWskmIrfZrWJOAhZ+H+wMRTNVO5wAAtLElLIjvHJ
        4+cpYBkNShNTwA==
X-ME-Sender: <xms:_B7hXhB8lnXbhApKBqjOG0H0f_RhVy-5V5kkXkwTS1A8-sl8vznGOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjgcurfgr
    rhhithgthhgvrhcuoeihrdhlihhnuhigsehprghrihhttghhvghrrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejgeefteelueelveetjeetteeifffggfefvdffffdvtddvvdevvefh
    hfdthedukeenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:_B7hXvhOP8uENS5VAu1zXBCHSJat4Eet91HUPoxJeEGXyubKE_RJ_g>
    <xmx:_B7hXsnH5z7sjpmL-yFyV2vyrqeReonsCz0n5Bmto4B1VvQsG28nbA>
    <xmx:_B7hXrwSXsYNcISPIwhCeQoptMugVfpiq0P2fYpbIr2RZjgdiuiOQQ>
    <xmx:_B7hXpI5RpQuW6Zm-2XvBqI7w5tlBUN59DG6IMOf4D21nI15i39oow>
Received: from localhost.localdomain (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4E873061DC5;
        Wed, 10 Jun 2020 13:57:15 -0400 (EDT)
From:   Y Paritcher <y.linux@paritcher.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mario.Limonciello@dell.com
Subject: [PATCH v4 3/3] platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
Date:   Wed, 10 Jun 2020 13:56:58 -0400
Message-Id: <b388001d4804871f03067dbbe134f7368c8b5b25.1591811549.git.y.linux@paritcher.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591811549.git.y.linux@paritcher.com>
References: <cover.1591584631.git.y.linux@paritcher.com> <cover.1591811549.git.y.linux@paritcher.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keycode is used by Dell as a no-op for keys that should have
no function.

This keycode is never triggered by a keypress in practice, rather
it is included from the 0xB2 DMI table at startup.

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

