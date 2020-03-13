Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9105EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E6206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCMLKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:10:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMLKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:10:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 80966AD32;
        Fri, 13 Mar 2020 11:10:06 +0000 (UTC)
Date:   Fri, 13 Mar 2020 12:10:04 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/14] x86/dumpstack: Add SHOW_REGS_IRET mode
In-Reply-To: <2b2c601047136a4dbe42ed58715071e5323b5dae.1584033751.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2003131128180.30076@pobox.suse.cz>
References: <cover.1584033751.git.jpoimboe@redhat.com> <2b2c601047136a4dbe42ed58715071e5323b5dae.1584033751.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Josh Poimboeuf wrote:

> Now that __show_regs() has the concept of "modes" to indicate which
> registers should be displayed, replace show_iret_regs() with a new
> SHOW_REGS_IRET mode.  This is only a cleanup and doesn't change any
> behavior.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/kdebug.h |  1 +
>  arch/x86/kernel/dumpstack.c   | 27 ++++++++++-----------------
>  arch/x86/kernel/process_64.c  |  7 ++++++-
>  3 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
> index 247ab14c6309..6112227368e7 100644
> --- a/arch/x86/include/asm/kdebug.h
> +++ b/arch/x86/include/asm/kdebug.h
> @@ -23,6 +23,7 @@ enum die_val {
>  };
>  
>  enum show_regs_mode {
> +	SHOW_REGS_IRET,
>  	SHOW_REGS_SHORT,
>  	/*
>  	 * For when userspace crashed, but we don't think it's our fault, and
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index ae64ec7f752f..8a9ff25779ec 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -126,15 +126,8 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
>  	show_opcodes(regs, loglvl);
>  }
>  
> -void show_iret_regs(struct pt_regs *regs)
> -{
> -	show_ip(regs, KERN_DEFAULT);
> -	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
> -		regs->sp, regs->flags);
> -}
> -

There is also declaration of show_iret_regs() in 
arch/x86/include/asm/kdebug.h which can be removed now.

Miroslav
