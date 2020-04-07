Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407FBC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCDD2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586278294;
	bh=hybhU6x+OnJln3ewfYearVtUDFvYr/tvnY6jHol4ltA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zR/ggUZU5gBBX5zK6TIfAxXefdKGRSNNEGwi9avYOlGsnm0hRnLlRSYP7iheQzBjL
	 roVQYVxXE11Fh53NH+NzJ5qAK8WNqTCc8Uvjj1TyhS+QkevSf5LppCrDWIUBIRf42h
	 q5R5a7GVUzayZNRKtxShtWNgTYgSqlx3r66Iy6f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDGQvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgDGQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:51:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45F62076E;
        Tue,  7 Apr 2020 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586278292;
        bh=hybhU6x+OnJln3ewfYearVtUDFvYr/tvnY6jHol4ltA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O5jx3/AV6mS7DZjU+GjcMYctgOJDk9MVvbpe/P3K5sucxiBppzuY9VFfQdd47RBIV
         1pKJV/8Ii5sMAUyeu9vg/x3skPB2uAxXwtSs14LGqcf+Ax89WHn/Y5A56FaEKpPw4d
         caQs3JXR5RORWchkAwR4l1I4+xUvb8j2iZYxkhGs=
Date:   Wed, 8 Apr 2020 01:51:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-Id: <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
In-Reply-To: <20200407111007.352324393@infradead.org>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 07 Apr 2020 13:02:39 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +static bool insn_is_vmx(struct insn *insn)
> +{
> +	u8 modrm = insn->modrm.bytes[0];
> +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> +	u8 modrm_reg = X86_MODRM_REG(modrm);
> +
> +	u8 prefix = insn->prefixes.bytes[0];
> +
> +	if (insn->opcode.bytes[0] != 0x0f)
> +		return false;
> +
> +	switch (insn->opcode.bytes[1]) {
> +	case 0x01:
> +		switch (insn->opcode.bytes[2]) {
> +		case 0xc1: /* VMCALL */
> +		case 0xc2: /* VMLAUNCH */
> +		case 0xc3: /* VMRESUME */
> +		case 0xc4: /* VMXOFF */
> +			return true;
> +
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	case 0x78: /* VMREAD */
> +	case 0x79: /* VMWRITE */
> +		return true;
> +
> +	case 0xc7:
> +		/* VMPTRLD, VMPTRST, VMCLEAR, VMXON */
> +		if (modrm_mod == 0x03)
> +			break;
> +
> +		if ((modrm_reg == 6 && (!prefix || prefix == 0x66 || prefix == 0xf3)) ||
> +		    (modrm_reg == 7 && (!prefix || prefix == 0xf3)))
> +			return true;
> +
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}

OK, so here is what you need ;)

From 36f4f6aec623b0190fde95c8630a6a1d8c23ffc9 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 8 Apr 2020 01:04:41 +0900
Subject: [PATCH] x86: insn: Add insn_is_vmx()

Add insn_is_vmx() to identify the given instruction is
for VMX or not. This is simply identifying those instructions
by mnemonic pattern.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/inat.h                | 1 +
 arch/x86/include/asm/insn.h                | 7 +++++++
 arch/x86/tools/gen-insn-attr-x86.awk       | 6 ++++++
 tools/arch/x86/include/asm/inat.h          | 1 +
 tools/arch/x86/include/asm/insn.h          | 7 +++++++
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 6 ++++++
 6 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index ffce45178c08..599876801ae8 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -79,6 +79,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_FPU	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_FPUIFVEX	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_VMX	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 1752c54d2103..57e81013836d 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -141,6 +141,13 @@ static inline int insn_is_fpu(struct insn *insn)
 	return 0;
 }
 
+static inline int insn_is_vmx(struct insn *insn)
+{
+	if (!insn->opcode.got)
+		insn_get_opcode(insn);
+	return (insn->attr & INAT_VMX) && !insn_is_fpu(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index d74d9e605723..ade80796453c 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -70,6 +70,8 @@ BEGIN {
 	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
 	fpu_expr = "^x87"
 
+	vmx_expr = "^VM.*" # All mnemonic start with "VM" are VMX instructions
+
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
 	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
@@ -328,6 +330,10 @@ function convert_operands(count,opnd,       i,j,imm,mod,mmx)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check VMX related opcode
+		if (match(opcode, vmx_expr))
+			flags = add_flags(flags, "INAT_VMX")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 2e6a05290efd..af393952916c 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -79,6 +79,7 @@
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
 #define INAT_FPU	(1 << (INAT_FLAG_OFFS + 8))
 #define INAT_FPUIFVEX	(1 << (INAT_FLAG_OFFS + 9))
+#define INAT_VMX	(1 << (INAT_FLAG_OFFS + 10))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index d9f6bd9059c1..d18ce4683d8e 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -141,6 +141,13 @@ static inline int insn_is_fpu(struct insn *insn)
 	return 0;
 }
 
+static inline int insn_is_vmx(struct insn *insn)
+{
+	if (!insn->opcode.got)
+		insn_get_opcode(insn);
+	return (insn->attr & INAT_VMX) && !insn_is_fpu(insn);
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index d74d9e605723..ade80796453c 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -70,6 +70,8 @@ BEGIN {
 	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
 	fpu_expr = "^x87"
 
+	vmx_expr = "^VM.*" # All mnemonic start with "VM" are VMX instructions
+
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
 	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
@@ -328,6 +330,10 @@ function convert_operands(count,opnd,       i,j,imm,mod,mmx)
 		if (match(ext, force64_expr))
 			flags = add_flags(flags, "INAT_FORCE64")
 
+		# check VMX related opcode
+		if (match(opcode, vmx_expr))
+			flags = add_flags(flags, "INAT_VMX")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
-- 
2.20.1



-- 
Masami Hiramatsu <mhiramat@kernel.org>
