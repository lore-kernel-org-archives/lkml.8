Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A4DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A27D20736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDTUDX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgDTUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:03:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06347C061A0C;
        Mon, 20 Apr 2020 13:03:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQcdF-00060b-RQ; Mon, 20 Apr 2020 22:03:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7266C1C007F;
        Mon, 20 Apr 2020 22:03:04 +0200 (CEST)
Date:   Mon, 20 Apr 2020 20:03:04 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] x86/elf: Split READ_IMPLIES_EXEC from executable
 PT_GNU_STACK
Cc:     "Hector Marco-Gisbert" <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Jason Gunthorpe <jgg@mellanox.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200327064820.12602-3-keescook@chromium.org>
References: <20200327064820.12602-3-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <158741298406.28353.13325232808182983778.tip-bot2@tip-bot2>
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

Commit-ID:     122306117afe4ba202b5e57c61dfbeffc5c41387
Gitweb:        https://git.kernel.org/tip/122306117afe4ba202b5e57c61dfbeffc5c41387
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 26 Mar 2020 23:48:16 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 19:09:38 +02:00

x86/elf: Split READ_IMPLIES_EXEC from executable PT_GNU_STACK

The READ_IMPLIES_EXEC workaround was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stacks are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Link: https://lkml.kernel.org/r/20200327064820.12602-3-keescook@chromium.org
---
 arch/x86/include/asm/elf.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index ee459d4..397a1c7 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -288,12 +288,13 @@ extern u32 elf_hwcap2;
  * ELF:                 |            |                  |                |
  * ---------------------|------------|------------------|----------------|
  * missing PT_GNU_STACK | exec-all   | exec-all         | exec-all       |
- * PT_GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * PT_GNU_STACK == RWX  | exec-stack | exec-stack       | exec-stack     |
  * PT_GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -302,7 +303,7 @@ extern u32 elf_hwcap2;
  *
  */
 #define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack != EXSTACK_DISABLE_X)
+	(executable_stack == EXSTACK_DEFAULT)
 
 struct task_struct;
 
