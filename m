Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A54CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A096204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JQknSTKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zJ1fXNvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgEYEMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:10 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46135 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgEYEMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 71888580083;
        Mon, 25 May 2020 00:12:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=8
        sfE3Rj57EXEb0jRYnEljRCSEHaUZbE+p8wZWGAhY6k=; b=JQknSTKOuNnJEf3Zo
        rCQkybtAbsW8Vofu18b+NlL7ni3R8OyOhkuUzsHDPXpUjFB5OQnf/wr9SXsA6Ojd
        K9y4jr9tIann9UxXb6cgxG7uUK27Uxc75tZaXfV+VJcXY/1KHJUhW/PbF0Tz+iDE
        MqYMlvRqIbqhGWehoQQvraekw+MfrjVEQMzUICkj88zWRf4LXNZ24p0vvn4rJ7A4
        Wu79SFHwxHMJxAa61bAQUAOtsrjPobnwUEoQH1vIMrjmG2lZwdd8HX/zwfl4aRbp
        HaKGR1sPMj2TNMiUuS1l+HGFVQk0EXpUPvYZPNEQIZimmKukK22f/UVd4JRIsQLc
        yaY9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8sfE3Rj57EXEb0jRYnEljRCSEHaUZbE+p8wZWGAhY
        6k=; b=zJ1fXNvn4vtcrQFkf+F7reH6Go3EdR9vY7TRsCY5RPBfh/NF2WMiCZPJ8
        eh43FpmHtJBhiKN8DRHkdw10pBiBzmKBKpXDYx3/umSPCG8JZ13vu+DsHALjjQZ0
        nR/d7/ssrzm50rw++YuI5A/EgbCQ+y3Ed4yECZNN3hSvIZCxFedcssq98v/QfkKZ
        md7Cj0/5sZ706NH8MbkbrmAbV3nJtU6RgeJcFLLWDVhX0qTEJURUvNbS2yzNf7eE
        u4uxirjaEahSKg0m23ReY9kDucoM8tYQJvZGg4MErA97v5CiOVuVMT3p4VRmKtMY
        +BFerLfa2y+U9lmFT3AqFyd5nKMgA==
X-ME-Sender: <xms:k0XLXmhe9vs-ViR4UPEvLmgjNq7yEbSYGGH9mWTXWBRGKJiGhBXXXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdehudeujeeileevjeekffdvjeeludfhfedukeeiffetuefgkeet
    heehkeffueetnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgpdhshhholh
    hlrghnugdrohhrghenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholh
    hlrghnugdrohhrgh
X-ME-Proxy: <xmx:k0XLXnC-jSBYOIirisgTzWbL1Sv-B4RlyzREEMau1ye5TeNG_0bhVg>
    <xmx:k0XLXuENE9x-SpMrvtqjC3sZIlFIpzOapSE-Vo8UgISrXgi0BrFLpg>
    <xmx:k0XLXvR65ADaoWJJDu-RI0SU8IzHzzWxQNxup1PiWr3EB2KpsrMLtA>
    <xmx:lkXLXorvCxxr18oEbEe27FhQwxy2EXOBtu2UPHtjgKgnJ33-DC8qdw>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EFC6306654D;
        Mon, 25 May 2020 00:12:02 -0400 (EDT)
Subject: Re: [PATCH 1/9] irqchip/sun6i-r: Switch to a stacked irqchip driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200113044936.26038-1-samuel@sholland.org>
 <20200113044936.26038-2-samuel@sholland.org>
 <22bbdefdc0060e1eacb2c3a41dffebe4@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fb984b28-0aee-b3ac-8cdc-e15df33e17d8@sholland.org>
Date:   Sun, 24 May 2020 23:12:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <22bbdefdc0060e1eacb2c3a41dffebe4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, and thanks for the feedback!

I know this is quite the delay in responding; I wanted to make sure my
understanding of the hardware was as clear as possible before sending a v2.

