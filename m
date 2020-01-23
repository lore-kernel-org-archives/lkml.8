Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E3AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6B1207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpiRDsoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWVhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:37:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34060 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgAWVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:37:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so4931072wrr.1;
        Thu, 23 Jan 2020 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=ZWpBhbXeVZLaPeJZtMiBvJEIVffq3Z2vtGP/vPPTPKA=;
        b=GpiRDsoWq45KNCle0oqYym+Cf//LmirQry38EQxyuDci+fOCOtrJBGIAk80J6Mz6oI
         bug/R6fmCPyKMLEo6QS4B7Lm5AD0t0qQnhWQyniozx460nhoPzYJ5oLpp/XtaD01yZew
         YEtHmfe344UjiWb3+l3p1U/iXjU7zA/FT5g5zRRtzGr7INplASA+QHimqF8dHZRSZTg2
         jGbhV+BeIE0hCYvbC0UO1XXL7MB+pw6RO6UxKzeD3QmJGDJSh/1Y6XmVGYifnEe817Qy
         dwRkHwFPrmdb+9IEyRFgJuQN5GzpCF7Fmj7UpusSxJri0vbV95nHK7XHtdqNoSNgj5+Y
         y/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=ZWpBhbXeVZLaPeJZtMiBvJEIVffq3Z2vtGP/vPPTPKA=;
        b=Em+rWxyX4a/3tkPL9yPhrkNOOmVK5SQ5t2ffShBo6wK2hNFsO41WMLgDQjwT4Rpe0l
         bb6aD0uJqM/JzwJZbVfuZaZhMGI+fTE4mGmTuyFVHd42JDl11vzPhK8PoiPS+1QhQQjL
         KiSllTaabdPyMTFAlm0GIJLNshh8S6WFr2d4cCmzMf10XEpI683X+p05SsKeL9R90POL
         heMpgrqaXNv1EQNMMAYHwx5GW/sp7ofbb44oGjFQuc2+BSAbwAff6NBDfZAqHKi8oe8J
         OV1HQtg4H+SZJYjlc08UY6KwR+TnIZEtxJxT4qUaOgtF/wMzkOmeYRfy+ib5991uOUfV
         FuOQ==
X-Gm-Message-State: APjAAAUYwi4QW/+ymqKy9gWlNLj70tmQUZNjHVoXrUg3by+B76TzhQ35
        ih4oUI91YW8PZTuC3rKpE30=
X-Google-Smtp-Source: APXvYqyoK4ulX4Mr0m2DsYdXGNhPrk70c9qXNO3ZD66nFkirevCR+InAiANF6eKEMb/mUrLyheZhjA==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr75021wrq.125.1579815434134;
        Thu, 23 Jan 2020 13:37:14 -0800 (PST)
Received: from x1cbn.MEGAROWIFI.local ([5.148.123.66])
        by smtp.gmail.com with ESMTPSA id p18sm4192971wmb.8.2020.01.23.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 13:37:13 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        mgorman@suse.de, SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [RFC PATCH 5/5] mm/damon: Add kunit tests
Date:   Thu, 23 Jan 2020 22:37:02 +0100
Message-Id: <20200123213702.14739-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g47eB42E3X7m_rfmG=vEcMK9dtdAFZT5WjwV3sx3MO0-MQ@mail.gmail.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 13:12:55 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Fri, Jan 10, 2020 at 5:18 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds kunit based unit tests for DAMON.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Sorry for the late review on this: I am still getting caught up on my
> vacation backlog.

Thank you so much for this review, Brendan :)

BTW, I posted 'PATCH v1' of this [1] meanwhile and I forgot adding you as
recipients, sorry.  That said, the kunit related part has no change with the
next spin, so your reviews will applied.  Will not miss you from 'v2'.

[1] https://lore.kernel.org/linux-mm/20200120162757.32375-1-sjpark@amazon.com/

> 
> > ---
> >  mm/Kconfig      |  11 +
> >  mm/damon-test.h | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/damon.c      |   2 +
> >  3 files changed, 584 insertions(+)
> >  create mode 100644 mm/damon-test.h
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index b7af8a1b5cb5..7b023799aa38 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -748,4 +748,15 @@ config DAMON
> >           be 1) accurate enough to be useful for performance-centric domains,
> >           and 2) sufficiently light-weight so that it can be applied online.
> >
> > +config DAMON_TEST
> 
> To be consistent with other KUnit tests, this should be "DAMON_KUNIT_TEST".

Good point, will do so.

