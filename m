Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B4C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029AE21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz99gZv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAWVNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:13:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36036 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgAWVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:13:08 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so42336pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6wpmiim8QVTezoGjHOb0voVyMmr/vVLwldVWKwAVCSI=;
        b=Oz99gZv77ElCOPCb7+qFUgo6x/al9DjS5HGSe++pJfkB5glRfeUnRT65paQ6WVvUdF
         gDOh1AsWq7mM7ehe7CURKALW+CFEgqOUXizQw8Urzr1qe8Hx5V6u/GH/jz3J352GGLz0
         7ntoZDMGg8G0ra25HvTlMynunTcHivE/2P3wwAPmpayzU0460oBub3CJGh4s3nHMyqB+
         V15Kan03NKAswql5uoMTqlqRWbMxtr5xWq2BFILeec7keVvsfUaujd6ByEWZY2dBsanO
         ROM/6c7soS17MsRf1MQMcc8PZffojFuwu7DijLVQII1ohvCPBGu/et5HJXX1wjkzdpjD
         3AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wpmiim8QVTezoGjHOb0voVyMmr/vVLwldVWKwAVCSI=;
        b=MZst0B3Qs8UvBXcFszVLxnZEzm/4/0C4I8Befv4DSICV3WieqM9w+ZGt5oiLiiR9p9
         pfO3RpJnDJdHo3chUvAutlcVRlL1ZEaynU+sNti2o4KsIB/gnwbN09UalgraoA+ClAwx
         lKNKtSaeuHm/JLKvHmsrtfW6q7hD9qM0qaaKiEst12FRXdfIFzkIKcg2WvEHH0fXGN43
         otCpGOiN0tp9C5IAI4mj7HHJBpL7ARjuwKZy7VOJ7Oaq0NNQdAwLQ867nj4Zu4iP3Adg
         8XagQqAFVjqD4rgY/jSOJPRGHL1DbqtXuzU06vOdLu8bL+egD/RrEecJVtpOoCK/oVa1
         aJSw==
X-Gm-Message-State: APjAAAUA1Xw+tlxnQFr2BytBUQ0p6fJF7p3qfCNHjn0Q0yvgeqlRQ6bh
        tygdAEr7X8SxwAxOZp92Fl88JnVrHKF7guAq/mAZpA==
X-Google-Smtp-Source: APXvYqx0vKloJwZMdT+rTROmZMxonMvWDTNUmKb5T/PnAAhv/SBm/qsNJ3xaxcTSA8zdsWI8aP6U3n48Rtjx5kInsoI=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr55564plv.297.1579813987117;
 Thu, 23 Jan 2020 13:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20200110131522.29964-1-sjpark@amazon.com> <20200110131753.30737-1-sjpark@amazon.com>
In-Reply-To: <20200110131753.30737-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 13:12:55 -0800
Message-ID: <CAFd5g47eB42E3X7m_rfmG=vEcMK9dtdAFZT5WjwV3sx3MO0-MQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] mm/damon: Add kunit tests
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        mgorman@suse.de, SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 5:18 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds kunit based unit tests for DAMON.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Sorry for the late review on this: I am still getting caught up on my
vacation backlog.

> ---
>  mm/Kconfig      |  11 +
>  mm/damon-test.h | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/damon.c      |   2 +
>  3 files changed, 584 insertions(+)
>  create mode 100644 mm/damon-test.h
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b7af8a1b5cb5..7b023799aa38 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -748,4 +748,15 @@ config DAMON
>           be 1) accurate enough to be useful for performance-centric domains,
>           and 2) sufficiently light-weight so that it can be applied online.
>
> +config DAMON_TEST

