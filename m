Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE42EC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918DE2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584929446;
	bh=r11iNbIDFCbWfoiGIfkO6S/9Fnxa0ZaDs0KJoGw/JoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7CyhKNzqpmaAJ8RiOEZ1kbH7WjmJ7zkJOmCMWQLXEM6BCpKInG9jzrJxXipxNVDU
	 pZ8AvYuvYTwwz8TlD1A6UZQlDMtopIAVkvm0GA4tj+jIuE8k+hxOUNpA3CQJNcr7d9
	 quEvKEK0Ym5eFZWWDLrVrWhsCKC/sIX4VSeAwUFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWCKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:10:45 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44403 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCWCKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:10:45 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02N28urU002941;
        Mon, 23 Mar 2020 11:09:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02N28urU002941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584929340;
        bh=nd/oHID8eH/14iCoxOKwvwzNHlBaytPY2wrQZxGEUsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GY4fTicqaAbfjFR3vdn3js6dVKASaP78PZx7u5LkiLLpMlc/TpCrinj0808nL/3UC
         czcYrU47UTe/QVLkQwI1nUMXioAXwTrgvYXSuKcr1FYbk21Rvcxdv1je1wAOCZ5Cov
         5gbjJgy6Hy3q/HIKUHJwdX3r8R268VBGExi2vHjyxFfNFiZLQoyj16DFB0Uvi8zNKc
         Fm6aINAa3WfzXEWEjzkO00FzLNSVHFQ0yagPtgVsYmboZOXbifhzkfepYB7rB/REvB
         Wgm2+1aUPBa3KkVN4AXcdAmzrOwQKckkzSWr4gsoo/SAVCZLOSfnoQdzO5aU+wnC1e
         c9gpoOwSUg7/Q==
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
Subject: [PATCH 3/7] x86: remove always-defined CONFIG_AS_CFI_SIGNAL_FRAME
Date:   Mon, 23 Mar 2020 11:08:40 +0900
Message-Id: <20200323020844.17064-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323020844.17064-1-masahiroy@kernel.org>
References: <20200323020844.17064-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_AS_CFI_SIGNAL_FRAME was introduced by commit adf1423698f0
("[PATCH] i386/x86-64: Work around gcc bug with noreturn functions
in unwinder").

We raise the minimal supported binutils version from time to time.
The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
required binutils version to 2.21").

I confirmed the code in $(call as-instr,...) can be assembled by the
binutils 2.21 assembler and also by LLVM integrated assembler.

Remove CONFIG_AS_CFI_SIGNAL_FRAME, which is always defined.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile             | 6 ++----
 arch/x86/include/asm/dwarf2.h | 5 -----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 72f8f744ebd7..dd275008fc59 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -177,8 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
-# is .cfi_signal_frame supported too?
-cfi-sigframe := $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1)
 cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
 
 # does binutils support specific instructions?
@@ -190,8 +188,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
 sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
 adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
 
-KBUILD_AFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
-KBUILD_CFLAGS += $(cfi-sigframe) $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
+KBUILD_AFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
+KBUILD_CFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 90807583cad7..d6697aab5706 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -20,12 +20,7 @@
 #define CFI_RESTORE_STATE	.cfi_restore_state
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
-
-#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
 #define CFI_SIGNAL_FRAME	.cfi_signal_frame
-#else
-#define CFI_SIGNAL_FRAME
-#endif
 
 #if defined(CONFIG_AS_CFI_SECTIONS)
 #ifndef BUILD_VDSO
-- 
2.17.1

