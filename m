Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7553C207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iq6iNDbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgG2W5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG2W5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:57:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD0C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:57:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so23127653wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8b8qAqV8mqmEXP+yiynnGsxHiDwmHCU219yrWhjnYM=;
        b=Iq6iNDbuIjRQv1qjfDLpHhq89DsYEogu+Z4T/Bbvg2J0VVqKPfANVmN7t/Hkb8n540
         GpTOFbCxbGmeGm8r+745UnIZnGgerJKHBaCE+oKmCa/XGU34jeD/BaFrUKIRBqSc4+YY
         SJ63cNQnOpSzD8d3cG4Dne180zpQwVzSCiHXWbvM2IXtBZ4rYY/04WQriyfbWQEPDDid
         TDOjD3iQ8Tx9k3hOPcGtU1gnJtlnNdakWwOvH/yQV2NJHUSoujwGeV9StdmkVItWhCMP
         OCu2L4JIND4//1d7zRDQ3P4V/okAZgp6ZyBvuYfB6jD4zjps9sReHXOGEsb2N/CNIlAv
         m/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8b8qAqV8mqmEXP+yiynnGsxHiDwmHCU219yrWhjnYM=;
        b=XG8DWKOpYF9vtcSbvdWDPThP6C0s7ybDENnFOZjWn5hxyiV3Eb0vrqVG4tXZQIPxJw
         1p2zrVa2/3S6RjfZ3IgA1fW/8zt63GJijvRYIIl2oiEOklc9GG0aD2OEwNjKkovzPeoA
         a252hw7CRfWClmkVqDuT2erUDAcaEjf6tfZ808tj1EOYt5sSJxFb92NUkV08NQifmX4N
         EZoGdmVKC+zpahKpxulW5ws+tLSfGjT7NJiqG2cIdGsMW8jvD3yZqHzIP9NbngBEhbGM
         6vMUSNg/GaVu8DxBCxMZ2aWMcfszgjJcaN/0dN1CwHF3gopelccNJ66VJP5v8PZZQ9zF
         701w==
X-Gm-Message-State: AOAM532Txzma1P/uDEyHM5XhoyBrGDINbIA9MvvdDwOgCTc62TIlAZ+Z
        hmb8HWuaCfpQh99i9Lmhq1tgbhtaPsGkt+HLcdQWMQ==
X-Google-Smtp-Source: ABdhPJzJt7Qzo3MeHpzcKyozU4OTEzCtsgjsvz++0P66kmni11XfkG34xRV1U5/8E1taaRrSlNx8fhodKsBRg81vkOY=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr34374615wro.271.1596063427581;
 Wed, 29 Jul 2020 15:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org>
In-Reply-To: <20200729201146.537433-1-vitor@massaru.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jul 2020 15:56:55 -0700
Message-ID: <CAP-5=fWCMPyBYqn4p+_=Ra5_sXqUbr4h_OCuYS4iY-6fsnevvA@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, brendanhiggins@google.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 1:11 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_min_heap,
> from `lib/test_min_heap.c` to KUnit tests.
>
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Thanks for this, I'm a fan of testing frameworks :-)

> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  lib/Kconfig.debug                         |  29 ++++--
>  lib/Makefile                              |   2 +-
>  lib/{test_min_heap.c => min_heap_kunit.c} | 117 ++++++++++++----------
>  3 files changed, 83 insertions(+), 65 deletions(-)
>  rename lib/{test_min_heap.c => min_heap_kunit.c} (60%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..46674fc4972c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1864,16 +1864,6 @@ config TEST_LIST_SORT
>
>           If unsure, say N.
>
> -config TEST_MIN_HEAP
> -       tristate "Min heap test"
> -       depends on DEBUG_KERNEL || m
> -       help
> -         Enable this to turn on min heap function tests. This test is
> -         executed only once during system boot (so affects only boot time),
> -         or at module load time.
> -
> -         If unsure, say N.
> -
>  config TEST_SORT
>         tristate "Array-based sort test"
>         depends on DEBUG_KERNEL || m
> @@ -2185,6 +2175,25 @@ config LINEAR_RANGES_TEST
>
>           If unsure, say N.
>
> +config MIN_HEAP_KUNIT
> +        tristate "KUnit test for Min heap"
> +        depends on KUNIT
> +        depends on DEBUG_KERNEL || m
> +        help
> +          Enable this to turn on min heap function tests. This test is
> +          executed only once during system boot (so affects only boot time),
> +          or at module load time.
> +
> +          KUnit tests run during boot and output the results to the debug log
> +          in TAP format (http://testanything.org/). Only useful for kernel devs
> +          running the KUnit test harness, and not intended for inclusion into a
> +          production build.
> +
> +          For more information on KUnit and unit tests in general please refer
> +          to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +          If unsure, say N.
> +

It's a shame we need a config option for this. Could we have one
option to cover all basic library tests?

>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index b1c42c10073b..748f57063160 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -72,7 +72,6 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> -obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
>  obj-$(CONFIG_TEST_LKM) += test_module.o
>  obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
>  obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
> @@ -318,3 +317,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> +obj-$(CONFIG_MIN_HEAP_KUNIT) += min_heap_kunit.o
> diff --git a/lib/test_min_heap.c b/lib/min_heap_kunit.c
> similarity index 60%
> rename from lib/test_min_heap.c
> rename to lib/min_heap_kunit.c
> index d19c8080fd4d..398db1c63146 100644
> --- a/lib/test_min_heap.c
> +++ b/lib/min_heap_kunit.c
> @@ -7,9 +7,8 @@
>
>  #include <linux/log2.h>
>  #include <linux/min_heap.h>
> -#include <linux/module.h>
> -#include <linux/printk.h>
>  #include <linux/random.h>
> +#include <kunit/test.h>
>
>  static __init bool less_than(const void *lhs, const void *rhs)
>  {
> @@ -29,37 +28,34 @@ static __init void swap_ints(void *lhs, void *rhs)
>         *(int *)rhs = temp;
>  }
>
> -static __init int pop_verify_heap(bool min_heap,
> +static __init void pop_verify_heap(struct kunit *context,
> +                               bool min_heap,
>                                 struct min_heap *heap,
>                                 const struct min_heap_callbacks *funcs)
>  {
>         int *values = heap->data;
> -       int err = 0;
>         int last;
>
>         last = values[0];
>         min_heap_pop(heap, funcs);
>         while (heap->nr > 0) {
>                 if (min_heap) {
> -                       if (last > values[0]) {
> -                               pr_err("error: expected %d <= %d\n", last,
> -                                       values[0]);
> -                               err++;
> -                       }
> +                       KUNIT_EXPECT_FALSE_MSG(context,
> +                                              last > values[0],
> +                                              "expected %d <= %d\n",
> +                                              last, values[0]);

I'm not familiar with kunit, is there a reason not to prefer:
KUNIT_EXPECT_LT(context, last, values[0]);

>                 } else {
> -                       if (last < values[0]) {
> -                               pr_err("error: expected %d >= %d\n", last,
> -                                       values[0]);
> -                               err++;
> -                       }
> +                       KUNIT_EXPECT_FALSE_MSG(context,
> +                                              last < values[0],
> +                                              "expected %d >= %d\n",
> +                                              last, values[0]);

Similarly KUNIT_EXPECT_GT.

Thanks,
Ian

>                 }
>                 last = values[0];
>                 min_heap_pop(heap, funcs);
>         }
> -       return err;
>  }
>
> -static __init int test_heapify_all(bool min_heap)
> +static __init void test_heapify_all(struct kunit *context, bool min_heap)
>  {
>         int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
>                          -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
> @@ -73,12 +69,11 @@ static __init int test_heapify_all(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, err;
> +       int i;
>
>         /* Test with known set of values. */
>         min_heapify_all(&heap, &funcs);
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> -
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         /* Test with randomly generated values. */
>         heap.nr = ARRAY_SIZE(values);
> @@ -86,12 +81,10 @@ static __init int test_heapify_all(bool min_heap)
>                 values[i] = get_random_int();
>
>         min_heapify_all(&heap, &funcs);
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_push(bool min_heap)
> +static __init void test_heap_push(struct kunit *context, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -106,25 +99,22 @@ static __init int test_heap_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Test with known set of values copied from data. */
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_push(&heap, &data[i], &funcs);
> -
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         /* Test with randomly generated values. */
>         while (heap.nr < heap.size) {
>                 temp = get_random_int();
>                 min_heap_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> -
> -       return err;
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>  }
>
> -static __init int test_heap_pop_push(bool min_heap)
> +static __init void test_heap_pop_push(struct kunit *context, bool min_heap)
>  {
>         const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
>                              -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
> @@ -139,7 +129,7 @@ static __init int test_heap_pop_push(bool min_heap)
>                 .less = min_heap ? less_than : greater_than,
>                 .swp = swap_ints,
>         };
> -       int i, temp, err;
> +       int i, temp;
>
>         /* Fill values with data to pop and replace. */
>         temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
> @@ -149,8 +139,7 @@ static __init int test_heap_pop_push(bool min_heap)
>         /* Test with known set of values copied from data. */
>         for (i = 0; i < ARRAY_SIZE(data); i++)
>                 min_heap_pop_push(&heap, &data[i], &funcs);
> -
> -       err = pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
>
>         heap.nr = 0;
>         for (i = 0; i < ARRAY_SIZE(data); i++)
> @@ -161,34 +150,54 @@ static __init int test_heap_pop_push(bool min_heap)
>                 temp = get_random_int();
>                 min_heap_pop_push(&heap, &temp, &funcs);
>         }
> -       err += pop_verify_heap(min_heap, &heap, &funcs);
> +       pop_verify_heap(context, min_heap, &heap, &funcs);
> +}
>
> -       return err;
> +static void __init test_heapify_all_true(struct kunit *context)
> +{
> +       test_heapify_all(context, true);
>  }
>
> -static int __init test_min_heap_init(void)
> +static void __init test_heapify_all_false(struct kunit *context)
>  {
> -       int err = 0;
> -
> -       err += test_heapify_all(true);
> -       err += test_heapify_all(false);
> -       err += test_heap_push(true);
> -       err += test_heap_push(false);
> -       err += test_heap_pop_push(true);
> -       err += test_heap_pop_push(false);
> -       if (err) {
> -               pr_err("test failed with %d errors\n", err);
> -               return -EINVAL;
> -       }
> -       pr_info("test passed\n");
> -       return 0;
> +       test_heapify_all(context, true);
> +}
> +
> +static void __init test_heap_push_true(struct kunit *context)
> +{
> +       test_heap_push(context, true);
> +}
> +
> +static void __init test_heap_push_false(struct kunit *context)
> +{
> +       test_heap_push(context, false);
>  }
> -module_init(test_min_heap_init);
>
> -static void __exit test_min_heap_exit(void)
> +static void __init test_heap_pop_push_true(struct kunit *context)
>  {
> -       /* do nothing */
> +       test_heap_pop_push(context, true);
>  }
> -module_exit(test_min_heap_exit);
> +
> +static void __init test_heap_pop_push_false(struct kunit *context)
> +{
> +       test_heap_pop_push(context, false);
> +}
> +
> +static struct kunit_case __refdata min_heap_test_cases[] = {
> +       KUNIT_CASE(test_heapify_all_true),
> +       KUNIT_CASE(test_heapify_all_false),
> +       KUNIT_CASE(test_heap_push_true),
> +       KUNIT_CASE(test_heap_push_false),
> +       KUNIT_CASE(test_heap_pop_push_true),
> +       KUNIT_CASE(test_heap_pop_push_false),
> +       {}
> +};
> +
> +static struct kunit_suite min_heap_test_suite = {
> +       .name = "min-heap",
> +       .test_cases = min_heap_test_cases,
> +};
> +
> +kunit_test_suites(&min_heap_test_suite);
>
>  MODULE_LICENSE("GPL");
>
> base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
> --
> 2.26.2
>
