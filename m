Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C188C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDA2206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlp/XaVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgFKSva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:51:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:51:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so4094425lfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7i6ozYWDoWdhQUF8n+x9eu910xpemZDjtGEhhP0cTk=;
        b=rlp/XaVYonga5QinfFwsLoaIXlslNYQSJwttXyi6N1DPtni+Z9xseTTwICCdRvqWr6
         qPZ5lhRsiQsy8BwTDRCfw65JYP1996bXUGBgdT+Yq5uJALkY3iOFcj3WR7qQDGN3kCzL
         D8l+fO94iptR4okMhyofMB67D103f2O4gtY1Kyp0Jaokdr3zGa50AXSpLY9Xtr38noct
         ArIW2AIVuJxvMJuZkHphTfhW9va9ZRhvGdwmzc8q4MCfpwIDHLq4Rq2Y0AhV1hNKd4Su
         7JjvuOZp2WItjlpJdst2FXSm8PlyBWTqcs46ByVF064hxRhM/YC2vwDdjvLsq/SrZxOp
         ISKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7i6ozYWDoWdhQUF8n+x9eu910xpemZDjtGEhhP0cTk=;
        b=m3iAUY5rariaYjRCTVz2eaGTYP4IHYsf6PPeVmGdx9PhbSbtSL8KMA5nx/gsVCoUdW
         vH1Z/gfFrVh91haiXEforh8D82qs/fmuQ5RkwHktTKAMryUZPMi8hZh+v+myvDE0eYFC
         QOsCI9YCM5ipTbXHmjTJ+X/Dj+sE9oHQrh2xvu2tv6+Czr/nANpy8iAK22bDlwSRYCQU
         5ykETTp6r0AiDte9RG87713fg7yzuS9Vf40JjkUQbHzQIfBzh/9gCkRxF/WnNcJaiTbq
         WCqOCpzA1DfLmEAA/jIey0qFbS4c/sezdRX8fjfI0KViL4CKSmvMUq0jEmQq72YitN4Z
         0Ilw==
X-Gm-Message-State: AOAM533mLMAoWYGkAYjK1byUegX/M5FYuYY5UN72LLOvV8n0CaOJ1dx4
        S8qjzMx0yy+/rosYY27/GaIHIwlcarUlgLoWk+4=
X-Google-Smtp-Source: ABdhPJxmo33Ui3MIAC28jpu9Vap0dYVj1bHQ2B2/VPCbhXf8cJjYDLpxAqae9OB1JfTyQiYyt7E3SatXY9LAIaV6S8s=
X-Received: by 2002:a19:3f01:: with SMTP id m1mr4909173lfa.130.1591901487983;
 Thu, 11 Jun 2020 11:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
 <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
 <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
 <CANiq72nOaDo9LQ3JoZk6VH-ZYErHpvD1O=DyVngs3xno5e9W7Q@mail.gmail.com> <b4646ed22573568c0953d272514ab3b701e54faa.camel@perches.com>
In-Reply-To: <b4646ed22573568c0953d272514ab3b701e54faa.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 11 Jun 2020 20:51:16 +0200
Message-ID: <CANiq72=58t3T0VckOOm7jAnwaxdEK2zbrWeQw-bXifmOq86BCA@mail.gmail.com>
Subject: Re: [PATCH] .clang-format: update column limit
To:     Joe Perches <joe@perches.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 6:22 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-06-11 at 13:54 +0200, Miguel Ojeda wrote:
> > Why is 80 "still preferred" to begin with?
>
> That's neither my nor your issue to solve.

? You (or Linus, I still don't know since the commit is on your name
but I can't find the full patch in the list...) updated the wording on
`coding-style.rst` and I have to decide what limit to put into
`ColumnLimit` to make `clang-format` most useful for developers within
the new constraints. So it does concern us...

In my view, `coding-style.rst` is saying what it used to say from the
point of view of a new contributor. But regardless of that, forcing
`clang-format` to work under the 80-column constraint means we will
get code that won't look as good as giving it a slightly higher hard
limit. Yes, more lines will get over 80, but that is not as big of a
concern now since it is not as "strongly preferred" as before, which
is the point I was trying to make.

A concern for keeping the `clang-format` limit as it is that I can
think of is that newcomers using `clang-format` may feel forced not to
go over 80-column no matter what since "that is what the tool does".
On the other hand, my concern for *increasing* it is about things like
function signatures, since there is no easy way to decrease their
length or rearrange them without reducing the identifiers' length. A
third alternative is using `ColumnWidth: 0` and let people break lines
on their own, `clang-format` will respect that if possible. But then
we rely on people using `checkpatch` and they have to take care of the
limit themselves, so the advantage of automatic formatting decreases.

By the way, I noticed that a lot of kernel code will still trigger the
100-column warning (~20% of the previous set triggering it!).

Cheers,
Miguel
