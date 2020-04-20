Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A62C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF130218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJkRkP/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDTW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:57:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DBCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:57:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so1480402wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHAraBxaNBhreyeFni0FWqDVB5guk3xkclwYoQz0lyU=;
        b=JJkRkP/mOdP3Ju59IG8dR4xztQX/1hsjiNn9uKp9W9fV7L9wUDG+b3/Nrb2nNwk0R+
         jdaBaIEImRZFkH+SgqJJ7sVlsomS817bQ0EYcQDORBlggKLCP8t/qPPEqnehFPVdUZ4o
         S73WdwurDf1Y4kekLs59/oz6mp8QzHo90nxYDoFqUdjgTlGbD1bm5XcM2lH4Lwje8FOg
         bM2+TPM/jzU+5YIuRWEh49p7dSA6cOfxTyv10g6o0yIlmWioABo5zArCiRTvmxLQSxEo
         8qXurxw9Xi2O04cdWaIpx6ZBbUicavP78STYka5LIseI1dluzUxUjJBeb2gfle9isyzn
         IlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHAraBxaNBhreyeFni0FWqDVB5guk3xkclwYoQz0lyU=;
        b=bPDCtbw2fsPw16mqwDf6oRm7KU0DTV+XkvhqN1o6hQbTjAevmzd+D1eO2eNceSW8uH
         +43wnkFGn5Bg65Imf1L6Vjm6v5BIZDb6S0KQS8OWIfCldDuQVdUUDQwxCKkwmqV5hf2I
         rdtW2bFrRDVdnl9ILVZJjHaPQNpUv+gCsAGeoY8i0K/Nbl/gQYKEAWysI7OkP8/U/ryt
         5U1adzhxw2Cuco6Zll5f4+yxfjVLt4CMS9F3hhShhAYe2ZBHZTPuKQOu1iAGvQsgHdv/
         DUNtRF46sIRGLgw357LlvPb/1p1GB5raQ0/r3U4y+T/uBZl0RmlY5e52PZn5e5gjxKqK
         J2hA==
X-Gm-Message-State: AGi0PuajOkkGf4yi6DqH8uwP6KmOnUQNNz1jw+qnAwiV8G9jm1VXsXvL
        rD7YOERAUzMkziN5BcT1nd8aWA==
X-Google-Smtp-Source: APiQypLWMgYMoJtk44mftpP3EmtcC0OUdFuydtkJrgqU9fPFtjDpp0HL52GVsyoA3RWtkS3KEqZ6nQ==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr1576385wmh.157.1587423443008;
        Mon, 20 Apr 2020 15:57:23 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id h16sm1386461wrw.36.2020.04.20.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:57:22 -0700 (PDT)
Date:   Tue, 21 Apr 2020 00:57:15 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Petko Manolov' <petko.manolov@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] WRITE_ONCE_INC() and friends
Message-ID: <20200420225715.GA176156@google.com>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420150545.GB17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020, Paul E. McKenney wrote:

> On Sun, Apr 19, 2020 at 09:37:10PM +0000, David Laight wrote:
> > From: Petko Manolov
> > > Sent: 19 April 2020 19:30
> > > 
> > > On 20-04-19 18:02:50, David Laight wrote:
> > > > From: Petko Manolov
> > > > > Sent: 19 April 2020 10:45
> > > > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > > > >
> > > > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> > > >
> > > > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > > > field 'volatile'?
> > > 
> > > This is a bit heavy.  I guess you've read this one:
> > > 
> > > 	https://lwn.net/Articles/233479/
> > 
> > I remember reading something similar before.
> > I also remember a very old gcc (2.95?) that did a readback
> > after every volatile write on sparc (to flush the store buffer).
> > That broke everything.
> > 
> > I suspect there is a lot more code that is attempting to be lockless
> > these days.
> > Ring buffers (one writer and one reader) are a typical example where
> > you don't need locks but do need to use a consistent value.
> > 
> > Now you may also need ordering between accesses - which I think needs
> > more than volatile.
> 
> In Petko's patch, all needed ordering is supplied by the fact that it
> is the same variable being read and written.  But yes, in many other
> cases, more ordering is required.
> 
> > > And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> > > example, all others are from withing spin_lock/unlock pairs then we _may_ not
> > > need READ/WRITE_ONCE().
> > 
> > The cost of volatile accesses is probably minimal unless the
> > code is written assuming the compiler will only access things once.
> 
> And there are variables marked as volatile, for example, jiffies.
> 
> But one downside of declaring variables volatile is that it can prevent
> KCSAN from spotting violations of the concurrency design for those
> variables.

Note that, KCSAN currently treats volatiles not as special, except a
list of some known global volatiles (like jiffies). This means, that
KCSAN will tell us about data races involving unmarked volatiles (unless
they're in the list).

As far as I can tell, this is what we want. At least according to LKMM.

If, for whatever reason, volatiles should be treated differently, we'll
have to modify the compilers to emit different instrumentation for the
kernel.

Thanks,
-- Marco
