Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE8920717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rjrwIKiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbgGVNoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGVNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B7C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EWtLJL7w8EdfjQzaisXGJJvbCuuFzVysmmdZePTzIok=; b=rjrwIKiPstA8yWJdW8Up2uspRV
        rwKIKh2XGEQ8tsJnoviP/DdIzp7ETM6Aw2W7bWNFN6+/19Ep962KY+oYk6N2RfW6iTsPQwng9C1ck
        jCbXc75SuPEoul7ukUFRZ2ITNrZ8Iqz3AwtGBDyc0tpbphhA3HM3bwMrLZCAG1dqsVqoMBVsk0ePX
        G4F7ljF1XvtFxlsulDDNM+rOmscanmsidDtI20CB9kGHWv1qRGWxYi+A5+xL+2rAAnlM0zRz1Httk
        dkomk/kaEge6PfFiDVjblvm+ObOQ8KVFSS8KEz9fx/AmLj6VLpzSMt4kj8V+aUqg+FpPnQ8x/MVaj
        fk7OHEHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyF2X-0003j3-A3; Wed, 22 Jul 2020 13:44:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4B7F3006D0;
        Wed, 22 Jul 2020 15:44:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 829A1233D6983; Wed, 22 Jul 2020 15:44:06 +0200 (CEST)
Date:   Wed, 22 Jul 2020 15:44:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fork: silence a false postive warning in __mmdrop
Message-ID: <20200722134406.GN10769@hirez.programming.kicks-ass.net>
References: <20200604150344.1796-1-cai@lca.pw>
 <20200722100637.GR119549@hirez.programming.kicks-ass.net>
 <20200722131900.GA4041@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722131900.GA4041@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:19:00AM -0400, Qian Cai wrote:
> On Wed, Jul 22, 2020 at 12:06:37PM +0200, peterz@infradead.org wrote:
> > On Thu, Jun 04, 2020 at 11:03:44AM -0400, Qian Cai wrote:
> > > The linux-next commit bf2c59fce407 ("sched/core: Fix illegal RCU from
> > > offline CPUs") delayed,
> > > 
> > > idle->active_mm = &init_mm;
> > > 
> > > into finish_cpu() instead of idle_task_exit() which results in a false
> > > positive warning that was originally designed in the commit 3eda69c92d47
> > > ("kernel/fork.c: detect early free of a live mm").
> > > 
> > >  WARNING: CPU: 127 PID: 72976 at kernel/fork.c:697
> > >  __mmdrop+0x230/0x2c0
> > >  do_exit+0x424/0xfa0
> > >  Call Trace:
> > >  do_exit+0x424/0xfa0
> > >  do_group_exit+0x64/0xd0
> > >  sys_exit_group+0x24/0x30
> > >  system_call_exception+0x108/0x1d0
> > >  system_call_common+0xf0/0x278
> > 
> > Please explain; because afaict this is a use-after-free.
> > 
> > The thing is __mmdrop() is going to actually free the mm, so then what
> > is finish_cpu()'s mmdrop() going to do?
> > 
> > ->active_mm() should have a refcount on the mm.
> 
> Well, the refcount issue you mentioned then happens all before bf2c59fce407 was
> introduced as well, but then it looks harmless because mmdrop() in finish_cpu()
> will do,
> 
> 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
> 		__mmdrop(mm);

That's not harmless, that's a use-after-free. Those can cause memory
corruption bugs and the like at best. Who knows what's at the location
of mm->mm_count after we've already freed it.

> where that atomic_dec_and_test() see the negative refcount and will not involve
> __mmdrop() again. It is not clear to me that once the CPU is offline if it
> needs to care about its idle thread mm_count at all. Even if this refcount
> issue is finally addressed, it could hit this warning in finish_cpu() without
> this patch.
> 
> On the other hand, if you look at the commit 3eda69c92d47, it is clearly that
> the assumption of,
> 
>    WARN_ON_ONCE(mm == current->active_mm);
> 
> is totally gone due to bf2c59fce407. Thus, the patch is to fix that discrepancy
> first and then I'll look at that the imbalance mmdrop()/mmgrab() elsewhere.

No, you're talking nonsense. We must not free @mm when
'current->active_mm == mm', never.
