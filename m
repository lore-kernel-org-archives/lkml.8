Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1747C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786722072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3HX9eH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgC3TCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:02:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39503 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgC3TCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585594936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6zp2QJVJpIP8WXOxtm6IGtb5ZWgTJYBDO5pfh4qyN0=;
        b=W3HX9eH/JHEIbhe2/KeOQeaXv3BmWS8CLpS1yiGHrAkG6wg6uvEvb8DYhVVK7Wn7HNQebk
        OmRCP94QYaJ6TuibnLryOaSBd5LtzE4ySJJr56SefSCXj2+RXHUd6t5CZfR5L1A0LVbXpm
        Cgr2gv0MA/uxn/0mprkSZp3q2zoEBWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-8Z87KwO5OgqT86voizP4jQ-1; Mon, 30 Mar 2020 15:02:11 -0400
X-MC-Unique: 8Z87KwO5OgqT86voizP4jQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4615F107ACCA;
        Mon, 30 Mar 2020 19:02:10 +0000 (UTC)
Received: from treble (ovpn-112-172.rdu2.redhat.com [10.10.112.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 991925C1C5;
        Mon, 30 Mar 2020 19:02:08 +0000 (UTC)
Date:   Mon, 30 Mar 2020 14:02:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200330190205.k5ssixd5hpshpjjq@treble>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:02:00PM +0200, Peter Zijlstra wrote:
> Subject: objtool: Implement RET_TAIL hint
> 
> This replaces the SAVE/RESTORE hints with a RET_TAIL hint that applies to:
> 
>  - regular RETURN and sibling calls (which are also function exists)
>    it allows the stack-frame to be off by one word, ie. it allows a
>    return-tail-call.
> 
>  - EXCEPTION_RETURN (a new INSN_type that splits IRET out of
>    CONTEXT_SWITCH) and here it denotes a return to self by having it
>    consume arch_exception_frame_size bytes off the stack and continuing.
> 
> Apply this hint to ftrace_64.S and sync_core(), the two existing users
> of the SAVE/RESTORE hints.
> 
> For ftrace_64.S we split the return path and make sure the
> ftrace_epilogue call is seen as a sibling/tail-call turning it into it's
> own function.
> 
> By splitting the return path every instruction has a unique stack setup
> and ORC can generate correct unwinds (XXX check if/how the ftrace
> trampolines map into the ORC). Then employ the RET_TAIL hint to the
> tail-call exit that has the direct-call (orig_eax) return-tail-call on.
> 
> For sync_core() annotate the IRET with RET_TAIL to mark it as a
> control-flow NOP that consumes the exception frame.

I do like the idea to get rid of SAVE/RESTORE altogether.  And it's nice
to make that ftrace code unwinder-deterministic.

However sync_core() and ftrace_regs_caller() are very different from
each other and I find the RET_TAIL hint usage to be extremely confusing.

For example, IRETQ isn't even a tail cail.

And the need for the hint to come *before* the insn which changes the
state is different from the other hints.

And now objtool has to know the arch exception stack size because of a
single code site.

And for a proper tail call, the stack should be empty.  I don't
understand the +8 thing in has_modified_stack_frame().  It seems
hard-coded for the weird ftrace case, rather than for tail calls in
general (which should already work as designed).

How about a more general hint like UNWIND_HINT_ADJUST?

For sync_core(), after the IRETQ:

  UNWIND_HINT_ADJUST sp_add=40

And ftrace_regs_caller_ret could have:

  UNWIND_HINT_ADJUST sp_add=8
  
-- 
Josh

