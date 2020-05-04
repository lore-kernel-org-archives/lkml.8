Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BABC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA12820705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pe+ijt2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgEDUUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEDUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:20:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:20:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so342408pgg.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xaFDE4g4p/pfu65Jhz0iAnoQG/IN6780tnTez8q5sq0=;
        b=Pe+ijt2fVsN12xkG1GsTH5/i4/DMGMsbivxvAUVhLlaea1juEJPoGGxo9jdCjrT4Fm
         yyApy8FCO4P1zOD3PHHlUKlY3umo9vNMZmUSqnYA5Hx0H2zbEZQ4fJNaEiSpFWFmj77/
         GkpEAKJBPdw+p9DT9xLRySHQWmZqXWR52ov+ctHADAFvqFkPB+4YxYkSUC3SOEiwXLrx
         j5Ta6MnZrpfz33WiOTn0LEbtXtS5LDwPQbda9efXrnCMXHy7a0wJBnlBroTZ6LQgSFBl
         sFqRSet5Ok0X8E/drIwANszW0/MoAPMRQyAQsgIVe6qEKMbzQBKekAfWLrWBGvxCNkLf
         +WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xaFDE4g4p/pfu65Jhz0iAnoQG/IN6780tnTez8q5sq0=;
        b=hi4DM072D9tt1xlumAUwipOa3xzsMioc6QAfgM6CQU6Q19D6WCpjXa2Ds+dJxy9zY6
         UMmuU5S+Jt9z0X6WAFDNNjT5bn2UlQ3pgjhci6y1212/4gG5drgffK9341Hlab6UzfWM
         elOyD1YXseEUIoRwWb58/AA03NZPf6d6YTA5y9VcvYjoVMDUeNmiGD6aDC3HwLcl6MTz
         Vt7GKHwsaSdOyU2+0hIZ/1DmF+/es1KxGV64i1D2IeKrQfOo5lZ13PsPIq3lxViRtIkm
         ro6h5FUfuzZcB/DYVpkQhC49jeL2JxndqP+5NSAbu1L5LTFR2fRiWv4qzHM5M3KnZ5y1
         9p/A==
X-Gm-Message-State: AGi0PuYDCTuyDGQJJJDdfGJZBK+1C+wEoWbVEo7C8Yp7A8NZMrCxsVma
        BKuVVwdfRVV15jQlv19azvWoqqX1iCnru0O9XhrLzQ==
X-Google-Smtp-Source: APiQypJsF9Yo6Q2MI0HNGKq/pvUM7NgV4bX31/MRnHpzQDfW/a8tY92Aqms0Xy5V6plfrHE22Fi4mm8m4rNjn7rGj6s=
X-Received: by 2002:a62:1a46:: with SMTP id a67mr17852037pfa.284.1588623599474;
 Mon, 04 May 2020 13:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200408035637.110858-1-sboyd@kernel.org> <ba25547c4416059310606b8b92bd2d9fe7f82df4.camel@fi.rohmeurope.com>
 <CABVgOSnyudG-GYizLj8LThv5J54bWB=MX1e+arh6CvUd94On=A@mail.gmail.com> <300c532bba46f4f963c3a6d80bf8f22261e44f56.camel@fi.rohmeurope.com>
In-Reply-To: <300c532bba46f4f963c3a6d80bf8f22261e44f56.camel@fi.rohmeurope.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 May 2020 13:19:48 -0700
Message-ID: <CAFd5g453v9c_7DrXmmxZQM_OGB2kwiy7gWdODXaxF6cg76G-pg@mail.gmail.com>
Subject: Re: [PATCH/RFC] clk: gate: Add some kunit test suites
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "davidgow@google.com" <davidgow@google.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 10:54 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Hello David, & All
>
> This review and mail is more for pointing out the downsides of UTs. I
> am not demanding any changes, these comments can be seen as 'nit's.

Understood.

