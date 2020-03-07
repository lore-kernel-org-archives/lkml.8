Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D018C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCC22073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583552925;
	bh=dsF84Sqj98Y5uyCZp4EE6mHCp+OeA7YI7cckcIGR2SU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j5iWkMQIftiKI1u2P+5eJGCb2lW4jYKExK2IAPROsFGYuyqF66PFfbc2D3Dm1OIQb
	 9HXyQfH1bw1VDu1qdI+Olm4olbeeOX20Y9PMAmCKONjFpIWTSu/6g0GKam+uLxhkYO
	 wZ15MSrtQvm36rQv3YxITWOSJ2xJ12m9bsUAFkQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCGDso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCGDsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:48:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3C32072D;
        Sat,  7 Mar 2020 03:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583552923;
        bh=dsF84Sqj98Y5uyCZp4EE6mHCp+OeA7YI7cckcIGR2SU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YklI/t6Xvzh4qZAL8iY7bD16kQU2cu1p/qf2jF8TuLuQLZbQNM+Prmghd8eJPwOrX
         AHM+cFvWyPgnf5q/GaB/kFQAQSv4Vg6gJFi0oKWE1rrMqCLu9B/KCAQRXiV6wG0DHI
         mPUSw7uPiC3m0rLWGoTguiHljzqAbDdC30Y8+sOM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF5E33522891; Fri,  6 Mar 2020 19:48:42 -0800 (PST)
Date:   Fri, 6 Mar 2020 19:48:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Subject: Re: [patch 2/2] x86/kvm: Sanitize kvm_async_pf_task_wait()
Message-ID: <20200307034842.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200306234204.847674001@linutronix.de>
 <20200307000259.448059232@linutronix.de>
 <20200307002210.GJ2935@paulmck-ThinkPad-P72>
 <874kv1asf2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kv1asf2.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 02:02:25AM +0100, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> In #2c RCU is eventually not watching, but as that state cannot schedule
> >> anyway there is no point to worry about it so it has to invoke
> >> rcu_irq_enter() before running that code. This can be optimized, but this
> >> will be done as an extra step in course of the entry code consolidation
> >> work.
> >
> > In other words, any needed rcu_irq_enter() and rcu_irq_exit() are added
> > in one of the entry-code consolidation patches, and patch below depends
> > on that patch, correct?
> 
> No. The patch itself is already correct when applied to mainline. It has
> no dependencies.
> 
> It invokes rcu_irq_enter()/exit() for the case (#2c) where it is
> relevant. All other case are already RCU safe today.
> 
> The fact that the invocation is misplaced is a different story and yes,
> that is part of the entry code cleanup along with some optimization
> which are possible once the entry voodoo is out of ASM and adjustable
> for a particular entry point in C.

The weekend clearly did not come a moment too soon for me, did it?  :-/

							Thanx, Paul
