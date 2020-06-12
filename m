Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C078C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DDA20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="EPdfTDWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFLNCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:02:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E47C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:02:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j4so467063plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4qeZQcX95U4N3R/ypmQmEh1mMjrUPShqDI2RTzZrjQ=;
        b=EPdfTDWl1G/GVHurZylyRqjKzspNsa17BFE58sovbsXPHfds/7uvGL65oLZbe17VZQ
         Ar6IEsfVe0S3pirOPx3w771y1O9/Q7ARtuUz9LaeG2YISqLi2vNQ3kb4wADnfLDepLgp
         F2MLaikUlPZCu+u3fAYRDizjOrDd/+41mk5wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4qeZQcX95U4N3R/ypmQmEh1mMjrUPShqDI2RTzZrjQ=;
        b=aScEuMbdIW7kk8CYUcPayH8vkYD2q5IBLx/+pV2K+hVlrZ/sUi2PIXoDG9vhMzOG0T
         64Gl37a/7Gn3Hi85C7arH6ve450ia5S6Zy1g5sBQfPMvv99KTJPhmkgSB3/c1Ixr2wvP
         PmV82WsOYC+v/cju9mNrrl6xU9UJ/S+cp459tanlgvyy9f7tWv/fXOhhQZYXCteOb7B+
         n94Eq/yP5yI1S7Em/wGkIiD0SK2LrZPCdqx0lir7ukb5TZb+723w69vob7FRNtnjvlQf
         KJu0HvIpXVwJJNLfw1mRs0nBrLLUV4JuCvNNINTmI5htRZDGPwJyLZmb6oph7C4ZbyNC
         nVow==
X-Gm-Message-State: AOAM532ENzN4LzyIRCnFcMb5lteKzk6mYQKpKgWLyddQnSTLfo/HeKZu
        UNpONaRlOymwV7Z9YsgETCpKLeD1w7uItw==
X-Google-Smtp-Source: ABdhPJyvkfI58V2aXL74q8VxrTKcq9UctmPdxlYUl4YZz8qY2tcibtTno2DYbZMfzP1WXTFnsCG46g==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr13045485pju.118.1591966965021;
        Fri, 12 Jun 2020 06:02:45 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:02:43 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel@0x0f.com, afaerber@suse.de, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/12] Initial MStar/Sigmastar Armv7 SoC support
Date:   Fri, 12 Jun 2020 22:00:00 +0900
Message-Id: <20200612130032.3905240-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200610090421.3428945-1-daniel@0x0f.com>
References: <20200610090421.3428945-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds initial support for MStar/Sigmastar's
Armv7 based SoCs. There is just enough here to get to a shell
with an initramfs but support for a lot of the hardware is
in progress and will follow.

MStar also shipped chips with MIPS cores and ARM9 etc which
are incompatible so I've tried to make the distinction in the
code that this is strictly for the Armv7 based chips.

Differences from v2:

1. With Marc Zyngier's help the GIC node has been filled out properly.

2. A comment was added to the arch timer node to explain why the
clock-frequency is specified. Basically the vendor u-boot is old and
broken.

3. Based on Arnd Bergmann's feedback the heavy memory barrier is now
implemented using a DT node to specify where the registers are instead
of hardcoding their location. A binding description has been added for
the new node.

4. Expanded comments around the heavy memory barrier code so it's more
obvious why it looks like it does.

5. The heavy memory barrier init code was folded into the machine init
function.

6. Updated the device tree bindings and prefixes based on Andreas Färber's
feedback. They have also been split out into a number of commits

7. Based on Andreas Färber's feedback I've added the "riu" (register interface
unit) internal bus that contains all of the peripheral registers and the proper
ranges for the soc node. This bus has clocks, interrupts and some configuration
register so it might get it's own driver in the future.

8. I've dropped the pmu node for now as it's not needed to boot and I'm not
sure of the relationship between the single core in most of the chips and
the 4 documented interrupts.

9. Numerous cosmetic changes based on Andreas Färber's feedback.

Differences from v1:

1. v1 only really supported two specific chips that were known
at the time of submitting that patch series. Since then it's
become apparent that there are a few families of SoCs based
on the same ARMv7 core, clk blocks, interrupt controllers etc
and this v2 attempts to make support more generic so in the future
more SoCs from this lineage can be added. Support for some other
chips is already in progress and will follow.

2. v1 only added support for the BreadBee boards that I have been
working on. v2 also adds support for a readily available car dash
camera.

3. Support for the BreadBee board has been split into two top level
dts to cleanly support if either the msc313 or msc313e is mounted on
the board. The chips are pin compatible but some of the internal
hardware is different. The u-boot port for these SoCs can detect
which chip it is running on and select the right dts so the user
doesn't have to care which chip is mounted on their board.

Daniel Palmer (12):
  dt-bindings: vendor-prefixes: Add mstar vendor prefix
  dt-bindings: vendor-prefixes: Add sstar vendor prefix
  dt-bindings: vendor-prefixes: Add 70mai vendor prefix
  dt-bindings: vendor-prefixes: Add thingy.jp prefix
  dt-bindings: dt-bindings: arm: Add mstar YAML schema
  ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs
  ARM: mstar: Add binding details for mstar,l3bridge
  ARM: mstar: Add Armv7 base dtsi
  ARM: mstar: Add infinity/infinity3 family dtsis
  ARM: mstar: Add mercury5 series dtsis
  ARM: mstar: Add dts for msc313(e) based BreadBee boards
  ARM: mstar: Add dts for 70mai midrive d08

 .../devicetree/bindings/arm/mstar.yaml        | 33 ++++++++
 .../bindings/misc/mstar,l3bridge.yaml         | 44 ++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  8 ++
 MAINTAINERS                                   | 11 +++
 arch/arm/Kconfig                              |  2 +
 arch/arm/Makefile                             |  1 +
 arch/arm/boot/dts/Makefile                    |  4 +
 .../dts/infinity-msc313-breadbee_crust.dts    | 25 ++++++
 arch/arm/boot/dts/infinity-msc313.dtsi        | 14 ++++
 arch/arm/boot/dts/infinity.dtsi               |  7 ++
 .../boot/dts/infinity3-msc313e-breadbee.dts   | 25 ++++++
 arch/arm/boot/dts/infinity3-msc313e.dtsi      | 14 ++++
 arch/arm/boot/dts/infinity3.dtsi              |  7 ++
 .../boot/dts/mercury5-ssc8336n-midrive08.dts  | 25 ++++++
 arch/arm/boot/dts/mercury5-ssc8336n.dtsi      | 14 ++++
 arch/arm/boot/dts/mercury5.dtsi               |  7 ++
 arch/arm/boot/dts/mstar-v7.dtsi               | 83 +++++++++++++++++++
 arch/arm/mach-mstar/Kconfig                   | 26 ++++++
 arch/arm/mach-mstar/Makefile                  |  1 +
 arch/arm/mach-mstar/mstarv7.c                 | 80 ++++++++++++++++++
 20 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/mstar,l3bridge.yaml
 create mode 100644 arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
 create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
 create mode 100644 arch/arm/boot/dts/infinity.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c

-- 
2.27.0.rc0

