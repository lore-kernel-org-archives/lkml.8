Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC4C20855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRtZjwsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMQoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:44:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42708C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:44:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h22so5285779otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNwmqUN3Din5AgMfA1AowncGpfCWRIbdPZGgEuOM99E=;
        b=pRtZjwsx+5/KVqFxJWePajQmYIyHgL6S0sTKx98vTTlEc6nuAzNuDJzQiUT2qBWlnX
         bVi8wWYLpJ3RJo0i+ik8F0vMUkcpA7YPN3JYJ4R0CYsE6IJ1vJPAvirCMwnARb5S90cw
         D4S/+hSUKfBK9wwPkqll06RaOMB/yRVHUP7P5Eq4fOQj4To7NrS0V1NnF6wHTEtNvBwC
         tBpj1IbE9ZOcYtw0yY8f3bX+7Fi2kNr/jobwA/G63gUeFyRxVyTjDue3bNStAPEEoZjV
         UTo1JBm6XJLWeaCeioylAnwFIFS0sGyDfqUhsXyS7kPFpBMAac9+czLrPIzlKDlNshoA
         qr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNwmqUN3Din5AgMfA1AowncGpfCWRIbdPZGgEuOM99E=;
        b=Amr8AZJ1HO6T+SDWHiBTgeP6FJ4jE1e9JdML/BdMWmF+78k45LmD4jKeGxJZJuh5PL
         ojamVATbbGSwk0Ld5rFrbWbUzuVqH9A9KlhMtyWeM9r6Qx2pSFimveGVuONNlXGzVEOn
         yxAxhOIdp7Dx2+dDGUOGOMTPkqNmLWWIBsTBol+n5RVgEnErEsFHZBdc+EqKSr6c8w1W
         e3lhQXpA9T86Z/A2KZun6VaZLsa1DTrr5TArudkLQpu0KtXEZyCmQaqXS2uYOE3iS9Wj
         K9D6WsY4ahOr4Om7YBezzayau+ENcywyQUAmyJcJetjC/DsLkv/e9j+SVMtCdzSFnEyY
         Ns4w==
X-Gm-Message-State: AOAM5315wyGQqgxdeo6kuESP9zcRyNrt87bT4vaKOh8qGvWUICeMHGKD
        J3VkX5KdNyn0BBPM1t+6VKxxZ29DLmDkT47ZZmlcLQ==
X-Google-Smtp-Source: ABdhPJxOtYgFe3w+gHdVpjtCqB9psV+KWvCtDeEoRZ6Kn+fo/IF9Og9Cac8DASPkZ7ePLtccRtB0Da2uZI7oY855YnM=
X-Received: by 2002:a9d:450a:: with SMTP id w10mr5144123ote.327.1597337055153;
 Thu, 13 Aug 2020 09:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200812193332.954395-1-urielguajardojr@gmail.com> <alpine.LRH.2.21.2008130925460.4960@localhost>
