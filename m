Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B0C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA85216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMpISK3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgDXS0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgDXS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:26:24 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D2C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:26:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so10185179ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYGcnKYRU9uURI0r1qD3tlSxc3V/4QuWnHzjogV6130=;
        b=aMpISK3EVPKuTv64GwuroTTPYBPsQ/4Pbu/lvzajy9aC8/wG7mQMIaFDJJsSJDLBhg
         nL0kPYtx97AksBGHO83KeT6qIWbpd4xkuh5lt0xyaxe4Dbso6X6QgeqnyWp3udLneel3
         UaIe6kHxRIfd+1oYItIl/0j05NdFTCQOAcyyYEcFIhHsi2QIfx2lDEXaMM3/wwig/Jtu
         MQH1sEt95rnRP7vq5djLplB82O3Y2sbaArGPJWPxDO63K7xP13p5ODcSo3vUlYJrFoAK
         R0dDeUl345BBPNPrsuNzOOLu16SKyQcQQKVT04f1AdzEnzCjQgS5OxNGPuqAVx54si5E
         nqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYGcnKYRU9uURI0r1qD3tlSxc3V/4QuWnHzjogV6130=;
        b=iWcQDiaahl4nyuCap4jwVdkZD3LtuYTlIQoU3Pn62vYlFe/iUGtiAM9bnVmg0tHUVp
         4Ido9Uk3CkHpJfTIreriI0fdlsFY/ikVOK8fbD9d8BQ8w1IqsiqghTjABkx5gkm5zWGX
         m/NUCwUEQSnVOQ44BrjeyyOgn+NAV7meW+8ScZaRLkAusP/K6Or3WHB7qFO108LdYHZd
         RMeaObjxbj+YUSOTQmJJfkk2UczJSm6bqkAQSRDAuYHNmHOvudevDnpwI/j9tmj2Lr4A
         f6B+Ql0eFzDIdPixqRcwIGQaBIg6Rs5FBCWJYWY3kVpzdt8dW7AodU6jJGgPIO50icxQ
         Ji3w==
X-Gm-Message-State: AGi0PuYRdwqhSuBpOnyGgENb2e8OHHJs557LitOTMRIeb2imoRD1OXG6
        W/D2OPy5UmF2HNOiG/KMy20qe+0hyBoXy35vGeM=
X-Google-Smtp-Source: APiQypJDNXAdjomHebtWL/SwtpY/wFcOOIsUAhljTeFxom3s098gX7QRiXQwkRBusMK/MOxvomK3nsgKocIGB9NDJZ8=
X-Received: by 2002:a92:3a09:: with SMTP id h9mr6622973ila.5.1587752783415;
 Fri, 24 Apr 2020 11:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200424122619.GA5573@syed> <CAHp75VcWwHT1eWekAMheaaU0-M_-w41XvJ-iNdKSVC+GZY7JsQ@mail.gmail.com>
In-Reply-To: <CAHp75VcWwHT1eWekAMheaaU0-M_-w41XvJ-iNdKSVC+GZY7JsQ@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 24 Apr 2020 23:56:11 +0530
Message-ID: <CACG_h5oNkRbusS9Qa-KR35Q=LppQxx+ah7wHpkC1FvjLQ1wHgQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 6:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 3:29 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> >
> > The introduction of the generic for_each_set_clump macro need test
> > cases to verify the implementation. This patch adds test cases for
> > scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> > The cases contain situations where clump is getting split at the word
> > boundary and also when zeroes are present in the start and middle of
> > bitmap.
>
> ...
>
> >  #define expect_eq_clump8(...)          __expect_eq(clump8, ##__VA_ARGS__)
> > +#define expect_eq_clump(...)           __expect_eq(clump, ##__VA_ARGS__)
>
> What the difference with clump8() ? Can either of them use another?
>

The difference is that generic (Non-8 version) expect_eq_clump(...)
expands to __check_eq_clump(...), which further uses clump_size
variable to check for the tests. Now this clump_size can have any
value signifying number of bits (less than or equal to BITS_PER_LONG).

While the clump8 version uses a fixed (hardcoded) value '8' for clump size.

I don't think either of them can use another.

