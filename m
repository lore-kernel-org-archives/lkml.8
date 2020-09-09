Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57034C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F32E20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jXLCBqNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIIVaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:30:11 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF29C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:30:10 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id e5so1064690vkm.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47pCfHCQ+v4BbpZhrHNZ2wtMUQkpqJXTbV3lF3DkBic=;
        b=jXLCBqNUV9jGbre90QfVGVO4THC61Ocp5+wSKhoeIGyRADR6hKTBJUMPPXtjVJtlfT
         nxJk7eqLtaDCYR7zQTQAYQt9efFu8muNYflrHPKsG8DB37chbJKvqorUdT2Ks++80dxl
         sT5gwqw36/ChMVpExrBrojlJx98COigtRy9a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47pCfHCQ+v4BbpZhrHNZ2wtMUQkpqJXTbV3lF3DkBic=;
        b=S326JOCEy4rELKQ2ok4bTNrwyI7e/72p05wGWvIIvkGD+FS5V6M8nuL8QS1so5vm9r
         /aOE97Ez0GXGvq9ZImF2KIYXz4dKikfRr6qSSSOBXRx7iPXzMQqRIKWbcktOIHGpg5+L
         z7q6FB1SMtel8vio2254uA9oJqmLBd6Nx+x2OshXegQij2d8H78b5rtj3eWCfUHyevdx
         A1DW/M4E/HKM0szgua4PI34cwieRtQ3GJ0MndVXpLAgDVQiqGkuLCux941bPK9NJn4Ok
         Fv3Sr+MdGGulOwcwLL4wKERpfU3gh3ocX9g8OQJNyfJ0IAuyKx/XzdGcYB1pLZzEZEXi
         60pg==
X-Gm-Message-State: AOAM531FrbdzfgTq3gqN6BHLQXE0mAMy+dR+vDUvi/F0A3NnXLWCYKXn
        AeORnaq7GwU3HTmKXfwRbjNLzbKbygfeYA==
X-Google-Smtp-Source: ABdhPJxqbfEe+TATKdbG3Fxs0y3q3HBgzi+3zaL9vS1zY84JB53PxWK23+Pc8h5rMKp51CYySDMqgw==
X-Received: by 2002:a1f:bf53:: with SMTP id p80mr2236681vkf.5.1599687009659;
        Wed, 09 Sep 2020 14:30:09 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id b205sm581649vkf.54.2020.09.09.14.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:30:08 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id n193so1051941vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 14:30:08 -0700 (PDT)
X-Received: by 2002:a1f:e641:: with SMTP id d62mr2162009vkh.30.1599687008270;
 Wed, 09 Sep 2020 14:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <1599145498-20707-1-git-send-email-skakit@codeaurora.org> <1599145498-20707-4-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1599145498-20707-4-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Sep 2020 14:29:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VyRU3+BLx_6YPrOsaA6E05cJn_OpBR1y3Dt0LA0X5REA@mail.gmail.com>
Message-ID: <CAD=FV=VyRU3+BLx_6YPrOsaA6E05cJn_OpBR1y3Dt0LA0X5REA@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] arm64: dts: qcom: sc7180: Add sleep state for BT UART
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 8:08 AM satya priya <skakit@codeaurora.org> wrote:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index cecac3e..77e3523 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -507,6 +507,43 @@
>         };
>  };
>
> +&qup_uart3_sleep {
> +       pinconf-cts {
> +               /*
> +                * Configure no-pull on CTS. As this is driven by BT, do not
> +                * specify any pull in order to not conflict with BT pulls.
> +                */
> +               pins = "gpio38";
> +               bias-disable;

Same comment as in the previous patch that I'm not convinced removing
the bias here is correct.


> +       };
> +
> +       pinconf-rts {
> +               /*
> +                * Configure pull-down on RTS to make sure that the BT SoC can
> +                * wake up the system by sending wakeup bytes during suspend.
> +                */
> +               pins = "gpio39";
> +               bias-pull-down;
> +       };
> +
> +       pinconf-tx {
> +               /* Configure pull-up on TX when it isn't actively driven */
> +               pins = "gpio40";
> +               bias-pull-up;
> +       };
> +
> +       pinconf-rx {
> +               /*
> +                * Configure a pull-up on RX. This is needed to avoid
> +                * garbage data when the TX pin of the Bluetooth module is
> +                * in tri-state (module powered off or not driving the
> +                * signal yet).
> +                */
> +               pins = "gpio41";
> +               bias-pull-up;
> +       };
> +};
> +
>  &qup_uart8_default {

Slight nit that "default" starts with a "d" which sorts before "sleep"
which starts with an "s".  Thus "qup_uart8_default" should be above
"qup_uart3_sleep", not below.
