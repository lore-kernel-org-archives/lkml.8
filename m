Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E6C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E35C21473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587329442;
	bh=jvFDAug2GFFX4yN2JsSrhlUT7KN9MeiQvzM1VGjlj/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1rCBlaAVfPD1eT3zQrvJ7O5gtK61wDqf0U3rMxtaQGETZsHcr+CxAG0No52noUuo4
	 vSI5tiXcxUwokMcBGSqJhC3oulfJEwWvgO4MXTRKr06AJ6Po7CGIqpWaSxROIH/r4h
	 alRHJHMR7yOvOXD4pc5LEiuO/5uJEOoZ6lrEbU2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDSUul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:50:41 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24661 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:50:40 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03JKoAc2028808;
        Mon, 20 Apr 2020 05:50:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03JKoAc2028808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587329411;
        bh=b4Ak/xeyfOjeKfK1kzKYBYqfHPdfw20wYLgyLscinyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=veXDidF6JjssluTfqXjUwFZskuHxFWjXJ5XI8XlVxaGx8/+pWk7jjSukVGsAe0wVH
         IErWttooQsuYag7wgKv/tj2b6M4Le3knorzWgdAuHrxkjkY7Zr5JpHEQJJshyY3FwD
         KXthGt+38WqrfyyT7RdVUyShtsZQXTrKsKhLN1i7IVSc5rNO5ZtWxrtbL9HMx7uAds
         82Ex/Gl+brXDj/7UcSwfJ/F/P8Sq8yINAeZEv80cFx9lhk5eg3zISMh5deIqzUgpqQ
         0Kk5bIM/nkgS9bR9dBEGGVH3A0bsAkJSaBBUx3+jwwkLuatA9RqAwZW//AJH+f1YwF
         e5Vbx4LbQ1Clw==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id h30so4282961vsr.5;
        Sun, 19 Apr 2020 13:50:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuaKXP+xa7gBCVC4yaXSR5vTFLpFkx/3lZO2FnF2oLRR62pzb5LI
        hoDfdVwE35pFwFe+DFxEErUMigIoN2wvYRN27go=
X-Google-Smtp-Source: APiQypJndbmDUDapZ/+4dHGPMoEz4KcYAlKAXHkq6s8kl44aaHQr0IaIqZtwJ0YFLUjUWLALayZS/2ihkGm3UGtUt+M=
X-Received: by 2002:a67:fa11:: with SMTP id i17mr9546654vsq.155.1587329409691;
 Sun, 19 Apr 2020 13:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200413014743.16353-1-masahiroy@kernel.org> <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
In-Reply-To: <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Apr 2020 05:49:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnovOtP99fuxcoTknj1g1Uoa8U4YopRQfdFYjC998B=A@mail.gmail.com>
Message-ID: <CAK7LNASnovOtP99fuxcoTknj1g1Uoa8U4YopRQfdFYjC998B=A@mail.gmail.com>
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

On Mon, Apr 20, 2020 at 5:46 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Linus,
>
> On Mon, Apr 13, 2020 at 10:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The closing parenthesis is missing.
> >
> > Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
>
> Will you pick up this directly ?
> The SuperH subsystem is inactive these days.
>
> https://lore.kernel.org/patchwork/patch/1223032/
>
>
> This is easy to review, and ARCH=sh build is apparently broken.
>
> Thanks.


Sorry, I take it back.

Guenter's one is already queued up in linux-next.

Somebody will fix it eventually.




-- 
Best Regards
Masahiro Yamada
