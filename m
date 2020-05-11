Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0AC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC448206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILnkM6H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgEKKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729086AbgEKKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:52:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864DAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:52:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x8so7400089qtr.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72CupRCuRPXXCvNwucE/1jDQJJRDxROzY5cHpuICnYs=;
        b=ILnkM6H19JK17KC3M5FAIaz0BrdJVQQCiKVz4hMQKY+zmUQLJmBjxqaofT2C/PU3bR
         lHITSoyEEq2oW26FnPNPLeLM+tiaSBXyJn5L1+kFGVUjqX7SpOtLm9yp/z6X6p6oEQmH
         ndb1m0gPuuPgyVNoMkNvQVywYqrDZDn39LAH6xZrCMKOauwpePg1Oz+BIRB6x8nt6d4B
         lQ1P9Eaw9sPiGAiWu4AhIUnGQrLw2+nsxYKt4JvErU8YbQ0Cb5jgY1s8cq7MP8HPxc76
         eUQS+lo9zvS/M7Rt+cjaAuH4xJ64f62hwjRn8smLeYRcRmBvI4hLFUrWOGCgn+0RgD9k
         9pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72CupRCuRPXXCvNwucE/1jDQJJRDxROzY5cHpuICnYs=;
        b=kJIPB0cgHR6NnIXMFJboXcRlQvOPAuR3Dde04cEPXeObGMaxol2mcnvd62RvgbZDHB
         T/OCS29UrfqNyMPg4hHwyZO1d+Imw7hPZFXNL8PgvePREavJLL+Et/haA7RJbRveLr6j
         NMe30I68GGk6ES9xnRJAWGTr3NopNDNA+rG540IHzyexiY91HirJn0ugnYCC9N2lA9vF
         bDJ0DIi/TtYK2hmIXX/EUikBq5sBs3ZfKBdi2oj2H4KxCid9bDy0qhw3OiaVvDZ7ZRmM
         3p1KBS6vvkWCXpnQ3PGk/ZifpRlriB46FHTu9ZaLmww1i8ziSMJc2L57Wj1VPOWbxf7k
         8zXQ==
X-Gm-Message-State: AGi0Puah+/0Dgug1F2MD+GN/6XB8NHZvOINW+dEG33g2Jreq1sPs+x0t
        8Nl83YpKQvUdBtasCRG2tPSnkbFZ2KmzE/8PA19Pjg==
X-Google-Smtp-Source: APiQypJuV7vh5fEAGAZHwSjBCKi7okLe7bGzhUJ7V6MHqJk55bkwMB8VH74FcIlcoOfXfKrlsq8FE9ROC7OHxh1Ytq4=
X-Received: by 2002:ac8:370c:: with SMTP id o12mr15522299qtb.380.1589194350352;
 Mon, 11 May 2020 03:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023231.15437-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200511023231.15437-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 May 2020 12:52:19 +0200
Message-ID: <CACT4Y+aL_R4uVFugsj3wXeXw2oXbe6KQ=YmwD0jCrUH_12ouiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: update documentation for generic kasan
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:32 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Generic KASAN will support to record first and last call_rcu() call
> stack and print them in KASAN report. so we update documentation.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/dev-tools/kasan.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..d4efcfde9fff 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -193,6 +193,12 @@ function calls GCC directly inserts the code to check the shadow memory.
>  This option significantly enlarges kernel but it gives x1.1-x2 performance
>  boost over outline instrumented kernel.
>
> +Currently

Currently is excessive here. Everything in the doc is about the
current state of the things.

> generic KASAN can print call_rcu()

s/can print/prints/

> call stack in KASAN report, it

KASAN is implied for "report" in this doc.
s/KASAN//


> +can't increase the cost of memory consumption,

It does not increase only as compared to the current state of things.
But strictly saying, if we now take the call_rcu stacks away, we can
reduce memory consumption.
This statement is confusing because stacks consume memory.

> but it has one limitations.
> +It can't get both call_rcu() call stack and free stack, so that it can't
> +print free stack for allocation objects in KASAN report.

1. This sentence produces the impression that KASAN does not print
free stack for freed objects. KASAN does still print free stack for
freed objects.
2. This sentence is mostly relevant as diff on top of the current
situation and thus more suitable for the commit description. We never
promise to print free stack for allocated objects. And free stack for
allocated objects is not an immediately essential thing either. So for
a reader of this doc, this is not a limitation.

> This feature is
> +only suitable for generic KASAN.

We already mentioned "generic" in the first sentence. So this is excessive.

This paragraph can be reduced to:

"Generic KASAN prints up to 2 call_rcu() call stacks in reports, the
first and the last one."

The rest belongs to change description and is only interesting as a
historic reference. Generally documentation does not accumulate
everything that happened since the creation of the world :)


>  Software tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200511023231.15437-1-walter-zh.wu%40mediatek.com.
