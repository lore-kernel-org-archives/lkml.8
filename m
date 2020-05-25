Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BDC20878
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="FTsyW2XN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2vnoY5R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgEYEMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:12:39 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47779 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgEYEMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EEA37580083;
        Mon, 25 May 2020 00:12:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=rYZqNHqHnZAV21ZKHa3aUy0OID
        zAwKRxIFDvFJGUpJU=; b=FTsyW2XN/jym19egwgJJ7WCbhqQIsaltEwehyXGXAr
        o+ZuP3tH0R2ReNNyrp/n4eABd9ehD+ZrCFi4Wd7J0MWXIGyG6WT+wh7Y1elzXkVe
        QnC33MdI4UP9GV6jwQMomppkrbXKuS1eHuftOQU3hV/DYWEPe7UnT57B5XL+1539
        H3JqPwrg/BZvNBxNownd15dWleh2TVjtAhgNga6WLT0SZivTnk2pIWtlnLKbRyBA
        PL26w+j8l8HUPeTBnna5ReO8GhdiRzb9exy2Dcl+au8mYwDpSIA5aHyt3cw+G4yx
        WfjTH7eAw0TSIW8cJkH2Nfd24wUbQFlSBBy4P8mSFMjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rYZqNHqHnZAV21ZKH
        a3aUy0OIDzAwKRxIFDvFJGUpJU=; b=2vnoY5R9JStsguPV1qAGjEvAGbmh4akzy
        sx2Q4sUkrMnJQ9El/k1Gk9puwsN6Ffqi21FwEm8iOBkYe0zl731iNqiEkan/ygWm
        T5XDbHw+as6PxXz8WB7SwMnf3+nU6423G3u22zBxmV/0/slZ72N1EO16Vv16uNdX
        ZLZ71AkuvKplb4qrL2T8oeNdqcAHXpL54Xwcl4HYTfyz5lGUWZQvglh7wJN46Hbn
        wCg6oQMOXzZ6uEksH9Ml26pIEY2lfi+HB0F2ZOtXb9PcF8cQ2JHONNCA0a14834q
        c8OITTV8kyJ2vcm3qK45VkfUoPJpn70g3Y9IXilRwOQa723aH8tGw==
X-ME-Sender: <xms:tUXLXrMp6KfTJhXLa78C3aIk0suHFPmwraS6dVkcS6wka1PYQ2pdog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:tUXLXl-vSgZaHceYyR0es1wM54RXm2rqmUnh2GA55P024TkoofuxNg>
    <xmx:tUXLXqRdUMyCcP_cwnZ1zq8qJw6JfwOOBe7noC95AfR7gHWOOw7IMw>
    <xmx:tUXLXvuibALjEkJuZP_XohV3VeM5TggDQ9shb8D_QuAcxZkrFnnRsA>
    <xmx:tUXLXkV5qlAa4lUoGnnr5zqvM-9q-74W8ls6v5IkTIqgTVcmTXgPZA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 426A03066544;
        Mon, 25 May 2020 00:12:37 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 0/9] sunxi: Support IRQ wakeup from deep sleep
Date:   Sun, 24 May 2020 23:12:53 -0500
Message-Id: <20200525041302.51213-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner sun8i/sun50i SoCs (A31 and newer) have two interrupt
controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC handles
the external NMI pin, and provides 16-32 IRQs to the ARISC. At least the
first 16 of these correspond 1:1 to a block of GIC IRQs starting with
the NMI.

This series replaces the existing chained irqchip driver used only to
control the NMI, with a stacked irqchip driver that also provides wakeup
capability for those 16 IRQs. The idea is that we preconfigure the
ARISC's IRQ controller, and then the ARISC firmware knows to wake up as
soon as it receives an IRQ.

I went back and forth about updating the existing driver versus writing
a new one. Since the hardware really is different from the NMI-only
controller on the A20, ultimately I went with a new driver. It may be
useful to separately do the chained->stacked conversion on the sunxi-nmi
driver as well.

Patch 1 adds the new driver.
Patch 2 adds wakeup capability.
The other patches update the DT+bindings to use R_INTC where beneficial.

With appropriate firmware, this series allows waking from RTC, NMI/PMIC,
(power button, plugging in USB, etc.), and Port L GPIO (lid switch, BT,
WiFi, modem, etc.).

Changes from v1:
 - Use writel_relaxed() instead if writel().
 - Remove use of the MASK register, as it doesn't affect the NMI as seen
   by the GIC. It only affects the IRQs seen by the coprocessor.
 - Leave NMI_HWIRQ enabled at all times, since it can be masked at the
   GIC level (removed .irq_enable and .irq_disable).
 - Use .irq_ack vs .irq_eoi depending on the trigger type, to avoid
   missing interrupts or double interrupts.
   - Because of this change, the driver needs two "irq_chip"s, one
     with .irq_eoi set to our function and one without.
   - Also because of this, we need IRQ_FASTEOI_HIERARCHY_HANDLERS for
     handle_fasteoi_ack_irq(), so our .irq_ack function gets called
     while the GIC driver works as if handle_fasteoi_irq() was used.
 - Inline the SUNXI_SRC_TYPE_* enum into sun6i_r_intc_irq_set_type().
 - Add a comment explaining how the trigger type is used.
 - Don't call irqd_set_trigger_type().
 - Set IRQCHIP_SET_TYPE_MASKED to match the GIC (since flags from this
   driver mask flags from that one).
 - Set IRQCHIP_EOI_THREADED to avoid doubled level interrupts, since the
   latch will be set again as long as the trigger is met.
 - Replace sun6i_r_intc_domain_translate() with
   irq_domain_translate_twocell().
 - Use an enum for the device tree binding.
 - Update commit messages for accuracy and typos.


Samuel Holland (9):
  irqchip/sun6i-r: Use a stacked irqchip driver
  irqchip/sun6i-r: Add wakeup support
  dt-bindings: irq: Add a compatible for the H3 R_INTC
  ARM: dts: sunxi: h3/h5: Add r_intc node
  ARM: dts: sunxi: h3/h5: Move wakeup-capable IRQs to r_intc
  ARM: dts: sunxi: a83t: Move wakeup-capable IRQs to r_intc
  arm64: dts: allwinner: a64: Move wakeup-capable IRQs to r_intc
  arm64: dts: allwinner: h6: Fix indentation of IR node
  arm64: dts: allwinner: h6: Move wakeup-capable IRQs to r_intc

 .../allwinner,sun7i-a20-sc-nmi.yaml           |  12 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi             |   9 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  20 +-
 arch/arm/mach-sunxi/Kconfig                   |   4 +
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  11 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  33 ++-
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sun6i-r.c                 | 267 ++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c               |  26 +-
 10 files changed, 329 insertions(+), 56 deletions(-)
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

-- 
2.24.1

