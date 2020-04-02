Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16892C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94A220787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGejEdLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbgDBQky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:40:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45086 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbgDBQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:40:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id t4so1524639plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FzclJGrxe0sBGhzxk/JNHh6pg2AnQtz+q6DvHj5q10=;
        b=kGejEdLzNpc24fti4HltAQ/UUqwdImGBZGpAeqjfU6/b1r6RpggRFDrw7QBmH0FrHG
         QEGBJIDSzU9Umdda3H1udEJsEGpfU4Kw4NMrEIlR3Ru2z05wOdqAFnF/DsoVTw7L1RyU
         6uh3lBktbic+tvfuEb1VxOh5hsvI6vrIArWfgf1tMlrs6n/4LTvnU2SyxxK3U1maKywS
         hmcn8XzKX0vXhXSJd1CtapoMbKMPBp2TAaoGxkYnK3HQN5z9IzYftortvEAHj/KraDw9
         N8eZQkwDal7RoSRzQVYPfwA4xO0f2vE8o5O+kU5EIk2UVF3mQoHkvdCOqks5u1JDgApl
         WiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FzclJGrxe0sBGhzxk/JNHh6pg2AnQtz+q6DvHj5q10=;
        b=LFci3RlLZo57z+JBhf0yoPPM0vb7XdhIh7WiQCJVVZDraTh7qwdpt0bddkLoARMwl+
         dV/TBatE/Aenlwyf+6j3Uv7WOb2rXzQOvHOgq5AlcrJugqxYIVuRWRO58qOxfBHD+pPS
         Vo8i5HlUyVGqyzdU0rWM8OoKyoGTUUTrY7kAoeK8ZU3lu1HtsUGOyhzPp7JKvfyN/LzQ
         BLkFy1oRutV3R3wjHUioX60bcQlKplMzXL/K2ympZl9yg/dINTKSYZRumLMO7jonUAgr
         Q+zFazzaEw7Br8HS+oMzyrp5BFV9nJ/vrCUWcmk9brOL9pf71Z5M/cVN90HvqZBf1RUe
         iAmA==
X-Gm-Message-State: AGi0PuZYFNlci72x+FicxBVujCvD6vbE4sVyxlQVjJf8DZcYGuH1ORuZ
        VK94ibBEzwEE0KJM6vKeYM2wPikaFtbRZRzH+V9Mow==
X-Google-Smtp-Source: APiQypIsJx+kKXTfBgQruZHx3rFZniXMgkzYYwn+JN5ftWgJsJZBGwaTOgJ/tBeXqB92eQw3Oc+EXUy8cOPI0CaPrlE=
X-Received: by 2002:a17:90b:1985:: with SMTP id mv5mr4787168pjb.69.1585845652159;
 Thu, 02 Apr 2020 09:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
 <20200401180907.202604-2-trishalfonso@google.com> <CAAeHK+zwshOOfnS3QNRcysF+KbTVK6=9yavj18GFkGF1tw0X4g@mail.gmail.com>
 <CAKFsvU+Ro2zazrd_BdLsn4z6JAR4rmvn5pHkNTw=CvWFMjseFQ@mail.gmail.com>
