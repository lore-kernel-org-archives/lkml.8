Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55267C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400DE2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2MOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:14:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2MOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:14:15 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MiJhQ-1kgAKJ33qA-00fS3o; Wed, 29 Jul 2020 14:14:13 +0200
Received: by mail-qt1-f176.google.com with SMTP id t23so14266160qto.3;
        Wed, 29 Jul 2020 05:14:13 -0700 (PDT)
X-Gm-Message-State: AOAM533RPdXnM6vwVyFQw9vg20GiTqJ8FdMmVPmrjtPfyMOICuU1Qece
        HdilerdGY+cD9dPatJz9GmMKy6NkGCRpZVA6nDg=
X-Google-Smtp-Source: ABdhPJzEETy3t0VIPJ+9M1SnOjitwEPi3DBVQh79vV4tcPeBIqCH4XXLwXt5aL88sDcPWbirZtMAzq/553+VeZLex24=
X-Received: by 2002:aed:33e7:: with SMTP id v94mr28783760qtd.18.1596024852337;
 Wed, 29 Jul 2020 05:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100321.1691745-1-daniel@0x0f.com> <20200728100321.1691745-2-daniel@0x0f.com>
 <20200728191842.GB2778962@bogus> <CAFr9PXkwpNAhQvOJFqLUm-uWoaH=nsNiq_y+OgTf8Z60i4RhRw@mail.gmail.com>
In-Reply-To: <CAFr9PXkwpNAhQvOJFqLUm-uWoaH=nsNiq_y+OgTf8Z60i4RhRw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jul 2020 14:13:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-rZq_aJxWY2+009C91igzC4nHG7XJFwXkbB8bJBertA@mail.gmail.com>
Message-ID: <CAK8P3a0-rZq_aJxWY2+009C91igzC4nHG7XJFwXkbB8bJBertA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm: mstar: Add binding details for mstar,pmsleep
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tvq8uSyI/xOwjnta/TqGt3R+UnfahZltj0tXcWUP0nDif71Q2BU
 Kg8MP0f85lIlvIv+Mmru+9PA5o+NgkY+s1WAk9VruGSNvSU1vwuc8lNp4+kb+QjIKrdUZAM
 Oh4iRLjgawXUhTDpQZnEzlOKZXlI5KziiJ4s3ruyftPjCX2SaYc3TNu9HtiqaoIisF6jBs9
 mNNaTdDJwWqTWSnMAIndg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mxvqiXYnn7g=:Bh9eImBvjiq0gBEBELa+sg
 jCppt11Kz8VhsZAzC1spzrfbiwgJ8jm7BcVq+JYnzTnpR8d0/d3Cp2kNEcNUMhPnE/VU0e27o
 m/Gjmrt73zPdFn5h/Ki8lCC0DKqjt9B3BsPdx9L8rr3wHlQvHnwzTQ/i8C22wHxD4kaLLmucK
 IYFU0wvi+g0Z7YVYzkJ0BOAGOAOsKX8UKGCKrrPee0C/uMxUfgzuwBvlDn7QpkxgVvnMfI0+L
 zeFo4ABLe+C/TXx6aWef0qTD9eGQ5XEE7DS7woMqgEhihJBJXFVrtYDlGvrJ5f4AnXBiq+GgI
 xxRgl+wONzLOIZPoBdeOPIamfbE09f4VuaJK+eSoyTnpP43sGGiEk4+NQeaweIkfG2/k4XSj1
 Yiqlaco5dzaatq0MdNGLQoRKhivFA/dfRGDMSv20pTovPox5ua0EafLuYYQQn1UlVpiRP10Nq
 w16plnWvBXr3VvyXSbVmhluzQdAdNbxCb3bUHgpsEJyIl2tsL9lZdikR483usuXLuCklW66WQ
 wHZnfgyI4vvWA5DL442v8GF9h6MzybvHKMag3e7wpuDk2RaqBodFQ074pnkjuLxA9GbKsgfc9
 XO82A3fmMZULboOWKKLAUGojzT5DTUjByz4r5ZCA/1kCYrl0xifYqcULocCmTZX2T4hjwLA4h
 78a4ze6w8wEKgRMn3AfCRdjn3h/GDvc68F963RBXv+38XBXUGHbFZ20CvwYoMNTL1wGKhf1hG
 8OXj/0y970JG+aRqb4WQXsy8D6IFIar2BnxojNpxovX2ipVfOCa7kFk4uJSCbe4qYU5dvjrFZ
 rv8A1mb09Svkca5GQ/dIpqF883cJ1oMlvdf/30/eNIE8Y5wHbMydl0fM2fy5MAEQrbm9HzZZw
 QLsTfaZfW5a6nMeqZrihNbIdXO9GhKUPeCuMHHDJr1t+Egt9lFiA2poiOc+yAubpeds2Q7oj1
 yQ7vVeHf7SRN+IY9EaZLEfQhad6FaK2cBkAbPmf/lty1FrpoKqFL7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:14 AM Daniel Palmer <daniel@0x0f.com> wrote:
> On Wed, 29 Jul 2020 at 04:18, Rob Herring <robh@kernel.org> wrote:
>
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +         - enum:
> > > +             - mstar,pmsleep
> >
> > Needs to be SoC specific. Random collections of bits are never
> > 'standard' from one SoC to the next.
>
> I don't have a manual for any of the chips so I can't say for sure but
> so far all of the chips in this group (ARMv7 based MStar/Sigmastar)
> has the same layout for the registers i.e. the reset register,
> the resume address registers are at the same place for all of them.
>
> Does calling it "mstar,pmsleepv7" make more sense? I'm not sure what
> to call it really.

Use the name of the oldest chip you know that supports it in there,
such as "mstar,msc313-pmsleep" if this one is specific to msc313.

       Arnd
