Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C1522507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGNOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgGNOQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:16:40 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC43022447;
        Tue, 14 Jul 2020 14:16:37 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:16:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200714101636.5022a558@oasis.local.home>
In-Reply-To: <20200714095117.GS10769@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134337.036717190@infradead.org>
        <20200710211426.298a3d94@oasis.local.home>
        <20200711050831.GY597537@hirez.programming.kicks-ass.net>
        <20200713162419.3a45f334@oasis.local.home>
        <20200714095117.GS10769@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 11:51:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 13, 2020 at 04:24:19PM -0400, Steven Rostedt wrote:
> > On Sat, 11 Jul 2020 07:08:31 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Fri, Jul 10, 2020 at 09:14:26PM -0400, Steven Rostedt wrote:  
> > > > On Fri, 10 Jul 2020 15:38:46 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > >     
> > > > > In order to use static_call() to wire up x86_pmu, we need to
> > > > > initialize earlier; copy some of the tricks from jump_label to enable
> > > > > this.
> > > > > 
> > > > > Primarily we overload key->next to store a sites pointer when there
> > > > > are no modules, this avoids having to use kmalloc() to initialize the
> > > > > sites and allows us to run much earlier.
> > > > >     
> > > > 
> > > > I'm confused. What was the need to have key->next store site pointers
> > > > in order to move it up earlier?    
> > > 
> > > The critical part was to not need an allocation.  
> > 
> > Why is an allocation needed? What's different about calling it early
> > that we need an allocation or this trick?
> > 
> > The two paragraphs above seem totally disconnected.
> > 
> > "In order to use static_call() to wire up x86_pmu, we need to
> > initialize earlier; copy some of the tricks from jump_label to enable
> > this."
> > 
> > What tricks were copied?
> > 
> > "Primarily we overload key->next to store a sites pointer when there  
> 
> ^^ this trick...
> 
> +	union {
> +		/* bit 0: 0 = mods, 1 = sites */
> +		unsigned long type;
> +		struct static_call_mod *mods;
> +		struct static_call_site *sites;
> +	};
> 
> If that isn't a trick, I don't know ;-)

Ah, that makes more sense. The way it was worded didn't quite put 2 and
2 together like that.

> 
> > are no modules, this avoids having to use kmalloc() to initialize the
> > sites and allows us to run much earlier."
> > 
> > Why is kmalloc() (or this trick) needed to initialize the sites?  
> 
> That's just how the code was; it treated vmlinux as the NULL module, and
> as such needed a static_call_mod allocated to host the static_call_sites
> pointer.
> 
> That is, the static_call_key has a single linked list pointer to
> static_call_mod, and every module has an entry on that list with a
> pointer to their sites. Very simple and straight forward.
> 
> Except it requires an allocation to set up, which is a pain is you want
> it initialized very early.

OK, I'm still missing something, but having a hard time explaining
exactly what that is. ;-)

I guess that is, why did moving the initialization early require an
allocation where initializing it later did not? What allocation are we
avoiding?

I'm not seeing why this trick is needed when we moved the init early as
compared to doing the same thing later on.

Is it this?

> @@ -192,16 +222,35 @@ static int __static_call_init(struct mod
>                 if (key != prev_key) {
>                         prev_key = key;
>  
> +                       if (!mod) {
> +                               key->sites = site;
> +                               key->type |= 1;
> +                               goto do_transform;
> +                       }
> +

We want to avoid calling kzalloc() early?

If so, this should have a comment here stating so and why.

>                         site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
>                         if (!site_mod)
>                                 return -ENOMEM;

-- Steve
