Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F9AC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6521C20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFg12bRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgDWPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729230AbgDWPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:54:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193D3C09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KwSXPvgUYiTHnatXM5A5YtzTm3Yeu/jjyhqkXoCcjDE=; b=hFg12bRGbQqFI+zNKj371TZHSW
        lvAvAaphdJwCIw2u4Xn1D3AzlFVuMW07NHIIhyJwgEAEj6mEt9EHRXRNOxx26pnQWyP5eYWngVj0m
        Q6C4OkHonMLdPzW7KgRqxmM/7/atqLEaML7jxwfLvytR8MN/2myv3xiU6zUAF3NzmT3LKMc4RdxHX
        dllTEMox+oNRv7N8LIGFwg5vTZKmksw07RFmC/ipKJDUsXDnP0wJfwxjv57aBGTGuhfgE0hjHak/W
        Y6W2I1k2MG01deBlrwvmsdyj/nng9IiSJUyeIUs48E7j0s8zrMxBq+IeP4zNdubD3I1nkgB+PxRRC
        E+x42T8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jReBH-00018N-A0; Thu, 23 Apr 2020 15:54:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C7F33011C6;
        Thu, 23 Apr 2020 17:54:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18BC720BC7378; Thu, 23 Apr 2020 17:54:25 +0200 (CEST)
Date:   Thu, 23 Apr 2020 17:54:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
Message-ID: <20200423155425.GW20730@hirez.programming.kicks-ass.net>
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
> 
> static struct stack_op *add_op(void)
> {
>         struct stack *op;
> 
>         op = calloc(1, sizeof(*op));
>         if (!op)
>                 return NULL;
>         list_add_tail(&op->list, ops_list);
> }
> 
> Then it requires two more lines when using it but I think the code is much
> cleaner and clearer, e.g.:
> 
>                         op = add_op();
>                         if (!op)
>                                 return -1;
>                         op->src.type = OP_SRC_ADD;
>                         op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
>                         op->dest.type = OP_DEST_REG;
>                         op->dest.reg = CFI_SP;

The 'problem' which this is that it doesn't NULL op again, so any later
use will do 'funny' things instead of crashing sensibly. Also, I'm
mightly lazy, I don't like endlessly repeating the same things.
