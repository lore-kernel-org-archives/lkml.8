Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49AC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10151206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXo0h9Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBURgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:36:54 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42716 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgBURgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:36:53 -0500
Received: by mail-oi1-f182.google.com with SMTP id j132so2344006oih.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTRXYuQ87dvDK9Oz1vWAuaYjsHn0ZemoE8V0xwoz7H0=;
        b=kXo0h9Gt5NHWtGfZV9IH1vFOGRutjzEa7R2/xU2oUsHRonvAFyHjnro0dqamOexF8z
         EsiyWR8yFFWMoONokEhG6mOxxYHiJ+iQPuhmpWKiW32liSjm4QrviswEFzhWBSeLEE5w
         eRujlRgEzoM8eNA+CYFUf2UGSflgLO+Emz02CqJyfadQZotnXRkCQ+l2cGQbdxuRBYyc
         C8peDwALRlJaHoSjbBAPenvadCC2o2QvOz8CgNr/fTkxiHagEkqE9jDB4/15IuoNRLAZ
         6z66cy/jd2dxId0AXTVmEfjV3d/4ynIY1vQdorg5LDEUuZqqy6Hu7T8FDaxBieccmRE6
         muzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTRXYuQ87dvDK9Oz1vWAuaYjsHn0ZemoE8V0xwoz7H0=;
        b=CdjpV5PtMnQ6WMS6NetsMgKepWf91usPHdvALzIoaFFvFnuYi49p01Jp3HfHhdEFz6
         CTugfJ/vM+Fp1Sh6W6LUyHejVemPSTkRtYBKtgc8xntyqxDfZK5qYHuixEXkPjx+db2r
         RuSGK0xlPZsO3ush1vxjZdKx7rr8+jVqlICs+1KkAvKaq596kuUTH2r+/6XwIWP13fpd
         QeG1OUPQuH8PUIpHyDqCEbaRAjvIwa7kM4m/fjlD1aJ5TpLeoMkoRNyeDZ/808PS0trR
         getcDlmAt3hSb0uiqSu1aBsgLajS7O9hw47j4/OlPW0GJTBdjsUGACwuW1inUI9JbSPy
         13Aw==
X-Gm-Message-State: APjAAAVW//VH3iZzyhLHjJ20xTccFITFhbw4hb1c5kJyRd+MgyUrhaSq
        sMFbEpyl1aG6noet6rgnr4RfDAv4+zW3e8A801R0dA==
X-Google-Smtp-Source: APXvYqxCoOJQzNGFh4S6Wf2LwznGZ2gPK7NTphumYq3n31yOSzlLD/AyHuWWgTne7kL2s4mbyiQCCgUXnQwWQXZ8d/8=
X-Received: by 2002:aca:d954:: with SMTP id q81mr2902469oig.157.1582306612529;
 Fri, 21 Feb 2020 09:36:52 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
 <CAG48ez3ZMg4O5US3n=p1CYK-2AAgLRY+pjnUXp2p5hdwbjCRSA@mail.gmail.com>
 <1808070.1582287889@warthog.procyon.org.uk> <CAG48ez0+_kO_YL6iO9uA+HjjnHRVHVD-bFq0C=ZLeaGtTMss5A@mail.gmail.com>
 <2113718.1582304782@warthog.procyon.org.uk>
In-Reply-To: <2113718.1582304782@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 18:36:26 +0100
Message-ID: <CAG48ez14CHMjZS8vCp6h6FnLvcFQq8oy_9JPCd=5qZ52X6w12Q@mail.gmail.com>
Subject: seq_lock and lockdep_is_held() assertions
To:     David Howells <dhowells@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
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

adding some locking folks to the thread...

On Fri, Feb 21, 2020 at 6:06 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > On Fri, Feb 21, 2020 at 1:24 PM David Howells <dhowells@redhat.com> wrote:
> > > What's the best way to write a lockdep assertion?
> > >
> > >         BUG_ON(!lockdep_is_held(lock));
> >
> > lockdep_assert_held(lock) is the normal way, I think - that will
> > WARN() if lockdep is enabled and the lock is not held.
>
> Okay.  But what's the best way with a seqlock_t?  It has two dep maps in it.
> Do I just ignore the one attached to the spinlock?

Uuuh... very good question. Looking at how the seqlock_t helpers use
the dep map of the seqlock, I don't think lockdep asserts work for
asserting that you're in the read side of a seqlock?

read_seqbegin_or_lock() -> read_seqbegin() -> read_seqcount_begin() ->
seqcount_lockdep_reader_access() does seqcount_acquire_read() (which
maps to lock_acquire_shared_recursive()), but immediately following
that calls seqcount_release() (which maps to lock_release())?

So I think lockdep won't consider you to be holding any locks after
read_seqbegin_or_lock() if the lock wasn't taken?
