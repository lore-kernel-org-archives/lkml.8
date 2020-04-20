Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A6C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0524520736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgDTUDM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgDTUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:03:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C8C061A0F;
        Mon, 20 Apr 2020 13:03:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQcdD-0005zY-48; Mon, 20 Apr 2020 22:03:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 88B281C007F;
        Mon, 20 Apr 2020 22:03:02 +0200 (CEST)
Date:   Mon, 20 Apr 2020 20:03:02 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] arm64/elf: Disable automatic READ_IMPLIES_EXEC for
 64-bit address spaces
Cc:     "Hector Marco-Gisbert" <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327064820.12602-7-keescook@chromium.org>
References: <20200327064820.12602-7-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <158741298213.28353.4215804588736774881.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     6e0d6ac5f3d9d90271899f6d340872360fe1caee
Gitweb:        https://git.kernel.org/tip/6e0d6ac5f3d9d90271899f6d340872360fe1caee
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 26 Mar 2020 23:48:20 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 19:44:27 +02:00

arm64/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces

With arm64 64-bit environments, there should never be a need for automatic
READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
(as in, the default memory protection should be NX unless a region
explicitly requests to be executable).

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lkml.kernel.org/r/20200327064820.12602-7-keescook@chromium.org
---
 arch/arm64/include/asm/elf.h | 4 ++--
 fs/compat_binfmt_elf.c       | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 0074e9f..0e7df6f 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -105,7 +105,7 @@
  *                CPU*: | arm32      | arm64      |
  * ELF:                 |            |            |
  * ---------------------|------------|------------|
- * missing PT_GNU_STACK | exec-all   | exec-all   |
+ * missing PT_GNU_STACK | exec-all   | exec-none  |
  * PT_GNU_STACK == RWX  | exec-stack | exec-stack |
  * PT_GNU_STACK == RW   | exec-none  | exec-none  |
  *
@@ -117,7 +117,7 @@
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
+#define compat_elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index aaad4ca..3068d57 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -113,6 +113,11 @@
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
+#ifdef	compat_elf_read_implies_exec
+#undef	elf_read_implies_exec
+#define	elf_read_implies_exec compat_elf_read_implies_exec
+#endif
+
 /*
  * Rename a few of the symbols that binfmt_elf.c will define.
  * These are all local so the names don't really matter, but it