To be consistent with other KUnit tests, this should be "DAMON_KUNIT_TEST".

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
> index 000000000000..0d94910b8fe5
> --- /dev/null
> +++ b/mm/damon-test.h
> @@ -0,0 +1,571 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Access Monitor Unit Tests
> + *
> + * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#ifdef CONFIG_DAMON_TEST
> +
> +#ifndef _DAMON_TEST_H
> +#define _DAMON_TEST_H
> +
> +#include <kunit/test.h>
> +
> +static void damon_test_str_to_pids(struct kunit *test)
> +{
> +       char *question;
> +       unsigned long *answers;
> +       unsigned long expected[] = {12, 35, 46};
> +       ssize_t nr_integers = 0, i;
> +
> +       question = "123";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 1l, nr_integers);
> +       KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
> +       kfree(answers);
> +
> +       question = "123abc";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 1l, nr_integers);
> +       KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
> +       kfree(answers);
> +
> +       question = "a123";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
> +       KUNIT_EXPECT_PTR_EQ(test, answers, (unsigned long *)NULL);
> +
> +       question = "12 35";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 2l, nr_integers);
> +       for (i = 0; i < nr_integers; i++)
> +               KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
> +       kfree(answers);
> +
> +       question = "12 35 46";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 3l, nr_integers);
> +       for (i = 0; i < nr_integers; i++)
> +               KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
> +       kfree(answers);
> +
> +       question = "12 35 abc 46";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 2l, nr_integers);
> +       for (i = 0; i < 2; i++)
> +               KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
> +       kfree(answers);
> +
> +       question = "";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
> +       KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
> +       kfree(answers);
> +
> +       question = "\n";
> +       answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
> +       KUNIT_EXPECT_EQ(test, 0l, nr_integers);
> +       KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
> +       kfree(answers);
> +}
> +
> +static void damon_test_regions(struct kunit *test)
> +{
> +       struct damon_region *r;
> +       struct damon_task *t;
> +
> +       r = damon_new_region(1, 2);
> +       KUNIT_EXPECT_EQ(test, 1ul, r->vm_start);
> +       KUNIT_EXPECT_EQ(test, 2ul, r->vm_end);
> +       KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
> +       KUNIT_EXPECT_TRUE(test, r->sampling_addr >= r->vm_start);
> +       KUNIT_EXPECT_TRUE(test, r->sampling_addr < r->vm_end);
> +
> +       t = damon_new_task(42);
> +       KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
> +
> +       damon_add_region_tail(r, t);
> +       KUNIT_EXPECT_EQ(test, 1u, nr_damon_regions(t));
> +
> +       damon_del_region(r);
> +       KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
> +
> +       damon_free_task(t);
> +}
> +
> +static void damon_test_tasks(struct kunit *test)
> +{
> +       struct damon_task *t;
> +
> +       t = damon_new_task(42);
> +       KUNIT_EXPECT_EQ(test, 42ul, t->pid);
> +       KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks());
> +
> +       damon_add_task_tail(t);
> +       KUNIT_EXPECT_EQ(test, 1u, nr_damon_tasks());
> +
> +       damon_destroy_task(t);
> +       KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks());
> +}
> +
> +static void damon_test_set_pids(struct kunit *test)
> +{
> +       unsigned long pids[] = {1, 2, 3};
> +       char buf[64];
> +
> +       damon_set_pids(pids, 3);
> +       damon_sprint_pids(buf, 64);
> +       pr_info("buf: %s (%zu)\n", buf, strlen(buf));

Might want to use kunit_info here so it matches the TAP test log
format. Not a requirement, just an FYI.

> +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "1 2 3\n", 64));

Here and elsewhere: This should probably use KUNIT_EXPECT_STREQ().