> 
> > +       bool "Test for damon"
> > +       depends on DAMON && KUNIT
> > +       help
> > +         This builds the DAMON Kunit test suite.
> > +
> > +         For more information on KUnit and unit tests in general, please refer
> > +         to the KUnit documentation.
> > +
> > +         If unsure, say N.
> > +
> >  endmenu
> > diff --git a/mm/damon-test.h b/mm/damon-test.h
> > new file mode 100644
> > index 000000000000..0d94910b8fe5
> > --- /dev/null
> > +++ b/mm/damon-test.h
> > @@ -0,0 +1,571 @@
[...]
> > +
> > +static void damon_test_set_pids(struct kunit *test)
> > +{
> > +       unsigned long pids[] = {1, 2, 3};
> > +       char buf[64];
> > +
> > +       damon_set_pids(pids, 3);
> > +       damon_sprint_pids(buf, 64);
> > +       pr_info("buf: %s (%zu)\n", buf, strlen(buf));
> 
> Might want to use kunit_info here so it matches the TAP test log
> format. Not a requirement, just an FYI.

Oh, this is a debugging code I missed to delete.  Will delete from next spin.
Also, will use 'kunit_info()' like things if I need any log, either.

> 
> > +       KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "1 2 3\n", 64));
> 
> Here and elsewhere: This should probably use KUNIT_EXPECT_STREQ().

Good point, will fix with the next spin.

