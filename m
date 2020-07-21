Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221372077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgGUBhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGUBhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:37:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A97F2075B;
        Tue, 21 Jul 2020 01:37:53 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:37:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/24] Documentation: locking: Describe seqlock
 design and usage
Message-ID: <20200720213752.70319a1c@oasis.local.home>
In-Reply-To: <20200720213551.5ba9bc6d@oasis.local.home>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200720155530.1173732-1-a.darwish@linutronix.de>
        <20200720155530.1173732-2-a.darwish@linutronix.de>
        <20200720213551.5ba9bc6d@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 21:35:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 20 Jul 2020 17:55:07 +0200
> "Ahmed S. Darwish" <a.darwish@linutronix.de> wrote:
> > +Read path, three categories:
> > +
> > +1. Normal Sequence readers which never block a writer but they must
> > +   retry if a writer is in progress by detecting change in the sequence
> > +   number.  Writers do not wait for a sequence reader::
> > +
> > +	do {
> > +		seq = read_seqbegin(&foo_seqlock);
> > +
> > +		/* ... [[read-side critical section]] ... */
> > +
> > +	} while (read_seqretry(&foo_seqlock, seq));
> > +
> > +2. Locking readers which will wait if a writer or another locking reader
> > +   is in progress. A locking reader in progress will also block a writer
> > +   from entering its critical section. This read lock is
> > +   exclusive. Unlike rwlock_t, only one locking reader can acquire it::  
> 
> Nit, but I would mention that this acts similar to a normal spin_lock, and even disables preeption (in the non-RT case).

What I learned today: Ctrl-return on claws mail sends the email :-p

I need to disable that before I send another email before I'm done with it!


I haven't finished reading the rest.

-- Steve
