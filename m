Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB1C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A38D2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IsJnbR37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgA0IEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:04:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56192 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sZi2zm/JG5duSVHmWzKHgCFXi+/oFyOvHLu50859iFY=; b=IsJnbR37rrQBmfGapoKQzAs8B
        lP8fZMtd+MpCUXtcjfgJ4WsqTrU8aPK190wIBC+PjaA0RUdmozBdJaB+gtKyneZVYJEUeaJS5I5oJ
        2la0fN9AtW/MYO8DTP+ZScgFCeEflGf3yYV+fM0KPEX7oRtWrkOBnK0Br7ID5RiJtAZ/6IsSFXorv
        BzIstbZUTvymqYxbvD6yp5xqs5Xk84Z9yvKe+XW8qVlIXZQff5VzwmqZw1CHyDNKDHX6J6BZDmKxi
        m/ZAtGDsCEcaRqwu4p7HBWIX56ywDtwQEoR+vD1gzsLI8BYCOD44ywF7KuAViVkoFlRuDguW/lvom
        7786r97fA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivzNc-0004Qx-Or; Mon, 27 Jan 2020 08:04:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FF3A300F4B;
        Mon, 27 Jan 2020 09:02:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41862203CF5D4; Mon, 27 Jan 2020 09:04:19 +0100 (CET)
Date:   Mon, 27 Jan 2020 09:04:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200127080419.GG14914@hirez.programming.kicks-ass.net>
References: <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan>
 <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 01:50:03PM -0800, Luck, Tony wrote:
> On Sat, Jan 25, 2020 at 04:25:25PM -0500, Arvind Sankar wrote:
> > On Fri, Jan 24, 2020 at 06:47:27PM -0800, Luck, Tony wrote:
> > > I did find something with a new test. Applications that hit a
> > > split lock warn as expected. But if they sleep before they hit
> > > a new split lock, we get another warning. This is may be because
> > > I messed up when fixing a PeterZ typo in the untested patch.
> > > But I think there may have been bigger problems.
> > > 
> > > Context switch in V14 code did: 
> > > 
> > >        if (tifp & _TIF_SLD)
> > >                switch_to_sld(prev_p);
> > > 
> > > void switch_to_sld(struct task_struct *prev)
> > > {
> > >        __sld_msr_set(true);
> > >        clear_tsk_thread_flag(prev, TIF_SLD);
> > > }
> > > 
> > > Which re-enables split lock checking for the next process to run. But
> > > mysteriously clears the TIF_SLD bit on the previous task.
> > 
> > Did Peter mean to disable it only for the current timeslice and
> > re-enable it for the next time its scheduled?
> 
> He's seen and commented on this thread since I made this comment. So

Yeah, I sorta don't care either way :-)

> I'll assume not.  Things get really noisy on the console (even with
> the rate limit) if split lock detection is re-enabled after a context
> switch (my new test highlighted this!)

Have you found any actual bad software ? The only way I could trigger
was by explicitly writing a program to tickle it.
