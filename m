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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9BBC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185F820792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc5wXVio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGULHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgGULHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:07:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3BC061794;
        Tue, 21 Jul 2020 04:07:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so2386961wme.5;
        Tue, 21 Jul 2020 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZyLTGBYU80P+U/XLzVkUfsWKWDdFrBlDOcpYxYd4js=;
        b=Fc5wXVio5CFidsuzIit664RMMlbc2J2nvQux3ajoC6p28t1TpOOcmHED4cmf2RXpyg
         DsUwIVOI3Hc5/PRwk+fJCiOIOfJKlgXHcBabNjndCMJWXOQ60hrGkYK6H1wFOyfkMom5
         jIEJuC32xo2W46/6X2y97BvGdn+V/2El6qD+GyHUcrrVvOwxjNPngcReHd5S8wUgE82X
         u9RVDCmHC2ZMdVKfACprAsN/ctCN+kQqJ6nawf7fMc2ZfVICH7qEa2+PQrqHqmMb7BdP
         /rGLEJJvtsNKJMHJD9CQ7qlRuFSaiJQ9Ky6vgQ6z7sqwdXWj/oc2L4umEtBsqjFFrous
         HBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZyLTGBYU80P+U/XLzVkUfsWKWDdFrBlDOcpYxYd4js=;
        b=kgjdZjWGUK23ScagNcpLbsAMFTJpWNPUXl5cor04nBRFq3wDdYLI2W9iA8+tCJxxAM
         cYWuRALxX9JWfa5SAUsiblQM94P0IdBwinEpYSeshapRrGyITX+t4gY+Ie19LgWFVPKu
         0m94yX9cLUmqHI1wUp2Ki3tXBD/iEFnq4Cb8Knj6oSCguSV49WsZoHwXHgIztSvGxAku
         Xss6r22bDZd8/3M/MPV3xwRvDcua/icok7fYPfw6XHe3T4XRoVKv+rTP0nxqZHeeylEv
         QoShtPjKLNAquQAisb6McmcKrMdkPDf52yt2O4rU+JoWbGBVBbEWh4jWln5WnJi8Rtxe
         0QAg==
X-Gm-Message-State: AOAM533m3LdUtxMMymxYWORJIs+Ix076HQ9XHfDlL4f7v3kIPOtkTwdd
        2FqPIiQRRZQF7iZFXlcuTDk=
X-Google-Smtp-Source: ABdhPJxB+A27RbNwhEx0EiDOdGaGmkY0YOdfq/izYyLF7dN3XEsn2dEsqMEYjzhWc+gJSIcljKq78w==
X-Received: by 2002:a1c:2d0c:: with SMTP id t12mr3460106wmt.43.1595329662026;
        Tue, 21 Jul 2020 04:07:42 -0700 (PDT)
Received: from [10.182.202.153] ([87.201.30.26])
        by smtp.gmail.com with ESMTPSA id c24sm12095941wrb.11.2020.07.21.04.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 04:07:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <1jo8o98c2c.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 21 Jul 2020 15:07:38 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@hardkernel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA492513-A6EF-4938-ACB5-EA836379A968@gmail.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-4-christianshewitt@gmail.com>
 <1jo8o98c2c.fsf@starbuckisacylon.baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Jul 2020, at 1:14 pm, Jerome Brunet <jbrunet@baylibre.com> =
wrote:
>=20
> On Sun 19 Jul 2020 at 16:10, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
>> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of =
higher
>> clock speeds than the original ODROID-N2. Hardkernel supports the big =
cpu
>> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points =
and
>> regulator changess are from the HardKernel Linux kernel sources.
>>=20
>> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>> .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 =
+++++++++++++++++++
>> 2 files changed, 54 insertions(+)
>> create mode 100644 =
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>>=20
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
>> index 5cac4d1d487d..6dc508b80133 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D =
meson-g12b-gtking-pro.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-a311d-khadas-vim3.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-s922x-khadas-vim3.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-odroid-n2.dtb
>> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-odroid-n2-plus.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-g12b-ugoos-am6.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-kii-pro.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxbb-nanopi-k2.dtb
>> diff --git =
a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>> new file mode 100644
>> index 000000000000..99e96be509f8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-g12b-odroid-n2.dtsi"
>> +
>> +/ {
>> +	compatible =3D "hardkernel,odroid-n2-plus", "amlogic,s922x", =
"amlogic,g12b";
>> +	model =3D "Hardkernel ODROID-N2+";
>> +
>> +	vddcpu_a: regulator-vddcpu-a {
>> +		regulator-min-microvolt =3D <680000>;
>> +		regulator-max-microvolt =3D <1040000>;
>> +
>> +		pwms =3D <&pwm_ab 0 1500 0>;
>> +	};
>> +
>> +	vddcpu_b: regulator-vddcpu-b {
>> +		regulator-min-microvolt =3D <680000>;
>> +		regulator-max-microvolt =3D <1040000>;
>> +
>> +		pwms =3D <&pwm_AO_cd 1 1500 0>;
>> +	};
>> +
>> +	cpu_opp_table_0: opp-table-0 {
>> +		opp-1908000000 {
>> +			opp-hz =3D /bits/ 64 <1908000000>;
>> +			opp-microvolt =3D <1030000>;
>> +		};
>> +
>> +		opp-2016000000 {
>> +			opp-hz =3D /bits/ 64 <2016000000>;
>> +			opp-microvolt =3D <1040000>;
>> +		};
>> +	};
>> +
>> +	cpub_opp_table_1: opp-table-1 {
>> +		opp-2304000000 {
>> +			opp-hz =3D /bits/ 64 <2304000000>;
>> +			opp-microvolt =3D <1030000>;
>> +		};
>> +
>> +		opp-2400000000 {
>> +			opp-hz =3D /bits/ 64 <2400000000>;
>> +			opp-microvolt =3D <1040000>;
>> +		};
>> +	};
>=20
> Are this opp specific to the N2+ or S922x rev C ?
> If it is the latter, shouldn't these be in s922x-revC dtsi ?

N2+ is currently the only known device with RevC chip (and shipping with
a huge heatsink) so we don=E2=80=99t know. I prefer to to put them in =
the board
dts for now and move to a common dtsi in the future once we=E2=80=99ve =
seen more
devices in the wild and proven they can handle the overclock.

Christian

