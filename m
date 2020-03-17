Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D009C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428C920735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XYU1URAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:14:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34602 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgCQMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Ey7nc3Xwn+RHDnAhkb2QTzFDpMtlF+8imW4XG/pP40=; b=XYU1URAk9H9cVZdK3E6YU35U8A
        Su8vsVEV3kMqBbDQOvw2d61EPqeBQTqxQt6Aad8a7WhkbVq0Vqe06GqzZFe5KdtjU8CXX2Klobupz
        AtTEObV6MZXNjMA/HK1Mh0yDPs4u1DDZ7JDpirL/xH9vLtlcONcJjJd4VfiCsGkBXvlbJAm0Bd0sN
        lmfB6tJdSdm+M1pqCHCbqfO3poBhbFt1Jk5s0yVHv6B0fGmXwyE3kEe/OfyZQpr7eiiWc5NoWe0aY
        GoDExRbTaQpuOC+P1k47qv15qKig0y23H9iX/v3NO9XTaiynrlMByWcaS6dMd7R1nH7k8PK2UDe8N
        efI8SCiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEB79-0005WV-Ne; Tue, 17 Mar 2020 12:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0B2830110E;
        Tue, 17 Mar 2020 13:14:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B699D20C4A235; Tue, 17 Mar 2020 13:14:28 +0100 (CET)
Date:   Tue, 17 Mar 2020 13:14:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-ID: <20200317121428.GI12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312162337.GU12561@hirez.programming.kicks-ass.net>
 <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:56:28AM +0900, Masami Hiramatsu wrote:
> On Thu, 12 Mar 2020 17:23:37 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > So one of the problem i've ran into while playing with this and Thomas'
> > patches is that it is 'difficult' to deal with indirect function calls.
> > 
> > objtool basically gives up instantly.
> 
> Can we introduce a "safe-call" wrapper function instead of indirect
> call, and if objtool found an indirect call without safe-call function,
> it can make it an error?
> 
> static int __noinstr safe_indirect_callback(int (*fn)(...), real-args)
> {
> 	if (!is_instr_text(fn))
> 		return -ERANGE;
> 	return fn(real-args)
> }

That is a runtime test and as such susceptible to code coverage issues.

I could probably frob a few cases manually in objtool; so far I've
managed to just make them go away.

> BTW, out of curiously, if BUG*() or WARN*() cases happens in the noinstr
> section, do we also need to move them (register dump, stack unwinding,
> printk, console output, etc.) all into noinstr section?

Since BUG/WARN should not happen, we've added instr_begin()/instr_end()
to their slow path. If those trigger, we've got bigger issues.

