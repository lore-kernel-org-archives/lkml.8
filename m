Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08457C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1752065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd77kxg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgETVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgETVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:40:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781ACC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:40:31 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id n11so4902407ilj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4uSck2D86dpTs469W5wKjloBJypVL8duZpRo2duhsQ=;
        b=vd77kxg4ETWr2fDRCnGcqjQ9TsU8wqOlCCoHGj4JIvrmNSarEtFJcltK1N7uaYm+9E
         v+BFEpuMeG1qJqv+Sw1FwGsoPWzLvAvBrVBT22386iJg/BgZ6XAIupsCEnCx83xA1zwg
         jBi/W61OZO0yv0Ae2RkpET6KWoBQSqLUGIu0kgCC228iTG9rA1y+f1G0tNInHCSOx5YE
         hb0l6JHXoTQYBR8cc6RekCMirCIgCKnuY8u6jc8hG2sT9/Na0JMmHWOfo+iW79pzXG42
         k1Ia55xi0wZbi1doYvG58vrW/mBXpEf9/iKIFXxeY6ZMFYqcddTnKYTk6l3RD/m5+H1g
         czLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4uSck2D86dpTs469W5wKjloBJypVL8duZpRo2duhsQ=;
        b=i8dMBLzv7csT9dI7vTo1fLd1OhjMQQU9jXHaXwLiITvGfBoZ+mJU6m7WL0wLF5tVYG
         sh79KCAExXCSmbgke6rMMi1bm47JXDs/U0QbzEjlNTxCF0QNrHbjqNaCS7LEDAc0EE5L
         +GEFyxDbliVbzOMn6xM8F4vGkJ8zUKJF1ISbBUYj5FeW2gfC8gu8hy6tW4VDUTKQeR9k
         rkiV089EItb6RpZY8JGO7qNBuB7QAcOAdxDClTn10LgXdneWH4kbP/wdwdZdTJ5IceX8
         CIabTifk7izY87/wTQjWOcOva3bK+Xpqfp6y5yyIR+/oUr0B5A93Ksa3UY4GLx/YWxle
         1FHw==
X-Gm-Message-State: AOAM531TqlyZr4N2oIkQgv0+hY1oyaYu1OU5fxJ3PdEROk2Qjw9SGIRV
        81mlQxcrB+OUNYAyiGQewSa+8D9irAUVqN5++KQ=
X-Google-Smtp-Source: ABdhPJz23uIlfGOeXr7jQekSJcilX37yG4hoY41Ib+Q53STXl7JIZKScUW9ZFwROs3p5jdVOaxQO3YGTKbGm43mw8lk=
X-Received: by 2002:a92:d591:: with SMTP id a17mr6081321iln.13.1590010830285;
 Wed, 20 May 2020 14:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589497311.git.syednwaris@gmail.com> <f4d924971feb15b0044eeefdd969b36747d2322b.1589497312.git.syednwaris@gmail.com>
 <20200515113202.GO185537@smile.fi.intel.com>
