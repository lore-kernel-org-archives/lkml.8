Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C192C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3280920732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 00:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWkqkt7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgFVADp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFVADp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 20:03:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 17:03:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id i3so17280013ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iQjccibNsODBxIPRVwtnty0pnVq+FPlTnqtaVf/zvo=;
        b=gWkqkt7iFu2e/U9U61du1Nn2Ytp5xdzZ0egK+HCF6urHHSXmJhOAdLTP7kJZPhaJI0
         srpDhJl0eDusw4obCJo9U4nOuXCzuTaoYSi2VOMHXH5IOnNUNnWYDJoFCSxuOuI7fCRk
         A68KzOZYcAZQCdtWZHOj/XGZTdwTSASqNXKKmZY0u9SvGKqVujGF2+OKAaPVQEP9bGbi
         4oQ7tpdwSa3YwBRumsesYU+VuGJpeTzHaLx8+8m+tcdTysFPUjZwaGPWpKiizzThMFh0
         zWxE/4IvomBtLpCn7smxRTnqKlA2+/9ZLQXuKoQSbiDMOvDpBTHxeUo8SCporcE2N9aX
         fU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iQjccibNsODBxIPRVwtnty0pnVq+FPlTnqtaVf/zvo=;
        b=K4d6YMfLiefPWkIPz39eHiKP0yu16D0cJMhafoASnL87EQ3Rtl770YCML7x3Q24tLc
         PYbWDQ4+Lz1fgJu5IK4cBWZPbh9lFLVdqjcBeZkBIzuXjpXuRoZwCILmhgGWOy6bXrzh
         vrr7Z+qBZZtTf1xVhI26kc7o8z9i+AyO9ndGKP5c2+wCkB0jt3SZmVOorkOmTNxTl1Ti
         viMCwgiMVtu1xunH94Wok1z72wrgINUsbwVDpCVz0n6IiKV+GPS+viBgfsmIms/tLLhC
         fPMsRp2FgSdBCShk2Bsfxj7YicVuMTo6FPciv1BuNjsJ+OoBRHn8NlrF/D0ueUEl0JRO
         pJ/g==
X-Gm-Message-State: AOAM530mPobVjCfLDJ9MezkxuDiikYh9bznK3OrXyuJo8J/2Kuln8GWI
        0FGbDcY8ldwnMd0pzmEYOyiDfhldmnFCv3i5UCE=
X-Google-Smtp-Source: ABdhPJwSaCvPsG8+hrDbkxINhvppY4SBLr0ZVB+euq0/82PQtMjX61SJohIxND3GvhhPhxwVnC6xj1u4/8dyX7nElNY=
X-Received: by 2002:a2e:a544:: with SMTP id e4mr7716310ljn.264.1592784223211;
 Sun, 21 Jun 2020 17:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
 <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com>
 <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
 <CANiq72nOaDo9LQ3JoZk6VH-ZYErHpvD1O=DyVngs3xno5e9W7Q@mail.gmail.com>
 <b4646ed22573568c0953d272514ab3b701e54faa.camel@perches.com>
 <CANiq72=58t3T0VckOOm7jAnwaxdEK2zbrWeQw-bXifmOq86BCA@mail.gmail.com> <42da4b47dd3aaee77e65550df30e548dd23580cd.camel@perches.com>
In-Reply-To: <42da4b47dd3aaee77e65550df30e548dd23580cd.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Jun 2020 02:03:32 +0200
Message-ID: <CANiq72m1E1=7yVz=jrDJWBtLZzDsi0ygFvZaHrOk_EbKdbf38A@mail.gmail.com>
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

Hi Joe,

I didn't forget about this -- I was playing the other day with
`ColumnLimit: 0` and the new options up to LLVM 11 to see what we
could do... See below.

On Thu, Jun 11, 2020 at 9:26 PM Joe Perches <joe@perches.com> wrote:
>
> Hey again Miguel:
>
> A little script and some statistics:
>
> Today about 6% of all code lines are > 80 columns
>
> Oddities like the ~3% of all lines with 113 and 121 columns
> are machine generated.
>
> So realistically, < 3% of code is > 80 columns.

The data you show is very useful, thanks! Of course, the current set
of lines tends to be < 80 columns given the previous strongly
preferred limit, but I would expect that % to grow in the future.

By the way, the 20% figure I mentioned was w.r.t. the previous set of
lines that were already over 80 columns (not w.r.t. the total set).

Regarding the changes: `ColumnLimit: 0` could be a good compromise
(which makes `clang-format` respect as much as possible the current
line breaks) to let developers have more leeway. They would still get
warnings from your `checkpatch` etc. On the other hand, making
formatting dependent on the previous state is not something I am a fan
of, particularly for long-term efforts to move to `clang-format`
"completely".

I guess users of `clang-format` should speak up (w.r.t. `ColumnLimit:
100`, `ColumnLimit: 0` or no change). At the end of the day, this is
still just a tool and not enforced, and they can still override it, so
if people start submitting code with 200-wide lines, well, they still
can :-) Otherwise, let's leave it as it is for the moment and see what
is the output of the script in, say, a year.

Cheers,
Miguel
