Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C507920717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPRuwLr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgGVRza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVRz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:55:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F85C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:55:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so3165587eja.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6guxX6mZtix0UN5UXZjDkdDZ88VY9pbVBPWoe8hGYQ=;
        b=jPRuwLr32SMDzzTNsRbghRPMenaWVD+B/SVzZF1Uc1Llsq/ZIivz/T2o5NrbEYVBeE
         80cewu8Dm2oDPeU2T5l8KbRX5uCRRPNXKGZe76hTgXrlYJ4elRmCeqOka6AyaKkp+a7s
         tnk/332zp8t1AETZ0FjTRzFOtOuc0geYlT+Ui0cQOsKgBbPK877a7fzOmuv04SvVY9Pu
         +blOv/fx0pZSJyb9xbRMaNxgo93g9vImKoXda8tZHsytWfDipNMj8tq3VHHssp6jgGAj
         GBl2XSguaL63ZfAPPVPBL2RhYT6Zk1UWJ/FvurSAG62Qi/1i4ReuK4AkuI7H4wYv56hZ
         YOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6guxX6mZtix0UN5UXZjDkdDZ88VY9pbVBPWoe8hGYQ=;
        b=RQCVvWOXTvshBTBK8xHa28pjMKrPOTJ6+/UgPnnaiVphWq+mFS8QPMWJrbYxaCeNbi
         3I5Vix8l9pCLheyY/YZBaazZ/Vcko2M5dmn5LOTiwp3onVGi4UraNiOWYe7xopTKBkSq
         eOPQQuRK1ZDXOuRStegdboIbw3wBOZKipFRcvSA9hD5CXD1BOnv0TNc1Rpbh+QKOgFxm
         6t/SjDKDvHb31LbOiryazYdqtrGKmyW03++N6C+hrUFRctJVy7y+Kscp0L03Myxjim/E
         PYVrjrZmY0BxodiTkbUstUkCtFhJQixFtsZviWwKSsurD0y/mdcFP11IucDO6FStPmZ0
         /IbQ==
X-Gm-Message-State: AOAM5318yaEOyjV5+c40s3K6926I61U3Lp7zQ7yuP/l/Zv3j4mwQ/rwm
        gR2rMEw4V5zK5/XnvoHNLSxlz/AsADmATGKPb3ofI+fX
X-Google-Smtp-Source: ABdhPJzQHgTVTJmsdSnHKQg+hRAmObEtDQPCwtFEQ4cKuewxqthv0FypycyZ0js2NzGr+FeBDN0d6aQyo6ktu11WGNc=
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr741268ejb.79.1595440528090;
 Wed, 22 Jul 2020 10:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200722121439.44328-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200722121439.44328-1-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Jul 2020 10:54:41 -0700
Message-ID: <CAHbLzkpYxxO=p82upzjRBW5eD0iwMRC=_9KheiRP54MHwaAGvg@mail.gmail.com>
Subject: Re: [PATCH] khugepaged: Fix null-pointer dereference due to race
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 5:14 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> khugepaged has to drop mmap lock several times while collapsing a page.
> The situation can change while the lock is dropped and we need to
> re-validate that the VMA is still in place and the PMD is still subject
> for collapse.
>
> But we miss one corner case: while collapsing an anonymous pages the VMA
> could be replaced with file VMA. If the file VMA doesn't have any
> private pages we get NULL pointer dereference:
>
>         general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
>         KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>         anon_vma_lock_write include/linux/rmap.h:120 [inline]
>         collapse_huge_page mm/khugepaged.c:1110 [inline]
>         khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
>         khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
>         khugepaged_do_scan mm/khugepaged.c:2193 [inline]
>         khugepaged+0x3bba/0x5a10 mm/khugepaged.c:2238
>
> The fix is to make sure that the VMA is anonymous in
> hugepage_vma_revalidate(). The helper is only used for collapsing
> anonymous pages.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Reported-by: syzbot+ed318e8b790ca72c5ad0@syzkaller.appspotmail.com

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

I think this is worth backporting to stable as well.

> ---
>  mm/khugepaged.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b043c40a21d4..700f5160f3e4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -958,6 +958,9 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>                 return SCAN_ADDRESS_RANGE;
>         if (!hugepage_vma_check(vma, vma->vm_flags))
>                 return SCAN_VMA_CHECK;
> +       /* Anon VMA expected */
> +       if (!vma->anon_vma || vma->vm_ops)
> +               return SCAN_VMA_CHECK;
>         return 0;
>  }
>
> --
> 2.26.2
>
>
