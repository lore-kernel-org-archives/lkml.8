Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9FC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454E32067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FT9p080A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCLTPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:15:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgCLTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4g9fQgW9dCodXN7ne6KwbbetdDJH4EvXKxWTgNToIY=; b=FT9p080A1NqLcZU2fcMTu0EDC2
        745cUvr6B6Oq5/t1KfF03qCKxOObYbaDRga9C1XAIn6SKhij1q/Xyq85yW13fCbr4bu+EOruwszzN
        R5oX0UVuoB+EjhjPq79XceAZEj6Knbt5nHqxJFmF4L3UoIYODUCZn6aR42vU3OtjdYp6lUb+FDegt
        Tly1v1sU77r2h5nJql7cJ8BR0eLlo4cAqAUjcEx2C/ZbgCeH5wf2KsNbq7SaALeuz4RNK2LrzsjRV
        OuWOdY9VaIL+S50IyZSVG1FfZIOx7r5JuZrn87P3YfqMBrz6kWrPIDi/vZyQaGV3+JkdiScTRlk1F
        2wX1ZWhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCTIq-0003bu-Jt; Thu, 12 Mar 2020 19:15:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABA0598114E; Thu, 12 Mar 2020 20:15:29 +0100 (CET)
Date:   Thu, 12 Mar 2020 20:15:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 00/14] x86/unwind/orc: ORC fixes
Message-ID: <20200312191529.GA5086@worktop.programming.kicks-ass.net>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:30:19PM -0500, Josh Poimboeuf wrote:
> Several ORC unwinder cleanups, fixes, and debug improvements.
> 
> Jann Horn (1):
>   x86/entry/64: Fix unwind hints in rewind_stack_do_exit()
> 
> Josh Poimboeuf (12):
>   x86/dumpstack: Add SHOW_REGS_IRET mode
>   objtool: Fix stack offset tracking for indirect CFAs
>   x86/entry/64: Fix unwind hints in register clearing code
>   x86/entry/64: Fix unwind hints in kernel exit path
>   x86/entry/64: Fix unwind hints in __switch_to_asm()
>   x86/unwind/orc: Convert global variables to static
>   x86/unwind: Prevent false warnings for non-current tasks
>   x86/unwind/orc: Prevent unwinding before ORC initialization
>   x86/unwind/orc: Fix error path for bad ORC entry type
>   x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
>   x86/unwind/orc: Add more unwinder warnings
>   x86/unwind/orc: Add 'unwind_debug' cmdline option
> 
> Miroslav Benes (1):
>   x86/unwind/orc: Don't skip the first frame for inactive tasks

Looks like good stuff..

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
