Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F401C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728BB23B44
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD4ybwLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgDFOQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728595AbgDFOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586182605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WcO8TXZOfAAlpthvQyqPPILllkYX4ryRFO2UZO2nFW8=;
        b=cD4ybwLu3E5S2IcYzH3HymarOHu1lK2WQ9u7h1Y217kb4W+9tb1FC8mXY7WyqHLgYGLbFW
        0G62kMbh3DvivCutaTcAgyIJK0/fvCJCioSBIk7WDLzBbQpyDRga1qy+wPNNY71ijt5yl+
        PiKkBBYvVdyq2WT5CgbI0Dx+KDj9HG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-o3QKa2jSOQKa9W5BXxPUmQ-1; Mon, 06 Apr 2020 10:16:41 -0400
X-MC-Unique: o3QKa2jSOQKa9W5BXxPUmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C8269898;
        Mon,  6 Apr 2020 14:16:23 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C2645C1B0;
        Mon,  6 Apr 2020 14:16:22 +0000 (UTC)
Date:   Mon, 6 Apr 2020 09:16:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200406141620.tlsywln52gopinos@treble>
References: <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
 <20200404142232.wpn7estahnabfy3z@treble>
 <20200404155126.GF20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200404155126.GF20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 05:51:26PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 04, 2020 at 09:22:32AM -0500, Josh Poimboeuf wrote:
> > On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> > > > On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > > > > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > > > > work here?
> > > > 
> > > > Yes, it would.
> > > 
> > > Sorry, I have reconsidered. While it will shut up objtool, it will not
> > > 'work'. That is, the ORC data generated will not correctly unwind.
> > > 
> > > I'll try and write a longer email tonight.
> > 
> > Right, that's what I've been trying to say.  The ORC data will be
> > non-deterministic unless we unroll the loop.  Or did you mean something
> > else?
> 
> The below should result in deterministic code.
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 07e95dcb40ad..109ee65f4a11 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -59,8 +59,8 @@
>  	jmp	775b;				\
>  774:						\
>  	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	add	$(BITS_PER_LONG/8) * $2, sp;	\
> +	jnz	771b;
>  
>  #ifdef __ASSEMBLY__

That should work, though we should make sure it doesn't break the RSB
clearing -- I'm pretty sure it wouldn't, but you never know...

-- 
Josh

