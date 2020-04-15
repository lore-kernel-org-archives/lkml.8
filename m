Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6553A20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586939031;
	bh=0kpxY7WRGFbm5Qwfk/sr8dvg3Yio8hbJ+U8aY4ogpnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ht//3nL+q4XA0DREqnJRLYaaM9WfiprRoCNBybh6VaQjFTRYZumwU+fse/mgF7gud
	 WzSOqeyrb/r5Mppi05ppFiUlwsu67xpgtqYIyqUb58UcHsWSaWhUU8jJM0EBIJD8Ny
	 +RbOlOmmYsi79OFssnoZiVNXTaQqkwIPVQpcUSIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894391AbgDOIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635898AbgDOIXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:23:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 803C520784;
        Wed, 15 Apr 2020 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586939018;
        bh=0kpxY7WRGFbm5Qwfk/sr8dvg3Yio8hbJ+U8aY4ogpnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGM9sA8DLqJS/QtEocHEqn/OvB/TI8TVm/SPdYRlIaKnHqtE4vOYZjexduuu5974c
         hrpTnb4L2dDtN9i58/NQOYkv28mC7SPW0RuV8+EGtecJ3NngVYWdwaUqcYn8W2m3+S
         2bvaxNKzZCBZfN/N9RLXRcbMvBWXMf7Jly+QPEa0=
Date:   Wed, 15 Apr 2020 17:23:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v3] x86: insn: Add insn_is_fpu()
Message-Id: <20200415172331.96807c231956f3a7255b0202@kernel.org>
In-Reply-To: <158648174982.1073.6608148826246795028.stgit@devnote2>
References: <20200409143212.GW20696@hirez.programming.kicks-ass.net>
        <158648174982.1073.6608148826246795028.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 10:22:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> @@ -318,10 +331,14 @@ function convert_operands(count,opnd,       i,j,imm,mod)
>  		if (match(opcode, rex_expr))
>  			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
>  
> -		# check coprocessor escape : TODO
> -		if (match(opcode, fpu_expr))
> +		# x87 escape opcode needs MODRM
> +		if (match(ext, x87_expr))

Oops, it must be match(opcode, x87_expr). I'll fix it.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
