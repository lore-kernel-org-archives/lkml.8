Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDD7206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgEVSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgEVSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D5C061A0E;
        Fri, 22 May 2020 11:30:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCQy-0002kr-Kl; Fri, 22 May 2020 20:30:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E7FD1C0095;
        Fri, 22 May 2020 20:30:16 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:16 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] x86/boot: Mark global variables as static
Cc:     Mike Lothian <mike@fireburn.co.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511225849.1311869-1-nivedita@alum.mit.edu>
References: <20200511225849.1311869-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159017221614.17951.9790248963724097639.tip-bot2@tip-bot2>
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

Commit-ID:     e78d334a5470ead861590ec83158f3b17bd6c807
Gitweb:        https://git.kernel.org/tip/e78d334a5470ead861590ec83158f3b17bd6c807
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 11 May 2020 18:58:49 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 14 May 2020 11:11:20 +02:00

x86/boot: Mark global variables as static

Mike Lothian reports that after commit
  964124a97b97 ("efi/x86: Remove extra headroom for setup block")
gcc 10.1.0 fails with

  HOSTCC  arch/x86/boot/tools/build
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  error: linker defined: multiple definition of '_end'
  /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
  /tmp/ccEkW0jM.o: previous definition here
  collect2: error: ld returned 1 exit status
  make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
  make: *** [arch/x86/Makefile:303: bzImage] Error 2

The issue is with the _end variable that was added, to hold the end of
the compressed kernel from zoffsets.h (ZO__end). The name clashes with
the linker-defined _end symbol that indicates the end of the build
program itself.

Even when there is no compile-time error, this causes build to use
memory past the end of its .bss section.

To solve this, mark _end as static, and for symmetry, mark the rest of
the variables that keep track of symbols from the compressed kernel as
static as well.

Fixes: 964124a97b97 ("efi/x86: Remove extra headroom for setup block")
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200511225849.1311869-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/tools/build.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 8f8c8e3..c8b8c1a 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,14 +59,14 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-unsigned long efi32_stub_entry;
-unsigned long efi64_stub_entry;
-unsigned long efi_pe_entry;
-unsigned long efi32_pe_entry;
-unsigned long kernel_info;
-unsigned long startup_64;
-unsigned long _ehead;
-unsigned long _end;
+static unsigned long efi32_stub_entry;
+static unsigned long efi64_stub_entry;
+static unsigned long efi_pe_entry;
+static unsigned long efi32_pe_entry;
+static unsigned long kernel_info;
+static unsigned long startup_64;
+static unsigned long _ehead;
+static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
