Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C66207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7nYoDyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgFMUX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgFMUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:23:25 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF2C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:23:24 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 190so7224053vsr.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8F8rDggZZb6P87zVlxWd51Hiut+wbH0vXk4GSdYwO64=;
        b=Z7nYoDyM1Dq+80bZyzkS/Cw7kiHinBMBLzwXfWmZF1H7dX2P2PrEdepadxnIlVRfxu
         zKZrzsSZbeQVqRi5Bnekc/N80nYXhDPN+NZD7hL3u+gzmmkZIiUw4ZdxBRNoSuee276j
         s4dTOeEa3dioV6eUFMQqyOvp4DJqnMqzkFSHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8F8rDggZZb6P87zVlxWd51Hiut+wbH0vXk4GSdYwO64=;
        b=lEvG2DjJ4xOOp/gI3lqPtugQsFqI1IGmaiI5ZmW8JnGtiVY5b9BEsnSFgpofAz12pJ
         GQmjm7wS2XtIxudtykErDGEIj+YHNBJLq54XM8YBWkMAN+e9FfPFTXhriHvnkKHxjG4y
         4ejcLOcFLxPMWlG6izsTIxXjzBPTEn7XTPNnOnhnqPe1Y/M5qm7beX08P18PAx3m67Kl
         94ySXqrps++wYXdYpiASGDJ6Y1LEmQSL/gntzcSrlCPpoDsZJ+/lpPKLttG8doM95UMI
         5fHSpDhesEfxc0B5f1I8oz+md0oRxfGrCjOju860KbUYP8B+QU4dSA6sHO+7hNjuarS0
         bhBA==
X-Gm-Message-State: AOAM531HSuVd1f+wNtf7LOJJWcL4l7eLL4ebi1aV1MEP3Qdo4biDO8Qb
        ViiG38qCrC2T4253Lm42FcHAu1pPMMI=
X-Google-Smtp-Source: ABdhPJyWnqrdcpfBzmV2u2w+tAfa4OGSURylppq4xSbVBnz0Mxhh0QJmVMCshET2b7Mf3xLdopNLIA==
X-Received: by 2002:a67:88c4:: with SMTP id k187mr15003650vsd.29.1592079802791;
        Sat, 13 Jun 2020 13:23:22 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id u74sm1593601vkb.12.2020.06.13.13.23.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 13:23:21 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id c1so7220368vsc.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:23:21 -0700 (PDT)
X-Received: by 2002:a67:8881:: with SMTP id k123mr14750073vsd.198.1592079801068;
 Sat, 13 Jun 2020 13:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org> <1591868882-16553-4-git-send-email-rbokka@codeaurora.org>
In-Reply-To: <1591868882-16553-4-git-send-email-rbokka@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 13 Jun 2020 13:23:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBbm_kGBdkhf5Hx5pDFEsYeX4o-SL=a5rPt-R_8FjNqg@mail.gmail.com>
Message-ID: <CAD=FV=XBbm_kGBdkhf5Hx5pDFEsYeX4o-SL=a5rPt-R_8FjNqg@mail.gmail.com>
Subject: Re: [RFC v2 3/3] arm64: dts: qcom: sc7180: Add qfprom-efuse
To:     Ravi Kumar Bokka <rbokka@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 11, 2020 at 2:49 AM Ravi Kumar Bokka <rbokka@codeaurora.org> wrote:
>
> This patch adds device tree node for qfprom-efuse controller.
>
> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  4 ++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 10 ++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 4e9149d..2a9224e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -287,6 +287,10 @@
>         };
>  };
>
> +&qfprom {
> +       vcc-supply = <&vreg_l11a_1p8>;
> +};
> +
>  &qspi {
>         status = "okay";
>         pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 31b9217..20f3480 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -498,9 +498,15 @@
>                         #power-domain-cells = <1>;
>                 };
>
> -               qfprom@784000 {
> +               qfprom: qfprom@780000 {

The dt schema checker claims that your node should actually be called:

eeprom|efuse|nvram

So you probably want the above to actually be:

qfprom: efuse@780000

The label to the side doesn't matter and so it can stay qfprom--just
the node name itself is what the checker cares about.


>                         compatible = "qcom,qfprom";

As per my response in the bindings, this should be:

  "qcom,sc7180-qfprom", "qcom,qfprom"

...even if the driver only ever makes use of "qcom,qfprom" this
future-proofs us a bit.


> -                       reg = <0 0x00784000 0 0x8ff>;
> +                       reg = <0 0x00780000 0 0x7a0>,
> +                             <0 0x00782000 0 0x100>,
> +                             <0 0x00784000 0 0x8ff>;
> +                       reg-names = "raw", "conf", "corrected";

As per my response in the bindings, reg-names is discouraged so you
should remove and make it so that the driver doesn't need.


> +

It's hard to tell in email, but checkpatch yells above the above line:

    ERROR: trailing whitespace
    #53: FILE: arch/arm64/boot/dts/qcom/sc7180.dtsi:512:
    +^I^I^I$



> +                       clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
> +                       clock-names = "secclk";

As per the binding spec, clock name shouldn't end in "clk".

For your edification, I provided a patch to fix all my review feedback at:

https://crrev.com/c/2244933

Feel free to squash it into your next version.


-Doug
