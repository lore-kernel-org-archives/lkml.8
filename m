Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABE4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4513C20724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbgF3RvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:51:11 -0400
Received: from foss.arm.com ([217.140.110.172]:49868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbgF3RvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:51:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97DE530E;
        Tue, 30 Jun 2020 10:51:10 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ABE83F68F;
        Tue, 30 Jun 2020 10:51:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 0/3] SCMI System Power Support
Date:   Tue, 30 Jun 2020 18:50:53 +0100
Message-Id: <20200630175056.21843-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series wants to add the core SCMI System Power support and related
events' handling logic: the protocol support itself is trivial and boils
down to some bare initializations and supporting one SCMI System Power
notification event meant to carry platform-originated System transition
requests. This is patch [1/3].

On top of this a new SCMI driver has been developed which registers for
such System Power notification and acts accordingly to satisfy such
plaform system-state transition requests that can be of forceful or
graceful kind.

In order to comply with such graceful requests, and co-operate with
userspace entities to drive a clean shutdown/reboot, the logic of the
driver relies on the same orderly_* API methods used by ACPI when handling
ACPI Shutdown bus events.
As an alternative method to tunnel graceful requests to userspace it is
possible to configure, via available module parameters, a specific signal
to be sent to CAD pid. This is patch [2/3].

Patch [3/3] is a mere JUNO example of the minimal DT bindings needed to
enable the protocol at the DT level and is NOT meant to be upstream as of
now.

Based on scmi-next/for-next/scmi on top of:

commit 08fc3399646a ("firmware: arm_scmi: Add base notifications support")

Thanks

Cristian

----
v3 --> v4
- rebased on top of scmi-next/for-next/scmi 5.8-rc3 
- fixed some strict checkpatch issues

V2 --> V3
- changed Kconfig to fix naming and defaulting System Power Control
  driver to n
- fixes related to changes in SCMI Notifications core support V10

V1 --> V2
- use common event enums
- introduced optional alternative signal based comms 2 userspace


[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git

Cristian Marussi (3):
  firmware: arm_scmi: Add System Power Protocol support
  firmware: arm_scmi: Add SCMI System Power Control driver
  arm64: dts: juno: add SCMI SystemPower Protocol support

 arch/arm64/boot/dts/arm/juno-base.dtsi        |   4 +
 drivers/firmware/Kconfig                      |  12 +
 drivers/firmware/arm_scmi/Makefile            |   3 +-
 drivers/firmware/arm_scmi/driver.c            |   1 +
 .../firmware/arm_scmi/scmi_power_control.c    | 389 ++++++++++++++++++
 drivers/firmware/arm_scmi/system.c            | 136 ++++++
 include/linux/scmi_protocol.h                 |  18 +
 7 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c
 create mode 100644 drivers/firmware/arm_scmi/system.c

-- 
2.17.1