> On Wed, 2020-04-29 at 12:15 +0800, David Gow wrote:
> > On Tue, Apr 14, 2020 at 7:46 PM Vaittinen, Matti
> > <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> > > Hello Stephen & All,
> > >
> > > Prologue:
> > >
> > > I have been traumatized in the past - by unit tests :) Thus I am
> > > always
> > > a bit jumpy when I see people adding UTs. I always see the inertia
> > > UTs
> > > add to development - when people change anything they must also
> > > change
> > > impacted UTs - and every unnecessary UT case is actually burden. I
> > > was
> > > once buried under such burden.. Back at those times I quite often
> > > found
> > > myself wondering why I spend two days fixing UT cases after I did a
> > > necessary code change which took maybe 10 minutes. Please see my
> > > comments knowing this history and do your decisions based on less
> > > biased - brighter understanding :]
> > >
> > >
> >
> > Hey Matti,
> >
> > As someone who's definitely wasted a lot of time fixing
> > poorly-thought-through tests, but who is nevertheless working
> > enthusiastically on KUnit, I wanted to respond quickly here.
>
> I appreciate your reply. And I appreciate your (and others) work on
> KUinit. I don't think UTs are bad. I believe UTs are great and
> powerfull tool - when used on specific occasions. But UTs definitely
> are "double-edged sword" - you can hit your own leg.

Sure, I saw you just added a unit test, so I would assume that you
don't think that UTs are inherently bad :-)

> > Certainly, the goal is not to reduce development velocity, though it
> > is redistributed a bit: hopefully the extra time spent updating tests
> > will be more than paid back in identifying and fixing bugs earlier,
> > as
> > well as making testing one's own changes simpler. Only time will tell
> > if we're right or not, but if they turn out to cause more problems
> > than they solve we can always adjust or remove them. I remain
> > optimistic, though.
>
> Fixing and identifying bugs is definitely "the thing" in UTs. But what
> comes to weighing the benefits of UTs Vs. downsides - that's hard.
> First thing on that front is to understand the cost of UTs. And in my
> experience - many people underestimate that. It's easy too see things
> black & white and think UTs are only good - which is not true.
>
> UT cases are code which must be maintained as any code. And we must
> never add code which is not beneficial as maintaining it is work. We do
> constantly work to decrease amount of code to be maintaned - UTs are no
> exception - all code is a burden. Unnecessary code is burden with no
> purpose. And UTs have no other purpose but to point out mistakes. Only

I am in agreement with everything you said so far.

> good test is a test that is failing and pointing out a bug which would
> have otherwise gone unnoticed. Passing test is a waste.

Not to be uncharitable in how I read this, but I don't think this is
quite right. I think we would all agree that a test that *cannot* fail
is a waste, but on the other hand, you should never submit code that
doesn't pass *good tests*, right? Like you wrote tests for your linear
range stuff to verify that it worked as expected; I don't know if some
of the tests didn't pass on the first try, but you did ultimately fix
all the issues, and submitted only tests that pass, right? I am pretty
sure no one would accept code accompanied with tests that don't pass.

So would a better way to phrase this be: "tests that can only pass are
a waste"? Or maybe, "tests that don't provide useful information on a
failure are a waste"?

> So key thing when considering if adding a test is beneficial is whether
> the test is likely to point out a bug (in early phase). A bug that
> would otherwise have gone through unnoticed.

Why not a bug later on? On another project, I noticed a piece of code
that kept breaking, so I added a test for that piece of code, and
people stopped breaking it: mission accomplished, right?

>
> > I do think that these tests are unlikely to increase the burden on
> > developers much:
>
> All code which uses kernel APIs is increasing burden for someone who
> needs to change the API. Much can be discussed ;)
>
> >  they seem mostly to test interfaces and behaviour
> > which is used quite a bit elsewhere in the kernel: changes that break
> > them seem likely to be reasonably disruptive anyway, so these tests
> > aren't going to add too much to that overall,
>
> This statement is valid for almost all exported kernel APIs - yet
> adding tests for all APIs is definitely a bad idea. The effort is

I don't understand, can you elaborate? From my experience, APIs are
frequently one of the most valuable places to test.

> cumulative. We should never add new code just because maintenance
> effort is relatively small. We must only add code if it adds value.

