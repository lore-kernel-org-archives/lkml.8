Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D80C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="eK5LMIJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgHDT51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgHDT5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:57:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6989C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:57:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so39638832qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rW2BRGX/Sbv+gGj9FdTRztmdZP7QOIjZDIipDKfRWKE=;
        b=eK5LMIJbJ9NjqaqvVkl+OzCuK4cud6Gd/EYg8VIYsoMyx68onSz/IpWrz0Nw5pEXOP
         cYKwsQO/BGtvqnJlEkwaA5svMn0FErGbplWqNn4nWci/+YGxmqB4bYlIf+ZGlgfRYj7s
         ffrJY5I7NrW+L+4SvFbpeRfb+OqKMFOJw9A5n96XTUqA9dlZTM2Kp9HKdLM2sJO0VdhG
         eILxKvpX3sAKVbj+ufiaprnyfw0xTZ1DyJekpJML4KGnc0mpysYv3wwGfmxseBBSt4VM
         32XLogPbppKD9QrHkbHSXTUcvz9nKCuhwXiFgwtxFahwiGMCyHZlkJ90GJ6T4A7TpiYw
         9nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rW2BRGX/Sbv+gGj9FdTRztmdZP7QOIjZDIipDKfRWKE=;
        b=iE6I/Y4shtqCcM4Rnp7unKt3Gta805lFaBLg+Au6JM+8yTkvO3VznkBESkPLvaOX1j
         A9vRJW3mF6JwTJkvoaUt5XCzcYI9QNejnRDVfEnRo2ERhvMItE/3MDKFHhlGfYi4nZSK
         ui9I42tlOnJI2ItS7FbkHeVb1m5AkKbOzCOiJF6pq+ifaJsAVyXxHVTvb6G2euJ8V8w2
         2n0/2jhl/7Onu/z5I1uwpdNagKIzlRtwYY6SzZsXcJ8a/NarLjUPqozvbyyUs8WVcdoc
         Sx0Xq/pf99pL6/AOG+c44BqNt/iKtMqBR18MdRSjjB8UUKyEey3btYZNBKjCYncb0ucV
         z3JA==
X-Gm-Message-State: AOAM532pkFj2dIuwxJu9lkdMNZXQXUL/+vecHFdIhiZ1/HfPo8S4tMyN
        fY86rHwwN1sF4audgpONoNvTu4X1Poh54Enhvh/iSw==
X-Google-Smtp-Source: ABdhPJwfUyTmi7+YxwDcFb9y4O5WFQe1gX8+zuoljzZScW7TDgKuw4P0Shm+c9asxfdUTewciSF0Df1bxydY8BKpBUk=
X-Received: by 2002:a37:9f0a:: with SMTP id i10mr23651469qke.368.1596571042691;
 Tue, 04 Aug 2020 12:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com> <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
In-Reply-To: <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 4 Aug 2020 16:57:11 -0300
Message-ID: <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
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

On Tue, Aug 4, 2020 at 4:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 4, 2020 at 5:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > On Tue, Aug 4, 2020 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
> >> <daniel.gutson@eclypsium.com> wrote:
> >> >
> >> > Context, the intel-spi has a module argument that controls
> >> > whether the driver attempts to turn the SPI flash chip writeable.
> >> > The default value is FALSE (don't try to make it writeable).
> >> > However, this flag applies only for a number of devices, coming from the
> >> > platform driver, whereas the devices detected through the PCI driver
> >> > (intel-spi-pci) are not subject to this check since the configuration
> >> > takes place in intel-spi-pci which doesn't have an argument.
> >>
> >> This is still factually incorrect, as explained at least three times
> >> now.
> >>
> >> Please either make the same change for both the Bay Trail
> >> platform driver and the PCI driver, or explain why you want them to
> >> be different rather than incorrectly claiming that you change them to
> >> be the same.
> >
> >
> > What about just saying
> >
> > "This patch removes the attempt by the intel-spi-pci driver to
> > make the chip always writable."
>
> Yes, that is much better, though it still sounds like it would at the
> moment allow writing to the device from software without also
> setting the module parameter. I would say something like
>
> "Disallow overriding the write protection in the PCI driver
> with a module parameter and instead honor the current
> state of the write protection as set by the firmware."

But wait, Mika, the author of the file, asked earlier not to remove
the module parameter of intel-spi,
and just remove the unconditional attempt to turn the chip writable in
intle-spi-pci.
So I'm not touching intel-pci, just removing that code from
intel-spi-pci without adding
a new module parameter.

Are you aligned on this?


>
> (note also: imperative form in the patch description rather than
> "this patch ...").
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
