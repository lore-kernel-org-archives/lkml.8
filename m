Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48835C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A8A2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbgDBI6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:58:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387780AbgDBI6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:58:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CA9AAA55;
        Thu,  2 Apr 2020 08:58:07 +0000 (UTC)
Date:   Thu, 2 Apr 2020 10:58:07 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
In-Reply-To: <0a750745-b069-9ef2-61d3-a15b8fecb649@redhat.com>
Message-ID: <alpine.LSU.2.21.2004021053160.19977@pobox.suse.cz>
References: <20200331111652.GH20760@hirez.programming.kicks-ass.net> <20200331202315.zialorhlxmml6ec7@treble> <20200331204047.GF2452@worktop.programming.kicks-ass.net> <20200331211755.pb7f3wa6oxzjnswc@treble> <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net> <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com> <20200401170910.GX20730@hirez.programming.kicks-ass.net> <684d6e29-4a01-b4a5-f906-7bdee5ad108f@redhat.com> <20200402075036.GA20730@hirez.programming.kicks-ass.net>
 <20200402081710.GJ20760@hirez.programming.kicks-ass.net> <0a750745-b069-9ef2-61d3-a15b8fecb649@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020, Julien Thierry wrote:

> 
> 
> On 4/2/20 9:17 AM, Peter Zijlstra wrote:
> > On Thu, Apr 02, 2020 at 09:50:36AM +0200, Peter Zijlstra wrote:
> >> On Thu, Apr 02, 2020 at 07:41:46AM +0100, Julien Thierry wrote:
> > 
> >>> Also, instead of adding a special "arch_exception_frame_size", I could
> >>> suggest:
> >>> - Picking this patch [1] from a completely arbitrary source
> >>> - Getting rid of INSN_STACK type, any instruction could then include stack
> >>> ops on top of their existing semantics, they can just have an empty list
> >>> if
> >>> they don't touch SP/BP
> >>> - x86 decoder adds a stack_op to the iret to modify the stack pointer by
> >>> the
> >>> right amount
> >>
> >> That's not the worst idea, lemme try that.
> > 
> > Something like so then?
> > 
> 
> Yes, you could even remove INSN_STACK from insn_type and just always call
> handle_insn_ops() before the switch statement on insn->type. If the list is
> empty it does nothing.
> This way you wouldn't need to call it for the INSN_EXCEPTION_RETURN case, and
> any type of instructions could use stack_ops.
> 
> 
> And the other suggestion is my other email was that you don't even need to add
> INSN_EXCEPTION_RETURN. You can keep IRET as INSN_CONTEXT_SWITCH by default and
> x86 decoder lookups the symbol conaining an iret. If it's a function symbol,
> it can just set the type to INSN_OTHER so that it caries on to the next
> instruction after having handled the stack_op.
> 
> And everything fits under tools/objtool/arch/x86 :) .
> 
> Or is it too far-fetch'd?

Imho no. Well, it depends. I can see benefits of both approach. PeterZ's 
patch is quite minimal and it demonstrates itself as a one-off hack quite 
well. On the other hand, it is in a generic code, which is not nice 
especially when other archs do not have such thing. So your proposal would 
indeed make sense to hide it in arch-specific code. Especially for the 
future. And INSN_STACK is not used much in the code, so it can be removed 
easily as you proposed.

And going more in direction of supporting more archs in the future, I'd 
say it would make sense to allow more generic things such as "forget about 
INSN_STACK. If an instruction has non-empty stack_ops list, just process 
it". It is definitely more flexible.

So yes, I think it make sense unless I am missing something.

Miroslav
