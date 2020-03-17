Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED6C5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A794206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCQWSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:18:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56032 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:18:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEKX7-0001Cb-AX; Tue, 17 Mar 2020 23:17:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F06D71C2295;
        Tue, 17 Mar 2020 23:17:56 +0100 (CET)
Date:   Tue, 17 Mar 2020 22:17:56 -0000
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/purgatory: Disable various profiling and
 sanitizing options
Cc:     Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317130841.290418-1-hdegoede@redhat.com>
References: <20200317130841.290418-1-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <158448347670.28353.10536465598206779588.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     e2ac07c06058ae2d58b45bbf2a2a352771d76fcb
Gitweb:        https://git.kernel.org/tip/e2ac07c06058ae2d58b45bbf2a2a352771d76fcb
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Tue, 17 Mar 2020 14:08:40 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 15:57:19 +01:00

x86/purgatory: Disable various profiling and sanitizing options

Since the purgatory is a special stand-alone binary, various profiling
and sanitizing options must be disabled. Having these options enabled
typically will cause dependencies on various special symbols exported by
special libs / stubs used by these frameworks. Since the purgatory is
special, it is not linked against these stubs causing missing symbols in
the purgatory if these options are not disabled.

Sync the set of disabled profiling and sanitizing options with that from
drivers/firmware/efi/libstub/Makefile, adding
-DDISABLE_BRANCH_PROFILING to the CFLAGS and setting:

  GCOV_PROFILE                    := n
  UBSAN_SANITIZE                  := n

This fixes broken references to ftrace_likely_update() when
CONFIG_TRACE_BRANCH_PROFILING is enabled and to __gcov_init() and
__gcov_exit() when CONFIG_GCOV_KERNEL is enabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200317130841.290418-1-hdegoede@redhat.com
---
 arch/x86/purgatory/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee54..9733d1c 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -17,7 +17,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
+# Sanitizer, etc. runtimes are unavailable and cannot be linked here.
+GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
@@ -25,7 +28,7 @@ KCOV_INSTRUMENT := n
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