After experimentation, I came up with a diagram describing the hardware
architecture, available here:
https://linux-sunxi.org/images/5/5c/R_INTC.png (PNG)
https://sholland.org/files/R_INTC_v2.svg (SVG)

Based on that, your feedback, and similar examples like the great explanation of
the robustness requirements in 6dd859508336 ("gpio: zynq: Fix IRQ handlers"), I
think v2 will work properly for both edge and level interrupts. I tested both
triggers, albeit with the same source of (level) interrupts connected to the NMI
pin.

On 1/20/20 4:52 AM, Marc Zyngier wrote:
> Hi Samuel,
> 
> On 2020-01-13 05:49, Samuel Holland wrote:
>> The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
>> original sun4i interrupt controller than the sun7i/sun9i NMI controller.
>> It is used for two distinct purposes:
>>  1) To control the trigger and mask for the NMI input pin
>>  2) To provide the interrupt input for the ARISC coprocessor
>>
>> As this interrupt controller is not documented, information about it
>> comes from reverse-engineering the BSP-provided ARISC firmware.
>>
>> Like the original sun4i interrupt controller, it has:
>>  - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
>>  - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
>>    sun4i and sunxi-nmi drivers
>>  - A MASK_REG at 0x50
>>
>> Differences from the sun4i interrupt controller appear to be:
>>  - It is only known to have one register of each kind (max 32 inputs)
>>  - There is no FIQ-related logic
>>  - There is no interrupt priority logic
>>
>> In order to fulfill its two purposes, this hardware block combines two
>> types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
>> chip, with a trigger type controlled by the NMI_CTRL_REG. The (masked)
>> "IRQ 0 pending" output from this chip is then routed to a non-maskable
>> SPI IRQ input on the GIC, as IRQ_TYPE_LEVEL_HIGH. In other words, bit 0
> 
> I object to the "non-maskable" wording here. It may be non-maskable
> at this irqchip level (and yet you seem to have code to that effect),
> but the GIC definitely should be able to mask things.

You're 100% correct here. I had thought IRQ 0 was non-maskable because the MASK
register didn't affect the IRQ being sent to the GIC. Disabling the IRQ via
GICD_ICENABLER does indeed work.

