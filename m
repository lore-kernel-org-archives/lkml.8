Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8EAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A5206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="pVlvypf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGJJqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGJJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6879DC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so2037634pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2e7OWdtKM+pFPEyo4DPg5SvlQTX9Qtv8Uy9RdwLos4=;
        b=pVlvypf9hkBmygSZoTSoF4lW05YourFH342SOYD2gw5+vHpjHtt66iHNp201bYxYwS
         /PKSWe7MQRrr6C+YP+BJIe/ZRSIugmcwY1YdyZt2PbxltoR/36VQ3oAmKlyOtcg8XHxf
         uD4Xtgmi8s2Qas4UKQ55vci0CS2gKsXmB1uZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2e7OWdtKM+pFPEyo4DPg5SvlQTX9Qtv8Uy9RdwLos4=;
        b=eN5JJZulj+TIbu/JMGTzHj2QyiiQ7W9VB/zwV27dHvrFt40H+z2lnySS2kn6er8Jh7
         snwRkwmWw/bg/4Ax6b2C6lqv5dm8VMmRI8H9YyTDS9SF5GCaC+yb77xYI2BmKw0Tst1w
         7JCVOrQKB0nGOhD8t4aI+BBlNEeW5LqNYDCdHafswWqrrvF7Vwk+e2j2ahwYu/HM5Yww
         EnZf0C/kDpHjf+KUX8vPLVLsZNmyFtmP/Hcgi439IF5kD3lRgtitE+QkDIi2mOuvv/ZX
         b6dBaFXwCBuYrWbc/EDB1cxQ2cOQSoc6FKvW4uyrNtnSXR3cLKrxBnB4kskd+SPqUdaC
         eH/g==
X-Gm-Message-State: AOAM530dvQH73LTjrz1W84HzZ91T7wbPjoSjeDxceo605kwJE6OlzZhu
        DAcrLhWO+ygV0Ohu9LUx2w/EFw==
X-Google-Smtp-Source: ABdhPJwta1rDSOjCX54hbPdkwafDe4dqsFaudUpbSCCgMax0xB9Vz/fTyD62tx3Twm8dRXwy4KKy1w==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr59338626pls.1.1594374360695;
        Fri, 10 Jul 2020 02:46:00 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:00 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v5 00/12] Initial MStar/Sigmastar ARMv7 SoC support
Date:   Fri, 10 Jul 2020 18:45:32 +0900
Message-Id: <20200710094544.430258-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
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

Sorry for the spamming this. I just really want to make some
progress on this because I'm worried the other bits that are
needed for these SoCs (Really old AT91 support in macb and
the fotg210 usb host) will be lost or stop working in the meantime.
This already happened in u-boot.

Differences from v4:

1. Removed the crustx board from the MStar YAML that slipped in
during rebasing. (I think that change is small enough that it
doesn't affect Rob's Review-by but feel free to tell me off..)

2. Changed the comment for the SoC series in the MStar YAML to
a description as requested by Rob Herring.

3. Added Acked-by and Reviewed-by tags from Rob Herring.

Differences from v3:
1. Fixed the issue with the mstar binding that Rob Herring's bot
found.
2. Fixed the filename for the midrived08 dts.

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
  dt-bindings: arm: Add mstar YAML schema
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
 .../boot/dts/mercury5-ssc8336n-midrived08.dts | 25 ++++++
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
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrived08.dts
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c

-- 
2.27.0

