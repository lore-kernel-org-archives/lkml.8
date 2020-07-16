Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8842C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8274F2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHBUTi0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgGPSFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgGPSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:05:50 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B458C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:05:50 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j186so3490762vsd.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LJXcaiErt+0IC9WAhFqF+PgHD+Xfmr3j77sKRGuw00=;
        b=fHBUTi0o7R2ZDnjv7Bf840urtxXMHNAU19jmAKkxEYrc6Pk78KckWPlezDehMCs/1Q
         hxxgx33laG/g8T4dGc3fZblx3pRHNmBqLsxNbFwE/ZExYBRbTifNAI03v5WghgHjWt30
         Hxtcg186Z3dmy5Srwbn3Z6rUdC3iK3KE0li2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LJXcaiErt+0IC9WAhFqF+PgHD+Xfmr3j77sKRGuw00=;
        b=p20ZMB2wlrqNdKvZOq23grmATLWvf+dzlPaj6K2eQsaoUYzSYZvSHoUfi8UGp6RSee
         7pO4fxGCLl7mmRYdEk/mmolaojbwmI+fqG13m4l503LC9mwkfKupg7M561uOXaH4l1M5
         MSHMf8lgsl92mtNnnpGxHAMF0/voeq1M8+ucDv8HYU+RQU2nRQs243F1l6/5ArMwXxGE
         CtJDfQZl0mDak1VGcUV6ZHHSf1Fkv4Ope7gTazBl43ByYl+QaFAqhKJv+kwGpZy8+Ypx
         YDUsrdv3Okthg9qXjDusSUoFaJxjwtM+zxJJcoktqI53Atvb0nuSsAVGDnKXEQx6xsjJ
         c2kw==
X-Gm-Message-State: AOAM531Ne1dcF6owRbmQnOzRklIsrc42KHUXV03GrTPbVMSuUBcpMLAY
        1lhs0lJPpvddjZ3wjhoV1NiIr9JB0vQ=
X-Google-Smtp-Source: ABdhPJw87V5CCY6CNHvEKBgT5t7yUL4sNJEMFeQNWv+DGuFQpfrMLzHUvv4+dFJGgj/H7/XwZcf5Sg==
X-Received: by 2002:a67:7fd5:: with SMTP id a204mr4164494vsd.97.1594922748831;
        Thu, 16 Jul 2020 11:05:48 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id v9sm668536vsi.4.2020.07.16.11.05.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 11:05:47 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id b24so2057847uak.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:05:46 -0700 (PDT)
X-Received: by 2002:ab0:486d:: with SMTP id c42mr4460815uad.64.1594922746099;
 Thu, 16 Jul 2020 11:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200716061445.628709-1-cychiang@chromium.org>
In-Reply-To: <20200716061445.628709-1-cychiang@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Jul 2020 11:05:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U6oStCh3kyoM-jLEsRrYgnKvUNiQFOqxXm409gDUhcGA@mail.gmail.com>
Message-ID: <CAD=FV=U6oStCh3kyoM-jLEsRrYgnKvUNiQFOqxXm409gDUhcGA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add lpass cpu node for I2S driver
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ajit Pandey <ajitp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 15, 2020 at 11:14 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> From: Ajit Pandey <ajitp@codeaurora.org>
>
> Add the I2S controller node to sc7180 dtsi.
> Add pinmux for pirmary and secondary I2S.

s/pirmary/primary

>
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
> This patch depends on these patch series so it is not ready to be merged now.
> - clk: qcom: Support for Low Power Audio Clocks on SC7180 https://patchwork.kernel.org/cover/11664273/
> - arm64: dts: qcom: sc7180: Add LPASS clock controller nodes https://patchwork.kernel.org/patch/11664303/
> - ASoC: qcom: Add support for SC7180 lpass variant https://patchwork.kernel.org/cover/11650649/

Thanks for pointing out the dependencies!


>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 132 +++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)

My review is a bit rote since I don't actually know anything about
audio.  This is mostly just a dt-hygiene review.


> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 6eb14b6a47f5..2fe3bd89f950 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -511,6 +511,34 @@ qusb2p_hstx_trim: hstx-trim-primary@25b {
>                         };
>                 };
>
> +               lpass_cpu: lpass {

Missing unit address and also sorted incorrectly.  Nodes should be
sorted by unit address.


> +                       compatible = "qcom,lpass-cpu-sc7180";

Is there a pin config that generally makes sense for all boards?  If
so, you can add it here so it doesn't need to be added to all
sub-boards.


> +                       reg = <0 0x62F00000 0 0x29000>;

nit: lower case hex for reg address, so 62f not 62F.


> +                       reg-names = "lpass-lpaif";
> +
> +                       iommus = <&apps_smmu 0x1020 0>;
> +
> +                       power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
> +
> +                       status = "disabled";
> +
> +                       clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
> +                                <&lpasscc LPASS_AUDIO_CORE_CORE_CLK>,
> +                                <&lpasscc LPASS_AUDIO_CORE_EXT_MCLK0_CLK>,
> +                                <&lpasscc LPASS_AUDIO_CORE_SYSNOC_MPORT_CORE_CLK>,
> +                                <&lpasscc LPASS_AUDIO_CORE_LPAIF_PRI_IBIT_CLK>,
> +                                <&lpasscc LPASS_AUDIO_CORE_LPAIF_SEC_IBIT_CLK>;
> +
> +                       clock-names = "noc", "audio-core", "mclk0", "sysnoc_mport",
> +                                     "pri_ibit", "sec_ibit";
> +
> +                       #sound-dai-cells = <1>;
> +
> +                       interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;

First entry of interrupts should be GIC_SPI, which is what 0 is referring to.


> +                       interrupt-names = "lpass-irq-lpaif";
> +               };

Bindings claim you're supposed to have:

#address-cells = <1>;
#size-cells = <0>;

Do you not need them for some reason?


>                 sdhc_1: sdhci@7c4000 {
>                         compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
>                         reg = <0 0x7c4000 0 0x1000>,
> @@ -1357,6 +1385,110 @@ pinmux {
>                                 };
>                         };
>
> +                       sec_mi2s_active: sec-mi2s-active {
> +                               pinmux {
> +                                       pins = "gpio49";
> +                                       function = "mi2s_1";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio49";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       sec_mi2s_ws_active: sec-mi2s-ws-active {
> +                               pinmux {
> +                                       pins = "gpio50";
> +                                       function = "mi2s_1";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio50";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       sec_mi2s_dout_active: sec-mi2s-dout-active {
> +                               pinmux {
> +                                       pins = "gpio51";
> +                                       function = "mi2s_1";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio51";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       pri_mi2s_active: pri-mi2s-active {
> +                               pinmux {
> +                                       pins = "gpio53";
> +                                       function = "mi2s_0";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio53";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       pri_mi2s_ws_active: pri-mi2s-ws-active {
> +                               pinmux {
> +                                       pins = "gpio54";
> +                                       function = "mi2s_0";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio54";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       pri_mi2s_dout_active: pri-mi2s-dout-active {
> +                               pinmux {
> +                                       pins = "gpio55";
> +                                       function = "mi2s_0";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio55";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
> +                       pri_mi2s_din_active: pri-mi2s-din-active {
> +                               pinmux {
> +                                       pins = "gpio56";
> +                                       function = "mi2s_0";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio56";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };

Can you group together any of the configs?  See, for instance,
"qup_spi0_default" where we configure 4 pins together.  Then you don't
need so many separate nodes to add.

Also: pinconf is nearly always done in board files unless you truly
have a reason to believe that it would be the same for every board.


> +                       pri_mi2s_mclk_active: pri-mi2s-mclk-active {
> +                               pinmux {
> +                                       pins = "gpio57";
> +                                       function = "lpass_ext";
> +                               };
> +
> +                               pinconf {
> +                                       pins = "gpio57";
> +                                       drive-strength = <8>;
> +                                       bias-pull-up;
> +                               };
> +                       };
> +
>                         sdc1_on: sdc1-on {
>                                 pinconf-clk {
>                                         pins = "sdc1_clk";

-Doug
