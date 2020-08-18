Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C189C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EE92054F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597763723;
	bh=oS4H9N77c9RTUfV0WFBdDsZdB594DRNKFt9jHii7/Pk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QYHKpvnAp5wh6WOGZmbezq9LPHuTJpvuEUfc2c4TDhD0DlTwQKtDYPFeBmgKj7EvG
	 MqrPCc3+jgNPbkwmDmdzeCId0hd4o1sTHOJ6/H1GQMMtzxsQI/X99tpx6sU/YcbDgW
	 ZZJxzNlGCu6JKRAuritMxN/tOGDP1oIxbG2zJEXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHRPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgHRPPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:15:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A32D2054F;
        Tue, 18 Aug 2020 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763711;
        bh=oS4H9N77c9RTUfV0WFBdDsZdB594DRNKFt9jHii7/Pk=;
        h=From:To:Cc:Subject:Date:From;
        b=YdFq56/b16kAMnBdnZ6baWZABAlJJGBJgOKkjQDMCQfQCSWjWRVfRr+sRvX3gtGyh
         +SiINg939ZP1cl7qV80GduJeH7HMDA78T/48+EpXglIQvuLzBGINK0Z4PgE6hE9UqX
         zEHUD6ytaz3AMOI3QG/7T6E18gvUJ+xcMxjz5oHQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k83KP-003wAO-M1; Tue, 18 Aug 2020 16:15:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh@kernel.org>, Suman Anna <s-anna@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.9, take #1
Date:   Tue, 18 Aug 2020 16:14:48 +0100
Message-Id: <20200818151448.472216-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, john.stultz@linaro.org, lokeshvutla@ti.com, nm@ti.com, robh@kernel.org, s-anna@ti.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

As -rc1 is out, here's the first batches of fixes for 5.9. The most
important one is a fix for a typo that broke modular irqchips using
the brand new set of macros. Oh hum...

The rest of it is what I was hinting at when I sent the original 5.9
pull request, with a bunch of TI updates that deal with the change of
their firmware interface. The handling of the dependencies was bad
enough that I couldn't send it before -rc1 was out...

Please pull,

	M.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.9-1

for you to fetch changes up to 7828a3ef8646fb2e69ed45616c8453a037ca7867:

  irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers (2020-08-17 08:06:11 +0100)

----------------------------------------------------------------
irqchip fixes for Linux 5.9, take #1

- Fix an embarassing typo in the new module helpers, leading
  to the probe failing most of the time

- The promised TI firmware rework that couldn't make it into
  the merge window due to a very badly managed set of dependency

----------------------------------------------------------------
Lokesh Vutla (13):
      firmware: ti_sci: Drop the device id to resource type translation
      firmware: ti_sci: Drop unused structure ti_sci_rm_type_map
      firmware: ti_sci: Add support for getting resource with subtype
      dt-bindings: irqchip: ti, sci-intr: Update bindings to drop the usage of gic as parent
      dt-bindings: irqchip: Convert ti, sci-intr bindings to yaml
      irqchip/ti-sci-intr: Add support for INTR being a parent to INTR
      dt-bindings: irqchip: ti, sci-inta: Update docs to support different parent.
      dt-bindings: irqchip: Convert ti, sci-inta bindings to yaml
      irqchip/ti-sci-inta: Do not store TISCI device id in platform device id field
      irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC
      arm64: dts: k3-j721e: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: ti-sci-inta/intr: Update to latest bindings
      arm64: dts: k3-am65: Update the RM resource types

Marc Zyngier (1):
      irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers

 .../bindings/interrupt-controller/ti,sci-inta.txt  |  66 ---------
 .../bindings/interrupt-controller/ti,sci-inta.yaml |  98 +++++++++++++
 .../bindings/interrupt-controller/ti,sci-intr.txt  |  82 -----------
 .../bindings/interrupt-controller/ti,sci-intr.yaml | 102 ++++++++++++++
 MAINTAINERS                                        |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  36 +++--
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  12 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   8 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   4 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  10 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  43 +++---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  12 +-
 drivers/firmware/ti_sci.c                          | 155 +++++++++------------
 drivers/irqchip/irq-ti-sci-inta.c                  |  95 ++++++++++---
 drivers/irqchip/irq-ti-sci-intr.c                  | 152 ++++++++++++--------
 drivers/irqchip/irqchip.c                          |   2 +-
 include/linux/soc/ti/ti_sci_protocol.h             |  13 ++
 17 files changed, 517 insertions(+), 377 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
