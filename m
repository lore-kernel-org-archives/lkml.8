Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D219E206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gixcreoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFAR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:26:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D8C05BD43;
        Mon,  1 Jun 2020 10:26:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so127999pjv.2;
        Mon, 01 Jun 2020 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMi/4BxM0AbXAkM7OIaB/P+4lYmXtN8bwq9ouV8Hcfg=;
        b=gixcreoioOVRmb/MHec/20OTFgvBLgJMODpAhpBX8wvXRjGV0VJOZIyDEoIHnDz86V
         E/JNAO4TOvEXU9jpEk5jMB8Jl8gLxblRSDwng4aBZ9lTRF564K/hpD+/CJBFolIh4BpM
         2NgF6hapRSFk8AGYFTziS/P8G2MVrOacSFcjy50TNgCXbDG4NBFteLodKkvO0vbUx0C5
         M8zDbPWxFOBCcv4qfraFT2gGFM9LjOPlLWAo8u4Q8TUkpNF6B+c0FDolyHwmo9Kx2uXs
         IrohpGP4hEXXWA3bXBcKpAfqKRjS9GCCs6IN6Jnwd/hnjbQ77MGXUmR/yIibfWRxdrcJ
         4vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMi/4BxM0AbXAkM7OIaB/P+4lYmXtN8bwq9ouV8Hcfg=;
        b=lZ1/6GcwkqYYskKg8lIMRA7JDaeBI6cBtM5M2DeJJUjl9IWm9E0hoLCD/KurJw8tDk
         y7kxHVjA7SApqOdyIPRCHhl1uOfh4+jzQT7w8XB8JhFVvOTmGsqV2/4lR/wURvPZl1yT
         vp6yKjLHYNHd5UOgBZIxKUeMaploomOcShGeycprwh3XgEPzZHB7s8gRwbUxtLbwSQx9
         jSXAPM20Fwdo2qMa6uM+IuMKrWxFnpMNmTm9VpG8fwQWCS9ohMrr67cUEUQZ9b6PepU4
         77dvzsSYzUFquGIH1LZ9/bTieAKd3lF/6+KW3ZtyQVKsWPF3oeABcsfCr9oK0Mi9Q2F3
         N4eQ==
X-Gm-Message-State: AOAM532N8ERH0D3EsIyfM98HX/52laOpstZ/pI3XfKqECi5i9D1Csg5C
        qvBsMV5PCAgH+RsqRARS32Cbp6OiW1PMDRYB2sg=
X-Google-Smtp-Source: ABdhPJzk4Shgd8HYl9JK13sPsEt9pslUnIpILMIGTxNZDqYLmGXh9+fcZeaRJBl6q2TRwroNi5hrcGBg/uiGSbF/Vkc=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr492670pjq.228.1591032360279;
 Mon, 01 Jun 2020 10:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041506.39638-1-jhubbard@nvidia.com> <20200531205819.GC138722@ravnborg.org>
 <854fae07-3cb4-dbcf-fa93-35b447f9d084@nvidia.com> <CAHp75Vf6=UuC2Sef3m3CpRmjAOWt8ZgBW+OPf0-_53P3F__CWw@mail.gmail.com>
 <e7f95207-1b30-17a8-4667-ca58b77ec0a3@nvidia.com> <CAHp75VcaXTM86K9vzyxTQJP_oNnzJ8mMHzgm7ybEioVhG6DHDQ@mail.gmail.com>
 <8fa07f59-6d77-f76b-7539-c88bf85c5036@nvidia.com>
In-Reply-To: <8fa07f59-6d77-f76b-7539-c88bf85c5036@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Jun 2020 20:25:43 +0300
Message-ID: <CAHp75VfHnLz56jyR5PNgpxWGtO_u0bss45+iHhQ03c_4L3jH5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Paul Mundt <lethal@linux-sh.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 8:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-01 03:35, Andy Shevchenko wrote:
> > On Mon, Jun 1, 2020 at 1:00 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >> On 2020-05-31 14:11, Andy Shevchenko wrote:
> >>>      ...
> >>> JFYI, we have history.git starting from v0.01.
> >>>
> >> OK, thanks for that note. According to that history.git [1],
> >> then: drivers/video/pvr2fb.c had get_user_pages_fast() support added to
> >> pvr2fb_write() back in 2004, but only for CONFIG_SH_DMA, as part of
> >>
> >>       commit 434502754f2 ("[PATCH] SH Merge")
> >>
> >> ...and that commit created the minor bug that patch 0001 here
> >> addresses. (+Cc Paul just for the sake of completeness.)
> >>
> >>
> >> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> >
> > I mentioned this one, but I guess content should be the same.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
> >
>
> Actually, that history.git *starts* at Linux 2.6.12-rc2,

It's not true.

> while
> tglx/history.git *ends* at Linux 2.6.12-rc2 (which is in April, 2005).
> And the commit I was looking for is in 2004. So that's why I needed a
> different stretch of history.

Actually history/history.git contains all of them starting from v0.01.
But it ends, indeed, on 2.6.33.

-- 
With Best Regards,
Andy Shevchenko
