Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD06C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08492075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="G3zRJ+LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgHDNrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:46:59 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:46:58 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id e14so8105254ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 06:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrNhj1Agg0SHP12xm0hT7igSJHpcqAu4hLHMIrMVovc=;
        b=G3zRJ+LKHYQQmQiEDLgcscZ2UUOj3wnQ+W1Ni+ec/JMwsPKzwklZyd072ljtj+nVO6
         DjIkXeHLgdqAKIKMjpAkUPNVqcm6ySl63YS2p8R0uhI3oxgnwnOXtMI+cEpr5VIYpRt8
         iTo4JJFxDadosfOFWdP4bXgOp5r7YNffY4SkmaE14plPbAP6zeSPq9XWT74uhdcY3k0s
         c/oukbwmveqPyIF0QZ71Mv82UlY0dhrqEY4/h7FYFBsrapCPezpnG5O6FengjYzBPho1
         S1XNizrVbhTLpKayFkFX3MMdKazNk7DvJdqz+Rmgq5kcCZ2QuXL6Ry9Cb2Zrl0VWepjr
         0k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrNhj1Agg0SHP12xm0hT7igSJHpcqAu4hLHMIrMVovc=;
        b=k4oN8g0ijSjrMQHi68OFkenDcZR+fJeqT3i3bGJgUOuX/BF3MpPeJousRZGKKxzG02
         pyog5Pwcn+0/gXWOHAS7WLsDHMSKJAAI23xCRCaTwUyo5suzZ07yDhJBU5PVJdxDbYwf
         ShOiqyukM9q4Ta0gDFgjqX4qwN8HstzInY5B+eQIEyv36icOaeNoP/mhm2riLJtMD/qy
         mBbqi0f+ZyFeDoLPtU+ESIl0RHHC7RnQA+/GXpc2B2xfr53E5ksd/T0sSoiNx5NvhIGw
         UeYnfXj/iiCB4IvgoPgzulFb/99Jf/Tc4lHM7lb5/l8eJW0yRAObqMMCY8C8D9tRu3tl
         i+aw==
X-Gm-Message-State: AOAM533PdGcBU7yQksHzCRohCHe74eYhYcJREbcTrdCNp4OfHQQvACtx
        kwlDkQk6VlYJ7nIuleZ/X5+vu3W/HuYakW8VlM5JmQ==
X-Google-Smtp-Source: ABdhPJyOumCE9cxEnt0Ldc35X4Mj17jEYTCzkeETyZ7RjgfcQmd5geR9G2CuZLBYmTQ42LfeW667+pNFxkOXD8eQY8U=
X-Received: by 2002:a25:843:: with SMTP id 64mr17548617ybi.311.1596548818054;
 Tue, 04 Aug 2020 06:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200729201146.537433-1-vitor@massaru.org> <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com> <20200804132517.GK2657@hirez.programming.kicks-ass.net>
In-Reply-To: <20200804132517.GK2657@hirez.programming.kicks-ass.net>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Tue, 4 Aug 2020 10:46:21 -0300
Message-ID: <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
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

On Tue, Aug 4, 2020 at 10:25 AM <peterz@infradead.org> wrote:
>
> On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:
>
> > The results can be seen this way:
> >
> > This is an excerpt from the test.log with the result in TAP format:
> > [snip]
> > ok 5 - example
> >     # Subtest: min-heap
> >     1..6
> >     ok 1 - test_heapify_all_true
> >     ok 2 - test_heapify_all_false
> >     ok 3 - test_heap_push_true
> >     ok 4 - test_heap_push_false
> >     ok 5 - test_heap_pop_push_true
> >     ok 6 - test_heap_pop_push_false
> > [snip]
> >
> > And this from kunit-tool:
> > [snip]
> > [18:43:32] ============================================================
> > [18:43:32] ======== [PASSED] min-heap ========
> > [18:43:32] [PASSED] test_heapify_all_true
> > [18:43:32] [PASSED] test_heapify_all_false
> > [18:43:32] [PASSED] test_heap_push_true
> > [18:43:32] [PASSED] test_heap_push_false
> > [18:43:32] [PASSED] test_heap_pop_push_true
> > [18:43:32] [PASSED] test_heap_pop_push_false
> > [18:43:32] ============================================================
> > [18:43:32] Testing complete. 20 tests run. 0 failed. 0 crashed.
> > [18:43:32] Elapsed time: 9.758s total, 0.001s configuring, 6.012s
> > building, 0.000s running
> > [snip]
>
> I don't care or care to use either; what does dmesg do? It used to be
> that just building the self-tests was sufficient and any error would
> show in dmesg when you boot the machine.
>
> But if I now have to use some damn tool, this is a regression.

If you don't want to, you don't need to use the kunit-tool. If you
compile the tests as builtin and run the Kernel on your machine
the test result will be shown in dmesg in TAP format.

BR,
Vitor
