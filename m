Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E72C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413F920838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PoL0XhCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBJTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:31:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47031 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgBJTbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so10291165oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV+4L9n935hAwwy1rny/bKPJmpM6IQkGJafPemnuM6M=;
        b=PoL0XhCMF5RYylDc0l4IgFMeB8xwO+uVffzPYfytDnFxlYeMxyX/mZuQokiRqvLpeB
         3BSmLKsw8Mn0fTOGDf5FiPjNmXvq0HmdnXXBN/WXOAJCOAtbktliwg0Ij4BFjNLNEwz1
         LFDL39Nbv292S1gxIrW8F3TJd9vj+dby5RYxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV+4L9n935hAwwy1rny/bKPJmpM6IQkGJafPemnuM6M=;
        b=YGCvyxBG0TaDQJyVO0Xm38DHTqMZqZ5PqGIpiu2sUYuJhrW+7xV5NNG7OC8ZvuPCry
         77GV7g/uVXJxp2LsXiKkGp1d628qNxczDpwa9scz/2N0NVA52oPUISTaSgdWL1D5r7Pk
         0F7K7wL39f1Q6HVrC2VG9j490bVVz+ub53edAGp/Qve3RtrffgvZSvo3tsrk50FJVDc8
         HuhJheP0cpiHNW37hRA/oMuorTnbkaiikeziDUZm2xM2SLQHdFMwoFJ0ofzEP4wVKSN6
         wNpHKkdo69zDnuV5fpkQISPzLiunVuaytcHuugugP0bLqZ8JAxkI7UFUAwr/hR4BIRtw
         /nGg==
X-Gm-Message-State: APjAAAW8K0Eh2vV8iRI/dWTHeE4rEjDIrGGUjzvPl/ikghS8ZtAFAkjl
        Jwpg4rlteDVxL1J5BKCczLNPmw==
X-Google-Smtp-Source: APXvYqxxYA/0/Zbqi4Hv0JHtPdrzzbONYFkwCVp0/iu2hk9k8CQImN2sdfiTosdmQZKPTHVPQ7l30Q==
X-Received: by 2002:aca:5083:: with SMTP id e125mr424241oib.96.1581363063722;
        Mon, 10 Feb 2020 11:31:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f1sm370846otq.4.2020.02.10.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:31:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/7] arm32/64, elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
Date:   Mon, 10 Feb 2020 11:30:47 -0800
Message-Id: <20200210193049.64362-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
References: <20200210193049.64362-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The READ_IMPLIES_EXEC work-around was designed for old toolchains that
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
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

This changes arm32 and arm64 compat together, to keep behavior the same.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/elf.c        | 5 +++--
 arch/arm64/include/asm/elf.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 2f69cf978fe3..6965a673a141 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -87,12 +87,13 @@ EXPORT_SYMBOL(elf_set_personality);
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-stack |
  * GNU_STACK == RW   | exec-all   | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -102,7 +103,7 @@ EXPORT_SYMBOL(elf_set_personality);
  */
 int arm_elf_read_implies_exec(int executable_stack)
 {
-	if (executable_stack != EXSTACK_DISABLE_X)
+	if (executable_stack == EXSTACK_DEFAULT)
 		return 1;
 	if (cpu_architecture() < CPU_ARCH_ARMv6)
 		return 1;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7fc779e3f1ec..03ada29984a7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -106,17 +106,18 @@
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-stack | exec-stack |
  * GNU_STACK == RW   | exec-none  | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex,stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
-- 
2.20.1

