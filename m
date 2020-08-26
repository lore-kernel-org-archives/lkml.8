Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BD4C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32D820737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598477391;
	bh=M5xEKSXpVHecJggJ/7jEgp0eOy6bqawKlh1mdER1dPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jCb2uIcZqvfOv8gde46HPaoWoZcOmmUm2jxfPNGTsBQw18FIPnbVXyZ1ZNCvTRKGH
	 eU4bsxYjda73abo7AP+ARx/f/Z+4x8CJQXxHDPAJQTYP3BTsl5WLYdx9ivhSd/Etds
	 0isRjQD27UbvqZB9Bxk/amHNjZSI63HfVitHZUhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHZV3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:29:47 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553202087D;
        Wed, 26 Aug 2020 21:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598477387;
        bh=M5xEKSXpVHecJggJ/7jEgp0eOy6bqawKlh1mdER1dPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LzSG/Qk5a7WHKiWMn5Aie6eF3iIzNZ2Z16IWtEjn8XheIoyozAa5Wr9w7uXB2mb8k
         zHIPktW2cWMSBpItG9L30fRv6EL6nq/ixJmE6ksFv6ljGb3QpVka71a5KHi+WwV0Bp
         odTTB66Cn0nbD3qg9MYavogJg5f8w/NXotDnUybg=
Received: by mail-ot1-f52.google.com with SMTP id 5so2721709otp.12;
        Wed, 26 Aug 2020 14:29:47 -0700 (PDT)
X-Gm-Message-State: AOAM533nPRQ7ovw2sGYlPPXoTf5Kz9I9RYzsaRLHIDpSmjNSXQhBX8wO
        NvtozEIls4NUMAja9fUgDobif7BO33AmJJCT2Q==
X-Google-Smtp-Source: ABdhPJzKDROM+sVn9p1+uBWIsSAzu4iTPQHq6XS0P/baAB/RdWr+zWp8c0Q/Clsw7CgWdmERsCd2ozKRfUZcCCkoyOU=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr10408148otb.107.1598477386677;
 Wed, 26 Aug 2020 14:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200826183805.19369-1-andre.przywara@arm.com>
 <20200826183805.19369-4-andre.przywara@arm.com> <c401554a-36ce-7e05-5ef0-5c05a2ca2868@gmail.com>
 <44992125-7eaa-f35b-3344-16ae0d48f646@arm.com>
In-Reply-To: <44992125-7eaa-f35b-3344-16ae0d48f646@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Aug 2020 15:29:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Ch8_WF1VOK2RsxsnyyGTcZDYD4CqNW5sm9=20TBb_jQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Ch8_WF1VOK2RsxsnyyGTcZDYD4CqNW5sm9=20TBb_jQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: broadcom: Fix SP804 node
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:54 PM Andr=C3=A9 Przywara <andre.przywara@arm.co=
m> wrote:
>
> On 26/08/2020 19:42, Florian Fainelli wrote:
>
> Hi,
>
> > On 8/26/20 11:38 AM, Andre Przywara wrote:
> >> The DT binding for SP804 requires to have an "arm,primecell" compatibl=
e
> >> string.
> >> Add this string so that the Linux primecell bus driver picks the devic=
e
> >> up and activates the clock.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >
> > The commit subject should be:
> >
> > ARM: dts: NSP: Fix SP804 compatible node
> >
> > and we should probably have a Fixes tag that is:
> >
> > Fixes: a0efb0d28b77 ("ARM: dts: NSP: Add SP804 Support to DT")
> >
> > Could you please re-submit with those things corrected? Thanks
>
> Sure, will include that in a v2.
>
> Out of curiosity, do you have the hardware and can check the impact that
> has?
> Not sure we actually create the device without the primecell compatible?

My first thought was no, but since the timer isn't using the driver
model (i.e. amba bus), it doesn't need it.

So I think without it, we'd create a platform device instead, but then
there's some logic to prevent that IIRC.

Rob
