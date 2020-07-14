Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3F6221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvWTr1G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGNL1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:27:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4EEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:27:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so22030909ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRuLFKvQDaw1sZL3IQ7c0WjQdAQsHCg8KMZ60fQDX3s=;
        b=IvWTr1G8MbRGNvmmF3GY36Q3iShIoAcmF57XjtqSMlX+UjsveepMcNyeYiicFU+3E+
         bOSSCqYtoFqjo48izwzZCRfWncfuq8FFX4ZqMpjYPlN0DXZQAn/uvQY+8tWFxBm4nQam
         biWrkcFebp86rk2x+UCbWrFkPpCtZl4Om/XQnX76mubHorOPHg8ALbs3ZdV2Tqtt4CDU
         xB74Epl7L2Ddpc9UFfC+3qdjiFaxKde5OlQzlkOvvSfKv62WKARQGEf135nJb1Pg2Mo1
         23YiVG67fLpJQ5Q/2V5JmibKAzCtpBzjkEqkCL73RuAwhHw6ElJUCyx+wzJlEMs++D6D
         jxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRuLFKvQDaw1sZL3IQ7c0WjQdAQsHCg8KMZ60fQDX3s=;
        b=OLgc9FjzkkVytKeKCWYGIbj3TEKuUFQWA5Z1LgnRVW6/WPgwJJDM7BEljH5wUr+4WB
         VQfLON3EoRuykD+rhBlw60ZH3NNyQplVXZ+6+jNY13YggbKyKH/61KPMV1/G++9GB3B1
         D5oEWNGxIGA930/uLXmqTPBBdR6J4NY6CfrID7Q+ONIDGe8IViut7NQiLAR5P4hVk2BQ
         vr2cpGvZGo11V5QOebrbUmFW89ZuA9OavKMpze4SzGKjM2T0pK+8qHbytRgCeRkSl8j8
         5H9cE4tlsyxbUFzwIIGeP4sdy/MPY+RkHVxpLqzsJPy88RH4Mf4nsgA0eyGAXBga3LtR
         DCig==
X-Gm-Message-State: AOAM532u4vt6bUTnMYlBp41AT2tu3vjWa2uc+vsI+6Q51t5k4w59YkPB
        iSPQRnj8gVGu3Dy8MqbcAPCsT7IobxYoRyUSpHh0sw==
X-Google-Smtp-Source: ABdhPJy5qZDrujqexb2KWuHgK/pg2E8r3sHYRhykgzZdB+4AhkS8Ejrdf1ttrfztmNGMOeYDytwHysJ8zfNi+ujHmGY=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr2090256ljg.431.1594726058377;
 Tue, 14 Jul 2020 04:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com> <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
 <20200714073306.kq4zikkphqje2yzb@box>
In-Reply-To: <20200714073306.kq4zikkphqje2yzb@box>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Jul 2020 16:57:26 +0530
Message-ID: <CA+G9fYsqdHR=ty2hKj44zQ=SrHuWwu-eN0odp72AGCiNkFVUog@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 at 13:03, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Jul 12, 2020 at 03:58:06PM -0700, Linus Torvalds wrote:
> > Anybody else have any opinions?
>
> Maybe we just shouldn't allow move_normal_pmd() if ranges overlap?
>
> Other option: pass 'overlaps' down to move_normal_pmd() and only WARN() if
> see establised PMD without overlaps being true.
>
> Untested patch:

This patch applied on top of Linus mainline tree and tested on i386.
The reported warning did not happen while testing LTP mm [1].


>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5dd572d57ca9..e33fcee541fe 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>         unsigned long extent, next, old_end;
>         struct mmu_notifier_range range;
>         pmd_t *old_pmd, *new_pmd;
> +       bool overlaps;
> +
> +       /*
> +        * shift_arg_pages() can call move_page_tables() on overlapping ranges.
> +        * In this case we cannot use move_normal_pmd() because destination pmd
> +        * might be established page table: move_ptes() doesn't free page
> +        * table.
> +        */
> +       if (old_addr > new_addr)
> +               overlaps = old_addr - new_addr < len;
> +       else
> +               overlaps = new_addr - old_addr < len;
>
>         old_end = old_addr + len;
>         flush_cache_range(vma, old_addr, old_end);
> @@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>                         split_huge_pmd(vma, old_pmd, old_addr);
>                         if (pmd_trans_unstable(old_pmd))
>                                 continue;
> -               } else if (extent == PMD_SIZE) {
> +               } else if (!overlaps && extent == PMD_SIZE) {
>  #ifdef CONFIG_HAVE_MOVE_PMD
>                         /*
>                          * If the extent is PMD-sized, try to speed the move by
> --
>  Kirill A. Shutemov

ref:
https://lkft.validation.linaro.org/scheduler/job/1561734#L1598

- Naresh
