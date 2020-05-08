Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F1C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B01C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bqJnS5va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEHSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgEHSje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:39:34 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C02C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:39:34 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r2so2328187ilo.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGIpRsn9hXDxHTNl/QnLM0SbzmG3DHjOVcysfR1ByLg=;
        b=bqJnS5vane6smgkAuFEEcD0f6Ycc9yf0lJgeJRU4JjUw54yjKs7BXh8x7lk1vbGGnV
         0f+IMGeKn3Gw8E15EFVxSoihcpqVq3H2ka3HfRPYyf0OuTLXCPToeBb+OyVQEtZC7lHl
         zuolyQtCP3X66zQBV9+hARMxLnivHPtSnxXf5rUK+0xz88gPQQ3kiIwNSw4silZ09ksy
         iZesm817N+ct23uLjo+cnMxE5KHcCYtZJFFhLRXkIQCkpT0bZ5O/5lBtIwyt1tjgyZpr
         XXPJFtNZ04z6cdHl7rsn9ul842f84tS91OI8taD3ChAh0ODWd61l9meBxJla50/OQul7
         oA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGIpRsn9hXDxHTNl/QnLM0SbzmG3DHjOVcysfR1ByLg=;
        b=suTdqsGNmd9snOKpzLCHyethhRL3qXPnWjR+vTtzpD+/JiGl9U1KNjroBpsxNkNWdV
         ZiFHU59Yg9HHkxfe2trgvGfDmnALzrxMcbW5bwWu6Kv/Ynrm3cO7iq8eLbSwhSNa3FrJ
         YMo3uEf0OK+h/MTCUw2pbYnZyTgL44jn0B2Sk7kgt32f6lEj/g3g+1t9etB2N3ZJhuoo
         ew74EDoPWDv9itwXLscpL2NjqgXh/kYCAMjohbVufRbWunjBolGy93ic8AucmIpsXGaV
         SfeapicaW6atz0BF7UoRB0vvBOw6GnxsUfXJUFWE/izIuUsnbdZMoiZfNb4aVghpwzxz
         VGFg==
X-Gm-Message-State: AGi0Pua0aL0WfgAFc5BFbX+c2P1F+OIwumjxxFzbdMZ+R3cVj82+Wrzs
        JKJtUkPkne96Vp6dVbsEwHezbUqb7ZBjFfaGKNcdXw==
X-Google-Smtp-Source: APiQypIK7HVLTAX4pxfdG4Np+jILsEOGqiII5aB+gQC6LJN5kcIhjqNVKZy0G/G/rBz+o1NbRC9W4C8NgLZeDmRHgVw=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr4467857ili.40.1588963173745;
 Fri, 08 May 2020 11:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200505140231.16600-1-brgl@bgdev.pl> <20200505140231.16600-6-brgl@bgdev.pl>
 <20200505103105.1c8b0ce3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMRc=Mf0ipaeLKhHCZaq2YeZKzi=QBAse7bEz2hHxXN5OL=ptg@mail.gmail.com>
 <20200506101236.25a13609@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMpxmJWckQdKvUGFDAJ1WMtD9WoGWmGe3kyKYhcfRT2nOB93xw@mail.gmail.com>
 <20200507095315.1154a1a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMpxmJUEk3itZs4HujJOXUiL80kmEvGBvLF0NFc2UQoVDVTWRg@mail.gmail.com>
 <20200507155650.0c19229e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <c6e12eb6-d6ea-9ba9-4559-b2eda326601f@gmail.com>
In-Reply-To: <c6e12eb6-d6ea-9ba9-4559-b2eda326601f@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 May 2020 20:39:22 +0200
Message-ID: <CAMRc=MdKjZbHFfTYV12DjMet3sXbBht+qgiViddxs9csDvrf-Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] net: core: provide devm_register_netdev()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 maj 2020 o 07:54 Heiner Kallweit <hkallweit1@gmail.com> napisa=C5=82=
(a):
>
> On 08.05.2020 00:56, Jakub Kicinski wrote:
> > On Thu, 7 May 2020 19:03:44 +0200 Bartosz Golaszewski wrote:
> >>> To implement Edwin's suggestion? Makes sense, but I'm no expert, let'=
s
> >>> also CC Heiner since he was asking about it last time.
> >>
> >> Yes, because taking the last bit of priv_flags from net_device seems
> >> to be more controversial but if net maintainers are fine with that I
> >> can simply go with the current approach.
> >
> > From my perspective what Edwin suggests makes sense. Apart from
> > little use for the bit after probe, it also seems cleaner for devres
> > to be able to recognize managed objects based on its own state.
> >
> What I was saying is that we should catch the case that a driver
> author uses a device-managed register() w/o doing the same for the
> alloc(). A core function should not assume that driver authors do
> sane things only.
> I don't have a strong preference how it should be done.
> Considering what is being discussed, have a look at get_pci_dr() and
> find_pci_dr(), they deal with managing which parts of the PCI
> subsystem are device-managed.

Yes, I have - that's why I asked if anyone objects to me moving all
networking devres functions into their own source file. The reason for
that being: devres_find() needs to know the address of the release
function, meanwhile devm_register_netdev() would have to go into
net/core, while devm_alloc_etherdev() lives in net/ethernet.

Bart