> 
[...]
> > +
> > +static void damon_test_three_regions_in_vmas(struct kunit *test)
> > +{
> > +       struct region regions[3] = {0,};
> > +
> > +       struct vm_area_struct vmas[] = {
> > +               (struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
> > +               (struct vm_area_struct) {.vm_start = 20, .vm_end = 25},
> > +               (struct vm_area_struct) {.vm_start = 200, .vm_end = 210},
> > +               (struct vm_area_struct) {.vm_start = 210, .vm_end = 220},
> > +               (struct vm_area_struct) {.vm_start = 300, .vm_end = 305},
> > +               (struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
> > +       };
> > +       vmas[0].vm_next = &vmas[1];
> > +       vmas[1].vm_next = &vmas[2];
> > +       vmas[2].vm_next = &vmas[3];
> > +       vmas[3].vm_next = &vmas[4];
> > +       vmas[4].vm_next = &vmas[5];
> > +       vmas[5].vm_next = NULL;
> > +
> > +       damon_three_regions_in_vmas(&vmas[0], regions);
> > +
> > +       KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
> > +       KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
> > +       KUNIT_EXPECT_EQ(test, 200ul, regions[1].start);
> > +       KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
> > +       KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
> > +       KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
> 
> It's not obvious to me what property you are proving here. Might want
> to add a comment.

It's closely related with DAMON internal logic.  Will add a reference to a
document for the internal logic and what I'm checking, as you suggested.  Same
for other ambiguous test code fragments you pointed out below.

> 
[...]
> > +
> > +static void damon_test_aggregate(struct kunit *test)
> > +{
> > +       unsigned long pids[] = {1, 2, 3};
> > +       unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
> > +       unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
> > +       unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
> > +       struct damon_task *t;
> > +       struct damon_region *r;
> > +       int it, ir;
> > +       ssize_t sz, sr, sp;
> > +
> > +       damon_set_pids(pids, 3);
> > +
> > +       it = 0;
> > +       damon_for_each_task(t) {
> > +               for (ir = 0; ir < 3; ir++) {
> > +                       r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
> > +                       r->nr_accesses = accesses[it][ir];
> > +                       damon_add_region_tail(r, t);
> > +               }
> > +               it++;
> > +       }
> > +       kdamond_flush_aggregated();
> 
> I think this test case is also difficult to understand. I think you
> probably need at least a comment on what this test case does.
> 
> > +       it = 0;
> > +       damon_for_each_task(t) {
> > +               ir = 0;
> > +               damon_for_each_region(r, t) {
> > +                       KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
> > +                       ir++;
> > +               }
> > +               KUNIT_EXPECT_EQ(test, 3, ir);
> > +               it++;
> > +       }
> > +       KUNIT_EXPECT_EQ(test, 3, it);
> > +
> > +       sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
> > +       sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
> > +       sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
> > +       KUNIT_EXPECT_EQ(test, (unsigned int)sz, damon_rbuf_offset);
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
[...]
> > +
> > +static void damon_test_update_two_gaps(struct kunit *test)
> > +{
> 
> I think this test case is also difficult to understand. I think you
> probably need at least a comment on what this test case does.
> 
> > +       struct damon_task *t;
> > +       struct damon_region *r, *prev = NULL;
> > +       unsigned long regions[] = {10, 20, 20, 30,
> > +               50, 55, 55, 57, 57, 59,
> > +               70, 80, 80, 90, 90, 100};       /* 10-30, 50-59, 70-100 */
> > +       struct region new_regions[3] = {
> > +               (struct region){.start = 5, .end = 27},
> > +               (struct region){.start = 45, .end = 55},
> > +               (struct region){.start = 73, .end = 104} };
> > +       int i;
> > +       bool first_gap = true;
> > +
> > +       t = damon_new_task(42);
> > +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> > +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > +               damon_add_region_tail(r, t);
> > +       }
> > +       damon_add_task_tail(t);
> > +
> > +       damon_apply_three_regions(t, new_regions);
> > +
> > +       damon_for_each_region(r, t) {
> > +               if (prev == NULL) {
> > +                       KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
> > +                       goto next;
> > +               }
> > +
> > +               if (prev->vm_end != r->vm_start && first_gap) {
> > +                       KUNIT_EXPECT_EQ(test, prev->vm_end, 27ul);
> > +                       KUNIT_EXPECT_EQ(test, r->vm_start, 45ul);
> > +                       first_gap = false;
> > +                       goto next;
> > +               }
> > +
> > +               if (prev->vm_end != r->vm_start && !first_gap) {
> > +                       KUNIT_EXPECT_EQ(test, prev->vm_end, 55ul);
> > +                       KUNIT_EXPECT_EQ(test, r->vm_start, 73ul);
> > +                       goto next;
> > +               }
> > +
> > +next:
> > +               prev = r;
> > +       }
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
> > +static void damon_test_update_two_gaps2(struct kunit *test)
> > +{
> 
> Same here.
> 
> > +       struct damon_task *t;
> > +       struct damon_region *r;
> > +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> > +       unsigned long regions[] = {10, 20, 20, 30,
> > +               50, 55, 55, 57, 57, 59,
> > +               70, 80, 80, 90, 90, 100};
> > +       struct region new_regions[3] = {
> > +               (struct region){.start = 5, .end = 27},
> > +               (struct region){.start = 56, .end = 57},
> > +               (struct region){.start = 65, .end = 104} };
> > +       /* expect 5-27, 56-57, 65-80-90-104 */
> > +       unsigned long answers[] = {5, 20, 20, 27,
> > +               56, 57,
> > +               65, 80, 80, 90, 90, 104};
> > +       int i;
> > +
> > +       t = damon_new_task(42);
> > +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> > +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > +               damon_add_region_tail(r, t);
> > +       }
> > +       damon_add_task_tail(t);
> > +
> > +       damon_apply_three_regions(t, new_regions);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> > +               r = damon_nth_region_of(t, i);
> > +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> > +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> > +       }
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
> > +static void damon_test_update_two_gaps3(struct kunit *test)
> > +{
> 
> Same here.
> 
> > +       struct damon_task *t;
> > +       struct damon_region *r;
> > +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> > +       unsigned long regions[] = {10, 20, 20, 30,
> > +               50, 55, 55, 57, 57, 59,
> > +               70, 80, 80, 90, 90, 100};
> > +       struct region new_regions[3] = {
> > +               (struct region){.start = 5, .end = 27},
> > +               (struct region){.start = 61, .end = 63},
> > +               (struct region){.start = 65, .end = 104} };
> > +       /* expect 5-27, 56-57, 65-80-90-104 */
> > +       unsigned long answers[] = {5, 20, 20, 27,
> > +               61, 63,
> > +               65, 80, 80, 90, 90, 104};
> > +       int i;
> > +
> > +       t = damon_new_task(42);
> > +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> > +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > +               damon_add_region_tail(r, t);
> > +       }
> > +       damon_add_task_tail(t);
> > +
> > +       damon_apply_three_regions(t, new_regions);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> > +               r = damon_nth_region_of(t, i);
> > +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> > +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> > +       }
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
> > +static void damon_test_update_two_gaps4(struct kunit *test)
> > +{
> 
> Ditto.
> 
> > +       struct damon_task *t;
> > +       struct damon_region *r;
> > +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> > +       unsigned long regions[] = {10, 20, 20, 30,
> > +               50, 55, 55, 57, 57, 59,
> > +               70, 80, 80, 90, 90, 100};
> > +       struct region new_regions[3] = {
> > +               (struct region){.start = 5, .end = 7},
> > +               (struct region){.start = 30, .end = 32},
> > +               (struct region){.start = 65, .end = 68} };
> > +       /* expect 5-27, 56-57, 65-80-90-104 */
> > +       unsigned long answers[] = {5, 7, 30, 32, 65, 68};
> > +       int i;
> > +
> > +       t = damon_new_task(42);
> > +       for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
> > +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > +               damon_add_region_tail(r, t);
> > +       }
> > +       damon_add_task_tail(t);
> > +
> > +       damon_apply_three_regions(t, new_regions);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
> > +               r = damon_nth_region_of(t, i);
> > +               KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
> > +               KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
> > +       }
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
[...]


Will apply all of your suggestions, soon.


Thanks,
SeongJae Park
