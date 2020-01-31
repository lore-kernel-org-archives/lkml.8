Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB53C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83FF2464B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+S/ueOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgAaAO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:14:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgAaAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:14:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so2497948pgk.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJvpOzkSpH5moLMAnd53cwYtElWV0Wkl0w3s6oAjBVU=;
        b=L+S/ueOtjfv2Ymm0gPx2DY1HXf1cp2Ug76fzCuPUD+sUf8KeQ8DRSZ8unLZpHDsz1w
         FhRMIjiXUHuMT1p5sHS5RbYZUQKjXaLsfFZnVsOB1Gdz19ZxoOjOaaGgNc+hqXXHljCB
         vfSh92we7dPJGj5mBTKBpxNQp2NXQ/w9fEbtmoMVfDhIkbGazxEHCxEpbTCuWfVNxwsy
         CAXt2Fl/LOtCRB39zmQ3bD986Eu+J3PYYfII6Sb5oI33YL6Bqb+g7D8IvajSQzHyc9og
         pyWkkeY53A50faLjhcWOUu5ulFNKXLF/OEmv0x9E0h0ho7csMWavoAbY70VHDRitUltu
         IZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJvpOzkSpH5moLMAnd53cwYtElWV0Wkl0w3s6oAjBVU=;
        b=O47980GRY9090hUVSdM5aKdGG3iSjHWy18dQsSlnq6aYpeoFa66EB3DgbXiPAr94kg
         rV5k3ePSGMtUPgkJcLtGV4sNrgZZBIcuZbZUQRYbNIk+bN8SNc0wJTsDNMIn5HcppRm7
         3RyN1qCG/nX43PIQ3XfJFsM55dgfPV7Jg8yYMHE/9VwZ2BafkiX3f+EJgRnoY6UjWHe6
         nj+V8XKN8+QpsE5ZKRxWHMFGwHkI8iYd0IVLqg3rU2dcDhqNUQ3xYiAqRPOlP+TkBgi6
         AqFIW/8Eyo0mQNaRvWlrYvN0PumY+9oeeSx3++sfDSOfwwAW9CBIal2X1BBoqRI4kHdg
         6NUw==
X-Gm-Message-State: APjAAAXmnm3u/r7SkvDgG9lGBSXVIMwMG/roXN+zNBJu+JIIZAokoKTg
        2ifEF9+gZqtSdKaorc+BvFffqa4MvSGc0LJ/r1GThg==
X-Google-Smtp-Source: APXvYqzyDCxkNQI+bHVR6vZlIJkiVNXzGV5PEGQtDMuBxbo02R8a96u6N76V6GsDy921MAG//VFQu/jBjGswVp/Z0oQ=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr7709129pfg.23.1580429696504;
 Thu, 30 Jan 2020 16:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20200128085742.14566-1-sjpark@amazon.com> <20200128090127.16063-1-sjpark@amazon.com>
