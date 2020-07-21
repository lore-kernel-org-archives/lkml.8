Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33565C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073812065F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw/h84t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgGUPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:23:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3651C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:23:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so21595025wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjr3hOmDcg0k+YJ+y9Vtua3YshVZwwPlHwMwMv1uMsg=;
        b=gw/h84t5RF8NJH72MgGhtMzcUPSl1FhrUrxZuEUVe+HFrO/xYwk3WfJ/vOlKnLJkY7
         b4fTHfPO4xH0esscUx8Wg1xqeaR185DFKcMnj7eLHf7eXnbQ5S2zjcqCCMrNqXrg4uxa
         kT4X1yvYHYvfR945jIKeVPfiklyIwUG5TwbgaapycBoGncCf/OG6X5Co8pPeXJJq1GDF
         BZ29GRpQ0MdNJII58imEhBewYsjc+MACMoruSBon8h3eI0J2FPLJClOB8s422EOKPbUh
         Sd/Fgrj1yMGJIYdZZ88CUM/vABZ0Z6OW3ZCOYDIs6DS/2EoOiteHYS/s0p6lQw6tb3tN
         9KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjr3hOmDcg0k+YJ+y9Vtua3YshVZwwPlHwMwMv1uMsg=;
        b=a9tgbx42H+Fe6amDYCNzQGALlgIMmTmD2P84qVy7220sFhf+CxBRlE3Yq5yvQXZc24
         brWgBJYJNreTtvy71QeSgD4CygMA53EhoeoPJT2rBudiROM+axIcilWlfz0QtT7BN8UF
         +ylDWPSrToQqAB74F2T+idmjhqzVVj6LUicNR2Kek7R+F6Q5o3JlJ7KDsZ5/9mHdwe3C
         nHZEcCfxTZT95/BJi/I7e7tVEObv9fKFzGcX3bJzCItCYPsGzqPNRhdaRWwZkwqCuyKv
         Tnvc4Fx1fDbakBv3jRQP2tbWiP0lhBxGLEHR161hzYzkPql6Ya91bTYo8zYgtaDpel2C
         hRog==
X-Gm-Message-State: AOAM533a4Av98+MwRvuWpzVPlWrZlNeJCoXMAiev/yxy8G/GEtaoCNVu
        pQGUHbVVFJcTWihWfNlVYr92jYRzhMrf8kAvnaDrh/KyjTM=
X-Google-Smtp-Source: ABdhPJyZ2CYgqXoWpElRrDtFpve+aiQv8d5QjtVAfAUkHJ/Bn2wBT3fAyyIyfFVyQZSWnsx2/lT6LwQYCsvPyqnIT4M=
X-Received: by 2002:adf:fc06:: with SMTP id i6mr8845332wrr.79.1595344980632;
 Tue, 21 Jul 2020 08:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200708164936.9340-1-nsaenzjulienne@suse.de> <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
 <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de> <CAMi1Hd2V2pJjP=USS4r-Z3vK-aq7_aBy-jcVNk1GvbdEQAuzWg@mail.gmail.com>
 <011994f8a717a00dcd9ed7682a1ddeb421c2c43f.camel@suse.de> <CAMi1Hd0=ZsGhTkSy221EP9Vb3GMOcS0UMczX2u5X9qK37_ea1A@mail.gmail.com>
 <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
In-Reply-To: <01831596e4a2a6c9c066138b23bd30435f8e5569.camel@suse.de>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Jul 2020 20:52:24 +0530
Message-ID: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
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

