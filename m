Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F947C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0959420657
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg0rQeFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgGUJZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:25:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609FC061794;
        Tue, 21 Jul 2020 02:25:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so23289454ljc.5;
        Tue, 21 Jul 2020 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ze6lJWvJHZbmrt8N27YOntoBu13Av/K4oTVWvmf42EM=;
        b=Sg0rQeFUrG/1Joo1uXLswuZgL8HlliGcFZBnS7LPFBO0yiQa6vpYGNpyG1QVcQ4gjo
         eVUJva/qdPy31j6nav5crh4VtOaDJdkCm5Q8G/eT8G5Y3ehbfx7cGBi/jSJXZm5FMYjT
         XtiyGdwDLA+4nEc7zf+GLmrwEfRtIvSgMi+tktHNmpafTUy7PHes4Z73wLY4o2Oqw9X5
         6UaogLOr9+pp0xHgZ/kUxwoDTR34U3PLocaYUDw7JVhaUXcjcmtQYpCpst/m+f23g3TE
         7tuTllKB2WGle9AHQLNJaZmBA3KPtyPLUiszU0gyA28I79yFWXc6gs4Te4ybM8ZxxhH2
         rULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze6lJWvJHZbmrt8N27YOntoBu13Av/K4oTVWvmf42EM=;
        b=bqEIb0EtCZ3I8di3vGXZtATBIBUA4MVAPfTtsazFpBXXyCvm6JILS3jMLsTrJyZPFD
         zcKu0DEDQTDiNna0rNRJvKgMA1wQWbSMho1E0dmNv9z6zMP5fGtEvUpy54K02JzwTcKU
         mNgWvB17iWy+6QBPY1u5bc03kO3TF+T2GkqxC1eBsA/ZoHevqE08LLy5ZBzWi3MuhRfA
         2a5x4w2lJ96sb09IYa0Quzii0G9L3cgEaoMzEWUhMAaQGioMebqFW9zrZ9qWms1kkAXz
         ecQ5dYxBKVmz/EbAgbKg4LcPkHqqsoqKJS/kr0txUV5v+lld8akl6TIJPxC9uO+nAQLg
         0GKA==
X-Gm-Message-State: AOAM533rHaO8B7GUkRHK96sunq3kiStlKvX3JQgVOrW7nsSet8RDaKd5
        Hry1bhhOpjX+0Sl3FkKSdS4mDee5LlraxI/BCwI=
X-Google-Smtp-Source: ABdhPJyVqq/e5qtdfaM4Pt8zraL2Gu3jDazqIA7Ge6GF1VOUJm15J1RP3WN1Q8JW4PbN5N5rOWnxwOMnPvEAva9XsBw=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr12878639lja.152.1595323509227;
 Tue, 21 Jul 2020 02:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-4-christianshewitt@gmail.com> <90da2697-9dcc-1d75-eded-bf4bdc4b594b@baylibre.com>
 <fc679db1-be92-c384-0fe2-3b06c920ea75@baylibre.com>
In-Reply-To: <fc679db1-be92-c384-0fe2-3b06c920ea75@baylibre.com>
From:   Dongjin Kim <tobetter@gmail.com>
Date:   Tue, 21 Jul 2020 18:24:57 +0900
Message-ID: <CADoNuNepjmZgdAVAMM8Y6FA8uL5rd96e5qdn1_HDHKj6Lsnu6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dongjin Kim <tobetter@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we use "Hardkernel ODROID-N2Plus" instead of "Hardkernel ODROID-N2+"?

Thanks,
Dongjin.



On Tue, Jul 21, 2020 at 5:24 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 21/07/2020 10:10, Neil Armstrong wrote:
> > On 19/07/2020 16:10, Christian Hewitt wrote:
> >> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
> >> clock speeds than the original ODROID-N2. Hardkernel supports the big cpu
> >> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points and
> >> regulator changess are from the HardKernel Linux kernel sources.
> >>
> >> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
> >> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> >> ---
> >>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
> >>  .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 +++++++++++++++++++
> >>  2 files changed, 54 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> >> index 5cac4d1d487d..6dc508b80133 100644
> >> --- a/arch/arm64/boot/dts/amlogic/Makefile
> >> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> >> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
> >> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
> >>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> >> new file mode 100644
> >> index 000000000000..99e96be509f8
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> >> @@ -0,0 +1,53 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (c) 2019 BayLibre, SAS
> >> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "meson-g12b-odroid-n2.dtsi"
> >> +
> >> +/ {
> >> +    compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
> >> +    model = "Hardkernel ODROID-N2+";
> >> +
> >> +    vddcpu_a: regulator-vddcpu-a {
> >> +            regulator-min-microvolt = <680000>;
> >> +            regulator-max-microvolt = <1040000>;
> >> +
> >> +            pwms = <&pwm_ab 0 1500 0>;
> >> +    };
> >> +
> >> +    vddcpu_b: regulator-vddcpu-b {
> >> +            regulator-min-microvolt = <680000>;
> >> +            regulator-max-microvolt = <1040000>;
> >> +
> >> +            pwms = <&pwm_AO_cd 1 1500 0>;
> >> +    };
> >> +
> >> +    cpu_opp_table_0: opp-table-0 {
> >> +            opp-1908000000 {
> >> +                    opp-hz = /bits/ 64 <1908000000>;
> >> +                    opp-microvolt = <1030000>;
> >> +            };
> >> +
> >> +            opp-2016000000 {
> >> +                    opp-hz = /bits/ 64 <2016000000>;
> >> +                    opp-microvolt = <1040000>;
> >> +            };
> >> +    };
> >> +
> >> +    cpub_opp_table_1: opp-table-1 {
> >> +            opp-2304000000 {
> >> +                    opp-hz = /bits/ 64 <2304000000>;
> >> +                    opp-microvolt = <1030000>;
> >> +            };
> >> +
> >> +            opp-2400000000 {
> >> +                    opp-hz = /bits/ 64 <2400000000>;
> >> +                    opp-microvolt = <1040000>;
> >> +            };
> >> +    };
> >> +};
> >> +
> >>
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> >
>
> Wait no, it should be:
>
> / {
>         compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
>         model = "Hardkernel ODROID-N2+";
> };
>
> &vddcpu_a {
>         regulator-min-microvolt = <680000>;
>         regulator-max-microvolt = <1040000>;
>
>         pwms = <&pwm_ab 0 1500 0>;
> };
>
> &vddcpu_b {
>         regulator-min-microvolt = <680000>;
>         regulator-max-microvolt = <1040000>;
>
>         pwms = <&pwm_AO_cd 1 1500 0>;
> };
>
> &cpu_opp_table_0 {
>                 opp-1908000000 {
>                 opp-hz = /bits/ 64 <1908000000>;
>                 opp-microvolt = <1030000>;
>         };
>
>         opp-2016000000 {
>                 opp-hz = /bits/ 64 <2016000000>;
>                 opp-microvolt = <1040000>;
>         };
> };
>
> &cpub_opp_table_1 {
>         opp-2304000000 {
>                 opp-hz = /bits/ 64 <2304000000>;
>                 opp-microvolt = <1030000>;
>         };
>
>         opp-2400000000 {
>                 opp-hz = /bits/ 64 <2400000000>;
>                 opp-microvolt = <1040000>;
>         };
> };
>
> Neil
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
