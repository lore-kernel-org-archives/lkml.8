Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2712068F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="N2Lx7bIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgHDD3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgHDD3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:29:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED618C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 20:29:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so35986465wrl.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmKKzdmsH+1VZAyS/bcCQ07sLy0DbSnTthJzq4HEE1c=;
        b=N2Lx7bIpVS3FuJKK0Z0ef/alEh+npxvLnHgcnIQmEEHSV+bOdivorBtrAUOaIjaQuM
         /eLnzoiN2RHn5o1vELmITihEHOO1s7vfh3oLze4o01+BvJh61NtK3lY3JGcrm11VHvA3
         XWw5mSxLNCwU1VcD8M1Bx+/ZrsYDZFBVUeM/1pDg7SJ9T4sWiiy5WrOyAcymIlTB+GHE
         5mcsx6xQqdsgGXxYVoIHdGjoPjIjjlKHmYw2RNFeIbGMXEncp3CtPnFNqwM4BeujMFkn
         0BThrq0Ha2ymRqGfYsvbBo8ibUwzjiePhV6KYPqfqV+MXGsBlerMbU2HLYvKZwXW00Au
         OCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmKKzdmsH+1VZAyS/bcCQ07sLy0DbSnTthJzq4HEE1c=;
        b=tWxqLvp/7UCeAm7DVXd2w/xffhPHICyGQU0Bgwjd+NJywZQge5i3dKsUuXJNlC7FFV
         lY2CLJnfclPNoIHZNz2piAWJLXMpvdZf8IJ+PryOfc5ui7ZagxQVzpNrzo4+57pAj5Gi
         Tn8wkWGFpdjaeMxoErKQqJXocihG6SnkoJBHaQ9d4r1tEtCGkZ70mtmqzBgTF/mCFZQY
         R2/5NMZ9mHK+s7vwOcjSN8Nr5LcW5n2MoOc78fUgX1dw3oAmzTte48oMpyqKKGFcbUzI
         lu6xa+d5mOdctctkq319Aqg0OtWE3yclPuyF+r0prx3J6ZwNJsGBVSZiFb2iAP1mhLT2
         /c6A==
X-Gm-Message-State: AOAM530es/oJSjsnenVQSZufWoMs1X6O3s8+QXWYUyqMBeTY2CEzZW2o
        kA+ApaMJ3/fTADkImQ+z+P3jlfdAMQLZwxXLz5Hpm3Mi
X-Google-Smtp-Source: ABdhPJyFa+mc48R5ry3vm9Zy21Kc2uGTPuKBXSUBVyTN7VIdD1/fesiIXrwx4JlGChud9jFDvW10FSsVJaAlhWGNI1s=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr18913370wrr.390.1596511784511;
 Mon, 03 Aug 2020 20:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200804030205.91656-1-greentime.hu@sifive.com>
In-Reply-To: <20200804030205.91656-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 4 Aug 2020 08:59:32 +0530
Message-ID: <CAAhSdy1QbMjZxxu+wSBYr3+3oaM2Qg=_Uwj8dfQidi=ck6PV_Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add sfence.vma after page table changed
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, syven.wang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 8:32 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> This patch addes local_flush_tlb_page(addr) to use sfence.vma after the

s/addes/adds

> page table changed. That address will be used immediately in
> memset(nextp, 0, PAGE_SIZE) to cause this issue so we should add the
> sfence.vma before we use it.

Alternate version of this commit description can be:

Invalidate local TLB after both set_pet() and clear_pte() because the
address can be used immediately after page table change.

>
> Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")
>
> Reported-by: Syven Wang <syven.wang@sifive.com>
> Signed-off-by: Syven Wang <syven.wang@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/mm/init.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f4adb3684f3d..29b0f7108054 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>
>         ptep = &fixmap_pte[pte_index(addr)];
>
> -       if (pgprot_val(prot)) {
> +       if (pgprot_val(prot))
>                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
> -       } else {
> +       else
>                 pte_clear(&init_mm, addr, ptep);
> -               local_flush_tlb_page(addr);
> -       }
> +       local_flush_tlb_page(addr);
>  }
>
>  static pte_t *__init get_pte_virt(phys_addr_t pa)
> --
> 2.28.0
>

Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
