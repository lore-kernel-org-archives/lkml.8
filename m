Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B428C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFCA206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AI07kurl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbgDAGet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:34:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45733 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbgDAGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:34:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id c9so24789325otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnA7EYCoVJYIWQO5uMLkeOEOdfqORaBrTcKNEc28yYY=;
        b=AI07kurlnG+uQ0Sas+oEYHAyqA3uaQjgSu+JcWAX6qnYsXMNTuByTN2lAKb0jPVUYW
         C4A+Jcz1I32aaxNjVY0aaN+20mWc102bWehMohu4mj6ACawVVeqjnh5C/qiQIT3Ievdx
         WNIBPU9w+Pl17fSIxFns6zEFF+EHfRgZTJRPN5EaHUegadb63A/Z+Ion1ihZoroyK2fV
         JnFdwLs3dws+nTVHxnWDYbXynDShMvhUkMjECxgFhKFsMxvoUsifRZBlzOf5gM/KarFx
         Z4h3n0aEBx/RcKXPRzyJICmpaORRQ/DslOiZyxLs7LdabZA5CO9HlpoRYX9SdfpCeBav
         tocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnA7EYCoVJYIWQO5uMLkeOEOdfqORaBrTcKNEc28yYY=;
        b=bO37LJkJLrnVlyfAyht5+YcM3KBzwjfhynj40CtBCkEC60gJi5kF4euhnReB85OOJz
         9YAcmZq2GA0kp+YwI3WqN1WmyZe9gLq83+I04oflRJtIWURDdomAq2RUhNc8DDIx+2TK
         hMiWsxpOaZbJRzqysHEAnZquAENRs+qBGnoLJXzTgKaOLvznQ/BXCduMIaeL9XaRTGfi
         5oVhBLfKl2HSWWm+HWTY1VBV/ZFjs8hmCwxeS/YWWorWltrNH9Eixr7zv2sOh3FUC8Ig
         w8f9B6glhjWIWJmcNB1Tq4305txyEpF4mYb+VXuBsT2oLTkZlPAGqmhJ258gQXM6STXS
         sZFw==
X-Gm-Message-State: AGi0Publ69f8askf3zT47ZnMJln87PP7sY8fLvxIMvk/heokATCRm03F
        5f31T2DQh+9uJE6YvJhRhO0QRSwfKgiyBu8KOCfj3w==
X-Google-Smtp-Source: APiQypJfjS/kXYYGDaXryn4HsRwbBAV96lZ1gvez2EbUJtOV5YWRXj4Zda4APQHF8BW8uwiIYTGorQVuiQXbEq4zc8o=
X-Received: by 2002:a9d:4b84:: with SMTP id k4mr150225otf.233.1585722887489;
 Tue, 31 Mar 2020 23:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153643.15527-1-will@kernel.org> <20200324153643.15527-4-will@kernel.org>
 <CANpmjNPWpkxqZQJJOwmx0oqvzfcxhtqErjCzjRO_y0BQSmre8A@mail.gmail.com> <20200331131002.GA30975@willie-the-truck>
In-Reply-To: <20200331131002.GA30975@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Apr 2020 08:34:36 +0200
Message-ID: <CANpmjNN-nN1OfGNXmsaTtM=11sth7YJTJMePzXgBRU73ohkBjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with data_race()
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 at 15:10, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Mar 24, 2020 at 05:23:30PM +0100, Marco Elver wrote:
> > On Tue, 24 Mar 2020 at 16:37, Will Deacon <will@kernel.org> wrote:
> > > Some list predicates can be used locklessly even with the non-RCU list
> > > implementations, since they effectively boil down to a test against
> > > NULL. For example, checking whether or not a list is empty is safe even
> > > in the presence of a concurrent, tearing write to the list head pointer.
> > > Similarly, checking whether or not an hlist node has been hashed is safe
> > > as well.
> > >
> > > Annotate these lockless list predicates with data_race() and READ_ONCE()
> > > so that KCSAN and the compiler are aware of what's going on. The writer
> > > side can then avoid having to use WRITE_ONCE() in the non-RCU
> > > implementation.
> > >
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Marco Elver <elver@google.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  include/linux/list.h       | 10 +++++-----
> > >  include/linux/list_bl.h    |  5 +++--
> > >  include/linux/list_nulls.h |  6 +++---
> > >  include/linux/llist.h      |  2 +-
> > >  4 files changed, 12 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/list.h b/include/linux/list.h
> > > index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> > > --- a/include/linux/list.h
> > > +++ b/include/linux/list.h
> > > @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
> > >   */
> > >  static inline int list_empty(const struct list_head *head)
> > >  {
> > > -       return READ_ONCE(head->next) == head;
> > > +       return data_race(READ_ONCE(head->next) == head);
> >
> > Double-marking should never be necessary, at least if you want to make
> > KCSAN happy. From what I gather there is an unmarked write somewhere,
> > correct? In that case, KCSAN will still complain because if it sees a
> > race between this read and the other write, then at least one is still
> > plain (the write).
>
> Ok, then I should drop the data_race() annotation and stick to READ_ONCE(),
> I think (but see below).
>
> > Then, my suggestion would be to mark the write with data_race() and
> > just leave this as a READ_ONCE(). Having a data_race() somewhere only
> > makes KCSAN stop reporting the race if the paired access is also
> > marked (be it with data_race() or _ONCE, etc.).
>
> The problem with taking that approach is that it ends up much of the
> list implementation annotated with either WRITE_ONCE() or data_race(),
> meaning that concurrent, racy list operations will no longer be reported
> by KCSAN. I think that's a pretty big deal and I'm strongly against
> annotating the internals of library code such as this because it means
> that buggy callers will largely go undetected.
>
> The situation we have here is that some calls, e.g. hlist_empty() are
> safe even in the presence of a racy write and I'd like to suppress KCSAN
> reports without annotating the writes at all.
>
> > Alternatively, if marking the write is impossible, you can surround
> > the access with kcsan_disable_current()/kcsan_enable_current(). Or, as
> > a last resort, just leaving as-is is fine too, because KCSAN's default
> > config (still) has KCSAN_ASSUME_PLAIN_WRITES_ATOMIC selected.
>
> Hmm, I suppose some bright spark will want to change the default at the some
> point though, no? ;) I'll look at using
> kcsan_disable_current()/kcsan_enable_current(), thanks.

I think this will come up again (it did already come up in some other
patch I reviewed, and Paul also mentioned it), so it seems best to
change data_race() to match the intuitive semantics of just completely
ignoring the access marked with it. I.e. marking accesses racing with
accesses marked with data_race() is now optional:
  https://lkml.kernel.org/r/20200331193233.15180-1-elver@google.com

In which case, the original patch you had here works just fine.

Thanks,
-- Marco
