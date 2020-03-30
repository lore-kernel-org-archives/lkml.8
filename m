Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CD02072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbVjwtVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgC3Jjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:39:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39653 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgC3Jjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:39:52 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so2560449iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1gUtwRvLYdtrLbJA/IGQZdtPAAqrGpsy+JPnbE+NNQ=;
        b=qbVjwtVD2BzCf+Qpuozkb4s5p58/+w8HArwivwoaXjhQM4BRBbJZD1kjXjvrGMR2Sc
         c01PLmgHVLFPuJdFniHGMXu2w6rLIvzSQLvalO8Q/dKJVfnW9vg91QmDa9qpqpZ7A/ZS
         NDnjOyLxG5uOej6SWj2xLai2CEnoKXDf6G/88kxwgjdURScr1KviSCU82A3r3qOvk7Za
         GBKGw86I9wMmNFgdiGiFT5xs9qqCa/TWhd9uDOg/D0UssIN9Xx67PlvK9ktcyPpHSzvN
         QQdk9LkTYzni3Q3RY1WZbO9dB2TpaMazsGCIZeybPYWY90TNh+m5vd71koBGJ9unsrrI
         ZAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1gUtwRvLYdtrLbJA/IGQZdtPAAqrGpsy+JPnbE+NNQ=;
        b=s2OuG0zGT3XI9YoFtPSkGgVlQLNNtX3nCURYo9ccccteZGMlIRaYIiOrqBWvazA192
         Q/VACLTOraec6E7cEGTxpEHkcoV6IvNNKX2mhXKOQQf5ORIzuesFP1gJv7OVwFeS941a
         8XzPVJm6AmjQoJwYCoardEBGQOnGYxLssfrF067OejK0s0zTIznXLJ3+y9nTo3F4fBh5
         qEgKZ/NPgzhodZgduZ+iJG4xs9BFb0tgFE5aHvIgjyJcjKkI++ax4JLtg0FQen9HSW6N
         ix62GjzL13ep7kjfSN2IeASYE81Hc9yRd/2Vv300A2LJyyvBr0vI7f6USoE9rhHPGMfv
         uB8w==
X-Gm-Message-State: ANhLgQ1p7EExOV0svND6v5lXBFFi2TxJfum/usD6iCm1In0sfIFo5Q49
        pbPJMsAS06wp9ZV+ce9EpJAqh5Gup6z85GODqx8=
X-Google-Smtp-Source: ADFU+vtaoT6KjcJ9ecQiB0qXnt+YZYGFPOYnZ5jKaU4tddPcw7WZUkopfgN0n8FZ4HONOwByDpEh1zQSusUc3tl1iv0=
X-Received: by 2002:a6b:c916:: with SMTP id z22mr9873080iof.138.1585561191793;
 Mon, 30 Mar 2020 02:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200325090741.21957-2-bigbeeshane@gmail.com> <CGME20200327075458eucas1p2f1011560c5d2d2a754d2394f56367ebb@eucas1p2.samsung.com>
 <4aef60ff-d9e4-d3d0-1a28-8c2dc3b94271@samsung.com> <82df6735-1cf0-e31f-29cc-f7d07bdaf346@amd.com>
 <cd773011-969b-28df-7488-9fddae420d81@samsung.com> <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
In-Reply-To: <bba81019-d585-d950-ecd0-c0bf36a2f58d@samsung.com>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Mon, 30 Mar 2020 10:39:41 +0100
Message-ID: <CABnpCuBu0w7th2g+0EJvrFr2RFDC-uhHhOF1gvfsM-K0sjM5mg@mail.gmail.com>
Subject: Re: [v4,1/3] drm/prime: use dma length macro when mapping sg
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        amd-gfx-request@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:18 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Today I've noticed that this patch went to final v5.6 without even a day
> of testing in linux-next, so v5.6 is broken on Exynos and probably a few
> other ARM archs, which rely on the drm_prime_sg_to_page_addr_arrays
> function.
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Not sure what the full merge pipeline is here, but my original patch
was not sent to the stable mailing list. So I would assume that it
went through the normal release gates / checks ? If there was a fault
on the way I uploaded the patches I do apologise however I did follow
the normal guidelines as far as I understood them.

Personally I did validate this patch on systems with Intel and AMD GFX,
unfortunately I do not have any ARM based dev kits that are able to run
mainline (was never able to get an Nvidia TK1 to boot outside of L4T)
