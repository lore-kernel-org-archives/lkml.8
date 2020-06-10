Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAAA2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgFJI3p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:29:45 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46879 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFJI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:29:45 -0400
Received: by mail-ej1-f67.google.com with SMTP id p20so1543952ejd.13;
        Wed, 10 Jun 2020 01:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FDSNWzEU1BCo6wG/cdIC3mu6f2xb06oIyPX8U4p2La0=;
        b=nG6Purdq6ub66hKETSZxcqLCzaIHIIL4KgpgNjsW+FEHBZIMOXMQyk2SecPPxM1/2A
         x+VMFCg6wnWL+mkuNJDvFeHdLpHhrzUYtnuYGsAL9f5B4yBBp5g965vNAVsQ7Yyc46Dy
         ox3QiB5n+RALtawxU/UKA5rjpu/1Msh+Krtx2tDsyS92Wc86CE/48DENExl+cn9ZHLva
         ORheGGqoj3B6jnI86o5dNWAeGgvOldGUd1F6uc4fa8KR6MYN5j5kTm5IwMiscJS1KeAj
         E7ztG4o6QvE3QZ68zZHmI0hafSRwtO7/XihnV3j6aEVOverjRbjBpYy3EFO0vp+ksbdp
         JMSQ==
X-Gm-Message-State: AOAM532vpShi8vYLU/7pF7fTOKxpK8n/fDI7f4yjsvOiq8aehF0wwAcR
        WcMI1/exLwZ1WxHeTDzsAqyAQGkW+kVrkmUU6PQ=
X-Google-Smtp-Source: ABdhPJxOEtPuPOmj6dC8S4CZ/xJTRRt5rhm7PcV4cCO58Wg9TMbFQP8d/SywDEkq0BNkQlzSPKMmCP8/XoHZ7bIpl94=
X-Received: by 2002:a17:907:4096:: with SMTP id nm6mr2343355ejb.4.1591777782737;
 Wed, 10 Jun 2020 01:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200609113049.4035426-1-noltari@gmail.com> <20200609113049.4035426-3-noltari@gmail.com>
 <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com> <3E897527-55EB-47DB-99ED-C737725F0F9E@gmail.com>
In-Reply-To: <3E897527-55EB-47DB-99ED-C737725F0F9E@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Wed, 10 Jun 2020 10:29:31 +0200
Message-ID: <CAAdtpL7dUZ2RqkrqSxiZxDbp4qY-KdtSc7CyuR+rbnRRA2Yvrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 10, 2020 at 8:13 AM Álvaro Fernández Rojas
<noltari@gmail.com> wrote:
>
> Hi Florian,
>
> > El 10 jun 2020, a las 4:27, Florian Fainelli <f.fainelli@gmail.com> escribió:
> >
> >
> >
> > On 6/9/2020 4:30 AM, Álvaro Fernández Rojas wrote:
> >> +static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
> >> +    { .name = "adsl_asb", .bit = 0, },
> >> +    { .name = "usb_asb", .bit = 1, },
> >> +    { .name = "mips_asb", .bit = 2, },
> >> +    { .name = "pcie_asb", .bit = 3, },
> >> +    { .name = "phymips_asb", .bit = 4, },
> >> +    { .name = "robosw_asb", .bit = 5, },
> >> +    { .name = "sar_asb", .bit = 6, },
> >> +    { .name = "sdr_asb", .bit = 7, },
> >> +    { .name = "swreg_asb", .bit = 8, },
> >> +    { .name = "periph_asb", .bit = 9, },
> >> +    { .name = "cpubus160", .bit = 10, },
> >> +    { .name = "adsl", .bit = 11, },
> >> +    { .name = "sar124", .bit = 12, },
> >
> > Nit: this should be sar125
>
> Nice catch, I will fix this in v2.
>
> >
> >> +    { .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
> >> +    { .name = "pcie", .bit = 14, },
> >> +    { .name = "robosw250", .bit = 16, },
> >> +    { .name = "robosw025", .bit = 17, },
> >> +    { .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
> >> +    { .name = "usb", .bit = 20, },
> >
> > This should probably be "usbd" to indicate this is the USB device clock
> > (not host)
>
> Ok, I will change it. I got confused by the fact that both (usbd and usbh) were present on 6318_map_part.h:
> #define USBD_CLK_EN         (1 << 20)
> #define USBH_CLK_EN         (1 << 20)

Is there a datasheet to verify that?

>
> >
> > With that fixed:
> >
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > --
> > Florian
>
