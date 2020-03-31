Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7B5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A2D20772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThQ8+U00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgCaUXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:23:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727852AbgCaUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585686203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1OdirHNeVVh5N6MfUuTvEJyEgcCw9DPaOMxYfCgKLQ=;
        b=ThQ8+U00NbT2LGXue+UjCm5Gm9gJe7ad5OCCTvX7ZfQAAkh0aGQyMkYgbcHT/dqGop9uBz
        tNeXBL+x/C0nWrZMATTIM6dQ8LkbfZ8BRs34KsE87Cr59OPpp0fFcMyPd7/zkRzGSW8tIQ
        s9IoB03cfLOvLO0XCPgs/4JBhIp1JDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-h-_zVjEpM_K6MpHqc1JKFQ-1; Tue, 31 Mar 2020 16:23:19 -0400
X-MC-Unique: h-_zVjEpM_K6MpHqc1JKFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5D0718A8C94;
        Tue, 31 Mar 2020 20:23:17 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE7045E009;
        Tue, 31 Mar 2020 20:23:16 +0000 (UTC)
Date:   Tue, 31 Mar 2020 15:23:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331202315.zialorhlxmml6ec7@treble>
References: <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331111652.GH20760@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 01:16:52PM +0200, Peter Zijlstra wrote:
> Subject: objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
> 
> This replaces the SAVE/RESTORE hints with a RET_OFFSET hint that applies
> to the following instructions:
> 
>  - any instruction that terminates a function, like: RETURN and sibling
>    calls. It allows the stack-frame to be off by @sp_offset, ie. it
>    allows stuffing the return stack.
> 
>  - EXCEPTION_RETURN (a new INSN_type that splits IRET out of
>    CONTEXT_SWITCH) and here it denotes a @sp_offset sized POP and makes
>    the instruction continue.

Looking closer, I see how my UNWIND_HINT_ADJUST idea doesn't work for
the ftrace_regs_caller() case.  The ORC data is actually correct there.
So basically we need a way to tell objtool to be quiet.

I now understand what you're trying to do with the RET_TAIL thing, and I
guess it's ok for the ftrace case.  But I'd rather an UNWIND_HINT_IGNORE
before the tail cail, which would tell objtool to just silence the tail
call warning.  It's simpler for the user to understand, it's simpler
logic in objtool, and I think an "ignore warnings for the next insn"
hint would be more generally applicable anyway.

But also... the RET_OFFSET usage for sync_core() *really* bugs me.

I know you said it's like an indirect tail call with a bigger frame, but
that's kind of stretching it because the function frame is still there.

And objtool doesn't treat it like a tail call at all.  In fact, it
handles it *completely* differently from the normal ret-tail-call case.
Instead of silencing a tail call warning, it adjusts the stack offset
and continues the code path.

This basically adds *two* new hint types, while trying to call them the
same thing.  There's no overlapping functionality between them in
objtool, other than the use of the same insn->ret_offset variable.  But
it's two distinct functionalities, depending on the context (return/tail
vs IRETQ).

I'll try to work up some patches with a different approach in a bit.

-- 
Josh

