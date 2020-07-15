Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30794C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F5C20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASTb52Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGOTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGOTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:02:14 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FCBC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:02:14 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h1so728765vkn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmtQ0FrsBiOsqRJiGiTNFNGrmIx+8RMusU8KDu9T4aY=;
        b=ASTb52Iah2njRL2ETx3AA40ICz/qZGc0YsZ4RTzCHytuyNKqdrkSTbsaUPy6zkttzt
         S0MEohrvEOeRRGxXFQp93vIfJK+w3YIv6+8lc3P+gfKEBlEbAj93X2DRVgyxa9eN6HIB
         Wn7Yifou3j68JRXTW7Fq30Bc0R2f+cTkHEa1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmtQ0FrsBiOsqRJiGiTNFNGrmIx+8RMusU8KDu9T4aY=;
        b=tjRowsZRVF9ShFzQ58mXkm9w7X4MKJa+typjELUU6A4M4s+ISTUOhpsBUrdn3A+RIN
         0FR/EqxoyWrX8UDg7hudsOWGA1YhK2SpAwNYHBb04Ho1ieQVpHZKnVsSrd0eqkKFuVgO
         RSbEugeZ1Wgi66c6Ubl2hdp1mZ3vvaX0HXQnZ3/5MjckqPw0jcTZo3qXT3/CoJ52p1nm
         uJTTj4oGbGQV0WUfGk1ooiWBBAFvzlo+ByfIeCpwH5qJJNEOgrG9OQ5iIGBFD9fMAxYX
         SkHCtDWtdiJATk5VFaRe3WVBgt2L0F/fFTGxXAHafXl5hyuEmqEYrX1UIaBEwZf/xYaf
         eJoA==
X-Gm-Message-State: AOAM5305JiNRrWFA6603mjSutHC4avrMpaJNaJLtYwXQY75XRXhQZAKk
        dzLkfhkAPkpqpwxGsmiv/zyVAb62g4k=
X-Google-Smtp-Source: ABdhPJzA7oqzci4xxrt4xwtDv8MqYdm28Gl8Eh/WVwmIQw3nH1QZEG4l0zkbdpaiAe4SVoIqbFh/Ew==
X-Received: by 2002:a1f:a18f:: with SMTP id k137mr444207vke.69.1594839732872;
        Wed, 15 Jul 2020 12:02:12 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id f69sm434568vkf.4.2020.07.15.12.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 12:02:12 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id h190so731547vkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:02:11 -0700 (PDT)
X-Received: by 2002:a1f:3d4a:: with SMTP id k71mr443715vka.65.1594839731375;
 Wed, 15 Jul 2020 12:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <1594615586-17055-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1594615586-17055-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jul 2020 12:01:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XtBhM_CSQM63LCiVDR0oPAAyEr5bG_FRt1tdwpw5OPKQ@mail.gmail.com>
Message-ID: <CAD=FV=XtBhM_CSQM63LCiVDR0oPAAyEr5bG_FRt1tdwpw5OPKQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add missing properties for
 Wifi node
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 12, 2020 at 9:46 PM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> The wlan firmware memory is statically mapped in
> the Trusted Firmware, hence the wlan driver does
> not need to map/unmap this region dynamically.
>
> Hence add the property to indicate the wlan driver
> to not map/unamp the firmware memory region
> dynamically.
>
> Also add the chain1 voltage supply for wlan.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v1:
> - Add the wifi mac alias
>
> This patch is created on top of the change by
> Douglas Anderson.
> https://lkml.org/lkml/2020/6/25/817
>
> Also the dt-bindings for the chain1 voltage supply
> is added by the below patch series:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=309137
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 472f7f4..c042d61 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -19,6 +19,7 @@
>
>         aliases {
>                 bluetooth0 = &bluetooth;
> +               wifi0 = &wifi;
>                 hsuart0 = &uart3;
>                 serial0 = &uart8;

Could you alphabetize?

>         };
> @@ -391,10 +392,12 @@
>
>  &wifi {
>         status = "okay";
> +       qcom,msa-fixed-perm;
>         vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
>         vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
>         vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
>         vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
> +       vdd-3.3-ch1-supply = <&vreg_l11c_3p3>;
>         wifi-firmware {
>                 iommus = <&apps_smmu 0xc2 0x1>;
>         };

Other than the alphabetical order:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
