Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA290206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbgEYJhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgEYJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:37:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E5C061A0E;
        Mon, 25 May 2020 02:37:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jd9XP-00062M-Es; Mon, 25 May 2020 11:36:51 +0200
Date:   Mon, 25 May 2020 11:36:49 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code
 samples and notes
Message-ID: <20200525093649.GA370823@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-11-a.darwish@linutronix.de>
 <20200522180254.GS325280@hirez.programming.kicks-ass.net>
 <20200522180336.GD325303@hirez.programming.kicks-ass.net>
 <871rnbsu57.fsf@nanos.tec.linutronix.de>
 <20200522183216.GT325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522183216.GT325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 22, 2020 at 08:26:44PM +0200, Thomas Gleixner wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > > On Fri, May 22, 2020 at 08:02:54PM +0200, Peter Zijlstra wrote:
> > >> On Tue, May 19, 2020 at 11:45:32PM +0200, Ahmed S. Darwish wrote:
> > >> > Mark all C code samples inside seqlock.h kernel-doc text with the RST
> > >> > 'code-block: c' directive. Sphinx won't properly format the example code
> > >> > and will produce noisy text indentation warnings otherwise.
> > >>
> > >> I so bloody hate RST.. and now it's infecting perfectly sane comments
> > >> and turning them into unreadable junk :-(
> > >
> > > The correct fix is, as always, to remove the kernel-doc marker.
> >
> > Get over it already.
>
> I will not let sensible code comments deteriorate to the benefit of some
> external piece of crap.
>
> As a programmer the primary interface to all this is a text editor, not
> a web broswer or a pdf file or whatever other bullshit.
>
> If comments are unreadable in your text editor, they're useless.

Wait.

Most of the patch in question is just substituting the code snippet's
leading white spaces to tabs. For illustration purposes, if we remove
these white space hunks from the diff, it becomes:

  --- a/include/linux/seqlock.h
  +++ b/include/linux/seqlock.h
  @@ -232,6 +232,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  + * .. code-block:: c
  ...
  + * .. code-block:: c
  ...
  - * NOTE: The non-requirement for atomic modifications does _NOT_ include
  - *       the publishing of new entries in the case where data is a dynamic
  - *       data structure.
  + * .. attention::
  + *
  + *     The non-requirement for atomic modifications does _NOT_ include
  + *     the publishing of new entries in the case where data is a dynamic
  + *     data structure.
  ...

Are you trying to tell me that, good heavens, these directives are
really hurting your eyes so much?

Putting kernel-doc aside... That huge raw_write_seqcount_latch() comment
is actually *way more readable from any text editor* after applying this
patch. Go figure.

>>> The correct fix is, as always, to remove the kernel-doc marker.

Sorry, that's not the correct fix.

In the following patches, kernel-doc for the entire seqlock.h API is
added. Singling out raw_write_seqcount_latch() doesn't make any sense.

If you look at the top of this patch series, a lot of seqlock.h
seqcount_t call sites were badly broken. The 0day kernel test bot sent
me even more erroneous call sites due to the added lockdep checks. This
is an extra argument for the added documentation: the existing one is
horrible.

So, please, don't claim that the current situation is fine. It is not.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
