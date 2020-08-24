Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBCBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091D1214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuMev4pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHXLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHXLqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:46:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF24C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:46:37 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so7958243oii.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSpd9ndfyXeRtsopkN5H4Z9El4e9MphbysoofBmUjKk=;
        b=iuMev4pI1UXTK36SU5vo9Kb9A9hOWP30Dj81Zo7qdgxbcyzH0j8fQwJHFTueOj095U
         5slvsAiAYB4ZSz7mRzUwSk2bkGa0/TJnvlcnEPFiEug1QedBDSwH6I5zjK3kSswknmUx
         Lzol4pMRkdLbVAB94FPqz4XQkcp8nuM2aRbklxyqY7e/ebJt0i1fNKFTvYbotc4DVv+b
         FSS6rdqU4gpSNqKcv464DOsapk+LPNAJUGEC6e5l72ZEKjM0PscLBYKA6KntyFjA96ud
         rjUhcbtVF+UYWBO11lyINnbB1kgj9RQdFFUSLkEH7UzhcbNRix3StySlX86yNNgHEeTe
         F4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSpd9ndfyXeRtsopkN5H4Z9El4e9MphbysoofBmUjKk=;
        b=jbt3+8sXpOhO3FmH6MVPO0PnY4VJ0FLRyrAqeE/bhmTIFVtIWHO5X77+e/PWiPFqcr
         ky5MKD3Dzq5bpC/1rPqfYCvFmhhy6wgBqTzCnD9XsoJ1n9hm471vFOJGj99JxEOMWli3
         l/AgeaIa6F8Q1da6vk+WayO+1HRutkfOpVSsx7HUS8APuBwvPOKibQPENliCdbbnWJkI
         c22+NmWKN3oaLFs6eVmziEY86gtbuHBZ+XbZdQXpIPbXavHofjnuYbeQ5T8Hhx/+4QAc
         Z1Qa8aMeoB46DI6JlkHqNOtl+v1g9AACHQSOJFif5qoNzJp/OYYrFbI2wow0Bhxf3dZC
         PU4g==
X-Gm-Message-State: AOAM5303W6eiVkQA5GYcbQ3VYzT+CEKNT1bYcsGMhtAjGYcdBP/B8kJG
        6QysZaObj4/MylKT3678Qj4ykq1AAmeEXHICw6NRFg==
X-Google-Smtp-Source: ABdhPJy6Rvbpz4OVF7+E6Ibj6h44yQcnycBjoZStHMF7KBGlki8rKNee1gTheosMNsZuvJoobdu2aNNGxai7LvPhZeA=
X-Received: by 2002:aca:cd12:: with SMTP id d18mr156277oig.70.1598269596930;
 Mon, 24 Aug 2020 04:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200824081433.25198-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200824081433.25198-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Aug 2020 13:46:25 +0200
Message-ID: <CANpmjNOSKQi+wYbCVYqL-LriqCD37GtOfrArB0hyKysaPYyzGQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] kasan: update documentation for generic kasan
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 10:14, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Generic KASAN support to record the last two timer and workqueue
> stacks and print them in KASAN report. So that need to update
> documentation.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/dev-tools/kasan.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index fede42e6536b..5a4c5da8bda8 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -193,8 +193,8 @@ function calls GCC directly inserts the code to check the shadow memory.
>  This option significantly enlarges kernel but it gives x1.1-x2 performance
>  boost over outline instrumented kernel.
>
> -Generic KASAN prints up to 2 call_rcu() call stacks in reports, the last one
> -and the second to last.
> +Generic KASAN prints up to 2 call_rcu() call stacks, timer queueing stacks,
> +or workqueue queueing stacks in reports, the last one and the second to last.

We could make this more readable by writing something like this:

"Generic KASAN also reports the last 2 call stacks to creation of work
that potentially has access to an object. Call stacks for the
following are shown: call_rcu(), timer and workqueue queuing."

Thanks,
-- Marco