In-Reply-To: <CAKFsvU+Ro2zazrd_BdLsn4z6JAR4rmvn5pHkNTw=CvWFMjseFQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 Apr 2020 18:40:40 +0200
Message-ID: <CAAeHK+zWEPvALVhZWfs0vfWHeyfWv9tv_OGArnfVG4UMRk3ucQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 6:37 PM Patricia Alfonso <trishalfonso@google.com> wrote:
>
> On Thu, Apr 2, 2020 at 8:54 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Apr 1, 2020 at 8:09 PM 'Patricia Alfonso' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > >
> > > Integrate KASAN into KUnit testing framework.
> > >         - Fail tests when KASAN reports an error that is not expected
> > >         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> > >         - Expected KASAN reports pass tests and are still printed when run
> > >         without kunit_tool (kunit_tool still bypasses the report due to the
> > >         test passing)
> > >         - KUnit struct in current task used to keep track of the current test
> > >         from KASAN code
> > >
> > > Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
> > > kunit_resource API beyond allocated resources" and "[PATCH v3
> > > kunit-next 2/2] kunit: add support for named resources" from Alan
> > > Maguire [1]
> > >         - A named resource is added to a test when a KASAN report is
> > >          expected
> > >         - This resource contains a struct for kasan_data containing
> > >         booleans representing if a KASAN report is expected and if a
> > >         KASAN report is found
> > >
> > > [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)
> > >
> > > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> > > ---
> > >  include/kunit/test.h  |  5 +++++
> > >  include/linux/kasan.h |  6 ++++++
> > >  lib/kunit/test.c      | 13 ++++++++-----
> > >  lib/test_kasan.c      | 37 +++++++++++++++++++++++++++++++++++++
> > >  mm/kasan/report.c     | 33 +++++++++++++++++++++++++++++++++
> > >  5 files changed, 89 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index ac59d18e6bab..1dc3d118f64b 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -225,6 +225,11 @@ struct kunit {
> > >         struct list_head resources; /* Protected by lock. */
> > >  };
> > >
> > > +static inline void kunit_set_failure(struct kunit *test)
> > > +{
> > > +       WRITE_ONCE(test->success, false);
> > > +}
> > > +
> > >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > >
> > >  int kunit_run_tests(struct kunit_suite *suite);
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index 5cde9e7c2664..148eaef3e003 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -14,6 +14,12 @@ struct task_struct;
> > >  #include <asm/kasan.h>
> > >  #include <asm/pgtable.h>
> > >
> > > +/* kasan_data struct is used in KUnit tests for KASAN expected failures */
> > > +struct kunit_kasan_expectation {
> > > +       bool report_expected;
> > > +       bool report_found;
> > > +};
> > > +
> > >  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> > >  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> > >  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index 2cb7c6220a00..030a3281591e 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -10,16 +10,12 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/kref.h>
> > >  #include <linux/sched/debug.h>
> > > +#include <linux/sched.h>
> > >
> > >  #include "debugfs.h"
> > >  #include "string-stream.h"
> > >  #include "try-catch-impl.h"
> > >
> > > -static void kunit_set_failure(struct kunit *test)
> > > -{
> > > -       WRITE_ONCE(test->success, false);
> > > -}
> > > -
> > >  static void kunit_print_tap_version(void)
> > >  {
> > >         static bool kunit_has_printed_tap_version;
> > > @@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
> > >         struct kunit_suite *suite = ctx->suite;
> > >         struct kunit_case *test_case = ctx->test_case;
> > >
> > > +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> > > +       current->kunit_test = test;
> > > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> > > +
> > >         /*
> > >          * kunit_run_case_internal may encounter a fatal error; if it does,
> > >          * abort will be called, this thread will exit, and finally the parent
> > > @@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
> > >                 spin_unlock(&test->lock);
> > >                 kunit_remove_resource(test, res);
> > >         }
> > > +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> > > +       current->kunit_test = NULL;
> > > +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
> > >  }
> > >  EXPORT_SYMBOL_GPL(kunit_cleanup);
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index 3872d250ed2c..cf73c6bee81b 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -23,6 +23,43 @@
> > >
> > >  #include <asm/page.h>
> > >
> > > +#include <kunit/test.h>
> > > +
> > > +struct kunit_resource resource;
> > > +struct kunit_kasan_expectation fail_data;
> > > +
> > > +#define KUNIT_SET_KASAN_DATA(test) do { \
> > > +       fail_data.report_expected = true; \
> > > +       fail_data.report_found = false; \
> > > +       kunit_add_named_resource(test, \
> > > +                               NULL, \
> > > +                               NULL, \
> > > +                               &resource, \
> > > +                               "kasan_data", &fail_data); \
> > > +} while (0)
> > > +
> > > +#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
> > > +       struct kunit_resource *resource; \
> > > +       struct kunit_kasan_expectation *kasan_data; \
> > > +       condition; \
> > > +       resource = kunit_find_named_resource(test, "kasan_data"); \
> > > +       kasan_data = resource->data; \
> > > +       KUNIT_EXPECT_EQ(test, \
> > > +                       kasan_data->report_expected, \
> > > +                       kasan_data->report_found); \
> > > +       kunit_put_resource(resource); \
> > > +} while (0)
> > > +
> > > +/**
> > > + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> > > + * not cause a KASAN error.
> > > + *
> > > + */
> > > +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> > > +       KUNIT_SET_KASAN_DATA(test); \
> > > +       KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
> > > +} while (0)
> >
> > Any reason to split this macro into two parts? Do we call any of them
> > separately?
> >
> They are not called anywhere else... honestly, it was just a style
> choice to make it clear that there are 2 parts to the expectation. I
> don't think they have to be split if there's enough reason to smash
> them together.