On Tue, 21 Jul 2020 at 18:15, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-07-21 at 17:45 +0530, Amit Pundir wrote:
> > On Tue, 21 Jul 2020 at 16:45, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Tue, 2020-07-21 at 14:24 +0530, Amit Pundir wrote:
> > > > On Tue, 21 Jul 2020 at 14:09, Nicolas Saenz Julienne
> > > > <nsaenzjulienne@suse.de> wrote:
> > > > > Hi Amit,
> > > > > > Hi Nicolas,
> > > > > >
> > > > > > I see a boot regression with this commit d9765e41d8e9 "dma-
> > > > > > pool:
> > > > > > Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> > > > > > (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> > > > > > bootloader splash screen with this patch.
> > > > > >
> > > > > > Phone boots fine if I revert this patch. I carry only one out
> > > > > > of
> > > > > > tree
> > > > > > dts patch https://lkml.org/lkml/2020/6/25/52. And since this
> > > > > > is a
> > > > > > stock
> > > > > > phone, I don't have access to serial/dmesg logs until I boot
> > > > > > to
> > > > > > AOSP
> > > > > > (adb) shell.
> > > > > >
> > > > > > Any thoughts as to what might be going wrong here? I'd be
> > > > > > happy
> > > > > > to
> > > > > > help debug things. For what it's worth, I don't see this
> > > > > > regression
> > > > > > on
> > > > > > other two sdm845 devices (db845c and Pixel 3) I tested on.
> > > > >
> > > > > Can you provide a boot log (even if without my patch) and the
> > > > > device-
> > > > > tree files? It'd help a lot figuring things out.
> > > >
> > > > Thank you for the prompt reply Nicolas.
> > > >
> > > > Here is the boot log with the reverted patch
> > > > https://pastebin.ubuntu.com/p/BrhPf83nKF/
> > > >
> > > > Here is my phone's dts
> > > > https://github.com/pundiramit/linux/commit/2a394c199deeaf4c91e0e008e8fba2a72f494d8c
> > >
> > > I'm at loss at what could be failing here. Your device should be
> > > able
> > > to address the whole 8GB memory space, which AFAIK is the max
> > > available
> > > on that smartphone family. But maybe the device-tree is lying, who
> > > knows...
> >
> > If it helps, my phone has 6GB memory space.
> >
> > > Can you try booting *without* my patch and this in the kernel
> > > command
> > > line: "cma=16M@0x100000000-0x200000000".
> >
> > It doesn't boot with this added kernel command line.
>
>
> For the record, this placed the CMA in the [4GB, 8GB] address space
> instead of you setup's default: [3GB, 4GB]. All atomic pools fall in
> that memory area without my patch, which makes me think some of the
> devices on your board might not like higher addresses.
>

Thank you Nicolas for the details. Though we don't set the CMA
alloc-ranges explicitly in upstream sdm845 dts, but I dug around and
found that CMA alloc-ranges in the downstream kernel are indeed in
lower address space.
https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/dipper-q-oss/arch/arm64/boot/dts/qcom/sdm845.dtsi#L662

/* global autoconfigured region for contiguous allocations */
linux,cma {
        compatible = "shared-dma-pool";
        alloc-ranges = <0 0x00000000 0 0xffffffff>;
        reusable;
        alignment = <0 0x400000>;
        size = <0 0x2000000>;
        linux,cma-default;
};

> What happens if you boot with my troublesome patch with this in your
> device tree? (insert it at the bottom of sdm845-beryllium.dts)
>
> &soc {
>         dma-ranges = <0 0 0 0 0x1 0>;
> };
>

Device still doesn't boot up to adb shell.

Regards,
Amit Pundir

> Regards,
> Nicolas
>
> > Regards,
> > Amit Pundir
> >
> > > Regards,
> > > Nicolas
> > >
> > > And here is my kernel tree just in case
> > > > https://github.com/pundiramit/linux/commits/beryllium-mainline
> > > >
> > > > Regards,
> > > > Amit Pundir
> > > >
> > > >
> > > > > Regards,
> > > > > Nicolas
> > > > >
> > > > > > Regards,
> > > > > > Amit Pundir
> > > > > >
> > > > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > > > Signed-off-by: Nicolas Saenz Julienne <
> > > > > > > nsaenzjulienne@suse.de>
> > > > > > > ---
> > > > > > >
> > > > > > > An more costly alternative would be adding an option to
> > > > > > > dma_alloc_from_contiguous() so it fails when the allocation
> > > > > > > doesn't
> > > > > > > fall
> > > > > > > in a specific zone.
> > > > > > >
> > > > > > >  kernel/dma/pool.c | 11 ++---------
>
