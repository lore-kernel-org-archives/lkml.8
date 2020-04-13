Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE15C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121942051A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgDMW3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:29:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:10117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbgDMW33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:29:29 -0400
IronPort-SDR: SdXDhnVFF+ZKJ7yTKEaT/3QFJ0GvqNdOKeukXKzf/aqATrl6nROfZUHoeFgts42IfsxK6vTLAY
 m0QBQqTjg7ow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 15:29:28 -0700
IronPort-SDR: HA1pg7W+JidsbOkG2gETfFSzW+Y8ysmyVsIaPb3QvkwolyAjCMaPayW6gcm5TJRw2fpsJlDfDs
 X/PUIVQAGx/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="399760659"
Received: from epcorona-mobl.amr.corp.intel.com (HELO epcorona-moblu.amr.corp.intel.com) ([10.254.189.204])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2020 15:29:26 -0700
From:   Ernesto Corona <ernesto.corona@intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     Ernesto Corona <ernesto.corona@intel.com>
Subject: [PATCH v29 0/6] JTAG driver introduction 
Date:   Mon, 13 Apr 2020 15:29:14 -0700
Message-Id: <20200413222920.4722-1-ernesto.corona@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a need raise up to use JTAG interface for system's devices
programming or CPU debugging, usually the user layer
application implements jtag protocol by bit-bang or using a 
proprietary connection to vendor hardware.
This method can be slow and not generic.
 
We propose to implement general JTAG interface and infrastructure
to communicate with user layer application. In such way, we can
have the standard JTAG interface core part and separation from
specific HW implementation.
This allow new capability to debug the CPU or program system's 
device via BMC without additional devices nor cost. 

This patch purpose is to add JTAG master core infrastructure by 
defining new JTAG class and provide generic JTAG interface
to allow hardware specific drivers to connect this interface.
This will enable all JTAG drivers to use the common interface
part and will have separate for hardware implementation.

The JTAG (Joint Test Action Group) core driver provides minimal generic
JTAG interface, which can be used by hardware specific JTAG master
controllers. By providing common interface for the JTAG controllers,
user space device programing is hardware independent.
 
Modern SoC which in use for embedded system' equipped with
internal JTAG master interface.
This interface is used for programming and debugging system's
hardware components, like CPLD, FPGA, CPU, voltage and
industrial controllers.
Firmware for such devices can be upgraded through JTAG interface during
Runtime. The JTAG standard support for multiple devices programming,
is in case their lines are daisy-chained together.

For example, systems which equipped with host CPU, BMC SoC or/and 
number of programmable devices are capable to connect a pin and
select system components dynamically for programming and debugging,
This is using by the BMC which is equipped with internal SoC master
controller.
For example:

BMC JTAG master --> pin selected to CPLDs chain for programming (filed
upgrade, production) 
BMC JTAG master --> pin selected to voltage monitors for programming 
(field upgrade, production) 
BMC JTAG master --> pin selected to host CPU (on-site debugging 
and developers debugging)

For example, we can have application in user space which using calls
to JTAG driver executes CPLD programming directly from SVF file
 
The JTAG standard (IEEE 1149.1) defines the next connector pins:
- TDI (Test Data In);
- TDO (Test Data Out);
- TCK (Test Clock);
- TMS (Test Mode Select);
- TRST (Test Reset) (Optional);

The SoC equipped with JTAG master controller, performs
device programming on command or vector level. For example
a file in a standard SVF (Serial Vector Format) that contains
boundary scan vectors, can be used by sending each vector
to the JTAG interface and the JTAG controller will execute
the programming.

Initial version provides the system calls set for:
- SIR (Scan Instruction Register, IEEE 1149.1 Instruction Register scan);
- SDR (Scan Data Register, IEEE 1149.1 Data Register scan);
- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
  number of clocks.

SoC which are not equipped with JTAG master interface, can be built
on top of JTAG core driver infrastructure, by applying bit-banging of
TDI, TDO, TCK and TMS pins within the hardware specific driver. 

Oleksandr Shamray (4):
Ernesto Corona (6):
  drivers: jtag: Add JTAG core driver
  dt-binding: jtag: Aspeed 2400 and 2500 series
  Add Aspeed SoC 24xx and 25xx families JTAG master driver
  Documentation: jtag: Add ABI documentation
  Documentation jtag: Add JTAG core driver ioctl number
  drivers: jtag: Add JTAG core driver Maintainers

 Documentation/ABI/testing/jtag-dev            |   23 +
 .../devicetree/bindings/jtag/aspeed-jtag.yaml |   71 ++
 Documentation/index.rst                       |    1 +
 Documentation/jtag/index.rst                  |   18 +
 Documentation/jtag/jtag-summary.rst           |   47 +
 Documentation/jtag/jtagdev.rst                |  194 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 MAINTAINERS                                   |   11 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/jtag/Kconfig                          |   31 +
 drivers/jtag/Makefile                         |    2 +
 drivers/jtag/jtag-aspeed.c                    | 1027 +++++++++++++++++
 drivers/jtag/jtag.c                           |  301 +++++
 include/linux/jtag.h                          |   44 +
 include/uapi/linux/jtag.h                     |  194 ++++
 16 files changed, 1969 insertions(+)
 create mode 100644 Documentation/ABI/testing/jtag-dev
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
 create mode 100644 Documentation/jtag/index.rst
 create mode 100644 Documentation/jtag/jtag-summary.rst
 create mode 100644 Documentation/jtag/jtagdev.rst
 create mode 100644 drivers/jtag/Kconfig
 create mode 100644 drivers/jtag/Makefile
 create mode 100644 drivers/jtag/jtag-aspeed.c
 create mode 100644 drivers/jtag/jtag.c
 create mode 100644 include/linux/jtag.h
 create mode 100644 include/uapi/linux/jtag.h

-- 
2.17.1