I agree with this statement, but I don't see how it shows that API
testing is inherently bad. I know you are countering David's statement
that it doesn't add much cost; however, I think that API testing not
only doesn't add much cost, if done properly, I think it actually
reduces future effort in changing those APIs.

> >  and may ultimately make
> > things a bit simpler by helping to document and verify the changes.
>
> Yes. Definitely. But we must never deny that all added (test) code adds
> work. And do weighing pros an cons only after that. Danger of UTs is
> that we don't admit the cons.

True. There is no magic bullet here. UTs are but one tool in a
toolbox; there are other tools better suited to solve some problems,
and no problem is likely to be solved well if the person using the
tool uses the tool improperly. I don't think anyone here thinks that
UTs are inherently good and all UTs make all code better.

> > A few other notes inline:
> >
> > > On Tue, 2020-04-07 at 20:56 -0700, Stephen Boyd wrote:
> > > > Test various parts of the clk gate implementation with the kunit
> > > > testing
> > > > framework.
> > > >
> > > > Cc: Brendan Higgins <brendanhiggins@google.com>
> > > > Cc: <kunit-dev@googlegroups.com>
> > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > ---
> > > >
> > > > This patch is on top of this series[1] that allows the clk
> > > > framework to be selected by Kconfig language.
> > > >
> > > > [1]
> > > > https://lore.kernel.org/r/20200405025123.154688-1-sboyd@kernel.org
> > > >
> > > >  drivers/clk/Kconfig         |   8 +
> > > >  drivers/clk/Makefile        |   1 +
> > > >  drivers/clk/clk-gate-test.c | 481
> > > > ++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 490 insertions(+)
> > > >  create mode 100644 drivers/clk/clk-gate-test.c
> > > >
> > > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > > index 6ea0631e3956..66193673bcdf 100644
> > > > --- a/drivers/clk/Kconfig
> > > > +++ b/drivers/clk/Kconfig
> > > > @@ -377,4 +377,12 @@ source "drivers/clk/ti/Kconfig"
> > > >  source "drivers/clk/uniphier/Kconfig"
> > > >  source "drivers/clk/zynqmp/Kconfig"
> > > >
> > > > +# Kunit test cases
> > > > +config CLK_GATE_TEST
> > > > +     tristate "Basic gate type Kunit test"
> > > > +     depends on KUNIT
> > > > +     default KUNIT
> > > > +     help
> > > > +       Kunit test for the basic clk gate type.
> > > > +
> > > >  endif
> > > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > > index f4169cc2fd31..0785092880fd 100644
> > > > --- a/drivers/clk/Makefile
> > > > +++ b/drivers/clk/Makefile
> > > > @@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK)      +=3D clk-divider.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-fixed-factor.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-fixed-rate.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-gate.o
> > > > +obj-$(CONFIG_CLK_GATE_TEST)  +=3D clk-gate-test.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-multiplier.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-mux.o
> > > >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-composite.o
> > > > diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-
> > > > test.c
> > > > new file mode 100644
> > > > index 000000000000..b1d6c21e9698
> > > > --- /dev/null
> > > > +++ b/drivers/clk/clk-gate-test.c
> > > > @@ -0,0 +1,481 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * KUnit test for clk gate basic type
> > > > + */
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +#include <kunit/test.h>
> > > > +
> > > > +static void clk_gate_register_test_dev(struct kunit *test)
> > > > +{
> > > > +     struct clk_hw *ret;
> > > > +     struct platform_device *pdev;
> > > > +
> > > > +     pdev =3D platform_device_register_simple("test_gate_device",
> > > > -1,
> > > > NULL, 0);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > > > +
> > > > +     ret =3D clk_hw_register_gate(&pdev->dev, "test_gate", NULL,
> > > > 0,
> > > > NULL,
> > > > +                                0, 0, NULL);
> > > > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
> > > > +     KUNIT_EXPECT_STREQ(test, "test_gate",
> > > > clk_hw_get_name(ret));
> > > > +     KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> > > > +
> > > > +     clk_hw_unregister_gate(ret);
> > > > +     platform_device_put(pdev);
> > > > +}
> > > > +
> > > > +static void clk_gate_register_test_parent_names(struct kunit
> > > > *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *ret;
> > > > +
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         1000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +
> > > > +     ret =3D clk_hw_register_gate(NULL, "test_gate",
> > > > "test_parent", 0,
> > > > NULL,
> > > > +                                0, 0, NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > > > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > > > +
> > > > +     clk_hw_unregister_gate(ret);
> > > > +     clk_hw_unregister_fixed_rate(parent);
> > > > +}
> > > > +
> > > > +static void clk_gate_register_test_parent_data(struct kunit
> > > > *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *ret;
> > > > +     struct clk_parent_data pdata =3D { };
> > > > +
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         1000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +     pdata.hw =3D parent;
> > > > +
> > > > +     ret =3D clk_hw_register_gate_parent_data(NULL, "test_gate",
> > > > &pdata, 0,
> > > > +                                            NULL, 0, 0, NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > > > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > > > +
> > > > +     clk_hw_unregister_gate(ret);
> > > > +     clk_hw_unregister_fixed_rate(parent);
> > > > +}
> > > > +
> > > > +static void clk_gate_register_test_parent_data_legacy(struct
> > > > kunit
> > > > *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *ret;
> > > > +     struct clk_parent_data pdata =3D { };
> > > > +
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         1000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +     pdata.name =3D "test_parent";
> > > > +
> > > > +     ret =3D clk_hw_register_gate_parent_data(NULL, "test_gate",
> > > > &pdata, 0,
> > > > +                                            NULL, 0, 0, NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > > > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > > > +
> > > > +     clk_hw_unregister_gate(ret);
> > > > +     clk_hw_unregister_fixed_rate(parent);
> > > > +}
> > > > +
> > > > +static void clk_gate_register_test_parent_hw(struct kunit *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *ret;
> > > > +
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         1000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +
> > > > +     ret =3D clk_hw_register_gate_parent_hw(NULL, "test_gate",
> > > > parent,
> > > > 0, NULL,
> > > > +                                          0, 0, NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > > > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > > > +
> > > > +     clk_hw_unregister_gate(ret);
> > > > +     clk_hw_unregister_fixed_rate(parent);
> > > > +}
> > > > +
> > > > +static void clk_gate_register_test_hiword_invalid(struct kunit
> > > > *test)
> > > > +{
> > > > +     struct clk_hw *ret;
> > > > +
> > > > +     ret =3D clk_hw_register_gate(NULL, "test_gate", NULL, 0,
> > > > NULL,
> > > > +                                20, CLK_GATE_HIWORD_MASK, NULL);
> > > > +
> > > > +     KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
> > > > +}
> > >
> > > Do we really need all these registration tests? I guess most of the
> > > code path would be tested by just one of these - how much value we
> > > add
> > > by adding rest of the registration cases? (just wondering)
> > >
> >
> > The advantage of having multiple tests here is that it's really
> > obvious if just one of these function breaks: that's probably not
> > enormously likely,
>
> My point exactly.

I honestly don't know. TBH, I think I have a good idea what a good
test case should look like, as for measuring how useful a test case
is, that's harder and I am not sure anyone really has a great answer
for this. I just read a literature review on measuring code quality
and they concluded that coverage provided only a weak signal at best
and the best signal came from "engineers' perception of code quality".

The way I usually write tests is: I write my code first. I then write
some unit tests to exercise some basic features of my code. Then I
write some integration or end-to-end tests to make sure my code "fits"
in the job it's supposed to do. If everything works, I am done. If
not, then I start writing tests to narrow down what doesn't work the
way I expect. Eventually I write a test that clearly exposes the
issue. I fix the issue, and I rerun the tests to make sure they flip
from fail to pass. I then look through all the new tests I wrote and
try to make a judgement call about how useful I think the test will be
in the future. (I am curious what other people's thoughts are on this
approach.)

When it comes down to it, I don't know this code base well enough to
know whether all these registration tests are useful, but I think, as
they are written, they are easy to understand, and that is what I was
reviewing.

This is all a very long way of saying: "I think this is a question for
Stephen" :-)

> >  but there's also not much of a cost to having them
>
> And this is the other side of the equation. And I leave this estimation
> to others - I just want to point out that imbalance in this equation is
> what usually leads to writing excessive amounts of tests - which
> eventually just hinders development with little or no benefits. But as
> I said, I will leave this to smarter guys to evaluate. Just wanted to
> point out that this should be considered :)

Fair enough. And I think that's great! Unit testing is "new" to the
Linux kernel and I want to make sure we do it the right way. From my
experience, I think the best way to bring about a "new" thing like
this is to get someone who is overly liberal in adopting the new
thing, someone who is more conservative, and maybe some invested, but
less opinionated bystanders and make them all try to agree.

Once we have debated over a number of tests, it should start getting
easier. Hopefully, a good pattern will emerge and people will start
following that pattern.

> > =E2=80=94 these test would run pretty quickly, and wouldn't be too expe=
nsive
> > to change in the unlikely event that was necessary.
> >
> > > > +
> > > > +static struct kunit_case clk_gate_register_test_cases[] =3D {
> > > > +     KUNIT_CASE(clk_gate_register_test_dev),
> > > > +     KUNIT_CASE(clk_gate_register_test_parent_names),
> > > > +     KUNIT_CASE(clk_gate_register_test_parent_data),
> > > > +     KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
> > > > +     KUNIT_CASE(clk_gate_register_test_parent_hw),
> > > > +     KUNIT_CASE(clk_gate_register_test_hiword_invalid),
> > > > +     {}
> > > > +};
> > > > +
> > > > +static struct kunit_suite clk_gate_register_test_suite =3D {
> > > > +     .name =3D "clk-gate-register-test",
> > > > +     .test_cases =3D clk_gate_register_test_cases,
> > > > +};
> > > > +
> > > > +struct clk_gate_test_context {
> > > > +     void __iomem *fake_mem;
> > > > +     struct clk_hw *hw;
> > > > +     struct clk_hw *parent;
> > > > +     u32 fake_reg; /* Keep at end, KASAN can detect out of
> > > > bounds */
> > > > +};
> > > > +
> > > > +static struct clk_gate_test_context
> > > > *clk_gate_test_alloc_ctx(struct
> > > > kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx;
> > > > +
> > > > +     test->priv =3D ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > > > +     ctx->fake_mem =3D (void __force __iomem *)&ctx->fake_reg;
> > > > +
> > > > +     return ctx;
> > > > +}
> > > > +
> > > > +static void clk_gate_test_parent_rate(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +     struct clk_hw *parent =3D ctx->parent;
> > > > +     struct clk_hw *hw =3D ctx->hw;
> > > > +     unsigned long prate =3D clk_hw_get_rate(parent);
> > > > +     unsigned long rate =3D clk_hw_get_rate(hw);
> > > > +
> > > > +     KUNIT_EXPECT_EQ(test, prate, rate);
> > > > +}
> > > > +
> > > > +static void clk_gate_test_enable(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +     struct clk_hw *parent =3D ctx->parent;
> > > > +     struct clk_hw *hw =3D ctx->hw;
> > > > +     struct clk *clk =3D hw->clk;
> > > > +     int ret;
> > > > +     u32 enable_val =3D BIT(5);
> > > > +
> > > > +     ret =3D clk_prepare_enable(clk);
> > > > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +
> > > > +     KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> > > > +}
> > >
> > > Is this really necessary? Wouldn't most of this be tested by
> > > clk_gate_test_disable()?
> > >
> >
> > While _enable and _disable are likely pretty similar, having both
> > tests here would catch things like copy-paste bugs from one to the
> > other, which is probably worth the extra test. Particularly given
> > that
> > basically all of the functions tested are actually different
> > functions.
>
> The disable test already does the enable. Just adding another set of
> state checks before disable would verify whole thing, right? So, if I
> am not mistaken then - by minimum - these could be tested at one go.
> (If being beneficial at all).

True, but if enable is *super prone to breakage* then having a test
that tells you whether you broke it might still be more useful than
not. Stephen, thoughts?

> > > > +
> > > > +static void clk_gate_test_disable(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +     struct clk_hw *parent =3D ctx->parent;
> > > > +     struct clk_hw *hw =3D ctx->hw;
> > > > +     struct clk *clk =3D hw->clk;
> > > > +     int ret;
> > > > +     u32 enable_val =3D BIT(5);
> > > > +     u32 disable_val =3D 0;
> > > > +
> > > > +     ret =3D clk_prepare_enable(clk);
> > > > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +     KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> > > > +
> > > > +     clk_disable_unprepare(clk);
> > > > +     KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> > > > +}
> > > > +
> > > > +static struct kunit_case clk_gate_test_cases[] =3D {
> > > > +     KUNIT_CASE(clk_gate_test_parent_rate),
> > > > +     KUNIT_CASE(clk_gate_test_enable),
> > > > +     KUNIT_CASE(clk_gate_test_disable),
> > > > +     {}
> > > > +};
> > > > +
> > > > +static int clk_gate_test_init(struct kunit *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *hw;
> > > > +     struct clk_gate_test_context *ctx;
> > > > +
> > > > +     ctx =3D clk_gate_test_alloc_ctx(test);
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         2000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +
> > > > +     hw =3D clk_hw_register_gate_parent_hw(NULL, "test_gate",
> > > > parent,
> > > > 0,
> > > > +                                         ctx->fake_mem, 5, 0,
> > > > NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> > > > +
> > > > +     ctx->hw =3D hw;
> > > > +     ctx->parent =3D parent;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void clk_gate_test_exit(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +
> > > > +     clk_hw_unregister_gate(ctx->hw);
> > > > +     clk_hw_unregister_fixed_rate(ctx->parent);
> > > > +     kfree(ctx);
> > > > +}
> > >
> > > Aren't these init and exit actually covering some of the things
> > > tested
> > > in clk_gate_register_test_cases? Perhaps we could reduce some tests
> > > or
> > > use some test functions as init/exit?
> > >
> >
> > Logically, these init/exit functions are not supposed to be testing
> > anything in and of themselves, just setting up the environment for
> > other tests.
> > I do like the idea of reducing code duplication by, say, moving some
> > of the code into a separate helper function. I'm a little wary of
> > actually using the same function as an init function as a test: that
> > seems more confusing than the duplication to me, but that's just
> > personal preference, I think.
> >
> > > > +
> > > > +static struct kunit_suite clk_gate_test_suite =3D {
> > > > +     .name =3D "clk-gate-test",
> > > > +     .init =3D clk_gate_test_init,
> > > > +     .exit =3D clk_gate_test_exit,
> > > > +     .test_cases =3D clk_gate_test_cases,
> > > > +};
> > > > +
> > > > +static void clk_gate_test_invert_enable(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +     struct clk_hw *parent =3D ctx->parent;
> > > > +     struct clk_hw *hw =3D ctx->hw;
> > > > +     struct clk *clk =3D hw->clk;
> > > > +     int ret;
> > > > +     u32 enable_val =3D 0;
> > > > +
> > > > +     ret =3D clk_prepare_enable(clk);
> > > > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +
> > > > +     KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> > > > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> > > > +}
> > >
> > > Is this really adding value after clk_gate_test_invert_disable()
> > > has
> > > passed?
> > >
> > > +
> > > > +static void clk_gate_test_invert_disable(struct kunit *test)
> > > > +{
> > > > +     struct clk_gate_test_context *ctx =3D test->priv;
> > > > +     struct clk_hw *parent =3D ctx->parent;
> > > > +     struct clk_hw *hw =3D ctx->hw;
> > > > +     struct clk *clk =3D hw->clk;
> > > > +     int ret;
> > > > +     u32 enable_val =3D 0;
> > > > +     u32 disable_val =3D BIT(15);
> > > > +
> > > > +     ret =3D clk_prepare_enable(clk);
> > > > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > > > +     KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> > > > +
> > > > +     clk_disable_unprepare(clk);
> > > > +     KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> > > > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> > > > +}
> > > > +
> > > > +static struct kunit_case clk_gate_test_invert_cases[] =3D {
> > > > +     KUNIT_CASE(clk_gate_test_invert_enable),
> > > > +     KUNIT_CASE(clk_gate_test_invert_disable),
> > > > +     {}
> > > > +};
> > > > +
> > > > +static int clk_gate_test_invert_init(struct kunit *test)
> > > > +{
> > > > +     struct clk_hw *parent;
> > > > +     struct clk_hw *hw;
> > > > +     struct clk_gate_test_context *ctx;
> > > > +
> > > > +     ctx =3D clk_gate_test_alloc_ctx(test);
> > > > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent",
> > > > NULL,
> > > > 0,
> > > > +                                         2000000);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > > > +
> > > > +     ctx->fake_reg =3D BIT(15); /* Default to off */
> > > > +     hw =3D clk_hw_register_gate_parent_hw(NULL, "test_gate",
> > > > parent,
> > > > 0,
> > > > +                                         ctx->fake_mem, 15,
> > > > +                                         CLK_GATE_SET_TO_DISABLE
> > > > ,
> > > > NULL);
> > > > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> > > > +
> > > > +     ctx->hw =3D hw;
> > > > +     ctx->parent =3D parent;
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > Aren't these init and exit actually covering some of the things
> > > tested
> > > in clk_gate_register_test_cases? Perhaps we could reduce some tests
> > > or
> > > use some test functions as init/exit?
> >
> > As above, I personally like having the test versions as well, as it
> > ensures that there's at least one test showing the failure in its
> > actual test function. But reusing the actual code wouldn't be a
> > problem, and is probably just a matter of taste.
> >
> > > I stopped reviewing here - I think you know what I was up-to and
> > > you
> > > are the best experts to evaluate whether there is something to
> > > squash/drop also in the rest of the tests :)
> > >
> > >
> > > Epilogue:
> > >
> > > In general, I would be very careful when adding UT-code and I would
> > > try
> > > to minimize the required test changes when for example one of the
> > > clk
> > > APIs require a change. (I know, the test changes are least thing to
> > > worry if these APIs need change - but effort is still cumulative
> > > and if
> > > we can avoid some - we should).
> > >
> > > I don't mean to be disrespectful. I know my place in the food-chain
> > > :p
> > > Besides, I have seen the great work Stephen has been doing with clk
> > > -
> > > and I believe he knows what he is doing. But sometimes little
> > > poking
> > > can invoke new thoughts :grin: You can ignore my comments if they
> > > make
> > > no sense to you.
> > >
> > > Best Regards
> > >   --Matti
> >
> > While I obviously sit more on the "yes" side of the unit-testing
> > fence, you've definitely raised some interesting points. Personally,
> > I'd really like to see this test go in (whether as-is, or with minor
> > adjustments), but writing up a KUnit "testing style guide" or similar
> > is on my to-do list, and I'm definitely going to want to think more
> > about how best to handle some of these situations (and better
> > articulate why).
>
> I think this was more of my point than trying to demand actual changes
> here. Thank you for considering this! :) It is important to admit that
> _all_ code, whether test or implementation, require work and
> maintenance and slow down development. We should _always_ consider if
> adding a test is actually needed or if we could do it so that code
> change require less test changes.

Agreed.

> If I had all the power in the world I would never add a test for code
> which is clean and simple. It is likely to not be beneficial. I would

Probably semantics, but I would argue what is clean and simple to one
person is often not to someone else. A test at least gives you an
isolated context to test your assumptions.

> mostly utilize UTs at spots where the logic is somewhat complex and
> making a bug is likely. UTs do great job for example at verifying data
> parsing functions (I've voluntarily tested bunch of netlink message
> parsing code with UTs in some projects. I also added tests for
> linear_ranges helpers in series I recently submitted.) But UTs are more
> of a waste when added carelessly. I hope the UT documentation would
> also cover that front.
>
> Thanks for open discussion!

Thank *you*! It is good to have someone challenging our ideas. I get
worried when I don't have anyone questioning what I am doing: being
questioned is the only way that I can feel confident that what I am
doing is right. And in this case, I think you have leveled a number of
good points.

Cheers!