>> of ENABLE_REG and MASK_REG *do* affect the IRQs seen at the GIC.
>>
>> The NMI is then followed by a contiguous block of (at least) 15 IRQ
>> inputs that are connected *in parallel* to both R_INTC and the GIC. Or
>> in other words, the other bits of ENABLE_REG and MASK_REG *do not*
>> affect the IRQs seen at the GIC.
>>
>> Finally, the global "IRQ pending" output from R_INTC is connected to the
>> "external interrupt" input of the ARISC CPU (an OR1200).
>>
>> Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
>> a perfect scenario for using a stacked irqchip driver. We want to hook
>> into enabling/disabling/masking IRQs to add more features to the GIC
>> (specifically to allow masking the NMI and setting its trigger type),
>> but we don't need to actually *handle* the IRQ.
>>
>> And since R_INTC is in the always-on power domain, and its output is
>> connected directly in to the power management coprocessor, a stacked
>> irqchip driver provides a simple way to add wakeup support to this set
>> of IRQs. That is a future patch; for now, just the NMI is moved over.
>>
>> This driver keeps the same DT binding as the existing driver. The
>> "interrupt" property of the R_INTC node is used to determine 1) the
>> offset between GIC and R_INTC hwirq numbers and 2) the type of trigger
>> between the R_INTC "IRQ 0 pending" output and the GIC NMI input.
>>
>> This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
>> Support sun6i-a31-r-intc compatible").
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  arch/arm/mach-sunxi/Kconfig     |   1 +
>>  arch/arm64/Kconfig.platforms    |   1 +
>>  drivers/irqchip/Makefile        |   1 +
>>  drivers/irqchip/irq-sun6i-r.c   | 220 ++++++++++++++++++++++++++++++++
>>  drivers/irqchip/irq-sunxi-nmi.c |  26 +---
>>  5 files changed, 226 insertions(+), 23 deletions(-)
>>  create mode 100644 drivers/irqchip/irq-sun6i-r.c
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index eeadb1a4dcfe..ef1cc25902b5 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -6,6 +6,7 @@ menuconfig ARCH_SUNXI
>>      select CLKSRC_MMIO
>>      select GENERIC_IRQ_CHIP
>>      select GPIOLIB
>> +    select IRQ_DOMAIN_HIERARCHY
>>      select PINCTRL
>>      select PM_OPP
>>      select SUN4I_TIMER
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 16d761475a86..d282d0a1d17d 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -17,6 +17,7 @@ config ARCH_SUNXI
>>      bool "Allwinner sunxi 64-bit SoC Family"
>>      select ARCH_HAS_RESET_CONTROLLER
>>      select GENERIC_IRQ_CHIP
>> +    select IRQ_DOMAIN_HIERARCHY
>>      select PINCTRL
>>      select RESET_CONTROLLER
>>      help
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index cc7c43932f16..41996d98c30a 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_OR1K_PIC)            += irq-or1k-pic.o
>>  obj-$(CONFIG_ORION_IRQCHIP)        += irq-orion.o
>>  obj-$(CONFIG_OMAP_IRQCHIP)        += irq-omap-intc.o
>>  obj-$(CONFIG_ARCH_SUNXI)        += irq-sun4i.o
>> +obj-$(CONFIG_ARCH_SUNXI)        += irq-sun6i-r.o
>>  obj-$(CONFIG_ARCH_SUNXI)        += irq-sunxi-nmi.o
>>  obj-$(CONFIG_ARCH_SPEAR3XX)        += spear-shirq.o
>>  obj-$(CONFIG_ARM_GIC)            += irq-gic.o irq-gic-common.o
>> diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
>> new file mode 100644
>> index 000000000000..37b6e9c60bf8
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sun6i-r.c
>> @@ -0,0 +1,220 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Allwinner A31 and newer SoCs R_INTC driver
>> +//
>> +
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +#define NMI_HWIRQ        0
>> +
>> +#define SUN6I_R_INTC_NR_IRQS    16
>> +
>> +#define SUN6I_R_INTC_CTRL    0x0c
>> +#define SUN6I_R_INTC_PENDING    0x10
>> +#define SUN6I_R_INTC_ENABLE    0x40
>> +#define SUN6I_R_INTC_MASK    0x50
>> +
>> +enum {
>> +    SUNXI_SRC_TYPE_LEVEL_LOW = 0,
>> +    SUNXI_SRC_TYPE_EDGE_FALLING,
>> +    SUNXI_SRC_TYPE_LEVEL_HIGH,
>> +    SUNXI_SRC_TYPE_EDGE_RISING,
>> +};
> 
> It is unusual to use an enum for values that get directly programmed
> into the HW.

These definitons match the existing driver this was split from. I will inline
these for v2.

>> +
>> +static void __iomem *base;
>> +static irq_hw_number_t parent_offset;
>> +static u32 parent_type;
>> +
>> +static void sun6i_r_intc_irq_enable(struct irq_data *data)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ)
>> +        writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_ENABLE);
> 
> Please consider using _relaxed() accessors.

I've done this for v2.

