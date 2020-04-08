Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55894C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C88B20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ly7jlU8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgDHIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:38:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ACkspuPIfoQ3/5/zaLoUtXyvTpTXAnBFfLWAYMZ/rzs=; b=Ly7jlU8l1rKqdWtymw+5P8Us5L
        zj0u5X2Sk/xu4B6bimPchBI9xQJzfL+rp6mT1HAivIcL6kb/bgwF+gaol4/0MhsD6bhwwXwZWfLv+
        MHff0X6MDVM7nsWpSujSjZ0YqY+srJPWBn7DBlpedVY+yyliB4WS4aB2mQ/rLVDi9gEFHMqsy5qOq
        C6bbz6a4sAhvAf0sUsVb1iMXpOKlfF65TVnLZZ1t9uCGPSw8oB9E+1B2eszB7/esrz6PbeENtWt5H
        DNCQARtypj9TUiug8vb+FI6Jsv819f8UWAttNcyK12wTCIqR+mhK2fNt1MX57cn+BBcDAa4hcc0sP
        dLsIFGGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM6DO-00067X-DJ; Wed, 08 Apr 2020 08:37:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1586F3025C3;
        Wed,  8 Apr 2020 10:37:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEC9B2BA879E0; Wed,  8 Apr 2020 10:37:38 +0200 (CEST)
Date:   Wed, 8 Apr 2020 10:37:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408083738.GO20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <04f4fc03-95cd-df2e-e93d-e9c4fa221ae4@citrix.com>
 <a263df2d-6dd7-83c1-baff-301625ef60a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a263df2d-6dd7-83c1-baff-301625ef60a2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:22:45AM +0200, Paolo Bonzini wrote:
> On 08/04/20 01:15, Andrew Cooper wrote:
> >> Anyhow, I do not think it is the only use-case which is not covered by your
> >> patches (even considering CRs/DRs alone). For example, there is no kernel
> >> function to turn on CR4.VMXE, which is required to run hypervisors on x86.
> > How about taking this opportunity to see if there is a way to improve on
> > the status quo for co-existing hypervisor modules?
> 
> Almost serious question: why?  I can understand VMware, but why can't at
> least VirtualBox use KVM on Linux?  I am not sure if they are still
> running device emulation in ring zero, but if so do you really want to
> do that these days?

Having had the 'joy' of looking at the virtual-puke^Wbox code recently,
nobody with half a hair of sense on their head will want to ever touch
that thing again.

It's a security nightmare, and that's the best part of it.
