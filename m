Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D931C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AB620707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EAnJcYHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAaVnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:43:20 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43378 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgAaVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:43:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id o42so3128220uad.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77iC328Ix55f8VFyzEfO2GMt08mqvFscC4bjbzzCOZU=;
        b=EAnJcYHOR3ksx1xu/pw65w6JGYMh2xej0Mc4zDb3jtP78rR15ykv/sZtF0FkjJbSak
         b37qkQE2D14Y3z8vOROlg2MYyd005jIT3q29AlSTbjIBx/pCRxYehOaJ/wQjimcgSSxe
         6M65uD4rgYGAFuPGbXKpa7AjCV3oL5q6ZOezM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77iC328Ix55f8VFyzEfO2GMt08mqvFscC4bjbzzCOZU=;
        b=C3WiiQI9LrokOs9WripCFEQAHImgt+YgB21Ab8ZGjFnJbTjsZLfgxzHC/B+jwPnMun
         EGGLeohh0nIgRvU2YG+jOdHCAckUhWlyQtEPq+kzvMg1DRJ+YDa458a0r35vUvukDrAQ
         rvlk8P0JQHYXic0YccUlAYYAaJQg61S3GECNT5/GuZZKURp6i82wj/Lt/2Uo5vPLfWAf
         4h0ZgureDVDV7/jI6dKTBRnaNBKme5Jas38LDEX20CRowtGQ6751w1Uab0j2guZfpw+L
         B2+f47wahrkoLrF1aBDL7AJROKqaqh62JORZR7AcgQrKtXBQgSxDsjPZczvtXIzdvGD9
         DuFw==
X-Gm-Message-State: APjAAAWHyQxCC2CnTgLIxbciQuWw3R5zTNlxS0KN50Gi2xMk3VCuMigS
        iRQwPboMfbIvnGdCZzU+jzpo/A3wl84=
X-Google-Smtp-Source: APXvYqw9rPG2z72AG13xV0J2FugeHf2uyEx7QDNZl3lJKhD5FpaV7a3HzFxWLWmcQ4I70iYbGFLfug==
X-Received: by 2002:ab0:2150:: with SMTP id t16mr7224932ual.61.1580506998777;
        Fri, 31 Jan 2020 13:43:18 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id n10sm665698vsm.0.2020.01.31.13.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 13:43:17 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id l6so3115046uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:43:17 -0800 (PST)
X-Received: by 2002:ab0:724c:: with SMTP id d12mr7797680uap.0.1580506997224;
 Fri, 31 Jan 2020 13:43:17 -0800 (PST)
MIME-Version: 1.0
References: <1580472220-3453-1-git-send-email-smasetty@codeaurora.org> <1580472220-3453-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1580472220-3453-2-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 Jan 2020 13:43:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJF4KworkHFLoNtxB7d+VyGqZSZkDUdie+09ur1g5thw@mail.gmail.com>
Message-ID: <CAD=FV=XJF4KworkHFLoNtxB7d+VyGqZSZkDUdie+09ur1g5thw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 31, 2020 at 4:04 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> +               adreno_smmu: iommu@5040000 {
> +                       compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";
> +                       reg = <0 0x05040000 0 0x10000>;
> +                       #iommu-cells = <1>;
> +                       #global-interrupts = <2>;
> +                       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
> +                                       <GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +                               <&gcc GCC_GPU_CFG_AHB_CLK>,
> +                               <&gcc GCC_DDRSS_GPU_AXI_CLK>;
> +
> +                       clock-names = "bus", "iface", "mem_iface_clk";

Repeated comment from v2 feedback:

Please send a patch to:

Documentation/devicetree/bindings/iommu/arm,smmu.yaml

...adding 'qcom,sc7180-smmu-v2'.  If you do this it will point out
that you've added a new clock: "mem_iface_clk".  Is this truly a new
clock in sc7180 compared to previous IOMMUs?  ...or is it not really
needed?


> +               gmu: gmu@506a000 {
> +                       compatible="qcom,adreno-gmu-618.0", "qcom,adreno-gmu";
> +                       reg = <0 0x0506a000 0 0x31000>, <0 0x0b290000 0 0x10000>,
> +                               <0 0x0b490000 0 0x10000>;
> +                       reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> +                       interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +                                  <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hfi", "gmu";
> +                       clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +                              <&gpucc GPU_CC_CXO_CLK>,
> +                              <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +                              <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> +                       clock-names = "gmu", "cxo", "axi", "memnoc";
> +                       power-domains = <&gpucc CX_GDSC>;
> +                       power-domain-names = "cx";

As per continued comments on v2, please see if this works for you:

  power-domains = <&gpucc CX_GDSC>, <0>;
  power-domain-names = "cx", "gx";

...and work to get something more real for "gx" ASAP.  It did seem to
boot for me and (unless someone disagrees) it seems better than
totally leaving it out / violating the bindings?


-Doug
