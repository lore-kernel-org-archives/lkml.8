Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20035C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37EC2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/yHYzN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgDIOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:32:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgDIOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cek1JPKBY7wOsIzhQYQVdn8n+IKcetIj9PBwUwI8zUQ=; b=S/yHYzN/QmYNh6Jx5SKM+j2DDS
        VNNzYgF+FTyUYeT21cye7O8KkO46LRqbgExLOUhryqYvXj9PddsgQmYkXIiyk9LUIKF3/E5H8YckW
        kAd27TVxtTvfpNK+K6KyLJOqIJ88fp9O3s/j6uuJTwzBIpLvG8rXIukRGIQ8Y+vLbS4ysD629L8zc
        2a42M6Qd+Y/H0fRCrhdJSQ++DfiTlWAn6uP2V/uAkRx5YJ2/Sbm/QaG5Tx2ENnaX6bR4zl9jU+eG7
        aVvxZ9Aow5oR2bJwISyFUDV00YJOA1JSo0E3RiOe5ucjarubLHUTmfFv+hiDGkPPG0O/51nTYa9jF
        iobVz3ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMYE3-0008G2-C1; Thu, 09 Apr 2020 14:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D32253012D8;
        Thu,  9 Apr 2020 16:32:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA64B2B0BDA4F; Thu,  9 Apr 2020 16:32:12 +0200 (CEST)
Date:   Thu, 9 Apr 2020 16:32:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] x86: insn: Add insn_is_fpu()
Message-ID: <20200409143212.GW20696@hirez.programming.kicks-ass.net>
References: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
 <158636215075.6641.10786116450376715657.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158636215075.6641.10786116450376715657.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 01:09:11AM +0900, Masami Hiramatsu wrote:
> Add insn_is_fpu(insn) which tells that the insn is
> whether touch the FPU/SSE/MMX register or the instruction
> of FP coprocessor.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---

Sadly, it turns out I need "FWAIT" too, which I tried adding like the
below, but that comes apart most mighty :/

The trouble is that FWAIT doesn't take a MODRM, so the previous
assumption that INAT_FPU implied INAT_MODRM needs to be broken, and I
think that ripples through somewhere.

(also, your patch adds some whitespace to convert_operands(), not sure
that was intended)

--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -206,7 +206,7 @@ Table: one byte opcode
 98: CBW/CWDE/CDQE
 99: CWD/CDQ/CQO
 9a: CALLF Ap (i64)
-9b: FWAIT/WAIT
+9b: FWAIT/WAIT {FPU}
 9c: PUSHF/D/Q Fv (d64)
 9d: POPF/D/Q Fv (d64)
 9e: SAHF
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -331,9 +331,13 @@ function convert_operands(count,opnd,
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
+		# check coprocessor escape
+		if (match(ext, "^ESC"))
+			flags = add_flags(flags, "INAT_MODRM")
+
 		# check FPU/MMX/SSE superscripts
 		if (match(ext, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
+			flags = add_flags(flags, "INAT_FPU")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
