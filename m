Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C472FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A06206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNbUMBgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFOH6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:58:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:58:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so17971135ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hVbRT7TgTLZcT9uy08YM3oSIG8xHokXhK2qUcnQytI=;
        b=oNbUMBgRNwpIv6it8WW2Vx5mFSLI5cEsLOShg4rOp3GsRvhjR+x9Dimf9Y+lMiTftB
         e6FzU6QG+yE0GKxEKS717djWKSJhETPvW2SLf1hvRaYY1XNJYv61v7gSSHeJYFq9MVe8
         V8RibhMmb2H086li9LJwOZnuqNwjys16aDwvxBAskCzP5h2S33FGU7m8Cpy6G5hevDTM
         pcbmIkrVNlxJpVdR5HLOPEc8PyWZ3UJhedS3/J3RJmSfk3M+/yKgSyhEBZ4KxgrdUWKs
         4MDW9GX8E6HN96+GZaHdpZoFVlEE73N/kEhjM/N8pwuG/o8BHCya8tCH8hk9w/syHB+a
         9gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hVbRT7TgTLZcT9uy08YM3oSIG8xHokXhK2qUcnQytI=;
        b=TCS0aN+3lBexTtC/xSbwxlOvjN6IWgSE0tfKCpFhMWhUE0UolkWBZxHiaJlDTmXgZr
         YBNcUfwc2+G5eamwOtLVx3N/2bwz3mej+B/uj6wrq54OcRUXGW2icGpWGfR+NoGfaYe+
         Fpb1Dk4aOLz7/SkHpbYgih+iebIBAzeB8Asb7OpeEQosv3nWHm4iSN2rLjrtlNDlf6sB
         BNCmEBJcQi53eD5hNn9XaWFS1nDGtvL58LP0fnkDcSYFtAiUGY1X4/GI1V4c1WYbShcw
         jD6OOP6cW+v5y9eqs7EidWxnMhDplA51Meq+QD35liBlkcXOfcWGqfw9ZQ8PBsoVMupZ
         QW/Q==
X-Gm-Message-State: AOAM530NmKzsm6c/hHhNNQKz9KgGaSmtWljnBEfOCBSzh21+HN0pmC1s
        aN6VayPmd7k/Y4jWHPicZKnpz8AkGXSpD3rQ5MTgFQ==
X-Google-Smtp-Source: ABdhPJxg+uL8DnJW2k+EfREUi/iNpKVntD0qR8X7I2bKWY8MzYqsUUgrAaDH/eS0aX+JF1i+Oqmz10WfaEB3mj7RxQM=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr11261848ljb.156.1592207886700;
 Mon, 15 Jun 2020 00:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
 <CACT4Y+YokrJkh0ew-86=zsLLTr9Qnaom5gJeUX9TSMW7tDj=Eg@mail.gmail.com>
 <20200310061525.GA30283@ubuntu-m2-xlarge-x86> <CACT4Y+bx9w+Q5yJxykTbe8JDUt5ChLFRh5zGn78hHM8gqVZx7g@mail.gmail.com>
 <CACT4Y+Ym3Pc-UO3X33AhFE1rbdmr1gHcEmzJjtX7YZaBb2qexg@mail.gmail.com>
In-Reply-To: <CACT4Y+Ym3Pc-UO3X33AhFE1rbdmr1gHcEmzJjtX7YZaBb2qexg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Jun 2020 09:57:40 +0200
Message-ID: <CAG48ez3Qk6VEr2KwqZPZWA8N=JOJ5te+xKb4vUi-wh+hZhe_qg@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 10:03 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Mar 10, 2020 at 9:10 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Mar 10, 2020 at 7:15 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Mon, Mar 09, 2020 at 09:20:58AM +0100, Dmitry Vyukov wrote:
> > > > On Sun, Mar 8, 2020 at 7:35 PM 'Jann Horn' via syzkaller-bugs
> > > > <syzkaller-bugs@googlegroups.com> wrote:
> > > > > Ugh, why does it build with -Werror...
> > >
> > > There are certain warnings that are specifically treated like errors:
> > >
> > > In the main Makefile:
> > >
> > > KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
> > >
> > > > Now I am realizing I don't know what's the proper way to turn off
> > > > warnings entirely...
> > > >
> > > > We turn off this CONFIG_ERROR_ON_WARNING historically:
> > > > https://github.com/google/syzkaller/blob/2e9971bbbfb4df6ba0118353163a7703f3dbd6ec/dashboard/config/bits-syzbot.config#L17
> > > > and I thought that's enough. But now I realize it's not even a thing.
> > > > I see it referenced in some ChromeOS threads and there are some
> > > > discussions re upstreaming, but apparently it never existed upstream.
> > > >
> > > > make has W=n, but it seems that it can only be used to produce more
> > > > warnings. We don't pass W=3 specifically and there is no W=0.
> > > >
> > > > Should we always build with CFLAGS=-w? Is it guaranteed to work? Or is
> > > > there a better way?
> > >
> > > Would passing -Wno-werror via KCFLAGS work? Otherwise, passing
> > > -Wno-error=<specific warning> should work.
> > >
> > > Cheers,
> > > Nathan
> >
> > Filed https://github.com/google/syzkaller/issues/1635 so that this is not lost.
>
> Jann,
>
> Getting back to this.
> Are you sure building without warning will be better?
>
> Currently make enables these warnings as errors only:
>
> -Werror=strict-prototypes
> -Werror=implicit-function-declaration
> -Werror=implicit-int
> -Werror=date-time
> -Werror=incompatible-pointer-types
> -Werror=designated-init
>
> So most warnings won't cause build failure.
> And, say, converting T* to Y* implicitly may be an actual bug in the patch.

Ah, I guess you have a point there.
