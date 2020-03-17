Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E2C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DThUjTgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgCQRof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:44:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40789 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:44:34 -0400
Received: by mail-oi1-f195.google.com with SMTP id y71so22681994oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uny09Ikq2gRYtvFRYVAmcVvvtWssTyutAcTyjFY40Jo=;
        b=DThUjTgTucOr18Wp1UZD/1cFdTWwBV8uIN+p5KUTJ6I7KA3P2xEqTPyVWmWILig+Bh
         rF1zTEcnnwsfKDTTcR3rjykCe/bleoEgnMVYafYFwToOJEUhu2ETKajbEj6928d/zcNl
         fpBIUevyhrdCmz8J+Y+btMJamG/FEN274FxubxbqJZ4/Wl+FK9i5Eh3D5yhCBLkC+ukj
         LtUQrXxASXbYVly5jRtYEVH/+ZFZx0ZgrNAWDcCF0+ih2ktrGTE4EWhZu24+HmWSHchI
         v21Px0nOWOTIopmfH02YUusP+/m60gKxgtncucev2farv9B80Jh9BXdHv2iBVYwiT6tp
         Uugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uny09Ikq2gRYtvFRYVAmcVvvtWssTyutAcTyjFY40Jo=;
        b=Qikb69GdiEW592IdF7Wj9hj1cDULwr3E2luhESCY1Eu5SZ2k9l38PLHEW+zs6RiAc5
         JW7wvwNg06Tqi3RakVKh3mXuEQUjo1NTaWnOyaZnvUDyf+AYDc7FCumuv1HFV75FgkXO
         n4qoevJu2Hs50jevI53mP+o4obKn6XvibhLZfQyQOrDR3RwYo48+BfY3w+4Eq+5JP+MZ
         MTYAhINgANqx2RPWjno0IMNMuxJJ2dr2ev1+n/Dv4jbP2v7RRVWrqaHVOhwJICubM0qn
         12GlYD7YoxTA1+VfrBcvO8aUJbgHhMsxJiEkYt9vTM8B3a5FCh0KKtOwu5BuVMqbJsln
         tdTg==
X-Gm-Message-State: ANhLgQ3VdngH317WhC0G5neLy0Fs62MnDSbPNnTe1CCDk8Gunv83dI1i
        DtcXmPT1r3Tk/ekfJTNuZCJ7ZfbMNK3/l00vYQrLOw==
X-Google-Smtp-Source: ADFU+vsA2Sf5DwSLtvYCdJwkzVDeFYXHjoDvJ7ubh8/S00O5M/rsBeMhZZYuAswAai/e3PR6C5hIFMm32sYBh02ZRps=
X-Received: by 2002:aca:f541:: with SMTP id t62mr14021oih.172.1584467073577;
 Tue, 17 Mar 2020 10:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72> <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
 <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
 <20200316154535.GX3199@paulmck-ThinkPad-P72> <CANpmjNOsLeiD6hYXeD4g8fA=Ti6EiUsbtiv4VshRGg+oG1ct-g@mail.gmail.com>
 <20200317171320.GI3199@paulmck-ThinkPad-P72>
In-Reply-To: <20200317171320.GI3199@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Mar 2020 18:44:21 +0100
Message-ID: <CANpmjNMN0DTxCXVL+OOPRaDiZUMGn5EsdyEQ==w_=5MOXc8J4Q@mail.gmail.com>
Subject: Re: [PATCH kcsan 27/32] kcsan: Add option to allow watcher interruptions
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 at 18:13, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Mar 16, 2020 at 05:22:34PM +0100, Marco Elver wrote:
> > On Mon, 16 Mar 2020 at 16:45, Paul E. McKenney <paulmck@kernel.org> wro=
te:
> > >
> > > On Mon, Mar 16, 2020 at 02:56:38PM +0100, Marco Elver wrote:
> > > > On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrot=
e:
> > > > > > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org =
wrote:
> > > > > > > > From: Marco Elver <elver@google.com>
> > > > > > > >
> > > > > > > > Add option to allow interrupts while a watchpoint is set up=
. This can be
> > > > > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via th=
e boot
> > > > > > > > parameter 'kcsan.interrupt_watcher=3D1'.
> > > > > > > >
> > > > > > > > Note that, currently not all safe per-CPU access primitives=
 and patterns
