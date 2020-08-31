Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34DEC208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598882376;
	bh=0ELgDN4DCdbC4neuwarO8uv8nWk+EoaxkCEgogyZFGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TaN1/oEh9YVX+BghVNTiav/NM042DPVOG7AyM5Ppn/K3Z584CjlYvgG8a05wp9yGK
	 g94w29jzR/+bzKa/c00MNXM2glO+O7z4bvfuUHeQBP42IWf0X+2tNLwbpHLjDsEL5A
	 PUHPpxXKskGTcBKwJBWP7JYoT8VQJ6vbbZGg7y/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHaN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgHaN7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:59:21 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD84420936;
        Mon, 31 Aug 2020 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598882361;
        bh=0ELgDN4DCdbC4neuwarO8uv8nWk+EoaxkCEgogyZFGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ut5tovIEHzLSBfa4ieSRCaowAFda6fVXnIF6OfQVSDnQjQqD5u3XBE9ipwjTcLPjA
         8HyTMoS6pX0snp0m/oY5G0zGSFDaK0RFmCmcf26Dx5DV5v/vOXhZ50i8IQcxHCevvO
         yx44Yq7XOmt5yi5Id68//MxfeE2QR2wd+C/OynSU=
Received: by mail-ed1-f44.google.com with SMTP id w1so1906645edr.3;
        Mon, 31 Aug 2020 06:59:20 -0700 (PDT)
X-Gm-Message-State: AOAM532uKRsAsJ8lS8Ey37CFHZaIxYTNDdHJrcDCCsr70rOTAeBT1ajY
        s+EEQUOBrKRaZL4UgCBCAqQ6NFZTn8+i58nuA5I=
X-Google-Smtp-Source: ABdhPJz4mIou6NQDF9GoU0glbeGAVtu339WyqeM8YO5d2GjJ0q1vFCMgP88xGwBXgdcvmJjfHSnIr2cub9+CDPtsrSM=
X-Received: by 2002:a50:fd0b:: with SMTP id i11mr1363872eds.298.1598882359253;
 Mon, 31 Aug 2020 06:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200830135200.24304-1-krzk@kernel.org> <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
 <20200830135200.24304-23-krzk@kernel.org> <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
 <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
 <96651e85-c27f-3167-7b41-2ea051c25c65@kernel.org> <CAJKOXPdF4zzXvYrOiGQM9o=4rrWHvEr=o9aSTuR238dEaiD4cQ@mail.gmail.com>
 <01bb90db-511d-fbf5-d29a-1fba932f0abf@samsung.com>
In-Reply-To: <01bb90db-511d-fbf5-d29a-1fba932f0abf@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Aug 2020 15:59:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd+067DywsEJ=5G4NLPfo9+hrun0qvkrYGAsVepCZC3Jg@mail.gmail.com>
Message-ID: <CAJKOXPd+067DywsEJ=5G4NLPfo9+hrun0qvkrYGAsVepCZC3Jg@mail.gmail.com>
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 15:57, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 31.08.2020 12:42, Krzysztof Kozlowski wrote:
> > On Mon, 31 Aug 2020 at 12:35, Sylwester Nawrocki <snawrocki@kernel.org> wrote:
> >> On 8/31/20 10:38, Krzysztof Kozlowski wrote:
> >>> On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >>>> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
> >>>>> The camera's pinctrl configuration is simply empty and not effective.
> >>>>> Remove it to fix dtbs_check warning:
> >>>>>
> >>>>>     arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
> >>>>>
> >>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>>>
> >>>> I think that this was intentional to properly enable support for
> >>>> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
> >>>> default values if no pinctrl properties are provided. Sylwester, could
> >>>> you comment?
> >>>
> >>> Indeed it could be intentional... I see now errors:
> >>> [   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19
> >>>
> >>> I wonder why getting an empty pinctrl is needed... maybe the driver
> >>> should accept missing pinctrl?
> >>
> >> It might have been better to have the pinctrl properties optional, as there
> >> might be boards without the image sensor attached and FIMC could still be
> >> used in memory-to-memory mode, as Marek pointed out. But it seems too late
> >> now to change that. The binding defines the pinctrl properties as required
> >> (Documentation/devicetree/bindings/media/samsung-fimc.txt) and we need to
> >> keep them in dtses.
> >
> > You can always make a required property optional and it is not a break
> > of ABI. The other way around would be a break. Why then not changing
> > the driver to accept optional pinctrl?
>
> Feel free to send the patch, I would prefer to leave that as is though.
> Is it really suddenly a problem to use an empty property? The pinctrl
> bindings allows it.

The bindings scream:
arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True
is not of type 'array'
so either we should model it differently (not as empty array), update
the driver to make it optional or change the bindings/dtschema. I'll
see how to fix it properly.

Best regards,
Krzysztof
