Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C18206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGFLl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:41:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42637 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgGFLl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:41:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id g37so7656036otb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtUJcyIaWtI0015ev1OcSvJ6pgyP7aHuqpMEVgfaucs=;
        b=IRYc7XYeaT6AVvypOss0HN8Pe07UJFg7s/JKSZr+AEtRzLSMmArJjdM+oqNBSrbXXd
         +89kBY9NET8ATYnAwJWJXR1WAoRbFKDrQUBRZ4UpbINPbFf5jkmypvNhI4fzpHp4ZELC
         HKVTAvd2J5y3hySHXzqWexrB/ocUjP3LVJlUsasbl5O/+b5ffoJdz13OcHvgdpN1B1NR
         LYM4eEVw9DYPO/BxdJ7RvZcBF86iRnPGKWmQx6uAES8J/s26Qi0kIW/gSAveBH1J2q0g
         r8bkCPkfei1LjM3YxOotSu0gG5hu+AC0AmpsQKNv3jLDDEq7YaXlU8Sokn5EmoOBE7Lk
         Zkew==
X-Gm-Message-State: AOAM5330Bu29DiTsHmd9nSR+Im6Emz2ZFt6aYOL1XcIhzQIWwU4i4YfM
        k1+jVEE4t44Yf+dsu5u/3X9pWQ3X9KEKYosBuz4=
X-Google-Smtp-Source: ABdhPJyCetaItsraF+Xej81qEnliUvdiYNsk4jpDI3kMavNc8q1OP5C9VXrE3OsAY0PY+MaApgFh2p9uh2Dhdi6XwmY=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr28693826otp.250.1594035685317;
 Mon, 06 Jul 2020 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200706112900.7097-1-geert@linux-m68k.org> <20200706113400.GU3703480@smile.fi.intel.com>
In-Reply-To: <20200706113400.GU3703480@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Jul 2020 13:41:14 +0200
Message-ID: <CAMuHMdWyW6Tka6L-r9WtD6AwDN9G+NHspFdRzkM2=cbd=UT60g@mail.gmail.com>
Subject: Re: [PATCH v2] lib/test_bitops: Do the full test during module init
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jul 6, 2020 at 1:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Jul 06, 2020 at 01:29:00PM +0200, Geert Uytterhoeven wrote:
> > Currently, the bitops test consists of two parts: one part is executed
> > during module load, the second part during module unload. This is
> > cumbersome for the user, as he has to perform two steps to execute all
> > tests, and is different from most (all?) other tests.
> >
> > Merge the two parts, so both are executed during module load.
>
> I think it's right way to go, sorry, I didn't notice this during module
> submission.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> One question though, is compiler barrier enough to prevent potential ordering issues?

I think so, that's why I used barrier().
You may still be subject to CPU instruction reordering, though :-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
