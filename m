Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA21C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6F1208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="tV5VmVtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFQFjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgFQFjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:39:41 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:39:40 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id i8so357203uak.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9qIRx2tmhQ3c3ThbA5nkdagn3KrF5Ngnlh6eWWB5sQ=;
        b=tV5VmVtHEExLDAgnm3QHdrBX6Z+X2xewEeIPR6nHkE1YvO2YLuZj5m7aMMzZc0N5qn
         b+bHb3H1Pc+gT0kD2XioSKa20MP/FHGwtV/+Ku/ZtIp1b1oux3Iapejc2V8uF24wb84E
         iGb7tbt9DpISBvbBvsKSNtrp9WUTQMdXNgm5SX6l5DWFH999VJdCu1JcxskvBo+k2OZQ
         /Oz077l3N08uClrw1bPyI3kIatKaQbccwkvGEVq1gF7KwfD3tn5OMSSBypaFjkdpH7m4
         0SVo1rcoH6DlH7ilS9OSS3zJzdheVKSrfuPcWqR5TLKQeSrLrMatTJo4OiBQ9ZDSl+L5
         e/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9qIRx2tmhQ3c3ThbA5nkdagn3KrF5Ngnlh6eWWB5sQ=;
        b=S9iKcdKRBCMNoyAfF76egbPceyx7cIC8iF0kr6WFrd4kEJR+oiXzyq9PhkQYGAotEK
         wAQdYn/0hD6I5oDrlYmTLwvIjxAdlCH5d6rKl6stXxK4FgdW9Vx6bNlpPuo5R9sU5vIP
         q/bhDtUP/mQHEgjVyX+Kg4BG1QRCD8wbFvSa17eDtNiViZcFpszZzNmT8+OdzUQdwQh1
         JR43wtWoCe3IdYi7tQSA2T8XoWTtGptTtfKzORKVstAASGwZlMTQYaxi0PjnQKBUgdZ9
         BFDvO973aG9MAwfaVaKwH+TFdwvAhaCc8NLAG+kZ+ymbSc8cMdzYe0Gs6XWJvPLtErEM
         +Qww==
X-Gm-Message-State: AOAM5300HGiMb15fgmY9X1ucJeX+wL6cbcyBvRf8tNTi68+8J6jd/HH+
        sSMg6jMeGARtwWqKPy4m4SkmoJOqVBMt4lmedtJpxQ==
X-Google-Smtp-Source: ABdhPJz89Ef33YgEHunwRCxdjaFBZmv3URUcXF7ranAVS8kN/9HInOJDHD51KTNr0Mh1t1tL3cEoGx09WYVLD327dfg=
X-Received: by 2002:ab0:1eca:: with SMTP id p10mr4534103uak.94.1592372379134;
 Tue, 16 Jun 2020 22:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091739.2368-1-narmstrong@baylibre.com> <20200608091739.2368-6-narmstrong@baylibre.com>
In-Reply-To: <20200608091739.2368-6-narmstrong@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 17 Jun 2020 11:09:28 +0530
Message-ID: <CAHLCerP+jEhZJs7yPmwPEm15FnrShJjNzOJ2UNcXVP5-WFbwVg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 2:47 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Khadas MCU node with active FAN thermal nodes for all the
> Khadas VIM3 variants.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>


> ---
>  .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> index 094ecf2222bb..3325e54ea690 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
> @@ -183,6 +183,23 @@
>         hdmi-phandle = <&hdmi_tx>;
>  };
>
> +&cpu_thermal {
> +       trips {
> +               cpu_active: cpu-active {
> +                       temperature = <80000>; /* millicelsius */
> +                       hysteresis = <2000>; /* millicelsius */
> +                       type = "active";
> +               };
> +       };
> +
> +       cooling-maps {
> +               map {
> +                       trip = <&cpu_active>;
> +                       cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> +
>  &ext_mdio {
>         external_phy: ethernet-phy@0 {
>                 /* Realtek RTL8211F (0x001cc916) */
> @@ -222,6 +239,12 @@
>         pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
>         pinctrl-names = "default";
>
> +       khadas_mcu: system-controller@18 {
> +               compatible = "khadas,mcu";
> +               reg = <0x18>;
> +               #cooling-cells = <2>;
> +       };
> +
>         gpio_expander: gpio-controller@20 {
>                 compatible = "ti,tca6408";
>                 reg = <0x20>;
> --
> 2.22.0
>
