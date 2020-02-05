Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8572C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A1F21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuyExxOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBETTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:19:47 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39234 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBETTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:19:47 -0500
Received: by mail-vs1-f65.google.com with SMTP id p14so2113824vsq.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mevmQ6k3Ihmv8r7EI3IwBN79KI6v2gp2UE5ATwyofr0=;
        b=BuyExxOHNOnGw0g31bLqy0gVGWAXxG3djserMGkbzccG82zvt+a2/8Sqzj9jTg+Asa
         2upuVHfTuyxd4DU4e3VS+64pnwjwhNe/J8UtYPtwP/hwbQ2Of2yNZIjQyTe42b6laPAb
         Oa7DZNT5TuIoIpdt1rU89W3v4zmQUoQWR0r1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mevmQ6k3Ihmv8r7EI3IwBN79KI6v2gp2UE5ATwyofr0=;
        b=Svk7I0GgQF5CSmXpOZp98udgd8FnO0vn31D0O0veaSi8GffgScRwcOcJZwtMX4HhzC
         JTfgmwFNvpy/MnvIuQNrMi9lL28NxhP4iGAzegFmfoeGHTOLEQcd7XlxkrnyjjVW8lMf
         n1k90Q9KbYnTlvKZ99+rX1mwJtg5Gx4Acka2t2YsPopRaibxx998jDxud6UG08u9yA5Y
         z9/JF42PifpwBKUsOYfnLTddnBIWbGTGUYpdw4Dk9+VhF4J4bvd9zRxCXeOJXRF3ehsA
         TD4m9xp8tz81M9LQH4tGtyDblHetdFKZ/vHNwkud1Fnm4s0QbWQGV9zKs84aEspifzVR
         +Tjg==
X-Gm-Message-State: APjAAAVF4Ebl3VFMfHbrh9uTKT/oK4CWNveWhnc07smVXDIBs5Cp0GgG
        lPanK4KxtKc92AyePxPDTocR32KPbe8=
X-Google-Smtp-Source: APXvYqwcmYqh7DR+FdXeu4AHhVrKj1bDV/OBhEtdMOw354h0O/vuEEEMqaG8PW1eRvMhXnWhm3ow0w==
X-Received: by 2002:a05:6102:3105:: with SMTP id e5mr11651252vsh.133.1580930385998;
        Wed, 05 Feb 2020 11:19:45 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id p78sm271892vkf.0.2020.02.05.11.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 11:19:45 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id l6so1274315uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:19:44 -0800 (PST)
X-Received: by 2002:a9f:300a:: with SMTP id h10mr14335806uab.91.1580930384495;
 Wed, 05 Feb 2020 11:19:44 -0800 (PST)
MIME-Version: 1.0
References: <1580886097-6312-1-git-send-email-smasetty@codeaurora.org> <1580886097-6312-4-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1580886097-6312-4-git-send-email-smasetty@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Feb 2020 11:19:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UEQ0mOXuDrSZrcJ8g6jb0eLf1Ttn+Mn7T6d2TpCMUcuA@mail.gmail.com>
Message-ID: <CAD=FV=UEQ0mOXuDrSZrcJ8g6jb0eLf1Ttn+Mn7T6d2TpCMUcuA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
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

On Tue, Feb 4, 2020 at 11:02 PM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch adds the required dt nodes and properties
> to enabled A618 GPU.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f3fcc5c..63fff15 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1043,6 +1043,108 @@
>                         };
>                 };
>
> +               gpu: gpu@5000000 {
> +                       compatible = "qcom,adreno-618.0", "qcom,adreno";
> +                       #stream-id-cells = <16>;
> +                       reg = <0 0x05000000 0 0x40000>, <0 0x0509e000 0 0x1000>,
> +                               <0 0x05061000 0 0x800>;
> +                       reg-names = "kgsl_3d0_reg_memory", "cx_mem", "cx_dbgc";
> +                       interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +                       iommus = <&adreno_smmu 0>;
> +                       operating-points-v2 = <&gpu_opp_table>;
> +                       qcom,gmu = <&gmu>;
> +
> +                       gpu_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-800000000 {
> +                                       opp-hz = /bits/ 64 <800000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +                               };
> +
> +                               opp-650000000 {
> +                                       opp-hz = /bits/ 64 <650000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +                               };
> +
> +                               opp-565000000 {
> +                                       opp-hz = /bits/ 64 <565000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +                               };
> +
> +                               opp-430000000 {
> +                                       opp-hz = /bits/ 64 <430000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +                               };
> +
> +                               opp-355000000 {
> +                                       opp-hz = /bits/ 64 <355000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +                               };
> +
> +                               opp-267000000 {
> +                                       opp-hz = /bits/ 64 <267000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +                               };
> +
> +                               opp-180000000 {
> +                                       opp-hz = /bits/ 64 <180000000>;
> +                                       opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +                               };
> +                       };
> +               };
> +
> +               adreno_smmu: iommu@5040000 {
> +                       compatible = "qcom,sc7180-smmu-v2", "qcom,smmu-v2";

As per prior discussion "qcom,sc7180-smmu-v2" needs to be added to the bindings.


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

As per discussion in v3 [1], "mem_iface_clk" is new and needs to be
added to the bindings. Presumably that patch should be posted / Acked
by Rob before we land this dts.

Other than relying on un-posted bindings, this looks sane to me and
this patch lets me bring the GPU up on my sc7180-based board.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug

[1] https://lore.kernel.org/r/1e29097cc1cdf18671379f6420f872b0@codeaurora.org
