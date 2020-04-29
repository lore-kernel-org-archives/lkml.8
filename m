Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A003C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0277F2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UF05wFhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgD2EPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbgD2EPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:15:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595B8C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 21:15:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so429033wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWpKK4uT+PVwZpE/ncqJMXQ2HE/w9xC+J5GL7UJZT8o=;
        b=UF05wFhwncnOVwKvWyK42is1X0QbpW6zLHBIeaOxRpZHnmrBRtAqKfRACkG0CtSKbp
         ME2RiQfhxXE3SvVZA4MdJwe+I13RO4lhivLYXLlL0Fq5PC53zQxdNfPMJFOnm3zseDZi
         9dSkKEQJxAb1GqfHtlC8djBYkPsMM9ZyBIsELs0FAzVUKR9V6C5tyHrnbNmcNskXNuRW
         FIZylknU0kE37lfs35zFw3kelYYoSFuy/wwWmTVYkEk9GTt2DZ6OthKu1Dqrz+RM78MK
         0mjhtgMu2Uvbz4jdbxjXRCuhOnWZcLn7wMpvM3k8BMBtUMBub1h+SVK5lNIw3BoZ/vDm
         6JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWpKK4uT+PVwZpE/ncqJMXQ2HE/w9xC+J5GL7UJZT8o=;
        b=XjYAHDlJMbZFqFrpyfsSqKmHPuEKvuKgIhDEbMyc9RXi9QGM91xxvBwNso2eZ2hmU9
         VZpX8pF1QFqd8LFeshqC7CroFSbbGWbgI402ZiFwLvnBRYAR0KIy2Cc1zTalclPA4azx
         53Ni+o1kC6a/a8Ale1q/WHkT5RoZpqyNES57UNj3VrkRuj6VDmwwYdDg1gWlg6Lb/tTN
         lCnhVAfvA+0VRW9ruTNVTUNfZkDHUK4Bna5eHHzCoq3vbGxffGg4c3a8OZ8/lVkZ/hYe
         9/WCE3yjvbtS8fKgPMGK56GZYe2fPDz1G6cBZv918Y02CXchn6JGNPbJOVshyDzWrIy+
         4mrg==
X-Gm-Message-State: AGi0PuaT2kSmj50ckcR6poUy1pL1bwv7TAW/RuEXHncnM6bHw+B49P9k
        Qaj2W19YRhV38V9IEpIefCkvGhXivfcNz7LLi9tqMA==
X-Google-Smtp-Source: APiQypJoq3TUpOIbj3dGxpP4qYZI9Agw3ba6KlHi8hH9GsQNo0WDV0jg801yaB5vV7clg5rjpc1NT0wJ5dcWmjBAuxc=
X-Received: by 2002:a1c:f014:: with SMTP id a20mr809438wmb.86.1588133749465;
 Tue, 28 Apr 2020 21:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200408035637.110858-1-sboyd@kernel.org> <ba25547c4416059310606b8b92bd2d9fe7f82df4.camel@fi.rohmeurope.com>
In-Reply-To: <ba25547c4416059310606b8b92bd2d9fe7f82df4.camel@fi.rohmeurope.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Apr 2020 12:15:37 +0800
Message-ID: <CABVgOSnyudG-GYizLj8LThv5J54bWB=MX1e+arh6CvUd94On=A@mail.gmail.com>
Subject: Re: [PATCH/RFC] clk: gate: Add some kunit test suites
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 7:46 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
>
> Hello Stephen & All,
>
> Prologue:
>
> I have been traumatized in the past - by unit tests :) Thus I am always
> a bit jumpy when I see people adding UTs. I always see the inertia UTs
> add to development - when people change anything they must also change
> impacted UTs - and every unnecessary UT case is actually burden. I was
> once buried under such burden.. Back at those times I quite often found
> myself wondering why I spend two days fixing UT cases after I did a
> necessary code change which took maybe 10 minutes. Please see my
> comments knowing this history and do your decisions based on less
> biased - brighter understanding :]
>
>

Hey Matti,

As someone who's definitely wasted a lot of time fixing
poorly-thought-through tests, but who is nevertheless working
enthusiastically on KUnit, I wanted to respond quickly here.

Certainly, the goal is not to reduce development velocity, though it
is redistributed a bit: hopefully the extra time spent updating tests
will be more than paid back in identifying and fixing bugs earlier, as
well as making testing one's own changes simpler. Only time will tell
if we're right or not, but if they turn out to cause more problems
than they solve we can always adjust or remove them. I remain
optimistic, though.

