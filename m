Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46A72072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4QytbSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbgDNLNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728734AbgDNLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:13:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03201C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:13:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o10so9674294qtr.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpfwpM4hJBhdFDJUO/BIxalK0Gg3ckktz1WqTiHJk50=;
        b=I4QytbSpAnZXG1r/Db5mIDVrvXQLSHq4fcnWwKWk8mYODMe03naWopMlNgAwopXY8m
         idxsPH9gmF93HQ5SMGPrxo1V/8+IjEcpZbj536tG12qdTXpJ+5rOvmPMU+KZDESf/elV
         y2NyKuAJLZ7UKaFgy8/S7huKWRH2j/JSey2s6CbzG1BBiQhmKOg/fSYbWNV/UIHtXRL0
         JZiI+lt9pOdOubZphIKFObQHNVGsunZKyZ1F3cCn6F/Qv8NyJ8n5x8hDRedjl5pFIyW/
         Au1Jnl5wrSzoiOiVoGuUUA9TWfSxqFviSvmD1bPlX9p0kWn5LcrGSiqpAavY8mxI1CL5
         dGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpfwpM4hJBhdFDJUO/BIxalK0Gg3ckktz1WqTiHJk50=;
        b=OuMfFNmBxq+heOSOaAH3ONAugMa44wmHe5WbvF+3Ce93gp3EcdUW2Fl1DmJtHnYh7t
         hjSbvEecas0qYOEqT8NFml6XZoSUmKdl4e/pu06RFB69ERBK1CtcQ2almbE3ca2XW19v
         zggXwTVcBKXis1DpQZ+y+8ylQ3Uq+OBAANj8zUeZ2VN0Z4uwN4iCa18TH4TpMKBNtdPY
         vQtDTwcKcA4XiwQcZuca6P8LAyjm+ESGLEZ+I1DPXSr6jhiF1uQfohr2KqIUj7jHgO2t
         iFK+Nsd0Pm1G8zbVe7FexKKadj9sJ40yIwiUdWMIfeVVfwoCY/qM7WD+UzO5ttGNYw8O
         Prkg==
X-Gm-Message-State: AGi0PuYpdfpmClGvmH28U6VtmHLO4YkLy/D4YjYYaD3VgP8dAhG7rGN1
        0ximbk1jGCZqmXajap9z18cC/vC8DdkmO1QPy9ItIg==
X-Google-Smtp-Source: APiQypLTLZou7GmMOipiehchvkDoddYDW5giMclk4CBqIWYpJ7lCFsg4JpN9MDbUlh+yBN7yiwM0UI4bprBckWWO1nQ=
X-Received: by 2002:ac8:1b6a:: with SMTP id p39mr15253601qtk.158.1586862782660;
 Tue, 14 Apr 2020 04:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <CACT4Y+bhQVcpSkSh_OZ5ZanfFZUqn2iypLhG_Z-nWKTkaYr1jw@mail.gmail.com>
 <CAHk-=wgjGgfUfVm_DpTay5TS03pLCgUWqRpQS++90fSE2V-e=g@mail.gmail.com>
 <20200410092951.6db32bfe@canb.auug.org.au> <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
In-Reply-To: <7325374A-6072-44E4-85EE-F97FC7E8565F@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Apr 2020 13:12:50 +0200
Message-ID: <CACT4Y+ZE1XhYpTsjP1J1PyUsEHYKvchww71aHb7UnSk5=4xUrw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:06 AM Qian Cai <cai@lca.pw> wrote:
> > On Apr 9, 2020, at 7:29 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Linus,
> >
> > On Thu, 9 Apr 2020 09:32:32 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>
> >> On Thu, Apr 9, 2020 at 5:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>>
> >>> linux-next is boot-broken for more than a month and bugs are piling
> >>> onto bugs, I've seen at least 3 different ones.
> >>> syzbot can't get any working linux-next build for testing for a very
> >>> long time now.
> >>
> >> Ouch.
> >>
> >> Ok, that's not good. It means that linux-next has basically only done
> >> build-testing this whole cycle.
> >
> > Well, there are other CI's beyond syzbot .. Does syzbot only build/test
> > a single kernel arch/config?
> >
> >> Stephen, Dmitry - is there some way linux-next could possibly kick out
> >> trees more aggressively if syzbot can't even boot?