In-Reply-To: <20200128090127.16063-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 16:14:45 -0800
Message-ID: <CAFd5g47R_Cma_fi_rA1_9+Ns0dQPFRJ=zy9kq5vuMOGdzPHNKw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mm/damon: Add kunit tests
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 1:01 AM <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds kunit based unit tests for DAMON.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  MAINTAINERS     |   1 +
>  mm/Kconfig      |  11 +
>  mm/damon-test.h | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/damon.c      |   2 +
>  4 files changed, 585 insertions(+)
>  create mode 100644 mm/damon-test.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c8a0c4e69b8..cb091bee16c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4616,6 +4616,7 @@ M:        SeongJae Park <sjpark@amazon.de>
>  L:     linux-mm@kvack.org
>  S:     Maintained
>  F:     mm/damon.c
> +F:     mm/damon-test.h
>  F:     tools/damon/*
>  F:     Documentation/admin-guide/mm/data_access_monitor.rst
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 144fb916aa8b..8b34711c6ee1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -751,4 +751,15 @@ config DAMON
>           be 1) accurate enough to be useful for performance-centric domains,
>           and 2) sufficiently light-weight so that it can be applied online.
>
> +config DAMON_KUNIT_TEST
> +       bool "Test for damon"
> +       depends on DAMON && KUNIT
> +       help
> +         This builds the DAMON Kunit test suite.
> +
> +         For more information on KUnit and unit tests in general, please refer
> +         to the KUnit documentation.
> +
> +         If unsure, say N.
> +
>  endmenu
> diff --git a/mm/damon-test.h b/mm/damon-test.h
> new file mode 100644
> index 000000000000..3d92548058a7
> --- /dev/null
> +++ b/mm/damon-test.h
[...]
> +/*
> + * Test damon_three_regions_in_vmas() function
> + *
> + * DAMON converts the complex and dynamic memory mappings of each target task
> + * to three discontiguous regions which cover every mapped areas.  The two gaps
> + * between the areas is two biggest unmapped areas in the original mapping.
> + * 'damon_three_regions_in_vmas() receives an address space of a process.  It
> + * first identifies the start of mappings, end of mappings, and the two biggest
> + * unmapped areas.  After that, based on the information, it constructs the
> + * three regions and returns.  For more detail, refer to the comment of
> + * 'damon_init_regions_of()' function definition in 'mm/damon.c' file.
> + *
> + * For example, suppose virtual address ranges of 10-20, 20-25, 200-210,
> + * 210-220, 300-305, and 307-330 (Other comments represent this mappings in
> + * more short form: 10-20-25, 200-210-220, 300-305, 307-330) of a process are
> + * mapped.  To cover every mappings, the three regions should start with 10,
> + * and end with 305.

Why? What's special about those numbers? Don't you need 10 to 330 to
cover all the mappings?

> The process also has three unmapped areas, 25-200,
> + * 220-300, and 305-307.  Among those, 25-200 and 220-300 are the biggest two
> + * unmapped areas, and thus it should be converted to three regions of 10-25,
> + * 200-220, and 300-330.
> + */
> +static void damon_test_three_regions_in_vmas(struct kunit *test)
> +{
> +       struct region regions[3] = {0,};
> +       /* 10-20-25, 200-210-220, 300-305, 307-330 */
> +       struct vm_area_struct vmas[] = {
> +               (struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
> +               (struct vm_area_struct) {.vm_start = 20, .vm_end = 25},
> +               (struct vm_area_struct) {.vm_start = 200, .vm_end = 210},
> +               (struct vm_area_struct) {.vm_start = 210, .vm_end = 220},
> +               (struct vm_area_struct) {.vm_start = 300, .vm_end = 305},
> +               (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
> +       };
> +       vmas[0].vm_next = &vmas[1];
> +       vmas[1].vm_next = &vmas[2];
> +       vmas[2].vm_next = &vmas[3];
> +       vmas[3].vm_next = &vmas[4];
> +       vmas[4].vm_next = &vmas[5];
> +       vmas[5].vm_next = NULL;
> +
> +       damon_three_regions_in_vmas(&vmas[0], regions);
> +
> +       KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
> +       KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
> +       KUNIT_EXPECT_EQ(test, 200ul, regions[1].start);
> +       KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
> +       KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
> +       KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
> +}
> +
> +/* Clean up global state of damon */
> +static void damon_cleanup_global_state(void)
> +{
> +       struct damon_task *t, *next;
> +
> +       damon_for_each_task_safe(t, next)
> +               damon_destroy_task(t);
> +
> +       damon_rbuf_offset = 0;
> +}
> +
> +/*
> + * Test kdamond_flush_aggregated()
> + *
> + * DAMON checks access to each region and aggregates this information as the
> + * access frequency of each region.  In detail, it increases '->nr_accesses' of
> + * regions that an access has confirmed.  'kdamond_flush_aggregated()' flushes
> + * the aggregated information ('->nr_accesses' of each regions) to the result
> + * buffer.  As a result of the flushing, the '->nr_accesses' of regions are
> + * initialized to zero.
> + */
> +static void damon_test_aggregate(struct kunit *test)
> +{
> +       unsigned long pids[] = {1, 2, 3};
> +       unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
> +       unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
> +       unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
> +       struct damon_task *t;
> +       struct damon_region *r;
> +       int it, ir;
> +       ssize_t sz, sr, sp;
> +
> +       damon_set_pids(pids, 3);
> +
> +       it = 0;
> +       damon_for_each_task(t) {
> +               for (ir = 0; ir < 3; ir++) {
> +                       r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
> +                       r->nr_accesses = accesses[it][ir];
> +                       damon_add_region_tail(r, t);
> +               }
> +               it++;
> +       }
> +       kdamond_flush_aggregated();
> +       it = 0;
> +       damon_for_each_task(t) {
> +               ir = 0;
> +               /* '->nr_accesses' should be zeroed */
> +               damon_for_each_region(r, t) {
> +                       KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
> +                       ir++;
> +               }
> +               /* regions should be preserved */
> +               KUNIT_EXPECT_EQ(test, 3, ir);
> +               it++;
> +       }
> +       /* tasks also should be preserved */
> +       KUNIT_EXPECT_EQ(test, 3, it);
> +
> +       /* The aggregated information should be written in the buffer */
> +       sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
> +       sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
> +       sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
> +       KUNIT_EXPECT_EQ(test, (unsigned int)sz, damon_rbuf_offset);
> +
> +       damon_cleanup_global_state();
> +}
> +
> +static void damon_test_write_rbuf(struct kunit *test)
> +{
> +       char *data;
> +
> +       data = "hello";
> +       damon_write_rbuf(data, strnlen(data, 256));
> +       KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
> +
> +       damon_write_rbuf(data, 0);
> +       KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
> +
> +       KUNIT_EXPECT_STREQ(test, (char *)damon_rbuf, data);
> +}
> +
> +/*
> + * Test 'damon_apply_three_regions()'
> + *
> + * test                        kunit object
> + * regions             an array containing start/end addresses of current
> + *                     monitoring target regions
> + * nr_regions          the number of the addresses in 'regions'
> + * three_regions       The three regions that need to be applied now
> + * expected            start/end addresses of monitoring target regions that
> + *                     'three_regions' are applied
> + * nr_expected         the number of addresses in 'expected'
> + *
> + * The memory mapping of the target processes changes dynamically.  To follow
> + * the change, DAMON periodically reads the mappings, simplifies it to the
> + * three regions, and updates the monitoring target regions to fit in the three
> + * regions.  The update of current target regions is the role of
> + * 'damon_apply_three_regions()'.
> + *
> + * This test passes the given target regions and the new three regions that
> + * need to be applied to the function and check whether it updates the regions
> + * as expected.
> + */
> +static void damon_do_test_apply_three_regions(struct kunit *test,
> +                               unsigned long *regions, int nr_regions,
> +                               struct region *three_regions,
> +                               unsigned long *expected, int nr_expected)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r;
> +       int i;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < nr_regions / 2; i++) {
> +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> +               damon_add_region_tail(r, t);
> +       }
> +       damon_add_task_tail(t);
> +
> +       damon_apply_three_regions(t, three_regions);
> +
> +       for (i = 0; i < nr_expected / 2; i++) {
> +               r = damon_nth_region_of(t, i);
> +               KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
> +       }
> +
> +       damon_cleanup_global_state();
> +}
> +
> +/* below 4 functions test differnt inputs for 'damon_apply_three_regions()' */

