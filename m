Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B16C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC7120748
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRWjysvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGIUF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGIUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:05:57 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A4C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:05:57 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o15so1757477vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AinvQ5PJ9tMDmXSnO6ck/b394CwO1KeWDAa17fxTsYg=;
        b=YRWjysvDqa2DekkVgn/4ZOp6k855hwYraXOphC7+nCx7SuZ5nn61o38XK5X/azo5P6
         drSB++in4V2a93h0pcnzC1YcaT7j+hXWsH8/6k6A5t7ABanFshrtH+gezzIZW7I8Hjxc
         FhYBkILnSTuLzBLAunNFHZckck10Glqgq4A5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AinvQ5PJ9tMDmXSnO6ck/b394CwO1KeWDAa17fxTsYg=;
        b=kPrBsOHpKkL5y90ljxkqgkcnJe9hCxYks5KbP5j+N21Vvmcn4Ac2xbZ7c+Ugd7jPv4
         DsVBbNNK4z8gGqK0sdLCUn0pCDx65rI3Nm8Qezp6HxLoCQn5+UdmZzzqPf2hJlUzqkh9
         5nMBbzFBbrH5I4FUGD2PJiHBoCkPaMu5/DfLbSKMKeOy5GUxaNLCGbyQ+OtCbsH1IHaj
         30dNNpyuLII4RCaZ6Q5A9LIRj/u3PT8EtP93rORpZ1nGhl3PTIQN65FICfZLJDV+0cP6
         wz7aHfHGkByo9Jwj67rf0I9XERAzn6jyeUaaIgaeR5bGmYNIvxaeOEZbKO3TYfU9Nibl
         B8+g==
X-Gm-Message-State: AOAM531OrEV+X9crz74bL9fcRADPQDUJRPjPfRAFDLh/lyAPjPuqcV1D
        oExa+qMDR9Lp+rRUsQEWbRF93n+PBaM=
X-Google-Smtp-Source: ABdhPJzpJFH8Bn1yEdqlFNb6V/8rbsiAm8ko5GO9vgfSxSZBqSTT6dREv5mJWjxzbTTHiMeleXBy3Q==
X-Received: by 2002:a67:1342:: with SMTP id 63mr37432383vst.54.1594325153534;
        Thu, 09 Jul 2020 13:05:53 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id i4sm557521vkg.55.2020.07.09.13.05.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 13:05:52 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id j186so1763204vsd.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:05:52 -0700 (PDT)
X-Received: by 2002:a05:6102:30b5:: with SMTP id y21mr26283797vsd.42.1594325151959;
 Thu, 09 Jul 2020 13:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1594286253-32244-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1594286253-32244-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 13:05:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQy17ZuKdJXPH20uGTrEtPrDacDXAg+rTA96HBm6hVVw@mail.gmail.com>
Message-ID: <CAD=FV=XQy17ZuKdJXPH20uGTrEtPrDacDXAg+rTA96HBm6hVVw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add missing properties for Wifi node
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 2:18 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
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
> This patch is created on top of the change by
> Douglas Anderson.
> https://lkml.org/lkml/2020/6/25/817
>
> Also the dt-bindings for the chain1 voltage supply
> is added by the below patch series:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=309137
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 472f7f4..4c64bc1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -391,10 +391,12 @@
>
>  &wifi {
>         status = "okay";
> +       qcom,msa-fixed-perm;

At one point in time I thought +Sibi said that this wouldn't be needed
once the firmware was fixed.  ...afterwards you said that it was
needed for SSR (subsystem reset).  Would be good to get confirmation
from Sibi that this matches his understanding.


>         vdd-0.8-cx-mx-supply = <&vreg_l9a_0p6>;
>         vdd-1.8-xo-supply = <&vreg_l1c_1p8>;
>         vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
>         vdd-3.3-ch0-supply = <&vreg_l10c_3p3>;
> +       vdd-3.3-ch1-supply = <&vreg_l11c_3p3>;
>         wifi-firmware {
>                 iommus = <&apps_smmu 0xc2 0x1>;
>         };

Other than the one question this looks good to me.

-Doug
