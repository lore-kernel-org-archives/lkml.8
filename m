Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CA1204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgEVSad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgEVSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D259C061A0E;
        Fri, 22 May 2020 11:30:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCR0-0002lu-2u; Fri, 22 May 2020 20:30:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 99DB21C0475;
        Fri, 22 May 2020 20:30:17 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:17 -0000
From:   "tip-bot2 for Dave Young" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/earlycon: Fix early printk for wider fonts
Cc:     Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
References: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-ID: <159017221747.17951.10521608377233608958.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     8f592ada59b321d248391bae175cd78a12972223
Gitweb:        https://git.kernel.org/tip/8f592ada59b321d248391bae175cd78a12972223
Author:        Dave Young <dyoung@redhat.com>
AuthorDate:    Sun, 12 Apr 2020 10:49:27 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 12 May 2020 12:29:45 +02:00

efi/earlycon: Fix early printk for wider fonts

When I play with terminus fonts I noticed the efi early printk does
not work because the earlycon code assumes font width is 8.

Here add the code to adapt with larger fonts.  Tested with all kinds
of kernel built-in fonts on my laptop. Also tested with a local draft
patch for 14x28 !bold terminus font.

Signed-off-by: Dave Young <dyoung@redhat.com>
Link: https://lore.kernel.org/r/20200412024927.GA6884@dhcp-128-65.nay.redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/earlycon.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 5d4f847..a52236e 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -114,14 +114,16 @@ static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
 	const u32 color_black = 0x00000000;
 	const u32 color_white = 0x00ffffff;
 	const u8 *src;
-	u8 s8;
-	int m;
+	int m, n, bytes;
+	u8 x;
 
-	src = font->data + c * font->height;
-	s8 = *(src + h);
+	bytes = BITS_TO_BYTES(font->width);
+	src = font->data + c * font->height * bytes + h * bytes;
 
-	for (m = 0; m < 8; m++) {
-		if ((s8 >> (7 - m)) & 1)
+	for (m = 0; m < font->width; m++) {
+		n = m % 8;
+		x = *(src + m / 8);
+		if ((x >> (7 - n)) & 1)
 			*dst = color_white;
 		else
 			*dst = color_black;
