Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0ECC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AD720757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdDtMB9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgCaU0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:26:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20673 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727852AbgCaU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585686407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1Z/9VwqJGcJZLfMvWDku7BlRSjz3HIVK1Stq510DBE=;
        b=DdDtMB9iY3r8nEWVoYGkevx3jEkjpOGtMumKE0T67392mR2KqOODQ0gcjd2dhUWtrvwe7z
        NWwDZ0wo2/E1+9rDw7W0LGh7xDRjHPMEg34wpOYLICwdr1QPlULyzvP1vLkTQtJy3kQ9zq
        g616RRtHr1RQHeurcLIo4sjc4p+Xf8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-URMey5dXOsugvS_dbBt6Bw-1; Tue, 31 Mar 2020 16:26:46 -0400
X-MC-Unique: URMey5dXOsugvS_dbBt6Bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A9DB800D5C;
        Tue, 31 Mar 2020 20:26:44 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF9A296B8B;
        Tue, 31 Mar 2020 20:26:43 +0000 (UTC)
Date:   Tue, 31 Mar 2020 15:26:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331202642.2hkn33dbsjgnsg7q@treble>
References: <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331113136.01316614@gandalf.local.home>
 <20200331195841.GE2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331195841.GE2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:58:41PM +0200, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 11:31:36AM -0400, Steven Rostedt wrote:
> 
> > Can you send this change as a separate patch as it has nothing to do with
> > this current change, and is a clean up patch that stands on its own.
> 
> I also found this.. should I write it up?
> 
> ---
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 369e61faacfe..0f108096f278 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -23,7 +23,7 @@
>  #endif /* CONFIG_FRAME_POINTER */
> 
>  /* Size of stack used to save mcount regs in save_mcount_regs */
> -#define MCOUNT_REG_SIZE		(SS+8 + MCOUNT_FRAME_SIZE)
> +#define MCOUNT_REG_SIZE		(SIZEOF_PTREGS + MCOUNT_FRAME_SIZE)
> 
>  /*
>   * gcc -pg option adds a call to 'mcount' in most functions.
> @@ -77,7 +77,7 @@
>  	/*
>  	 * We add enough stack to save all regs.
>  	 */
> -	subq $(MCOUNT_REG_SIZE - MCOUNT_FRAME_SIZE), %rsp
> +	subq $(SIZEOF_PTREGS), %rsp
>  	movq %rax, RAX(%rsp)
>  	movq %rcx, RCX(%rsp)
>  	movq %rdx, RDX(%rsp)

I was going to suggest the same thing :-)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

