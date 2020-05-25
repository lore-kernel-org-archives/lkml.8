Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03684C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4ED620723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbgEYL1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390170AbgEYL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:27:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0ECC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:27:02 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdBG0-0007Vu-P3; Mon, 25 May 2020 13:27:00 +0200
Date:   Mon, 25 May 2020 13:27:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/7] locking: Introduce local_lock()
Message-ID: <20200525112700.tev37vrovevfrxqz@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-2-bigeasy@linutronix.de>
 <20200525070139.GB329373@gmail.com>
 <20200525071214.GC329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525071214.GC329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 09:12:14 [+0200], Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > ( The other departure from spinlocks is that the 'spinlock_t' name, 
> >   without underscores, while making the API names such as spin_lock() 
> >   with an underscore, was a conscious didactic choice. Applying that 
> >   principle to local locks gives us the spinlock_t-equivalent name of 
> >   'locallock_t' - but the double 'l' reads a bit weirdly in this 
> >   context. So I think using 'local_lock_t' as the data structure is 
> >   probably the better approach. )
> 
> BTW., along this argument, I believe we should rename the local-lock 
> header file from <linux/locallock.h> to <linux/local_lock.h>.
> 
> The reason for the <linux/spinlock.h> naming is that the main data 
> structure is spinlock_t.
> 
> Having <linux/locallock.h> for 'struct local_lock' or 'local_lock_t' 
> would introduce an idiosyncratic namespace quirk for no good reason.

agreed.

> Thanks,
> 
> 	Ingo

Sebastian
