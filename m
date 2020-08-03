Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F022C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B8B2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="c/rMlTX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgHCOWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:22:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1CBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:22:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so35269243qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6U3fsmoRxsdzTrGF6+v9nKYi2wiEIz1y0w1GdZEAgg=;
        b=c/rMlTX+pF6DK6cNfyzRR5HU0imloK+lrQAGqCCO6KFukqa/DOaBBJ7ijihiEJHzUK
         Uh/tdNJ2H/Xs0VbunlCTw8cW1sCiVImy+oifN5UTi/TdhJxb6gCwWDhXCf6BF8usd5Sf
         mqECCzILP1BjGuZkgyEvCEOGQuJGzRyqbV/zCcAxJu9WQYNcBWzN+bqa1KZf9qyoH6RR
         zhhRYTwF75PNg0gYm2tVKVXxoy8lE1gQz+wBI/idkkZ0QdzlTZgzpwanuuggQPScxu+c
         qb1C4xHtXgP2HWSrtMCDNtX22U0WpvctYjQiANkSKfZQsXpuK+FV0myoNFx+dTXcKupY
         RUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6U3fsmoRxsdzTrGF6+v9nKYi2wiEIz1y0w1GdZEAgg=;
        b=a6S2J28XGcJe5Tp09t9rjfGdNfUbqxT/Wf/KJJL9eyatF8SSCW+FALw+gSj6l6PdB8
         DzqzEbvafUjNE15MLcFcVo5RLMk8cCK8TMo79FuMcuHFrF02OETWOfitCruah8E7R+O1
         NWSsQvdx4LYftD+Y+ys81IzZreEE4vlUBiAZxQzgvH+fxnIOQbYaVbvEyXi6NYwhiKFj
         7nuORlqXWEmT2S55shZCafnSQX5TTMU9Iqv4q5ua8pjTmKg4SSIvJCG1hiErax5a96t5
         XQeTPkL9gLcefkFCCHm8GjqAMQr+HKggDDp7CfAZrGzq6/yQ/ZjFUY4n1PsKiXfkaoij
         Rpkw==
X-Gm-Message-State: AOAM530oV4LmwltYkwHa0PZZsU5tVy6WBQETMK0XDP4WbV+b5zZCZORb
        A8i+tDSBhH+aehPNAYk3k4MquPm2j+4curVZq3ay7w==
X-Google-Smtp-Source: ABdhPJxWIhpgMAjpjcjBBv4+U86NToUZpwQ7ZtnsSHKtMLJZOo/QaHcUs4SfUM0rBxsiNuYhy/wgovHJ5os+SSsWH9Q=
X-Received: by 2002:a37:b6c5:: with SMTP id g188mr15413581qkf.1.1596464530649;
 Mon, 03 Aug 2020 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200803134449.72502-1-daniel.gutson@eclypsium.com> <CAK8P3a0rZi9hBsA6+YQCpCdYj6uY6z+cfVVi37jY1aNx7B5iTQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0rZi9hBsA6+YQCpCdYj6uY6z+cfVVi37jY1aNx7B5iTQ@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 3 Aug 2020 11:21:59 -0300
Message-ID: <CAFmMkTGTX=NwpRKcTTkQN2S6LEWkvMzpL7eCHK99HgC_giNgUg@mail.gmail.com>
Subject: Re: [PATCH] Remove attempt by intel-spi-pci to turn the SPI flash
 chip writeable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 3, 2020 at 3:45 PM Daniel Gutson
> <daniel.gutson@eclypsium.com> wrote:
>
> > However, this flag applies only for a number of devices, coming from the
> > platform driver, whereas the devices detected through the PCI driver
> > (intel-spi-pci) are not subject to this check since the configuration
> > takes place in intel-spi-pci which doesn't have an argument.
>
> This part of the description sounds wrong: the current behavior is that
> the BIOS setting is ignored for PCI devices and it only uses the module
> parameter, the same way as it does for the platform driver.

Actually, the BIOS setting is not ignored, since it is not bypassable.
There is a lock in the BIOS setting, that, if enabled no matter what the
driver does, it will be still read only. However, if that lock is not set,
the SPI chip will be writable because of the driver. That's why
I say 'attempts'.
The intel-spi-pci driver doesn't have a module parameter, and that's
why it unconditionally attempts to turn the chip writable (it will succeed
if it is not locked).
What I did was just left the intel-spi-pci driver without any module parameter,
as it currently is, but removed the part where it attempts to turn the chip
writable (just in case the BIOS is not locked).

>
> With your patch, both the BIOS setting and the module parameter
> have to explicitly allow writing on PCI devices, while at least for Bay
> Trail platform devices the BIOS write protection is still ignored.
>
> It sounds like this is what you want, but you should update the description
> accordingly.
>
>       Arnd



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
