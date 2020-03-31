Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED611C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C116E206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkdoFHs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgCaVSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:18:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728124AbgCaVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0LgL0V0JjKG5HgqupeqHMxjUt+L9bajVaA6leqJ0tg=;
        b=IkdoFHs0h3lml/YG+CpNRcwPqxTTjy0kvgevLL9iVSGQOywShJjzPbMfSZMx4ul+kNpFcn
        fJh4Wv+/u9uLbSrWnV6Mp4J4+V/zJTgoti6qf1KRbl6C64gpF98+CEPopiaF1NJ4tPXC02
        cIk0ZHKieLtPljLSqEYr6fMlHs/WijQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-r0ybPYlCPNefdd9nBn720w-1; Tue, 31 Mar 2020 17:18:00 -0400
X-MC-Unique: r0ybPYlCPNefdd9nBn720w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E7A1085925;
        Tue, 31 Mar 2020 21:17:58 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A3AD1001DC2;
        Tue, 31 Mar 2020 21:17:57 +0000 (UTC)
Date:   Tue, 31 Mar 2020 16:17:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331211755.pb7f3wa6oxzjnswc@treble>
References: <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331204047.GF2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:40:47PM +0200, Peter Zijlstra wrote:
> > I now understand what you're trying to do with the RET_TAIL thing, and I
> > guess it's ok for the ftrace case.  But I'd rather an UNWIND_HINT_IGNORE
> > before the tail cail, which would tell objtool to just silence the tail
> > call warning.  It's simpler for the user to understand, it's simpler
> > logic in objtool, and I think an "ignore warnings for the next insn"
> > hint would be more generally applicable anyway.
> 
> I like how this is specific on how far the stack can be off, as opposed
> so say 'ignore any warning on this instruction'.
> 
> Because by saying this RET should be +8, we'll still get a warning when
> this is not the case (and in fact I should strengthen the patch to
> implement that).
> 
> Also, you don't want to suppress any other valid warning at that
> instruction.

Ok, I guess I'm convinced :-)  As we continue to add new warnings to
objtool, it is true that "ignore all warnings at this insn" is probably
too broad.

/me stops writing patch

BTW, if we're in agreement that this hint doesn't belong for
sync_core(), will sp_offset always be +8?  Just wondering if we can
hard-code that assumption.

> > I know you said it's like an indirect tail call with a bigger frame, but
> > that's kind of stretching it because the function frame is still there.
> > 
> > And objtool doesn't treat it like a tail call at all.  In fact, it
> > handles it *completely* differently from the normal ret-tail-call case.
> > Instead of silencing a tail call warning, it adjusts the stack offset
> > and continues the code path.
> > 
> > This basically adds *two* new hint types, while trying to call them the
> > same thing.  There's no overlapping functionality between them in
> > objtool, other than the use of the same insn->ret_offset variable.  But
> > it's two distinct functionalities, depending on the context (return/tail
> > vs IRETQ).
> 
> I'm not against adding a second/separate hint for this. In fact, I
> almost considered teaching objtool how to interpret the whole IRET frame
> so that we can do it without hints. It's just that that's too much code
> for this one case.
> 
> HINT_IRET_SELF ?

Despite my earlier complaint about stack size knowledge, we could just
forget the hint and make "iretq in C code" equivalent to "reduce stack
size by arch_exception_stack_size()" and keep going.  There's
file->c_file which tells you it's a C file.

-- 
Josh

