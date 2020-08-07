Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB71C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6D3204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHGRmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:42:50 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55037 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:42:49 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkYoK-1kReqP3jfa-00m3Ei; Fri, 07 Aug 2020 19:42:48 +0200
Received: by mail-qv1-f53.google.com with SMTP id w2so1108850qvh.12;
        Fri, 07 Aug 2020 10:42:47 -0700 (PDT)
X-Gm-Message-State: AOAM532+7psWA3XSEzzzlRrYm69eacuclV6Rxrpwixdruc3bF/469+3k
        yJWT/aRpSFQBxy040BkHuzXP69d2ie00vtHgmD4=
X-Google-Smtp-Source: ABdhPJyv7rCGmFeLP7RqhcY13WRRiZFuulb0+11PGjaOlihhytyNU3OWx3CTv4fKmN0hSDmFQyGgcqMPDDRluUfvdeM=
X-Received: by 2002:a0c:e604:: with SMTP id z4mr16028335qvm.222.1596822166562;
 Fri, 07 Aug 2020 10:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-9-krzk@kernel.org>
 <87v9hupnf7.fsf@kernel.org>
In-Reply-To: <87v9hupnf7.fsf@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Aug 2020 19:42:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
Message-ID: <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
Subject: Re: [PATCH v2 09/41] usb: gadget: s3c-hsudc: remove platform header dependency
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xqCGEHVPGcWB0jFSoTTeIJSqhIg7jVYYMR5j6NlvNl3TbaQ0WLr
 +8ETHw69y0eV6btEKppBnfNKYARUJNbYhrpZnQwY9UGItBJQluG410enW81PrSEYRlN7ms2
 kURabCHww+WltJqBkc7pNCxWIMnLDtgiCmYh6qKwaibwz/eSyN3hQ3ZCkRBXJwXHE01Vs7l
 V15y1LQw3+u5kuB4BvPIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xuYE522+8qo=:D7pjgWSOHM6maavPIzu8JH
 NBk2XWP6xcFRkDFEhGxHX3a2T5KwIxJCfJyEv8pFvtRgDn0vIhVvWAPP9os1bqnQTa921d4OF
 yCGIBZqV1RO6VV6Q1XpZagM0SKuWIpFMos0cPcEu5m+1tl/Guwl2vF/u4xZexUogeu43ecNrD
 IInm9OsPg7cOZs6sRKFbAMjwOddT35RVEfRgSyuUSrx5KtR78v8RXJ5IzePLxW5DYE9GZl+X8
 UB+7sH0smUk/hGwU2eMDCiccm6F/IPEg48Tjhb/gLXgowHl9usaxeooIgdYl2nLT48Vbgiinm
 sr2gZnyfHXPeJewzZIuzonleNax5qbNrKsKE7MyQe86uMHC/az49oUEL8lZJes8PpBOX+tfkM
 XkskfDEYHaG2W1AQT8McFJXPRutuOyuocFpWPQOgzGvz8F+lxBTNS7Z5R4XKeKTKnWBwEZDly
 KSg1vJVeV0LMrwiiwV1PGDrpIcPhuCTi8Y8v+J2XUV/IMLqYPDOjQfwppGhzM+0DfnIn1nBaS
 ARWxg3aCHRK3fOkBqNP45ltMpPadrz1etsoqtnbEYzsQUoR+Ty/ndQxWyg/kXEf3M6ezhTaji
 qUolMcHjczxWcbcdXPUPGHHy0ULjT9dapcTZOK9TnslzgS586fS65QbN2zPMzGVV5pwhYphKd
 TkfrbBjLwPDNrS7eUKgkRUy/cJ+wudbNPdsrfiG9gStI7WJRz2Ug77g3GOwbtcGkrZEVsPNTB
 f95ilNP2PF5WtzzHcl0OAZJtms6Ng4Y452LFQcbshk4wvr+jaSzp/xHectlBYIykpVsiZEwjA
 fhftQAHnzHjrO8gCy6NOqjJMvNNDGC9MpUWGPFreAWBAzDXdnm5EmewvuoShojJZSVBT2qdrP
 E+7GDwxkb6G1Cl4I8keYYiEr/S2Ghe/pdJLTmj8cJjwdIwSxODpRCaXGgQzN/2OivB+4ll5uq
 xuM2gH8h3/lWbpibBi4P2zVLj7XrgxDmSTgWl3w8ynu0WWThfDne0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 3:59 PM Felipe Balbi <balbi@kernel.org> wrote:
> Krzysztof Kozlowski <krzk@kernel.org> writes:

> > +#include <linux/delay.h>
> > +
> >  #define S3C2443_CLKREG(x)            ((x) + S3C24XX_VA_CLKPWR)
> >
> >  #define S3C2443_PLLCON_MDIVSHIFT     16
> > @@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned int baseclk)
> >       return (unsigned int)fvco;
> >  }
> >
> > +static inline void s3c_hsudc_init_phy(void)
>
> This should, really, be a PHY driver under drivers/phy, since the goal
> is to make this platform-independent, might as well take the opportunity
> to introduce a proper driver, no?

In theory, this is absolutely correct. I fear it will be hard to find anyone
to make a larger scale cleanup of the file however. As my old changelog
text says, there is only one board (smdk2416) in the kernel that registers
the device. My change was the minimum to keep it working during the
move to a multiplatform configuration, but if there is someone who has
the hardware and volunteers to make a proper phy driver, that would also
work.

As the board only exists as a reference for other boards, but none of those
made it into the kernel, we could alternatively just decide to drop the
driver. There is also a .dts file for the board, which is lacking a device node
for the udc (and the driver lacks DT support), so that board file could also
be dropped then, leaving only the DT version as a reference for the SoC.

       Arnd
