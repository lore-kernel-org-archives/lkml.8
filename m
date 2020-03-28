Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD347C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8269B20714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hypZZ56o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC1SXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:23:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34907 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC1SXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so15747780edj.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R436PKaf7Me7i9Q+u1EyxQhECXtmveD85TYjBFq47Tw=;
        b=hypZZ56oIK1R5yJZ8yM4evhkoSOKTKu4FO6ru0cfN+t1sEKakoBcMTsfznAy7BPK/I
         +7t6SVe7/KDB9k4WIQfKr8OaB09sWme6xjjK5DEhXfHYTkHO6O3ntWdtxPxxx0uFy5WB
         +plf1hd9cEYp7e590pGK6oO2PO2dZLXCMCIueB5ImbOsaznC4FfAtlPifo8t/O2mlh3I
         V60Y8qXBZ0fKEzCw2ye/Zk1vFq4fiIB7PTP6KBHPA1XJ1hfvJenzYblr64fEBRD8IPAc
         1trh8RBfBe0nZN05Otm863olSui4NnCehOCbtJY5tAYRnGhsrp9cw6wMaM9A6ozdDoCe
         7RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R436PKaf7Me7i9Q+u1EyxQhECXtmveD85TYjBFq47Tw=;
        b=awfXPih/rhNbP7XnH/75VBX+GIDz2VJEqEYR27cyrDzBP5dr2iF2yCcN4TRH9gCEIt
         N92mOroNnyupQfOB8EHouWudZLXJTyxdVxO0mZi5eX7C0wN7eVIBpqoGObqF4RxizG78
         AqJ4WA26QETLO7q2L5sYINA1N/GGO66fh1a0cZCuWJJs6lqUIoAUAOzbf7kzA9/miRn3
         0iGyRZh8tg8B1PaLKpHdtFR5UAya9UA6UPdfRFR1g6zeahJDTnEAhCNvnw9zji1Q9GJn
         VUK3R1jkBpVLCNNzSzBfdDaMoFZ2K+BIVTfhbaUWF+meEyoIpHC6VZIpldnEd/dhzu7l
         1Rpw==
X-Gm-Message-State: ANhLgQ1z7Hf3OfHG67d6HvmAo0h4Gu1VUFZtNFSVJA3zWUl4J0VvClF/
        rIrwUZv1tptz7PrPOY54NbNIkSJQaL6hZYKgNJ97VcdUlgQ=
X-Google-Smtp-Source: ADFU+vscrzeh0HZ8Xsmgb8y7RdjhEQ38CYXQnm+4bw2bkwwkKqV8qCwiP3mwv5aMWlSG9MkFix6hAs2Z+UCEta+SWK4=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr4599093edb.165.1585419815840;
 Sat, 28 Mar 2020 11:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <202003281643.02SGhPmY017434@sdf.org>
In-Reply-To: <202003281643.02SGhPmY017434@sdf.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 28 Mar 2020 11:23:24 -0700
Message-ID: <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 46/50] mm/shuffle.c: use get_random_max()
To:     George Spelvin <lkml@sdf.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 9:43 AM George Spelvin <lkml@sdf.org> wrote:
>
> Now that we have it, this is an example of where it helps.

I didn't get copied on the cover and this series does not seem to be
threaded in a way lore can find the cover either:
https://lore.kernel.org/r/202003281643.02SGhPmY017434@sdf.org

Mind including a short blurb about what it is and why it helps in the changelog?

>
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/shuffle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index b3fe97fd66541..e0ed247f8d907 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -135,7 +135,7 @@ void __meminit __shuffle_zone(struct zone *z)
>                          * in the zone.
>                          */
>                         j = z->zone_start_pfn +
> -                               ALIGN_DOWN(get_random_long() % z->spanned_pages,
> +                               ALIGN_DOWN(get_random_max(z->spanned_pages),
>                                                 order_pages);
>                         page_j = shuffle_valid_page(j, order);
>                         if (page_j && page_j != page_i)
> --
> 2.26.0
>
