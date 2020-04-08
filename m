Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23776C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C02074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c9Blg/NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgDHIqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:46:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgDHIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ERtUtaPypgnb+NtH656JmA67c7oy6LtzFhZvEl2iRIo=; b=c9Blg/NLRKYBVKyS1BhH0EquxA
        FhT/oPKkfekeF3BKL2FB897OjmSUwfAkbUwqI9MrIyTGPxPn0VgI+sa1+GTAw9mhNnkfJQh3bbgLA
        +58ZX5H4ykLrh/1dYrvbINIkl2lJGSK6OdVaUtekMsDPyJvVPJq8G/HhNrEPGYoCDadXprcrZDXZm
        U/mmgbZhj6Y+wHoz0zDGRQzji36KeCLqmhcs2OccuhtbPWYER3tzpX1vP8dhuMp7jp13Oyt1u7iAu
        hWoeG3pm+6PDLcPAoxrFTm+Rn7sToPUY4AfnsdJ4EA3hjXKgy2HYuKt1N5/ueji8mG4K+jS7qm3jq
        APT3GBSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM6LP-0006Ff-TL; Wed, 08 Apr 2020 08:46:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EF53304DB2;
        Wed,  8 Apr 2020 10:45:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B9612BB00AA0; Wed,  8 Apr 2020 10:45:58 +0200 (CEST)
Date:   Wed, 8 Apr 2020 10:45:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
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
Message-ID: <20200408084558.GP20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <20200407212754.GU2452@worktop.programming.kicks-ass.net>
 <e390a895-cc09-0e9b-a05d-0c9b7bc6bfbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e390a895-cc09-0e9b-a05d-0c9b7bc6bfbd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:12:14AM +0200, Paolo Bonzini wrote:
> On 07/04/20 23:27, Peter Zijlstra wrote:
> > On Tue, Apr 07, 2020 at 02:22:11PM -0700, Nadav Amit wrote:
> >> Anyhow, I do not think it is the only use-case which is not covered by your
> >> patches (even considering CRs/DRs alone). For example, there is no kernel
> >> function to turn on CR4.VMXE, which is required to run hypervisors on x86.
> > That needs an exported function; there is no way we'll allow random
> > writes to CR4, there's too much dodgy stuff in there.
> 
> native_write_cr4 and pv_ops (through which you can do write_cr4) are
> both exported, and so is cpu_tlbstate which is used by __cr4_set_bits
> and friends.  Am I missing something glaringly obvious?

cpu_tlbstate is going away, but yes, native_write_cr4() is the right
interface to use, or rather the cr4_{set,clear,toggle}_bits() things
are.

That gives us control over which CR4 bits are available, and, a possible
means of arbitrating that VMX bit.
