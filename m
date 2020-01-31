Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A5C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EB52173E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 04:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceYLltBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgAaEzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:55:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgAaEzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 23:55:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so7155986wme.4;
        Thu, 30 Jan 2020 20:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=JJuf6F98cQcfxJlNtiuDW2HYjFK+PJrivUzpewMfPgU=;
        b=ceYLltBTxb0XYd0zWy2MHICx0O2XIPkPhWeH80EX07feujkgtZ7/VLV5E8ATzNceM4
         6W3R7VyCll2TdWX2ePqs/rIOiWrIbZulaHI/7jGewSgWcKvLEU1tdDiE52WD3HMVX2sa
         4AdOPiOxmpaqSVi0K2Me2/6747Ag0XjDb62t7gLX4DHGQpo6yjpTmFpCEL5ovHW0VhYA
         4b4I1uo5L7/2S7+j7MRc1LeD7k/jJ31+y8svpLMfun+Cn50ZMsUzui3AhU2nrKaMrIJf
         cVeQdW+NAaX8UCAGxJggs6LVJZvPtrYeWSnRlSqrxqcdiFpIZqDybjgQmUp2FcwGyUR3
         +fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=JJuf6F98cQcfxJlNtiuDW2HYjFK+PJrivUzpewMfPgU=;
        b=DhsiB2U/vT7t+U3oYxEVAC6sEkjIsn0k164G3D5fk/vPt5/OINJnktMFusl6aA25My
         1MGsK7X/vD+TrWUus4HMtrmNnjKne8Q2A7wJusdyOsH6q5nd+O7HvsoOwvYVo4wldHgi
         +gR+s2SpYRV22FuVv2Pg1daM4trnYxDoqFXGNnBtr6ev/4eX70+Qwf6rbfdkC3PNuzfh
         CrJhX8GagLKZHaZZXjWA1wwokzHH0u3d+cgbYgs68lGT6IJoNWAKQsACht7XrBLn9GBQ
         vYFj8cJH3WhvNMwLLqjJTeJ12uX5C6bZtUsBdjPHjDf3wx9FQWUp6pnfyDADcRLMO1kT
         y90A==
X-Gm-Message-State: APjAAAV30eBpegHXSUbQaow4tJaIoL1WwMQIms3q7SdNWY2IXAafO7Pp
        uMizVUwtx5ClKy+lepB/m48=
X-Google-Smtp-Source: APXvYqzkPpQM1jPO+h3W9539omwWZjIjyOv76n4yquRe7JRdKHdJQky2cjgMuvejzeqvkbR5Hw2gAw==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr9535980wmf.106.1580446536649;
        Thu, 30 Jan 2020 20:55:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:9e5:a83e:83e7:3809])
        by smtp.gmail.com with ESMTPSA id z133sm9711346wmb.7.2020.01.30.20.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 20:55:35 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        SeongJae Park <sj38.park@gmail.com>, acme@kernel.org,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, dwmw@amazon.com,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        kirill@shutemov.name, colin.king@canonical.com, minchan@kernel.org,
        vdavydov.dev@gmail.com, vdavydov@parallels.com, linux-mm@kvack.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2 8/9] mm/damon: Add kunit tests
