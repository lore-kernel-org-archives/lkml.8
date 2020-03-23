Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5EEC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817F42074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584929454;
	bh=jaGPIpGPPqctDJCD6IDvFLvTBAHWUPLPebvF99tCaPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wvGgDsiWnH+VYuKzsdbFiKwD8dtBYWfzwp3JUaufvZYw8FhrejyHskOdKh+7wf4Ce
	 NGUWzd5s+pfHhWJCgOxka2TnzeQjkgq3fkWCXqo6Ahtbtp8vDNCawwXf3KgagXZdZG
	 +7GlFPSL07Nk9quLr1rEDhyJJH04Z3LNo22efdYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCWCKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:10:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44563 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgCWCKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:10:51 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02N28urT002941;
        Mon, 23 Mar 2020 11:08:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02N28urT002941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584929339;
        bh=OBYpbzm6LFgChfbfmHLibCZaTv/7d/Vlu331wrlDIOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkDpJesliGScBOAxZ66gIOiD2WBWbhIna7MuM4pGekNDp0ijO/7AFqNjlLFqglyI6
         9Do/dM8ngkRIU9M0XbVHdlgsM9myaQsmtfIqv8QE0I1kGLoFVJbMAlcVAtJ0Y/hJjy
         cyKP1MSmilQb6R8/CXRkufwVbqHjl8y1TaOlWtKRyoIDCEl95YeAdiWLk9FJh/3g47
         hJcHYTcDBZQJCGeakVhAKqaecMveMht7Uj8jOD7cdpmraUUnPSp24gXGZHQ1oDfOl8
         bApyyJP8S3v45mW7DhP/PT5iL0IQJdghBsr+NeM6BcYSB9mTQ9wdiatOiW6M0by82p
         Psxmp3ZMKXg7Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 2/7] x86: remove always-defined CONFIG_AS_CFI
Date:   Mon, 23 Mar 2020 11:08:39 +0900
Message-Id: <20200323020844.17064-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323020844.17064-1-masahiroy@kernel.org>
References: <20200323020844.17064-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AS_CFI was introduced by commit e2414910f212 ("[PATCH] x86:
Detect CFI support in the assembler at runtime"), and extended by
commit f0f12d85af85 ("x86_64: Check for .cfi_rel_offset in CFI probe").

We raise the minimal supported binutils version from time to time.
The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
required binutils version to 2.21").

I confirmed the code in $(call as-instr,...) can be assembled by the
binutils 2.21 assembler and also by LLVM integrated assembler.

Remove CONFIG_AS_CFI, which is always defined.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

If this series is OK, we can do follwup cleanups.
We can hard-code the assembler code, and delete CFI_* macros entirely.


 arch/x86/Makefile             | 10 ++--------
 arch/x86/include/asm/dwarf2.h | 36 -----------------------------------
 2 files changed, 2 insertions(+), 44 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 513a55562d75..72f8f744ebd7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -177,12 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
-# Stackpointer is addressed different for 32 bit and 64 bit x86
-sp-$(CONFIG_X86_32) := esp
-sp-$(CONFIG_X86_64) := rsp
-
-# do binutils support CFI?
-cfi := $(call as-instr,.cfi_startproc\n.cfi_rel_offset $(sp-y)$(comma)0\n.cfi_endproc,-DCONFIG_AS_CFI=1)
 # is .cfi_signal_frame supported too?
 cfi-sigframe := $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1)
 cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
@@ -196,8 +190,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
 sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
 adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
 
-KBUILD_AFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
-KBUILD_CFLAGS += $(cfi) $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
+KBUILD_AFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
+KBUILD_CFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 5a0502212bc5..90807583cad7 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -6,15 +6,6 @@
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
-/*
- * Macros for dwarf2 CFI unwind table entries.
- * See "as.info" for details on these pseudo ops. Unfortunately
- * they are only supported in very new binutils, so define them
- * away for older version.
- */
-
-#ifdef CONFIG_AS_CFI
-
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA		.cfi_def_cfa
@@ -55,31 +46,4 @@
 #endif
 #endif
 
-#else
-
-/*
- * Due to the structure of pre-exisiting code, don't use assembler line
- * comment character # to ignore the arguments. Instead, use a dummy macro.
- */
-.macro cfi_ignore a=0, b=0, c=0, d=0
-.endm
-
-#define CFI_STARTPROC		cfi_ignore
-#define CFI_ENDPROC		cfi_ignore
-#define CFI_DEF_CFA		cfi_ignore
-#define CFI_DEF_CFA_REGISTER	cfi_ignore
-#define CFI_DEF_CFA_OFFSET	cfi_ignore
-#define CFI_ADJUST_CFA_OFFSET	cfi_ignore
-#define CFI_OFFSET		cfi_ignore
-#define CFI_REL_OFFSET		cfi_ignore
-#define CFI_REGISTER		cfi_ignore
-#define CFI_RESTORE		cfi_ignore
-#define CFI_REMEMBER_STATE	cfi_ignore
-#define CFI_RESTORE_STATE	cfi_ignore
-#define CFI_UNDEFINED		cfi_ignore
-#define CFI_ESCAPE		cfi_ignore
-#define CFI_SIGNAL_FRAME	cfi_ignore
-
-#endif
-
 #endif /* _ASM_X86_DWARF2_H */
-- 
2.17.1

