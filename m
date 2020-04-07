Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDAC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD6B20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3BXaZZxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgDGTlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:41:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57106 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rg9Zo5WhZ/L+g9noY6cXA3kVA2E3WxWXpgepHp8ztII=; b=3BXaZZxqSeNXfw7lYzC50SSaKp
        gBC/wiEU6omWRWUOXz2LqoCNgAH1d0vz8h3dVqHXk4zrl9mGtICZgeXUYvj2csOMLgD8LCexqGsIJ
        YE1QcAAKqcH+3zrfzEOYXqr8BxQbYDLi/QpnNRgPRSmM7aWwAS7cd6QoVHfawdZTSPHoz4LwvOOuk
        Qx+srqlN1ydZt0RSWaKpxRpaVWFd1PnWwf6v58wyX8D+lYDCwU5Ugb/FVqU5jw2DLhuQ5Kxp/sTkm
        Copr7Vowiisz52ko/Q4T5IYECgBqupfJsAS36K3jir3z0bixkP2mBaRBL5wqJZwkBPlUuvvweK8hb
        kc8MM2yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLu5y-0000vz-Di; Tue, 07 Apr 2020 19:41:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92B9E983507; Tue,  7 Apr 2020 21:41:12 +0200 (CEST)
Date:   Tue, 7 Apr 2020 21:41:12 +0200
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
Message-ID: <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:23:27PM +0100, Andrew Cooper wrote:
> On 07/04/2020 12:02, Peter Zijlstra wrote:
> > Hi all,
> >
> > Driven by the SLD vs VMX interaction, here are some patches that provide means
> > to analyze the text of out-of-tree modules.
> >
> > The first user of that is refusing to load modules on VMX-SLD conflicts, but it
> > also has a second patch that refulses to load any module that tries to modify
> > CRn/DRn.
> >
> > I'm thinking people will quickly come up with more and more elaborate tests to
> > which to subject out-of-tree modules.
> 
> Anything playing with LGDT & friends?  Shouldn't be substantially more
> elaborate than CR/DR to check for.

More friends? (I wasn't sure on the Sxxx instructions, they appear
harmless, but what do I know..)

I was also eyeing LSL LTR LSS, none of which I figured a module has any
business of using. Are there more?

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -282,6 +282,50 @@ static bool insn_is_mov_DRn(struct insn
 	return false;
 }
 
+static bool insn_is_LxDT(struct insn *insn)
+{
+	u8 modrm = insn->modrm.bytes[0];
+	u8 modrm_mod = X86_MODRM_MOD(modrm);
+	u8 modrm_reg = X86_MODRM_REG(modrm);
+
+	if (insn->opcode.bytes[0] != 0x0f)
+		return false;
+
+	switch (insn->opcode.bytes[1]) {
+	case 0x00:
+		if (modrm_mod != 0x03)
+			break;
+
+		switch (modrm_reg) {
+		case 0x0: /* SLDT */
+		case 0x2: /* LLDT */
+			return true;
+
+		default:
+			break;
+		}
+		break;
+
+	case 0x01:
+		switch (modrm_reg) {
+		case 0x0: /* SGDT */
+		case 0x1: /* SIDT */
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
 static int decode_module(struct module *mod, void *text, void *text_end, bool sld_safe)
 {
 	bool allow_vmx = sld_safe || !split_lock_enabled();

