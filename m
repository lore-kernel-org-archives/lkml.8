Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C374C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD5E206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pb33OIwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbgDCQnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:43:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404111AbgDCQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h5xVyZDdTl/i+9iQgx6bdlJyd/kR2bw4PP7kj2Lt4LM=; b=Pb33OIwESbt+HU//6fOhOnv2DB
        kG5Y45x2S+d1ebwN3a3Iyulocb4sJ4w4JNbaX/VCsTnRXYrtXyq49jWHjSXDanYaBoPuPD1fp7l/r
        ZIHZ52asY9GR4E0Ck+GNUbFP4bKqMwxmeZM3T1eYcrqXg0Tn1bYM/r25nkdpPaI3imq6k9i+Ixc2S
        Ngend0+wUr3KtrHCqpxEWMWMFv9RcpVP1L/1mEA4msUBcijBYMCpfQaUSOXA9DPtt2bb7eR1fS5M3
        EwFrmOdJp4+A8qCs2tBh8ZZvZ9wxNV1A+0MVPzremit2iy03uiE7J3Q9AbCc39AkBYp/6pryFXLTh
        MvUw30Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPP4-0007Fj-Eq; Fri, 03 Apr 2020 16:42:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B30B03010BC;
        Fri,  3 Apr 2020 18:42:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3AE1284DE644; Fri,  3 Apr 2020 18:42:44 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:42:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200403164244.GZ20730@hirez.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403163007.6463-1-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:30:07AM -0700, Sean Christopherson wrote:
> Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
> is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
> module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
> into the guest, or don't intercept #AC in the first place.  With SLD
> enabled, this results in unexpected #AC faults in the guest, leading to
> crashes in the guest and other undesirable behavior.
> 
> Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Kenneth R. Crudup <kenny@panix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: Doug Covelli <dcovelli@vmware.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> A bit ugly, but on the plus side the code is largely contained to intel.c.
> I think forgoing the on_all_cpus() remote kill is safe? 

How would it be safe? You can't control where the module text will be
ran, or how quickly.
