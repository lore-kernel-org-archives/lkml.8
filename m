Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C005206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpVGUku4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgG2JL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgG2JL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:11:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA8C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J0SIyyCqtngJmxWOxvkn9MOwqoIdVm/BuYE3QogVzc8=; b=hpVGUku45zWWGcg3Prx2nBUfqb
        wC7X8NqIK6c6gnNIbhOYj17a2dqHkheORFnbppCmKyIBj/YKeSpuQyiisJqs50YqU3dAyGOIems4V
        LHIXzMKWl6aFtCjwT1NrwYz2JAmdz/FS2XpPJ9NKiP6AYrQ0T8NUz3aPFAuadCNZrl8sQJeEO7yhY
        NfBCwK4vvGWkub3aVF14dJdSw2TasQjmhM1EshBuXO9ZWJ9ca87kAYesGvw6kMeMFjDCJpWLuJ0ou
        gI+D78lyyCVpDihtztlVMkpTsBqbMuluBhHYDHfhaxQ9ZuYYFF6G7+MVd3xjGvcRthS7+WBZEnMcz
        B8FIoJoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0i7u-0003PP-J3; Wed, 29 Jul 2020 09:11:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3265F300238;
        Wed, 29 Jul 2020 11:11:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D9B22B804951; Wed, 29 Jul 2020 11:11:54 +0200 (CEST)
Date:   Wed, 29 Jul 2020 11:11:54 +0200
From:   peterz@infradead.org
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH 2/6] arch: x86: Wrap TIF_IA32 checks
Message-ID: <20200729091154.GB119549@hirez.programming.kicks-ass.net>
References: <20200728202229.1195682-1-krisman@collabora.com>
 <20200728202229.1195682-3-krisman@collabora.com>
 <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV_HJCrDLCKLrqNbLiOsoEcC9M7zn-v_hcVMvDgnWW8yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:43:27PM -0700, Andy Lutomirski wrote:
> On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi

> > diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> > index dc43cc124e09..27d1cc1f3d05 100644
> > --- a/arch/x86/events/intel/ds.c
> > +++ b/arch/x86/events/intel/ds.c
> > @@ -1261,7 +1261,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
> >                 old_to = to;
> >
> >  #ifdef CONFIG_X86_64
> > -               is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
> > +               is_64bit = kernel_ip(to) || !TASK_IA32(current);
> 
> PeterZ, does PEBS not give us a CPL?  Is it really just IP?
> 
> Anyway, this should probably be:
> 
> is_64bit = kernel_ip(to) || user_64bit_mode(regs) || !user_mode(regs);

Correct, PEBS doesn't have the segment registers and we get to guess :/
Look at the various pebs_record_* structures in
arch/x86/events/intel/ds.c.

That said, in fixup_ip() we're guaranteed to be in the same process, so
unless the task does really funny things like switch mode between
triggering the assist and getting the PMI, we ought to be able to trust
regs.
