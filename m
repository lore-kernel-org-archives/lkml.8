Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63797C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991B20769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586479654;
	bh=enGM3Zk5ckxO6YjhHclG/EyDxbe/4faXeT7uJSpIT3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a5JOTksISrvYwmIy6q4GxnVjNUwwei93ZpGmWmex1WpGgGhvTOknooankGxWjzPnG
	 krKTaEgy+84qV06l7clitXn9B2u7xTwkQVSyJlMkDFHm4OSMutRJyw51SjArGJlSry
	 fRC+b35OJJB2ohy2HX8e4qgljZcoAc4vjj10PHE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgDJArc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgDJArc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:47:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D9DF20768;
        Fri, 10 Apr 2020 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586479652;
        bh=enGM3Zk5ckxO6YjhHclG/EyDxbe/4faXeT7uJSpIT3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=taEFXAPgJjLCfnupDKhIlGYKK6UO3ZzxKmeDDnETQjIy6FCNAMjjXf0BeZH6jSqkQ
         PL1cRbyDaRAqoFPgYZP5SFgT8lPdbhYOOHRqj5F4KFmCPQz8hozPzS8nkxybBlU/ko
         BrA61BTbYo1FXoBNn6EUVLgz1PURBOAoMCGS81dw=
Date:   Fri, 10 Apr 2020 09:47:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Message-Id: <20200410094726.f9885bafa730fe2a8b3b3c3a@kernel.org>
In-Reply-To: <20200409143212.GW20696@hirez.programming.kicks-ass.net>
References: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
        <158636215075.6641.10786116450376715657.stgit@devnote2>
        <20200409143212.GW20696@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 16:32:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 09, 2020 at 01:09:11AM +0900, Masami Hiramatsu wrote:
> > Add insn_is_fpu(insn) which tells that the insn is
> > whether touch the FPU/SSE/MMX register or the instruction
> > of FP coprocessor.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> 
> Sadly, it turns out I need "FWAIT" too, which I tried adding like the
> below, but that comes apart most mighty :/

Thanks for pointing it out. Now I understand the FWAIT/WAIT is used
to wait for FPU...

> 
> The trouble is that FWAIT doesn't take a MODRM, so the previous
> assumption that INAT_FPU implied INAT_MODRM needs to be broken, and I
> think that ripples through somewhere.

Oops, I missed it.

> 
> (also, your patch adds some whitespace to convert_operands(), not sure
> that was intended)

Ah, that's my typo.

> 
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -206,7 +206,7 @@ Table: one byte opcode
>  98: CBW/CWDE/CDQE
>  99: CWD/CDQ/CQO
>  9a: CALLF Ap (i64)
> -9b: FWAIT/WAIT
> +9b: FWAIT/WAIT {FPU}
>  9c: PUSHF/D/Q Fv (d64)
>  9d: POPF/D/Q Fv (d64)
>  9e: SAHF
> --- a/arch/x86/tools/gen-insn-attr-x86.awk
> +++ b/arch/x86/tools/gen-insn-attr-x86.awk
> @@ -331,9 +331,13 @@ function convert_operands(count,opnd,
>  		if (match(opcode, rex_expr))
>  			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
>  
> +		# check coprocessor escape
> +		if (match(ext, "^ESC"))
> +			flags = add_flags(flags, "INAT_MODRM")
> +
>  		# check FPU/MMX/SSE superscripts
>  		if (match(ext, fpu_expr))
> -			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
> +			flags = add_flags(flags, "INAT_FPU")


OK, I'll include this.

Thank you,

>  
>  		# check VEX codes
>  		if (match(ext, evexonly_expr))


-- 
Masami Hiramatsu <mhiramat@kernel.org>