> +
> +       damon_set_pids(NULL, 0);
> +       damon_sprint_pids(buf, 64);
> +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "\n", 64));
> +
> +       damon_set_pids((unsigned long []){1, 2}, 2);
> +       damon_sprint_pids(buf, 64);
> +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "1 2\n", 64));
> +
> +       damon_set_pids((unsigned long []){2}, 1);
> +       damon_sprint_pids(buf, 64);
> +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "2\n", 64));
> +
> +       damon_set_pids(NULL, 0);
> +       damon_sprint_pids(buf, 64);
> +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "\n", 64));
> +}
> +
> +static void damon_test_three_regions_in_vmas(struct kunit *test)
> +{
> +       struct region regions[3] = {0,};
> +
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

It's not obvious to me what property you are proving here. Might want
to add a comment.

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

I think this test case is also difficult to understand. I think you
probably need at least a comment on what this test case does.

> +       it = 0;
> +       damon_for_each_task(t) {
> +               ir = 0;
> +               damon_for_each_region(r, t) {
> +                       KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
> +                       ir++;
> +               }
> +               KUNIT_EXPECT_EQ(test, 3, ir);
> +               it++;
> +       }
> +       KUNIT_EXPECT_EQ(test, 3, it);
> +
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
> +       KUNIT_EXPECT_EQ(test, strncmp(damon_rbuf, data, 5), 0);
> +}
> +
> +static void damon_test_update_two_gaps(struct kunit *test)
> +{

I think this test case is also difficult to understand. I think you
probably need at least a comment on what this test case does.

> +       struct damon_task *t;
> +       struct damon_region *r, *prev = NULL;
> +       unsigned long regions[] = {10, 20, 20, 30,
> +               50, 55, 55, 57, 57, 59,
> +               70, 80, 80, 90, 90, 100};       /* 10-30, 50-59, 70-100 */
> +       struct region new_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 45, .end = 55},
> +               (struct region){.start = 73, .end = 104} };
> +       int i;
> +       bool first_gap = true;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> +               damon_add_region_tail(r, t);
> +       }
> +       damon_add_task_tail(t);
> +
> +       damon_apply_three_regions(t, new_regions);
> +
> +       damon_for_each_region(r, t) {
> +               if (prev == NULL) {
> +                       KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
> +                       goto next;
> +               }
> +
> +               if (prev->vm_end != r->vm_start && first_gap) {
> +                       KUNIT_EXPECT_EQ(test, prev->vm_end, 27ul);
> +                       KUNIT_EXPECT_EQ(test, r->vm_start, 45ul);
> +                       first_gap = false;
> +                       goto next;
> +               }
> +
> +               if (prev->vm_end != r->vm_start && !first_gap) {
> +                       KUNIT_EXPECT_EQ(test, prev->vm_end, 55ul);
> +                       KUNIT_EXPECT_EQ(test, r->vm_start, 73ul);
> +                       goto next;
> +               }
> +
> +next:
> +               prev = r;
> +       }
> +
> +       damon_cleanup_global_state();
> +}
> +
> +static void damon_test_update_two_gaps2(struct kunit *test)
> +{

Same here.

> +       struct damon_task *t;
> +       struct damon_region *r;
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30,
> +               50, 55, 55, 57, 57, 59,
> +               70, 80, 80, 90, 90, 100};
> +       struct region new_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 56, .end = 57},
> +               (struct region){.start = 65, .end = 104} };
> +       /* expect 5-27, 56-57, 65-80-90-104 */
> +       unsigned long answers[] = {5, 20, 20, 27,
> +               56, 57,
> +               65, 80, 80, 90, 90, 104};
> +       int i;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> +               damon_add_region_tail(r, t);
> +       }
> +       damon_add_task_tail(t);
> +
> +       damon_apply_three_regions(t, new_regions);
> +
> +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> +               r = damon_nth_region_of(t, i);
> +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> +       }
> +
> +       damon_cleanup_global_state();
> +}
> +
> +static void damon_test_update_two_gaps3(struct kunit *test)
> +{

Same here.

> +       struct damon_task *t;
> +       struct damon_region *r;
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30,
> +               50, 55, 55, 57, 57, 59,
> +               70, 80, 80, 90, 90, 100};
> +       struct region new_regions[3] = {
> +               (struct region){.start = 5, .end = 27},
> +               (struct region){.start = 61, .end = 63},
> +               (struct region){.start = 65, .end = 104} };
> +       /* expect 5-27, 56-57, 65-80-90-104 */
> +       unsigned long answers[] = {5, 20, 20, 27,
> +               61, 63,
> +               65, 80, 80, 90, 90, 104};
> +       int i;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> +               damon_add_region_tail(r, t);
> +       }
> +       damon_add_task_tail(t);
> +
> +       damon_apply_three_regions(t, new_regions);
> +
> +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> +               r = damon_nth_region_of(t, i);
> +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> +       }
> +
> +       damon_cleanup_global_state();
> +}
> +
> +static void damon_test_update_two_gaps4(struct kunit *test)
> +{

Ditto.

> +       struct damon_task *t;
> +       struct damon_region *r;
> +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> +       unsigned long regions[] = {10, 20, 20, 30,
> +               50, 55, 55, 57, 57, 59,
> +               70, 80, 80, 90, 90, 100};
> +       struct region new_regions[3] = {
> +               (struct region){.start = 5, .end = 7},
> +               (struct region){.start = 30, .end = 32},
> +               (struct region){.start = 65, .end = 68} };
> +       /* expect 5-27, 56-57, 65-80-90-104 */
> +       unsigned long answers[] = {5, 7, 30, 32, 65, 68};
> +       int i;
> +
> +       t = damon_new_task(42);
> +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> +               damon_add_region_tail(r, t);
> +       }
> +       damon_add_task_tail(t);
> +
> +       damon_apply_three_regions(t, new_regions);
> +
> +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> +               r = damon_nth_region_of(t, i);
> +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> +       }
> +
> +       damon_cleanup_global_state();
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
> +       KUNIT_CASE(damon_test_update_two_gaps),
> +       KUNIT_CASE(damon_test_update_two_gaps2),
> +       KUNIT_CASE(damon_test_update_two_gaps3),
> +       KUNIT_CASE(damon_test_update_two_gaps4),
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
> +#endif /* CONFIG_DAMON_TEST */
> diff --git a/mm/damon.c b/mm/damon.c
> index 0e99b4875700..c4b6b2db9a8c 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -1262,3 +1262,5 @@ static int __init damon_init(void)
>  }
>
>  module_init(damon_init);
> +
> +#include "damon-test.h"
> --
> 2.17.1
>
