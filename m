Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEFCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEFE20715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598352407;
	bh=A2g5oilIRlZrMle7ltlGm+gmrEyCPIBbijgQjXU/jDk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e5a5mz4qilPqIUwT03GFebw0COTtASF52QInliFMUYIJvsjDkL3ztEE+B+zMSB6H2
	 DDsYzRk4udkN9wEt/eYNOfzcrQMFeDhuOkKDwnh+V+fc2CSUHpA1QPJVnvtdoG8K+u
	 E4OvkA10gvjaJhhVJfrGa9GgBmol/+W6otypP4Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgHYKqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbgHYKqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:46:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9052068E;
        Tue, 25 Aug 2020 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598352403;
        bh=A2g5oilIRlZrMle7ltlGm+gmrEyCPIBbijgQjXU/jDk=;
        h=From:To:Cc:Subject:Date:From;
        b=RQYFIU70fNrrKSv+aJ6VQbTUxdzzqI77VBhCdUSnroTC7Gmw+mw6VigQpjuMzTk6H
         jrjrcemPcAHP/Uz0QkHSDG1jFrC0sLOVQ895+zatkTZSZ97q38+RVRFwjUf4eqtDL6
         wAPrPSyYqhW4YH8U87syp3/1JH+iLRVjmjLaOZbQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAWTR-006VZJ-JQ; Tue, 25 Aug 2020 11:46:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        qiuguorui1 <qiuguorui1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Suman Anna <s-anna@ti.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] irqchip fixes for 5.9, take #2
Date:   Tue, 25 Aug 2020 11:45:57 +0100
Message-Id: <20200825104557.1042702-1-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, enric.balletbo@collabora.com, linux@fw-web.de, john.stultz@linaro.org, lokeshvutla@ti.com, nm@ti.com, paul@crapouillou.net, qiuguorui1@huawei.com, robh@kernel.org, saravanak@google.com, s-anna@ti.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is a combo pull request for the first two two batches of fixes
for 5.9. The most important part is that the whole "let's build
irqchips as platform devices" series has broken users' platforms as
the end-points drivers are not equipped to deal with the semi-random
probe ordering. There is work in progress to fix it, but in the
meantime let's go back to something that doesn't set the world on
fire. I have kept the helpers around to serve as a base for that
future work, but the callers are now back to their original state.

We also have two interesting fixes: one avoiding losing interrupts
when there is more that a single one pending with STM32 exti, and a
wakup interrupt issue with the Ingenic driver.

The rest of it is what I was hinting at when I sent the original 5.9
pull request, with a bunch of TI updates that deal with the change of
their firmware interface. The handling of the dependencies was bad
enough that I couldn't send it before -rc1 was out...

Please pull,

	M.

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.9-2

for you to fetch changes up to 821fc9e261f3af235752f46e59084467cfd440c4:

  irqchip/ingenic: Leave parent IRQ unmasked on suspend (2020-08-25 10:59:29 +0100)

----------------------------------------------------------------
irqchip fixes for Linux 5.9, take #2

- Revert the wholesale conversion to platform drivers of the
  pdc, sysirq and cirq drivers, as it breaks a number of
  platforms even when the driver is built-in (probe ordering
  bites you).

- Prevent interrupt from being lost with the STM32 exti driver

- Fix wake-up interrupts for the MIPS Ingenir driver

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

Marc Zyngier (2):
      irqchip: Fix probing deferal when using IRQCHIP_PLATFORM_DRIVER helpers
      irqchip: Revert modular support for drivers using IRQCHIP_PLATFORM_DRIVER helperse

Paul Cercueil (1):
      irqchip/ingenic: Leave parent IRQ unmasked on suspend

qiuguorui1 (1):
      irqchip/stm32-exti: Avoid losing interrupts due to clearing pending bits by mistake

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
 drivers/irqchip/Kconfig                            |   2 +-
 drivers/irqchip/irq-ingenic.c                      |   2 +-
 drivers/irqchip/irq-mtk-cirq.c                     |   4 +-
 drivers/irqchip/irq-mtk-sysirq.c                   |   4 +-
 drivers/irqchip/irq-stm32-exti.c                   |  14 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |  95 ++++++++++---
 drivers/irqchip/irq-ti-sci-intr.c                  | 152 ++++++++++++--------
 drivers/irqchip/irqchip.c                          |   2 +-
 drivers/irqchip/qcom-pdc.c                         |   8 +-
 include/linux/soc/ti/ti_sci_protocol.h             |  13 ++
 23 files changed, 534 insertions(+), 394 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
