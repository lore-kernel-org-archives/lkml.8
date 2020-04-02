Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F07C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DE62078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbgDBRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgDBRxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:53:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9B82077D;
        Thu,  2 Apr 2020 17:52:59 +0000 (UTC)
Date:   Thu, 2 Apr 2020 13:52:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Claudiu Zissulescu <claziss@gmail.com>
Subject: Re: [RFC] ARC: initial ftrace support
Message-ID: <20200402135257.7dd14f36@gandalf.local.home>
In-Reply-To: <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
References: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
        <20200327131020.79e68313@gandalf.local.home>
        <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 01:17:01 +0000
Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> +CC Claudiu
> 
> On 3/27/20 10:10 AM, Steven Rostedt wrote:
> > On Fri, 27 Mar 2020 18:53:55 +0300
> > Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com> wrote:  
> 
> Maybe add a comment that gcc does the heavy lifting: I have following in glibc
> 
> +/* this is very simple as gcc does all the heavy lifting at _mcount call site
> + *  - sets up caller's blink in r0, so frompc is setup correctly
> + *  - preserve argument registers for original call */
> 
> >> +noinline void _mcount(unsigned long parent_ip)
> >> +{
> >> +	unsigned long ip = (unsigned long)__builtin_return_address(0);
> >> +
> >> +	if (unlikely(ftrace_trace_function != ftrace_stub))
> >> +		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
> >> +				      NULL, NULL);
> >> +}
> >> +EXPORT_SYMBOL(_mcount);  
> > 
> > So, ARCv2 allows the _mcount code to be written in C? Nice!  
> 
> Yeah, the gcc backend for -pg was overhauled recently so it is a first class "lib
> call" meaning we get all the register save/restore for free as well as caller PC
> (blink) as explicit argument to _mcount
> 
> void bar(int a, int b, int c) {
> 	printf("%d\n", a, b, c);
> }
> 
> bar:
> 	push_s	blink
> 	std.a r14,[sp,-8]
> 	push_s	r13
> 	mov_s	r14,r1
> 	mov_s	r13,r0
> 	mov_s	r0,blink
> 	bl.d @_mcount
> 	mov_s	r15,r2
> 
> 	mov_s	r3,r15   <-- restore args for call

We really don't want this. :-/

This will make it really difficult to implement the dynamic ftrace, and
this causes more overhead when tracing is not enabled.

Also, ftrace is much more complex, and this will make it difficult to have
function graph tracing and other features.

Gcc has an "instrument-functions" which people asked me why I didn't go
that route, as it lets you do the same (call C code), and its because of
the overhead it adds to each function that I turned it down.

-- Steve



> 	mov_s	r2,r14
> 	mov_s	r1,r13
> 	mov_s	r0,@.LC0
> 	ld	blink,[sp,12]
> 	pop_s	r13
> 	b.d	@printf
> 	ldd.ab r14,[sp,12]
> 
> @Eugeniy, this patch looks ok to me, but a word of caution. This won't work with
> elf32 toolchain which some of the build systems tend to use (Alexey ?)
> 
> The above _mcount semantics is only implemented for the linux tool-chains.
> elf32-gcc generates "legacy" __mcount (2 underscores, blink not provided as arg)
> likely done by Claudiu to keep newlib stuff unchanged. Perhaps elf32 gcc can add a
> toggle to get new _mcount.
> 
> And this is conditional to ARCv2 due to future ties into dynamic ftrace and
> instruction fudging etc ? We may have to revisit that for BE anyhow given such a
> customer lining up.
> 
> -Vineet

