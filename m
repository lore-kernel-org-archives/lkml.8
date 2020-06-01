Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45617C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B0520842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMwUwSMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgFASpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgFASpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:45:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:45:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f7so10191837ejq.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1VMPDaeJfT8+NmaRje7sflS/Zy0f/09GM/fygivpDo=;
        b=eMwUwSMmFyEn7DmLF4myi59y7ESt2HQDfbtUySBAfQf+MVQoCAq2ISQG8jRaF4we3D
         EDsTMPkk77N3GGd43Kw601vDoU1sLinW5DaqzZqH9oHiGqEB+0a6nTXaw0b055PVIEEV
         NQtwRu5bwRqWwQkLq43ahZjfuqUrc7H5hFtF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1VMPDaeJfT8+NmaRje7sflS/Zy0f/09GM/fygivpDo=;
        b=ZSUZJXxD5pSuMCy4KZu5emwnuUPWTaGp/02AhtCm1iRW17oYXXBSuPj9ALGKZtGX/m
         l0TnMHUMoB86WqZfri44UvPjknM7WQ0Y+XbeakjAhEpOrjpk5ybJsxSkatPBhdejm2uh
         HKHnX9kVj41XIPLsDmYxwCRfSP/shKNKBg9VhguJXvpBi7RD0vhDoxdWdq6ldCom8h7Q
         cLP/BJOJq+WfU4T4nRYhJqhJf51V97cHzJx87pcYUcXde5eN6wJgxtFRkrI/Lzun7M4q
         ElZfZGTB4Hod7+3I2xxKWn43tnlHnQVQX0drSL/sSpQcsx2qvQI1E0Fyw/R99YLHeQcf
         9ggQ==
X-Gm-Message-State: AOAM533dVsMxVcxPeKratlR63GpVegYuU6sms7GnaOs/fkv1Re2pJS3K
        oBS0uzQMAmcOw/O6Eh2LEwW8PJbRk/laLw==
X-Google-Smtp-Source: ABdhPJx1PWL7KBlrTdeU6BF+X7fko9ipCpCiO9IvwffBouQasH4zw+PfzuqUVhe9yjVeX9MghmlTCg==
X-Received: by 2002:a17:906:e0cf:: with SMTP id gl15mr6519669ejb.501.1591037128894;
        Mon, 01 Jun 2020 11:45:28 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id h10sm356751ejb.2.2020.06.01.11.45.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 11:45:28 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c71so487999wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:45:27 -0700 (PDT)
X-Received: by 2002:a7b:c622:: with SMTP id p2mr581952wmk.55.1591037127078;
 Mon, 01 Jun 2020 11:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200529130405.929429-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20200529130405.929429-1-maxime.chevallier@bootlin.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 1 Jun 2020 20:45:14 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AVD+LhYZziqNUfga1sCp98MMu+ESgBMagS1n6++ae=pg@mail.gmail.com>
Message-ID: <CAAFQd5AVD+LhYZziqNUfga1sCp98MMu+ESgBMagS1n6++ae=pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] media: rockchip: Introduce driver for the camera
 interface on PX30
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Helen Koike <helen.koike@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, May 29, 2020 at 3:04 PM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hello everyone,
>
> Here's a V2 of the series adding very basic support for the camera interface on
> the Rockchip PX30 SoC.
>
> Thanks to everyone that commented on the first series, your reviews were
> very helpful :)
>
> This Camera Interface is also supported on other Rockchip SoC such as
> the RK1808, RK3128, RK3288 and RK3288, but for now I've only been able to
> test it on the PX30, using a PAL format.

How does this hardware relate to the one handled by the rkisp1 driver
that is available under staging/media/rkisp1? It was written with
RK3399 in mind, but I have a loose recollection that the hardware in
RK3288 was roughly the same.

+Helen Koike +Dafna Hirschfeld working on the rkisp1 driver.

Best regards,
Tomasz

>
> This driver is mostly based on the driver found in Rockchip's BSP, that
> has been trimmed down to support the set of features that I was able to test,
> that is pretty much a very basic one-frame capture and video streaming
> with GStreamer.
>
> This first draft only supports the Parallel interface, although the
> controller has support for BT656 and CSI2.
>
> Finally, this controller has an iommu that could be used in this driver,
> but as of today I've not been able to get it to work.
>
> Any review is welcome.
>
> Thanks,
>
> Maxime
>
> --- Changes since V1 ---
>
>  - Took reviews from Rob, Hans, Robin and Heiko into account :
>   - Renamed the clocks in the binding
>   - Fixed the DT schema compiling
>   - Fixed a few typos
>   - Used the clk bulk API
>   - Used the reset array API
>   - Changed a few helpers for more suitable ones
>   - Rebased on 5.7-rc7
>
>
>
> Maxime Chevallier (3):
>   media: dt-bindings: media: Document Rockchip CIF bindings
>   media: rockchip: Introduce driver for Rockhip's camera interface
>   arm64: dts: rockchip: Add the camera interface description of the PX30
>
>  .../bindings/media/rockchip-cif.yaml          |  100 ++
>  arch/arm64/boot/dts/rockchip/px30.dtsi        |   12 +
>  drivers/media/platform/Kconfig                |   13 +
>  drivers/media/platform/Makefile               |    1 +
>  drivers/media/platform/rockchip/cif/Makefile  |    3 +
>  drivers/media/platform/rockchip/cif/capture.c | 1170 +++++++++++++++++
>  drivers/media/platform/rockchip/cif/dev.c     |  358 +++++
>  drivers/media/platform/rockchip/cif/dev.h     |  213 +++
>  drivers/media/platform/rockchip/cif/regs.h    |  256 ++++
>  9 files changed, 2126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip-cif.yaml
>  create mode 100644 drivers/media/platform/rockchip/cif/Makefile
>  create mode 100644 drivers/media/platform/rockchip/cif/capture.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.c
>  create mode 100644 drivers/media/platform/rockchip/cif/dev.h
>  create mode 100644 drivers/media/platform/rockchip/cif/regs.h
>
> --
> 2.25.4
>
