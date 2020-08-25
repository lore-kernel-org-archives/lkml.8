Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5BFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D3F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F0NY4N2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHYOP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:15:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rpL1dCRWpxTiOufY/e0NW96imqT+arMYCY2NNc5N7tI=; b=F0NY4N2GNGQonqtuLf8+pXPYAE
        bjuCTYw/ONtO2Qvnyf+jNRKZwQ3bR2dKT24TSlYfzlAUOQlpeZTLjCxfDafTvd5u82neTXWT31l7e
        Sfh77tx5cOK6GWZsia7FGvWV391oL/5CKXzWySJVgk5g03yg+SdW2xEBODaSd+QUZ6pe6PTXcH15v
        WxDw7Wivu+c1IWEcIdLMxzNh77Q3KCeg1hxNkjb95e5Ox9AFYiyTp/WQh3LTe3DKpEiOmDn4eruOk
        cdcurrCJRoNpoYAHAPTPVyeY+HDH4EXh3jd8w9bYmAUQluYksBOIP3viuLP1njhtrvVBw2QIICRM+
        7ZznDz6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAZjO-0003kh-IH; Tue, 25 Aug 2020 14:15:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 615BB30280E;
        Tue, 25 Aug 2020 16:15:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13B7120C19006; Tue, 25 Aug 2020 16:15:21 +0200 (CEST)
Date:   Tue, 25 Aug 2020 16:15:21 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200825141521.GA1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <20200825221555.a2d72c9754284feced6a8536@kernel.org>
 <20200825133005.GY1362448@hirez.programming.kicks-ass.net>
 <20200825225954.2202d28b449f2354d5c88070@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825225954.2202d28b449f2354d5c88070@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:59:54PM +0900, Masami Hiramatsu wrote:
> On Tue, 25 Aug 2020 15:30:05 +0200
> peterz@infradead.org wrote:
> 
> > On Tue, Aug 25, 2020 at 10:15:55PM +0900, Masami Hiramatsu wrote:
> > 
> > > > damn... one last problem is dangling instances.. so close.
> > > > We can apparently unregister a kretprobe while there's still active
> > > > kretprobe_instance's out referencing it.
> > > 
> > > Yeah, kretprobe already provided the per-instance data (as far as
> > > I know, only systemtap depends on it). We need to provide it for
> > > such users.
> > > But if we only have one lock, we can avoid checking NMI because
> > > we can check the recursion with trylock. It is needed only if the
> > > kretprobe uses per-instance data. Or we can just pass a dummy
> > > instance on the stack.
> > 
> > I think it is true in general, you can unregister a rp while tasks are
> > preempted.
> 
> Would you mean the kretprobe handler (or trampoline handler) will be
> preempted? All kprobes (including kretprobe) handler is running in
> non-preemptive state, so it shouldn't happen...

I was thinking about something like:


	for_each_process_thread(p, t) {
		if (!t->kretprobe_instances.first)
			continue;

	again:
		if (try_invoke_on_locked_down_task(t, unhook_rp_inst, tp))
			continue;

		smp_function_call(...);

		if (!done)
			goto again;
	}

So then for each task that has a kretprobe stack, we iterate the stack
and set ri->rp = NULL, remotely when the task isn't running, locally if
the task is running.

I just need to change the semantics of try_invoke_on_locked_down_task()
a bit -- they're a tad weird atm.

> > Anyway,. I think I have a solution, just need to talk to paulmck for a
> > bit.
> 
> Ah, you mentioned that the removing the kfree() from the trampline
> handler? I think we can make an rcu callback which will kfree() the
> given instances. (If it works in NMI)

Yes, calling kfree() from the trampoline seems dodgy at best. When
!ri->rp rcu_free() is a good option.
