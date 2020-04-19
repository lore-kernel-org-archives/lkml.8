Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B4EC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7065021D94
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZVhNmDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDSQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:52:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21890 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbgDSQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587315127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzz7YRw1DCsHCQiZX7ADv0pBrJTMFminqApr+J/RZrg=;
        b=ZZVhNmDE0pYoAqhlmrouuf2ouUQFtjAuJesK0J2IsIGegEhhlL9q6GXrOnu3W3WeAft+gU
        1G1jAUdojPbZ206beFA11PEvAYu8DDvrG6l6oHE66OQQlcEGnTKpMm4K7w9eTJGM2wq1YF
        qp5rQ3cKaXOO2hAHm7UqNcWc5bYslDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-GJeCgLpyMPegH3tJJLuUOQ-1; Sun, 19 Apr 2020 12:52:01 -0400
X-MC-Unique: GJeCgLpyMPegH3tJJLuUOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CA4B107ACC7;
        Sun, 19 Apr 2020 16:52:00 +0000 (UTC)
Received: from treble (ovpn-112-237.rdu2.redhat.com [10.10.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7ED46;
        Sun, 19 Apr 2020 16:51:58 +0000 (UTC)
Date:   Sun, 19 Apr 2020 11:51:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 5/7] x86/speculation: Change __FILL_RETURN_BUFFER to
 work with objtool
Message-ID: <20200419165155.4twgzmf6eusk7rv5@treble>
References: <20200416150752.569029800@infradead.org>
 <20200416151025.004441230@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416151025.004441230@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:07:57PM +0200, Peter Zijlstra wrote:
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> Change __FILL_RETURN_BUFFER so that the stack state is deterministically
> defined for each iteration and that objtool can have an accurate view
> of the stack.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200414103618.12657-8-alexandre.chartre@oracle.com
> ---
>  arch/x86/include/asm/nospec-branch.h |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -4,6 +4,7 @@
>  #define _ASM_X86_NOSPEC_BRANCH_H_
>  
>  #include <linux/static_key.h>
> +#include <linux/frame.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/alternative-asm.h>
> @@ -46,12 +47,14 @@
>  #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
>  	mov	$(nr/2), reg;			\
>  771:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>  	call	772f;				\
>  773:	/* speculation trap */			\
>  	pause;					\
>  	lfence;					\
>  	jmp	773b;				\
>  772:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>  	call	774f;				\
>  775:	/* speculation trap */			\
>  	pause;					\
> @@ -59,8 +62,8 @@
>  	jmp	775b;				\
>  774:						\
>  	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	add	$(BITS_PER_LONG/8) * 2, sp;	\
> +	jnz	771b;
>  
>  #ifdef __ASSEMBLY__

Are we still planning to warn about stack changes inside an alternative?
If so then this would still fail...

In this case I think it should be safe, but I'm not sure how we can
ensure that will always be the case for other alternatives.

And do the ORC entries actually work for this?  As far as I can tell,
they would be associated with the .altinstructions section and not
.text, so it wouldn't work.

Also, does objtool not warn about the unreachable speculation traps?
I'm guessing it doesn't notice unreachable alternatives... which I guess
is probably fine.

-- 
Josh

