Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D35C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3599621702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bw5qLVhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgGUHW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUHW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:22:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55ACC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:22:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so5152826wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mDt5kpJwMymYRqRaKvVOgNHH4S840KB1Q5qo8lJK+0=;
        b=bw5qLVhwEPApJIrN/Od0X5ERx0RDO466+X493IFt0rXA/P4fBmJPsCu3QySCOrGThs
         wdkqhdDfdWaZlpCe4mRNB+29J1pPcrBQrkjXOKOJpN9m8pEDCLq2pjVXFUEgi2AxVdvC
         dng3OJA5cj+QorM5salBcPEY6IEAzDqnMMqRujGUhGDIyePZTjkeic3K/m8JzspgclvQ
         tvT0Dq4hgrhg08KwifNAzzs5BqSxzRVv7geSSYDtE4NXQleFE3TnuvA9kdYZxuTSsvkq
         ZlbENIeUi25Qw4Tx7tlbJJHXgLzzOiYjtFrUhuuyY5VdD4sw/cDDX92KTObc9VbiLEQb
         u3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mDt5kpJwMymYRqRaKvVOgNHH4S840KB1Q5qo8lJK+0=;
        b=iVfOSzfJRfz/Z8uzvoqG1yJNT9jowwFNJIbNjE4LCgF7I1aWgkR5e+XYzFvswVrqXQ
         sFOAsybRhpn5iHBHB4INemZP50mQ0biZDs0kG9trbJoF5HVYp2Oi39RG6A3MI7uWasZg
         i0E5xhvHSKfNnMNciwkuzGjP3+Cguk2MFplKLJTGNrOclP3jklSyGCSxAl2btRSQlekf
         lPhGwMeTV+CflUDIQbj+8nnVHKhvbWZdm7GuyORMIXD6oXLrvpJ7D5tVXQ2DZYzRNg3M
         ef9+kyAO9XG2l+tlMWGzn7fj7VTePFIz7Dc+MtsqNKIjKBzZH+MqdmclSIvTakXVWEBf
         buqQ==
X-Gm-Message-State: AOAM533e60D2O088N02gkGEiVUw2hRXGbRBejVRP0n/8RKfD/1fSk+Jq
        26L5Uqeprk0aKQXp4tJFSZ2wOISct7HIRxhLRe96rrfyx+0=
X-Google-Smtp-Source: ABdhPJzg0r2NZuAxysESnJp5XGQlor6++234SGZEwSzn9eOy1cmWLxft/eGYyuiWJNhNzm0VuRS4dJaaQVFZkLwiK9w=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr3977421wrf.171.1595316146210;
 Tue, 21 Jul 2020 00:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Jul 2020 12:51:50 +0530
Message-ID: <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 22:43, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
>
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")

Hi Nicolas,

I see a boot regression with this commit d9765e41d8e9 "dma-pool:
Do not allocate pool memory from CMA" on my Xiaomi Poco F1
(Qcom sdm845) phone running v5.8-rc6. I can't boot past the
bootloader splash screen with this patch.

Phone boots fine if I revert this patch. I carry only one out of tree
dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a stock
phone, I don't have access to serial/dmesg logs until I boot to AOSP
(adb) shell.

Any thoughts as to what might be going wrong here? I'd be happy to
help debug things. For what it's worth, I don't see this regression on
other two sdm845 devices (db845c and Pixel 3) I tested on.

Regards,
Amit Pundir

> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> An more costly alternative would be adding an option to
> dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
> in a specific zone.
>
>  kernel/dma/pool.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..4bc1c46ae6ef 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -6,7 +6,6 @@
>  #include <linux/debugfs.h>
>  #include <linux/dma-direct.h>
>  #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>  #include <linux/init.h>
>  #include <linux/genalloc.h>
>  #include <linux/set_memory.h>
> @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>
>         do {
>                 pool_size = 1 << (PAGE_SHIFT + order);
> -
> -               if (dev_get_cma_area(NULL))
> -                       page = dma_alloc_from_contiguous(NULL, 1 << order,
> -                                                        order, false);
> -               else
> -                       page = alloc_pages(gfp, order);
> +               page = alloc_pages(gfp, order);
>         } while (!page && order-- > 0);
>         if (!page)
>                 goto out;
> @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>         dma_common_free_remap(addr, pool_size);
>  #endif
>  free_page: __maybe_unused
> -       if (!dma_release_from_contiguous(NULL, page, 1 << order))
> -               __free_pages(page, order);
> +       __free_pages(page, order);
>  out:
>         return ret;
>  }
> --
> 2.27.0
>
