Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A279EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7769020776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcSxKRV9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xo5jN+ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgH1IYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:24:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1IYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:24:00 -0400
Date:   Fri, 28 Aug 2020 10:24:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598603038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEiZumMR91+ugTaWQjQ9DrHw93Cp34f5FFmDZ6hxyG4=;
        b=rcSxKRV9iz2F8Y5zp0USjZ3VF/c7UG2td+HZgDG1akGjyNyD7hFKmdS/77eZnXzUfxiiN5
        0fTrTMHUAyBCjvsLFff7Rz1x7uMOlulJoQCdWykXR1VbrifW9eC1GRXRzWm5JsgGOm+HNk
        /lXufW8PghFth2uCW9UCBgMasazoQsZxkrtp3nkg/Dg87hdQMJHhswOUAdqzJ+3pn0W9sc
        tyW7LfEPNKm2o37N8N4O/q0cXd5JfXzNnUmJyZA4osAIFbzYTe+1NwT3tHYcjAtLNy4Fzs
        TuySVs4D9UkfJSjhfoGhbCtS7u8BcU09d20Erq8DhwsU9uO3NOzNRXGAp0M1Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598603038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEiZumMR91+ugTaWQjQ9DrHw93Cp34f5FFmDZ6hxyG4=;
        b=Xo5jN+ee8SDiOMwfVBguIWdquTaYib8iyWO4QIDDH2AK0KCMiTXXZJTaqa+kOiK/fzNt8b
        t/DcLoW98sns0kAw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] seqlock: seqcount_LOCKTYPE_t: Standardize naming
 convention
Message-ID: <20200828082418.GA7161@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-2-a.darwish@linutronix.de>
 <20200828081844.GM1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828081844.GM1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :)

On Fri, Aug 28, 2020 at 10:18:44AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 03:07:06AM +0200, Ahmed S. Darwish wrote:
> > At seqlock.h, sequence counters with associated locks are either called
> > seqcount_LOCKNAME_t, seqcount_LOCKTYPE_t, or seqcount_locktype_t.
> >
> > Standardize on "seqcount_LOCKTYPE_t" for all instances in comments,
> > kernel-doc, and SEQCOUNT_LOCKTYPE() generative macro paramters.
>
> > +#define SEQCOUNT_LOCKTYPE(locktype, locktype_t, preemptible, lockmember)	\
> > +typedef struct seqcount_##locktype {					\
> > +	__SEQ_LOCK(locktype_t	*lock);					\
> > +} seqcount_##locktype##_t;						\
>
> Hurmph, so my thinking was that the above 'locktype' is not actually a
> type and therefore a misnomer.
>
> But I see your point about it being a bit of a mess.
>
> Would:
>
>  s/LOCKTYPE/LOCKNAME/g
>  s/seqcount_locktype_t/seqcount_LOCKNAME_t/g
>
> help? Then we're consistently at: seqcount_LOCKNAME_t, which is a type.
>

Sounds good, will do.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
