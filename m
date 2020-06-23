Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3CB92076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgFWQNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:13:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AEC061573;
        Tue, 23 Jun 2020 09:13:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jnlY2-0005Ko-Kg; Tue, 23 Jun 2020 18:13:22 +0200
Date:   Tue, 23 Jun 2020 18:13:21 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623152450.GM4817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:24:50PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 05:00:31PM +0200, Ahmed S. Darwish wrote:
> > On Tue, Jun 23, 2020 at 10:36:52AM +0200, Peter Zijlstra wrote:
> > ...
> > > -#define lockdep_assert_irqs_disabled()	do {				\
> > > -		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
> > > -			  current->hardirqs_enabled,			\
> > > -			  "IRQs not disabled as expected\n");		\
> > > -	} while (0)
> > > +#define lockdep_assert_irqs_enabled()					\
> > > +do {									\
> > > +	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> > > +} while (0)
> > >
> >
> > Can we add a small comment on top of lockdep_off(), stating that lockdep
> > IRQ tracking will still be kept after a lockdep_off call?
>
> That would only legitimize lockdep_off(). The only comment I want to put
> on that is: "if you use this, you're doing it wrong'.
>

Well, freshly merged code is using it. For example, KCSAN:

    => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
    => kernel/kcsan/report.c:

    void kcsan_report(...)
    {
	...
        /*
         * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
         * we do not turn off lockdep here; this could happen due to recursion
         * into lockdep via KCSAN if we detect a race in utilities used by
         * lockdep.
         */
        lockdep_off();
	...
    }

thanks,

--
Ahmed S. Darwish
Linutronix GmbH
