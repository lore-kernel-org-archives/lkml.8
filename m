Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8203C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74C7206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRA87ZpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgD1PtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:49:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgD1PtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588088956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2/K5uPFOC3xkb96FgK9bRPm2O5D0n0FhbGzP2S0ozQ=;
        b=TRA87ZpCeQsey3moCnl/ziy5LVqrBhNGsUeMn7mzzzeNcM0LuIXvWmg1dki0t9n/KYejyC
        VAoy78mim3UZiIIMwgbjPvAJI58EYnYMH15Rhhe26MtJpfavMzIF8o64Em0jOJG7bKObD8
        oaJCOK4JqZyxtjjEOjpc9xwv0UIx7cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-fEAv9dx4M3eIBZgtKgb0eA-1; Tue, 28 Apr 2020 11:49:13 -0400
X-MC-Unique: fEAv9dx4M3eIBZgtKgb0eA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4C7108BD1B;
        Tue, 28 Apr 2020 15:49:12 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AB4019C4F;
        Tue, 28 Apr 2020 15:49:11 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:49:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428154909.4cjwetyyb2zhnq5i@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428152552.GD13592@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:25:52PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 09:31:57AM -0500, Josh Poimboeuf wrote:
> > That's quite the monstrosity, and I still don't see the point.  I
> > thought we decided to just disallow CFI changes in alternatives anyway?
> > That can be done much simpler.
> 
> Something like so then ?
> 
> ---
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 8443ec690051..d14d83e6edb0 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -940,6 +940,7 @@ static int handle_group_alt(struct objtool_file *file,
>  
>  		last_new_insn = insn;
>  
> +		insn->alt_group = true;
>  		insn->ignore = orig_insn->ignore_alts;
>  		insn->func = orig_insn->func;
>  
> @@ -2242,6 +2243,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
>  	list_for_each_entry(op, &insn->stack_ops, list) {
>  		int res;
>  
> +		if (insn->alt_group) {
> +			WARN_FUNC("alternative has CFI", insn->sec, insn->offset);
> +			return 1;
> +		}
> +

ACK (separate patch)

>  		res = update_cfi_state(insn, &state->cfi, op);
>  		if (res)
>  			return res;
> @@ -2439,12 +2445,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  	sec = insn->sec;
>  
> -	if (insn->alt_group && list_empty(&insn->alts)) {
> -		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
> -			  sec, insn->offset);
> -		return 1;
> -	}
> -

ACK (separate patch)

>  	while (1) {
>  		next_insn = next_insn_same_sec(file, insn);
>  
> @@ -2494,8 +2494,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  				}
>  			}
>  
> -			if (skip_orig)
> +			if (skip_orig) {
> +				struct instruction *prev_insn = insn;
> +				sec_for_each_insn_continue(file, insn) {
> +					if (!insn->alt_group)
> +						break;
> +					if (!insn->visited)
> +						insn->cfi = prev_insn->cfi;
> +				}
>  				return 0;
> +			}

NACK :-)

What happens if you have two alternatives adjacent to each other (which
can definitely happen in this scenario)?

I still like my patch, at least the hack is done before the validate
code, so validate_branch() itself is simpler.

-- 
Josh