In-Reply-To: <20200515113202.GO185537@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 21 May 2020 03:10:18 +0530
Message-ID: <CACG_h5o5=DXFtNzHn+NzY0rRjbZXhjrs58ka042hoOsVFFHnkA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, May 15, 2020 at 04:48:46AM +0530, Syed Nayyar Waris wrote:
> > The introduction of the generic for_each_set_clump macro need test
> > cases to verify the implementation. This patch adds test cases for
> > scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> > The cases contain situations where clump is getting split at the word
> > boundary and also when zeroes are present in the start and middle of
> > bitmap.
>
> Thanks for an update. Looks pretty much okay to me, though one nit below.
> After addressing,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> > Changes in v6:
> >  - Make 'for loop' inside 'test_for_each_set_clump' more succinct.
> >
> > Changes in v5:
> >  - No change.
> >
> > Changes in v4:
> >  - Use 'for' loop in test function of 'for_each_set_clump'.
> >
> > Changes in v3:
> >  - No Change.
> >
> > Changes in v2:
> >  - Unify different tests for 'for_each_set_clump'. Pass test data as
> >    function parameters.
> >  - Remove unnecessary bitmap_zero calls.
> >
> >  lib/test_bitmap.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> >
> > diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> > index 6b13150667f5..673c512a5bbd 100644
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -155,6 +155,38 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
> >       return true;
> >  }
> >
> > +static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
> > +                                 const unsigned int offset,
> > +                                 const unsigned int size,
> > +                                 const unsigned long *const clump_exp,
> > +                                 const unsigned long *const clump,
> > +                                 const unsigned long clump_size)
> > +{
> > +     unsigned long exp;
> > +
> > +     if (offset >= size) {
> > +             pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
> > +                     srcfile, line, size, offset);
> > +             return false;
> > +     }
> > +
> > +     exp = clump_exp[offset / clump_size];
> > +     if (!exp) {
> > +             pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
> > +                     srcfile, line, offset);
> > +             return false;
> > +     }
> > +
> > +     if (*clump != exp) {
> > +             pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
> > +                     srcfile, line, exp, *clump);
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +
> >  #define __expect_eq(suffix, ...)                                     \
> >       ({                                                              \
> >               int result = 0;                                         \
> > @@ -172,6 +204,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
> >  #define expect_eq_pbl(...)           __expect_eq(pbl, ##__VA_ARGS__)
> >  #define expect_eq_u32_array(...)     __expect_eq(u32_array, ##__VA_ARGS__)
> >  #define expect_eq_clump8(...)                __expect_eq(clump8, ##__VA_ARGS__)
> > +#define expect_eq_clump(...)         __expect_eq(clump, ##__VA_ARGS__)
> >
> >  static void __init test_zero_clear(void)
> >  {
> > @@ -577,6 +610,28 @@ static void noinline __init test_mem_optimisations(void)
> >       }
> >  }
> >
> > +static const unsigned long clump_bitmap_data[] __initconst = {
> > +     0x38000201,
> > +     0x05ff0f38,
> > +     0xeffedcba,
> > +     0xbbbbabcd,
> > +     0x000000aa,
> > +     0x000000aa,
> > +     0x00ff0000,
> > +     0xaaaaaa00,
> > +     0xff000000,
> > +     0x00aa0000,
> > +     0x00000000,
> > +     0x00000000,
> > +     0x00000000,
> > +     0x0f000000,
> > +     0x00ff0000,
> > +     0xaaaaaa00,
> > +     0xff000000,
> > +     0x00aa0000,
> > +     0x00000ac0,
> > +};
> > +
> >  static const unsigned char clump_exp[] __initconst = {
> >       0x01,   /* 1 bit set */
> >       0x02,   /* non-edge 1 bit set */
> > @@ -588,6 +643,92 @@ static const unsigned char clump_exp[] __initconst = {
> >       0x05,   /* non-adjacent 2 bits set */
> >  };
> >
> > +static const unsigned long clump_exp1[] __initconst = {
> > +     0x01,   /* 1 bit set */
> > +     0x02,   /* non-edge 1 bit set */
> > +     0x00,   /* zero bits set */
> > +     0x38,   /* 3 bits set across 4-bit boundary */
> > +     0x38,   /* Repeated clump */
> > +     0x0F,   /* 4 bits set */
> > +     0xFF,   /* all bits set */
> > +     0x05,   /* non-adjacent 2 bits set */
> > +};
> > +
> > +static const unsigned long clump_exp2[] __initconst = {
> > +     0xfedcba,       /* 24 bits */
> > +     0xabcdef,
> > +     0xaabbbb,       /* Clump split between 2 words */
> > +     0x000000,       /* zeroes in between */
> > +     0x0000aa,
> > +     0x000000,
> > +     0x0000ff,
> > +     0xaaaaaa,
> > +     0x000000,
> > +     0x0000ff,
> > +};
> > +
> > +static const unsigned long clump_exp3[] __initconst = {
> > +     0x00000000,     /* starting with 0s*/
> > +     0x00000000,     /* All 0s */
> > +     0x00000000,
> > +     0x00000000,
> > +     0x3f00000f,     /* Non zero set */
> > +     0x2aa80003,
> > +     0x00000aaa,
> > +     0x00003fc0,
> > +};
> > +
> > +static const unsigned long clump_exp4[] __initconst = {
> > +     0x00,
> > +     0x2b,
> > +};
> > +
> > +struct clump_test_data {
>
> > +     unsigned long data[256];
>
> DECLARE_BITMAP() ?
>
> > +     unsigned long count;
> > +     unsigned long offset;
> > +     unsigned long limit;
> > +     unsigned long clump_size;
> > +     unsigned long const *exp;
>
> > +} clump_test_data[] = { {{0}, 2, 0, 64, 8, clump_exp1},
> > +                     {{0}, 8, 2, 240, 24, clump_exp2},
> > +                     {{0}, 8, 10, 240, 30, clump_exp3},
> > +                     {{0}, 1, 18, 18, 6, clump_exp4} };
>
> Please, split structure definition and test data.
>
> > +

I have incorporated your above 2 review comments.

I will be sharing the new (v7) patchset in some time with your
'Reviewed-by' tag included in this patch. I believe I have understood
correctly.

Regards
Syed Nayyar Waris
