Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A59C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE920725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkFrPEBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGKVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgGKVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:07:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FB4C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:07:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t74so5165542lff.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4nruq+oFiOvqyvb4/VdyM/ZTJbNZf/NdW35w9sc1Vw=;
        b=JkFrPEBfH8dagE1gbcrczR+NaJRYTz6akXcZnsC2ggF2HTLUZaJhU0SQhevq7SR9A8
         TOJvCa3mY07asVGgE2VAD20RElrOPt6KCtSjgGMlvTB3YKaQxIMxfIDiEDcggO6YGOdz
         PM5yAGQkvoDKcKEQOJ344MZ0oFVlyliO9Vsii66zWJ2UdnmumhsVl6/CabNCg4sCK9GX
         GgwXoF+gE/rmqAd9/bYsBcnF0GogprDeJJ17LniiVoWsnHw/HV8H+hvJ2m+wvkEULTEa
         n6mGiKnXpvUMGeTuKpKWzKhSeJRyMYXXYcBkceT87oGMqAFowaOLvj5q82JYPQO0Yu0F
         0mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4nruq+oFiOvqyvb4/VdyM/ZTJbNZf/NdW35w9sc1Vw=;
        b=hF97dvdl7zdhL1wUxegI2b1jOK+Wx4RC+RLIU7r4vN9JUgRw6PUnmJIboyTF/QUak6
         M0j0L4VTtY/rx5YU3q0Jaf9db/asbJVEB80c/bCVzHfppoC8PrI/85AuWihrCcHl0eii
         P0monkDKwS6GmRm0AlX/EHT3vtvz42lkxU3jpaO5HvAqliyTiCjF/iuWsOx2MgPV+SAz
         /MNyEchSu/WP/3hIB02EKWlfQtyeryXdfpgCs55rmfOz3IeW+WNuTtIHBRQ+mXs6h7xe
         qNhXTP0ISG0VTZy/NaAKa7UZ8fDHNph0dsUhv9wuFNLf6W+rIUjYO8wCCebkZooBMwkq
         RoMA==
X-Gm-Message-State: AOAM530x2AkM8MEH3cJxsduxDtfsAmH/xLAFRcDyiEcZH+8WKvnm3ZjD
        +UF/0DhQOT4Sc8UzsIEcOlH3pYC61V+WBokVD8+jjA==
X-Google-Smtp-Source: ABdhPJyDiDsK12IuwKtw/dVRn5YAY+IfXPlqFWGCjxLbFu5B1b6OC79zeGSpRTe7ZBdq9RgfyCwrSSqQp7SJJDFTsQE=
X-Received: by 2002:a05:6512:3150:: with SMTP id s16mr36960881lfi.47.1594501660354;
 Sat, 11 Jul 2020 14:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200630212958.24030-1-mark.tomlinson@alliedtelesis.co.nz>
 <a1dc8f14-187d-a804-45bb-d1fa25ff7b01@broadcom.com> <760595a8cdfeb0156d5180ecaeb2ee4487f50cc7.camel@alliedtelesis.co.nz>
 <86c009a8-05c4-40a3-daef-6d9e848642a3@gmail.com> <db96187e25342cd36133cde64ef742e03325c8c3.camel@alliedtelesis.co.nz>
 <cd40f919-f8d9-cde4-6cc5-f523e4973c3b@gmail.com>
In-Reply-To: <cd40f919-f8d9-cde4-6cc5-f523e4973c3b@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:07:29 +0200
Message-ID: <CACRpkdZRQq3EbibSWcKnTp6+iFJACeaytQEX+zR69Y_4LMSkYg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: initialise nsp-mux earlier.
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 6:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 6/30/2020 9:37 PM, Mark Tomlinson wrote:

> > That was one of my thoughts too. I found someone had tried that
> > earlier, but it was rejected:
> >
> >
> > https://patchwork.ozlabs.org/project/linux-gpio/patch/1516566774-1786-1-git-send-email-david@lechnology.com/
>
> clk or reset APIs do not complain loudly on EPROBE_DEFER, it seems to me
> that GPIO should follow here. Also, it does look like Linus was in
> agreement in the end, not sure why it was not applied though.

I never got an updated patch. My last message was:

>> so you mean something like this?
>>
>> if (err == -EPROBE_DEFER)
>>         dev_info(dev, "deferring probe\n")
>> else
>>         dev_err(dev, "... failed to register\n")
>
> Yes exactly.

Patches welcome :D

Yours,
Linus Walleij
