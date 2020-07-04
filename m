Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D095C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6532920870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiWxA3m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGDK2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGDK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:28:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55EC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 03:28:51 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a6so12410401ilq.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 03:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6MVUUUiUZ/bhtH2VAQ03gjFBPUDLQ1YkvRus2a1Mlo=;
        b=XiWxA3m31JFaQ+mz5kCbQf2IwRGT6mUu1B/lZblRXRO8IlLsbz/OnJy0/frpHJ/CV0
         LIdILgFdp5R0ARxu3Rh4n6BNeCyylUo72QIrg1zKCp0Tb6SDEjonSX4i8UIfwY4cuaKu
         mDiiggfIuCRigMOAV3FNhhMEvKPFhZYOGHgvdWQezTeoayDm9xvl8/T8wWojPAswvqt8
         osbSGPR52diaqebXjARk2VnefI/2NKhE+DC0yBudXPgoXml5BC21gsPT744DlJl7uPBv
         7mmHdHP/jXe4gA0SliOy1tto4JUr4iX4sQUbpv6D4JgJWZ3IgefHX1mAKaanraTlIEdr
         Nu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6MVUUUiUZ/bhtH2VAQ03gjFBPUDLQ1YkvRus2a1Mlo=;
        b=cS8nkdM8KeyYkJNfKqPpIzYWa7Udy1nfyPXzw9Yz9QKGwcNmyQaIm8edRd35mvIf7a
         k4fBT/e/elVFEpRTEGvCCgEstK9h61OYTdR9Wpo77N4e51v2zwXkFetGlgmMYL0v+6Ef
         l12jutbSL85gBBubYSLgnWcQjePAvE4XfkwjKXKxidFWn/l482ipe2t8xxQK1czhblzA
         Tb5TwCLvlBCd1l3+HKS4I9MVDqAIiRI1N5ga7fs9+Pmg00Nzjfm8UKhiyMDMYwkbyLn4
         pze331KTY4mzDHBMnDcdk6T1sJY9DJsM9jV6vWlNdUhgVPT1A9v6Wn/w5iMRkS8ceYpI
         gz8w==
X-Gm-Message-State: AOAM530NNFq1ChyFBepZoDDxOi3TekU5GAu0LCsSS24edpguWIc36feB
        WNnLuTbNtqOU4RK/M84+WhcmWYoE/1rTgUkOpSs=
X-Google-Smtp-Source: ABdhPJwHCZ64dKNUzlzI7XDW+kwEnMHynN76AwRs4uNaGRVxWWcWCidxkyxY8FZITDR284KtKQEMNNfZTm4vASzNsz8=
X-Received: by 2002:a92:4b08:: with SMTP id m8mr20423899ilg.150.1593858530565;
 Sat, 04 Jul 2020 03:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200704102535.189647-1-peron.clem@gmail.com>
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 4 Jul 2020 12:28:39 +0200
Message-ID: <CAJiuCceE8bMFwyZ5Nf3CxbczDYJZ64UhO=syqcWKc6knpK7sNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Add regulator devfreq support to Panfrost
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 4 Jul 2020 at 12:25, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi,
>
> This serie cleans and adds regulator support to Panfrost devfreq.
> This is mostly based on comment for the freshly introduced lima
> devfreq.
>
> We need to add regulator support because on Allwinner the GPU OPP
> table defines both frequencies and voltages.
>
> First patches [01-07] should not change the actual behavior
> and introduce a proper panfrost_devfreq struct.
>
> Regards,
> Cl=C3=A9ment

Changes since v1:
 - Collect Steven Price reviewed-by tags
 - Fix spinlock comment
 - Drop OPP clock-name path
 - Drop device_property_test patch
 - Add rename error labels patch

>
> Cl=C3=A9ment P=C3=A9ron (14):
>   drm/panfrost: avoid static declaration
>   drm/panfrost: clean headers in devfreq
>   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
>   drm/panfrost: introduce panfrost_devfreq struct
>   drm/panfrost: use spinlock instead of atomic
>   drm/panfrost: properly handle error in probe
>   drm/panfrost: rename error labels in device_init
>   drm/panfrost: move devfreq_init()/fini() in device
>   drm/panfrost: dynamically alloc regulators
>   drm/panfrost: add regulators to devfreq
>   arm64: defconfig: Enable devfreq cooling device
>   arm64: dts: allwinner: h6: Add cooling map for GPU
>   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
>   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
>
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 +++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 165 ++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 +++-
>  drivers/gpu/drm/panfrost/panfrost_device.c    |  61 ++++---
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
>  9 files changed, 290 insertions(+), 109 deletions(-)
>
> --
> 2.25.1
>
