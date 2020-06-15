Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ADE20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 05:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="VnHovaYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6bPl0dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgFOFaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 01:30:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:40351 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgFOFaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 01:30:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 11C7858015D;
        Mon, 15 Jun 2020 01:29:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jun 2020 01:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=T
        aA4E30QnHyeJ9whAqz+gQm0yiiY1N3IeCntOygSgK0=; b=VnHovaYBvVNQ5PB69
        2joW6HWwNYxw+wLXn1HV058OUH4LUVjdRtUcukZZkSgJ5bp0VgMXUaZLpNfQ+VwE
        Wd0GVbRcy6B+PqW998RP/0zpjkb/FyI5oBBzt9gpnPkhS/hROGqv4YLpOMzcIcxq
        TJQL1Xv8t6WIo2ob5T6LjcaDwPlEVyU5ot92ibnwhuvOXKv6Vdc5JfcjvUmyCfW5
        BU4YA9BpbtqGg8NjsYglD+Roerx5mi/qbpNwtqEeX6M5FoXjGjEIBZSgd26Ob+4i
        n7E1j4daZ4TRFTe9ztm4Wuxv2vzXhUqciaS0pAZzjoqAB1gt/CwKxzbauG4VKLSR
        6NIJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TaA4E30QnHyeJ9whAqz+gQm0yiiY1N3IeCntOygSg
        K0=; b=T6bPl0dmmV+dSft3EEM3ybxMd1c/zRbCddAhVegeIYK6h2twX3hVO/12y
        L9wfTjIZxSZmg4UxUA6/hjMjZWGQFhWGkP+wmA362R0DmTXGNzCueZyvVDlbKB6m
        d1TZsa4OqjKUk3zTlcm/o0cFBN2cnQxWdNHu08VW9hg5bePFlGt3zdf0RhAqjxap
        S9O6IYZNT2zyEL7FrmTdhWV0RuMRQNh6BOlz1Cn0OwJKqdhfWU0z+eYnGEDh0lqA
        U3hC5ID2RB/VCpU+7Xnqfp3A3F7F0jPyTw54w7Pw+VYNoAMIN6c+NNqdqBnc2qb6
        EX1FA+M1rSVZ9RjiFxCHbMenonGJw==
X-ME-Sender: <xms:UAfnXgchR5EfKaztTnPmBJEqIwAJhjyy4s1u_RDLA6EBXk8q5KXEuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeijedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuefhfffgveejjeevhfdukeejhedtiefhgeejfeeuuddtkedugeei
    hfduteelffetnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:UAfnXiN2X4_CmZVwRgc2hQ9c57zCzsCTMNu2VwPLWGK9a7NE8qEWCg>
    <xmx:UAfnXhgXbQlQlWFfOYc2YwnRrfMGPI-ddUY8YxtMJLcqGQliEwJnKQ>
    <xmx:UAfnXl_RNWWM8Nx-uvbY74bwSX1fkCMRrx0RI9d8g5fT-EvqgPOnbg>
    <xmx:VwfnXuIHbrppvTvIufguNgabIuddsz8xtj8GMgOmr9F4WXgMBD0j6A>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A99B330618B7;
        Mon, 15 Jun 2020 01:29:51 -0400 (EDT)
Subject: Re: [PATCH v2 1/9] irqchip/sun6i-r: Use a stacked irqchip driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200525041302.51213-1-samuel@sholland.org>
 <20200525041302.51213-2-samuel@sholland.org>
 <20200608084853.wr6eca5nt772p5h7@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fcfe6d02-2500-37de-e795-664bf2c7b5ee@sholland.org>
Date:   Mon, 15 Jun 2020 00:29:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608084853.wr6eca5nt772p5h7@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 3:48 AM, Maxime Ripard wrote:
> On Sun, May 24, 2020 at 11:12:54PM -0500, Samuel Holland wrote:
>> The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
>> original sun4i interrupt controller than the sun7i/sun9i NMI controller.
>> It is used for two distinct purposes:
>>  1) To control the trigger, latch, and mask for the NMI input pin
>>  2) To provide the interrupt input for the ARISC coprocessor
>>
>> As this interrupt controller is not documented, information about it
>> comes from vendor-provided ARISC firmware and from experimentation.
>>
>> Like the original sun4i interrupt controller, it has:
>>  - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
>>  - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
>>    sun4i and sunxi-nmi drivers
>>  - A MASK_REG at 0x50
>>  - A RESP_REG at 0x60
>>
>> Differences from the sun4i interrupt controller appear to be:
>>  - It is only known to have one register of each kind (max 32 inputs)
>>  - There is no FIQ-related logic
>>  - There is no interrupt priority logic
>>
>> In order to fulfill its two purposes, this hardware block combines two
>> types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
>> chip, with a trigger type controlled by the NMI_CTRL_REG. The "IRQ 0
>> pending" output from this chip, if enabled, is then routed to a SPI IRQ
>> input on the GIC, as IRQ_TYPE_LEVEL_HIGH. In other words, bit 0 of
>> ENABLE_REG *does* affect the NMI IRQ seen at the GIC.
>>
>> The NMI is then followed by a contiguous block of (at least) 15 IRQ
>> inputs that are connected in parallel to both R_INTC and the GIC. Or
>> in other words, the other bits of ENABLE_REG *do not* affect the IRQs
>> seen at the GIC.
>>
>> Finally, the global "IRQ pending" output from R_INTC, after being masked
>> by MASK_REG and RESP_REG, is connected to the "external interrupt" input
>> of the ARISC CPU (an OR1200). This path is not relevant to Linux.
>>
>> Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
>> a perfect scenario for using a stacked irqchip driver. We want to hook
>> into enabling/disabling IRQs to add more features to the GIC
>> (specifically to allow masking the NMI and setting its trigger type),
>> but we don't need to actually handle the IRQ in this driver.
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
> 
> As usual, thanks for that commit log (and the experiments you did to
> write it in the first place).
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> Maxime

I've done more experimenting, and I've learned what comes after the first 16
IRQs: all of the other SPI IRQs, multiplexed in clusters of 8, with per-IRQ
masks for the inputs to each cluster.

In fact, the H6 has so many IRQs that it begins to use the the second register
in each group (0x14, 0x44, 0x54). This means that more than one register in each
group are in fact implemented.

See https://linux-sunxi.org/INTC#IRQ_Mapping for more details.

The ability to send other IRQs to the AR100 makes it possible to implement
functionality like USB Remote Wakeup or Wake on LAN without adding complexity to
the AR100 firmware.

I will need to update the driver to take advantage of this ability, and it
raises some questions about the binding. Since the NMI is not the
lowest-numbered IRQ that can be mapped, the numbering scheme would need to
change. Maybe the IRQ number should be the same as the GIC SPI IRQ number? But
this would mean a new compatible.

The other question is which devices should be routed through this irqchip
driver? Anything that provides a wakeup source needs to go through it, so it can
intercept irq_set_wake. Probably other devices should not, as 1) not quite all
IRQs can even be sent to the AR100 for wakeup (e.g. the A64 appears to stop in
the middle of the GPU IRQs), and 2) stacking on another irqchip driver adds a
(tiny) overhead to masking/unmasking during IRQ handling.

Thoughts?
Samuel
