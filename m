Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3E207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgFKNjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:39:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgFKNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:39:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D165AF7C;
        Thu, 11 Jun 2020 13:39:34 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] ARM: mstar: Add infinity/mercury series dtsi
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191014061617.10296-2-daniel@0x0f.com>
 <20200610090421.3428945-4-daniel@0x0f.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <bf26822d-acb0-ae40-df7f-80978bd26cfb@suse.de>
Date:   Thu, 11 Jun 2020 15:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610090421.3428945-4-daniel@0x0f.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 10.06.20 um 11:04 schrieb Daniel Palmer:
> Adds initial dtsi for the base MStar ARMv7 SoCs, family dtsis for infinity
> and mercury families, and then some chip level dtsis for chips in those
> families.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>   MAINTAINERS                              |  3 +
>   arch/arm/boot/dts/infinity-msc313.dtsi   | 14 +++++
>   arch/arm/boot/dts/infinity.dtsi          | 10 ++++
>   arch/arm/boot/dts/infinity3-msc313e.dtsi | 14 +++++
>   arch/arm/boot/dts/infinity3.dtsi         | 10 ++++
>   arch/arm/boot/dts/mercury5-ssc8336n.dtsi | 14 +++++
>   arch/arm/boot/dts/mercury5.dtsi          | 10 ++++
>   arch/arm/boot/dts/mstar-v7.dtsi          | 71 ++++++++++++++++++++++++
>   8 files changed, 146 insertions(+)

Can you split this up into three parts for easier review?

>   create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
>   create mode 100644 arch/arm/boot/dts/infinity.dtsi
>   create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
>   create mode 100644 arch/arm/boot/dts/infinity3.dtsi
>   create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
>   create mode 100644 arch/arm/boot/dts/mercury5.dtsi
>   create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 754521938303..839ae0250d3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2114,6 +2114,9 @@ ARM/MStar/Sigmastar ARMv7 SoC support
>   M:	Daniel Palmer <daniel@thingy.jp>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> +F:	arch/arm/boot/dts/infinity*.dtsi
> +F:	arch/arm/boot/dts/mercury*.dtsi
> +F:	arch/arm/boot/dts/mstar-v7.dtsi

Sort order wrt D.

>   F:	arch/arm/mach-mstar/
>   F:	Documentation/devicetree/bindings/arm/mstar.yaml
>   
> diff --git a/arch/arm/boot/dts/infinity-msc313.dtsi b/arch/arm/boot/dts/infinity-msc313.dtsi
> new file mode 100644
> index 000000000000..4eb522e6a75d
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity-msc313.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0

DTs as hardware description should be dual-licensed as either MIT or 
BSD-2-Clause, similar to the schema.

Also, elsewhere, for any code that might get reused for OpenOCD (e.g., 
clk drivers and low-level init like machine - 2/5) or other non-kernel 
projects potentially incompatible with GPL-2.0-only, it would be useful 
to use the -or-later version of the GPL for code sharing - if the 
sources you used permit that.

> +/*
> + * Copyright (c) 2019 thingy.jp.

2019-2020? Check elsewhere.

> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "infinity.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x20000000 0x4000000>;

The memory node needs to become memory@20000000 then.

> +	};

I take it, this RAM is integrated? Maybe add some explanation of what 
this file is

> +};
> diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infinity.dtsi
> new file mode 100644
> index 000000000000..25d379028689
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "mstar-v7.dtsi"
> +
> +/ {
> +};

What do you intend to add here? Is it really needed? (same below)

Pre-DT-Schema I used to add a compatible property in the .dtsi, to make 
sure we have at least the SoC's, in case someone neglects to add one in 
their board's .dts. With DT schema that's no longer valid (if enum/const 
is required), but Linux would still work better with than without.

> diff --git a/arch/arm/boot/dts/infinity3-msc313e.dtsi b/arch/arm/boot/dts/infinity3-msc313e.dtsi
> new file mode 100644
> index 000000000000..d0c53153faad
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity3-msc313e.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "infinity3.dtsi"
> +
> +/ {
> +	memory {

Ditto, unit address missing.

> +		device_type = "memory";
> +		reg = <0x20000000 0x4000000>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/infinity3.dtsi b/arch/arm/boot/dts/infinity3.dtsi
> new file mode 100644
> index 000000000000..cf5f18a07835
> --- /dev/null
> +++ b/arch/arm/boot/dts/infinity3.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "infinity.dtsi"
> +
> +/ {
> +};

Don't you anticipate incompatibilities between infinity and infinity3, 
i.e., things you don't want to inherit? Seems a bit optimistic. You can 
of course overwrite properties, but deleting is more difficult.

> diff --git a/arch/arm/boot/dts/mercury5-ssc8336n.dtsi b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
> new file mode 100644
> index 000000000000..7513f903c838
> --- /dev/null
> +++ b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "mercury5.dtsi"
> +
> +/ {
> +	memory {

Unit address.

> +		device_type = "memory";
> +		reg = <0x20000000 0x4000000>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercury5.dtsi
> new file mode 100644
> index 000000000000..25d379028689
> --- /dev/null
> +++ b/arch/arm/boot/dts/mercury5.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include "mstar-v7.dtsi"
> +
> +/ {
> +};
> diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
> new file mode 100644
> index 000000000000..0fccc4ca52a4
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-v7.dtsi

So this is the only file starting with mstar. Have you thought about 
prefixing infinity/mercury, so that they're grouped together?

> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;> 
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +		};
> +	};
> +
> +	arch_timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2)
> +				| IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <6000000>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a7-pmu";
> +		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;

Lacking interrupt-affinity.

"This property should be present when there is more than a single SPI."

To deal with single- vs. dual-core models, you should give the pmu node 
a label, e.g., arm_pmu used elsewhere, I think. Depending on your 
preferences you could set it here in common code (less work) or in the 
SoC-specific .dtsi where you know the number of CPUs for sure (safer to 
not forget later).

> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

I had been instructed not to use full identity ranges but to exclude RAM 
ranges for safety reasons.

> +
> +		gic: interrupt-controller@16001000 {
> +			compatible = "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-controller;
> +			reg = <0x16001000 0x1000>,
> +			      <0x16002000 0x1000>;

In addition to Marc's comments, please reorder reg to below compatible 
for consistency. Suggest to also reorder interrupt-controller before the 
-cells properties, after reg.

> +		};
> +
> +		pm_uart: uart@1f221000 {
> +			compatible = "ns16550a";
> +			reg = <0x1f221000 0x100>;
> +			reg-shift = <3>;
> +			clock-frequency = <172000000>;
> +			status = "disabled";
> +		};

If you have any decent manuals for these SoCs, I suggest to check 
whether there are any internal buses that you may want to model as 
simple-bus for grouping. In-tree examples include meson and recently 
merged rtd1195 - it affects the reg addresses and unit addresses via 
suitable ranges mappings.

> +	};
> +};

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