I do think that these tests are unlikely to increase the burden on
developers much: they seem mostly to test interfaces and behaviour
which is used quite a bit elsewhere in the kernel: changes that break
them seem likely to be reasonably disruptive anyway, so these tests
aren't going to add too much to that overall, and may ultimately make
things a bit simpler by helping to document and verify the changes.

A few other notes inline:

> On Tue, 2020-04-07 at 20:56 -0700, Stephen Boyd wrote:
> > Test various parts of the clk gate implementation with the kunit
> > testing
> > framework.
> >
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: <kunit-dev@googlegroups.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >
> > This patch is on top of this series[1] that allows the clk
> > framework to be selected by Kconfig language.
> >
> > [1]
> > https://lore.kernel.org/r/20200405025123.154688-1-sboyd@kernel.org
> >
> >  drivers/clk/Kconfig         |   8 +
> >  drivers/clk/Makefile        |   1 +
> >  drivers/clk/clk-gate-test.c | 481
> > ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/clk/clk-gate-test.c
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 6ea0631e3956..66193673bcdf 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -377,4 +377,12 @@ source "drivers/clk/ti/Kconfig"
> >  source "drivers/clk/uniphier/Kconfig"
> >  source "drivers/clk/zynqmp/Kconfig"
> >
> > +# Kunit test cases
> > +config CLK_GATE_TEST
> > +     tristate "Basic gate type Kunit test"
> > +     depends on KUNIT
> > +     default KUNIT
> > +     help
> > +       Kunit test for the basic clk gate type.
> > +
> >  endif
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index f4169cc2fd31..0785092880fd 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -7,6 +7,7 @@ obj-$(CONFIG_COMMON_CLK)      +=3D clk-divider.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-fixed-factor.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-fixed-rate.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-gate.o
> > +obj-$(CONFIG_CLK_GATE_TEST)  +=3D clk-gate-test.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-multiplier.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-mux.o
> >  obj-$(CONFIG_COMMON_CLK)     +=3D clk-composite.o
> > diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-
> > test.c
> > new file mode 100644
> > index 000000000000..b1d6c21e9698
> > --- /dev/null
> > +++ b/drivers/clk/clk-gate-test.c
> > @@ -0,0 +1,481 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for clk gate basic type
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <kunit/test.h>
> > +
> > +static void clk_gate_register_test_dev(struct kunit *test)
> > +{
> > +     struct clk_hw *ret;
> > +     struct platform_device *pdev;
> > +
> > +     pdev =3D platform_device_register_simple("test_gate_device", -1,
> > NULL, 0);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> > +
> > +     ret =3D clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0,
> > NULL,
> > +                                0, 0, NULL);
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
> > +     KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
> > +     KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
> > +
> > +     clk_hw_unregister_gate(ret);
> > +     platform_device_put(pdev);
> > +}
> > +
> > +static void clk_gate_register_test_parent_names(struct kunit *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *ret;
> > +
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         1000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +
> > +     ret =3D clk_hw_register_gate(NULL, "test_gate", "test_parent", 0,
> > NULL,
> > +                                0, 0, NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > +
> > +     clk_hw_unregister_gate(ret);
> > +     clk_hw_unregister_fixed_rate(parent);
> > +}
> > +
> > +static void clk_gate_register_test_parent_data(struct kunit *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *ret;
> > +     struct clk_parent_data pdata =3D { };
> > +
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         1000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +     pdata.hw =3D parent;
> > +
> > +     ret =3D clk_hw_register_gate_parent_data(NULL, "test_gate",
> > &pdata, 0,
> > +                                            NULL, 0, 0, NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > +
> > +     clk_hw_unregister_gate(ret);
> > +     clk_hw_unregister_fixed_rate(parent);
> > +}
> > +
> > +static void clk_gate_register_test_parent_data_legacy(struct kunit
> > *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *ret;
> > +     struct clk_parent_data pdata =3D { };
> > +
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         1000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +     pdata.name =3D "test_parent";
> > +
> > +     ret =3D clk_hw_register_gate_parent_data(NULL, "test_gate",
> > &pdata, 0,
> > +                                            NULL, 0, 0, NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > +
> > +     clk_hw_unregister_gate(ret);
> > +     clk_hw_unregister_fixed_rate(parent);
> > +}
> > +
> > +static void clk_gate_register_test_parent_hw(struct kunit *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *ret;
> > +
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         1000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +
> > +     ret =3D clk_hw_register_gate_parent_hw(NULL, "test_gate", parent,
> > 0, NULL,
> > +                                          0, 0, NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
> > +     KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
> > +
> > +     clk_hw_unregister_gate(ret);
> > +     clk_hw_unregister_fixed_rate(parent);
> > +}
> > +
> > +static void clk_gate_register_test_hiword_invalid(struct kunit
> > *test)
> > +{
> > +     struct clk_hw *ret;
> > +
> > +     ret =3D clk_hw_register_gate(NULL, "test_gate", NULL, 0, NULL,
> > +                                20, CLK_GATE_HIWORD_MASK, NULL);
> > +
> > +     KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
> > +}
>
> Do we really need all these registration tests? I guess most of the
> code path would be tested by just one of these - how much value we add
> by adding rest of the registration cases? (just wondering)
>

The advantage of having multiple tests here is that it's really
obvious if just one of these function breaks: that's probably not
enormously likely, but there's also not much of a cost to having them
=E2=80=94 these test would run pretty quickly, and wouldn't be too expensiv=
e
to change in the unlikely event that was necessary.

> > +
> > +static struct kunit_case clk_gate_register_test_cases[] =3D {
> > +     KUNIT_CASE(clk_gate_register_test_dev),
> > +     KUNIT_CASE(clk_gate_register_test_parent_names),
> > +     KUNIT_CASE(clk_gate_register_test_parent_data),
> > +     KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
> > +     KUNIT_CASE(clk_gate_register_test_parent_hw),
> > +     KUNIT_CASE(clk_gate_register_test_hiword_invalid),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite clk_gate_register_test_suite =3D {
> > +     .name =3D "clk-gate-register-test",
> > +     .test_cases =3D clk_gate_register_test_cases,
> > +};
> > +
> > +struct clk_gate_test_context {
> > +     void __iomem *fake_mem;
> > +     struct clk_hw *hw;
> > +     struct clk_hw *parent;
> > +     u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
> > +};
> > +
> > +static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct
> > kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx;
> > +
> > +     test->priv =3D ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> > +     ctx->fake_mem =3D (void __force __iomem *)&ctx->fake_reg;
> > +
> > +     return ctx;
> > +}
> > +
> > +static void clk_gate_test_parent_rate(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +     struct clk_hw *parent =3D ctx->parent;
> > +     struct clk_hw *hw =3D ctx->hw;
> > +     unsigned long prate =3D clk_hw_get_rate(parent);
> > +     unsigned long rate =3D clk_hw_get_rate(hw);
> > +
> > +     KUNIT_EXPECT_EQ(test, prate, rate);
> > +}
> > +
> > +static void clk_gate_test_enable(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +     struct clk_hw *parent =3D ctx->parent;
> > +     struct clk_hw *hw =3D ctx->hw;
> > +     struct clk *clk =3D hw->clk;
> > +     int ret;
> > +     u32 enable_val =3D BIT(5);
> > +
> > +     ret =3D clk_prepare_enable(clk);
> > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +     KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> > +}
>
> Is this really necessary? Wouldn't most of this be tested by
> clk_gate_test_disable()?
>

While _enable and _disable are likely pretty similar, having both
tests here would catch things like copy-paste bugs from one to the
other, which is probably worth the extra test. Particularly given that
basically all of the functions tested are actually different
functions.


> > +
> > +static void clk_gate_test_disable(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +     struct clk_hw *parent =3D ctx->parent;
> > +     struct clk_hw *hw =3D ctx->hw;
> > +     struct clk *clk =3D hw->clk;
> > +     int ret;
> > +     u32 enable_val =3D BIT(5);
> > +     u32 disable_val =3D 0;
> > +
> > +     ret =3D clk_prepare_enable(clk);
> > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > +     KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> > +
> > +     clk_disable_unprepare(clk);
> > +     KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> > +}
> > +
> > +static struct kunit_case clk_gate_test_cases[] =3D {
> > +     KUNIT_CASE(clk_gate_test_parent_rate),
> > +     KUNIT_CASE(clk_gate_test_enable),
> > +     KUNIT_CASE(clk_gate_test_disable),
> > +     {}
> > +};
> > +
> > +static int clk_gate_test_init(struct kunit *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *hw;
> > +     struct clk_gate_test_context *ctx;
> > +
> > +     ctx =3D clk_gate_test_alloc_ctx(test);
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         2000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +
> > +     hw =3D clk_hw_register_gate_parent_hw(NULL, "test_gate", parent,
> > 0,
> > +                                         ctx->fake_mem, 5, 0, NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> > +
> > +     ctx->hw =3D hw;
> > +     ctx->parent =3D parent;
> > +
> > +     return 0;
> > +}
> > +
> > +static void clk_gate_test_exit(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +
> > +     clk_hw_unregister_gate(ctx->hw);
> > +     clk_hw_unregister_fixed_rate(ctx->parent);
> > +     kfree(ctx);
> > +}
>
> Aren't these init and exit actually covering some of the things tested
> in clk_gate_register_test_cases? Perhaps we could reduce some tests or
> use some test functions as init/exit?
>

Logically, these init/exit functions are not supposed to be testing
anything in and of themselves, just setting up the environment for
other tests.
I do like the idea of reducing code duplication by, say, moving some
of the code into a separate helper function. I'm a little wary of
actually using the same function as an init function as a test: that
seems more confusing than the duplication to me, but that's just
personal preference, I think.

> > +
> > +static struct kunit_suite clk_gate_test_suite =3D {
> > +     .name =3D "clk-gate-test",
> > +     .init =3D clk_gate_test_init,
> > +     .exit =3D clk_gate_test_exit,
> > +     .test_cases =3D clk_gate_test_cases,
> > +};
> > +
> > +static void clk_gate_test_invert_enable(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +     struct clk_hw *parent =3D ctx->parent;
> > +     struct clk_hw *hw =3D ctx->hw;
> > +     struct clk *clk =3D hw->clk;
> > +     int ret;
> > +     u32 enable_val =3D 0;
> > +
> > +     ret =3D clk_prepare_enable(clk);
> > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > +
> > +     KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
> > +     KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
> > +}
>
> Is this really adding value after clk_gate_test_invert_disable() has
> passed?
>
> +
> > +static void clk_gate_test_invert_disable(struct kunit *test)
> > +{
> > +     struct clk_gate_test_context *ctx =3D test->priv;
> > +     struct clk_hw *parent =3D ctx->parent;
> > +     struct clk_hw *hw =3D ctx->hw;
> > +     struct clk *clk =3D hw->clk;
> > +     int ret;
> > +     u32 enable_val =3D 0;
> > +     u32 disable_val =3D BIT(15);
> > +
> > +     ret =3D clk_prepare_enable(clk);
> > +     KUNIT_ASSERT_EQ(test, ret, 0);
> > +     KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
> > +
> > +     clk_disable_unprepare(clk);
> > +     KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
> > +     KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
> > +}
> > +
> > +static struct kunit_case clk_gate_test_invert_cases[] =3D {
> > +     KUNIT_CASE(clk_gate_test_invert_enable),
> > +     KUNIT_CASE(clk_gate_test_invert_disable),
> > +     {}
> > +};
> > +
> > +static int clk_gate_test_invert_init(struct kunit *test)
> > +{
> > +     struct clk_hw *parent;
> > +     struct clk_hw *hw;
> > +     struct clk_gate_test_context *ctx;
> > +
> > +     ctx =3D clk_gate_test_alloc_ctx(test);
> > +     parent =3D clk_hw_register_fixed_rate(NULL, "test_parent", NULL,
> > 0,
> > +                                         2000000);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> > +
> > +     ctx->fake_reg =3D BIT(15); /* Default to off */
> > +     hw =3D clk_hw_register_gate_parent_hw(NULL, "test_gate", parent,
> > 0,
> > +                                         ctx->fake_mem, 15,
> > +                                         CLK_GATE_SET_TO_DISABLE,
> > NULL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> > +
> > +     ctx->hw =3D hw;
> > +     ctx->parent =3D parent;
> > +
> > +     return 0;
> > +}
>
> Aren't these init and exit actually covering some of the things tested
> in clk_gate_register_test_cases? Perhaps we could reduce some tests or
> use some test functions as init/exit?

As above, I personally like having the test versions as well, as it
ensures that there's at least one test showing the failure in its
actual test function. But reusing the actual code wouldn't be a
problem, and is probably just a matter of taste.

> I stopped reviewing here - I think you know what I was up-to and you
> are the best experts to evaluate whether there is something to
> squash/drop also in the rest of the tests :)
>
>
> Epilogue:
>
> In general, I would be very careful when adding UT-code and I would try
> to minimize the required test changes when for example one of the clk
> APIs require a change. (I know, the test changes are least thing to
> worry if these APIs need change - but effort is still cumulative and if
> we can avoid some - we should).
>
> I don't mean to be disrespectful. I know my place in the food-chain :p
> Besides, I have seen the great work Stephen has been doing with clk -
> and I believe he knows what he is doing. But sometimes little poking
> can invoke new thoughts :grin: You can ignore my comments if they make
> no sense to you.
>
> Best Regards
>   --Matti
> >
>

While I obviously sit more on the "yes" side of the unit-testing
fence, you've definitely raised some interesting points. Personally,
I'd really like to see this test go in (whether as-is, or with minor
adjustments), but writing up a KUnit "testing style guide" or similar
is on my to-do list, and I'm definitely going to want to think more
about how best to handle some of these situations (and better
articulate why).

Cheers,
-- David
