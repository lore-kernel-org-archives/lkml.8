Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF3EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D78B2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 09:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDKJB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 05:01:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDKJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 05:01:26 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N49Qd-1jE5DA1hwn-01061n; Sat, 11 Apr 2020 11:01:25 +0200
Received: by mail-qk1-f170.google.com with SMTP id c63so4531238qke.2;
        Sat, 11 Apr 2020 02:01:25 -0700 (PDT)
X-Gm-Message-State: AGi0PuakGIqo1uIxr8HLOPeGeH6LU6PW9cKtcNuYvPoOXZU97yx1LGCN
        q+wu+2NdOwsMZwWTNoghE9zdtLoJ+ABWUMJ7wrY=
X-Google-Smtp-Source: APiQypKhDmVAIU0z8agDejiZXz9OBxIwMlgFklDn7Rrv5q+p5XAxHWKHi77FzV/FNVWHIsKUQeFHo1tNP/u1dTlnWpk=
X-Received: by 2002:a05:620a:5ee:: with SMTP id z14mr1058582qkg.3.1586595684151;
 Sat, 11 Apr 2020 02:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200408200828.124139-1-arnd@arndb.de> <20200409132435.GA3263479@ulmo>
In-Reply-To: <20200409132435.GA3263479@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Apr 2020 11:01:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Ktmt_9VLaQfm98ZzRnB9LnnjriHeJ+7O5aE=eMXk7oQ@mail.gmail.com>
Message-ID: <CAK8P3a0Ktmt_9VLaQfm98ZzRnB9LnnjriHeJ+7O5aE=eMXk7oQ@mail.gmail.com>
Subject: Re: [PATCH] phy: tegra: fix USB dependencies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SMaxRY3ptf++WVxvQEi66DejCKOoCt8Ygpe0PdzzJz0DiGFNKr/
 1U8L3vTuDXGPHZL8wc+nydbukK3nLkPcljWsbJ6toqxX0aVfIV8bbEgNS9qjuBUuImOarrx
 vMabGFy4yJHzXO+fyIyq+6Jw65+NpHaxvUrNMiPFvSGnEtSzh/pAZ0+QmVhXfWYQK5dpRtZ
 dKUcLlMoXoptYtW8sKzWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OXaZuq25LLs=:hU/z/8lfLCG/W/1NmOzXtF
 LhI2nzbGTr3eNHSl6v0Ki3YQi0hmsQyOqrX40J2Oax1PqlIDwdH03ll0tT9AzIrQ0ESihXw18
 D83adzLFp4hbQdfpHZrENMNc8VD/QuLgn5uk2afIgrth3YG4ESIzETxX6/2Nno/kRky/MhF9Y
 mO7Nqmc48srNmEZ/c9VRRPDGCwN+qbxYTgcGUbg27TP9lrWfTkw4R6kusr8Kaa4mIiT5N0dNc
 r3cIr0SBFsrYkU6EZuBl9dVsJDU3ZdU8lYcmZS2uBTuzdweYGH3lKEfu6sHdZ3Uva0csv6N6o
 L4kZb4cHb03JagagzO+WhRYEXz/svPN2xRkCGzHBt3qPg4/saSg4IIkFeRmlXKWDyI/LWKUl/
 fEzaAtyKT2/sNu9sS01Ziu7b543lhX0iHEwroZlXy6LaRJOChSDuLFwlAzrv7jP1r0JPzNhHA
 qVMLrX2ECqPBJePa0mFZvXl+qEAvCGsyJULd6MokngzxAQCWzKjhPsig4EoXw1+Xl2MljSNkW
 /i7WMjo/kvkLfBKZr50zTFDS3bQtZoMpH2Sx/09b06iYo8sW4/VJ529QBPqzLus1oGg2pSSKE
 U1JS6wZ4YNLn2GmeJL5fwbuugqm0XGpxeUpgI5AtXSrraNH//3QTUprhLUcgoWvZMtherBftl
 SR9BRgbbG18AFNK4qS4D3z0FFcqxM3bANVHHlVZ3/RUEe7CmD8D2ysko5vu2mtr1BPrkHNh7i
 WtA+37rV3OQGu6RE1HsVIIfcJjm+J9GU0Gnv9lfxZlyKIIj0y6yLFOiRwphxjRD+JwBAG9QXp
 +Pyr30RlqjVXrjWtWu7YvuvViSjJI6O0b2X6LbSyZKs/MaVev8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 3:24 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Apr 08, 2020 at 10:08:14PM +0200, Arnd Bergmann wrote:
> > Without CONFIG_USB_SUPPORT, we can get a couple of warnings for
> > missing dependencies:
> >
> > WARNING: unmet direct dependencies detected for USB_PHY
> >   Depends on [n]: USB_SUPPORT [=n]
> >   Selected by [m]:
> >   - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]
> >
> > WARNING: unmet direct dependencies detected for USB_CONN_GPIO
> >   Depends on [n]: USB_SUPPORT [=n] && GPIOLIB [=y]
> >   Selected by [m]:
> >   - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]
> >
> > Fixes: 6835bdc99580 ("phy: tegra: Select USB_PHY")
> > Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/phy/tegra/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I sent a similar patch a couple of days ago:
>
>         http://patchwork.ozlabs.org/patch/1263865/
>
> This should be applied by Greg on top of the PR that I sent for USB. I
> did get the semi-automated "we're in the merge window" reply from Greg,
> but I was under the impression that he still applied fixes during the
> merge window. It seems like he didn't pick this up yet, though.
>
> Greg, anything I should've done differently for you to notice this?

FWIW, your patch is correct, mine was wrong as I forgot the "select USB_COMMON".

       Arnd
