Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC261C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91539204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405230AbgFSQq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405042AbgFSQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35010C06174E;
        Fri, 19 Jun 2020 09:46:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9T-00045N-Ao; Fri, 19 Jun 2020 18:46:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5CED1C074B;
        Fri, 19 Jun 2020 18:46:01 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:46:01 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/x86: Fix build with gcc 4
Cc:     Andrey Ignatov <rdna@fb.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200605150638.1011637-1-nivedita@alum.mit.edu>
References: <20200605150638.1011637-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159258516173.16989.16252579910825894796.tip-bot2@tip-bot2>
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

Commit-ID:     5435f73d5c4a1b7504356876e69ba52de83f4975
Gitweb:        https://git.kernel.org/tip/5435f73d5c4a1b7504356876e69ba52de83f4975
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 05 Jun 2020 11:06:38 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 11:41:14 +02:00

efi/x86: Fix build with gcc 4

Commit

  bbf8e8b0fe04 ("efi/libstub: Optimize for size instead of speed")

changed the optimization level for the EFI stub to -Os from -O2.

Andrey Ignatov reports that this breaks the build with gcc 4.8.5.

Testing on godbolt.org, the combination of -Os,
-fno-asynchronous-unwind-tables, and ms_abi functions doesn't work,
failing with the error:
  sorry, unimplemented: ms_abi attribute requires
  -maccumulate-outgoing-args or subtarget optimization implying it

This does appear to work with gcc 4.9 onwards.

Add -maccumulate-outgoing-args explicitly to unbreak the build with
pre-4.9 versions of gcc.

Reported-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200605150638.1011637-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf2..4cce372 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,8 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
+				   $(call cc-option,-maccumulate-outgoing-args)
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
