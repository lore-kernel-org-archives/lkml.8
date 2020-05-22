Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18959C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A4C20870
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgEVWYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbgEVWYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:24:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331E32085B;
        Fri, 22 May 2020 22:24:12 +0000 (UTC)
Date:   Fri, 22 May 2020 18:24:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 09/25] Documentation: locking: Describe seqlock
 design and usage
Message-ID: <20200522182409.4016d83c@oasis.local.home>
In-Reply-To: <20200522180145.GR325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
        <20200519214547.352050-10-a.darwish@linutronix.de>
        <20200522180145.GR325280@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 20:01:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 19, 2020 at 11:45:31PM +0200, Ahmed S. Darwish wrote:
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index d35be7709403..2a4af746b1da 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -1,36 +1,15 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef __LINUX_SEQLOCK_H
> >  #define __LINUX_SEQLOCK_H
> > +
> >  /*
> > - * Reader/writer consistent mechanism without starving writers. This type of
> > - * lock for data where the reader wants a consistent set of information
> > - * and is willing to retry if the information changes. There are two types
> > - * of readers:
> > - * 1. Sequence readers which never block a writer but they may have to retry
> > - *    if a writer is in progress by detecting change in sequence number.
> > - *    Writers do not wait for a sequence reader.
> > - * 2. Locking readers which will wait if a writer or another locking reader
> > - *    is in progress. A locking reader in progress will also block a writer
> > - *    from going forward. Unlike the regular rwlock, the read lock here is
> > - *    exclusive so that only one locking reader can get it.
> > + * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
> > + * lockless readers (read-only retry loops), and no writer starvation.
> >   *
> > - * This is not as cache friendly as brlock. Also, this may not work well
> > - * for data that contains pointers, because any writer could
> > - * invalidate a pointer that a reader was following.
> > + * See Documentation/locking/seqlock.rst for full description.  
> 
> So I really really hate that... I _much_ prefer code comments to crappy
> documents.

Agreed. Comments are much less likely to bitrot than documents. The
farther away the documentation is from the code, the quicker it becomes
stale.

It's fine to add "See Documentation/..." but please don't *ever* remove
comments that's next to the actual code.

-- Steve
