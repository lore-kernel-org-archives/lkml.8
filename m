Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E7C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F5A20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyf2pDtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgAJPkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:40:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39661 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgAJPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:40:25 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so2078733ila.6;
        Fri, 10 Jan 2020 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zfveKwnRK85mJXCf2w5k6uuMDFTAUqHiB2SRdT1OPtw=;
        b=Eyf2pDtvCwsChMpc+mpR9mGl+B89HFzVOVjGCDfOKJzIuX/1FUntYjwt/szKs2X2RP
         oyZsDtCNH9oXEolJwkI4bijMHUmbH5gDCN9bnb1TEsZ89cjwOfEIS2J9qXOpPcL79TkC
         Jb3nK4NB5HgKGsCGV0DVJoZjflgCFWqifdSJEarXjG5DUdLUIwsZUlBxHtetIJ/SVbwT
         /IUOavZELqgR8+Me4B2vS5JeYUae0m/LokZu+KbQnGX9lQKnXY1JxtIpMOa+Zi4ApeJ6
         ndDe1GXurmXskgSPnAcbFjg9dPc3vPv8p1l4pRzbYxD9N3enYdTuE2JSHf7TreI+m/Bb
         LqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zfveKwnRK85mJXCf2w5k6uuMDFTAUqHiB2SRdT1OPtw=;
        b=nVdRICVi5/6BzjSiBkebzBwwhZQMXYWlvsa78xhm32tjkQ72jBWEWekwKVFOi1mGLV
         fDaB+t/KOdN7T3I7wHKCEPO+WNLkEMq6/SgakL/ZQzyYZEVNXmQrhJx9lb+mE9LengLf
         9bbs/IjXBRt5UIz/PmY0yj7Axvl6K1RO433DB66QjT5wJ6WZCNLBKovuB05/smjpdmWR
         6UOj8eaL+xpGTe6U1oBte/zEyJVdEToWKnVigdSZpqVO67039EVPQT5/mWT9C1WnT8Cs
         fwV/q35xOPS8qyw3sQqW8hTZ+82D2HE2FzZKoJ4fIev7FtFynL04zBN0PwVk0UxWhGNB
         ulhA==
X-Gm-Message-State: APjAAAWqwGcTmi0CLuucPtBHL/Plmv0HyaEdQIO4PWeegOFdx3zkIbdu
        gg0H9vjVggf6DZcuJBWbTpYbwAjNYHlO/rdlATU=
X-Google-Smtp-Source: APXvYqwVstS0bfJ7o2vEobkH8jOr99DSJkX7e0rovYTLXZAar3F1T2Nwyk4CYH3OT34MDdWPeSc7+j1+bIEtM/b8RdQ=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr3025126ilq.306.1578670824629;
 Fri, 10 Jan 2020 07:40:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:5809:0:0:0:0:0 with HTTP; Fri, 10 Jan 2020 07:40:24
 -0800 (PST)
In-Reply-To: <20200110142128.13522-1-jbx6244@gmail.com>
References: <20200110142128.13522-1-jbx6244@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Date:   Fri, 10 Jan 2020 16:40:24 +0100
Message-ID: <CA+z=w3UjX71Nw7W+iiGkQh=UJkPMsEn1phSdp25d--O8QM-ETQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add reg property to brcmf sub node
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Question for Heiko or rob+dt.
Where would should #address-cells and #size-cells go in the dts or to the dtsi.
In case they become required in a futhure rockchip-dw-mshc.yaml?
ie. Should we patch all XXX rockchip,rk3288-dw-mshc nodes with them?

Thanks

2020-01-10 15:21 GMT+01:00, Johan Jonker <jbx6244@gmail.com>:
> An experimental test with the command below gives this error:
> rk3399-firefly.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-orangepi.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge-captain.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge-v.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> So fix this by adding a reg property to the brcmf sub node.
> Also add #address-cells and #size-cells to prevent more warnings.
>
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 3 +++
>  arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 3 +++
>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 3 +++
>  3 files changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> index 92de83dd4..06043179f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> @@ -669,9 +669,12 @@
>  	vqmmc-supply = &vcc1v8_s3;	/* IO line */
>  	vmmc-supply = &vcc_sdio;	/* card's power */
>
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
>
>  	brcmf: wifi@1 {
> +		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> index 4944d78a0..e87a04477 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> @@ -654,9 +654,12 @@
>  	sd-uhs-sdr104;
>  	vqmmc-supply = <&vcc1v8_s3>;
>  	vmmc-supply = <&vccio_sd>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
>
>  	brcmf: wifi@1 {
> +		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> index 0541dfce9..9c659f311 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> @@ -648,9 +648,12 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
>  	sd-uhs-sdr104;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>  	status = "okay";
>
>  	brcmf: wifi@1 {
> +		reg = <1>;
>  		compatible = "brcm,bcm4329-fmac";
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> --
> 2.11.0
>
>
