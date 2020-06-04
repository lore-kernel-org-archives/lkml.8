Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E134C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4221720772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pBLxwY3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgFDQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFDQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:04:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DAC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tL9q+t8Vqftp23TReUP0WPRi7rrcPb/Bl/OGGiR0B+c=; b=pBLxwY3FdJi/B95CQxC5sy60fF
        nj6BOVbpfeRct+qR4bDej3dOtdi9Ws+RR9Sa8c6/VVQO40xC0Y3tsskNeMKN8ZKqByeF4f1Y9sSgp
        4hChjgSK0xZHMhpDNVd+HApV6CfehskCuQll6h2RAGhbjyCq3/lZVkpu3epzfHi6SgW74k2x2gO91
        Sc4rX/4DJa3xmxCp/I+qcopphb09naROy4xVyksZbXP0kT6qBieoaIM5qUd7xALtBBil0+4QUTCWj
        7uJPPPZBTW0+KoEYr9DzaAlFShUay1I9LCUkwpWXeDhyqzm4NjwiPFYUjK95+qVBsmiK2EPUfGF4K
        +absGcZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgsLW-0004Zj-Fw; Thu, 04 Jun 2020 16:03:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 239A430008D;
        Thu,  4 Jun 2020 18:03:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DB1D20D6E7D6; Thu,  4 Jun 2020 18:03:57 +0200 (CEST)
Date:   Thu, 4 Jun 2020 18:03:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
Message-ID: <20200604160357.GF3976@hirez.programming.kicks-ass.net>
References: <20200604095057.259452-1-elver@google.com>
 <20200604110918.GA2750@hirez.programming.kicks-ass.net>
 <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:02:54PM +0200, Andrey Konovalov wrote:
> On Thu, Jun 4, 2020 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > That whole kcov_remote stuff confuses me.
> >
> > KCOV_ENABLE() has kcov_fault_in_area(), which supposedly takes the
> > vmalloc faults for the current task, but who does it for the remote?
> 
> Hm, no one. This might be an issue, thanks for noticing!
> 
> > Now, luckily Joerg went and ripped out the vmalloc faults, let me check
> > where those patches are... w00t, they're upstream in this merge window.
> 
> Could you point me to those patches?
> 
> Even though it might work fine now, we might get issues if we backport
> remote kcov to older kernels.

Thinking more about this; you can't actually pre-fault for kernel
threads, as kernel threads will run with the mm of whatever regular
thread ran before them, and who knows if they have that vmalloc region
faulted in.

So Joerg's patches are pretty much the only way to guarantee remotes
will not his the vmalloc fault.
