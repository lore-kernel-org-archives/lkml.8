Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F9C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="foF0NqRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylZc9xKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbgGVWs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:48:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgGVWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:46 -0400
Date:   Wed, 22 Jul 2020 22:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fqjmv8MjIlaqve5+muPh3xQ907gB9UTetbhEATMxpaU=;
        b=foF0NqRSeY3NqTIfEGPsWkM+z5gjMsByvmRKKn3ZWJez2HVlmC1aqOG7dLZDldD1tQhOMc
        BeFiVDIvq/XrD7FsHCE0GE+cxIZ6UyppAMef9OrW7iSbkn1oqPt+r7TCl0jFU85/lAFpHb
        5v0r4pd/upoJXEUiK2F4hRqoclcxvhwqc92M5ReyG97W+44d6+n9OXXa80I51nMHLxQWxa
        /yqezhHvjdXSpJP82FHFO6FbdKn8g/HrufTGEp34wOiW2bWjZHemw2P73TGtkdxioPrRJq
        +QMVDkDVzsD2mscpFkKgMQtoMZxziGMooDh/XxfTAosWaIFgbQ8JZrw0nTh/SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458123;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fqjmv8MjIlaqve5+muPh3xQ907gB9UTetbhEATMxpaU=;
        b=ylZc9xKlGw4eGshLg51up40KyagAcq1iXyaJgupF2qhID8Iu0NHiyJoxJ7jX4jsMjugLC2
        Cp8YzsstuWSrM2BQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Only copy upto the end of setup_header
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159545812288.4006.15411570516545627500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     59476f80d8781a84e25f0cbcf378ccab1ad7abf8
Gitweb:        https://git.kernel.org/tip/59476f80d8781a84e25f0cbcf378ccab1ad7abf8
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Thu, 18 Jun 2020 16:43:15 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 25 Jun 2020 18:09:48 +02:00

efi/x86: Only copy upto the end of setup_header

When copying the setup_header into the boot_params buffer, only the data
that is actually part of the setup_header should be copied.

efi_pe_entry() currently copies the entire second sector, which
initializes some of the fields in boot_params beyond the setup_header
with garbage (i.e. part of the real-mode boot code gets copied into
those fields).

This does not cause any issues currently because the fields that are
overwritten are padding, BIOS EDD information that won't get used, and
the E820 table which will get properly filled in later.

Fix this to only copy data that is actually part of the setup_header
structure.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 37e82bf..3672539 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -8,6 +8,7 @@
 
 #include <linux/efi.h>
 #include <linux/pci.h>
+#include <linux/stddef.h>
 
 #include <asm/efi.h>
 #include <asm/e820/types.h>
@@ -388,8 +389,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 	hdr = &boot_params->hdr;
 
-	/* Copy the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512, 512);
+	/* Copy the setup header from the second sector to boot_params */
+	memcpy(&hdr->jump, image_base + 512,
+	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
 
 	/*
 	 * Fill out some of the header fields ourselves because the
