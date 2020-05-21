Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F87C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25A4207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590087853;
	bh=3nH8c5Za0jZJgADrQX18D09s3xO5mCSojo8RLZsF690=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qQMiq1LeZCMpziD2O0EIkoJsC1SmqbEwDo5eoeDHPYfEbGtMgauBoTcrv+lrPSzhP
	 6HK8fczi40Lv9Bx6wbVwuYL9mfHIfL6GsNPuE99yyaxpckbOY95F8LnM+ckiug8RWg
	 WC/as/Q8V1BBUBPbM05JmG6njruaQIWlJbIh4kwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgEUTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgEUTEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:04:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2665F20759;
        Thu, 21 May 2020 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590087852;
        bh=3nH8c5Za0jZJgADrQX18D09s3xO5mCSojo8RLZsF690=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=er0d5pOduRTKTocgRdTx+MJ8U+E2NOGs0e/J0P+Hezo2Q2QGQtQvSkJXVBWEEN8qS
         mg3bEBbZY93XnvGMk51xRgOsNL5sAfA4c8uwF4Xkkt7geoA//yPn3y6xl/HBwfiCWz
         Elwsgcm07bGOaKXued/C02qmqECS8MsBq0eRxkq0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E67573522FEB; Thu, 21 May 2020 12:04:10 -0700 (PDT)
Date:   Thu, 21 May 2020 12:04:10 -0700
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
Message-ID: <20200521190410.GB2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
 <20200520180546.GQ2869@paulmck-ThinkPad-P72>
 <87o8qiv135.fsf@nanos.tec.linutronix.de>
 <20200520221531.GW2869@paulmck-ThinkPad-P72>
 <20200520232550.GA20812@paulmck-ThinkPad-P72>
 <87zha1u1tc.fsf@nanos.tec.linutronix.de>
 <20200521133920.GY2869@paulmck-ThinkPad-P72>
 <87mu61t9ko.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu61t9ko.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 08:41:11PM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Thu, May 21, 2020 at 10:31:11AM +0200, Thomas Gleixner wrote:
> >> And I made this a NOP for for !NOHZ_FULL systems and avoided the call if
> >> context tracking is not enabled at boot.
> >> 
> >> void __rcu_irq_enter_check_tick(void);
> >> 
> >> static inline void rcu_irq_enter_check_tick(void)
> >> {
> >> 	if (context_tracking_enabled())
> >>         	__rcu_irq_enter_check_tick();
> >> }
> >
> > That certainly is a better approach!
> >
> > So let's go with your version.  But could you please post it, just in
> > case reviewing an alternative version causes me to spot something?
> 
> I'm just testing the complete rework of this series and will post it if
> it survives smoke testing.

Fair enough!

							Thanx, Paul
