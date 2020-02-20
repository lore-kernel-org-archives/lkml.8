Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EDDC11D81
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C036B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="MruqT/lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgBTGM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:12:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54073 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBTGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:12:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so684255wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LXBy0Uexw62kag86kt07J2cNSFL92+mtSCX46spkX8=;
        b=MruqT/lLwSAY/zZMkWPYyZnUdokPOkKShNCtKtMf/VykASByq7CcqXkeJtyAFtaE9d
         mO5avU+Ye1J1rSsVQYiZYzVTh2UcMw4oSNd88QTH2ZnWcqW0y7X903SrT2LBN6Ueo7Ak
         O5/k8vc51viBHlk9Pst4jGvSCHEng4S2zFufuqaWQfdgxgF9RbTM9i1kKH49Pq3Jd9rD
         axORqzyd3aaOYT00FJIWvjhDCfrUDCcjo5qiuTg6N764cg04CVA5hMMv2EwNCak1jiYg
         rYWGXwLF4qexYdwemsf2asYFk6VP4ARRR5pqJKviz3lLKi4EhKWXt2ktUm+WEMyDy1sq
         +7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LXBy0Uexw62kag86kt07J2cNSFL92+mtSCX46spkX8=;
        b=FGvoXFgWcohuLZ3mapnwnsp4BK2MsDvVWU+RLkmcOGHycs+/EQK+HPzDJrscpjmhgc
         ijOPi5yj8ZnPdgTUV+NHXOXs1ofVPu78yjcxbo9vQtIMamrfT2j9CyvUiDK+87upK2pI
         my9J8fFS1Mjs8Wnkegnr4h5xsLwv2vCJjDVSHaTS2NZnslHo3cS1/aQOs1WZ/DhUhf5w
         7ij61WemRh20lU06vofqSMitVc041TyKJLh8ksPKQctQW3l1bNyFqAF+p7Y6QgvmITnv
         tfkwxXVyGgVz+MTSp8O3ZrlDRHM/Wn+jDfSaPIsLfH1lJM6p0SbAUEjzHzabEV4C/CCp
         mgBw==
X-Gm-Message-State: APjAAAXtIYBSHW1iwC4uWHbFc3sNKKbwWsx2Jx4P3jpmGwwueMY8hO8B
        OmFL6KP3MacjSOeC93giQyNwj0LcVLxmOyPRJ0Li4A==
X-Google-Smtp-Source: APXvYqzeQceJiDvtYYc92q/YMWZtyrFqJ1ahaVG9IrTJOyiVw37zCRGbeNeYXxtFFERU8m8iCnxSB/q+gcv23p72kzA=
X-Received: by 2002:a1c:1984:: with SMTP id 126mr2342646wmz.78.1582179175373;
 Wed, 19 Feb 2020 22:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20200220061023.958-1-alex@ghiti.fr>
In-Reply-To: <20200220061023.958-1-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 20 Feb 2020 11:42:44 +0530
Message-ID: <CAAhSdy1=xwzcJuKtyyv_d1fL6=v2kB_rq2F06081Bc68WGXH_A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Use p*d_leaf macros to define p*d_huge
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:41 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> The newly introduced p*d_leaf macros allow to check if an entry of the
> page table map to a physical page instead of the next level. To avoid
> duplication of code, use those macros to determine if a page table entry
> points to a hugepage.
>
> Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/hugetlbpage.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 0d4747e9d5b5..a6189ed36c5f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -4,14 +4,12 @@
>
>  int pud_huge(pud_t pud)
>  {
> -       return pud_present(pud) &&
> -               (pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +       return pud_leaf(pud);
>  }
>
>  int pmd_huge(pmd_t pmd)
>  {
> -       return pmd_present(pmd) &&
> -               (pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
> +       return pmd_leaf(pmd);
>  }
>
>  static __init int setup_hugepagesz(char *opt)
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
