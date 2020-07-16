Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8447C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9A52071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V83W9JPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGPHXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgGPHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:23:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so5956577lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMfq9IrRotghhONHBzEQ7VPqPzHVuJEy3x1AP8iTmRU=;
        b=V83W9JPe/G9CHrgopNuB/d5bRkNFKdOlMAmC5tThj3DS+uDWgV0HDsLkoheHvsSKyp
         Sr+JASOLA/ukU/xXADuoY10L3qNc9wTmpsHB7zNrfRaGD7MtVG/axzdCKXQXdspuw9Ra
         De74rZ7R6EgIzv6v5cZ/l8IKdlYrdqUVTQVgLxXJ6wXXo/b8TXdJyKM4vT8WoapzcIHN
         Lavov63WdNyrISXKE/gaOMEEjlZwKAA9Z94ng1lWPGpxBeiFXX9bejYOHGzc88nbwVlb
         Fl6PxUPp68mVMfIvVRmgFHN0/5NgY4TCHtOb/GxPXIHwXsGzAwnsiikCortLcauml4jv
         LFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMfq9IrRotghhONHBzEQ7VPqPzHVuJEy3x1AP8iTmRU=;
        b=XqHow8VzY6rZEHvMQpczbIWbcNi6EGPKlXNxgs32jojzF4k2MkyWrmK8pnAHTdPa7C
         Xj7zuC9TE4h4vwlJe9wvgLm1y8sIhlbWdCrC5/nl5OeoO8vh/jD5daUHg6bBe0n0GRP7
         2JYfhtzbgsrt/fFlplSakk6TUI+7jasxUAz8aunFMjQtWeipGM/LtnUAbsJgauII01LA
         s5sm75aJ7rSvRFJ8bgbGiics9sdhqdNeolazfapEQgix8zzUJZtfzvQAnDjtoSPaJ6v9
         1YGR9Skfka0bur/9MOEtHEclhkmGoCutOtjtPK275dCxFPEK5h/k0tu0hIPtsbCIBab6
         74BQ==
X-Gm-Message-State: AOAM530Z22JHNpo1crLivqIYU9E925TutowgysgiITxqJ63PVf/11AqJ
        EL4DOYbn/YdFVpOGdl2+gso+EhHRgCKj1r++WF92ZA==
X-Google-Smtp-Source: ABdhPJzGsDMZLoStikfh66vE054+v0Q3o3xaW/g4KhQ/UoV69B8PFvAniTkP+YdnV+4mot2nvsg5xP/izSv6raHPgkU=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr1331358ljg.431.1594884215665;
 Thu, 16 Jul 2020 00:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
 <20200715222228.jf2pv5u2wyhtc5o5@box> <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
 <CAHk-=wh3jD4dwXWWFors9OnYp-YCzYN2bCGs9HDxrtZ=TiFyDQ@mail.gmail.com>
 <CAHk-=wjw2yuQjP1rqB=ocr9W3=ak+6h4XygoFTAgM5meiM1Q0A@mail.gmail.com> <CA+G9fYsRcL1mcFhH47ek3YdGcK6sDSa+Gb0UoJzWkMcTsfxWdQ@mail.gmail.com>
In-Reply-To: <CA+G9fYsRcL1mcFhH47ek3YdGcK6sDSa+Gb0UoJzWkMcTsfxWdQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 12:53:23 +0530
Message-ID: <CA+G9fYuO+ZHDbWR7fqfFoFj2HcSSmDYSBnQBm2FmY4Sj19Rg+g@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 at 12:07, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 16 Jul 2020 at 04:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Jul 15, 2020 at 4:04 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It *might* be as simple as this incremental thing on top
> >
> > No, it needs to be
> >
> > +       if (*old_addr + *len < old->vm_end)
> > +               return;
> >
> > in try_to_align_end(), of course.
> >
> > Now I'm going for a lie-down, because this cross-eyed thing isn't working.
>
>
> Just want to double check.
> Here is the diff after those two patches applied. Please correct me if
> it is wrong.
> This patch applied on top of Linus mainline master branch.
> I am starting my test cycles.

