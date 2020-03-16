Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCCCC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E1C20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuHh1iQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgCPN4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:56:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42373 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgCPN4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:56:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id 66so17883031otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SSNdADPq40Icef6Tc/mRDZ+zWsTXT5yssnz0a7eZlsw=;
        b=BuHh1iQw9D5S/CSDLMes3O/Z027IN27+nS9M9h0w3X2Q6aE54k3WH6saSfk3mbexwy
         Ot9DqbQkbclTXsc0sh9lkymaa5NFknCXTSMJJM0WIqMLzdke72kKAGM6KMvkpy5CxxVs
         z6eEtT1Gv+RY6oHBhoergPp6GS+cNYLA4OUqXODE5c26VmwsANLuNrsrKzn1ccxpUE33
         loWXV0pmiPDdsjGscwCtpBAN50waRiSzvPKgB1Hv3axNkraImnw+uyzyP1pegu1Mt83q
         BnFjImWtl3B91wnMDhdp9cFFiuXCnOwbZfD5NAyYv89gA1zbDeKfB1JzcTylbl1tKk9x
         lSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SSNdADPq40Icef6Tc/mRDZ+zWsTXT5yssnz0a7eZlsw=;
        b=WXuzyhNsgRwoEgpOM7kGDwNeSuOh0vhnTdGQo7gFoXGd2GNKdvQylnSZsFDMol7bLx
         VoM8PFQNGfbA+QAn5yY5mX5fE/jNvsQwk2KJDtvNhobKgIpyLAV5tIOpBVRBDFOc/K2o
         5N3bPYAGrDU0PMaBWAX3DYP/EqLVA51ss1Ys5irm9V3sw9EARiwxPFTlVO+FfS7Rv/3t
         l8T7UQb8lyyaVI5EEDJosvbgMLzmGjv8jsT9IbF6roJXdylKQCjkXyvUnHtaK39ov2iA
         yGsVs90pqKAlZxyRz7f3RyISsCcaRkCvIoFPLSiB/ysNQriFLpKnIguqtixqqL//sqrW
         JA+Q==
X-Gm-Message-State: ANhLgQ3ooDFQ6g7Iz40+3JVkJ/Ia84lGCB+btaLKG5soQSpmjQS+XMzt
        D9O/66CUKQ1scPq437zgPpOwksOCZjKdI0koN3UmlQ==
X-Google-Smtp-Source: ADFU+vuFs6DxW0lAL9j9/oJQCI1FKsehJ8PLZtN9yyub223KaBZWQ828I7ir6elf1GcKI0XTnDEZI4ORA3smEkvCBXQ=
X-Received: by 2002:a9d:2c64:: with SMTP id f91mr2675599otb.17.1584367009313;
 Mon, 16 Mar 2020 06:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72> <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
In-Reply-To: <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Mar 2020 14:56:38 +0100
Message-ID: <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
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

On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
>
> On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> wrote=
:
> >
> > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> > > > From: Marco Elver <elver@google.com>
> > > >
> > > > Add option to allow interrupts while a watchpoint is set up. This c=
an be
> > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > parameter 'kcsan.interrupt_watcher=3D1'.
> > > >
> > > > Note that, currently not all safe per-CPU access primitives and pat=
terns
> > > > are accounted for, which could result in false positives. For examp=
le,
> > > > asm-generic/percpu.h uses plain operations, which by default are
> > > > instrumented. On interrupts and subsequent accesses to the same
> > > > variable, KCSAN would currently report a data race with this option=
.
> > > >
> > > > Therefore, this option should currently remain disabled by default,=
 but
> > > > may be enabled for specific test scenarios.
> > > >
> > > > To avoid new warnings, changes all uses of smp_processor_id() to us=
e the
> > > > raw version (as already done in kcsan_found_watchpoint()). The exac=
t SMP
> > > > processor id is for informational purposes in the report, and
> > > > correctness is not affected.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > And I get silent hangs that bisect to this patch when running the
> > > following rcutorture command, run in the kernel source tree on a
> > > 12-hardware-thread laptop:
> > >
> > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --durati=
on 10 --kconfig "CONFIG_DEBUG_INFO=3Dy CONFIG_KCSAN=3Dy CONFIG_KCSAN_ASSUME=
_PLAIN_WRITES_ATOMIC=3Dn CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn CONFIG_K=
CSAN_REPORT_ONCE_IN_MS=3D100000 CONFIG_KCSAN_VERBOSE=3Dy CONFIG_KCSAN_INTER=
RUPT_WATCHER=3Dy" --configs TREE03
> > >
> > > It works fine on some (but not all) of the other rcutorture test
> > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common t=
hread
> > > is that these are the TREE scenarios are all PREEMPT=3Dy.  So are RUD=
E01,
> > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
> > > on Tree RCU, and thus have far less interrupt activity and the like.
> > > Given that it is an interrupt-related feature being added by this com=
mit,
> > > this seems like expected (mis)behavior.
> > >
> > > Can you reproduce this?  If not, are there any diagnostics I can add =
to
> > > my testing?  Or a diagnostic patch I could apply?
>
> I think I can reproduce it.  Let me debug some more, so far I haven't
> found anything yet.
>
> What I do know is that it's related to reporting. Turning kcsan_report
> into a noop makes the test run to completion.
>
> > I should hasten to add that this feature was quite helpful in recent wo=
rk!
>
> Good to know. :-)  We can probably keep this patch, since the default
> config doesn't turn this on. But I will try to see what's up with the
> hangs, and hopefully find a fix.

So this one turned out to be quite interesting. We can get deadlocks
if we can set up multiple watchpoints per task in case it's
interrupted and the interrupt sets up another watchpoint, and there
are many concurrent races happening; because the other_info struct in
report.c may never be released if an interrupt blocks the consumer due
to waiting for other_info to become released.
Give me another day or 2 to come up with a decent fix.

Thanks,
-- Marco