>> +
>> +    irq_chip_enable_parent(data);
>> +}
>> +
>> +static void sun6i_r_intc_irq_disable(struct irq_data *data)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ)
>> +        writel(0, base + SUN6I_R_INTC_ENABLE);
>> +
>> +    irq_chip_disable_parent(data);
>> +}
>> +
>> +static void sun6i_r_intc_irq_mask(struct irq_data *data)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ)
>> +        writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_MASK);
>> +
>> +    irq_chip_mask_parent(data);
>> +}
>> +
>> +static void sun6i_r_intc_irq_unmask(struct irq_data *data)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ)
>> +        writel(0, base + SUN6I_R_INTC_MASK);
>> +
>> +    irq_chip_unmask_parent(data);
>> +}
>> +
>> +static void sun6i_r_intc_irq_eoi(struct irq_data *data)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ)
>> +        writel(BIT(NMI_HWIRQ), base + SUN6I_R_INTC_PENDING);
> 
> Are you sure about this? Clearing the pending bit is not quite an EOI.
> It won't hurt a level interrupt, but could be pretty deadly with
> edge signaling (you'd loose that interrupt). But does this register
> actually latch the input until you clear it? Or does it follow the
> level of its input?

For bit 0 (the only one Linux cares about), there is a latch. This latch gets
set whenever the IRQ is triggered (once for edge, continuously for level), and
it gets reset by writing 1 to PENDING.

What I've done for v2 is set this bit in .irq_ack for edge, and .irq_eoi for level.

>> +
>> +    irq_chip_eoi_parent(data);
>> +}
>> +
>> +static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
>> +{
>> +    if (data->hwirq == NMI_HWIRQ) {
>> +        u32 src_type;
>> +
>> +        switch (type) {
>> +        case IRQ_TYPE_EDGE_FALLING:
>> +            src_type = SUNXI_SRC_TYPE_EDGE_FALLING;
>> +            break;
>> +        case IRQ_TYPE_EDGE_RISING:
>> +            src_type = SUNXI_SRC_TYPE_EDGE_RISING;
>> +            break;
>> +        case IRQ_TYPE_LEVEL_HIGH:
>> +            src_type = SUNXI_SRC_TYPE_LEVEL_HIGH;
>> +            break;
>> +        case IRQ_TYPE_NONE:
> 
> What does "IRQ_TYPE_NONE" mean here?

It means that IRQ_TYPE_NONE was put in the specifier in the device tree (this is
copied from the other driver). Since this should never happen, I've removed this
case in v2.

>> +        case IRQ_TYPE_LEVEL_LOW:
>> +            src_type = SUNXI_SRC_TYPE_LEVEL_LOW;
>> +            break;
>> +        default:
>> +            pr_err("%pOF: invalid trigger type %d for IRQ %d\n",
>> +                   irq_domain_get_of_node(data->domain), type,
>> +                   data->irq);
>> +            return -EBADR;
>> +        }
>> +        writel(src_type, base + SUN6I_R_INTC_CTRL);
>> +
>> +        irqd_set_trigger_type(data, type);
> 
> It is odd to update this from a driver. Specially that you change it
> before finding out if the parent call has succeeded or not.

Yes, I'm not sure what I was doing there. I've removed this.

>> +
>> +        /* Send the R_INTC -> GIC trigger type to the GIC driver. */
>> +        type = parent_type;
>> +    }
>> +
>> +    return irq_chip_set_type_parent(data, type);
> 
> Half of the above signaling modes are invalid for the GIC. Does this
> widget actually invert the signalling when the input is either
> level low or falling edge?

Yes. The signal sent to the GIC is effectively bit 0 of the PENDING register. So
it's a "1" when the IRQ is triggered, regardless of the physical pin trigger type.

>> +}
>> +
>> +static struct irq_chip sun6i_r_intc_chip = {
>> +    .name            = "sun6i-r-intc",
>> +    .irq_enable        = sun6i_r_intc_irq_enable,
>> +    .irq_disable        = sun6i_r_intc_irq_disable,
>> +    .irq_mask        = sun6i_r_intc_irq_mask,
>> +    .irq_unmask        = sun6i_r_intc_irq_unmask,
> 
> What is the upshot of having both enable/disable and mask/unmask?
> Given that the GIC only supports the latter, I'd expect this driver
> to leave everything enabled, and only deal with mask/unmask.

This makes sense. I've done this for v2.

>> +    .irq_eoi        = sun6i_r_intc_irq_eoi,
>> +    .irq_set_affinity    = irq_chip_set_affinity_parent,
>> +    .irq_retrigger        = irq_chip_retrigger_hierarchy,
>> +    .irq_set_type        = sun6i_r_intc_irq_set_type,
>> +    .irq_set_vcpu_affinity    = irq_chip_set_vcpu_affinity_parent,
> 
> Under which circumstances do you expect this to be called?

Under the same circumstances as the underlying GIC callback. It's my
understanding that irq_chip hooks always go to the outermost irqdomain in the
hierarchy. So the only way the GIC driver functions get called is if I call them
here with irq_chip_*_parent. Presumably, all of the GIC functions are there for
a reason, so I should expose them.

The same appears to be the case for .flags: flags from the inner irqdomains have
to be duplicated here, because the core interrupt handling code only looks at
the flags of desc->irq_data.chip->flags, which is the outermost irqdomain in the
hierarchy.

>> +};
>> +
>> +static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
>> +                     struct irq_fwspec *fwspec,
>> +                     unsigned long *hwirq,
>> +                     unsigned int *type)
>> +{
>> +    if (!is_of_node(fwspec->fwnode) || fwspec->param_count != 2)
>> +        return -EINVAL;
>> +
>> +    *hwirq = fwspec->param[0];
>> +    *type  = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +
>> +    return 0;
>> +}
>> +
>> +static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
>> +                     unsigned int virq,
>> +                     unsigned int nr_irqs, void *arg)
>> +{
>> +    struct irq_fwspec *fwspec = arg;
>> +    struct irq_fwspec gic_fwspec;
>> +    irq_hw_number_t hwirq;
>> +    unsigned int type;
>> +    int i, ret;
>> +
>> +    ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
>> +    if (ret)
>> +        return ret;
>> +    if (hwirq + nr_irqs > SUN6I_R_INTC_NR_IRQS)
>> +        return -EINVAL;
>> +
>> +    /* Construct a GIC-compatible fwspec from this fwspec. */
>> +    gic_fwspec = (struct irq_fwspec) {
>> +        .fwnode      = domain->parent->fwnode,
>> +        .param_count = 3,
>> +        .param       = { GIC_SPI, parent_offset + hwirq, type },
> 
> Same problem here. The GIC only supports level-high and rising-edge
> for SPIs.

This actually doesn't cause any errors. The only check that the GIC does on the
"type" parameter during .translate is verifying that it is not IRQ_TYPE_NONE,
and no additional checks are done during .alloc. In fact, nothing seems to
really care about "type" during .alloc. They just want "hwirq", and it's
convenient to use .translate to get that.

>> +    };
>> +
>> +    for (i = 0; i < nr_irqs; ++i)
>> +        irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> +                          &sun6i_r_intc_chip, NULL);
>> +
>> +    return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
>> +    .translate    = sun6i_r_intc_domain_translate,
>> +    .alloc        = sun6i_r_intc_domain_alloc,
>> +    .free        = irq_domain_free_irqs_common,
>> +};
>> +
>> +static int __init sun6i_r_intc_init(struct device_node *node,
>> +                    struct device_node *parent)
>> +{
>> +    struct irq_domain *domain, *parent_domain;
>> +    struct of_phandle_args parent_irq;
>> +    int ret;
>> +
>> +    /* Extract the R_INTC -> GIC mapping from the OF node. */
>> +    ret = of_irq_parse_one(node, 0, &parent_irq);
>> +    if (ret)
>> +        return ret;
>> +    if (parent_irq.args_count != 3 || parent_irq.args[0] != GIC_SPI)
>> +        return -EINVAL;
>> +    parent_offset = parent_irq.args[1];
>> +    parent_type   = parent_irq.args[2];
>> +
>> +    parent_domain = irq_find_host(parent);
>> +    if (!parent_domain) {
>> +        pr_err("%pOF: Failed to obtain parent domain\n", node);
>> +        return -ENXIO;
>> +    }
>> +
>> +    base = of_io_request_and_map(node, 0, NULL);
>> +    if (IS_ERR(base)) {
>> +        pr_err("%pOF: Failed to map MMIO region\n", node);
>> +        return PTR_ERR(base);
>> +    }
>> +
>> +    domain = irq_domain_add_hierarchy(parent_domain, 0,
>> +                      SUN6I_R_INTC_NR_IRQS, node,
>> +                      &sun6i_r_intc_domain_ops, NULL);
>> +    if (!domain) {
>> +        pr_err("%pOF: Failed to allocate domain\n", node);
>> +        iounmap(base);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    /* Disable and unmask all interrupts. */
>> +    writel(0, base + SUN6I_R_INTC_ENABLE);
>> +    writel(0, base + SUN6I_R_INTC_MASK);
>> +
>> +    /* Clear any pending interrupts. */
>> +    writel(~0, base + SUN6I_R_INTC_PENDING);
>> +
>> +    return 0;
>> +}
>> +IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
>> diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
>> index a412b5d5d0fa..9f2bd0c5d289 100644
>> --- a/drivers/irqchip/irq-sunxi-nmi.c
>> +++ b/drivers/irqchip/irq-sunxi-nmi.c
>> @@ -27,18 +27,12 @@
>>
>>  #define SUNXI_NMI_IRQ_BIT    BIT(0)
>>
>> -#define SUN6I_R_INTC_CTRL    0x0c
>> -#define SUN6I_R_INTC_PENDING    0x10
>> -#define SUN6I_R_INTC_ENABLE    0x40
>> -
>>  /*
>>   * For deprecated sun6i-a31-sc-nmi compatible.
>> - * Registers are offset by 0x0c.
>>   */
>> -#define SUN6I_R_INTC_NMI_OFFSET    0x0c
>> -#define SUN6I_NMI_CTRL        (SUN6I_R_INTC_CTRL - SUN6I_R_INTC_NMI_OFFSET)
>> -#define SUN6I_NMI_PENDING    (SUN6I_R_INTC_PENDING - SUN6I_R_INTC_NMI_OFFSET)
>> -#define SUN6I_NMI_ENABLE    (SUN6I_R_INTC_ENABLE - SUN6I_R_INTC_NMI_OFFSET)
>> +#define SUN6I_NMI_CTRL        0x00
>> +#define SUN6I_NMI_PENDING    0x04
>> +#define SUN6I_NMI_ENABLE    0x34
>>
>>  #define SUN7I_NMI_CTRL        0x00
>>  #define SUN7I_NMI_PENDING    0x04
>> @@ -61,12 +55,6 @@ struct sunxi_sc_nmi_reg_offs {
>>      u32 enable;
>>  };
>>
>> -static const struct sunxi_sc_nmi_reg_offs sun6i_r_intc_reg_offs __initconst = {
>> -    .ctrl    = SUN6I_R_INTC_CTRL,
>> -    .pend    = SUN6I_R_INTC_PENDING,
>> -    .enable    = SUN6I_R_INTC_ENABLE,
>> -};
>> -
>>  static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
>>      .ctrl    = SUN6I_NMI_CTRL,
>>      .pend    = SUN6I_NMI_PENDING,
>> @@ -232,14 +220,6 @@ static int __init sunxi_sc_nmi_irq_init(struct
>> device_node *node,
>>      return ret;
>>  }
>>
>> -static int __init sun6i_r_intc_irq_init(struct device_node *node,
>> -                    struct device_node *parent)
>> -{
>> -    return sunxi_sc_nmi_irq_init(node, &sun6i_r_intc_reg_offs);
>> -}
>> -IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc",
>> -        sun6i_r_intc_irq_init);
>> -
>>  static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
>>                      struct device_node *parent)
>>  {
> 
> Thanks,
> 
>         M.

Thanks again for your review,
Samuel
