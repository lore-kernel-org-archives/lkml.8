Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D89C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5687721473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587329263;
	bh=EaIYZ9qgxSDFW+EhUZwE7Dfg9yW7Ly4gKtaxL5SVMjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=geNK1PjWL+Lp5BF9wi+mZps/wGjKFYqY2MrjD6uwlmYpwGPYqT0PXxVWBrLN17K5Q
	 xf1FtJLkDt+uxR8te0mnNvxD+VAGG3MtqdOFd3my5eGBRBx07tSyOWFScjFvrEdfVb
	 vq5AzU6M/5hB9dx83df1vysbmsy9mgu9u7K81IlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDSUrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:47:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45558 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSUrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:47:41 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 03JKlGLJ016271;
        Mon, 20 Apr 2020 05:47:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 03JKlGLJ016271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587329236;
        bh=v+RpJEat+92QmCApx0BdvXg/nDfZseknYEaexTDhzWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=13J9QhAAQDvg8FwnlzLdWVrVTCTAArLV1TDAg+HSTSyKn0kJRIyO9CkuZDcD3yyas
         LTG93Z/kBWanCwAoBOaaZFbIc9qrgrcVL06bWYFxOBdSktp2xgslNTysJEbPK7pc+g
         u01aN6e8GBdVQjaI19U+T1/5hZYXiyPTEyRzc8llZwYcgGRRtS06MDLqQ9184P2kbb
         F8Sa1iaVtiBDNgaxNQk9DlzdOqVGiN7BGmjdBrJ1VeJLMoZYpHYDD6Xt8f9jNkSvyu
         0h/7y/jj0sbyDEf0r/yEybjwG9QXifHtHZgEIe9CWtXYrPyYX077q+Q5UAgehq8HBU
         tyoL5E1uHebdg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id 1so4703205vsl.9;
        Sun, 19 Apr 2020 13:47:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuZdOZUW3Dw5roGoThbMmopAZjL0VSHbkORNiVB/U/DAL1LHVvDP
        Brj3emEdd/2QCVbO2rBXKOsDuBJduuUttniZ7ig=
X-Google-Smtp-Source: APiQypLnkV8NEW6ECJyaibDDd6UeGGVrSJXtSG+kcqQBzv3RTSXH97CUdnFk2qk19Nsb49WfC1dia3PekfJ59Fq9NZ0=
X-Received: by 2002:a67:6e07:: with SMTP id j7mr3649531vsc.181.1587329235290;
 Sun, 19 Apr 2020 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200413014743.16353-1-masahiroy@kernel.org>
In-Reply-To: <20200413014743.16353-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Apr 2020 05:46:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
Message-ID: <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
Subject: Re: [PATCH] sh: fix build error in mm/init.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Apr 13, 2020 at 10:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The closing parenthesis is missing.
>
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



Will you pick up this directly ?
The SuperH subsystem is inactive these days.

https://lore.kernel.org/patchwork/patch/1223032/


This is easy to review, and ARCH=sh build is apparently broken.

Thanks.





> ---
>
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index b9de2d4fa57e..8d2a68aea1fc 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         int ret;
>
> -       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>                 return -EINVAL;
>
>         /* We only have ZONE_NORMAL, so this is easy.. */
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
