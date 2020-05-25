Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A844C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D1E20849
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vu/F9Dss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390861AbgEYNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbgEYNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:44:58 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A1C061A0E;
        Mon, 25 May 2020 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+/9EB+gqUSTCQhVlgwmYHPpqEaICAppIqnpJ4LPwD8U=; b=Vu/F9Dss7kuI+g7DVtxcOSePVc
        EZi7fra/CTyTCjXy2K8r4Jebv5UwcmZorzPld1lnp1vj2529Ccm7MeesYZyDC95euECiec839L96e
        ioig9ELPpt1To0X6XLFHP1dUQ66Lfp+ce5DdwiJV8CuQcTcvyZp8GfM2rElQTY8GLkfEayeSCUcZw
        ACzYIH7tAgjck1ntkBCqrjP+qJGWJQxe4UTy+uJFBD7gFpCW5HuWzUg7r+SYePXuuQNrfx0z3Oy9L
        MgYA+UzKytPYdwwz+k/9lQQYFnf5gJlFC2xv2ynloQy30JaLRVih8I7yFXnn2ReXuzJY79iD3/PUw
        OZiRo4QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdDP6-00087O-2X; Mon, 25 May 2020 13:44:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 654DB300B38;
        Mon, 25 May 2020 15:44:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 145ED20962E29; Mon, 25 May 2020 15:44:29 +0200 (CEST)
Date:   Mon, 25 May 2020 15:44:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code
 samples and notes
Message-ID: <20200525134429.GE317569@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-11-a.darwish@linutronix.de>
 <20200522180254.GS325280@hirez.programming.kicks-ass.net>
 <20200522180336.GD325303@hirez.programming.kicks-ass.net>
 <871rnbsu57.fsf@nanos.tec.linutronix.de>
 <20200522183216.GT325280@hirez.programming.kicks-ass.net>
 <20200525093649.GA370823@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525093649.GA370823@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:36:49AM +0200, Ahmed S. Darwish wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:

> > I will not let sensible code comments deteriorate to the benefit of some
> > external piece of crap.
> >
> > As a programmer the primary interface to all this is a text editor, not
> > a web broswer or a pdf file or whatever other bullshit.
> >
> > If comments are unreadable in your text editor, they're useless.
> 
> Wait.
> 
> Most of the patch in question is just substituting the code snippet's
> leading white spaces to tabs. For illustration purposes, if we remove
> these white space hunks from the diff, it becomes:
> 
>   --- a/include/linux/seqlock.h
>   +++ b/include/linux/seqlock.h
>   @@ -232,6 +232,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
>   + * .. code-block:: c
>   ...
>   + * .. code-block:: c
>   ...
>   - * NOTE: The non-requirement for atomic modifications does _NOT_ include
>   - *       the publishing of new entries in the case where data is a dynamic
>   - *       data structure.
>   + * .. attention::
>   + *
>   + *     The non-requirement for atomic modifications does _NOT_ include
>   + *     the publishing of new entries in the case where data is a dynamic
>   + *     data structure.
>   ...
> 
> Are you trying to tell me that, good heavens, these directives are
> really hurting your eyes so much?

Yep, they're a distraction and serve absolutely no purpose. They're also
utterly moronic, of course it's code and of course it's bloody well C.

> Putting kernel-doc aside... That huge raw_write_seqcount_latch() comment
> is actually *way more readable from any text editor* after applying this
> patch. Go figure.

I don't mind the re-indent.

> >>> The correct fix is, as always, to remove the kernel-doc marker.
> 
> Sorry, that's not the correct fix.

Of course it is, if kerneldoc complains that a perfectly good comment
is no good, then the fault lies with kerneldoc.

It's like checkpatch; assume it is wrong :-)

> In the following patches, kernel-doc for the entire seqlock.h API is
> added. Singling out raw_write_seqcount_latch() doesn't make any sense.

% s/\/\*\*/\/\*/g -- tada!!

> If you look at the top of this patch series, a lot of seqlock.h
> seqcount_t call sites were badly broken. The 0day kernel test bot sent
> me even more erroneous call sites due to the added lockdep checks. This
> is an extra argument for the added documentation: the existing one is
> horrible.

I've nothing against improving comments, I'm just saying that RST is
absolute atrocious shite and has nothing to do with good comments.

If sphinx doesn't like "NOTE:' when go teach it.

> So, please, don't claim that the current situation is fine. It is not.

I've never claimed that. My claim is that RST is shite and has no added
value.
