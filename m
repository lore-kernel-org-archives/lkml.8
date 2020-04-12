Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C01C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DF7206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABKvW/nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDLCtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 22:49:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726108AbgDLCtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 22:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586659778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VogcAM4f+7ZYGZP3VmVCoYpWE3MtWwpRfqsHtlQY+ws=;
        b=ABKvW/nRIPaYrJHY508S/C0Hey0yIhO4eklFiMZcWhzITuxTfmExjp1aETVWoSzzxXjtxI
        E5qQdCzCCnRhEGyngQ697x/BitEQkhfIBoStNovgZZibeTLtovL/m+AE+WOdfnfAqJsD5x
        5X4YH/CgfyN48a3cWx5x2U7tbXSMxlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-iwefRy8oOki2qNz0nU7NVA-1; Sat, 11 Apr 2020 22:49:34 -0400
X-MC-Unique: iwefRy8oOki2qNz0nU7NVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C977A107ACC9;
        Sun, 12 Apr 2020 02:49:33 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5514CFDE3;
        Sun, 12 Apr 2020 02:49:31 +0000 (UTC)
Date:   Sun, 12 Apr 2020 10:49:27 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi/earlycon: fix early printk for wider fonts
Message-ID: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I play with terminus fonts I noticed the efi early printk does
not work because the earlycon code assumes font width is 8.

Here add the code to adapt with larger fonts.  Tested with all kinds
of kernel built-in fonts on my laptop. Also tested with a local draft
patch for 14x28 !bold terminus font.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/firmware/efi/earlycon.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-x86.orig/drivers/firmware/efi/earlycon.c
+++ linux-x86/drivers/firmware/efi/earlycon.c
@@ -114,14 +114,16 @@ static void efi_earlycon_write_char(u32
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

