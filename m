Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4299C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E1F20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neRdBchb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgDWQRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:17:24 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAFAC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iZrweN9eLmW7wiF8Ronk6pSDprkhVTVjX9L9M75OoZs=; b=neRdBchbbP/OCKWE1H8nvjo05d
        G9JLZSe9YX/XQFqNTHIfrP7XR9DJO9ShBHV48JuK7NFFjaMBDu/Mq40T8bwbTTXk1uwj9ArtGRYeL
        zE0ADuBVmC+Z97jnuGwENDR3tzuNumnyHi9sKZ2aAsd0ONUhuelR/UJbC+Dcu0ONtHnV3zAah86aw
        7n4ILg4oSvGYQ0IPHMcN7wZy4fn5yaR4a2BlsjHeAIvx83dvLqTxnGHRlh+VwKf5v/rxv7aVn6Qw2
        LlcEsHxqV1pjvCGvMLRLpbNYbml+HNF3jc+62jfh+IgoQNUW9UAwAx+vcVMNv3p9UYtBFP0u0H5dV
        /eAS69hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jReX5-0003Fv-9x; Thu, 23 Apr 2020 16:16:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29B583011C6;
        Thu, 23 Apr 2020 18:16:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16EBC2392DE85; Thu, 23 Apr 2020 18:16:56 +0200 (CEST)
Date:   Thu, 23 Apr 2020 18:16:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
Message-ID: <20200423161656.GX20730@hirez.programming.kicks-ass.net>
References: <20200423125013.452964352@infradead.org>
 <20200423125042.713052240@infradead.org>
 <7df9ec97-dc14-c4b6-fb26-f163e9afb1cd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7df9ec97-dc14-c4b6-fb26-f163e9afb1cd@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:40:38PM +0200, Alexandre Chartre wrote:
> 
> On 4/23/20 2:47 PM, Peter Zijlstra wrote:
> > Wrap each stack_op in a macro that allocates and adds it to the list.
> > This simplifies trying to figure out what to do with the pre-allocated
> > stack_op at the end.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   tools/objtool/arch/x86/decode.c |  257 +++++++++++++++++++++++-----------------
> >   1 file changed, 153 insertions(+), 104 deletions(-)
> > 
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -77,6 +77,17 @@ unsigned long arch_jump_destination(stru
> >   	return insn->offset + insn->len + insn->immediate;
> >   }
> > +#define PUSH_OP(op) \
> > +({ \
> > +	list_add_tail(&op->list, ops_list); \
> > +	NULL; \
> > +})
> > +
> > +#define ADD_OP(op) \
> > +	if (!(op = calloc(1, sizeof(*op)))) \
> > +		return -1; \
> > +	else for (; op; op = PUSH_OP(op))
> > +
> 
> I would better have a function to alloc+add op instead of weird macros,
> for example:

I know it'll not make you feel (much) better, but we can write it
shorter:

+#define ADD_OP(op) \
+       if (!(op = calloc(1, sizeof(*op)))) \
+               return -1; \
+       else for (list_add_tail(&op->list, ops_list); op; op = NULL)

Also, the kernel is full of funny macros like this ;-)
