Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BA6206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbgDAPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733099AbgDAPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:39:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442C1214DB;
        Wed,  1 Apr 2020 15:39:13 +0000 (UTC)
Date:   Wed, 1 Apr 2020 11:39:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401113911.21b67c0a@gandalf.local.home>
In-Reply-To: <20200401143916.h5keq55yabetyv5u@treble>
References: <20200330190205.k5ssixd5hpshpjjq@treble>
        <20200330200254.GV20713@hirez.programming.kicks-ass.net>
        <20200331111652.GH20760@hirez.programming.kicks-ass.net>
        <20200331202315.zialorhlxmml6ec7@treble>
        <20200331204047.GF2452@worktop.programming.kicks-ass.net>
        <20200331211755.pb7f3wa6oxzjnswc@treble>
        <20200331212040.7lrzmj7tbbx2jgrj@treble>
        <20200331222703.GH2452@worktop.programming.kicks-ass.net>
        <20200401141402.m4klvezp5futb7ff@treble>
        <20200401142226.GU20696@hirez.programming.kicks-ass.net>
        <20200401143916.h5keq55yabetyv5u@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 09:39:16 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > > > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > > > +		ip = ftrace_regs_caller_ret;
> > > > +		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> > > > +		if (WARN_ON(ret < 0))
> > > > +			goto fail;
> > > > +	}
> > > > +  
> > > 
> > > Hm?  This function creates a trampoline but it looks like this change is
> > > overwriting the original ftrace_64 code itself?  
> > 
> > Ahh. So if you look at what the trampoline copies, you'll note we'll
> > copy until -- but *NOT* including -- the jmp ftrace_epilogue. Instead
> > we'll write a RET at the end.
> > 
> > However, due to splitting the return path, such that each instruction
> > has a unique stack offset, we now have a second jmp ftrace_epilogue in
> > the middle of the function. That too needs to be overwritten by a RET.  
> 
> Right, but 'ip' needs to point to the trampoline's version of
> 'ftrace_regs_caller_ret', not the original ftrace_64 version.

I noticed the same thing. And after applying just this patch (with tweaking
the obtool mark ups to make it compile) it crashed.

-- Steve
