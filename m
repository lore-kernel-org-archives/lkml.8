Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5522080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ar1cQ7cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbgDBPk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:40:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgDBPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esjjBZxKnGNy+IIHWT7KnlJCrv+OC0h6w5d5h2JWV7c=; b=Ar1cQ7ccV2xZGXsK/bV7FKiDyY
        n4ihXvv0gfo/dEQWwHTG9Xsy+1cskV86+pyGqRkswFzaUB5ubPEUinmc69JVK0/T0YEfS0cZ9m/W4
        k52nbYod9CIaa1U2XhbmtjuD3nNXS7PUwSoNz0MkAqTWluVbBIJ3RMqkGTPvv5oEXkdkfYQhuQPS8
        64IF49iZupFeDD4DI9HYjfGsGqpiPV9lkP2eptc1sawEnYmFCFgYK5zwEKVWzkpCVa8vtYq6Iuo7d
        y3crhlCEQ/0u8zDGRtPlP5hLydCRKB7yfI8WnBsJ+jyvXvmF2jdSQv1ZtSfE0U6amjuXPTwTlXY4d
        8svU6Xkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK1xA-0003kO-GG; Thu, 02 Apr 2020 15:40:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3A48306089;
        Thu,  2 Apr 2020 17:40:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE9B92B0DED96; Thu,  2 Apr 2020 17:40:22 +0200 (CEST)
Date:   Thu, 2 Apr 2020 17:40:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200402154022.GG20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:31:05PM +0100, Julien Thierry wrote:
> My understanding is that once you find an intra-function call, either you
> hit a return, ending the branch, so the return should undo the modification
> the intra-function call did (whether is it a retpoline return or not).
> Otherwise, the intra-function call branch will need to reach an end in some
> way (e.g. hitting a CONTEXT_SWITCH instruction, calling a
> dead_end_function).
> 
> Am I missing something?

The thing is basically doing:

	mov  $n, cx
1:	call 2f
2:	dec  cx
	jnz  1b
	add  8*n, sp

So it does N calls to self, then subtracts N words from the stack.

The reason being that the CPU has a return-stack-buffer for predicting
returns, and call/ret being naturally paired, that works. The above
is a software flush of the RSB.

