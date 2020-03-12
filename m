Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B86C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598B520716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nINd6GUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCLKoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:44:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WqyumJrZ9gCw2EaxZyjuUmJeqSdvSfd5gO1r+0CDsHs=; b=nINd6GUIl977AwD1uxa3bR0VpV
        Cgr4ologxSnNFISHq6+cq0RxheACedmpn0oAnY0o+BZPX2jZcrFABos9O9xxR/cH1T2LwWk7gbJ3r
        UlSxMNPw13dO2ATIOKRXr1qvCSpYoEO4pJthzOevSop8xddKQpm5R0F9Xk9W5CPdhzvHw1OlCmBtH
        y362EuEx9HF7braVeT0YiSaKEgUHJJdOyxAR7C6qC7fx09g9dflwruisHeXxuGIiwl8Fm09/1gB8j
        dV1lBKcoG1UYOMMoIZ44wWU9113ers9gm2c/ZPIJskGx7f0qdwJmZjMTSBdOB7GUryh5ase1+JEW3
        Sf4oOMhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCLKI-00076U-SE; Thu, 12 Mar 2020 10:44:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAE25300328;
        Thu, 12 Mar 2020 11:44:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D09922B7403B0; Thu, 12 Mar 2020 11:44:27 +0100 (CET)
Date:   Thu, 12 Mar 2020 11:44:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: make nr_running() return "unsigned int"
Message-ID: <20200312104427.GR12561@hirez.programming.kicks-ass.net>
References: <20200311210608.GA4517@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311210608.GA4517@avx2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 12:06:08AM +0300, Alexey Dobriyan wrote:
> I don't anyone have been crazy enough to spawn 2^32 threads.
> It'd require absurd amounts of physical memory.

And we're going to 5 level page-tables because 48 bits physical isn't
enough. 57 bits of physical is plenty space to spawn that many tasks and
still have some left over.

Now 32 bit tasks is indeed insane, but memory isn't the problem. The
actual limit is the pid-space, which is 30 bits.
