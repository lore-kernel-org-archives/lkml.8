Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321EDC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FC120722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug+Z9F6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgCOSD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 14:03:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729001AbgCOSD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584295407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=95xS5t+H142XA8BZ5Nj0h/jFaSeDCZFMkwS3z1buK24=;
        b=Ug+Z9F6pNwWQnbsVJnHxRNEfNlyCY7XHsPl42Rz1nGp8SoHm3YMrEWPgE3AXPnr5WRhc0d
        DASJ/g3siSvAygTYXFB5ou3gtWgx8/XxllaDhGFctF0C5zxBMU4C7bSX7T7fF2A6vMt3fB
        i5GYORDtQIsznF8xiLbKMMjGxawdbzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-gCc6QIcbPKqCpfSpZoO_7Q-1; Sun, 15 Mar 2020 14:03:24 -0400
X-MC-Unique: gCc6QIcbPKqCpfSpZoO_7Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8E0F477;
        Sun, 15 Mar 2020 18:03:22 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2627560C81;
        Sun, 15 Mar 2020 18:03:22 +0000 (UTC)
Date:   Sun, 15 Mar 2020 13:03:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200315180320.cgy2ealklbjlx4g7@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135042.288201372@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:22PM +0100, Peter Zijlstra wrote:
> Validate that any call out of .noinstr.text is in between
> instr_begin() and instr_end() annotations.
> 
> This annotation is useful to ensure correct behaviour wrt tracing
> sensitive code like entry/exit and idle code. When we run code in a
> sensitive context we want a guarantee no unknown code is ran.
> 
> Since this validation relies on knowing the section of call
> destination symbols, we must run it on vmlinux.o instead of on
> individual object files.
> 
> Add the -i "noinstr validation only" option because:
> 
>  - vmlinux.o isn't 'clean' vs the existing validations
>  - skipping the other validations (which have already been done
>    earlier in the build) saves around a second of runtime.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I find the phrase "noinstr" to be WAY too ambiguous.  To my brain it
clearly stands for "no instructions" and I have to do a double take
every time I read it.

And "read_instr_hints" reads as "read_instruction_hints()".

Can we come up with a more readable name?  Why not just "notrace"?

The trace begin/end annotations could be

  trace_allow_begin()
  trace_allow_end()

Also -- what happens when a function belongs in both .notrace.text and
in one of the other special-purpose sections like .sched.text,
.meminit.text or .entry.text?

Maybe storing pointers to the functions, like NOKPROBE_SYMBOL does,
would be better than putting the functions in a separate section.

> ---
>  tools/objtool/builtin-check.c |    4 -
>  tools/objtool/builtin.h       |    2 
>  tools/objtool/check.c         |  155 ++++++++++++++++++++++++++++++++++++------
>  tools/objtool/check.h         |    3 
>  4 files changed, 140 insertions(+), 24 deletions(-)
> 
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -17,7 +17,7 @@
>  #include "builtin.h"
>  #include "check.h"
>  
> -bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
> +bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, noinstr, vmlinux;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -32,6 +32,8 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
>  	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
>  	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
> +	OPT_BOOLEAN('i', "noinstr", &noinstr, "noinstr validation only"),
> +	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
>  	OPT_END(),
>  };

It seems like there should be an easy way to auto-detect vmlinux.o,
without needing a cmdline option.

For example, if the file name is "vmlinux.o" :-)

Also, maybe we can just hard-code the fact that vmlinux.o is always
noinstr-only.  Over time we'll probably need to move more per-.o
functionalities to vmlinux.o and I think we should avoid creating a
bunch of cmdline options.

-- 
Josh