Hello all,

Sorry for corona/holiday-delays. I will try to answer/comment on all
things in this thread in this email.

AI: we need to CC linux-next@ on linux-next build/boot failures. I
will work on this.
We have functionality to CC given emails on _all_ bugs on the given
tree, but we don't have this for build/boot bugs only. I will try to
add this soon.
Stephen, do you want to be CCed as well? Or just linux-next@?

> So old bugs generally should be aged out

This actually happens now.
Bugs without reproducers are auto-closed after 60-120 days since last
occurrence (based on past frequency). And for linux-next the range is
40-60 days.
Bugs with reproducers are not auto-closed. But they are fix bisected
and cause bisected, both of which are only ~66% correct, but still
frequently provide a useful signal. Also bugs with reproducers are
just generally easier to handle.

Another important distinction from Bugzilla is that syzbot dashboard
has up-to-date "Last crash time" information. Click on the "Last"
column here:
https://syzkaller.appspot.com/upstream
It's very easy to ignore everything that happened months ago for
starters, if that's the concern.

So it's not as perfect as it would be with a dedicated human team
attached, but I would say it's now in a reasonable shape with ~400
open bugs that happened within the last month.
And now we have data to confirm that "old" does not mean "irrelevant".
Our leader:
BUG: please report to dccp@vger.kernel.org => prev = 0, last = 0 at
net/dccp/ccids/lib/packet_history.c:LINE/tfrc_rx_hist_sample_rtt()
https://syzkaller.appspot.com/bug?id=0881c535c265ca965edc49c0ac3d0a9850d26eb1
was first triggered 964 days ago, but pretty much still there all that time.

> It would be nice if there was some way we could triage Syzkaller
> bugs into different buckets.

Though, yes, I am afraid of stepping onto the slippery slope of
implementing a full-fledged bug tracking system, I think syzbot will
gather more bug tracker features and tags will happen. We still have
https://github.com/google/syzkaller/issues/608 open and it's mainly
the question of allocating resources for implementation and figuring
out the actual tags hierarchy.
For login and credentials, I guess we will go with just "whoever can
send emails is a root" because we are doing this already anyways
(closing a bug is more critical than changing a tag) :)

Re panic_on_warn.
We don't have a dedicated engineer to sheriff and give manual
consideration and judgement to each case. And as Qian noted, in such
circumstances it's reasonable to don't trust anything after a warning.
Some notorious examples: LOCKDEP warnings disable LOCKDEP; so if we
boot in such state with eyes closed and then try to do fuzzing, or
"better" test a patch for a LOCKDEP error, or do bisection of a
LOCKDEP error, we will immediately give bogus testing results or
bisection culprit.
Or a warning about hung task may re-appear later during testing and
confuse results again.
Or if we ignore KASAN warning, we boot potentially with corrupted
memory with who-knows-what consequences.
A "normal" WARNING may be benign (misuse of WARNING), or maybe not.
Impossible to figure out automatically. And in the end, if we ignore
that, who/when will notice and fix that?
We get this far with this black-and-white criteria for kernel bugs. I
think it had some positive effects on a number of areas, as we go
forward I think it's better to extend panic_on_warn to more testing
systems. Then non-fatal bugs will be no different from fatal bugs
during boot, which we need to handle in a reasonable timeframe anyway.
Which gets me to the next "interesting" point.

> Well, there are other CI's beyond syzbot.
> On the other hand, this makes me worry who is testing on linux-next every day.

How do these use-after-free's and locking bugs get past the
unit-testing systems (which syzbot is not) and remain unnoticed for so
long?...
syzbot uses the dumbest VMs (GCE), so everything it triggers during
boot should be triggerable pretty much everywhere.
It seems to be an action point for the testing systems. "Boot to ssh"
is not the best criteria. Again if there is a LOCKDEP error, we are
not catching any more LOCKDEP errors during subsequent testing. If
there is a use-after-free, that's a serious error on its own and KASAN
produces only 1 error by default as well. And as far as I understand,
lots of kernel testing systems don't even enable KASAN, which is very
wrong.
I've talked to +Dan Rue re this few days ago. Hopefully LKFT will
start catching these as part of unit testing. Which should help with
syzbot testing as well.
