Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF86C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0892072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqPTCWuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0SK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:10:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37276 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0SK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:10:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so12389796edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgLPKsmfWVu/jSbaiK5YtS+h03FH0KlNpjtZGdb44ik=;
        b=PqPTCWuS2ibLmwAWw9gb1YvuH5vJbKB6wXMzh5L9/UuhpBLj5DVX4tuRr7KTUhNp0B
         WcFVL9vHWL3RL9KJ92YsCMGDSW8p+jRDCzOgfwhaEmzNd8u0GzMFg2rdpDIBr7mqjMFD
         ZxGlBmrGxCQp86bJgQVTzymz+3cysJ36qPZ6kQXql6GwdRgvpf0rUZFXFszV7cKU+hEO
         oDl1yR1VVozpU+HbHYKKuOt9CH8o9R9BXRJhDPkAHhm9nT/a9XaCRVKJw0Z1HPAJ38ZE
         yrUU7Dl805Q2gOPrz0x8UqCrN4ivWL4ME5dBaRilk0FaYu1z6W5W7x9eCF1XlKf/qY3m
         gSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgLPKsmfWVu/jSbaiK5YtS+h03FH0KlNpjtZGdb44ik=;
        b=GCZuAfElRnPDbBr5a9vB9uLG6uEWJswUjsID1G+sfP7xbVo6c44Q1Mv2YytB50XGwg
         Z6p0azcb5AGFRBOcz+qCkZmK3bf6TpHfpLQFtoa3e7IFNddkV7Gup2GWsgz7A6PQFTWs
         oRe7hkhqxPVaZLeeHL/9k5ABbuL5FURQnYwGBiz1D4hzopp0Igyi+Zs/cLwsUBSgLTcs
         uu4QxjQqnbppUY3SyGS18G5H++ReLPee5RVIxU7ihOBU9DWaZDVkSVfrxP9a1g03SyS3
         Vohg5Hu1zzJpZTFKu6M41aADYMuH+fOH2JlZ5IgpvK7aNQmKUYlZ+vn08XrP90HBMIFh
         0aJg==
X-Gm-Message-State: ANhLgQ3bkBWE20yA2fmp6gCNBSfURWmuGKrEksWBR3YJQgLNsZ6MyTe7
        hPCWlz5FcOwPEI1RZTuI+yyq+rL5mMOKNNZcjmY=
X-Google-Smtp-Source: ADFU+vvN0UUlONTwZNdlp5HxOlnmdQrR7kdvIyEMSXCJV2YAqXTiDG8jHfNVJcFGibcS0ZsRpTeOTKu5AMbgzliGcQU=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr352734edf.372.1585332655311;
 Fri, 27 Mar 2020 11:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com> <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 11:10:40 -0700
Message-ID: <CAHbLzkoe-07mxAuA18QUi=H21_Ts0JcbP2SUT=02ZTPhaQB6ug@mail.gmail.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of extra pins
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> pagevec. It's petty common for swapin case: we swap in pages just to
> fail due to the extra pin.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/khugepaged.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 14d7afc90786..39e0994abeb8 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>                  * The page must only be referenced by the scanned process
>                  * and page swap cache.
>                  */
> +               if (page_count(page) != 1 + PageSwapCache(page)) {
> +                       /*
> +                        * Drain pagevec and retry just in case we can get rid
> +                        * of the extra pin, like in swapin case.
> +                        */
> +                       lru_add_drain();

This is definitely correct.

I'm wondering if we need one more lru_add_drain() before PageLRU check
in khugepaged_scan_pmd() or not? The page might be in lru cache then
get skipped. This would improve the success rate.

Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>

> +               }
>                 if (page_count(page) != 1 + PageSwapCache(page)) {
>                         unlock_page(page);
>                         result = SCAN_PAGE_COUNT;
>                         goto out;
>                 }
> +
>                 if (pte_write(pteval)) {
>                         writable = true;
>                 } else {
> --
> 2.26.0
>
>
