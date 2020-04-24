Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A9C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E5420728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pngB0Cmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDXNLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgDXNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:11:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18FDC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so4782424pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20oOj0FbEeXishwdAVymg17c3dn9yshiC1V7t1YWhiU=;
        b=pngB0Cmdt/l0wNv+SuNtWhN6rGP7nuhbFBa6uMmKDBq2MLRxVIrfj4OQrQUuYJnbDP
         /eMFC1zQTneDVYtVQbpnHqrGZ2IzKa9Byjk/NqGovdeC/VfuyRafOFnD5F8gi5wIkUV0
         t5OOToyAiRT4r9PHDo2xXWhNxMI4oRkxWt+/iRPGZSQCttM4m8ykhqblqt2s8pSEDEyq
         e3b7bQa/kRjeYtA0LeDpmkeYfclLRCR/uF82b5S1rltwwRSvN73/ugSQ3VVJD5VKdhBr
         es+tWUDcU9B9TIY3XP5bfH5lauwzyfBbcWaEeAcfS1WbnH5d62riyz9UtTCKtr0QCs+S
         U+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20oOj0FbEeXishwdAVymg17c3dn9yshiC1V7t1YWhiU=;
        b=a9ipff+Ou9Xw2mU6uWVQICKE57SaQ1TzX6MVZgQmzOmp0eLM86j/LOseJbFFQx97BC
         F/sqGZOn3whcNMS3jjLg2bJqoYFAar5Y+fDYwmiMiUexgO+sx4SxWCoC1DOqNCCBJtcW
         k1LiAlysGJdio/q7hq5vvC56CgoUBMzgdzHzCSkakmZxDlYdaD37BWT1hRUkBGOCHGro
         JWlAHNFCcxng7BP1gbFjBF9alyZfwIIMJlRG2chunIcKNWKwho5GnsneS85gj+wOlAKl
         fVz9H3+CK+60vHlwQCPP/MS6TUwMnvNBwbnTrxEvNW65ViZvpdRS90jp/MduqOptpMNu
         UcoQ==
X-Gm-Message-State: AGi0PuZ7b6LmZ/kd3f6VOlDdPq64aEFSpbpPx+8ynruUyBkG/uJXsZa6
        8VGLc1/W3Jh/umEkD4tGqZBbYXgde/ABjC+NZnc=
X-Google-Smtp-Source: APiQypKugQfTNWwzZrWFU2ZXQGOPlo2vFscCqmE6g6oZMX0508KzU2BqKUWfgdN/qtKhg43mYtJOhaVBhSUk3Pm+EK8=
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr9791653pfr.36.1587733894375;
 Fri, 24 Apr 2020 06:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200424122619.GA5573@syed>
In-Reply-To: <20200424122619.GA5573@syed>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Apr 2020 16:11:27 +0300
Message-ID: <CAHp75VcWwHT1eWekAMheaaU0-M_-w41XvJ-iNdKSVC+GZY7JsQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Syed Nayyar Waris <syednwaris@gmail.com>
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

On Fri, Apr 24, 2020 at 3:29 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> The introduction of the generic for_each_set_clump macro need test
> cases to verify the implementation. This patch adds test cases for
> scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
> The cases contain situations where clump is getting split at the word
> boundary and also when zeroes are present in the start and middle of
> bitmap.

...

>  #define expect_eq_clump8(...)          __expect_eq(clump8, ##__VA_ARGS__)
> +#define expect_eq_clump(...)           __expect_eq(clump, ##__VA_ARGS__)

What the difference with clump8() ? Can either of them use another?

...

>  #define CLUMP_EXP_NUMBITS 64

> +static void __init test_for_each_set_clump_8(void)  /* 8 bit clumps test using
> +                                                 new for_each_set_clump */
> +{

> +#define CLUMP_EXP_NUMBITS 64

Isn't it a redefinition? Shouldn't we undef all local definitions
above and below?

Also, can we derive it's size based on ARRAY_SIZE() and clump size?

> +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
> +       unsigned long start, clump, clump_size = 8;
> +
> +       /* set bitmap to test case */
> +       bitmap_zero(bits, CLUMP_EXP_NUMBITS);
> +       bitmap_set_value(bits, 0x38000201, 0, 32);
> +       bitmap_set_value(bits, 0x05ff0f38, 32, 32);
> +
> +       for_each_set_clump(start, clump, bits, CLUMP_EXP_NUMBITS, clump_size)
> +               expect_eq_clump(start, CLUMP_EXP_NUMBITS, clump_exp1, &clump, clump_size);
> +}
> +
> +static void __init test_for_each_set_clump_24(void)  /* 24 bit clumps */
> +{
> +#define CLUMP_EXP_NUMBITS_2 256
> +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> +       unsigned long start, clump, clump_size = 24;
> +       unsigned long size = clump_size * 10;
> +
> +       /* set bitmap to test case */
> +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> +       bitmap_set_value(bits, 0xeffedcba, 0, 32);
> +       bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
> +       bitmap_set_value(bits, 0x000000aa, 64, 32);
> +       bitmap_set_value(bits, 0x000000aa, 96, 32);
> +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> +       bitmap_set_value(bits, 0xff000000, 192, 32);
> +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> +
> +       for_each_set_clump(start, clump, bits, size, clump_size)
> +               expect_eq_clump(start, size, clump_exp2, &clump, clump_size);
> +}
> +
> +static void __init test_for_each_set_clump_30(void)   /* 30 bit clumps */
> +{
> +#define CLUMP_EXP_NUMBITS_2 256
> +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> +       unsigned long start, clump, clump_size = 30;
> +       unsigned long size = clump_size * 8;
> +
> +       /* set bitmap to test case */
> +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> +       bitmap_set_value(bits, 0x00000000, 0, 32);
> +       bitmap_set_value(bits, 0x00000000, 32, 32);
> +       bitmap_set_value(bits, 0x00000000, 64, 32);
> +       bitmap_set_value(bits, 0x0f000000, 96, 32);
> +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> +       bitmap_set_value(bits, 0xff000000, 192, 32);
> +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> +
> +       for_each_set_clump(start, clump, bits, size, clump_size)
> +               expect_eq_clump(start, size, clump_exp3, &clump, clump_size);
> +}
> +
> +static void __init test_for_each_set_clump_6(void)   /* 6 bit clumps */
> +{
> +#define CLUMP_EXP_NUMBITS_2 256
> +       DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
> +       unsigned long start, clump, clump_size = 6;
> +       unsigned long size = clump_size * 3;
> +
> +       /* set bitmap to test case */
> +       bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
> +       bitmap_set_value(bits, 0x00000ac0, 0, 32);
> +       bitmap_set_value(bits, 0x00000000, 32, 32);
> +       bitmap_set_value(bits, 0x00000000, 64, 32);
> +       bitmap_set_value(bits, 0x0f000000, 96, 32);
> +       bitmap_set_value(bits, 0x00ff0000, 128, 32);
> +       bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
> +       bitmap_set_value(bits, 0xff000000, 192, 32);
> +       bitmap_set_value(bits, 0x00aa0000, 224, 32);
> +
> +       for_each_set_clump(start, clump, bits, size, clump_size)
> +               expect_eq_clump(start, size, clump_exp4, &clump, clump_size);
> +}

Can we unify all above and provide simple two test data sets:
expected, input, clump size and other information as function
parameter?

-- 
With Best Regards,
Andy Shevchenko
