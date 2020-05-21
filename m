Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E974C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85442072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590068362;
	bh=wuhCxg3j7TpZopIH2SvKuor1c9QvsKng3GvVNMy2g7Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=O4nV38CPPhu68ZSq5xhsFYlq+ryUx12u4pOsmyIGS1YIFWwR6yhjjiGzDvbfDKDVy
	 3zPaUyB72s0NzXdPX6gUy6Q39yyyL6ZaR5bm6IOTCvNXeYgJ1tGPICndA/+Z7AE/er
	 0fSt0GAZEYdGiKG0MMFUDy8R52s0a8ThjM73iMfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgEUNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgEUNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:39:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21C120721;
        Thu, 21 May 2020 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590068360;
        bh=wuhCxg3j7TpZopIH2SvKuor1c9QvsKng3GvVNMy2g7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sqK7L1MEapC5P8zj33e58I1wv3QVL2V6bwiRKNiu9a5hUQF4/VbiiYrAI8H+D95A+
         sDhOquAcvcv/+QBnJYWTEmTB9KocrA+FwwgZGOipb0dWEnRC9snwP/Scl5iLJalb5D
         qgiifr8eOdCHbVqV0XOT95LQX9OPv6qRV83xoynU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 962CF3520CB7; Thu, 21 May 2020 06:39:20 -0700 (PDT)
Date:   Thu, 21 May 2020 06:39:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200521133920.GY2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <874ksb7hbg.fsf@nanos.tec.linutronix.de>
 <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
 <20200520180546.GQ2869@paulmck-ThinkPad-P72>
 <87o8qiv135.fsf@nanos.tec.linutronix.de>
 <20200520221531.GW2869@paulmck-ThinkPad-P72>
 <20200520232550.GA20812@paulmck-ThinkPad-P72>
 <87zha1u1tc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zha1u1tc.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:31:11AM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, May 20, 2020 at 03:15:31PM -0700, Paul E. McKenney wrote:
> > Same patch, but with updated commit log based on IRC discussion
> > with Andy.
> 
> Fun. I came up with the same thing before going to bed. Just that I
> named the function differently: rcu_irq_enter_check_tick()

I am good with that name.

> >  #if defined(CONFIG_TINY_RCU)
> >  
> > +static inline void tickle_nohz_for_rcu(void)
> > +{
> > +}
> > +
> >  static inline void rcu_nmi_enter(void)
> >  {
> >  }
> > @@ -23,6 +27,7 @@ static inline void rcu_nmi_exit(void)
> >  }
> >  
> >  #else
> > +extern void tickle_nohz_for_rcu(void);
> 
> And I made this a NOP for for !NOHZ_FULL systems and avoided the call if
> context tracking is not enabled at boot.
> 
> void __rcu_irq_enter_check_tick(void);
> 
> static inline void rcu_irq_enter_check_tick(void)
> {
> 	if (context_tracking_enabled())
>         	__rcu_irq_enter_check_tick();
> }

That certainly is a better approach!

So let's go with your version.  But could you please post it, just in
case reviewing an alternative version causes me to spot something?

							Thanx, Paul
