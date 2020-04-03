Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6CDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A490206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OB9f/mtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbgDCQmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:42:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgDCQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oWXG5QSbpYfvkFdjY4l1811DSoPH7nI2HTV6dvF6oBU=; b=OB9f/mtNJpcSeSG9Y1OSONyoRb
        mvrjE2qVstB/4X/XS6tNMkYuF3KRM2GYdfqPEec0+TfM1pnTyNmbZMPbji8SjFrb2RnvVhb3/0Npm
        uG5VruxgD0I1hRH4wDNxFzrTZcsSPQaePfkvISS5seSpy3RXCVOL6vprS4KfMGSEI0y1RBBPdUKPh
        0B3u3HJqFlZVqq35EHNfaMFl+Bw5LB0I3609d24YzfEZP5KiYV+IXO0FFPqANFCWfOWpyWJ3Ovc5v
        HdFrleiKC0Xg0gP2xQ7PGdxatAUD3B3N16VVDcCD3UrllIGGDZgT763y1BNgRPkSyRHZO+wZLGlRn
        k/Iobs2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPOH-0003Jq-K7; Fri, 03 Apr 2020 16:41:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DF873010BC;
        Fri,  3 Apr 2020 18:41:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 225DA2B12078B; Fri,  3 Apr 2020 18:41:56 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:41:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403164156.GY20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200403163605.GC2701@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403163605.GC2701@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:36:05AM -0700, Sean Christopherson wrote:
> On Thu, Apr 02, 2020 at 02:32:59PM +0200, Thomas Gleixner wrote:
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -24,6 +24,7 @@
> >  #include <asm/pgtable.h>
> >  #include <asm/setup.h>
> >  #include <asm/unwind.h>
> > +#include <asm/cpu.h>
> >  
> >  #if 0
> >  #define DEBUGP(fmt, ...)				\
> > @@ -253,6 +254,11 @@ int module_finalize(const Elf_Ehdr *hdr,
> >  					    tseg, tseg + text->sh_size);
> >  	}
> >  
> > +	if (text && !me->sld_safe) {
> 
> As also reported by the test bot, sld_safe only exist if CPU_SUP_INTEL=y.
> 
> This can also be conditioned on boot_cpu_has(X86_FEATURE_VMX), or the
> static variant.  If CPU_SUP_INTEL=y, X86_FEATURE_VMX will be set if and
> only if VMX is fully enabled, i.e. supported by the CPU and enabled in
> MSR_IA32_FEATURE_CONTROl.
> 
> > +		void *tseg = (void *)text->sh_addr;
> > +		split_lock_validate_module_text(me, tseg, tseg + text->sh_size);
> > +	}

Ideally we push it all into arch code, but load_info isn't exposed to
arch module code :/.