Spelling. Also, I think this comment doesn't really say anything that
you cannot get from reading the code. Maybe provide some more details?
Maybe add why you picked the inputs that you did?

> +static void damon_test_apply_three_regions1(struct kunit *test)
> +{
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
> +                               70, 80, 80, 90, 90, 100};
> +       /* 5-27, 45-55, 73-104 */
> +       struct region new_three_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 45, .end = 55},
> +               (struct region){.start = 73, .end = 104} };
> +       /* 5-20-27, 45-55, 73-80-90-104 */
> +       unsigned long expected[] = {5, 20, 20, 27, 45, 55,
> +                               73, 80, 80, 90, 90, 104};
> +
> +       damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
> +                       new_three_regions, expected, ARRAY_SIZE(expected));
> +}
> +
> +static void damon_test_apply_three_regions2(struct kunit *test)
> +{
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
> +                               70, 80, 80, 90, 90, 100};
> +       /* 5-27, 56-57, 65-104 */
> +       struct region new_three_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 56, .end = 57},
> +               (struct region){.start = 65, .end = 104} };
> +       /* 5-20-27, 56-57, 65-80-90-104 */
> +       unsigned long expected[] = {5, 20, 20, 27, 56, 57,
> +                               65, 80, 80, 90, 90, 104};
> +
> +       damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
> +                       new_three_regions, expected, ARRAY_SIZE(expected));
> +}
> +
> +static void damon_test_apply_three_regions3(struct kunit *test)
> +{
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
> +                               70, 80, 80, 90, 90, 100};
> +       /* 5-27, 61-63, 65-104 */
> +       struct region new_three_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 61, .end = 63},
> +               (struct region){.start = 65, .end = 104} };
> +       /* 5-20-27, 61-63, 65-80-90-104 */
> +       unsigned long expected[] = {5, 20, 20, 27, 61, 63,
> +                               65, 80, 80, 90, 90, 104};
> +
> +       damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
> +                       new_three_regions, expected, ARRAY_SIZE(expected));
> +}
> +
> +static void damon_test_apply_three_regions4(struct kunit *test)
> +{
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
> +                               70, 80, 80, 90, 90, 100};
> +       /* 5-7, 30-32, 65-68 */
> +       struct region new_three_regions[3] = {
> +               (struct region){.start = 5, .end = 7},
> +               (struct region){.start = 30, .end = 32},
> +               (struct region){.start = 65, .end = 68} };
> +       /* expect 5-7, 30-32, 65-68 */
> +       unsigned long expected[] = {5, 7, 30, 32, 65, 68};
> +
> +       damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
> +                       new_three_regions, expected, ARRAY_SIZE(expected));
> +}
> +
> +static void damon_test_split_evenly(struct kunit *test)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r;
> +       unsigned long i;
> +
> +       KUNIT_EXPECT_EQ(test, damon_split_region_evenly(NULL, 5), -EINVAL);
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(0, 100);
> +       KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 0), -EINVAL);
> +
> +       damon_add_region_tail(r, t);
> +       KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 10), 0);
> +       KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 10u);
> +
> +       i = 0;
> +       damon_for_each_region(r, t) {
> +               KUNIT_EXPECT_EQ(test, r->vm_start, i++ * 10);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, i * 10);
> +       }
> +       damon_free_task(t);
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(5, 59);
> +       damon_add_region_tail(r, t);
> +       KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 5), 0);
> +       KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
> +
> +       i = 0;
> +       damon_for_each_region(r, t) {
> +               if (i == 4)
> +                       break;
> +               KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i++);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, 5 + 10 * i);
> +       }
> +       KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i);
> +       KUNIT_EXPECT_EQ(test, r->vm_end, 59ul);
> +       damon_free_task(t);
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(5, 6);
> +       damon_add_region_tail(r, t);
> +       KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 2), -EINVAL);
> +       KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 1u);
> +
> +       damon_for_each_region(r, t) {
> +               KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, 6ul);
> +       }
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_split_at(struct kunit *test)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r;
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(0, 100);
> +       damon_add_region_tail(r, t);
> +       damon_split_region_at(r, 25);
> +       KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
> +       KUNIT_EXPECT_EQ(test, r->vm_end, 25ul);
> +
> +       r = damon_next_region(r);
> +       KUNIT_EXPECT_EQ(test, r->vm_start, 25ul);
> +       KUNIT_EXPECT_EQ(test, r->vm_end, 100ul);
> +
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_merge_two(struct kunit *test)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r, *r2, *r3;
> +       int i;
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(0, 100);
> +       r->nr_accesses = 10;
> +       damon_add_region_tail(r, t);
> +       r2 = damon_new_region(100, 300);
> +       r2->nr_accesses = 20;
> +       damon_add_region_tail(r2, t);
> +
> +       damon_merge_two_regions(r, r2);
> +       KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
> +       KUNIT_EXPECT_EQ(test, r->vm_end, 300ul);
> +       KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> +
> +       i = 0;
> +       damon_for_each_region(r3, t) {
> +               KUNIT_EXPECT_PTR_EQ(test, r, r3);
> +               i++;
> +       }
> +       KUNIT_EXPECT_EQ(test, i, 1);
> +
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_merge_regions_of(struct kunit *test)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r;
> +       unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
> +       unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
> +       unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
> +
> +       unsigned long saddrs[] = {0, 114, 130, 156, 170};
> +       unsigned long eaddrs[] = {112, 130, 156, 170, 230};
> +       int i;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < ARRAY_SIZE(sa); i++) {
> +               r = damon_new_region(sa[i], ea[i]);
> +               r->nr_accesses = nrs[i];
> +               damon_add_region_tail(r, t);
> +       }
> +
> +       damon_merge_regions_of(t, 9);
> +       /* 0-112, 114-130, 130-156, 156-170 */
> +       KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
> +       for (i = 0; i < 5; i++) {
> +               r = damon_nth_region_of(t, i);
> +               KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
> +       }
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_split_regions_of(struct kunit *test)
> +{
> +       struct damon_task *t;
> +       struct damon_region *r;
> +
> +       t = damon_new_task(42);
> +       r = damon_new_region(0, 22);
> +       damon_add_region_tail(r, t);
> +       damon_split_regions_of(t);
> +       KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 2u);
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_kdamond_need_stop(struct kunit *test)
> +{
> +       KUNIT_EXPECT_TRUE(test, kdamond_need_stop());

This doesn't look like a useful test, or a useful function. Why even
check if the function always returns true? And if it doesn't always
return true, then this test is not hermetic which is bad unit testing
practice.

> +}
> +
> +static struct kunit_case damon_test_cases[] = {
> +       KUNIT_CASE(damon_test_str_to_pids),
> +       KUNIT_CASE(damon_test_tasks),
> +       KUNIT_CASE(damon_test_regions),
> +       KUNIT_CASE(damon_test_set_pids),
> +       KUNIT_CASE(damon_test_three_regions_in_vmas),
> +       KUNIT_CASE(damon_test_aggregate),
> +       KUNIT_CASE(damon_test_write_rbuf),
> +       KUNIT_CASE(damon_test_apply_three_regions1),
> +       KUNIT_CASE(damon_test_apply_three_regions2),
> +       KUNIT_CASE(damon_test_apply_three_regions3),
> +       KUNIT_CASE(damon_test_apply_three_regions4),
> +       KUNIT_CASE(damon_test_split_evenly),
> +       KUNIT_CASE(damon_test_split_at),
> +       KUNIT_CASE(damon_test_merge_two),
> +       KUNIT_CASE(damon_test_merge_regions_of),
> +       KUNIT_CASE(damon_test_split_regions_of),
> +       KUNIT_CASE(damon_test_kdamond_need_stop),
> +       {},
> +};
> +
> +static struct kunit_suite damon_test_suite = {
> +       .name = "damon",
> +       .test_cases = damon_test_cases,
> +};
> +kunit_test_suite(damon_test_suite);
> +
> +#endif /* _DAMON_TEST_H */
> +
> +#endif /* CONFIG_DAMON_KUNIT_TEST */
> diff --git a/mm/damon.c b/mm/damon.c
> index 3e1b5eb945ea..f21968f079f0 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -1289,3 +1289,5 @@ module_exit(damon_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
>  MODULE_DESCRIPTION("DAMON: Data Access MONitor");
> +
> +#include "damon-test.h"
> --
> 2.17.1
>
