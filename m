Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1960C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103CD22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="coDDm+vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHCSJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:09:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3432C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:09:34 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j23so13461236vsq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVtWQUGpmw8jhNyuuKCyNkZI5368yArYPxJOwi5ESm4=;
        b=coDDm+vPAuh6Fuh2z/owncaMvXWcMJtlRYB7hg03SaGSChcDWim/iI7wQu6Gtru4LI
         LNNy/0P59m7hXu3w8xvG2OpKtNRj3lQLUBTX0H4+160GNmcD4+O94D6G26WpSJdbxPGx
         S9b8lEbGDCKUi6B37X/bH0jLuj/oO8PhAeAds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVtWQUGpmw8jhNyuuKCyNkZI5368yArYPxJOwi5ESm4=;
        b=Qu7L/770j1SGaYv1ERKsq89eMKBebsaVje/XSJp1mmeO96Tw80tzR6IWTRq/7feCwD
         6/K23Dhv21CbUVNx1lU7szWdumIFvhQZ39rk2+lE8q2TF4tXPhMsCo1x25jF3jSEPBhT
         YCJ1ZUhAZVJXnrTOdYFdiMBLecs+s0w9Q4gxQxFGjW15O9aPRNRZ67jjPAFlYUAEs/hy
         Jr7oth+v+75T6UXfAduzh9l6gslm+iYvy3yfqMf0YZjFiBiLgBfVz/gkih+6Wv1UAvU5
         IunDel4BmQcJmg35/CxVC83b4TTwWI3NM0ReuIdsHKwCUdGSUmBawupbcyo4/b2GFfbA
         xXJw==
X-Gm-Message-State: AOAM530E4Mk9sH0S81K/g0p1HMPuQOdluJKqhOER4DNf5slq3a4lB+sN
        5rR3Fas7vF0bPSFiZqSz64Vg2BBlf5U=
X-Google-Smtp-Source: ABdhPJxGgaIW4Sruf6QfVttExcXGpWKuD1aMgV5mLvGKiXiJdwXqb47nsOlDZkOqwM+IEBpgth5IUw==
X-Received: by 2002:a67:2043:: with SMTP id g64mr10706230vsg.25.1596478173386;
        Mon, 03 Aug 2020 11:09:33 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id n20sm881803vsr.6.2020.08.03.11.09.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 11:09:31 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id q68so9056580uaq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:09:30 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr12122918uan.121.1596478170242;
 Mon, 03 Aug 2020 11:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <1596305615-5894-1-git-send-email-tdas@codeaurora.org> <1596305615-5894-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1596305615-5894-2-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Aug 2020 11:09:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vm4bF07OFQv85kmOyzK9=TcC0gJuuxcJwUxGNed06QTw@mail.gmail.com>
Message-ID: <CAD=FV=Vm4bF07OFQv85kmOyzK9=TcC0gJuuxcJwUxGNed06QTw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add LPASS clock controller nodes
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 1, 2020 at 11:14 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> Update the clock controller nodes for Low power audio subsystem
> functionality.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index d46b383..7cf8bfe 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
> +#include <dt-bindings/clock/qcom,lpasscorecc-sc7180.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,videocc-sc7180.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
> @@ -3312,6 +3313,30 @@
>                         qcom,msa-fixed-perm;
>                         status = "disabled";
>                 };
> +
> +               lpasscc: clock-controller@62d00000 {
> +                       compatible = "qcom,sc7180-lpasscorecc";
> +                       reg = <0 0x62d00000 0 0x50000>,
> +                           <0 0x62780000 0 0x30000>;
> +                       reg-names = "lpass_core_cc", "lpass_audio_cc";
> +                       clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "iface", "bi_tcxo";
> +                       power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
> +                       #clock-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
> +
> +               lpass_hm: clock-controller@63000000 {
> +                       compatible = "qcom,sc7180-lpasshm";
> +                       reg = <0 0x63000000 0 0x28>;
> +                       clocks = <&gcc GCC_LPASS_CFG_NOC_SWAY_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "iface", "bi_tcxo";
> +                       #clock-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
> +
>         };

You end up adding a blank line at the end that Bjron can probably fix
when applying, but other than that this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
