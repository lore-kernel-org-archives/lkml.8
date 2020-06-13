Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82734C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693C02081A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFMRxV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:53:21 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46741 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgFMRxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:53:21 -0400
Received: by mail-ej1-f65.google.com with SMTP id p20so13198524ejd.13;
        Sat, 13 Jun 2020 10:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3JeOvtc/eAFvXr156ydRZZGyosX/Qqp3aRK+SICpX5s=;
        b=sLBPEvEKU7ScKIlWorrVKzreyEkCYAzSdXtL9zPV/k9a1iCPGYpmo4awxkrzKkhh6U
         ljS0xWEq35aGHV9Q0TUqMU1Wr2CVfnEn8iWe0Qhbst7jpGqajcO/r1/Cx+D60g/28yEu
         /BiMYnWuMDfIb+DpDY/Zs/2Q2do9UoeO2YbDn159AeKtyHVqs1Cp3mSIjOfrWge7j9Y8
         JrKYEFomPaxiKPyp6s3r6eBWxnlZ4YXKs3cUZ+FtZtbT1jprsX+ACNwJlCzieQIgIVlZ
         F+zMfkUBNJUrX24rZZqKrA40iaCnmUoVKhom/t/301MAiKixjLlkEjUppD5Jg5uAI5A3
         ob5A==
X-Gm-Message-State: AOAM530vb6vrzbiSMsUhb1/Aq7Po+9UT3wd2QquwWyCXktQ95PdidG93
        0kNPymiV1LwZxxsLwl4xej3oTjmZUylVv0QT0sUpzw==
X-Google-Smtp-Source: ABdhPJxBidEPydvBx4KSo0FSYx8i1Uqr0G7Qz/qzjO76L9wCItTl6v+val9pjKo6XeFlXTpivudQHulBPZcm4eDaPxQ=
X-Received: by 2002:a17:906:27c5:: with SMTP id k5mr18340389ejc.251.1592070799112;
 Sat, 13 Jun 2020 10:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200609113049.4035426-1-noltari@gmail.com> <20200609113049.4035426-3-noltari@gmail.com>
 <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com> <3E897527-55EB-47DB-99ED-C737725F0F9E@gmail.com>
 <CAAdtpL7dUZ2RqkrqSxiZxDbp4qY-KdtSc7CyuR+rbnRRA2Yvrw@mail.gmail.com> <93c429b1-31f4-95c2-1bd9-b3756b396f3a@gmail.com>
In-Reply-To: <93c429b1-31f4-95c2-1bd9-b3756b396f3a@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Sat, 13 Jun 2020 19:53:07 +0200
Message-ID: <CAAdtpL6OXziD9Q0dBZzkcq0jPF04rmNd6o_hi7Frm5DejG29mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
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

On Wed, Jun 10, 2020 at 5:32 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 6/10/2020 1:29 AM, Philippe Mathieu-Daudé wrote:
> > Hi,
> >
> > On Wed, Jun 10, 2020 at 8:13 AM Álvaro Fernández Rojas
> > <noltari@gmail.com> wrote:
> >>
> >> Hi Florian,
> >>
> >>> El 10 jun 2020, a las 4:27, Florian Fainelli <f.fainelli@gmail.com> escribió:
> >>>
> >>>
> >>>
> >>> On 6/9/2020 4:30 AM, Álvaro Fernández Rojas wrote:
> >>>> +static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
> >>>> +    { .name = "adsl_asb", .bit = 0, },
> >>>> +    { .name = "usb_asb", .bit = 1, },
> >>>> +    { .name = "mips_asb", .bit = 2, },
> >>>> +    { .name = "pcie_asb", .bit = 3, },
> >>>> +    { .name = "phymips_asb", .bit = 4, },
> >>>> +    { .name = "robosw_asb", .bit = 5, },
> >>>> +    { .name = "sar_asb", .bit = 6, },
> >>>> +    { .name = "sdr_asb", .bit = 7, },
> >>>> +    { .name = "swreg_asb", .bit = 8, },
> >>>> +    { .name = "periph_asb", .bit = 9, },
> >>>> +    { .name = "cpubus160", .bit = 10, },
> >>>> +    { .name = "adsl", .bit = 11, },
> >>>> +    { .name = "sar124", .bit = 12, },
> >>>
> >>> Nit: this should be sar125
> >>
> >> Nice catch, I will fix this in v2.
> >>
> >>>
> >>>> +    { .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
> >>>> +    { .name = "pcie", .bit = 14, },
> >>>> +    { .name = "robosw250", .bit = 16, },
> >>>> +    { .name = "robosw025", .bit = 17, },
> >>>> +    { .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
> >>>> +    { .name = "usb", .bit = 20, },
> >>>
> >>> This should probably be "usbd" to indicate this is the USB device clock
> >>> (not host)
> >>
> >> Ok, I will change it. I got confused by the fact that both (usbd and usbh) were present on 6318_map_part.h:
> >> #define USBD_CLK_EN         (1 << 20)
> >> #define USBH_CLK_EN         (1 << 20)
> >
> > Is there a datasheet to verify that?
>
> Not a public one, but I can confirm this is correct given the internal
> datasheet.

OK thank you Florian.

> --
> Florian
