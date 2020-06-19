Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D47C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D586207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCnrqAUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgFSNxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFSNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:53:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:53:27 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g3so9248754ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=N67LFZCCD5XjDCH+/cowa2h90QhFRw4fTnac82tg+S0=;
        b=jCnrqAUmFuCAL+lYQKPmfG+RSpbVe341x6DhN50zY9zZg3WGROrar6WYLEo0xBMWiv
         kZw8t2G7XryhOgFMeq4E6lQJqtX0I0BtGXjILiG+JkX1czJGH6BxXa8fVCKPU9ofhBsG
         6cWP3f80gV6BsF9ZH8TxLT3jSB0BPVqrj7Njwm8bFE1km/FulpmZLF6AJfP9r4KdYGkm
         VfCXjS75AZMEMjaNOAyUwwqf+ZzWb4BH9gFD1lb0lACV3VbpHVwYCAJfxNUALWmprVE7
         ON7fiNBxFc20X+1plGRtMtS14QiGxbr697k/vxEd9Z5AM229caBhYuMMM/hyl8tREnOl
         d18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=N67LFZCCD5XjDCH+/cowa2h90QhFRw4fTnac82tg+S0=;
        b=LExFGtilsMOl8zj1M8m3v/DwFKYKAEDQhttMpEhtjriBnBjtg8+naRW6YGYMX1OaCd
         cHPlqKlY7BYY1Yk15V2Eyi6ByhKy6TZgZ7XtqnJisPExUEbfJ1TLuLvtFcpa9dL5iUYw
         jdDh6ysKtY+7kyjQrQE+m2h1AN3U9txlfq5eVz13Dc/vNWtJuRglaXtRTLgKRYSyqykN
         N9dojVhJp6whcaVNjjVvpoU4BejFmSb4aJRT/vamMOKEv6glC6LD3gwLupLxrBEVo5rE
         VXs6+fZXqhlGHV7L8Hz7+Zp9TXtHNKYa1AgmpIgVfuUwcrx0ufiPRtbfqxkzJTSIIDNC
         ehuQ==
X-Gm-Message-State: AOAM530FJxG9ILG+p55ZG4m/fVYW8fJJLCA1yniI7zQABbVJZh0xp8Kv
        hk/ijPVxXQo3tyqTqYZcL5D+1IPYe60fSRQixaF+MQtq
X-Google-Smtp-Source: ABdhPJz5wJm7PvbG7mK/lT7vcDxFPXQ2NBF92Fb0POy4J/ALxQT2SugkAt0pnwrZS5AYGsaxbMMTdL2Xt4CoyRG7U2k=
X-Received: by 2002:a92:940f:: with SMTP id c15mr3891903ili.204.1592574805857;
 Fri, 19 Jun 2020 06:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125721.15946-1-sedat.dilek@gmail.com> <20200619132627.GD222848@elver.google.com>
In-Reply-To: <20200619132627.GD222848@elver.google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 19 Jun 2020 15:53:14 +0200
Message-ID: <CA+icZUU7tz3yPyB317yZR6ksMDT-4SbvF7kHnQ+GV-v+O5eKGQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Improve small stylistic detail in compiler-clang.h
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 3:26 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, Jun 19, 2020 at 02:57PM +0200, Sedat Dilek wrote:
> > Commit 5cbaefe9743bf14c9d3106db0cc19f8cb0a3ca22
> > ("kcsan: Improve various small stylistic details")
> >
> > ...forgot to improve a stylistic detail that was already done at
> > another place in compiler-clang.h file.
> >
> > Fixes: 5cbaefe9743b ("kcsan: Improve various small stylistic details")
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  include/linux/compiler-clang.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index ee37256ec8bd..c47141b185fe 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -25,7 +25,7 @@
> >  #endif
> >
> >  #if __has_feature(thread_sanitizer)
> > -/* emulate gcc's __SANITIZE_THREAD__ flag */
> > +/* Emulate GCC's __SANITIZE_THREAD__ flag */
>
> Yeah, it's inconsistent, but if you look at the rest of the file, none
> of it looks particularly pretty.
>
> This change isn't really affecting KCSAN, but is a stylistic change
> confined to compiler-clang.h: while we're here, we could just bunch a
> couple of them into one patch and make it "compiler-clang.h: Improve
> comments style" or something.
>
> 1. These sentences probably want a '.' at the end.
>
> 2. Make all comments start with a capital letter, and punctuate
>    correctly.
>
> 3. Multi-line comments should have the first line just '/*' and the
>    second line starts the text.
>

More improvements :-).

I just fell over this one when looking through KCSAN commits in Linux v5.8-rc1+.

- Sedat -
