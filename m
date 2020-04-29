Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA09C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF512082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=narfindustries.com header.i=@narfindustries.com header.b="AJT7sbva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgD2Td5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2Tdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:33:54 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21444C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:54 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b5so2197013vsb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=narfindustries.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nZMTNOEhGvabmemsI4hj8aTBrQwvDT8DepBlF5l+XRA=;
        b=AJT7sbvaf+okUnC0oBPKyDFXHEIOp7bafkO365+Znk5uKdixRPURAc/l1lUbwZu4iI
         Fo+Qc9LwBgb2pThxzrSJTelmW8MzM814rWy5Ptax9QwsZVwUTaevFBhFVAOD/SvO2SZi
         SDSr+eCFUc/Z5PF2oQh3i6j6JjG0eIkPPUb0CfoMoxR1KOHDWhdoL4vvoLBI5C4Z886g
         Vi/xB7VaJEbhp+NxZmhQ532588gCc8xRvD23qpbjZfiHs9UfPf59SKiA4gUyzF+MZOEw
         XuRqHXR96exmQ4PDXjjVZhtYELvhKmJKHjCWU3mYGZlY2OSDK4AVEhGx9S1UIBY/2WKX
         24qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nZMTNOEhGvabmemsI4hj8aTBrQwvDT8DepBlF5l+XRA=;
        b=RtrhlAIb8R3P/HUaETHB5NQbtSq5W/nMIh7zYUO11ACHz1awSs9LH9JKH1aBjvj7l0
         vBUdwvjDhW47Ffj55o28Ru82i5AvmiaY9sg5bINsTsTyQbQvGShshK9OtqrGrIOrWpDD
         dOAZFDsPZ/dU87qqSfXtwYn4huIS6IEeOi3t77O6+0XPlisuR07Jfc7JfFcHmMlKDXQZ
         kylP8qtZHQsNeTMKKetGkadvdqfp3w+UtcyB6xJ8CHyrSsxi5IsW41CiQtSVmCWLwsVK
         7prm7vJEsGYdCWcJOyGN04QKBOCSLb1tvNlLHS8l1RxwqzQrxMz+MzFsb+Mp/g9npjlh
         yGYA==
X-Gm-Message-State: AGi0PuaorLm0/CslNnR1n3E02tLE/3keOVERrz6HzZiPb+RE1j61oe1S
        5UaqtAa2VhbfOEC1eLSWfly+2Q==
X-Google-Smtp-Source: APiQypJ1F9uYJiyzzKipRq9PM19G18F9kxvzFXnehelEFRfNDqMKRjpIDo3YpkpyDjfPJyfwe5aj/g==
X-Received: by 2002:a67:7c50:: with SMTP id x77mr28314248vsc.187.1588188833244;
        Wed, 29 Apr 2020 12:33:53 -0700 (PDT)
Received: from localhost.localdomain ([24.171.221.68])
        by smtp.gmail.com with ESMTPSA id k26sm76764uag.10.2020.04.29.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:33:52 -0700 (PDT)
From:   Javier Malave <javier.malave@narfindustries.com>
To:     bx@narfindustries.com
Cc:     Javier Malave <javier.malave@narfindustries.com>,
        linux-kernel@vger.kernel.org, ah@narfindustries.com
Subject: [RFC 4/9] Popcorn system call additions
Date:   Wed, 29 Apr 2020 15:32:51 -0400
Message-Id: <1d44b88fe4435a6ff0db629ac6883e6b01844019.1588127445.git.javier.malave@narfindustries.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
References: <cover.1588127445.git.javier.malave@narfindustries.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Popcorn system calls are a core component of
Popcorn Linux. All system calls have been added 
to kernel/sched/core.c

The main system call is popcorn_migrate. User
applications may invoke this system call to trigger
a migration from their origin node to a remote
node; and vice-versa. The system call relies on
several "server modules" (process server, vma server,
page server) to perform the migration and maintain
VMA coherency. A message layer for IPC has been
also added to communicate Popcorn messages across
the distributed threads. You may find a basic
example of the system call at the Popcorn kernel
library. All three system calls are showcased in the
Popcorn kernel library.
---
 arch/x86/entry/syscalls/syscall_64.tbl |  3 +++
 include/linux/syscalls.h               |  9 +++++++++
 include/uapi/asm-generic/unistd.h      | 11 +++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e62..5f8aff57e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,9 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	64	popcorn_migrate		__x64_sys_popcorn_migrate
+435	64	popcorn_get_thread_status	__x64_sys_popcorn_get_thread_status
+436	64	popcorn_get_node_info	__x64_sys_popcorn_get_node_info
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2bcef4c70..e8e4430d5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1250,6 +1250,15 @@ ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
 ssize_t ksys_pwrite64(unsigned int fd, const char __user *buf,
 		      size_t count, loff_t pos);
 int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len);
+#ifdef CONFIG_POPCORN
+long ksys_brk(unsigned long brk);
+long ksys_mremap(unsigned long addr,
+		 unsigned long old_len, unsigned long new_len,
+		 unsigned long flags, unsigned long new_addr);
+long ksys_madvise(unsigned long start, size_t len, int behavior);
+long ksys_mprotect(unsigned long start, size_t len,
+		  unsigned long prot);
+#endif
 #ifdef CONFIG_ADVISE_SYSCALLS
 int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 #else
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf..71a526a1b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,16 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
-
+#ifdef CONFIG_POPCORN
+#define __NR_popcorn_migrate 434
+__SYSCALL(__NR_popcorn_migrate, sys_popcorn_migrate)
+#define __NR_popcorn_get_thread_status 435
+__SYSCALL(__NR_popcorn_get_thread_status, sys_popcorn_get_thread_status)
+#define __NR_popcorn_get_node_info 436
+__SYSCALL(__NR_popcorn_get_node_info, sys_popcorn_get_node_info)
+#endif
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 437
 
 /*
  * 32 bit systems traditionally used different
-- 
2.17.1

