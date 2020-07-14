Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A064C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716A922B3A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGNTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgGNTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:38:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCDC22AAE;
        Tue, 14 Jul 2020 19:38:07 +0000 (UTC)
Date:   Tue, 14 Jul 2020 15:38:06 -0400
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
Message-ID: <20200714153806.5649b2dc@oasis.local.home>
In-Reply-To: <20200714183143.GF5523@worktop.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134337.036717190@infradead.org>
        <20200710211426.298a3d94@oasis.local.home>
        <20200711050831.GY597537@hirez.programming.kicks-ass.net>
        <20200713162419.3a45f334@oasis.local.home>
        <20200714095117.GS10769@hirez.programming.kicks-ass.net>
        <20200714101636.5022a558@oasis.local.home>
        <20200714155417.GZ10769@hirez.programming.kicks-ass.net>
        <20200714120701.332f310d@oasis.local.home>
        <20200714183143.GF5523@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 20:31:43 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jul 14, 2020 at 12:07:01PM -0400, Steven Rostedt wrote:
> > Can we add a statement that says something like: "Because x86 now calls
> > static_call_init() before the setup of the memory allocator, we must
> > avoid using kmalloc() and friends for core kernel static calls." ?
> > 
> > This was the missing piece for me.  
> 
> It now reads like this.
> 
> ---
> Subject: static_call: Allow early init
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 4 Oct 17:21:10 CEST 2019
> 
> In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier, specifically before memory allocation works; copy
> some of the tricks from jump_label to enable this.
> 
> Primarily we overload key->next to store a sites pointer when there
> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier.

All the pieces lie in place. Thanks!

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
