Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4BBC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BC7206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhRgWIyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgELPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:34:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66200C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:34:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e6so9556542pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1nGYbQQUmvuJU/OQ0QH/3SmFbvxo3s8FBGQi1+ShN0=;
        b=JhRgWIyGDLGDgVyj026NrKDvn6dkTCd+VU8mrYizgnc2WSuuh0KpIX2YDQFjoGLhrS
         ZVYeOZ5ffD+ZChhzZUQkkYPazdKadKg4uqhWA8a4VoAH9bI69Ar1hoePsH567m87/L4J
         bxIvjQWufessKMrKot/IlfwZ/AwsJ0mo3QyMw70GBO3RVxIWAY9xdVh2um3imALaO2PQ
         3F97ygOyuEiXg46fHynVzEe1INWAM0MNHlcpmgH0sMbthqGtsMuxGeiq0g9q8GZZQvpM
         xIeBJG6EbmtCeLTn1ucAXafQGlZaB71i2FUDvRoSvbuSZICBzLtn4GTL7Paow3nMLNQw
         yIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1nGYbQQUmvuJU/OQ0QH/3SmFbvxo3s8FBGQi1+ShN0=;
        b=Wc6TAeb9w1MhsUBW96DRRVdNYXYsvMgdYRIYQZQhEZ9JK26pO4vbb4QBtsSDOy2OGf
         ZDevHz4nR/mxXfSgIUgrXgTXXmadE8cVOnYeYYH78tt0lsaLoe1iZWaUaMmu9pmPEdfz
         T560XcK2ZGiIAwHt+35ffWXqmh6XqPLza/lqa1HD4oS7I8XiK7k/0EvZINTaO+fWJA+z
         3cdBFy/7x35scgrkrSVFaxIH9ONxe9n2MAjJewyJfOfUuWc8Xl190vWMrUeDnoEamRVA
         xUzJJkyS8XCUrNnkjU9djxO+pl9rMiY6bTVm2jqgo6FazgFxaMbIZ4SvbG1PY7vs9eJJ
         OK+Q==
X-Gm-Message-State: AGi0Pubp4AB026N67ihdqrWmJbfYzVl86mfmQZvni90bvV/Cya2TH4ax
        AvibmJGj0dEXE+/pZGj/fki9FAtZrYBFxW+3CnIEyw==
X-Google-Smtp-Source: APiQypK7/bKHf1kUJGGT+0rp9NRHuxwfhfT/LmdCu+FeC9iSpuFycx5/OjmLZJ4ijBHilmyuUebshEcCuTnSMQIolWQ=
X-Received: by 2002:a17:90a:dc01:: with SMTP id i1mr27443683pjv.166.1589297661687;
 Tue, 12 May 2020 08:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200512063728.17785-1-leon@kernel.org>
In-Reply-To: <20200512063728.17785-1-leon@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 May 2020 17:34:10 +0200
Message-ID: <CAAeHK+zFDoykmS3KD88hD3S8R09n064c7n1gLDurMr0KOhte5A@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/2] Fix kasan compilation warnings
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 8:37 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Hi,
>
> The following two fixes are adding missing function prototypes
> declarations to internal kasan header in order to eliminate compilation
> warnings.
>
> Thanks
>
> Leon Romanovsky (2):
>   kasan: fix compilation warnings due to missing function prototypes
>   kasan: add missing prototypes to fix compilation warnings

Hi Leon,

I've mailed a series with slightly different/fuller fixes for these issues.

Thanks for the report!

>
>  mm/kasan/common.c |  3 ---
>  mm/kasan/kasan.h  | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200512063728.17785-1-leon%40kernel.org.