I think squashing them together will look cleaner.

>
> > > +
> > >  /*
> > >   * Note: test functions are marked noinline so that their names appear in
> > >   * reports.
> > > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > > index 5ef9f24f566b..87330ef3a99a 100644
> > > --- a/mm/kasan/report.c
> > > +++ b/mm/kasan/report.c
> > > @@ -32,6 +32,8 @@
> > >
> > >  #include <asm/sections.h>
> > >
> > > +#include <kunit/test.h>
> > > +
> > >  #include "kasan.h"
> > >  #include "../slab.h"
> > >
> > > @@ -455,12 +457,38 @@ static bool report_enabled(void)
> > >         return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_KUNIT)
> > > +void kasan_update_kunit_status(struct kunit *cur_test)
> > > +{
> > > +       struct kunit_resource *resource;
> > > +       struct kunit_kasan_expectation *kasan_data;
> > > +
> > > +       if (kunit_find_named_resource(cur_test, "kasan_data")) {
> > > +               resource = kunit_find_named_resource(cur_test, "kasan_data");
> > > +               kasan_data = resource->data;
> > > +               kasan_data->report_found = true;
> > > +
> > > +               if (!kasan_data->report_expected)
> > > +                       kunit_set_failure(current->kunit_test);
> >
> > Hm, we only call KUNIT_SET_KASAN_DATA() for KASAN tests that we expect
> > to fail AFAICS. Then we end up calling kunit_set_failure twice, once
> > here and the other time when we do KUNIT_EXPECT_EQ() in
> > KUNIT_DO_EXPECT_KASAN_FAIL(). Or maybe there's something I
> > misunderstand.
> >
>
> You are right. I didn't realize, but yes. If the report_expected is
> false, KUNIT_DO_EXPECT_KASAN_FAIL() will set the test failure in
> KUNIT_EXPECT_EQ(). I think this is just leftover logic from before I
> thought to use KUNIT_EXPECT_EQ().
>
> > > +               else
> > > +                       return;
> >
> > Nit: "else return;" can be dropped.
> >
> > You can actually reorder the code a bit to make it easier to read:
> >
> > if (!kunit_find_named_resource(cur_test, "kasan_data")) {
> >   kunit_set_failure(current->kunit_test);
> >   return;
> > }
> > // here comes kasan tests checks
> >
>
> I agree. This looks much cleaner. The thing to note is that anyone can
> add a named resource to a test. I doubt anyone will name their
> resource "kasan_data" outside of this file, but it may be worth adding
> a comment advising against it.
>
> >
> >
> >
> >
> > > +       } else
> > > +               kunit_set_failure(current->kunit_test);
> > > +}
> > > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > > +
> > >  void kasan_report_invalid_free(void *object, unsigned long ip)
> > >  {
> > >         unsigned long flags;
> > >         u8 tag = get_tag(object);
> > >
> > >         object = reset_tag(object);
> > > +
> > > +#if IS_ENABLED(CONFIG_KUNIT)
> > > +       if (current->kunit_test)
> > > +               kasan_update_kunit_status(current->kunit_test);
> > > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > > +
> > >         start_report(&flags);
> > >         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
> > >         print_tags(tag, object);
> > > @@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
> > >         if (likely(!report_enabled()))
> > >                 return;
> > >
> > > +#if IS_ENABLED(CONFIG_KUNIT)
> > > +       if (current->kunit_test)
> > > +               kasan_update_kunit_status(current->kunit_test);
> > > +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> > > +
> > >         disable_trace_on_warning();
> > >
> > >         tagged_addr = (void *)addr;
> > > --
>
> Thanks for the comments!
>
> Best,
> Patricia
