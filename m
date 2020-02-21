Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF04BC3565A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71DB20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQjdrHTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgBUSCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:02:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41789 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgBUSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:02:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so2422343oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YwDEdueNqiLiTZn2fh4bRMDgxjPniW53g8xmvHACU8Q=;
        b=xQjdrHTyiXy4turHzDZawU33aP36M8C7jfcRPKkpZOWK4V8Zng8Z6f+ZgYj7VxJaFK
         5Spfrxkvpfi24B5ZMNSQ4zijH9oXUi0TjkRHlZy4p+o+GHFj7sQp91f/yhA706x1ZWMy
         QI/h2BnyyFjtA2nPfmhrZidKwkesQDhIpNPE5Rq3JTzmWpzItKvuV7pFIm/r2ZDha7co
         9f+SB7uplc1s7HwIkY6KPwsRdjrP3Q9n9R9o/2r5hb5l4YFol9quvryDblWiKQ2ERHY6
         wHqrdXaOo/w+WgWBTejcc8efA2jIXWb8INL/HXIVLxDLOM7zPH3L/wwe9r8ECi41E5HS
         TBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwDEdueNqiLiTZn2fh4bRMDgxjPniW53g8xmvHACU8Q=;
        b=G7yZbrckz6WpgzSOX4Mqgx6WHQ/j2Eo81EeczuWfCzl4MtBuCFqX7kVqIi+0Tw9Q/x
         Q2QQE20/XjC/mVqATn1RYtY3t4b0wHZfss12/v9kKHMg66Ju0zCcRBSJ+qluT1XLkKVj
         uOg9rKCPOB4XRc5ZkGSXLuDSBISGNfNYsm3u9ldLz7KrBu7p9gjOjJd7pZbiypPPSUTS
         1ON82M6a5t96QkyySCR97w1KVVOxzUGVsGTVFt6Txp4YDXAWjarSKpNkvNl3Lt3YvtTK
         bbo+VTqcHw0ywn/AIOYYtcHGYe/5fhVeuEKox84ks1g6D0+betFmBZ4ImbX6Gvhax5I/
         i1aQ==
X-Gm-Message-State: APjAAAWyuo+ueSmG9NAoZxq5vd9rf4aajH6Gc5Fa6ZrGh97reOd+5vBJ
        CikWar4Ijq+O0teUE3J7oNUfosj2Y5M8Ncd14BWneg==
X-Google-Smtp-Source: APXvYqyEtv2oGXx37l0a2b85lAJA3ombqXpMi4TeaNhtI8rq6+iJk+G5kX12275qe2nvDThK6H9LGH1udU668SSz7Zo=
X-Received: by 2002:aca:c551:: with SMTP id v78mr3003192oif.161.1582308156744;
 Fri, 21 Feb 2020 10:02:36 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
 <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com>
 <1808070.1582287889@warthog.procyon.org.uk> <CAG48ez0+_kO_YL6iO9uA+HjjnHRVHVD-bFq0C=ZLeaGtTMss5A@mail.gmail.com>
 <2113718.1582304782@warthog.procyon.org.uk> <CAG48ez14CHMjZS8vCp6h6FnLvcFQq8oy_9JPCd=5qZ52X6w12Q@mail.gmail.com>
In-Reply-To: <CAG48ez14CHMjZS8vCp6h6FnLvcFQq8oy_9JPCd=5qZ52X6w12Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 21 Feb 2020 10:02:25 -0800
Message-ID: <CALAqxLWxpkZMrJEHgYjtZnRtYtT7zY8=igKQ3rNPpqNV8FmLhg@mail.gmail.com>
Subject: Re: seq_lock and lockdep_is_held() assertions
To:     Jann Horn <jannh@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 9:36 AM Jann Horn <jannh@google.com> wrote:
>
> adding some locking folks to the thread...
>
> On Fri, Feb 21, 2020 at 6:06 PM David Howells <dhowells@redhat.com> wrote:
> > Jann Horn <jannh@google.com> wrote:
> > > On Fri, Feb 21, 2020 at 1:24 PM David Howells <dhowells@redhat.com> wrote:
> > > > What's the best way to write a lockdep assertion?
> > > >
> > > >         BUG_ON(!lockdep_is_held(lock));
> > >
> > > lockdep_assert_held(lock) is the normal way, I think - that will
> > > WARN() if lockdep is enabled and the lock is not held.
> >
> > Okay.  But what's the best way with a seqlock_t?  It has two dep maps in it.
> > Do I just ignore the one attached to the spinlock?
>
> Uuuh... very good question. Looking at how the seqlock_t helpers use
> the dep map of the seqlock, I don't think lockdep asserts work for
> asserting that you're in the read side of a seqlock?
>
> read_seqbegin_or_lock() -> read_seqbegin() -> read_seqcount_begin() ->
> seqcount_lockdep_reader_access() does seqcount_acquire_read() (which
> maps to lock_acquire_shared_recursive()), but immediately following
> that calls seqcount_release() (which maps to lock_release())?
>
> So I think lockdep won't consider you to be holding any locks after
> read_seqbegin_or_lock() if the lock wasn't taken?

Yea. It's a bit foggy now, but the main concern at the time was
wanting to catch seqlock readers that happened under a writer which
was a common cause of deadlocks between the timekeeping core and stuff
like printks (or anything we called out that might try to read the
time).

I think it was because writers can properly interrupt readers, we
couldn't hold the depmap across the read critical section? That's why
we just take and release the depmap, since that will still catch any
reads made while holding the write, which would deadlock.

But take that with a grain of salt, as its been awhile.

thanks
-john
