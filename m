Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13313206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifu4mAhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHXLt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgHXLt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:49:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D93C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:49:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i13so2126819otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfIxkLsRxova3XYkDm6i/K8H2HRLaB3EQ7huQjW3f6w=;
        b=ifu4mAhcTRgtT25z97rVnVLSZIehYoWZP8njiAuMAclckn9QF6jbVP9Hz7Htj0eApu
         mAtaaK9Vv7vTMujUpSkvkdv59rffw4S+b4wo7FklQ4IG/DkO+lejrQgJuaRUVn5yPkkf
         Ugo6AK2ksLHd7xu8urFifQ5nbrZf01NR6zdW3IrCwjZ2bEo68yYEKe+C3635MLiW5BSV
         Mmy+tihlpl7pk1aBdkegmzmwQtmMwLz+rebJoqtGTgAG8H+Fr6z5tMjoYOB8Diw+cuRa
         7z2JPsLcyQRrjG2k9P3H0xHTrBpndrxWp3GysVNseNU2L1WSHLLP7FLCS1SQXOXp1UY8
         EWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfIxkLsRxova3XYkDm6i/K8H2HRLaB3EQ7huQjW3f6w=;
        b=kjgbqGYv+KsarhRFkTrUPiYVobrfuVOVBoF+9ypgW36b0I3or+bHatfpKgc+7Y7jMU
         V5n4FzxNAoUfCV7bu68nz5eyMosnu1mGBire0ojbqJGz0kFMyPQFiHxl+zItnt3mVpbE
         dh4yzXwzxhj+QctsVKxgcR4ztWOy9iqRW1b0a+9l4104zMTQd7wN3+XNBnUyCD8ZLaZt
         YntqRCPG6NlqGyhm9uQ5n0mk5TDOawo+Yaw/ggHlT6/ux/c3H+exjibA/fXcrp9MNKQh
         GwjVKKg5JimVoQoQ127byFOAYUYYoddbGnDnjkA3eYYkDUKxGqyoMHvc/LmPxgoQZKGV
         1nfw==
X-Gm-Message-State: AOAM532J8na+M0iC5bc5xpBAP9N2V2gefwzWE5jtL0cY9I4dcZK45MWI
        rfL+wciUbYz6tg3M0ck+5nRNCC2bV5OYUktpyrHBGw==
X-Google-Smtp-Source: ABdhPJx8/ShV3Gs8ffER3S7rZnw0ZFPWF5N02fGQqTCvCQFx6YSWKYgZLvFexBYVMpA5tpKhoxssOwaUlfs41PMlPVI=
X-Received: by 2002:a05:6830:1612:: with SMTP id g18mr3040756otr.251.1598269765865;
 Mon, 24 Aug 2020 04:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200824081353.25148-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200824081353.25148-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Aug 2020 13:49:14 +0200
Message-ID: <CANpmjNNf5pr=0hKVo92M9fEnCy7sYbv==6Bv_sVSmn=rZi7JEA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kasan: add tests for workqueue stack recording
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 10:14, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Adds a test to verify workqueue stack recording and print it in
> KASAN report.
>
> The KASAN report was as follows(cleaned up slightly):
>
>  BUG: KASAN: use-after-free in kasan_workqueue_uaf
>
>  Freed by task 54:
>   kasan_save_stack+0x24/0x50
>   kasan_set_track+0x24/0x38
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x10c/0x170
>   kasan_slab_free+0x10/0x18
>   kfree+0x98/0x270
>   kasan_workqueue_work+0xc/0x18
>
>  Last potentially related work creation:
>   kasan_save_stack+0x24/0x50
>   kasan_record_wq_stack+0xa8/0xb8
>   insert_work+0x48/0x288
>   __queue_work+0x3e8/0xc40
>   queue_work_on+0xf4/0x118
>   kasan_workqueue_uaf+0xfc/0x190
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

These will majorly conflict with the KASAN-test KUnit rework, which I
don't know what the status is. AFAIK, these are not yet in -mm tree.

I think the KASAN-test KUnit rework has priority, as rebasing that
work on top of this patch is going to be difficult. So maybe these
test additions can be declared optional if there are conflicts coming,
and if that'll be the case you'll have to rebase and resend the test.

Thanks,
-- Marco
