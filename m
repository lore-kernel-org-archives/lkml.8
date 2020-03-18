Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0870C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82DE20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eq8b+myj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCRRmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37704 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgCRRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12so21154681otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fukrr76bOiZh5lh10kgVm2Vkii/yxFVJxA3G3n1k3QE=;
        b=Eq8b+myjEbR8AEjWwr2QvjY3yH+cSxJpGbsFhEzB3ix6Aw0v1AQ0uV6RTebigZqI1T
         1lw4LBHVApZX0BXs2VftlAzj6LitRquxBGk4xcsyMI/dfIchPW64iJfjsuZd+7PbLvVB
         5A3Pn6m74cWmArY5hA9IheCvZROlCReLOzVpdlTN1YiHI9YmQzarZxrj1L/gWBpdHE5D
         lXgFKscFZjLJ+nuISJktD0wkgh+t0ekSvgaaNBE1BYeA1Xx5KKnOkZUe1LAq2qMpOwGT
         fE2jg+vY7ACodyTi9iKM3OvJ/Bsd2dTU6374GQ5o5MrWMvmHPhf7snx+xr3T8UTxbDl4
         YXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fukrr76bOiZh5lh10kgVm2Vkii/yxFVJxA3G3n1k3QE=;
        b=bVIsiwNXBd5FhIWwiehEJAbDJpt+FvYs8vWvkBo3kUzODOp12+joYclC1LSqDrZp0y
         enLqd44+IzVckrINrB8VxcYahfEq5OD9VihHcJMbCD4EYDRB6xYjIIZmlqmyx97Pg2I6
         z1Z+0gmi+vdapKNwBYROE67Isz0R94xdRDkWwb0DRt3EjD661zNEN1olcXZ87/oP34Q5
         /AQ0d5L8v0bGoLH9wmwT36et+IFNYSWFZtQSiUG5lmRxW0e0g3hryS+lX/oZNIaX/QJt
         y8bMmxWClsdYbTRT5EYLMlSHq/IXxn5NsOIFnH+18o0Mlx5pPPlp2XalulH92wyRhgjT
         TyMw==
X-Gm-Message-State: ANhLgQ04lGS3mZnArdn/viNn9M+cXCXp76OL7mst13VG6q6XVyp89V3a
        UoZBVhk4yTOFENQgkzNX7RUbIn2Hh8Z1Atsxi5KH9g==
X-Google-Smtp-Source: ADFU+vvz5HQKwyRc1NM0JrJ2L/gHTKeABoAQH0o1P08sTiZoA4Tb9vSNR5uZiEciy+l9zDUUug3Lb+IstHGsy1m5jmk=
X-Received: by 2002:a9d:6d87:: with SMTP id x7mr5110501otp.233.1584553342180;
 Wed, 18 Mar 2020 10:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72> <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com> <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
In-Reply-To: <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 18 Mar 2020 18:42:10 +0100
Message-ID: <CANpmjNOyaEMPpKrfLYCCz722toZFH7YJx2Tj8wjyBxHSEMHWzQ@mail.gmail.com>
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

On Mon, 16 Mar 2020 at 14:56, Marco Elver <elver@google.com> wrote:
>
> On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> wro=
te:
> > >
> > > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> > > > > From: Marco Elver <elver@google.com>
> > > > >
> > > > > Add option to allow interrupts while a watchpoint is set up. This=
 can be
> > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > > parameter 'kcsan.interrupt_watcher=3D1'.
> > > > >
> > > > > Note that, currently not all safe per-CPU access primitives and p=
atterns
> > > > > are accounted for, which could result in false positives. For exa=
mple,
> > > > > asm-generic/percpu.h uses plain operations, which by default are
> > > > > instrumented. On interrupts and subsequent accesses to the same
> > > > > variable, KCSAN would currently report a data race with this opti=
on.
> > > > >
> > > > > Therefore, this option should currently remain disabled by defaul=
t, but
> > > > > may be enabled for specific test scenarios.
> > > > >
> > > > > To avoid new warnings, changes all uses of smp_processor_id() to =
use the
> > > > > raw version (as already done in kcsan_found_watchpoint()). The ex=
act SMP
> > > > > processor id is for informational purposes in the report, and
> > > > > correctness is not affected.
> > > > >
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > And I get silent hangs that bisect to this patch when running the
> > > > following rcutorture command, run in the kernel source tree on a
> > > > 12-hardware-thread laptop:
> > > >
> > > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --dura=
tion 10 --kconfig "CONFIG_DEBUG_INFO=3Dy CONFIG_KCSAN=3Dy CONFIG_KCSAN_ASSU=
ME_PLAIN_WRITES_ATOMIC=3Dn CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn CONFIG=
_KCSAN_REPORT_ONCE_IN_MS=3D100000 CONFIG_KCSAN_VERBOSE=3Dy CONFIG_KCSAN_INT=
ERRUPT_WATCHER=3Dy" --configs TREE03
> > > >
> > > > It works fine on some (but not all) of the other rcutorture test
> > > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common=
 thread
> > > > is that these are the TREE scenarios are all PREEMPT=3Dy.  So are R=
UDE01,
> > > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
> > > > on Tree RCU, and thus have far less interrupt activity and the like=
.
> > > > Given that it is an interrupt-related feature being added by this c=
ommit,
> > > > this seems like expected (mis)behavior.
> > > >
> > > > Can you reproduce this?  If not, are there any diagnostics I can ad=
d to
> > > > my testing?  Or a diagnostic patch I could apply?
> >
> > I think I can reproduce it.  Let me debug some more, so far I haven't
> > found anything yet.
> >
> > What I do know is that it's related to reporting. Turning kcsan_report
> > into a noop makes the test run to completion.
> >
> > > I should hasten to add that this feature was quite helpful in recent =
work!
> >
> > Good to know. :-)  We can probably keep this patch, since the default
> > config doesn't turn this on. But I will try to see what's up with the
> > hangs, and hopefully find a fix.
>
> So this one turned out to be quite interesting. We can get deadlocks
> if we can set up multiple watchpoints per task in case it's
> interrupted and the interrupt sets up another watchpoint, and there
> are many concurrent races happening; because the other_info struct in
> report.c may never be released if an interrupt blocks the consumer due
> to waiting for other_info to become released.
> Give me another day or 2 to come up with a decent fix.

The patch-series fixing this:
http://lkml.kernel.org/r/20200318173845.220793-1-elver@google.com

Please do confirm it resolves the problems in your test scenarios.

Many thanks,
-- Marco