Date:   Fri, 31 Jan 2020 05:55:27 +0100
Message-Id: <20200131045527.30320-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g47R_Cma_fi_rA1_9+Ns0dQPFRJ=zy9kq5vuMOGdzPHNKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 16:14:45 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Tue, Jan 28, 2020 at 1:01 AM <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit adds kunit based unit tests for DAMON.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  MAINTAINERS     |   1 +
> >  mm/Kconfig      |  11 +
> >  mm/damon-test.h | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/damon.c      |   2 +
> >  4 files changed, 585 insertions(+)
> >  create mode 100644 mm/damon-test.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5c8a0c4e69b8..cb091bee16c7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4616,6 +4616,7 @@ M:        SeongJae Park <sjpark@amazon.de>
> >  L:     linux-mm@kvack.org
> >  S:     Maintained
> >  F:     mm/damon.c
> > +F:     mm/damon-test.h
> >  F:     tools/damon/*
> >  F:     Documentation/admin-guide/mm/data_access_monitor.rst
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 144fb916aa8b..8b34711c6ee1 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -751,4 +751,15 @@ config DAMON
> >           be 1) accurate enough to be useful for performance-centric domains,
> >           and 2) sufficiently light-weight so that it can be applied online.
> >
> > +config DAMON_KUNIT_TEST
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
> > index 000000000000..3d92548058a7
> > --- /dev/null
> > +++ b/mm/damon-test.h
> [...]
> > +/*
> > + * Test damon_three_regions_in_vmas() function
> > + *
> > + * DAMON converts the complex and dynamic memory mappings of each target task
> > + * to three discontiguous regions which cover every mapped areas.  The two gaps
> > + * between the areas is two biggest unmapped areas in the original mapping.
> > + * 'damon_three_regions_in_vmas() receives an address space of a process.  It
> > + * first identifies the start of mappings, end of mappings, and the two biggest
> > + * unmapped areas.  After that, based on the information, it constructs the
> > + * three regions and returns.  For more detail, refer to the comment of
> > + * 'damon_init_regions_of()' function definition in 'mm/damon.c' file.
> > + *
> > + * For example, suppose virtual address ranges of 10-20, 20-25, 200-210,
> > + * 210-220, 300-305, and 307-330 (Other comments represent this mappings in
> > + * more short form: 10-20-25, 200-210-220, 300-305, 307-330) of a process are
> > + * mapped.  To cover every mappings, the three regions should start with 10,
> > + * and end with 305.
> 
> Why? What's special about those numbers? Don't you need 10 to 330 to
> cover all the mappings?

No big special, I just wanted to show whether the function really identify the
two biggest gaps in given regions and convert to the three regions.

I'm not using onlt 10 to 330 because the two biggest unmapped area are usually
the gap between 1) heap and the mmap()-ed area, and 2) the mmap()-ed area and
stack, which is so huge.  Therefore I wanted to test the gap existing case.  If
you have any different opinion, please let me know.

Will document this point more in next spin.

[...]
> > +
> > +static void damon_test_write_rbuf(struct kunit *test)
> > +{
> > +       char *data;
> > +
> > +       data = "hello";
> > +       damon_write_rbuf(data, strnlen(data, 256));
> > +       KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
> > +
> > +       damon_write_rbuf(data, 0);
> > +       KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
> > +
> > +       KUNIT_EXPECT_STREQ(test, (char *)damon_rbuf, data);
> > +}
> > +
> > +/*
> > + * Test 'damon_apply_three_regions()'
> > + *
> > + * test                        kunit object
> > + * regions             an array containing start/end addresses of current
> > + *                     monitoring target regions
> > + * nr_regions          the number of the addresses in 'regions'
> > + * three_regions       The three regions that need to be applied now
> > + * expected            start/end addresses of monitoring target regions that
> > + *                     'three_regions' are applied
> > + * nr_expected         the number of addresses in 'expected'
> > + *
> > + * The memory mapping of the target processes changes dynamically.  To follow
> > + * the change, DAMON periodically reads the mappings, simplifies it to the
> > + * three regions, and updates the monitoring target regions to fit in the three
> > + * regions.  The update of current target regions is the role of
> > + * 'damon_apply_three_regions()'.
> > + *
> > + * This test passes the given target regions and the new three regions that
> > + * need to be applied to the function and check whether it updates the regions
> > + * as expected.
> > + */
> > +static void damon_do_test_apply_three_regions(struct kunit *test,
> > +                               unsigned long *regions, int nr_regions,
> > +                               struct region *three_regions,
> > +                               unsigned long *expected, int nr_expected)
> > +{
> > +       struct damon_task *t;
> > +       struct damon_region *r;
> > +       int i;
> > +
> > +       t = damon_new_task(42);
> > +       for (i = 0; i < nr_regions / 2; i++) {
> > +               r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
> > +               damon_add_region_tail(r, t);
> > +       }
> > +       damon_add_task_tail(t);
> > +
> > +       damon_apply_three_regions(t, three_regions);
> > +
> > +       for (i = 0; i < nr_expected / 2; i++) {
> > +               r = damon_nth_region_of(t, i);
> > +               KUNIT_EXPECT_EQ(test, r->vm_start, expected[i * 2]);
> > +               KUNIT_EXPECT_EQ(test, r->vm_end, expected[i * 2 + 1]);
> > +       }
> > +
> > +       damon_cleanup_global_state();
> > +}
> > +
> > +/* below 4 functions test differnt inputs for 'damon_apply_three_regions()' */
> 
> Spelling. Also, I think this comment doesn't really say anything that
> you cannot get from reading the code. Maybe provide some more details?
> Maybe add why you picked the inputs that you did?

Good point.  Will add more comments your points in next spin.

> 
> > +static void damon_test_apply_three_regions1(struct kunit *test)
> > +{
> > +       /* 10-20-30, 50-55-57-59, 70-80-90-100 */
> > +       unsigned long regions[] = {10, 20, 20, 30, 50, 55, 55, 57, 57, 59,
> > +                               70, 80, 80, 90, 90, 100};
> > +       /* 5-27, 45-55, 73-104 */
> > +       struct region new_three_regions[3] = {
> > +               (struct region){.start = 5, .end = 27},
> > +               (struct region){.start = 45, .end = 55},
> > +               (struct region){.start = 73, .end = 104} };
> > +       /* 5-20-27, 45-55, 73-80-90-104 */
> > +       unsigned long expected[] = {5, 20, 20, 27, 45, 55,
> > +                               73, 80, 80, 90, 90, 104};
> > +
> > +       damon_do_test_apply_three_regions(test, regions, ARRAY_SIZE(regions),
> > +                       new_three_regions, expected, ARRAY_SIZE(expected));
> > +}
[...]
> > +
> > +static void damon_test_kdamond_need_stop(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_TRUE(test, kdamond_need_stop());
> 
> This doesn't look like a useful test, or a useful function. Why even
> check if the function always returns true? And if it doesn't always
> return true, then this test is not hermetic which is bad unit testing
> practice.

You're right, will remove the test code in next spin.

Thank you so much for your reviews!


Thanks,
SeongJae Park

> 
[...] 
