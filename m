Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D414C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EF920720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgFWCQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:16:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgFWCQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:16:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DC95AE18;
        Tue, 23 Jun 2020 02:16:10 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 Pym Particles EVB
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20200620233227.31585-1-afaerber@suse.de>
 <20200620233227.31585-4-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <fd6ad520-54f2-076c-dd4c-34a4bf426b22@suse.de>
Date:   Tue, 23 Jun 2020 04:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620233227.31585-4-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 21.06.20 um 01:32 schrieb Andreas Färber:
> From: James Tai <james.tai@realtek.com>
> 
> Add Device Trees for Realtek RTD1319 SoC family, RTD1319 SoC and
> Realtek Pym Particles EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>   v3 -> v4:
>   * Updated Realtek copyright for 2 out of 3 files from v3
>   * Renamed from rtd1319-pymparticle.dts to rtd1319-pymparticles.dts
>   * Updated compatible from pymparticle to pym-particles
>   * Updated PMU compatible from armv8-pmuv3 to cortex-a55-pmu (Robin)
>   
>   v2 -> v3:
>   * Add virtual maintenance interrupt for architecture timer
>   * Correct the GIC redistributor address range
[...]
> diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
> new file mode 100644
> index 000000000000..8c5b6fc7b8eb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
[...]
> +		gic: interrupt-controller@ff100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0xff100000 0x10000>,
> +			      <0xff140000 0x80000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

In my testing this appears to cause the following error:

[    2.239858] irq: type mismatch, failed to map hwirq-25 for 
interrupt-controller@ff100000!
...
[    3.505649] kvm [1]: IPA Size Limit: 40bits
[    3.506051] kvm [1]: GICv3: no GICV resource entry
[    3.506058] kvm [1]: disabling GICv2 emulation
[    3.506081] kvm [1]: GIC system register CPU interface enabled
[    3.506175] kvm [1]: vgic interrupt IRQ1
[    3.506293] kvm [1]: Hyp mode initialized successfully

If I change it to IRQ_TYPE_LEVEL_LOW, that error goes away:

[    3.506030] kvm [1]: IPA Size Limit: 40bits
[    3.506430] kvm [1]: GICv3: no GICV resource entry
[    3.506437] kvm [1]: disabling GICv2 emulation
[    3.506459] kvm [1]: GIC system register CPU interface enabled
[    3.506551] kvm [1]: vgic interrupt IRQ1
[    3.506672] kvm [1]: Hyp mode initialized successfully

In-tree RTD1619 has it as HIGH, too, but doesn't show above error:

[    2.918973] kvm [1]: IPA Size Limit: 40bits
[    2.919345] kvm [1]: GICv3: no GICV resource entry
[    2.919352] kvm [1]: disabling GICv2 emulation
[    2.919373] kvm [1]: GIC system register CPU interface enabled
[    2.919522] kvm [1]: vgic interrupt IRQ1
[    2.919700] kvm [1]: Hyp mode initialized successfully

RTD1619 doesn't show an error either if I change it to LOW though:

[    2.918843] kvm [1]: IPA Size Limit: 40bits
[    2.919212] kvm [1]: GICv3: no GICV resource entry
[    2.919218] kvm [1]: disabling GICv2 emulation
[    2.919240] kvm [1]: GIC system register CPU interface enabled
[    2.919390] kvm [1]: vgic interrupt IRQ1
[    2.919567] kvm [1]: Hyp mode initialized successfully

The GICv3 bindings example does have it as 4 == HIGH, but so does the 
GICv2 binding example, and yet we used LOW == 8 for in-tree RTD139x, 
RTD129x and RTD1195. The downstream BSP uses value 4 == HIGH for both 
RTD16xx and RTD13xx - is it possible this was never actually tested?

Thanks in advance for clarifying the correct interrupt polarity.

> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
[snip]

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
