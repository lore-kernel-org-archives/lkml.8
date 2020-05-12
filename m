Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D581C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B8B206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgELOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:38:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38398 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbgELOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:38:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id m33so10671845otc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEOhIcgguE7QiBF5GVKHbgpK+UGFJ5iOOuHAZ/w1324=;
        b=KtX/ou7eRZ+ekDivy9kigcpQaHsqtwigz9p0oOIbVs4llls342tWu1GKGow4YnXuGW
         9nE8TiLYWOY0psnm6by/4rnN5JSE3t5ZGOPo15/t8NEj9hqSB+5HlWIzNisHk9+5RKLT
         /B9f83zwp0/LuAd/4FzJjqpLcHzEPLBO2Ffna6eQTA3xyZ7kByFoSsHlGnJEgWRz58EZ
         sc1azy1CkH8e48C/ovkkmaPUqW34wuYNYUasNS8wuJBTPDH4W9ALbJe+Ramr8uk3Z73G
         xu+PDeZvxY9slFszIG+3+f3+AxsZ9vGwrb3g/lFSYlYslOxVNUzh6zWG5WpIeGR5LATM
         YwBg==
X-Gm-Message-State: AGi0Pua7d/mNJGee5fFM5A5FQhDNJjhMSzQ752plgWDFXnKn8mrVvqWr
        R/ulOytmv4GGPGlZsNRj6gpORIDa7Fbp+JpqwSU=
X-Google-Smtp-Source: APiQypJzwnULcupZhJ1hAK9PIxOmvUr3iNrQX67MIeBrouwfs6dTnTLKqRJrFgv8BW1Kx/8XD3O1Fy0luMGtioKgTOo=
X-Received: by 2002:a9d:564:: with SMTP id 91mr17018452otw.250.1589294310970;
 Tue, 12 May 2020 07:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200512124238.28792-1-geert+renesas@glider.be> <20200512141200.GD3021@willie-the-truck>
In-Reply-To: <20200512141200.GD3021@willie-the-truck>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 May 2020 16:38:19 +0200
Message-ID: <CAMuHMdXM5GGXvxEemmLtcTU14nKgKVmO_yON+7+pLnUv2oExtQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: cpufeature: Add "or" to mitigations for multiple errata
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, May 12, 2020 at 4:12 PM Will Deacon <will@kernel.org> wrote:
> On Tue, May 12, 2020 at 02:42:38PM +0200, Geert Uytterhoeven wrote:
> > Several actions are not mitigations for a single erratum, but for
> > multiple errata.  However, printing a line like
> >
> >     CPU features: detected: ARM errata 1165522, 1319367, 1530923
> >
> > may give the false impression that all three listed errata have been
> > detected.  This can confuse the user, who may think his Cortex-A57 is
> > suddenly affected by Cortex-A76 and Cortex-A55 errata.
> >
> > Add "or" to all descriptions for mitigations for multiple errata, to
> > make it clear that only one or more of the errata printed are
> > applicable, and not necessarily all of them.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This seems to conflict with the other patch you sent to reorder the entries.

My reordering applied to the Kconfig file.
This patch applies fine to arm64/for-next/core.

> Please can you send another version, based on the arm64 for-next/kconfig
> branch?

Then it will conflict with commit 02ab1f5018c3ad0b ("arm64: Unify
WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}") from for-next/kvm/errata?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
