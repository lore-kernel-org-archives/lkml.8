Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9EEC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F332063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 05:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRg5/WYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDHFSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 01:18:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 01:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=StKPm373OSdksMMVXI6SQKnBhmEVN9dQRT4B9G7vKnE=; b=RRg5/WYKllwAuh+d8Y2KqazRaP
        dbwf5MWSki1XVIYQND6PNzwAJUfuoS4rSC7RdvGsm4U77BchhcYhuDxM5qi4w79nS5wDLlYUP6tkR
        viC+9yQVXkCXj8gC3BPF/s679GCu1s4ybb8w/6oVPt037rJvAiCxRsOApKNYC+Eq4cZvZ7s8QLfmr
        RbIJkZGbTcxocv7HjOzn8xFRL44EbrkyldxouLPiLVQwQf4k2AlQSbUtkgUnmga+En8gdUm+Hh3Po
        EXm2sdA6CGEdb18HlXFtsj5ZUhYdcwQqSI8XUQJ1ZANZre9aaZXLvR09mkPMYT0LOhu1LqRjrrl7F
        HcdH+4EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM36m-0002OQ-WD; Wed, 08 Apr 2020 05:18:41 +0000
Date:   Tue, 7 Apr 2020 22:18:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408051840.GA8561@infradead.org>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <20200407212754.GU2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407212754.GU2452@worktop.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:27:54PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 02:22:11PM -0700, Nadav Amit wrote:
> > Anyhow, I do not think it is the only use-case which is not covered by your
> > patches (even considering CRs/DRs alone). For example, there is no kernel
> > function to turn on CR4.VMXE, which is required to run hypervisors on x86.
> 
> That needs an exported function; there is no way we'll allow random
> writes to CR4, there's too much dodgy stuff in there.

And this clearly shows while trying to cater to anyone doing hardware
virt out of tree is just a disaster and we need to stick to our
traditional line that out of tree modules don't matter, if you care
about your module bring it upstream.  Especially as we have a perfectly
fine upstream module for just about every variant of hardware
virtualization that can be extended for the needs of other hypervisors.
