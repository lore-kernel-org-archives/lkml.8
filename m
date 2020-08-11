Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE1220782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597173883;
	bh=BqFHDivktO2v2DgcoUuslMhBd4l+xl/4G9mm7hCxrqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ivm1mwc85gZ9HLefwwD+SVMMrRxNh99ylLTF+e8roJRg698J1n8JgR+9P+HA87y+K
	 beVkR6Ybz3P/YCY2oFrw3Y7AZmRVZ6rM+A/Ww9Mr1rDbnKjIuM+2CYXsEzB4ye7kvA
	 Vb69yW3t888pGd8u3Agr0dRCkEBURkhL9smJ8iiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHKTYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:24:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:24:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so14772639ljn.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpN6xraykRS+TA74TQmy+03p34x/yy7UF3SXmuV0HYg=;
        b=IlP6ZNw/3TyULOWMmm7t1u6tgdDTVgMSnIjrGb6EkAd9JLYt9PMPIxqmlU/yRqicXx
         g3KFM4RWJY5FFrSPJ7FdsHTuMtA7c6A/+xD8eyvb54B0lJgR4si9iu7qlOyaeog9UO+R
         5P89PzEVoqEh6ADwIcGiRqr7j2tIaouCFYfBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpN6xraykRS+TA74TQmy+03p34x/yy7UF3SXmuV0HYg=;
        b=orfgIEErQNiGsLc7L4nAyjAO+XyeA+oVmH15wQDgrVBYgGShnF3XfKnRH1awwus7BQ
         k2+enRTPXPOrIbqSWiZ39O/ibEgzcZ5iOEUVuzJA+HSU4vpLVh3YkWO2ElPf9lcK724p
         VR5NyqTriAMEB6XysblQ/ZnMkArn2uXTmKExafe8yWvmakF73v09nz5g7D/gyK8hpAZ5
         vdMTVrNns0aEVL/rkJjZ/XD8c3J/sktYrs9ZgWePu6unU1flCpyBpmNBsaNCXjrnUzTd
         8Y/JUP7cXqpYMI3uPpAp1+utzAFd0sXuVg+fAljWh2TCTvCrm063KyyTgJM0OChlDwkn
         TzBA==
X-Gm-Message-State: AOAM532cGn1Cj5SK3Z30tlFN3lyq+qeSRyOPPR2ld8qJB1nrnXpsdeHQ
        O7yFcdJ8//qROOQm5SM/YH9h7opcbQw=
X-Google-Smtp-Source: ABdhPJzL5E0LVs7W2TvJqTf5KzEtdpU0jCQtrMxd6CcQ352tusvOXUbKQf1vIV/BMMbBCjKf5LRroQ==
X-Received: by 2002:a2e:8ecc:: with SMTP id e12mr3439775ljl.33.1597173878800;
        Tue, 11 Aug 2020 12:24:38 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n29sm12967024lfi.9.2020.08.11.12.24.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 12:24:37 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id m22so14746205ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 12:24:37 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3493591lju.102.1597173876835;
 Tue, 11 Aug 2020 12:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200811183950.10603-1-peterx@redhat.com>
In-Reply-To: <20200811183950.10603-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 12:24:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
Message-ID: <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:40 AM Peter Xu <peterx@redhat.com> wrote:
>
> index 206f52b36ffb..c88f773d03af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1296,7 +1296,17 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>         if (reuse_swap_page(page, NULL)) {
>                 pmd_t entry;
>                 entry = pmd_mkyoung(orig_pmd);
> -               entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +               entry = pmd_mkdirty(entry);
> +               if (pmd_uffd_wp(orig_pmd))
> +                       /*
> +                        * This can happen when an uffd-wp protected page is
> +                        * copied due to enfornced COW.  When it happens, we
> +                        * need to keep the uffd-wp bit even after COW, and
> +                        * make sure write bit is kept cleared.
> +                        */
> +                       entry = pmd_mkuffd_wp(pmd_wrprotect(entry));
> +               else
> +                       entry = maybe_pmd_mkwrite(entry, vma);
>                 if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
>                         update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>                 unlock_page(page);
> diff --git a/mm/memory.c b/mm/memory.c
> index c39a13b09602..b27b555a9df8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2706,7 +2706,17 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>                 flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>                 entry = mk_pte(new_page, vma->vm_page_prot);
>                 entry = pte_sw_mkyoung(entry);
> -               entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +               entry = pte_mkdirty(entry);
> +               if (pte_uffd_wp(vmf->orig_pte))
> +                       /*
> +                        * This can happen when an uffd-wp protected page is
> +                        * copied due to enfornced COW.  When it happens, we
> +                        * need to keep the uffd-wp bit even after COW, and
> +                        * make sure write bit is kept cleared.
> +                        */
> +                       entry = pte_mkuffd_wp(pte_wrprotect(entry));
> +               else
> +                       entry = maybe_mkwrite(entry, vma);
>                 /*
>                  * Clear the pte entry and flush it first, before updating the
>                  * pte with the new entry. This will avoid a race condition

I think this needs to be cleaned up some way. I realize it's not an
exact duplicate (pmd vs pte), but this code is illegible.

Maybe just making it a helper inline function (well, two separate
ones) with the comment above the function would resolve my "this is
very ugly" concerns.


> @@ -2900,7 +2910,13 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>
> -       if (userfaultfd_pte_wp(vma, *vmf->pte)) {
> +       /*
> +        * Userfaultfd-wp only cares about real writes.  E.g., enforced COW for
> +        * read does not count.  When that happens, we will do the COW with the
> +        * UFFD_WP bit inherited from the original PTE/PMD.
> +        */
> +       if ((vmf->flags & FAULT_FLAG_WRITE) &&
> +           userfaultfd_pte_wp(vma, *vmf->pte)) {
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 return handle_userfault(vmf, VM_UFFD_WP);
>         }
> @@ -4117,7 +4133,14 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
>  {
>         if (vma_is_anonymous(vmf->vma)) {
> -               if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
> +               /*
> +                * Userfaultfd-wp only cares about real writes.  E.g., enforced
> +                * COW for read does not count.  When that happens, we will do
> +                * the COW with the UFFD_WP bit inherited from the original
> +                * PTE/PMD.
> +                */
> +               if ((vmf->flags & FAULT_FLAG_WRITE) &&
> +                   userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
>                         return handle_userfault(vmf, VM_UFFD_WP);

Here again the comment placement could be improved. Particularly in
the do_wp_page() case, we have a big and somewhat complex function,
and this duplicated boiler-plate makes me worry.

Making it a helper function with a comment above would again I think
make it more legible.

And I think Jann is on the money wrt the follow_page_pte() issue.

I think you broke COW break there entirely.

That was one of the reasons I did just that "make it use FOLL_WRITE"
originally, because it meant that we couldn't have any subtle places
we'd missed.

Now I wonder if there's any other case of FOLL_WRITE that is missing.

            Linus
