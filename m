Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BFCC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0195B20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3PB2oaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDII5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:57:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDII5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=42i9OocVN2b7bspQwd+XlTYCzdfsxyPwvlEay6KrGnY=; b=h3PB2oaBq7btbwcyAGOC2n57pv
        fONg9SxsLXz4z+7nL+cx8+Q2qKQPYG8qRY8xZpQvoZVvvmHqjxAVyZnaPs+OjjRIpllKy/X1TW+wi
        69D6fCC1OsHZC9cpSnA4agzPVJuuxnuVtFoHFZMQBOagBB51gbomAwUNtlfpyik4lJJ65kYm7sX5B
        bQ4cF4kVJN6kynBVw9z/yadsrT0s5syTnoQvEgEcOkp/7VuxaLhpf8ix9REcjnFejJv7r6Rv0za7v
        Xbg6j8veAVZwwvh7+6j0ddlMUu7zjACk1VRpsAB90QrgPp0a5OA29ns95YkbgInmEqsUxqERmrjvT
        1h4tdB6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMSzD-0006pQ-EN; Thu, 09 Apr 2020 08:56:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B77A3010C8;
        Thu,  9 Apr 2020 10:56:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 300BE2BAFC3E3; Thu,  9 Apr 2020 10:56:32 +0200 (CEST)
Date:   Thu, 9 Apr 2020 10:56:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200409085632.GB20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
 <20200408154602.GA24869@infradead.org>
 <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 06:15:48PM +0200, Paolo Bonzini wrote:
> On 08/04/20 17:46, Christoph Hellwig wrote:

> > Scanning all modules seems safer.  While we're at it - can be move the
> > kvm bits using VMX to be always in the core kernel and just forbid
> > modules from using those instructions entirely?
> 
> I suppose we could use PVOPS-style patching for the more
> performance-critical cases, but VMREAD/VMWRITE does not seem like a
> particularly bad thing to allow modules and VMLAUNCH/VMRESUME have very
> peculiar calling conventions around them.
> 
> However, I wouldn't mind it if VMCLEAR/VMPTRLD and the associated kdump
> cleanup code were moved to core kernel code.

Speaking with my virt ignorance hat on, how impossible is it to provide
generic/useful VMLAUNCH/VMRESUME wrappers?

Because a lot of what happens around VMEXIT/VMENTER is very much like
the userspace entry crud, as per that series from Thomas that fixes all
that. And surely we don't need various broken copies of that in all the
out-of-tree hypervisors.

Also, I suppose if you have this, we no longer need to excempt CR2.

