Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA911C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE353206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lOG92mXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbgDCQM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:12:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390687AbgDCQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rqlld1Uubvd6ip+ZOUGD8JPJGcMPZk5ZrxuNgdULhhk=; b=lOG92mXzJaYPN8xxxVwpPbxV4X
        ssI5QC6+qXHMFppQqJQ5rNdyap2yVIGDdzH8+HqalLHo8sDxj/A3/BkQplP1+56I/A0hCObJMauWo
        F04q2qY6vZ1g7gtrYyW0bh8KIaShzneN1YCDkNcxoaAluISYM0j/fnndrZmJIomOI67GF/AOexgfi
        e+Ta2n9jR+vUHrjgL8fkjqG3OWYPem515ItQYsjC/gTOIF3uNXjmLQMSzkh9zio8TQ0aoEm46rpl6
        SUVJKY/mrkMPHHX4vPUVISFnyiaAxpqf9ChM12LHeWvLaEmigQxinu/E/hIl+vtDoUwmPikPoGEjk
        UIVSMv9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKOvR-0003Ff-Lu; Fri, 03 Apr 2020 16:12:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F417C30477A;
        Fri,  3 Apr 2020 18:12:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D01702B124BED; Fri,  3 Apr 2020 18:12:05 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:12:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403161205.GT20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
 <20200403152158.GR20730@hirez.programming.kicks-ass.net>
 <20200403160156.GA2701@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403160156.GA2701@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:01:56AM -0700, Sean Christopherson wrote:
> On Fri, Apr 03, 2020 at 05:21:58PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:

> > > I wonder if it would make sense then to limit the text scans to just
> > > out-of-tree modules (i.e., missing the intree modinfo flag)?
> > 
> > It would; didn't know there was one.
> 
> Rather than scanning modules at all, what about hooking native_write_cr4()
> to kill SLD if CR4.VMXE is toggled on and the caller didn't increment a
> "sld safe" counter?

And then you're hoping that the module uses that and not:

  asm volatile ("mov %0, cr4" :: "r" (val));

I think I feel safer with the scanning to be fair. Also with the intree
hint on, we can extend the scanning for out-of-tree modules for more
dodgy crap we really don't want modules to do, like for example the
above.
