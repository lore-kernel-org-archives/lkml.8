Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C737C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38292206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI4o8Q6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDFSkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:40:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+eHYy1TRMZkiZZ4ozE6WbbjxeEz9f0kEwn1sBNWI5n0=; b=WI4o8Q6D773savdW1v4nxEUHL2
        mMGrCl5u2gVVs2RrfoOd6qfvSVzSjlPrS+GydmAy967DV+QChJOotsOBoIM+0VqXty5044Rl0O43T
        0DBJJGD2XFhvefSvQ/JJHA1UI0L5u6sLSGss1uo3t/F5TjY7JEh1WNtX2I33x5d03DWZpckkESO+2
        2v0nNLBz/CsYoToBz5wzIkpzP0u5P7p7ZcXg0Qews/oR5ozop1q2tG3VYGtQAARhMy9U6AsJPI9mH
        whxs1VaDt/MEY5f3tjzMUUmIDD6iaXCtwqzi82s4uT158VIaW/uWvhpIuZWI4tQwIBwv2Z1pco7cu
        UYas9rsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLWev-0004V8-Uw; Mon, 06 Apr 2020 18:39:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70C5A9834E2; Mon,  6 Apr 2020 20:39:42 +0200 (CEST)
Date:   Mon, 6 Apr 2020 20:39:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200406183942.GN2452@worktop.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
 <20200406153902.GA9939@infradead.org>
 <20200406160157.GS20730@hirez.programming.kicks-ass.net>
 <20200406171058.GA5352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406171058.GA5352@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:10:58AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 06, 2020 at 06:01:57PM +0200, Peter Zijlstra wrote:
> > Please feel free to use my pgprot_nx() and apply liberally on any
> > exported function.
> > 
> > But crucially, I don't think any of the still exported functions allows
> > getting memory in the text range, and if you want to run code outside of
> > the text range, things become _much_ harder. That said, modules
> > shouldn't be able to create executable code, full-stop (IMO).
> 
> This is what i've got for now:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api

Looks excellent:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
