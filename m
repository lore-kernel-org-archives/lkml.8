Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4446CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E922073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="je50tGed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbgDCOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:33:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDCOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ms4LVOzhF0vPDOhEHsaxnyIsKzU/f/4CTRFC4kv8zA8=; b=je50tGed4E17GOQUyIWT5kd1j6
        Ua/PVXId51dLBBxiVIp0jW7hZL+Y0ckijQLCYtaTZ3jNFgO9w23AMgiRdUzpmTwQFd8jU4FMB6yjl
        ef55cQFBo3XeFlsP/4a2j3ZpdKdsWdqSTDYwpSHLE1RewSabrUDhWNgkX6ApM39L2MKQxjhYH5+LR
        xApplv/IrRCUyrEoKLoF+icmr30f4cnvmyPvaLJq2I66LD/Ey+fn2Y8LxKRMCAtCW/a/14AVqJti5
        66cHcmz1tSZbT4E5wMSrvgAbUm9G0MDALCw6lwSUW2Tj9RbPHgj2Hrl413hapDVwmUR9NlwJjYM9t
        4iu3n7jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKNOG-0000li-0M; Fri, 03 Apr 2020 14:33:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD8593056DE;
        Fri,  3 Apr 2020 16:33:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5B5B2B12210A; Fri,  3 Apr 2020 16:33:44 +0200 (CEST)
Date:   Fri, 3 Apr 2020 16:33:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403143344.GP20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <9b95fe9e81c14370859e19f081cc23e4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b95fe9e81c14370859e19f081cc23e4@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:09:03AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 02 April 2020 16:24
> > 
> > I picked VMXOFF (which also appears in vmmon.ko) instead of VMXON
> > because that latter takes an argument is therefore more difficult to
> > decode.
> ...
> > +	while (text < text_end) {
> > +		kernel_insn_init(&insn, text, text_end - text);
> > +		insn_get_length(&insn);
> > +
> > +		if (WARN_ON_ONCE(!insn_complete(&insn)))
> > +			break;
> > +
> > +		if (insn.length == 3 &&
> > +		    (!memcmp(text, vmlaunch, sizeof(vmlaunch)) ||
> > +		     !memcmp(text, vmxoff, sizeof(vmxoff))))
> > +				goto bad_module;
> > +
> > +		text += insn.length;
> > +	}
> 
> How long is that going to take on a module with (say) 400k of text?

It's module load, why would you care? I suspect it's really fast, but
even if it wasn't I couldn't be arsed.
