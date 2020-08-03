Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5038C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A94F2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsAJtSHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgHCP7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:59:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9862C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E4aLVP8KgP1USQagfpf75QTFDzBITp4dyRHsxxXJWp0=; b=JsAJtSHN8xdq/UI7RznvqcP7j4
        UNNCU0dnIqaNkkmV85E/RvpWVtpmeMBu9tYkV+1el61/tsj1/8BbKSLiLP9hIUy4d65ek/b/Mzncv
        pq192108Wzeo12UayBi8/4BILUss+w2O0jpk+f/Ch8e763cKkrvEcuNr8HQ8227H6HrKx5iegeQM/
        /mfqBSmKxusNu/l3VUzvMAtNy3euITeyQEpErOsmIsrCXwti0S5TqWmrvYZCjN9YHxl6daeEIOsXL
        SkfcjOpJ83b/TDRPvII1PuXZji/BBGAt/Lvm1Z/BRQefjhwVOEJX77zF+Yo1hY5Yb7YMp003hIEpe
        twHByhJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2cs4-0000JP-8L; Mon, 03 Aug 2020 15:59:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A82A8304E03;
        Mon,  3 Aug 2020 17:59:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8972E2BEFF772; Mon,  3 Aug 2020 17:59:25 +0200 (CEST)
Date:   Mon, 3 Aug 2020 17:59:25 +0200
From:   peterz@infradead.org
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, mbenes@suse.de,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [RFC][PATCH] objtool,x86_64,paravirt: Add pv_ops[] support
Message-ID: <20200803155925.GF2674@hirez.programming.kicks-ass.net>
References: <20200803143231.GE2674@hirez.programming.kicks-ass.net>
 <CALCETrXhgmkRNaZq9QFWjVVYiX+t=ML_e-oDw2PPEFxQdoA+6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXhgmkRNaZq9QFWjVVYiX+t=ML_e-oDw2PPEFxQdoA+6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 08:15:02AM -0700, Andy Lutomirski wrote:
> On Mon, Aug 3, 2020 at 7:33 AM <peterz@infradead.org> wrote:
> >
> >
> > Thomas wanted paramuck vs noinstr, here goes. Very rough, very nasty,
> > mostly works.
> >
> > It requires call sites are the normal indirect call, and not mangled
> > retpoison (slow_down_io() had those), it also requires pv_ops[]
> > assignments are single instructions and not laundered through some
> > pointless intermediate helper (hyperv).
> >
> > It doesn't warn when you get any of that wrong.
> >
> > But if you have it all lined up right, it will warn about noinstr
> > violations due to paramuck:
> 
> I certainly agree that pv_ops is mucky, but could you expound on
> precisely what this patch actually does?  On a very quick
> read-through, I'm guessing you're complaining about any call to pv_ops
> in a noinstr section?  But maybe this is only calls to pv_ops that
> aren't themselves noinstr?

Yeah, it makes sure that any pv_op called from noinstr are to a noinstr
function.

The example here:

../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x15: call pv_ops[48] from noinstr
../../defconfig-build/vmlinux.o: warning: objtool: pv_op[48]: xen_read_cr2
../../defconfig-build/vmlinux.o: warning: objtool: exc_double_fault()+0x15: call to {dynamic}() leaves .noinstr.text section

complains about exc_double_fault(), a noinstr function, calling to
xen_read_cr2(), a regular function.

Basically, for every pv_ops[] entry, it compiles a list of assigned
functions, and when there's a noinstr call, it makes sure all functions
assigned to that pv_op are noinstr.
