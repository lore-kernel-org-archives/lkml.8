Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0612620737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nxlxNSZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGQH0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:26:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55818 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:26:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7QCjL011362;
        Fri, 17 Jul 2020 02:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594970772;
        bh=tKYwrKi8X1cOjaOBmnoL7GIPg/AdrpmzkkkGA5eACeI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=nxlxNSZg8Jm2Pb23OGBeg1ab3FzMclsQI67sYUzne2e35HB7UagRokLGe7NA3nf8E
         NkT3hRlTD183yp60jPxn2xrlE4fFlK3xWzMMuKe2THKQVOgBefk8FVOhX/aTish9U3
         pruvwGWnlYjpMG4bBmkkKJH7p3HfwGQ5VGXbSVgc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7QCMT048479;
        Fri, 17 Jul 2020 02:26:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:26:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:26:12 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7Q9nD065861;
        Fri, 17 Jul 2020 02:26:10 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, <nm@ti.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200713101409.33131-1-grandmaster@al2klimov.de>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <98a8c378-3220-65e0-965c-5b0f4167605d@ti.com>
Date:   Fri, 17 Jul 2020 10:26:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713101409.33131-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 13:14, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Queued up for 5.9, thanks.

-Tero

> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>   (Actually letting a shell for loop submit all this stuff for me.)
> 
>   If there are any URLs to be removed completely or at least not just HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
> 
>   Sorry again to all maintainers who complained about subject lines.
>   Now I realized that you want an actually perfect prefixes,
>   not just subsystem ones.
>   I tried my best...
>   And yes, *I could* (at least half-)automate it.
>   Impossible is nothing! :)
> 
> 
>   arch/arm64/boot/dts/ti/Makefile                       | 2 +-
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi              | 2 +-
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi               | 2 +-
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            | 2 +-
>   arch/arm64/boot/dts/ti/k3-am65.dtsi                   | 2 +-
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts        | 2 +-
>   arch/arm64/boot/dts/ti/k3-am654.dtsi                  | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi           | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi                  | 2 +-
>   include/dt-bindings/pinctrl/k3.h                      | 2 +-
>   13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index b397945fdf73..05c0bebf65d4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -3,7 +3,7 @@
>   # Make file to build device tree binaries for boards based on
>   # Texas Instruments Inc processors
>   #
> -# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> +# Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>   #
>   
>   dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 61815228e230..940acc6cbf26 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for AM6 SoC Family Main Domain peripherals
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   #include <dt-bindings/phy/phy-am654-serdes.h>
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index ae5f813d0cac..8c1abcfe0860 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for AM6 SoC Family MCU Domain peripherals
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_mcu {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 54a133fa1bf2..dd75a5592539 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_wakeup {
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 5be75e430965..27c0406b10ba 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for AM6 SoC Family
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 2f3d3316a1cf..78084a507fcf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> index b221abf43ac2..f0a6541b8042 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for AM6 SoC family in Quad core configuration
>    *
> - * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include "k3-am65.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 6df823aaa37c..7de37e8abfbb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 96c929da639d..bdeda701af7c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for J721E SoC Family Main Domain peripherals
>    *
> - * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_main {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index dc31bd0434cb..4e1865d2d4b1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for J721E SoC Family MCU/WAKEUP Domain peripherals
>    *
> - * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   &cbass_mcu_wakeup {
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> index 7680109ca60a..8fa3361e5e45 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index 2f9a56d9b114..d035b61e0e16 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -2,7 +2,7 @@
>   /*
>    * Device Tree Source for J721E SoC Family
>    *
> - * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2016-2019 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
>   #include <dt-bindings/interrupt-controller/irq.h>
> diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
> index 499de6216581..b0eea7cc6e23 100644
> --- a/include/dt-bindings/pinctrl/k3.h
> +++ b/include/dt-bindings/pinctrl/k3.h
> @@ -3,7 +3,7 @@
>    * This header provides constants for pinctrl bindings for TI's K3 SoC
>    * family.
>    *
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   #ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
>   #define _DT_BINDINGS_PINCTRL_TI_K3_H
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
