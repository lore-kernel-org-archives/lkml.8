Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4EC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92C3120675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgEKP3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:29:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgEKP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:29:49 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9MYu-1j4W2J3Bn2-015GDz for <linux-kernel@vger.kernel.org>; Mon, 11 May
 2020 17:29:47 +0200
Received: by mail-qk1-f178.google.com with SMTP id b188so10119108qkd.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:29:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuYWVo022InwBklR4erVADxzq0IiImvaDS14HZ7iTYw2Y+Tmbl5u
        Uv+sLsZPcFulL2bLkhjjX/PVocqnnKXM39FpH9s=
X-Google-Smtp-Source: APiQypJqkx9Wh1nNgK7vVycduyuXesKEQUeeckiF+gPcu6V41M9Z/9Eq//BTqI9+j2JHqoWMGtanrCSLxeUhS5Jd6lo=
X-Received: by 2002:a37:4e08:: with SMTP id c8mr16010333qkb.286.1589210986640;
 Mon, 11 May 2020 08:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com> <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc> <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc> <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
In-Reply-To: <20200511142113.GA31707@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 May 2020 17:29:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
Message-ID: <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space (was Re: [PATCH 0/3] Highmem
 support for 32-bit RISC-V)
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r4zcMHCTCI4e1WcOWKSfX0GQqAfiHZSjBjZkV89H3zSVO+tjoBz
 4fGx3dWzOBmkjU6OoAqJc++71zy9WpabMtPCVDonh0Bvyuy8WAe9TRmh/mNJcWHjeGYSw2O
 GTJczLkN410tPdhk6AsJKrOTLSJYIC7QHkqyitvFB21qxumo4/zK0EQcVQs/gdJYVA0HUR2
 YxY8Xplx/Qpgsvo5PjkhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kwwigW7yKJQ=:P3WjjYxQ4beOwZm3XJN4aX
 mmqm7XsJfBuXFt9neLIE4CcVW2U5uaVKVi7OQGn4yfRHC/XLMec5Rj/pEeURIz0lSDss/RtyD
 Do9Gy42hBnkJS2cWEjIVOVie2mkoTzURSVUDUzV82poQx7NhFnE5P2sZZJY/MijKHj4NPoAAY
 hWbTO3EaOaldMpyPGjDx9Dlwz2xtHQDUKFfFzsvGLQylSNHlUHQOyJ27YrGbMOyukuzzfgUvg
 F14XVpTJ1Y/6m8s941Dd/6Q4XOHsHux2QF/G3irnYEK3u51VOx95sX9ngld2PU806uqNZv8Bf
 RZxC66bDBlMdQ3yFU+E/cgxslHrJjupHldhHTQhwXpQDT3E2XaR824mzs3qgU7wJbQO84NrmK
 O59rUkVS65ZmoiugTVw8bfXlYA7pFfLWQzysMfYAsjcuzd8Tzue+jZJK10cr7LBhPDYJxf2WG
 k/NwKnTh4XjozkaxAqarxZEMLcKF588ohb17RNuNtk5stdTp90JVNeGhQcgn1RKoqxK6wFiDA
 kZ05MFZOwg2GpOyeOkDR0Ol/zvh4Jhk5cgW9mWkBDEm9j0C78a2/AU/k7eLbA5Gl59ubWYXyv
 yw3Bo5qKrHynaiwULxLCqJgTps4WwM8nr2qD+ItQmBsh7FPeKmYRLBcWoNtSdXNuKjJOU/PLq
 oSLmJIiANVmsbI5Pi+xtlBNK+2mZY0VZ0KGopsP0E2EkcQCguafH3Wbh2o7r9+CKlBTepmLz5
 mtwiA7Zy08r6b2B4d43L+M52/NzeHArpoVDL0AK+PaaEMG05To1dSr82dczWlknXqi71L1omh
 rp+c1gFaz9pTcwYhiI+6+8rqHbuyiC0H2J0tsY+cNyhwBpA040=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:21 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> Hi,
>
> Kernel now boots to prompt w/ static kernel mapping moved to vmalloc
> space.
>
> Changes currently done have a couple of platform specific things, this
> has to be modified to make it multiplatform friendly (also to be taken
> care is ARM_PATCH_PHYS_VIRT case).

Nice!

> Module address space has to be taken care as well.

What do you currently do with the module address space? I suppose the
easiest way is to just always put modules into vmalloc space, as we already
do with CONFIG_ARM_MODULE_PLTS when the special area gets full,
but that could be optimized once the rest works.

        Arnd
