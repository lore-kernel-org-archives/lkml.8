Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270BC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A32F205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWQQM+Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCOCmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:42:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43439 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:42:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id x1so15210515qkx.10;
        Sat, 14 Mar 2020 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc8LwrIaU40nI0L9rZtv7zvcU+o5GuwsQBOLTCK4qFI=;
        b=OWQQM+EsX/WIldwdhGjM06LV5RrRYgpfmsg0veXZ5b1TbRwxXPK0G+WQbH1j1/L2e3
         WVMPJDIpZH/IDd7nWjzggg03LB0+pgKuXyrM4YWKU83RqpkFLv4osM0SP36Yd9ttHUXY
         Dveio6C8RFtOJ0nK3G1m6dGNn+ENhlyrEANU4viuG3hPzXpHAHcCOLm7mvyfoatCpxg5
         Sp1pJoOdqMCYSFFy6f4AjVPkEtY933eukKKpmug2SRaZqoGbIF0WvkHyIMMzyrgMaYIh
         ZzJxraxHiqWPV0u9qPQFucNts0nSW6OxBu8CGX6h4lxaE/5KvpRH2JAvjnHXM8nCLg1s
         MXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc8LwrIaU40nI0L9rZtv7zvcU+o5GuwsQBOLTCK4qFI=;
        b=NVhea6Ed0yAqP9ufxC82kq3x5AZWSiT31UCiLUbv2OMJgIDG/G+ZKnSNsmNE7qUeZW
         KdRohrY/9Q3xnpV5Hsd9ZB5jud/biFFLNCns+5H56fjC0ZC63OZCe7DZksN87eY49fTd
         kzc1xF32VC1+MyA2M1aPaCCG3IKMgSgxNn61QdCNOk8oqCRME4qzbW5tDpXl12zj74Ji
         EkgfHsGqnMTm+ng6Fk6pz8YwPRNoPFHqnhCJoPjUqnCrWhwfGGhpMkV0pql0jKx03s+M
         /2El1zNvMPOA1DLo+yiyuPT+FcWPN6BnPSN5B2EsMgOUFY/N0NtEnKWbKCauO8+3tJmm
         OIcw==
X-Gm-Message-State: ANhLgQ1IAqsmTNMTDOElPgNQi2Lf8OqSYurorlinp5CrzMzTaCWV/Cjs
        IiRH1QsjFH8reraW95+E9jYyrg2iVEjaGjTJhhDQlebC
X-Google-Smtp-Source: ADFU+vvqbJcRXoy8MLoV6dVlKl4R88lrkt8lrWmZMrkz8gdnvH1wWUt998hcX+ARQdd6OcDsbFBEZdJVYtnNc81xZ1Q=
X-Received: by 2002:a02:8795:: with SMTP id t21mr13779924jai.126.1584192765365;
 Sat, 14 Mar 2020 06:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-3-linux.amoon@gmail.com>
In-Reply-To: <20200310194854.831-3-linux.amoon@gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 14 Mar 2020 19:02:33 +0530
Message-ID: <CANAwSgR4fJK0uVANv-x-=iSL_hAKD8kvazACUsY9Meu5xonuqQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/5] ARM: dts: exynos: Add missing usbdrd3 suspend clk
To:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, 11 Mar 2020 at 01:19, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add new compatible strings for USBDRD3 for adding missing
> suspend clk, exynos5422 usbdrd3 support two clk USBD300 and
> SCLK_USBD300, so add missing suspemd_clk for Exynos542x DWC3 nodes.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

My assumption based on the FSYS clock source diagram below was bit wrong.
[0] https://imgur.com/gallery/zAiBoyh

And again re-looking into the driver source code, it turn out their
are *6 clock*
Here is the correct mapping as per the Exynos5420 clock driver.

USB-(phy@12100000)
|___________________CLK_SCLK_USBD300
|___________________CLK_SCLK_USBPHY300

USB-(phy@12500000)
|___________________CLK_SCLK_USBD301
|___________________CLK_SCLK_USBPHY301

USB-(dwc3@12000000)
|___________________CLK_USBD300
USB-(dwc3@12400000)
|___________________CLK_USBD301

Note: As per Exynos 5422 user manual, There are some more USB CLK
configuration missing in GATE_IP_FSYS. So we could enable another dwc3 clk,
If needed I would like too add this missing clk code and enable this
clk for dwc3 driver.

For some reason we already use CLK_USBD300 and CLK_USBD301
for PHY nodes, which lead to this confusion. So we need to update PHY clock
CLK_USBD300 with CLK_SCLK_USBD300 and clock CLK_USBD301 with CLK_SCLK_USBD301.

Please share your thought on linking PHY nodes above and add new DWC3 clock
and enable this clock.

-Anand

> ---
> fix the commit message
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 8 ++++----
>  arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
>  arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index 2eab80bf5f3a..19845dcd528f 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -396,8 +396,8 @@ &trng {
>  };
>
>  &usbdrd3_0 {
> -       clocks = <&clock CLK_USBD300>;
> -       clock-names = "usbdrd30";
> +       clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
> +       clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>
>  &usbdrd_phy0 {
> @@ -407,8 +407,8 @@ &usbdrd_phy0 {
>  };
>
>  &usbdrd3_1 {
> -       clocks = <&clock CLK_USBD301>;
> -       clock-names = "usbdrd30";
> +       clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
> +       clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>
>  &usbdrd_dwc3_1 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index b672080e7469..bd505256a223 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1372,8 +1372,8 @@ &trng {
>  };
>
>  &usbdrd3_0 {
> -       clocks = <&clock CLK_USBD300>;
> -       clock-names = "usbdrd30";
> +       clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
> +       clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>
>  &usbdrd_phy0 {
> @@ -1383,8 +1383,8 @@ &usbdrd_phy0 {
>  };
>
>  &usbdrd3_1 {
> -       clocks = <&clock CLK_USBD301>;
> -       clock-names = "usbdrd30";
> +       clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
> +       clock-names = "usbdrd30", "usbdrd30_susp_clk";
>  };
>
>  &usbdrd_dwc3_1 {
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> index 8aa5117e58ce..0aac6255de5d 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -143,7 +143,7 @@ hsi2c_7: i2c@12cd0000 {
>                 };
>
>                 usbdrd3_0: usb3-0 {
> -                       compatible = "samsung,exynos5250-dwusb3";
> +                       compatible = "samsung,exynos5420-dwusb3";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> @@ -165,7 +165,7 @@ usbdrd_phy0: phy@12100000 {
>                 };
>
>                 usbdrd3_1: usb3-1 {
> -                       compatible = "samsung,exynos5250-dwusb3";
> +                       compatible = "samsung,exynos5420-dwusb3";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges;
> --
> 2.25.1
>
