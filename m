Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45774C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295E221744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDTUDO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgDTUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:03:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53DC061A0C;
        Mon, 20 Apr 2020 13:03:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQcdE-0005zj-ET; Mon, 20 Apr 2020 22:03:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F402B1C0475;
        Mon, 20 Apr 2020 22:03:03 +0200 (CEST)
Date:   Mon, 20 Apr 2020 20:03:03 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] x86/elf: Disable automatic READ_IMPLIES_EXEC on 64-bit
Cc:     "Hector Marco-Gisbert" <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Jason Gunthorpe <jgg@mellanox.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327064820.12602-4-keescook@chromium.org>
References: <20200327064820.12602-4-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <158741298356.28353.12277851265006142535.tip-bot2@tip-bot2>
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

Commit-ID:     9fccc5c0c99f238aa1b0460fccbdb30a887e7036
Gitweb:        https://git.kernel.org/tip/9fccc5c0c99f238aa1b0460fccbdb30a887e7036
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 26 Mar 2020 23:48:17 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 19:24:33 +02:00

x86/elf: Disable automatic READ_IMPLIES_EXEC on 64-bit

With modern x86 64-bit environments, there should never be a need for
automatic READ_IMPLIES_EXEC, as the architecture is intended to always
be execute-bit aware (as in, the default memory protection should be NX
unless a region explicitly requests to be executable).

There were very old x86_64 systems that lacked the NX bit, but for those,
the NX bit is, obviously, unenforceable, so these changes should have
no impact on them.

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Link: https://lkml.kernel.org/r/20200327064820.12602-4-keescook@chromium.org
---
 arch/x86/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 397a1c7..452beed 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -287,7 +287,7 @@ extern u32 elf_hwcap2;
  *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
  * ELF:                 |            |                  |                |
  * ---------------------|------------|------------------|----------------|
- * missing PT_GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * missing PT_GNU_STACK | exec-all   | exec-all         | exec-none      |
  * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
@@ -303,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack == EXSTACK_DEFAULT)
+	(mmap_is_ia32() && executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
