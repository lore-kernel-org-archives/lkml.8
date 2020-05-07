Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A809C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5242073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588862136;
	bh=8ZRbF1oT0PlniE7k0j5hKHHVmF3lXbnS8elI06OuwuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWxa65C5hdBdeXu6+flnfz1toi+1x1WmnPE9iH+QO3fCNBgej1WZOFsIXDjApgMdy
	 3Dm5Mh1Al1IAIczCo+JYffegn30RhE9BafFY3/LlJ6q9CtQgPfPzvZ6BJ8iQW1XcVW
	 hupM+SbrxWeqSUsxObmok3Bs9AX+tSWHlfbk5ngU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgEGO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgEGO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:28:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E170020B1F;
        Thu,  7 May 2020 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861717;
        bh=8ZRbF1oT0PlniE7k0j5hKHHVmF3lXbnS8elI06OuwuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXNFJl8KbJPkblSiFy4yyduCW4E2uqJNnMlMSAKrRgTlrdocUY1PxoN2mtJOR9j4+
         jgrgS4GU04Q8iMrJhFh6RFPY6+LHuGJDBlxgrW9CWpLG3Lp3UNGWgvyo4BvZubvhaU
         XTDCKBUrylnj/WGI/5VfhrZuhzDS8PSRRhvD2uZk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-riscv@lists.infradead.org, clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 05/35] riscv: fix vdso build with lld
Date:   Thu,  7 May 2020 10:27:59 -0400
Message-Id: <20200507142830.26239-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142830.26239-1-sashal@kernel.org>
References: <20200507142830.26239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilie Halip <ilie.halip@gmail.com>

[ Upstream commit 3c1918c8f54166598195d938564072664a8275b1 ]

When building with the LLVM linker this error occurrs:
    LD      arch/riscv/kernel/vdso/vdso-syms.o
  ld.lld: error: no input files

This happens because the lld treats -R as an alias to -rpath, as opposed
to ld where -R means --just-symbols.

Use the long option name for compatibility between the two.

Link: https://github.com/ClangBuiltLinux/linux/issues/805
Reported-by: Dmitry Golovin <dima@golovin.in>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 33b16f4212f7a..a4ee3a0e7d20d 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -33,15 +33,15 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 
 # We also create a special relocatable object that should mirror the symbol
-# table and layout of the linked DSO.  With ld -R we can then refer to
-# these symbols in the kernel code rather than hand-coded addresses.
+# table and layout of the linked DSO. With ld --just-symbols we can then
+# refer to these symbols in the kernel code rather than hand-coded addresses.
 
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
 	-Wl,--build-id -Wl,--hash-style=both
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
 
-LDFLAGS_vdso-syms.o := -r -R
+LDFLAGS_vdso-syms.o := -r --just-symbols
 $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
 	$(call if_changed,ld)
 
-- 
2.20.1

