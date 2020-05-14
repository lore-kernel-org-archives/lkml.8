Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A422065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODGQhpxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgENXa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgENXaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:30:25 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974F8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:30:25 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so626908ile.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuIERYhuXXo2ajPM92lIoUzXr3Ylv4BmhFGwWA6yt1Y=;
        b=ODGQhpxOT8S6BNJB/wP6MJrtgy6xbMpiMb+YIymLTOfQkpDAjkvW89nwXmuG7RSsb2
         d4vsg/k9vxvaI/5GsEIUGNn/ydU4ukPDGSiBBe+7+jNyXn8RU34Zp/3yjL9dGgAW9uoD
         2GcqLuu6PWqfO5wGZAY4sHTiE+TkJYbROBvoNo2iw7uzw6N94jA0bR1XdeNrwsemnjPr
         72nvj4bPFZh+u8M+kRR14vYNBgM4vomHXNNov1vppVTUguiADa15YCruty369RfrcU7j
         t6UnRoi0lgAAVq0Lbj34ZVkzwOeWVXDwjSZFotsLWM3BXTx38eYSy29Zv24I+ZMochT4
         2/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuIERYhuXXo2ajPM92lIoUzXr3Ylv4BmhFGwWA6yt1Y=;
        b=fyURR6cO3EOGzHz085S6nlvIXxjlAKw1hBDfhFOlhqa5KSh5M9aw5w99mZ1tSGJNDQ
         uedcGC82mdKWz0x7b9Ha9EMIN/bl7OnH4wTdWttk7ErwXr3xJL9Pjvt80B0x8QVtNpTb
         YYCMXSQ35vFe+2/uEdT5w5nPkHsMBhXV5whP1SWoRee1Y7QJaIucds3NLSKTFzcxA+wF
         wakh35wKrdGpCsennB7Vzef0ob28ezNIe3oSQCXjmF+Adawj/A8jPfkBXtFXuTg6SkMn
         bs4LfC0MDDozTWqq0sv0bV7grUIYtFVndKDN8hisHt54H0ADFkhSk8lvBa4CX2nL3lrQ
         QJGw==
X-Gm-Message-State: AOAM530f8xfYND8OiB9FBUhANk/ttLQONJJXqEihEDz+AzobTAPzPo0Q
        7+mmcI75MwQreLWNvvpqt52Id95+IhlFdhjIIP48Jg==
X-Google-Smtp-Source: ABdhPJwdZ/3HIQgtjIyQOIKQ3aaEBtjRdGEQFbAGBSbma5oOkWvMcPrUigomLxxfyjRSgyxxdZCD/pe1zxztTw3lJqU=
X-Received: by 2002:a92:5e99:: with SMTP id f25mr709820ilg.0.1589499024964;
 Thu, 14 May 2020 16:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588460322.git.syednwaris@gmail.com> <3eeb13d101db69be8eca739522bbf303527339bd.1588460322.git.syednwaris@gmail.com>
 <20200504113804.GD185537@smile.fi.intel.com>
In-Reply-To: <20200504113804.GD185537@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 15 May 2020 05:00:13 +0530
Message-ID: <CACG_h5qXK=9vhwreMxKGPgT9Wf6yee_Le0bAboN+jP=nxxFy1g@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
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

On Mon, May 4, 2020 at 5:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, May 03, 2020 at 04:41:42AM +0530, Syed Nayyar Waris wrote:
> > The introduction of the generic for_each_set_clump macro need test
> > cases to verify the implementation. This patch adds test cases for
> > scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> > The cases contain situations where clump is getting split at the word
> > boundary and also when zeroes are present in the start and middle of
> > bitmap.
>
>
> > +static const unsigned long bitmap_test_data[] __initconst = {
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
> > +     0x00000ac0,
> > +};
> > +
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
>
> One more struct here, like
>
> struct clump_test_data {
>         unsigned long *data; // with offset implied
>         unsigned long count;
>         unsigned long size;
>         unsigned long limit;
>         unsigned long *exp;
> };
>
> > +static const unsigned long * const clump_data[] __initconst = {
> > +     clump_exp1,
> > +     clump_exp2,
> > +     clump_exp3,
> > +     clump_exp4,
> > +};
> > +
> >  static void __init test_for_each_set_clump8(void)
> >  {
> >  #define CLUMP_EXP_NUMBITS 64
> > @@ -610,6 +708,48 @@ static void __init test_for_each_set_clump8(void)
> >               expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
> >  }
> >
> > +static void __init execute_for_each_set_clump_test(unsigned long *bits,
> > +                             unsigned long size,
> > +                             unsigned long clump_size,
> > +                             const unsigned long *clump_exp)
> > +{
> > +     unsigned long start, clump;
> > +
> > +     for_each_set_clump(start, clump, bits, size, clump_size)
> > +             expect_eq_clump(start, size, clump_exp, &clump, clump_size);
> > +}
> > +
>
> > +static void __init prepare_test_data(unsigned long * bits,
> > +                             const unsigned long * test_data,
> > +                             int start, int count)
>
> ... prepare_test_data(struct clump_test_data *data)
> {
>         ...
> }

Hi. I have sent a new patchset (v6) incorporating your review
comments. Regarding your above review comment for function
'prepare_test_data', the parameter 'struct clump_test_data' has
already been declared outside (as was suggested.. see further above),
so I didn't require that (struct clump_test_data) as a parameter for
the function, as it can be accessed from everywhere.

Further, below ...

...

> > +static void __init test_for_each_set_clump(void)
> > +{
> > +     int i;
> > +     int count[] = {2, 8, 4, 1};
> > +     int offset[] = {0, 2, 10, 14};
> > +     unsigned long limit[] = {64, 240, 240, 18};
> > +     unsigned long clump_size[] = {8, 24, 30, 6};
> > +     DECLARE_BITMAP(bits, 256);
> > +
> > +     for(i = 0; i < 4; i++)
> > +     {
> > +             prepare_test_data(bits, bitmap_test_data, offset[i], count[i]);
> > +             execute_for_each_set_clump_test(bits, limit[i],
> > +                                     clump_size[i], clump_data[i]);
> > +     }
>
> As I told you it should be as simple as
>
>         unsigned int i;
>
>         for (i < ARRAY_SIZE(clump_test_data)) {
>                 prepare()
>                 execute()
>         }
>

Since it is required to use 'for loop' with 'ARRAY_SIZE', this implies
that 'clump_test_data'  be an array, which has been done so. I have
done here a minor addition that the 'prepare_test_data' function is
called with argument 'i' (index) to prepare data specifically for the
ith test case. Without passing 'i' it would not be possible (I
believe) to populate the bitmap properly for the ith test case.

Let me know if the new patchset seems alright. Thank you.

Regards
Syed Nayyar Waris
