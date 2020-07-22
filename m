Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE48CC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A13E2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="deuXnCCH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALyWDWGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgGVWsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:48:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbgGVWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:41 -0400
Date:   Wed, 22 Jul 2020 22:48:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jiZr9OI2nURziBYbmcqTV2pR8v4WZmMUcVBptqs0iE4=;
        b=deuXnCCHQw7t06dBjaI2r3xHmg+Zw0oZa7h2LxACCWUfC8UvtXK2jM3PZakH//mBVTGy40
        WK0O81PiS4FnZpbYbcLMGxfYpbWj4Ld/yYz3dTRe8+fgaIsBeGp6Q73GoloKkit7CaDvfj
        9QviYReZhQa4TGVWFtPR08AwRohqrfkoFZjiGjaKgoel2N1zqasejULHC8vkR42s3zlkVn
        10jsp7eOIZ9DfqxCY47qKqh43gRHpjTZOTJrFuxjbR3Vcesv4oU79MN3n802ThZV6nTu9U
        1axgZS4db6pjMtOMVNMp9K3fXQArT0VzcZQYmfFy7jGW3eJ/zRS2m9ysLMtoFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jiZr9OI2nURziBYbmcqTV2pR8v4WZmMUcVBptqs0iE4=;
        b=ALyWDWGV25e/yllGsLnGJDydyQPOj6bUXXL1D7XgfyuUVExa09knTzaM/TUH51wHazTF4w
        XogyYqGxG5MYSsCQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Revert "efi/x86: Fix build with gcc 4"
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159545811862.4006.10590013695157698470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     769e0fe1171e95d90ea5a2d6d0b2bdc7d5d2e7b2
Gitweb:        https://git.kernel.org/tip/769e0fe1171e95d90ea5a2d6d0b2bdc7d5d2e7b2
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 09 Jul 2020 09:59:57 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 09 Jul 2020 10:14:29 +03:00

efi: Revert "efi/x86: Fix build with gcc 4"

This reverts commit 5435f73d5c4a1b75, which is no longer needed now
that the minimum GCC version has been bumped to v4.9

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4cce372..75daaf2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,8 +6,7 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
-				   $(call cc-option,-maccumulate-outgoing-args)
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
