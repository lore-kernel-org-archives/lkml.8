Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1942083E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585209834;
	bh=68xXfc67h1Z7JWOf3VrvgS9/iXyuBFVMS73knk1Mykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ii9lRqNAZKN2Es66saHGdT3v76PlKaE7MWvn8eOBg4rTpDU4NJfLMKJwXMrlZpx9s
	 g7Oc26vDB9+xLvdXvQTTUEg3TbCiYAb3bGHH5YypvO/vIQiKJq/bWBCZavMP+yQkjR
	 HxLprljwfvXZDRcr3EioGYA1xhOmx3u55wvE29I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCZIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:03:52 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:18574 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:03:48 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02Q81WpX002183;
        Thu, 26 Mar 2020 17:01:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02Q81WpX002183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585209701;
        bh=Q+/lW+MK4bN7hGNuhF3kVcr+0Bx3tZbTLSEobJfEkn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDYIKDX5XYbFRbJ1HUeWSuVJLmK480uHs8IYsKyHn108Zk7Sg9E5vo3sG+ISlBo7c
         6w66gva8BPN3LrEVw9zybf3Xide7czAFzi3aw0Wtuk/71gi+vO9DrZDVhPGvR1v1PE
         +bZNWVQQ5GKB046J/O81yWkLMMnU++4xNn+Zo0744yb8Pue+D6y6Rk3Vy1xd7Sb6eM
         rq3nOCcW3yclryheVHU2cUBLbOLozkUoVb+HMdKFFMayuruWwJ5OEUM6kJyKJ/IU4l
         04pyisu0MzvSgUmLvDnDIgyViYGG3mvZXmIThPwq+K2kO9RRXmEmHIhtl3cvJpiT/4
         pwb1C2wpSWeZw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/16] x86: remove unneeded (CONFIG_AS_)CFI_SIGNAL_FRAME
Date:   Thu, 26 Mar 2020 17:00:52 +0900
Message-Id: <20200326080104.27286-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326080104.27286-1-masahiroy@kernel.org>
References: <20200326080104.27286-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 131484c8da97 ("x86/debug: Remove perpetually broken,
unmaintainable dwarf annotations") removes all the users of
CFI_SIGNAL_FRAME.

Remove the CFI_SIGNAL_FRAME and CONFIG_AS_CFI_SIGNAL_FRAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2: None

 arch/x86/Makefile             | 6 ++----
 arch/x86/include/asm/dwarf2.h | 6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

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
index 90807583cad7..f440790f09f9 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -21,12 +21,6 @@
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
 
-#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
-#define CFI_SIGNAL_FRAME	.cfi_signal_frame
-#else
-#define CFI_SIGNAL_FRAME
-#endif
-
 #if defined(CONFIG_AS_CFI_SECTIONS)
 #ifndef BUILD_VDSO
 	/*
-- 
2.17.1

