Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F57AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F0B207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMBY+L1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgESUHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:07:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9815C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:07:46 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id o26so371188vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXbwGQX7NBj93macBQks6TpgCaCAqI85y6U/Eho5NaA=;
        b=iMBY+L1k7S2P7A4yIvSJy4MuZVOr4X+yr4pt1EqaJLCp6UcTm+kmuYjI5XDEe9FOP2
         SumGBT1xC3NYhOGo+zSCsVuJcjHpynQ2q6oJ45AVzmudv6qxVEOkF4nnIgDJqe8LeQwJ
         yB5S7v/Ar4tfTj9fY0v9m2ouNF1hwJw9OzKyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXbwGQX7NBj93macBQks6TpgCaCAqI85y6U/Eho5NaA=;
        b=kErkjaQ1etNyP67qWBuAudXh6WxcMPaaMl5JCWhXqX8c5fWRH/JreY0AKK4WwVBGio
         5eckVA7V6wmJdQzrD8zygOkasDXN2Ivwg2HyYa2/9OiGEN0js8lsdNTxuJ/PNRvUgrQk
         Ash/v65J07ad7qNEoXfxZzbEoPXmSlZUvzLr7TS6r29yVZos8v0dd9kGEayHYbsKg+tS
         28rpKvH6GI6MocBMLyjy2N0whb8ylP/SDOIPZwF8bGMy/kNCGxJqVGJsaP9kTttQfGEx
         tJIQGlstdWZrGvtpo7neMvk9anVTVGPoNMuEObVfe1Kw4aBdr0fbhdABeNaKvHUpZtiF
         3Sew==
X-Gm-Message-State: AOAM533ahBYDP19c9cuUKlK2gg+rCkwthHJlF92JnpxELMbr7UHLMS3D
        nPjC4TjvSTVmpuqNY+AHHjN3cw+WXlg=
X-Google-Smtp-Source: ABdhPJzr3iUq8y6/ElwbnT02RLXq5rI1SlG67T1rVNaNlXPeH75hi1JCCG2VTpYCkvcBgUTg8S3hPQ==
X-Received: by 2002:a05:6102:1263:: with SMTP id q3mr771347vsg.150.1589918865522;
        Tue, 19 May 2020 13:07:45 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id l197sm177334vke.30.2020.05.19.13.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 13:07:44 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id i89so419056uad.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:07:44 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr945772uak.91.1589918864128;
 Tue, 19 May 2020 13:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <1589914405-6674-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1589914405-6674-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 May 2020 13:07:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXRhh-1cWH5rMPq4W_Dh4yE=++sga_aJ8cwFkKkrAXbg@mail.gmail.com>
Message-ID: <CAD=FV=XXRhh-1cWH5rMPq4W_Dh4yE=++sga_aJ8cwFkKkrAXbg@mail.gmail.com>
Subject: Re: [PATCH v10] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 19, 2020 at 11:53 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v9:
> - Place the wlan_fw_mem under reserved-memory node
> ---
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts |  7 +++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi    | 27 +++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> index 4e9149d..38b102e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> @@ -389,6 +389,13 @@
>         };
>  };
>
> +&wifi {
> +       status = "okay";
> +       wifi-firmware {
> +               iommus = <&apps_smmu 0xc2 0x1>;
> +       };
> +};
> +
>  /* PINCTRL - additions to nodes defined in sc7180.dtsi */
>
>  &qspi_clk {
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f1280e0..19bd7d0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -106,6 +106,11 @@
>                         no-map;
>                 };
>
> +               wlan_fw_mem: memory@94100000 {
> +                       reg = <0 0x94100000 0 0x200000>;
> +                       no-map;
> +               };
> +
>                 rmtfs_mem: memory@84400000 {
>                         compatible = "qcom,rmtfs-mem";
>                         reg = <0x0 0x84400000 0x0 0x200000>;

This is less wrong than v9, but still a little wrong.  You should be
keeping these ordered by unit address.  94100000 comes after 84400000.

-Doug
