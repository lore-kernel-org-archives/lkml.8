Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F9222B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="vY8v/QkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgHDQYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbgHDQWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:22:42 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:22:40 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id u43so8963271ybi.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pnsFML9kOr1mpGxswyZ75m8dhfY+/2C5+vBWHJn45U=;
        b=vY8v/QkBFvvM97vcv7qQBuKoB9WH0zYIDrB/Jg+3hS/ZIlJMvkTJ2QqnjQVLwNr5GS
         70mPlcS16tJ4QdDthmPcYfqyrGSCqfsewvOHtr+ULLBgLtz1eJcNeuRW+ayioA/2r4PG
         2Llon0xGXHDlvSR1EAzAExe9pkZ2u/+oUt7B10Bk8LxduhynTXitcaRLhMsb7vKMu3g+
         pHUXHfJprB9WtwemXG/s6roSqgHuanUmc790shYPUpZVULOrXJkloxZlDDHzntVqVSVt
         IpuqKoD4FzPDWGELc4e/BRPfvSuLrne8m57IHgAFuteKzrA+4g/0fcDXqYlsoQHd5x1w
         FBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pnsFML9kOr1mpGxswyZ75m8dhfY+/2C5+vBWHJn45U=;
        b=FYkjB4eq3Wp76nuvcxLU8+QTaHbRDnjnVex6P90/k6wzpJer2wyh8hqEwCjL2jxk8T
         22jOwlDzuL98AGujX/E4RbHHR7tgxSoKeaGBb2cme7PQ0WfI8JNs3+5FyeQ1ltm0UQLK
         tx7t84PKX+3k8hXiAvwEaF3UUiBTZ4+/TQRWcmz4JBya2G9FeNcKZHgjjQyUqSY6uFlz
         GZqqbrDoWYwwJUYMYmrLiNxdLCh6vUyt1AmczJdbQIAM8l2JUtjQcACd9R+4E8N6Ve/V
         KZ0z4ysaD+3rp3ttUIvNVuaep0BRhXki8LRj4U+iXMYmM1GnYL/Psiy3lnTekrTxHj6C
         DNTw==
X-Gm-Message-State: AOAM533tyd3Naqwt4Jm1YfKBCbvkekEgVM3ubzVWjjWVWHSP1EQaHVFR
        p+3feIeUaOTPd7pYJ8xsSPSXd7oFGOr11JWbPx2Ncg==
X-Google-Smtp-Source: ABdhPJyEjvjw6hlErB+kg/BSJ7LyU/dZjQUAvBRLQQ4hkNFJbTQQe1Btf7L6kkpWTGStUhQ/HNdcwukrIX/Ik9iHIBk=
X-Received: by 2002:a25:b88b:: with SMTP id w11mr23329907ybj.129.1596558159458;
 Tue, 04 Aug 2020 09:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net> <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
 <20200804142344.GM2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200804142344.GM2674@hirez.programming.kicks-ass.net>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Tue, 4 Aug 2020 13:22:03 -0300
Message-ID: <CADQ6JjWbCsyWxZKQ5=kkxx8hkaW=mbCjDodPXDAv5vH-=tVvEQ@mail.gmail.com>
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
To:     peterz@infradead.org
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ian Rogers <irogers@google.com>, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Aug 4, 2020 at 11:23 AM <peterz@infradead.org> wrote:
>
> On Tue, Aug 04, 2020 at 10:46:21AM -0300, Vitor Massaru Iha wrote:
> > On Tue, Aug 4, 2020 at 10:25 AM <peterz@infradead.org> wrote:
> > > On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:
> > >
> > > > The results can be seen this way:
> > > >
> > > > This is an excerpt from the test.log with the result in TAP format:
> > > > [snip]
> > > > ok 5 - example
> > > >     # Subtest: min-heap
> > > >     1..6
> > > >     ok 1 - test_heapify_all_true
> > > >     ok 2 - test_heapify_all_false
> > > >     ok 3 - test_heap_push_true
> > > >     ok 4 - test_heap_push_false
> > > >     ok 5 - test_heap_pop_push_true
> > > >     ok 6 - test_heap_pop_push_false
> > > > [snip]
>
> So ^ is TAP format?

Yep, you can see the spec here: https://testanything.org/tap-specification.html

>
> > > I don't care or care to use either; what does dmesg do? It used to be
> > > that just building the self-tests was sufficient and any error would
> > > show in dmesg when you boot the machine.
> > >
> > > But if I now have to use some damn tool, this is a regression.
> >
> > If you don't want to, you don't need to use the kunit-tool. If you
> > compile the tests as builtin and run the Kernel on your machine
> > the test result will be shown in dmesg in TAP format.
>
> That's seems a lot more verbose than it is now. I've recently even done
> a bunch of tests that don't print anything on success, dmesg is clutter
> enough already.

What tests do you refer to?

Running the test_min_heap.c, I got this from dmesg:

min_heap_test: test passed

And running min_heap_kunit.c:

ok 1 - min-heap

BR,
Vitor
