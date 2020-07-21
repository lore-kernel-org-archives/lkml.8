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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73128C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3420729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is3ZO80E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgGUJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGUJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:58:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9FC061794;
        Tue, 21 Jul 2020 02:58:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so20564573wru.6;
        Tue, 21 Jul 2020 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uQnhIuf4xfOnC38xqH6WdF/IwObbq5YHuPCxVqakQOQ=;
        b=Is3ZO80EuUuGJQl50+Q3Q28jYd7EBEJflzDKoC9uUMKwkdHBva83bhxF7Mh2bHAC04
         1ELE4/iZTPMU3KzPCQsede9BSVUYwZHJsT1jGwyf7ifSL4yTvn1OrxcbtkfwhCuaj6rC
         K0eJNkt4S255E6kb4wzy5JpDQNv3wS4luBxrnTZjsFlBv/I3lzUbHHL5lZPt5m0PuMHv
         dnd7Rqf7m4JAJnP5LOYlrpcVMUEb0/0uwEQs8c4HBQxA4TyaaV7bGFLaRcvjIuRwL+tu
         R1vzIci92T1aVyQMToT4xAEJQmOlk9KS96dhmx0vxeXiSq8ErrtFJrfXRtbWQBn/WHIl
         eylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uQnhIuf4xfOnC38xqH6WdF/IwObbq5YHuPCxVqakQOQ=;
        b=KBqKlYmeKLgjyjG4JGXGnpHeqPq+vK1u2S99pATwWDczlpX1/FoQ6GMyOEQ9dkD45T
         eowZ1G/sjTVSxOx65kpgsbHOZ9dTltDJGVrm435IH/V0UxmisyrY7OtkgNr3Isi6bdob
         sbYasCLAhHj4deRcRb+wFOHQ45Kx2i65uRQx+CNwi1z6LXrx4NFiNSII56bPoY1ar58C
         hbnus4/SZfOT+hnI7X00nzhi25y6P/nE493ry+uf7EJ36OX7bkn6JtBmS94CK/oVBPz/
         Si4OZNjs7k2iW8B4gW5uTdC8VGvSC4ctkyhr9B5cxL1UotluzodtKFYoEcO9EvCVqJqA
         OoPw==
X-Gm-Message-State: AOAM532ug3B6pO1XHn9thRq1LB9xsHQENbzQyPH6Mu7+PDPg9GU+4bAw
        36XffLJ9HHmyRMSrPrphL9s=
X-Google-Smtp-Source: ABdhPJyfdvD/kATKHtgQiw1J5nkCvpWkT+B1WdiQKjZHwXlEbW+rjhyO2ucEqZVbpcMZIJo+AeMQcg==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr25338306wrs.84.1595325501024;
        Tue, 21 Jul 2020 02:58:21 -0700 (PDT)
Received: from [10.182.202.153] ([87.201.30.26])
        by smtp.gmail.com with ESMTPSA id u20sm2612045wmc.42.2020.07.21.02.58.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 02:58:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <fc679db1-be92-c384-0fe2-3b06c920ea75@baylibre.com>
Date:   Tue, 21 Jul 2020 13:58:17 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@hardkernel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A598AB3-635D-4110-AC1C-94379E036586@gmail.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-4-christianshewitt@gmail.com>
 <90da2697-9dcc-1d75-eded-bf4bdc4b594b@baylibre.com>
 <fc679db1-be92-c384-0fe2-3b06c920ea75@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Jul 2020, at 12:19 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
