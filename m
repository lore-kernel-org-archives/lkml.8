Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5228820771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="C48UkXkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3F1dORF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgGWQyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:54:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52905 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgGWQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:54:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E37AE5C00FE;
        Thu, 23 Jul 2020 12:54:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Jul 2020 12:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=N
        aypVAu5q5bWw5EDqU/ZD81JjsTy8wVq+ErZYa1wjzg=; b=C48UkXkpzRRFWsN/y
        HQ2mVp4+rpu2C+IMnrWrkji+n0JtRvMgMNv3GB4zInYZU7lVJYtk0J/JnkRFXnlv
        JHlhk8g8Pdxj8J0hJvATwtBhJLGXmZR90bN+Zbn+YBMmuPKIXeJfbqPQWsJwGLyQ
        /FwozXDMTIa1ggWeRYuymmxdByEbKC+MYLbqH0Q3/Mx0p56LpZLljQl4TS24RsEP
        XGeRJlTIsXkJf6P3mnHb/DjQu5Asjg8p5c3epM3oDaJfEtoKNND4UQNIAnpoTpIu
        4iw5WWLBjalxxCLDBmoPMkmu3fcUL+JoKIb7RrphxTEK/9ItYd5EcEDFCFwPiWPy
        M/uAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=NaypVAu5q5bWw5EDqU/ZD81JjsTy8wVq+ErZYa1wj
        zg=; b=a3F1dORFPnqjQCWf/vHtmHFsDqp6pRf6LdBIOkgwR1kpzOKu7fLycwb8i
        WjrBJi1//rDrKzAg2SRGH2LnABR7jrvIK8dlW3DL3YDMdQvs1beUDV6j3HX/dj/L
        vqVdtOq+yemGqrnTh5RAEsRwKjEgHuGV9+FRRbjhihNsZytEApIeIrIJ5ZZw/DWa
        jTt/QLvBQvjV2RRwbMG1uT9qsn9AtfZcPVG0yt5dSH6ivWkjp1KNBmDY8lhFp38C
        Em5VEItyFes0F2A8TKifNZsjAUnQvrLRXoOLK5P/hPo7tSiFbyrWlb3qEkJIJMaS
        77NCyZZPzyhXxTMMXBe+k5xkdjodQ==
X-ME-Sender: <xms:2sAZX1xZgiYvlOQpmBUKsx-Uqg92lS4ZvlBDaWDqec9oiO8WwDPu6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrhedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2sAZX1TQjvIMb6bUbjt_aHp8bJkIaGXt60Wpa7ZFeSKDYdxkJhBAuQ>
    <xmx:2sAZX_WDynJ77bQg6qss3VXagrKspPxGf87_7O--xJ3dImYE5kxiXQ>
    <xmx:2sAZX3i5hzPonsdp63bRrIleGztI5MJECIRcET9iWR09ZHniXgHtPw>
    <xmx:3MAZXy5xg--258A-Q9bapyxLZCCCx6JT1ZEReeFdxU181qgcxYCHXA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C7853280064;
        Thu, 23 Jul 2020 12:54:50 -0400 (EDT)
Date:   Thu, 23 Jul 2020 18:54:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v4 14/16] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
Message-ID: <20200723165448.crdc4fc5jwqmsret@gilmour.lan>
References: <cover.1594708863.git.frank@allwinnertech.com>
 <f7f86c648bad6e72f8fc8117b96065bf5326a273.1594708864.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f7f86c648bad6e72f8fc8117b96065bf5326a273.1594708864.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 03:20:29PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
> the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
> nmi, and UART support.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 364 ++++++++++++++++++
>  1 file changed, 364 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> new file mode 100644
> index 000000000000..3fb2443f2121
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-a100-ccu.h>
> +#include <dt-bindings/clock/sun50i-a100-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-a100-ccu.h>
> +#include <dt-bindings/reset/sun50i-a100-r-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,armv8";

You should use the arm,cortex-a53 compatible here, arm,armv8 is for
software models.

> +		sid@3006000 {

The node name is supposed to be the class of the device, and the DT spec
defines a list of them already. eeprom would be better suited here.

> +	thermal-zones {
> +		cpu-thermal-zone {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths 0>;
> +		};
> +
> +		gpu-thermal-zone {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths 1>;
> +		};
> +
> +		ddr-thermal-zone {
> +			polling-delay-passive =3D <0>;
> +			polling-delay =3D <0>;
> +			thermal-sensors =3D <&ths 2>;
> +		};
> +	};

Ideally, the nodes here should be ordered by alphabetical order (so ddr
before GPU).

Thanks!
Maxime
