Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A7C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxn7awJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHJUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgHJUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:35:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F68C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:35:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so5589931pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bIRISkDDGTFXADmzCt8aRPLFkz3fsf+ngNbn9o21Dg=;
        b=gxn7awJT9+Np4VgP/fswxqwEnVeGmRiyFa3TO18lRa9adR0yPu62PZvlMG3XNvtQwq
         Mkwc1ciKjRqd2sj8jPtyTxcGIUrBr3zdjZMTqVA8n01OTZwofFP5uIr+ln8r8cpy+fou
         2ObEl8jiC0/c29dV2mKFFAVcqNESxUSMyqdudzCSfDT/2xIKbmYMsOx9piZKf4+zICS9
         MJDWAI0xzzeFTn7KKE18RY9Um0AOpWuod7fEkW6uMGLv4rgFzMiV1YDSeL88Vu4DpCsE
         oscChhZyhfFyd1qSD27ql80hQ8Gzl1Di002f59SRbEfHXLIdF1YPLqnjcFCmxK/6/kpF
         rTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bIRISkDDGTFXADmzCt8aRPLFkz3fsf+ngNbn9o21Dg=;
        b=PdFIVcm4PLhs9bOj/sHtv0YpZKzp/B7Mz4VbxKfhF3qI5h2LWpohA9ect0BocnIEVL
         PyvQ+Armfv1bgDqMSerYRKNmONUccrPEKl3jkc2g0jKwAMPi34ADJ/OX46WxB+ochqPW
         H2XXFhto8RKDXI0yj0M98jqnphTOIfW0NeaOGpoMJhDCDzbJsjRxSHfWViRFbFsnnSl4
         4OBsWXnMoKcZgoStJDsnuSRWJU90Gvoq/Al2+TMLqHUWcWzYd/aaQOncIdHUyCKeqUf8
         QEGFlaq9Cq/bDQMoUdYzS3avoahlZSzPrXya2aZFISMDZYUWMS0Pl2LGmWzjdyUffv6p
         P/0g==
X-Gm-Message-State: AOAM531Q9+czjKkWcz1YjT5XXJXD+veOwylLmV1piS2e+BCPlkxejAEq
        CG7kc7Ndh1OBCULRz4NUAsgRnY8Ju44EAGCUZW3lDg==
X-Google-Smtp-Source: ABdhPJxC2n4rFDhW9fIP7FdW5+L3038lUQLc/+oZMwG9o9fyQysucEzH8szpO8WTNuf6WmOt3EG7Igm7xxmhYHoh9hU=
X-Received: by 2002:a63:5022:: with SMTP id e34mr2477990pgb.384.1597091746854;
 Mon, 10 Aug 2020 13:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806203737.3636830-1-urielguajardojr@gmail.com> <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
In-Reply-To: <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:35:35 -0700
Message-ID: <CAFd5g46=zgY_+jawXMS+yTx6MhRGa_4-WVmer-BwoL_c2QPcrg@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:43 PM Uriel Guajardo <urielguajardo@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 3:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> >
> > From: Uriel Guajardo <urielguajardo@google.com>
> >
> > KUnit tests will now fail if lockdep detects an error during a test
> > case.
> >
> > The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> > first if lock debugging is turned on. If not, an error must have
> > occurred, so we fail the test and restart lockdep for the next test case.
> >
> > Like the locking selftests, we also fix possible preemption count
> > corruption from lock bugs.

Sorry, just noticed: You probably want to send this to some of the
lockdep maintainers or the maintainers of the kselftest for lockdep.

> > Depends on kunit: support failure from dynamic analysis tools [2]
> >
> > [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
> >
> > [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
> >
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > ---
> >  lib/kunit/test.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index d8189d827368..0838ececa005 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/sched.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/debug_locks.h>
> >
> >  #include "debugfs.h"
> >  #include "string-stream.h"
> > @@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
> >                 kunit_set_failure(current->kunit_test);
> >  }
> >
> > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > +                                           unsigned long saved_preempt_count)
> > +{
> > +       preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +       if (softirq_count())
> > +               current->softirqs_enabled = 0;
> > +       else
> > +               current->softirqs_enabled = 1;
> > +#endif
>
> I am not entirely sure why lib/locking-selftests enables/disables
> softirqs, but I suspect it has to do with the fact that preempt_count
> became corrupted, and somehow softirqs became incorrectly
> enabled/disabled as a result. The resetting of the preemption count
> will undo the enabling/disabling accordingly. Any insight on this
> would be appreciated!
>
> > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > +       local_irq_disable();
> > +       if (!debug_locks) {
> > +               kunit_set_failure(test);
> > +               lockdep_reset();
> > +       }
> > +       local_irq_enable();
> > +#endif
> > +}
> > +
> >  static void kunit_print_tap_version(void)
> >  {
> >         static bool kunit_has_printed_tap_version;
> > @@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
> >         struct kunit *test = ctx->test;
> >         struct kunit_suite *suite = ctx->suite;
> >         struct kunit_case *test_case = ctx->test_case;
> > +       unsigned long saved_preempt_count = preempt_count();
> >
> >         current->kunit_test = test;
> >
> > @@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
> >          * thread will resume control and handle any necessary clean up.
> >          */
> >         kunit_run_case_internal(test, suite, test_case);
> > -       /* This line may never be reached. */
> > +       /* These lines may never be reached. */
> > +       kunit_check_locking_bugs(test, saved_preempt_count);
> >         kunit_run_case_cleanup(test, suite);
> >  }
> >
> > --
> > 2.28.0.236.gb10cc79966-goog
> >
