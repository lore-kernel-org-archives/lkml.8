Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5AC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570E320771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGMUY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgGMUYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:24:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB7D20720;
        Mon, 13 Jul 2020 20:24:22 +0000 (UTC)
Date:   Mon, 13 Jul 2020 16:24:19 -0400
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
Message-ID: <20200713162419.3a45f334@oasis.local.home>
In-Reply-To: <20200711050831.GY597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134337.036717190@infradead.org>
        <20200710211426.298a3d94@oasis.local.home>
        <20200711050831.GY597537@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 07:08:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jul 10, 2020 at 09:14:26PM -0400, Steven Rostedt wrote:
> > On Fri, 10 Jul 2020 15:38:46 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > In order to use static_call() to wire up x86_pmu, we need to
> > > initialize earlier; copy some of the tricks from jump_label to enable
> > > this.
> > > 
> > > Primarily we overload key->next to store a sites pointer when there
> > > are no modules, this avoids having to use kmalloc() to initialize the
> > > sites and allows us to run much earlier.
> > >   
> > 
> > I'm confused. What was the need to have key->next store site pointers
> > in order to move it up earlier?  
> 
> The critical part was to not need an allocation.

Why is an allocation needed? What's different about calling it early
that we need an allocation or this trick?

The two paragraphs above seem totally disconnected.

"In order to use static_call() to wire up x86_pmu, we need to
initialize earlier; copy some of the tricks from jump_label to enable
this."

What tricks were copied?

"Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier."

Why is kmalloc() (or this trick) needed to initialize the sites?

-- Steve
