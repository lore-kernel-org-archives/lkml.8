Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619F22075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AlU1mY95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgESR2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgESR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:28:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2FFC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:28:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so245474lfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UU2uDfoQ0XDU5KpKT4RRKwHm6V5OiKc9FhAQ/MpRZE=;
        b=AlU1mY950tCF9utrFQJlkpHmR4B291Dm6iDtNg/pIX2GtWDmyyj5nBCfZdHnxlIZBo
         x8d58nILrz8M4S83m3rVZ34JaujF1PMsA2JJq7UjB/1bl30tz/Tzgvfcjf0g6OMPbQwW
         OeCiSlziacIOl3984F0dNQIh887yHOmDn6RUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UU2uDfoQ0XDU5KpKT4RRKwHm6V5OiKc9FhAQ/MpRZE=;
        b=kX+jCTgrx0pG/YZMCH3MrZyacAYgIMtUnyhx2J/p36FVf9lNZzpK/afMhgr8wICSzw
         +LfaJqGSWKvD4sM77yw2NsTmYe5JbpcVEeuZ0XO28hMTbg9RYqe59bOPaTuM/+QMuR2I
         HBJfkt1YAuWYQCcBb55EqIrdvJLZuIq6bCoF9DS0FI+yPUxauSs2zzBaD6zc92VUOXgZ
         LoEiXeUORbXyCqHUtAMsO4sUmHjgx+qoyk131OVcpKkcgI4bj+SIA4oReYfVF9eVXMCb
         yX5LMwuLuQPqJbskQVgnu2qDpwk80bs5g69xnUmsoZ4t4QwqSRS8kYiAo1JlaLTxRPO0
         D02g==
X-Gm-Message-State: AOAM530uztrX/yH6JJN4iRCVF5KAPu5sYkENtN/0vgXxepxqNuB2o47c
        wR1k3/7Ot6/kB1Hi7aUkg3BvpHyWnzY=
X-Google-Smtp-Source: ABdhPJxsYqu1gY9/8XaqJHaL6TVLbUw4EKQlRL49EX41a/VaPfa1zEb4tNk0EL4XgwdtnRs/WuTGwg==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr15974613lfh.87.1589909330782;
        Tue, 19 May 2020 10:28:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i1sm136329lja.3.2020.05.19.10.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 10:28:50 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x22so221825lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 10:28:49 -0700 (PDT)
X-Received: by 2002:a19:b06:: with SMTP id 6mr12546467lfl.104.1589909329254;
 Tue, 19 May 2020 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <1589712411-26718-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1589712411-26718-1-git-send-email-pillair@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 19 May 2020 10:28:12 -0700
X-Gmail-Original-Message-ID: <CAE=gft577zxP5F6OdFXt6taLuLyye+tdRqZa63mPSRtPXO3Lcw@mail.gmail.com>
Message-ID: <CAE=gft577zxP5F6OdFXt6taLuLyye+tdRqZa63mPSRtPXO3Lcw@mail.gmail.com>
Subject: Re: [PATCH v9] arm64: dts: qcom: sc7180: Add WCN3990 WLAN module
 device node
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 3:47 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on sc7180 soc.
>
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v8:
> - Removed the qcom,msa-fixed-perm
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
> index f1280e0..dd4e095 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -63,6 +63,11 @@
>                         clock-frequency = <32764>;
>                         #clock-cells = <0>;
>                 };
> +
> +               wlan_fw_mem: memory@94100000 {
> +                       reg = <0 0x94100000 0 0x200000>;
> +                       no-map;
> +               };

This node is not in the right place. Up through v8, this lived inside
reserved-memory. Here it seems to apply into the clocks {} node, which
is not the right spot.


>         };
>
>         reserved_memory: reserved-memory {
> @@ -944,6 +949,28 @@
>                         };
>                 };
>
> +               wifi: wifi@18800000 {
> +                       compatible = "qcom,wcn3990-wifi";
> +                       reg = <0 0x18800000 0 0x800000>;
> +                       reg-names = "membase";
> +                       iommus = <&apps_smmu 0xc0 0x1>;
> +                       interrupts =
> +                               <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH /* CE0 */ >,
> +                               <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH /* CE1 */ >,
> +                               <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH /* CE2 */ >,
> +                               <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH /* CE3 */ >,
> +                               <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH /* CE4 */ >,
> +                               <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH /* CE5 */ >,
> +                               <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH /* CE6 */ >,
> +                               <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH /* CE7 */ >,
> +                               <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH /* CE8 */ >,
> +                               <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH /* CE9 */ >,
> +                               <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH /* CE10 */>,
> +                               <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH /* CE11 */>;
> +                       memory-region = <&wlan_fw_mem>;

Should any of the *-supply regulators be specified? Or are they all
board specific? Or just not needed? The example has these:
vdd-0.8-cx-mx-supply = <&pm8998_l5>;
vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;



> +                       status = "disabled";
> +               };
> +
>                 config_noc: interconnect@1500000 {
>                         compatible = "qcom,sc7180-config-noc";
>                         reg = <0 0x01500000 0 0x28000>;
> --
> 2.7.4