> ...
>
> >  #define CLUMP_EXP_NUMBITS 64
>
> > +static void __init test_for_each_set_clump_8(void)  /* 8 bit clumps test using
> > +                                                 new for_each_set_clump */
> > +{
>
> > +#define CLUMP_EXP_NUMBITS 64
>
> Isn't it a redefinition? Shouldn't we undef all local definitions
> above and below?
>
> Also, can we derive it's size based on ARRAY_SIZE() and clump size?

Actually this macro is to create bitmap having a particular size. The
size doesn't need to be related to or derived from clump_size
necessarily.  I believe I should hardcode it - as it is just a test
value. I will submit this change in next version. Let me know if you
think otherwise.

>
> > +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
> > +       unsigned long start, clump, clump_size = 8;
> > +
> > +       /* set bitmap to test case */
> > +       bitmap_zero(bits, CLUMP_EXP_NUMBITS);
> > +       bitmap_set_value(bits, 0x38000201, 0, 32);
> > +       bitmap_set_value(bits, 0x05ff0f38, 32, 32);
> > +
> > +       for_each_set_clump(start, clump, bits, CLUMP_EXP_NUMBITS, clump_size)
> > +               expect_eq_clump(start, CLUMP_EXP_NUMBITS, clump_exp1, &clump, clump_size);
> > +}
> > +
> > +static void __init test_for_each_set_clump_24(void)  /* 24 bit clumps */
> > +{
> > +#define CLUMP_EXP_NUMBITS_2 256
> > +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> > +       unsigned long start, clump, clump_size = 24;
> > +       unsigned long size = clump_size * 10;
> > +
> > +       /* set bitmap to test case */
> > +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> > +       bitmap_set_value(bits, 0xeffedcba, 0, 32);
> > +       bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
> > +       bitmap_set_value(bits, 0x000000aa, 64, 32);
> > +       bitmap_set_value(bits, 0x000000aa, 96, 32);
> > +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> > +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> > +       bitmap_set_value(bits, 0xff000000, 192, 32);
> > +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> > +
> > +       for_each_set_clump(start, clump, bits, size, clump_size)
> > +               expect_eq_clump(start, size, clump_exp2, &clump, clump_size);
> > +}
> > +
> > +static void __init test_for_each_set_clump_30(void)   /* 30 bit clumps */
> > +{
> > +#define CLUMP_EXP_NUMBITS_2 256
> > +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> > +       unsigned long start, clump, clump_size = 30;
> > +       unsigned long size = clump_size * 8;
> > +
> > +       /* set bitmap to test case */
> > +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> > +       bitmap_set_value(bits, 0x00000000, 0, 32);
> > +       bitmap_set_value(bits, 0x00000000, 32, 32);
> > +       bitmap_set_value(bits, 0x00000000, 64, 32);
> > +       bitmap_set_value(bits, 0x0f000000, 96, 32);
> > +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> > +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> > +       bitmap_set_value(bits, 0xff000000, 192, 32);
> > +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> > +
> > +       for_each_set_clump(start, clump, bits, size, clump_size)
> > +               expect_eq_clump(start, size, clump_exp3, &clump, clump_size);
> > +}
> > +
> > +static void __init test_for_each_set_clump_6(void)   /* 6 bit clumps */
> > +{
> > +#define CLUMP_EXP_NUMBITS_2 256
> > +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> > +       unsigned long start, clump, clump_size = 6;
> > +       unsigned long size = clump_size * 3;
> > +
> > +       /* set bitmap to test case */
> > +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> > +       bitmap_set_value(bits, 0x00000ac0, 0, 32);
> > +       bitmap_set_value(bits, 0x00000000, 32, 32);
> > +       bitmap_set_value(bits, 0x00000000, 64, 32);
> > +       bitmap_set_value(bits, 0x0f000000, 96, 32);
> > +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> > +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> > +       bitmap_set_value(bits, 0xff000000, 192, 32);
> > +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> > +
> > +       for_each_set_clump(start, clump, bits, size, clump_size)
> > +               expect_eq_clump(start, size, clump_exp4, &clump, clump_size);
> > +}
>
> Can we unify all above and provide simple two test data sets:
> expected, input, clump size and other information as function
> parameter?

Yes I can do that. I will try it out in next version (v2).

>
> --
> With Best Regards,
> Andy Shevchenko

Thank You!
Syed Nayyar Waris
