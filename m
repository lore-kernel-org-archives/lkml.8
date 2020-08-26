Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUFP7Oiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgHZMSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgHZMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:18:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8144C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:18:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n23so1272184otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/q8ddA2FVVePJulVHbf1w2DVxs+k2gCtz8r5i1ccF8=;
        b=cUFP7Oiw1nGQBRVAjjWi4uM5zQAqXphiVe5sfmdel3PFSgL2f5Hc7lgzgDy9fc0qhb
         lJ9N8s3+lCqQAUn1b11KbLv8tr52O0JlPgWbKJUYy+kD4jIS2eOPAIg7iv70NvPAKyg0
         mcI8hVIPBXs9+1hQduhVWVBpH/OK85kGGuxqTzhalXNZOh0za+2xYHOugfpQ99+eoejT
         1NIidxHyeH3222oxS7vlk09XfFxD2yzTzij8oaq7TcAhFB9DpoA7VrvK000co/yi5brk
         yYMF+R5iVgZaFQAp0n52szNbvg1PVtA3osFR/eQCRnRzLywuSVdy+tiTe0lXQ4H89aJd
         O79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/q8ddA2FVVePJulVHbf1w2DVxs+k2gCtz8r5i1ccF8=;
        b=fxcajWjC7VaLw7lBZNPxBS3i4Z+bY6r0D+sy55DwjtvHCD8slCmZjkoikotONVFAj6
         wU5LoDGxa/JVPfdoP/VV/w08IiQsgvrUR8MK05f7YbHjxShrHasltBwM2lvilaJrmTLf
         2ZtRKAwnwccQA7PGL2ZMphbO3rBzegZpX3RaWRqEegf+fchN3J36fHJzVBc/s84U9lAo
         D2hzenMANkWFubDLmc152QtBHhJOjwQgT8ASqqiry7Uu680OVsf1t/0GcQdjqsFlfly6
         t4JSQc9Tz+24j1LyatGjMt7c9HMupnG7Gc8qSab49bEUBuc7aGwJSd0gkl++QbK+Tsiu
         bmRQ==
X-Gm-Message-State: AOAM530EoGvbyx5ZgNyN2oC7WA+GXJRidHZl1806dbLSiGWk5f4B6uy6
        DFo0Fzmbx6m5UopibgUFY3rQTg/z5iBUcmx5IayKoQ==
X-Google-Smtp-Source: ABdhPJwY8yOqgMAG5GbBC8S7wFO7rp5OTMSq8t+9EXlSRQ4LdqzRa+XFWCAY31bpPC+oZnvjdAVdY6DAc7krgBKagCk=
X-Received: by 2002:a9d:739a:: with SMTP id j26mr10379141otk.17.1598444288848;
 Wed, 26 Aug 2020 05:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200821123126.3121494-1-elver@google.com>
In-Reply-To: <20200821123126.3121494-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 Aug 2020 14:17:57 +0200
Message-ID: <CANpmjNMLL+Xqg0MQrtBMxLunUGXVP-mAXKqRH5s0xNSfAUhrzg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Use tracing-safe version of prandom
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 at 14:31, Marco Elver <elver@google.com> wrote:
> In the core runtime, we must minimize any calls to external library
> functions to avoid any kind of recursion. This can happen even though
> instrumentation is disabled for called functions, but tracing is
> enabled.
>
> Most recently, prandom_u32() added a tracepoint, which can cause
> problems for KCSAN even if the rcuidle variant is used. For example:
>         kcsan -> prandom_u32() -> trace_prandom_u32_rcuidle ->
>         srcu_read_lock_notrace -> __srcu_read_lock -> kcsan ...
>
> While we could disable KCSAN in kcsan_setup_watchpoint(), this does not
> solve other unexpected behaviour we may get due recursing into functions
> that may not be tolerant to such recursion:
>         __srcu_read_lock -> kcsan -> ... -> __srcu_read_lock
>
> Therefore, switch to using prandom_u32_state(), which is uninstrumented,
> and does not have a tracepoint.
>
> Link: https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com
> Link: https://lkml.kernel.org/r/20200820172046.GA177701@elver.google.com
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Applies to latest -rcu/dev only.
>
> Let's wait a bit to see what happens with
>   https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com,
> just in case there's a better solution that might make this patch redundant.

Paul, feel free to pick this up.

I wanted to wait until after plumbers to see what happens, but maybe
it's better to give the heads-up now, so this is in time for the next
pull-request. It seems that prandom_u32() will keep its tracepoint,
which means we definitely need this to make KCSAN compatible with
tracing again.

Thanks,
-- Marco