> > > > > > > > are accounted for, which could result in false positives. F=
or example,
> > > > > > > > asm-generic/percpu.h uses plain operations, which by defaul=
t are
> > > > > > > > instrumented. On interrupts and subsequent accesses to the =
same
> > > > > > > > variable, KCSAN would currently report a data race with thi=
s option.
> > > > > > > >
> > > > > > > > Therefore, this option should currently remain disabled by =
default, but
> > > > > > > > may be enabled for specific test scenarios.
> > > > > > > >
> > > > > > > > To avoid new warnings, changes all uses of smp_processor_id=
() to use the
> > > > > > > > raw version (as already done in kcsan_found_watchpoint()). =
The exact SMP
> > > > > > > > processor id is for informational purposes in the report, a=
nd
> > > > > > > > correctness is not affected.
> > > > > > > >
> > > > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > >
> > > > > > > And I get silent hangs that bisect to this patch when running=
 the
> > > > > > > following rcutorture command, run in the kernel source tree o=
n a
> > > > > > > 12-hardware-thread laptop:
> > > > > > >
> > > > > > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 =
--duration 10 --kconfig "CONFIG_DEBUG_INFO=3Dy CONFIG_KCSAN=3Dy CONFIG_KCSA=
N_ASSUME_PLAIN_WRITES_ATOMIC=3Dn CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn =
CONFIG_KCSAN_REPORT_ONCE_IN_MS=3D100000 CONFIG_KCSAN_VERBOSE=3Dy CONFIG_KCS=
AN_INTERRUPT_WATCHER=3Dy" --configs TREE03
> > > > > > >
> > > > > > > It works fine on some (but not all) of the other rcutorture t=
est
> > > > > > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The =
common thread
> > > > > > > is that these are the TREE scenarios are all PREEMPT=3Dy.  So=
 are RUDE01,
> > > > > > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not ham=
mering
> > > > > > > on Tree RCU, and thus have far less interrupt activity and th=
e like.
> > > > > > > Given that it is an interrupt-related feature being added by =
this commit,
> > > > > > > this seems like expected (mis)behavior.
> > > > > > >
> > > > > > > Can you reproduce this?  If not, are there any diagnostics I =
can add to
> > > > > > > my testing?  Or a diagnostic patch I could apply?
> > > > >
> > > > > I think I can reproduce it.  Let me debug some more, so far I hav=
en't
> > > > > found anything yet.
> > > > >
> > > > > What I do know is that it's related to reporting. Turning kcsan_r=
eport
> > > > > into a noop makes the test run to completion.
> > > > >
> > > > > > I should hasten to add that this feature was quite helpful in r=
ecent work!
> > > > >
> > > > > Good to know. :-)  We can probably keep this patch, since the def=
ault
> > > > > config doesn't turn this on. But I will try to see what's up with=
 the
> > > > > hangs, and hopefully find a fix.
> > > >
> > > > So this one turned out to be quite interesting. We can get deadlock=
s
> > > > if we can set up multiple watchpoints per task in case it's
> > > > interrupted and the interrupt sets up another watchpoint, and there
> > > > are many concurrent races happening; because the other_info struct =
in
> > > > report.c may never be released if an interrupt blocks the consumer =
due
> > > > to waiting for other_info to become released.
> > >
> > > Been there, done that!  ;-)
> > >
> > > > Give me another day or 2 to come up with a decent fix.
> > >
> > > My thought is to send a pull request for the commits up to but not
> > > including this patch, allowing ample development and testing time for
> > > the fix.  My concern with sending this, even with a fix, is that any
> > > further bugs might cast a shadow on the whole series, further slowing
> > > acceptance into mainline.
> > >
> > > Fair enough?
> >
> > That's fine. I think the features changes can stay on -rcu/kcsan-dev
> > for now, but the documentation updates don't depend on them.
> > If it'd be useful, the updated documentation could be moved before
> > this patch to -rcu/kcsan, so we'd have
> >
> >  kcsan: Add current->state to implicitly atomic accesses
> >  kcsan: Add option for verbose reporting
> >  kcsan: Add option to allow watcher interruptions
> > -- cut --
> >  kcsan: Update API documentation in kcsan-checks.h
> >  kcsan: Update Documentation/dev-tools/kcsan.rst
> >  kcsan: Fix a typo in a comment
> > .. rest of series ..
> >
> > Although I'm fine with either.
>
> Given my churn with a recent merge window, I am more reluctant than
> I might otherwise be to do that sort of rearrangement.  Sorry to be
> so cowardly!

No problem. This should be fine either way.

Thank you!
-- Marco