Sorry this patch (the below pasted ) did not solve the reported problem.
I still notice warning

[  760.004318] ------------[ cut here ]------------
[  760.009039] WARNING: CPU: 3 PID: 461 at mm/mremap.c:230
move_page_tables+0x818/0x840
[  760.016848] Modules linked in: x86_pkg_temp_thermal fuse
[  760.022220] CPU: 3 PID: 461 Comm: true Not tainted 5.8.0-rc5 #1
[  760.028198] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[  760.035651] EIP: move_page_tables+0x818/0x840

ref:
https://lkft.validation.linaro.org/scheduler/job/1574277#L12221

>
> ---
>  mm/mremap.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 6b153dc05fe4..4961c18d2008 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -254,6 +254,77 @@ static bool move_normal_pmd(struct vm_area_struct
> *vma, unsigned long old_addr,
>
>   return true;
>  }
> +
> +#define ADDR_BEFORE_PREV(addr, vma) \
> + ((vma)->vm_prev && (addr) < (vma)->vm_prev->vm_end)
> +
> +static inline void try_to_align_start(unsigned long *len,
> + struct vm_area_struct *old, unsigned long *old_addr,
> + struct vm_area_struct *new, unsigned long *new_addr)
> +{
> + if (*old_addr > old->vm_start)
> + return;
> +
> + if (ADDR_BEFORE_PREV(*old_addr & PMD_MASK, old))
> + return;
> +
> + if (ADDR_BEFORE_PREV(*new_addr & PMD_MASK, new))
> + return;
> +
> + /* Bingo! */
> + *len += *new_addr & ~PMD_MASK;
> + *old_addr &= PMD_MASK;
> + *new_addr &= PMD_MASK;
> +}
> +
> +/*
> + * When aligning the end, avoid ALIGN() (which can overflow
> + * if the user space is the full address space, and overshoot
> + * the vm_start of the next vma).
> + *
> + * Align the upper limit down instead, and check that it's not
> + * in the same PMD as the end.
> + */
> +#define ADDR_AFTER_NEXT(addr, vma) \
> + ((vma)->vm_next && (addr) > (PMD_MASK & (vma)->vm_next->vm_start))
> +
> +static inline void try_to_align_end(unsigned long *len,
> + struct vm_area_struct *old, unsigned long *old_addr,
> + struct vm_area_struct *new, unsigned long *new_addr)
> +{
> + if (*old_addr < old->vm_end)
> + return;
> +
> + if (ADDR_AFTER_NEXT(*old_addr + *len, old))
> + return;
> +
> + if (ADDR_AFTER_NEXT(*new_addr + *len, new))
> + return;
> +
> + /* Mutual alignment means this is same for new/old addr */
> + *len = ALIGN(*new_addr + *len, PMD_SIZE) - *new_addr;
> +}
> +
> +/*
> + * The PMD move case is much more efficient, so if we have the
> + * mutually aligned case, try to see if we can extend the
> + * beginning and end to be aligned too.
> + *
> + * The pointer dereferences look bad, but with inlining, the
> + * compiler will sort it out.
> + */
> +static inline void try_to_align_range(unsigned long *len,
> + struct vm_area_struct *old, unsigned long *old_addr,
> + struct vm_area_struct *new, unsigned long *new_addr)
> +{
> + if ((*old_addr ^ *new_addr) & ~PMD_MASK)
> + return;
> +
> + try_to_align_start(len, old, old_addr, new, new_addr);
> + try_to_align_end(len, old, old_addr, new, new_addr);
> +}
> +#else
> +#define try_to_align_range(len,old,olda,new,newa) do { } while(0);
>  #endif
>
>  unsigned long move_page_tables(struct vm_area_struct *vma,
> @@ -272,6 +343,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>   old_addr, old_end);
>   mmu_notifier_invalidate_range_start(&range);
>
> + try_to_align_range(&len, vma, &old_addr, new_vma, &new_addr);
> +
>   for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>   cond_resched();
>   next = (old_addr + PMD_SIZE) & PMD_MASK;
> --
> 2.27.0
>
> >
> >               Linus
>
> - Naresh
