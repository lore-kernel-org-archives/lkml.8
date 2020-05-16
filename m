Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866F3206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgEPHgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 03:36:16 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgEPHgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:36:16 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MJVY8-1jpKsg1ku8-00JttS for <linux-kernel@vger.kernel.org>; Sat, 16 May
 2020 09:36:14 +0200
Received: by mail-qk1-f175.google.com with SMTP id n14so5054516qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 00:36:14 -0700 (PDT)
X-Gm-Message-State: AOAM530d9paL23/U6YFiTrRYEYGsmWW7RCVxlZPul77LC65bgO6TV4ut
        vdi6q517DzsVNkBHh8k3y9bITj1iJG8bXrWmOzE=
X-Google-Smtp-Source: ABdhPJyMrjMOuEc9sNvAXnl1ziOiZoU4A71ucLrpRtJfpiM8Jgu2Ps5nTqWutNIrq0xkjgxG54pyT9byzsyIwkSCUJE=
X-Received: by 2002:a37:c96:: with SMTP id 144mr7046057qkm.138.1589614573331;
 Sat, 16 May 2020 00:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
In-Reply-To: <20200516060624.GA6371@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 16 May 2020 09:35:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
Message-ID: <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2X1VkGr2casfH9eFrkDJOEKVUQIetUtHPneBsZW5AB0JisxpcKO
 a5EQ8yURrBz+hSzpMyqfpUHHv5qxYjmb6nFHFoCJFuH8ecRkYdHa+QuXs2TNjzC0J/G0SlN
 JEzjBVx3l6OQrD4yBak4RpwiDjhR6KMaHc4aKJeorWMQ+G4DWxYfiFlsID5DlsTc/txIfbR
 H+aUymcAtNx3Zpldhr1ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6EtpMMkLAC8=:ms5w/fstygfKC/0qOaycWc
 I6mu7n2TEJgwtNMS0yhUFRAap0DLCBPDMtUj+St/T51ENOi8AAa3y2dygiIax8jhqOjOAWz0l
 c17sMFH/nkTa/KKJkz3CdaR4GY+lWLpWN28IH9kpVzOVA7Rer5NW8QaJMYREfo0Mj2croZJAz
 t0afSCOMIsyxvubWucW4GGqFLhcZw/hjOqEdDIkL6/XGRHTTUpgsp1j4go4snqDvJsRij2UJO
 iSKJA+8bM6AGMIUZ8+YQ1Dqod0bYBiFXNLz7BE6UdfN4ntZYzuIwst9ftF6Vy20oWoWBBUjUU
 bWZp1LhrKhjTaCqiwzDTkKBV0alaBjsGz5Vm6mlPDMsnQCQYZI1izXV0nKFnvgLHTi+TJLjAY
 2BIdCM7InEA4oC+KbMaGRgeDcnCWA1Ta0K1mB/uSVZBoYGTe2d5pmVukjJeAhzUk+ASNTO58R
 0guWN+6xzM5H5XMJL90IErQCl2lD3SKnLAaHgBSB10QuCwIMdAmIngruDUmbIFTLgSQIhETWT
 8ubE8D16UVS3QvZuPQcDRYh1+Dwh2FL3iOyg4hq1eGaAE3x+ow67SHivRhhqVDqHio88Q3al/
 JugxhftgFX+FCsG+AtSvHPYJu8V7QlBxKuup3nZblrPMCdZyzDZlfOFxtT6qKMir0UpSt1VZm
 AWq6RVRGPYxvwag2sgNcv9v81dZuxGk2Uku8r1W0qHspjSLjDHE7E9PLTuHCx9CAvAfOkExta
 DYwtBbq1mcEIpCxzdJE0gF8Va8ZzDPhN6Ajq+Qy4885Ye+GMr2zwkNIx1fjh4vgD82haT2qSx
 bdaLZKpwkNuKdEvpmJcaIbq29lhwf1bT8XVFtrJVnGQvwRxUVY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 8:06 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> On Thu, May 14, 2020 at 05:32:41PM +0200, Arnd Bergmann wrote:
>
> > Typical distros currently offer two kernels, with and without LPAE,
> > and they probably don't want to add a third one for LPAE with
> > either highmem or vmsplit-4g-4g. Having extra user address
> > space and more lowmem is both going to help users that
> > still have 8GB configurations.
>
> Okay, so the conclusion i take is,
>
> 1. VMSPLIT 4G/4G have to live alongside highmem
> 2. For user space copy, do pinning followed by kmap

Right, though kmap_atomic() should be sufficient here
because it is always a short-lived mapping.

      Arnd