> On 21/07/2020 10:10, Neil Armstrong wrote:
>> On 19/07/2020 16:10, Christian Hewitt wrote:
>>> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of =
higher
>>> clock speeds than the original ODROID-N2. Hardkernel supports the =
big cpu
>>> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points =
and
>>> regulator changess are from the HardKernel Linux kernel sources.
>>>=20
>>> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>> .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 =
+++++++++++++++++++
>>> 2 files changed, 54 insertions(+)
>>> create mode 100644 =
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>>>=20
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
>>> index 5cac4d1d487d..6dc508b80133 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-g12b-gtking-pro.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-a311d-khadas-vim3.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-s922x-khadas-vim3.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-odroid-n2.dtb
>>> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-odroid-n2-plus.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-ugoos-am6.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-kii-pro.dtb
>>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-nanopi-k2.dtb
>>> diff --git =
a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>>> new file mode 100644
>>> index 000000000000..99e96be509f8
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>>> @@ -0,0 +1,53 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 BayLibre, SAS
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "meson-g12b-odroid-n2.dtsi"
>>> +
>>> +/ {
>>> +	compatible =3D "hardkernel,odroid-n2-plus", "amlogic,s922x", =
"amlogic,g12b";
>>> +	model =3D "Hardkernel ODROID-N2+";
>>> +
>>> +	vddcpu_a: regulator-vddcpu-a {
>>> +		regulator-min-microvolt =3D <680000>;
>>> +		regulator-max-microvolt =3D <1040000>;
>>> +
>>> +		pwms =3D <&pwm_ab 0 1500 0>;
>>> +	};
>>> +
>>> +	vddcpu_b: regulator-vddcpu-b {
>>> +		regulator-min-microvolt =3D <680000>;
>>> +		regulator-max-microvolt =3D <1040000>;
>>> +
>>> +		pwms =3D <&pwm_AO_cd 1 1500 0>;
>>> +	};
>>> +
>>> +	cpu_opp_table_0: opp-table-0 {
>>> +		opp-1908000000 {
>>> +			opp-hz =3D /bits/ 64 <1908000000>;
>>> +			opp-microvolt =3D <1030000>;
>>> +		};
>>> +
>>> +		opp-2016000000 {
>>> +			opp-hz =3D /bits/ 64 <2016000000>;
>>> +			opp-microvolt =3D <1040000>;
>>> +		};
>>> +	};
>>> +
>>> +	cpub_opp_table_1: opp-table-1 {
>>> +		opp-2304000000 {
>>> +			opp-hz =3D /bits/ 64 <2304000000>;
>>> +			opp-microvolt =3D <1030000>;
>>> +		};
>>> +
>>> +		opp-2400000000 {
>>> +			opp-hz =3D /bits/ 64 <2400000000>;
>>> +			opp-microvolt =3D <1040000>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>>=20
>> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>>=20
>=20
> Wait no, it should be:
>=20
> / {
> 	compatible =3D "hardkernel,odroid-n2-plus", "amlogic,s922x", =
"amlogic,g12b";
> 	model =3D "Hardkernel ODROID-N2+";
> };
>=20
> &vddcpu_a {
> 	regulator-min-microvolt =3D <680000>;
> 	regulator-max-microvolt =3D <1040000>;
>=20
> 	pwms =3D <&pwm_ab 0 1500 0>;
> };
>=20
> &vddcpu_b {
> 	regulator-min-microvolt =3D <680000>;
> 	regulator-max-microvolt =3D <1040000>;
>=20
> 	pwms =3D <&pwm_AO_cd 1 1500 0>;
> };
>=20
> &cpu_opp_table_0 {
> 		opp-1908000000 {
> 		opp-hz =3D /bits/ 64 <1908000000>;
> 		opp-microvolt =3D <1030000>;
> 	};
>=20
> 	opp-2016000000 {
> 		opp-hz =3D /bits/ 64 <2016000000>;
> 		opp-microvolt =3D <1040000>;
> 	};
> };
>=20
> &cpub_opp_table_1 {
> 	opp-2304000000 {
> 		opp-hz =3D /bits/ 64 <2304000000>;
> 		opp-microvolt =3D <1030000>;
> 	};
>=20
> 	opp-2400000000 {
> 		opp-hz =3D /bits/ 64 <2400000000>;
> 		opp-microvolt =3D <1040000>;
> 	};
> };
>=20
> Neil

Okay, I will send corrected v2 and with model name changed.

Christian=
