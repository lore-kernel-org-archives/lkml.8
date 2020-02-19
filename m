Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC52DC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A704824655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSd7Al7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSDWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:22:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43103 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgBSDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:22:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so27348611edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 19:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOwsfCxIuEAE5EfWzjTqJ5OG19WWGU0wtmPirueEhaU=;
        b=eSd7Al7OY+mz5Or3VCm94r/VJDi1/bdRrhb9Ior3AMIH15vekk9WuEMIusd4zqBes5
         Ntpj53PgI/pKghFIQWbSVCEz2D+DuJSIFFryKUtFft133BNTw3XCqOJs2vcM24tXZC6p
         qV5O/UsBAxe0uidFndVqxdqOdu6aOn2zCHOciFcQT1ZlT+gj4X0qe+wlR0IVIEBkQBkW
         kKDGqcTRPcjqA/PmZs18SGduB1UMRGZmw4CGAAuRQDvv1kPAWyUD0bsbSE/yYGsxcS4q
         vVHspuASnEQYPUC1OrN0gCMRSmkAKy0yqd6u9L1ZQ3FL6O57Na+9hDemklOQWRDXkICx
         N0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOwsfCxIuEAE5EfWzjTqJ5OG19WWGU0wtmPirueEhaU=;
        b=klffs4+3TZIB65JDmfLo+NQBLhGxLGLFlMOC3IL1oOR4OAVR+/4QtwAGcw/+yIa8Hp
         992M2Ey22swIF/wsGNrpg8CCavEGDpX8/B0CyGlLYh6fZejMxYcq/Dujxk6PuIfqMmYP
         TsUKeEYqbGZf9Bv2yCNEdJ1uUSUOcOQPjns9ToXepiHojKzIhNFSkkfr3aGyjt+lHIEn
         veMTdoD+/pcITzwLX4U8meA/YUiiU+AV6JytNxHQ2zyv2I07vdWO8q4jRRYuyfVDnh+c
         z6QxiXhDXeOySQvLkV6R6SQRmeml+kvuyryM82yNZrJ2qcjR0GAy1btpYZA68yvvsG7N
         ZmvQ==
X-Gm-Message-State: APjAAAUZ40fB8HC9MEHZV+XWOyO+J+4jXlNrngL2P5/p6Qjpnv5CIzZa
        nBXaR6bYBAmBObZnxxrE9Q1eUE24ppLv1g0kGjA=
X-Google-Smtp-Source: APXvYqzwIb1FUBaecbUsJa4vYm6bhf8m9qyf9cN1RF7nJCD/1BOnd7Jb98IDNKDk4iocVSXjGHIlPjoZ9TBqh9WZA1A=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr21926223edb.200.1582082553048;
 Tue, 18 Feb 2020 19:22:33 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com> <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 18 Feb 2020 19:22:16 -0800
Message-ID: <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:29 PM David Rientjes <rientjes@google.com> wrote:
>
> The thp_fault_alloc and thp_fault_fallback vmstats are incremented when a
> hugepage is successfully or unsuccessfully allocated, respectively, during
> a page fault for anonymous memory.
>
> Extend this to shmem as well.  Note that care is taken to increment
> thp_fault_alloc only when the fault succeeds; this is the same behavior as
> anonymous thp.
>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/shmem.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
>         return page;
>  }
>
> -static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> -               struct inode *inode,
> -               pgoff_t index, bool huge)
> +static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
> +               pgoff_t index, bool fault, bool huge)
>  {
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct page *page;
> @@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
>         if (!shmem_inode_acct_block(inode, nr))
>                 goto failed;
>
> -       if (huge)
> +       if (huge) {
>                 page = shmem_alloc_hugepage(gfp, info, index);
> -       else
> +               if (!page && fault)
> +                       count_vm_event(THP_FAULT_FALLBACK);
> +       } else
>                 page = shmem_alloc_page(gfp, info, index);
>         if (page) {
>                 __SetPageLocked(page);
> @@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>         }
>
>  alloc_huge:
> -       page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> +       page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
>         if (IS_ERR(page)) {
>  alloc_nohuge:
> -               page = shmem_alloc_and_acct_page(gfp, inode,
> -                                                index, false);
> +               page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
>         }
>         if (IS_ERR(page)) {
>                 int retry = 5;
> @@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>
>         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
>                                             PageTransHuge(page));
> -       if (error)
> +       if (error) {
> +               if (vmf && PageTransHuge(page))
> +                       count_vm_event(THP_FAULT_FALLBACK);
>                 goto unacct;
> +       }
>         error = shmem_add_to_page_cache(page, mapping, hindex,
>                                         NULL, gfp & GFP_RECLAIM_MASK);
>         if (error) {
> @@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>         mem_cgroup_commit_charge(page, memcg, false,
>                                  PageTransHuge(page));
>         lru_cache_add_anon(page);
> +       if (vmf && PageTransHuge(page))
> +               count_vm_event(THP_FAULT_ALLOC);

I think shmem THP alloc is accounted to THP_FILE_ALLOC. And it has
been accounted by shmem_add_to_page_cache(). So, it sounds like a
double count.

>
>         spin_lock_irq(&info->lock);
>         info->alloced += compound_nr(page);
>
