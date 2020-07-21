Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9574208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5h641+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgGUDXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:23:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB3C061794;
        Mon, 20 Jul 2020 20:23:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o3so15149633ilo.12;
        Mon, 20 Jul 2020 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vy/t34kGa+AL0KVS5scjg7XYMyIm/b9u03KSFMBJSXw=;
        b=e5h641+MTFpVytkoYyEBT4W0KfC6V02/Z7w3+CKkJAly6R0JfqLQaCO0C7qq3km8Wb
         WFDVdCc+hEhqY+nS4HFLOvKt9R07H5PBFgzLDAelPS00zA9xMjj/Ih3pNbOYAbJrIhPC
         Gck4m85PrjCgtsTuHQJGL2piphuPT+S7wSsvo8nkiY+ut+DqE2TREJXRiAPn//n8NWEk
         2ZjDXsGBtILiF7AcQoM9O+jhNE6e6dNiHDu9rpIxyw2sm2l/JyKflj0skGlvEuTsINQF
         Jt6rXMIQL3mPqZaXXRWmWnAASVK++i/79at+NWr9oDK1QgLvnlc6R5qYVw+XjfbnJeTh
         wL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vy/t34kGa+AL0KVS5scjg7XYMyIm/b9u03KSFMBJSXw=;
        b=dIB4ppbtPAiaZEanSAMa7dpZ0NAou46pxjj5671zSg9in/1ilO3ImtpjAn/+oqF4fo
         RTCB2/46x7Z7qVQ/iFh33WIGYpGS89LKyNytA72S26bwNcdgG4hl/PMs4uQmLFBVirj4
         vUPjT930oRYM3J1GDya7WlLO5tXq0AkmGe4Nm8FND69RZPdtrBh5Acf15r1ucgVXuBNc
         Zobvu58609Cp6ESpP9Rq3erASFZcStzzIYLP7PJIB/RgvlO8dvUU+9zI/I9voRIaxEjn
         ebZVVWU7Fy0hTEhn1shxKoFmjk1DRQPBRfLryXkmd9Stv3ubwSRVp/CvASu/kz0KpaVJ
         GjAw==
X-Gm-Message-State: AOAM533d5UpNxyG3PQJgZKRyXrqbL6Av7K+cTIIm82kI7yykNCVqOZLh
        yKRGcn89hBVBpvvznO/aphNdy2u9BG4SjvL+bAs=
X-Google-Smtp-Source: ABdhPJzlqOcqKyey5YvPQM2wcN7pJpIFGRanN3KGGvW5kGMiePQ+aEHo+MR6gDJJj7Vv1ysgkHw3v0zs7bA044vZaeU=
X-Received: by 2002:a05:6e02:80b:: with SMTP id u11mr27228504ilm.178.1595301800016;
 Mon, 20 Jul 2020 20:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200709020629.91671-1-justin.he@arm.com> <20200709020629.91671-4-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-4-justin.he@arm.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 21 Jul 2020 05:23:08 +0200
Message-ID: <CAM9Jb+i7wMqXWXdnaeXmRQN8w8305A5WRKsnE9PAkxgUs2c++Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] sh/mm: use default dummy memory_add_physaddr_to_nid()
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-nvdimm@lists.01.org,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> After making default memory_add_physaddr_to_nid in mm/memory_hotplug,
> there is no use to define a similar one in arch specific directory.
>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/sh/mm/init.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index a70ba0fdd0b3..f75932ba87a6 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -430,15 +430,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         return ret;
>  }
>
> -#ifdef CONFIG_NUMA
> -int memory_add_physaddr_to_nid(u64 addr)
> -{
> -       /* Node 0 for now.. */
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> -#endif
> -
>  void arch_remove_memory(int nid, u64 start, u64 size,
>                         struct vmem_altmap *altmap)
>  {

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
