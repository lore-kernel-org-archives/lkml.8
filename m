Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670D20781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgC3SHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgC3SHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:07:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A552420780;
        Mon, 30 Mar 2020 18:07:38 +0000 (UTC)
Date:   Mon, 30 Mar 2020 14:07:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftrace not showing the process names for all processes on
 syscall events
Message-ID: <20200330140736.4b5f1667@gandalf.local.home>
In-Reply-To: <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
        <20200330110855.437fe854@gandalf.local.home>
        <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 15:34:08 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> Oh, does the 'function_graph' code ignore tail calls?

Yes and no ;-)  It works by dumb luck. As it was a year after function
graph tracing was live (some time in 2010 I believe) that someone brought
up tail calls, and I had to take a look at how it never crashed, and was
surprised that it "just worked". Here's a summary:


The function graph tracer works via the following:

start of function being traced:

  call fgraph trampoline

      Replace return code on stack with jump to return trampoline
      save original return address in shadow stack
      return back to start of function

end of function:

  pop return address
  jump to return address which is now a jump to the return trampoline:

      Return trampoline:
        trace return of function
        pop the shadow stack to get the original return address
        jump to original return address



Now let's take a look at a tail function call:


first_func() {
	some_stuff;
	tail_func();
	return;
}

tail_func() {
	some_other_stuff;
	return;
}


The above would look like in assembly something like this:


first_func:

1:    call fgaph_tramp
2:    asm some_stuff
3:    jmp tail_func


tail_func:

4:   call fgraph_trapm
5:   asm some_other_stuff
6:   pop
7:   ret

At 1 above, we call fgraph_tramp which will replace the return address on
the stack (what called first_func) with the address of the fgraph return
trampoline. And store the original address onto the shadow stack.

The stack looks like this:


  main stack:
  -----------
  fgraph return trampoline


  shadow stack:
  -------------
  original return address


At 3, we just jump directly to tail_func, without doing anything to the
stack.

At 4, fgraph_tramp is called for tail_func this time, and it will replace
its return address with a call to the fgraph return trampoline. HERE IS THE
TRICK!  The return address that was replaced, was actually the address of
the fgraph return trampoline and not the original return address. And this
is now stored on the shadow stack. Thus we have this:

  main stack:
  -----------
  fgraph return trampoline

  shadow stack:
  -------------
  original return address
  fgraph return trampoline

At 6, the fgraph return trampoline is popped off the stack, and called.

The fgraph return trampoline, will trace the end of the function, pop off
the shadow stack, and jump to that. It just happen that it pops off the
address of the fgraph return trampoline and jumps to itself again.

The second call to fgraph return trampline will trace the end of
first_func, pop the shadow stack, which this time is the original return
address, and then jump to that.

Thus, it "just works" and we can all stay happy ;-)

-- Steve
