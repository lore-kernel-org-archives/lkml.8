Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711D9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4101D21741
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9eh0jiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgCCKB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:01:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgCCKB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XlqXkLDSB+ETcyYLJsUXHHcoH+7NKDdu7FvL7NDQ/xg=; b=B9eh0jiq5+KlMWJmFSUzWYR613
        zxWNSWP+9sF4jQ+6I+IX3HYkE993QlvEhrHcH+sOgdPy4eTaG4YZYbQorOgrPoUJXJ+6zY+JKEnZO
        CVKnMu7ztGLagDpOjVy5/s7R3sRIv/z4L86IriUjgZFGxzHL6xLpa5X2i/u6McdU9zezmiW6mzHMe
        gXSSeIrME6Vu28bU42h59J2CeQOq548gmNXwfNAgs3B7u2qn+XJsB8S3ARTwOnZEXs0Paq/rPSnVl
        tRs85JnCZciWd3zNQQhuUHyUAfb+SsQ8y6EuBEcmqp18BGOBubZiH7vs28HNdFr+GA0fkRctHBvtb
        eghnNAnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j94MS-0001OM-CK; Tue, 03 Mar 2020 10:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01F453012C3;
        Tue,  3 Mar 2020 10:59:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED3D42119B2EB; Tue,  3 Mar 2020 11:01:10 +0100 (CET)
Date:   Tue, 3 Mar 2020 11:01:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        torvalds@linux-foundation.org, jannh@google.com, will@kernel.org
Subject: Re: [PATCH v2] mm: Fix use_mm() vs TLB invalidate
Message-ID: <20200303100110.GB2596@hirez.programming.kicks-ass.net>
References: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
 <202002261336.7A72F3C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002261336.7A72F3C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:36:53PM -0800, Kees Cook wrote:
> On Wed, Feb 26, 2020 at 02:21:33PM +0100, Peter Zijlstra wrote:
> > v2 now with WARN_ON_ONCE
> > [...]
> > +	WARN_ON(!(tsk->flags & PF_KTHREAD));
> > +	WARN_ON(tsk->mm != NULL);
> > [...]
> > +	WARN_ON(!(tsk->flags & PF_KTHREAD));
> 
> Version mismatch?

Dammit; no, that's just me being an idiot for doing too many things at
once :/

I suppose I'll go send v3..
