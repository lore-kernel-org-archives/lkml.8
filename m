Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14BFC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6552168B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897559AbgDOLoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:53278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897395AbgDOLlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:41:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7CA0AEE7;
        Wed, 15 Apr 2020 11:41:15 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-3-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <842e8a9d-cdd6-cb85-ce85-17f20ff7b626@suse.de>
Date:   Wed, 15 Apr 2020 13:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200204145207.28622-3-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

A couple more nits to consider for v4:

Am 04.02.20 um 15:52 schrieb James Tai:
> diff --git a/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
> new file mode 100644
> index 000000000000..2a36d220fef6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2019 Realtek Semiconductor Corp.

2019-2020? (also elsewhere)

> + */
> +
> +/dts-v1/;
> +
> +#include "rtd1319.dtsi"
> +
> +/ {
> +	compatible = "realtek,pymparticle", "realtek,rtd1319";
> +	model = "Realtek PymParticle EVB";
> +
> +	memory@2e000 {
> +		device_type = "memory";
> +		reg = <0x2e000 0x3ffd2000>; /* boot ROM to 1 GiB or 2 GiB */
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:460800n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};
> +};
> +
> +/* debug console (J1) */
> +&uart0 {
> +	status = "okay";
> +};
> +
> +/* M.2 slot (CON8) */

Also J14 and CON2 (unless the board is mislabeled?).

/* J14 and M.2 slots (CON2, CON8) */ ?

> +&uart1 {
> +	status = "disabled";
> +};
> +
> +/* GPIO connector (T1) */
> +&uart2 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/realtek/rtd1319.dtsi b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
> new file mode 100644
> index 000000000000..1dcee00009cd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1319 SoC
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include "rtd13xx.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1319";
> +};
> diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> new file mode 100644
> index 000000000000..f6d73f18345d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD13xx SoC family
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +/memreserve/	0x0000000000000000 0x000000000002e000; /* Boot ROM */

Can you check whether your U-Boot and LK respectively need this 
memreserve entry, here and for previous SoCs? Because for RTD16xx we 
don't seem to have any memreserve entries at all. We do have it in 
rtd139x.dtsi, rtd129x.dtsi and rtd1195.dtsi.

Unrelated: Since we're carving out the 2e000 or so from /memory node and 
mapping ranges for /soc, I've been wondering whether we should represent 
the Boot ROM as node somehow. But since it's a ROM with (I assume) 
binary code only, I didn't see any need to have it accessible as mtd-rom 
device, so it's way down my to-do list to research how other mainline 
platforms might model their boot ROMs... (maybe your team has time, or 
someone reading happens to know?)

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mtd/mtd-physmap.txt

> +/memreserve/	0x000000000002e000 0x0000000000100000; /* Boot loader */

Is this a) correctly sized (not 0xd2000?) and b) still needed? I thought 
the documented sub-0x100000 memory corruption were fixed in newer BSPs?

> +/memreserve/	0x000000000f400000 0x0000000000500000; /* Video FW */
> +/memreserve/	0x000000000f900000 0x0000000000500000; /* Audio FW */
> +/memreserve/	0x0000000010000000 0x0000000000014000; /* Audio FW RAM */
[snip]

Are these needed for the bootloader not to overwrite preloaded firmware, 
or could these become /mem-reserve sub-nodes instead?

Long-term I'm assuming we would move the responsibility for loading 
these to the new kernel drivers (so that the bootloader doesn't need to 
take care anymore) and ship the needed blobs in linux-firmware.git?

Or is the video FW needed by the bootloader itself for HDMI/DP output?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
