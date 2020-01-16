Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595DDC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299272077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfoDxmeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbgAPIHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:07:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46979 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:07:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so6859336qtr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IBdjvFRag9yZE/BKc5brHAQDARDtIXaGhkF8uJXRlQ=;
        b=qfoDxmehHt9zSJPjWabWfKApmNG47N0Q2/pjIts+XRh7UWc4ym2jspVC7dOFfypjnv
         qnIVrd6DHS4ExoKZLCfn7EiaWjc0VJ+thpAfGN13cJj50S+8ZZzG+BJuvVxj4+JMY4+Z
         R2R3sRy25/3S2Joee0sQyYVPnaXfnDYs0aGfjD1YGJjSt+TL0rdiQTLtodpF5kf/j6Pw
         othExYiiQoemDJnBkRX0X7T10o0baCnxfWlv3KwtSYdf0iHOwTBM8pggRIyGf5JBaiRK
         YBZSQa8lfcCAuhH2hwTvIHBU2LeyizZrqo97LUh1gq17vixbEJpIajFMOXrsvxxStmsS
         +BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IBdjvFRag9yZE/BKc5brHAQDARDtIXaGhkF8uJXRlQ=;
        b=Y8xxgm3zXixjXTXdtQL5WmqtqCS8CSSeL895xXn2Pa2NEfg9R5uWQK9jsC9ZyA6t2b
         Q0OEziuWq5BHhCZmPHSvsSwx3hlHdEz64ip3bhlkzexABrtIz6RIgLsY0wHv+Wfak7M/
         r8VqB0zjf08fNVDlwAO/nxi/5PBbUONlXyD4wq3eohepnZjWCNCLVuzRO4LztQ66y9U5
         rX5loJghXdH3GCvqbNqLBorGqk0UcoSSI94dOc7bC7C/hM6K5LMOtojlofHOYNJ7zYZ0
         oEZVFdidC+iJDpDeLqrVYtwJpRpgTXqPzXF/mVg34NdDLi4LlvhzGcd10dlphTH7umxx
         k/og==
X-Gm-Message-State: APjAAAVbsG2SLz0duzTuPW0MJubKIjNXbDQsNlylGKWGRUjRhXdZfPIj
        ylZH5PKGVYq1el93Rd99mc6q4qfz3a2K0jkZvWhO7an2
X-Google-Smtp-Source: APXvYqzAhF+/72Zrdu85/2jD42Zoi8Td02RrL0uBou/vlg73GMNKwc0ffgSpLNGBhaZsCL3tktCpzfELeo9cOZYU61U=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr1194993qta.380.1579162063680;
 Thu, 16 Jan 2020 00:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116062625.32692-1-dja@axtens.net> <20200116062625.32692-4-dja@axtens.net>
In-Reply-To: <20200116062625.32692-4-dja@axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:07:32 +0100
Message-ID: <CACT4Y+YpOm9cDk5Hi62iAwMFgiotzWjfiK4i9-9jkha_ZNwuvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kasan: initialise array in kasan_memcmp test
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 7:26 AM Daniel Axtens <dja@axtens.net> wrote:
>
> memcmp may bail out before accessing all the memory if the buffers
> contain differing bytes. kasan_memcmp calls memcmp with a stack array.
> Stack variables are not necessarily initialised (in the absence of a
> compiler plugin, at least). Sometimes this causes the memcpy to bail
> early thus fail to trigger kasan.
>
> Make sure the array initialised to zero in the code.
>
> No other test is dependent on the contents of an array on the stack.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a130d75b9385..519b0f259e97 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -619,7 +619,7 @@ static noinline void __init kasan_memcmp(void)
>  {
>         char *ptr;
>         size_t size = 24;
> -       int arr[9];
> +       int arr[9] = {};
>
>         pr_info("out-of-bounds in memcmp\n");
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200116062625.32692-4-dja%40axtens.net.
