Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24A820706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0UbnxIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgFYBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbgFYBHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:07:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4506C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:07:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d12so2011627ply.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DQNqb/XiJnv5S5KAYc7VnMgjA/JQZWT3OBZtTbZloYs=;
        b=H0UbnxIw9yihnQXV7n5Vs/S+wHPE+4oI5wiVf1L0FkydepByp7tukHVSsmBjKzLtYX
         yAcpeRrcRzj/Azf+tWW5QrIcwBLUlca1JeCMlp5VQ7O8QXhFKfAz6YcmO5rVSxdRxFr1
         wb59f68RnJCNYPRZVH9RkF3A//MIGZ1RhhQZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DQNqb/XiJnv5S5KAYc7VnMgjA/JQZWT3OBZtTbZloYs=;
        b=UIx9Zn2AdAUB9HE2AjQfWvK63iTSb1PRbH+iCNJeyaV2XZSOvGqkr6AiJC+FksNlXI
         ZBYJsfeP3H4qNO83YkarGlIBRbuotchhEHsIFfrn9d/84JBZizWEJYdQghHuT/VLzTjC
         2II3IJ4pTWr12/Cb74Xzp6jWVE18aNOpD30xG2F4F6Amy0+Qgm/ti5WV8HH4+ng2H82q
         5TZzI4fmNJUcoyYHCLpONiLPO9DHFURRZi8/ZpSw2WQGJgukZ5ErEBCb2O7Ujx+HeFxz
         erz5Cs8MbdQj+bvnpULTTaxk0TOPhrEHH1ZN3boRWL0B8Lns59UqQ4oA9Co2dksGlxNP
         b5Tw==
X-Gm-Message-State: AOAM533CMB+Tq8s/gkUzooyv0GD7R5f+dC/ZjSSwykZjAxkIi69gLj5v
        ej8GhwBIRtKeXzAWPfuNphgDcw==
X-Google-Smtp-Source: ABdhPJwwcQxMpk75imsoh0sM8lNh+D5onW70er8+RgLQLUV8Zlj+nifCh0lPXsEWgtHbcZypSU21dQ==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr501452pjc.27.1593047240035;
        Wed, 24 Jun 2020 18:07:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u8sm20760732pfh.215.2020.06.24.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 18:07:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200217085842.28333-1-harigovi@codeaurora.org>
References: <20200217085842.28333-1-harigovi@codeaurora.org>
Subject: Re: [v3] arm64: dts: sc7180: add nodes for idp display
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Harigovindan P <harigovi@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
To:     Harigovindan P <harigovi@codeaurora.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Date:   Wed, 24 Jun 2020 18:07:18 -0700
Message-ID: <159304723830.62212.5069780400830519255@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Harigovindan P (2020-02-17 00:58:42)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dt=
s/qcom/sc7180-idp.dts
> index 388f50ad4fde..349db8fe78a5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -232,6 +233,57 @@ vreg_bob: bob {
>         };
>  };
> =20
> +&dsi0 {
> +       status =3D "okay";
> +
> +       vdda-supply =3D <&vreg_l3c_1p2>;
> +
> +       panel@0 {
> +               compatible =3D "visionox,rm69299-1080p-display";
> +               reg =3D <0>;
> +
> +               vdda-supply =3D <&vreg_l8c_1p8>;
> +               vdd3p3-supply =3D <&vreg_l18a_2p8>;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&disp_pins>;
> +
> +               reset-gpios =3D <&pm6150l_gpio 3 GPIO_ACTIVE_HIGH>;
> +
> +               ports {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +                       port@0 {
> +                               reg =3D <0>;
> +                               panel0_in: endpoint {
> +                                       remote-endpoint =3D <&dsi0_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       ports {
> +               port@1 {
> +                       endpoint {
> +                               remote-endpoint =3D <&panel0_in>;
> +                               data-lanes =3D <0 1 2 3>;

Is this property needed? If it's the default assumption it would be nice
to omit it so that we don't have to think about it.

> +                       };
> +               };
> +       };
> +};
> +
> +&dsi_phy {
> +       status =3D "okay";
> +};
> +
> +&mdp {
> +       status =3D "okay";
> +};
> +
> +&mdss {
> +       status =3D "okay";
> +};
> +
>  &qspi {
>         status =3D "okay";
>         pinctrl-names =3D "default";
> @@ -289,6 +341,17 @@ &usb_1_qmpphy {
> =20
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
> =20
> +&pm6150l_gpio {
> +       disp_pins: disp-pins {

Curious how this works. It looks like PMIC GPIOS are expecting the node
to look like:

	disp_pins: disp-pins {
		pinconf {
			pins =3D "gpio3";
			function =3D PMIC_GPIO_FUNC_FUNC1;
			qcom,drive-strength =3D <PMIC_GPIO_STRENGTH_MED>;
			power-source =3D <PM6150_GPIO_VPH>;
			bias-disable;
			output-low;
		};

but this doesn't use the macros or the subnode for pinconf. Why? Also,
the PM6150_GPIO_VPH macro doesn't exist.

> +               pins =3D "gpio3";
> +               function =3D "func1";
> +               qcom,drive-strength =3D <2>;
> +               power-source =3D <0>;
> +               bias-disable;
> +               output-low;
> +       };
> +};
> +
