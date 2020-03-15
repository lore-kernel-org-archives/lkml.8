Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FDDC5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF6B205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 09:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+ZgyUWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgCOJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 05:46:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35112 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgCOJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 05:46:44 -0400
Received: by mail-io1-f68.google.com with SMTP id h8so14117216iob.2;
        Sun, 15 Mar 2020 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNFfXHO2uILPgu0B1T3kwaBgaXjP+dlED6DVNl3sNIg=;
        b=I+ZgyUWzIa8Yxi+0xMqH9yaVxAhiEOypJ/WXcO5ujz84CdXXQxL2d1ab/itSy71+MY
         v1zS6OgxvE0Bn+Qa0JXfcz8RKJwprkoMCBipzhzZlHWCugVSwinT5j3lnrH2WDYlwZ01
         eYOr9xN2OR+z2u3VNz+TrTa75FmvLhds4/9O2wY6HbEzs0xPbUZ28UtXN7LT2TXhup6Y
         pkBRtDX0RpzM5wTDCNpUYBgBjIeYHAnSJprQYhPVixRf+4+i5CWwFDcVCSryxTo7o+n+
         QvVX5JRwWD/Ek/EyR8q7MTRXZ3swX8IoaPhhLPo/I0oYQ9PA+4e/gT6RGNbVnejmq4aN
         w9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNFfXHO2uILPgu0B1T3kwaBgaXjP+dlED6DVNl3sNIg=;
        b=icy7SZW6XbPVFapP/3jpqqK8cP45v9BhR5hqZv6+2LAKRg88qcGHntKcEP3RniUpm2
         8LEX+pWrbaIZUospvcpto38IreGhQ6xer/WAe1etFMNVybjtQysb8/oteh868wW8gVD6
         djQisSMwIE7RgIMkRyUQdUFRQxAPzMO/TGyabuDy/pH8g0mzuow9RekefDDOvIKmhFtT
         Ql63wtn/xoKo30da9oWb1tdPIAE0IkoPw/kN0nduV4o4Uras2GMXvGGLqsh6ETjdk0or
         wMpz1snJ3Hfx1fwq5s8YmpJtLFiLt+k82n8rmtN/grRziuuZN+E1ZkiXsZbyJxbQIgQv
         4WmQ==
X-Gm-Message-State: ANhLgQ2BBjXijrw6M21cpRQEQNHUxd5BN44RVqMBAnYjTMCbNGJ0a3a1
        iYFOfYGgS3QSr5DJsQTsFZFdMMj7VjMSNlgyPPg=
X-Google-Smtp-Source: ADFU+vsewoQ8rLqcke0ekgyn+gsES6vdYQVgDzjdOdmXOPVuxzoaksZJ3jLUICWiRwD3y5hXFyjeMrRhGfoBBlDZBWk=
X-Received: by 2002:a6b:f311:: with SMTP id m17mr19317386ioh.128.1584265603378;
 Sun, 15 Mar 2020 02:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-3-linux.amoon@gmail.com>
 <CANAwSgR4fJK0uVANv-x-=iSL_hAKD8kvazACUsY9Meu5xonuqQ@mail.gmail.com> <20200314182010.GB17580@kozik-lap>
In-Reply-To: <20200314182010.GB17580@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 15 Mar 2020 15:16:33 +0530
Message-ID: <CANAwSgS1+6Dzv2XbmMUR40AbJePxUzWkKkBC1W9hBMGzaMWP3w@mail.gmail.com>
Subject: Re: [PATCHv3 2/5] ARM: dts: exynos: Add missing usbdrd3 suspend clk
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, 14 Mar 2020 at 23:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Mar 14, 2020 at 07:02:33PM +0530, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Wed, 11 Mar 2020 at 01:19, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Add new compatible strings for USBDRD3 for adding missing
> > > suspend clk, exynos5422 usbdrd3 support two clk USBD300 and
> > > SCLK_USBD300, so add missing suspemd_clk for Exynos542x DWC3 nodes.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >
> > My assumption based on the FSYS clock source diagram below was bit wrong.
> > [0] https://imgur.com/gallery/zAiBoyh
> >
> > And again re-looking into the driver source code, it turn out their
> > are *6 clock*
> > Here is the correct mapping as per the Exynos5420 clock driver.
> >
> > USB-(phy@12100000)
> > |___________________CLK_SCLK_USBD300
> > |___________________CLK_SCLK_USBPHY300
> >
> > USB-(phy@12500000)
> > |___________________CLK_SCLK_USBD301
> > |___________________CLK_SCLK_USBPHY301
> >
> > USB-(dwc3@12000000)
> > |___________________CLK_USBD300
> > USB-(dwc3@12400000)
> > |___________________CLK_USBD301
> >
> > Note: As per Exynos 5422 user manual, There are some more USB CLK
> > configuration missing in GATE_IP_FSYS. So we could enable another dwc3 clk,
> > If needed I would like too add this missing clk code and enable this
> > clk for dwc3 driver.
> >
> > For some reason we already use CLK_USBD300 and CLK_USBD301
> > for PHY nodes, which lead to this confusion. So we need to update PHY clock
> > CLK_USBD300 with CLK_SCLK_USBD300 and clock CLK_USBD301 with CLK_SCLK_USBD301.
> >
> > Please share your thought on linking PHY nodes above and add new DWC3 clock
> > and enable this clock.
>
> The real clock topology of Exynos5422 is not properly reflected in the
> kernel. However cleaning this up is quite big task.
>
>
> Best regards,
> Krzysztof
>

I would like to fix all my patches with new finding and submit them
once again for review.

-Anand
