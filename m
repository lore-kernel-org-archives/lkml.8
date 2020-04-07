Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C14C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF5620730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CX0cu7dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDGUqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:46:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDGUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=M/PmSf03EWCyTALuMOuTV3/WAZiw/Bj9sLqNHDMVOhg=; b=CX0cu7dL5hzuNQ2rV2r6GtxcDF
        SZVZo0WFpA1QIEeCWBv+ymIgM9u/dw8BA7CwpfZHlkftcdWRMkrO1KscVbElsj55LreO7A78/DuTc
        f1AZz9Q2ADH+tpJroPFtoVriSsO2DqNLJMPlpG8Le4CTULX3zPem+GmLoM3xA1JDh/xaS5sbw+AZi
        5VrTNVOLuG+aspV5W74+CI0oktL32wSSynF1ZUs2y3neIQRoZuHC5OfyXmOnel7f354+FRjEHc+cA
        GgWHJ9hUgtjTdmDCaVDGA3EX+S2RS/ZKewFyoxZ37oOl+t7znH5PkqvRgvev5mbyVVRVc7O269myJ
        d+6WYaVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLv6D-000123-G8; Tue, 07 Apr 2020 20:45:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD6A5982F1A; Tue,  7 Apr 2020 22:45:30 +0200 (CEST)
Date:   Tue, 7 Apr 2020 22:45:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
Message-ID: <20200407204530.GR2452@worktop.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
 <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
 <e6d9f83e-e88c-c079-50b3-ff8ad8682074@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d9f83e-e88c-c079-50b3-ff8ad8682074@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:11:17PM +0100, Andrew Cooper wrote:

> Sorry - should have been more clear.  By friends, I meant LGDT, LIDT,
> LLDT and LTR which are the 4 system table loading instructions.  LLDT
> and LTR depend on being able to write into the GDT, but still have no
> business being used.
> 
> Also, LMSW if you care about it, but its utility is somewhere close to 0
> these days, so probably not worth the cycles searching for.
> 
> The Sxxx instructions have no business being used, but are also harmless
> and similarly, probably not worth spending cycles searching for.
> 
> L{D,E,F,S}S are functional equivalents to "MOV val1, %sreg; mov val2,
> %reg"  so harmless (also mode specific as to whether they are useable).

OK, LxDT + LTR it is.

> Other things to consider, while we're on a roll:
> 
> WRMSR and RDMSR:  There is a lot of damage which can be done with these,
> and at least forcing people to use the regular hooks will get proper
> paravirt support and/or exception support.  That said, this might cause
> large carnage to out-of-tree modules which are a device driver for
> random platform things.

Yeah, I had already considered that, didn't want to touch that just yet.

> POPF: Don't really want someone being able to set IOPL3.  However, this
> might quite easily show up as a false positive depending on how the
> irqsafe infrastructure gets inlined.

local_irq_restore() will be a POPF :/

> SYSRET/SYSEXIT/IRET: Don't want a module returning to userspace behind
> the kernels back. 

Good thinking, let me add this.

> IRET may be a false positive for serialising
> purposes, as may be a write to CR2 for that matter.

We can out-of-line and export sync_core() for that.

> Looking over the list of other privileged instructions, CLTS,
> {,WB,WBNO}INVD, INVLPG and HLT might be candidates for "clearly doing
> something which shouldn't be done".  Not on the list is INVPCID which
> falls into the same category.
> 
> Come to think about it, it might be easier to gauge on CPL0 instructions
> and whitelist the ok ones, such as VMX and SVM for out-of-tree hypervisors.

Fair enough, I'll go over those tomorrow.

For now I ended up with:

---
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -282,6 +282,68 @@ static bool insn_is_mov_DRn(struct insn
 	return false;
 }

+static bool insn_is_GDT_modifier(struct insn *insn)
+{
+	u8 modrm = insn->modrm.bytes[0];
+	u8 modrm_mod = X86_MODRM_MOD(modrm);
+	u8 modrm_reg = X86_MODRM_REG(modrm);
+
+	if (insn->opcode.bytes[0] != 0x0f)
+		return false;
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x00: /* Grp6 */
+		switch (modrm_reg) {
+		/* case 0x0: SLDT */
+		case 0x2: /* LLDT */
+		case 0x3: /* LTR */
+			return true;
+
+		default:
+			break;
+		}
+		break;
+
+	case 0x01: /* Grp7 */
+		if (modrm_mod == 0x03)
+			break;
+
+		switch (modrm_reg) {
+		/* case 0x0: SGDT */
+		/* case 0x1: SIDT */
+		case 0x2: /* LGDT */
+		case 0x3: /* LIDT */
+			return true;
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static bool insn_is_xRET(struct insn *insn)
+{
+	u8 op1 = insn->opcode.bytes[0];
+	u8 op2 = insn->opcode.bytes[1];
+
+	if (op1 == 0xcf) /* IRET */
+		return true;
+
+	if (op1 != 0x0f)
+		return false;
+
+	if (op2 == 0x07 || op2 == 0x35) /* SYSRET, SYSEXIT */
+		return true;
+
+	return false;
+}
+
 static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
 {
 	bool allow_vmx = sld_safe || !split_lock_enabled();

