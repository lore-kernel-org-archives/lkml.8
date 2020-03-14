Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D62C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39D205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCOCfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:35:04 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54922 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgCOCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:35:03 -0400
Received: from sf.home (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id E455134EECE;
        Sat, 14 Mar 2020 16:45:04 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id A55C95A22061; Sat, 14 Mar 2020 16:45:01 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: [PATCH] x86: fix early boot crash on gcc-10
Date:   Sat, 14 Mar 2020 16:44:51 +0000
Message-Id: <20200314164451.346497-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change fixes boot failure on physical machine where kernel
is built with gcc-10 with stack-protector enabled by default:

```
Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary+0x191/0x1a0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
Call Trace:
  dump_stack+0x71/0xa0
  panic+0x107/0x2b8
  ? start_secondary+0x191/0x1a0
  __stack_chk_fail+0x15/0x20
  start_secondary+0x191/0x1a0
  secondary_startup_64+0xa4/0xb0
-—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary+0x191
```

This happens because `start_secondary()` is responsible for setting
up initial stack canary value in `smpboot.c`, but nothing prevents
gcc from inserting stack canary into `start_secondary()` itself
before `boot_init_stack_canary()` call.

The fix passes `-fno-stack-protector` to avoid any early stack
checks in `start_secondary()` or inlined functions into it.

Tested the change by successfully booting the machine.

A few similar crashes on VMs:
- https://bugzilla.redhat.com/show_bug.cgi?id=1796780
- http://rglinuxtech.com/?p=2694

CC: Jakub Jelinek <jakub@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: x86@kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/x86/kernel/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c13809a..da9f4ea9bf4c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -11,6 +11,12 @@ extra-y	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
+# smpboot's init_secondary initializes stack canary.
+# Make sure we don't emit stack checks before it's
+# initialized.
+nostackp := $(call cc-option, -fno-stack-protector)
+CFLAGS_smpboot.o := $(nostackp)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_tsc.o = -pg
-- 
2.25.1

