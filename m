Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A620857
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFYJIr4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgDHOij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:38:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33230 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgDHOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:38:38 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so272544iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w9uV7DT25Vxle+OoRarHDVgxrRzl4Tsa9YCyi8Vm+k=;
        b=TFYJIr4f0AtswFbA49HaZsm32aeev+TDMpn+EE95c1ecN011KRiZdGtiDab720w8Ld
         GgBlfjdnUgWDu9HK0Cm8FEGi5erCGR6URlj8txRHGg+0GGuDZR8vWWSOp9wa5HbVSF/5
         A9Hj4qPU12v+Fw12FRrqc/IU+d6jX1MV5slMf6vGp5HOEDatC3Xsvz8ZxnxONe2TcZcA
         QZe0pHUBJVudAQmSf1FK+rJE9RaHSqjoBnGxIeokfQTbg2Xl7qHmWHuvyBTQZYMpxxee
         yiAFjNSNgHFLeHIKEUrcQa4w0tqwQrCmt38P+Ec4fFBoe9/5UYsJW1v7JINTPCQbjOeE
         IU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w9uV7DT25Vxle+OoRarHDVgxrRzl4Tsa9YCyi8Vm+k=;
        b=hrzgTPjPXfE8iGzwtGHoqW91MRhzIidXfRM2XBU+sF1oUuDSqJN5rxwsPQJOkSub+T
         x2too06j5aq3fYhOO11cEjjwBFWLrsavHuHAHoELfY7uzKiuZIzut3j29lVNc2sfc+0Z
         uMtv5DKaz6sKMYvpA73660ektiDatjyJLSteTwVSqinQQrP3Uryz+dAVcEAs1LTNumd0
         319Cvlla1OJqZqOl3esY42Aj/Pzi52CbsWcuLdT+l4xwE2rQ9EuEBHBzOtLRNy5Zt4R9
         e/L2ddKRST42ipNCKTVLNoRziEuFk/ceKg8gakwKuH1aHb0QyI3SV4esqOr/HbJsHK2P
         2UKw==
X-Gm-Message-State: AGi0Pubw9EbwXJBXtB7Im6SB/G2LYQOhsOnyLBa2PmByJ7yihjaBOywx
        ThpJzrA1aDIKH5QXVf6aNO5aFNy3itWjxABPH73SW4wSScAEKg==
X-Google-Smtp-Source: APiQypLdZW5yPk3JBpDb6UZvC8HjfEYcKx/MpQioz7z8y1zRYoaDbSfn+v6BnNFNQHSAkRvEjBA4zZ+XEzg7dE64P4o=
X-Received: by 2002:a02:b70b:: with SMTP id g11mr7211033jam.16.1586356717774;
 Wed, 08 Apr 2020 07:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com> <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
In-Reply-To: <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 8 Apr 2020 16:38:25 +0200
Message-ID: <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 12:31 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 8, 2020 at 12:45 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > On Wed, Feb 19, 2020 at 8:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> > Hi Petr,
> >
> > Bump, as I don't see this in linux-next or other public branches.
> > The discussion was split between several threads, revolving around
> > the vision for how lib/test_printf.c should be structured, but the
> > fix itself wasn't disputed.
> >
> > Could you please pick it up for 5.7-rc1?  If you want to restructure
> > the test suite before adding any new test cases, v1 doesn't have them.
> > Other than the test cases, the only difference between v1 and v2 is
> > added reviews and acks.
>
> Petr has some obstacles that prevent him to pay attention on this and
> actually do anything right now for Linux kernel.
> If Rasmus, Sergey, you and maybe others will got consensus here, I
> think Andrew can take it thru his tree.

Thanks for letting us know, Andy.

Other than Petr, two people are listed as maintainers of vsprintf.c:
Sergey and Steve.  Both of them were fine with v1 (no tests) and sent
their acks.

Rasmus, you wanted to see some tests, so I posted v2.  However Petr
wanted to restructure the test suite first, and it didn't seem like you
him agreed on what exactly that should look like.  Which would you
prefer to be picked by Andrew, v1 or v2?

                Ilya