In-Reply-To: <alpine.LRH.2.21.2008130925460.4960@localhost>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 13 Aug 2020 11:44:03 -0500
Message-ID: <CAG30Eee1iufdzPHVDSLSS2Dxu6osnrtP70Bq4OEj4UsgeLj=Wg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: added lockdep support
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 4:11 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Wed, 12 Aug 2020, Uriel Guajardo wrote:
>
> > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > turns itself off after its first failure, only fail the first test and
> > warn users to not expect any future failures from lockdep.
> >
> > Similar to lib/locking-selftest [1], we check if the status of
> > debug_locks has changed after the execution of a test case. However, we
> > do not reset lockdep afterwards.
> >
> > Like the locking selftests, we also fix possible preemption count
> > corruption from lock bugs.
> >
> > Depends on kunit: support failure from dynamic analysis tools [2]
> >
> > [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
> >
> > [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > ---
> > v2 Changes:
> > - Removed lockdep_reset
> >
> > - Added warning to users about lockdep shutting off
> > ---
> >  lib/kunit/test.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index d8189d827368..7e477482457b 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched.h>
> > +#include <linux/debug_locks.h>
> >
> >  #include "debugfs.h"
> >  #include "string-stream.h"
> > @@ -22,6 +23,26 @@ void kunit_fail_current_test(void)
> >               kunit_set_failure(current->kunit_test);
> >  }
> >
> > +static void kunit_check_locking_bugs(struct kunit *test,
> > +                                  unsigned long saved_preempt_count,
> > +                                  bool saved_debug_locks)
> > +{
> > +     preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
> > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > +     if (saved_debug_locks && !debug_locks) {
> > +             kunit_set_failure(test);
> > +             kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +             kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +     }
> > +#endif
> > +}
>
> Nit: I could be wrong but the general approach for this sort of
> feature is to do conditional compilation combined with "static inline"
> definitions to handle the case where the feature isn't enabled.
> Could we tidy this up a bit and haul this stuff out into a
> conditionally-compiled (if CONFIG_LOCKDEP) kunit lockdep.c file?

Sure! Apologies if this isn't convention.

> Then in kunit's lockdep.h we'd have
>
> struct kunit_lockdep {
>         int preempt_count;
>         bool debug_locks;
> };
>
> #if IS_ENABLED(CONFIG_LOCKDEP)
> void kunit_test_init_lockdep(struct kunit_test *test, struct
>                              kunit_lockdep *lockdep);
> void kunit_test_check_lockdep(struct kunit_test *test,
>                               struct kunit_lockdep *lockdep);
> #else
> static inline void kunit_init_lockdep(struct kunit_test *test,
>                                       struct kunit_lockdep *lockdep) { }
> static inline void kunit_check_lockdep(struct kunit_test *test,
>                                        struct kunit_lockdep *lockdep) { }
> #endif
>
>
> The test execution code could then call
>
>         struct kunit_lockdep lockdep;
>
>         kunit_test_init_lockdep(test, &lockdep);
>
>         kunit_test_check_lockdep(test, &lockdep);
>

Thanks for these helpful tips. I agree that it'll be cleaner this way.
I'll implement this in the next version of the patch.

> If that approach makes sense, we could go a bit further
> and we might benefit from a bit more generalization
> here.  _If_ the pattern of needing pre- and post- test
> actions is sustained across multiple analysis tools,
> could we add generic hooks for this? That would allow any
> additional dynamic analysis tools to utilize them.  So

I think this is a great idea. Right now I'm a little hesitant to
generalize beyond lockdep, since most analysis tools I've seen don't
seem to require this. For most tools, they fail, they report to KUnit,
then they continue working without us needing to clean state. Perhaps
the generic hooks could prove useful in other ways that I'm not
considering..

In any case, I will go ahead and work on the lockdep-specific hook for
KUnit. If you or anyone else thinks it could be useful in other ways
in the future, we can make it generic!

> kunit_try_run_case() would then cycle through the registered
> pre- hooks prior to running the case and post- hooks after,
> failing if any of the latter returned a failure value.
>
> I'm thinking something like
>
>   kunit_register_external_test("lockdep", lockdep_pre, lockdep_post,
>                                &kunit_lockdep);
>
> (or we could define a kunit_external_test struct for
> better extensibility).
>
> A void * would be passed to pre/post, in this case it'd
> be a pointer to a struct containing the saved preempt
> count/debug locks, and the registration could be called during
> kunit initialization.  This doesn't need to be done with your
> change of course but I wanted to float the idea as in addition
> to uncluttering the test case execution code, it might allow
> us to build facilities on top of that generic tool support for
> situations like "I'd like to see if the test passes absent
> any lockdep issues, so I'd like to disable lockdep-based failure".
> Such situations are more likely to arise in a world where
> kunit+tests are built as modules and run multiple times within
> a single system boot admittedly, but worth considering I think.

Interesting!

>
> For that we'd need a way to select which dynamic tools kunit
> enables(kernel/module parameters or debugfs could do
> this), but a generic approach might help that sort of thing.
>
> An external test under this model wouldn't have to necessarily
> be external to the area under test; the general criteria for
> such things would be "something I want to track across multiple
> test case execution".
>
> Again I'm not trying to put you on the hook for any of
> the above suggestions (having lockdep support like this is
> fantastic!), but I think it'd be good to see if there's a
> pattern here we could potentially exploit in other use cases.

No worries, thanks for putting these suggestions out there.

>
> Thanks!
>
> Alan
