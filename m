Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E802CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CBD20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Km2dikJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fou7JYZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGHKnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgGHKnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F26C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 03:43:52 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:43:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594205031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEK85sVO3ycL8JSzZJh27ifOb3CbGrfZXgz/86KqZqY=;
        b=Km2dikJLJ0F7mT6kUvVrBd+IZvL6FcWRGw/Pp/jl/PwVvb2UhkIWv0SLEDjNkVVvE1/Tbn
        xDi7e5sj637Kjhekrr7Rdc55T5gqViHbTpsFYDioiwJjJNeoY5XRmdj1hiTENNoainHH5y
        jJj+v/PM10sE0DSStRY8MKk4Uogp8pnCpWsGIC9NVsj5Iymu0KrDE/bIdfyx8S12EC6nWh
        gt/kpoXLuQK9zY4bjRcZqMsiMNdf8hjCpK17R31GZ0CrTwGYi+H15UecsnNSWGlmytTbDy
        WNxPpvCX1wGTVGsjLktJhDOblX3riWLjfWtPAsNn3PG4mKM0PScC5t9/hjf8xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594205031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEK85sVO3ycL8JSzZJh27ifOb3CbGrfZXgz/86KqZqY=;
        b=fou7JYZt3+pJkGYalXVmhnXpo3VVX8qNT09pwoKP8q8A8KYUKb9waw8qOlS5vIYmtBE0y7
        x+9Q3IKr/Bg9s6Ag==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708104349.GA20372@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708091201.GP117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091201.GP117543@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:12:01AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 04:37:26PM +0200, Peter Zijlstra wrote:
> > + * Use the ``_irqsave`` and ``_bh`` variants instead if the read side
> > + * ``_bh`` variant of write_seqlock(). Use only if the read side section
> > + * ``_irq`` variant of write_sequnlock(). The write side section of
> > + * ``_irqsave`` variant of write_seqlock(). Use if the read section of
> > + * ``_irqrestore`` variant of write_sequnlock(). The write section of
> > + * ``_bh`` variant of read_seqlock_excl(). Use this variant if the
> > + * ``_bh`` variant of read_sequnlock_excl(). The closed section must've
> > + * ``_irq`` variant of read_seqlock_excl(). Use this only if the
> > + * ``_irq`` variant of read_sequnlock_excl(). The closed section must've
> > + * ``_irqsave`` variant of read_seqlock_excl(). Use this only if the
> > + * ``_irqrestore`` variant of read_sequnlock_excl(). The closed section
> > + * This is the ``_irqsave`` variant of read_seqbegin_or_lock(). Use if
> > + * This is the ``_irqrestore`` variant of done_seqretry(). The read
>
> Can we also get rid of that '' nonsense, the gods of ASCII gifted us "
> for this.

Hehe, why not. I welcome back our ASCII overlords.
