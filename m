Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68752C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A35206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DONDXx4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFGS14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgFGS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:27:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B76C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 11:27:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r16so7309789qvm.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QmioGnH7qJDU3OT9mDHd8GSZIvVq3zAcNpAh4ZmXQXQ=;
        b=DONDXx4kIl1CWLeuYYZotwdR/DNK0w4LSW4LZSyed98N0pJTL1+KCUMJ2ZSgA0mIW4
         eCIGEqZr+9L50bW44bbsfAf9ugAIpc4moImHi4WPyhYfHdJBlXqdHw6jH8Jmp/a7zLbE
         wvCHYg9/ov8KNQUqWE2zlkvE1GnltqZ/kMKMEt7gNkZc6K4jTjS0LvuePx9uzdpHxc2J
         wYWK1+CPyTjG0S7G8d5i2gn9u232/Amylyk0oW03+led6h5mIB3F4MJfV2AiLmW8BOFa
         28fuVnO2gIeIocWC3I5jqlzoOOd+pCzBDytw2eauHzWBdTqs6XBTYqPX8thm0rQLTqqa
         7DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QmioGnH7qJDU3OT9mDHd8GSZIvVq3zAcNpAh4ZmXQXQ=;
        b=EfflaPkhjIPv18+Cm0jk16MpuA1tKMzperHIb3erJ5q6/9KnZ21dhh4klDRUqnBGEJ
         eyLWolqmAWz7Fp9goM+Z5CqSZlf7W96v5Fc0Jf7gsCnGC5LzYlCrDAtVlu8oTGdC7fNL
         G22zRZoUwrrCUxFSQThH3ok2M5cHm2K6rMUmLaWiRRGbLpPMr4bRNoGqs3+iJUVvBmVB
         +8HInzmH5FqmaOdwK29s6hgJkv2Aex4o080DG2vYcd7S6XgdXYi9u/h51KVpNDvC6RNz
         GSUdk/yTpk4bkTYg0DZd4ncDxs9S2DiBAa9Em5cAmzvthItoB3POSa0cgaf7Udzi9Md1
         thFg==
X-Gm-Message-State: AOAM530yeaZmMJzsunIYKuE3x3H4PtJeMzo3nAmXXRc7WmOIEV5gMeOx
        C9hhNVmCIjrwOxSbb9AJBo7x/g==
X-Google-Smtp-Source: ABdhPJxzVAgSN0Cs3q/FkwYmpiknOWuq5kQ37Mbx7o3xldPy74zuaHdSaiGFb+u0Mem356Cm3OhizA==
X-Received: by 2002:ad4:5485:: with SMTP id q5mr10600649qvy.62.1591554474520;
        Sun, 07 Jun 2020 11:27:54 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 5sm5102607qko.14.2020.06.07.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:27:53 -0700 (PDT)
Date:   Sun, 7 Jun 2020 14:27:46 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200607182746.GA1361@lca.pw>
References: <20200521200513.656533920@linutronix.de>
 <20200521202117.763775313@linutronix.de>
 <20200605171816.GA4259@lca.pw>
 <20200605173622.GL3976@hirez.programming.kicks-ass.net>
 <20200605175200.GA5393@lca.pw>
 <87v9k3jdc6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9k3jdc6.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 01:59:53PM +0200, Thomas Gleixner wrote:
> 
> CC:+ Alexander
> 
> Qian Cai <cai@lca.pw> writes:
> > On Fri, Jun 05, 2020 at 07:36:22PM +0200, Peter Zijlstra wrote:
> >> > [ 9371.959858]  asm_call_on_stack+0x12/0x20
> >> > asm_call_on_stack at arch/x86/entry/entry_64.S:710
> >
> > This is one piece of call from the warning call traces that introduced
> > by the patch which leads me to revert the commit in the first place. It
> > may or may not be the real culprit, but just wanted to highlight it in
> > case.
> 
> Oh well. The warning is a storage check in the stack depot code,
> i.e. stack depot ran out of storage space.
> 
> Even if that commit causes stack traces to be larger that revert does
> not make any sense at all and handwaving about recursions does not help
> either. If that commit introduced a recursion then that would have worse
> effects than triggering this warning.
> 
> The difference between the interrupt stack switching introduced by this
> commit is that it generates another entry in the stack trace compared to
> the state before it, which obviously has an effect on the storage
> requirements in the stack depot.

Sorry, not meant to propose the reverting as a final solution to the
problem, but rather a data point. My problem is that I knew so little
about this kernel area, so I was to throw out something where I saw
something similiar while working in other areas over the years. Of
course, my "random" tips could be wrong.

The effect is quite bad for our CI because it will disable lockdep in
the middle of the tests which could miss regression bugs lockdep might
find later. Anyway, I am not motivate enough to measure how much "an
effect" is yet due to this patchset. I'll trim our .config and tests to
hopefully not running out of the storage this early.
