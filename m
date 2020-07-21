Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D78207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LU+YNfvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUsOjoEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGUFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:34:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGUFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:34:58 -0400
Date:   Tue, 21 Jul 2020 07:34:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595309695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xh6JYaPWaIWplZOMrnqFpx02BFp6tLeAYyDq7VCSNy8=;
        b=LU+YNfvcBeMNPH0PLwJ0qgIs+h+wwvZeWt+zW2ZTruQRUt3oshadWL8ke1wVqDH8bwS/iA
        gVJfxjyeyhiTMU2DtYGgaL2DpsA5Sb/+rQgZcwD2YcRhe25HXr/SLMALSaR2W9AIqUqswT
        om9AnGdNaYWNVisYJfo8s2KELwdI+S0lz2+Ed02bNPdzGIKfBqIv1Vd89TnxGUnAyCOPDO
        IA1y2vCczxhNw1Tuw8HhPM8BlLub5dKteD+AVEs1usMCIf02I8+4HSwV7ETlUa79VWbjTY
        gSjSgbbprSghcQ/r/v97o3PEumfu0Bhr3p5kLsudaatP5n5BTVGiMGKlgbY86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595309695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xh6JYaPWaIWplZOMrnqFpx02BFp6tLeAYyDq7VCSNy8=;
        b=RUsOjoEYNoCJ55m5UQP6l/dq4CRmDI5u8R4q0i/5goIRa7YQ47EFPiFtUdaUDMrNeWxKEk
        6lG7KJJfJLIF/MCA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/24] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200721053453.GA27648@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-2-a.darwish@linutronix.de>
 <20200720213551.5ba9bc6d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720213551.5ba9bc6d@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:35:51PM -0400, Steven Rostedt wrote:
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
> Nit, but I would mention that this acts similar to a normal spin_lock,
> and even disables preeption (in the non-RT case).

will do.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
