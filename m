Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9771C206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgIwfOLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGUMPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:15:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:15:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so20993122wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cA94sOb8FIWUebxDf9ORKnnfau0NCB40GlOe2QaQBCg=;
        b=CgIwfOLZksxv01U3Ox2GEGHdpWnCJf2DcA0Z30hMqfNdGZGPQqnOTXWRFSEa2cDN59
         Ed7YOlHnYg2vT9nCzGgVDPoHfnIeTnQchaAyDU2lpXTJ2g2knxzsZQCWeU3sF7kCcG0z
         ESICCvgchuKCulzBv9d+6QazxM0cFhDfSTzLetZmj+RcUnNOVUjewbAQOhMQD3DZUSXn
         mtpPRD2pZEHua4CnfLCIOmZkh9a++EJnqBI0deaYFBVGM7vTJj7X+h7kc0CBMoCqHld3
         0S7ZTwemnITiJIPRzuWgA/frR3/wFYPJHP2D2LH9i72VZxj4wQbfAy4F5ANTOLknIZrl
         w8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cA94sOb8FIWUebxDf9ORKnnfau0NCB40GlOe2QaQBCg=;
        b=JnNOkH4ksGB7jAmYOZ/ojtuPv+99m9LxyZyE1iqahpE4w4HLMpn0ZVF4Vpn4mrwSWU
         xsaK8zYTTZK3djrPBrba8uJoyH/0DRHrwj9qNfOSrnMEy0LAZf4/BdR0e4EzuIrzMEo6
         WT5xHdf89OJAaP4d/BSmYlI4NH7Bfo12fG7+yWHuCIy79z7Z+T3Jzo4BcWYR9mQ48IPs
         mFuSO14HxwlDMsW0lrsJKtURJh3scyGBV1moCxTMRcB6Rph+1/0xq+QtFu3ZFpWxzmDh
         oWmZQo+As2t7NvH+9+1W+6z8/d42VD3WjA/0bjNrOOQ88eJBNWkk8rzUx97TZBk3oM3/
         1DaA==
X-Gm-Message-State: AOAM530/vxjQEknfP3/lQHCLVvn3oUexA5FetAh7xyHy8iMHa74JRa8S
        crdT9JtGVdoDg5AYNCGHD9kAa0R2H9IaseOBp9YGAg==
X-Google-Smtp-Source: ABdhPJwW0WH69zD26zuxdyq5u22D6RndDM2fZyyK4TA+BkoXC0YCwHYj75KOg4xS6IYhZgmv0Dl7nJVqj7f2gXXm0Sg=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr8168305wrr.79.1595333739178;
 Tue, 21 Jul 2020 05:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de> <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
In-Reply-To: <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Jul 2020 17:45:02 +0530
Message-ID: <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 at 16:45, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-07-21 at 14:24 +0530, Amit Pundir wrote:
> > On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > Hi Amit,
> > > > Hi Nicolas,
> > > >
> > > > I see a boot regression with this commit d9765e41d8e9 "dma-pool:
> > > > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > > > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > > > bootloader splash screen with this patch.
> > > >
> > > > Phone boots fine if I revert this patch. I carry only one out of
> > > > tree
> > > > dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a
> > > > stock
> > > > phone, I don't have access to serial/dmesg logs until I boot to
> > > > AOSP
> > > > (adb) shell.
> > > >
> > > > Any thoughts as to what might be going wrong here? I'd be happy
> > > > to
> > > > help debug things. For what it's worth, I don't see this
> > > > regression
> > > > on
> > > > other two sdm845 devices (db845c and Pixel 3) I tested on.
> > >
> > > Can you provide a boot log (even if without my patch) and the
> > > device-
> > > tree files? It'd help a lot figuring things out.
> >
> > Thank you for the prompt reply Nicolas.
> >
> > Here is the boot log with the reverted patch
> > https://pastebin.ubuntu.com/p/BrhPf83nKF/
> >
> > Here is my phone's dts
> > https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c
>
> I'm at loss at what could be failing here. Your device should be able
> to address the whole 8GB memory space, which AFAIK is the max available
> on that smartphone family. But maybe the device-tree is lying, who
> knows...

If it helps, my phone has 6GB memory space.

>
> Can you try booting *without* my patch and this in the kernel command
> line: "cma=16M@0x100000000-0x200000000".

It doesn't boot with this added kernel command line.

Regards,
Amit Pundir

>
> Regards,
> Nicolas
>
> And here is my kernel tree just in case
> > https://github.com/pundiramit/linux/commits/beryllium-mainline
> >
> > Regards,
> > Amit Pundir
> >
> >
> > > Regards,
> > > Nicolas
> > >
> > > > Regards,
> > > > Amit Pundir
> > > >
> > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > > ---
> > > > >
> > > > > An more costly alternative would be adding an option to
> > > > > dma_alloc_from_contiguous() so it fails when the allocation
> > > > > doesn't
> > > > > fall
> > > > > in a specific zone.
> > > > >
> > > > >  kernel/dma/pool.c | 11 ++---------
>
