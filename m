Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BC320722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgHCVt0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:49:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHCVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:49:25 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Md6ZB-1kcbBF3cOp-00aAXl for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:49:19 +0200
Received: by mail-qk1-f170.google.com with SMTP id h7so36615713qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:49:18 -0700 (PDT)
X-Gm-Message-State: AOAM531auUDB2sbWHmGHNKtuGGwzl7DopDSVDsZwpibtIGz41RS1n3ai
        E67ak7qJx8f7twHdUtRSnVBvT3b1FuSj21rHtec=
X-Google-Smtp-Source: ABdhPJz5p65hAbv/0cE3RwE1/Mn+AwBmwVeygJ/vEkstKXxhnqkkoXE7NdyFOYDnwmWcYVZ08rfQgvWvcmVULS8kHxw=
X-Received: by 2002:a37:9004:: with SMTP id s4mr18051297qkd.286.1596491357611;
 Mon, 03 Aug 2020 14:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:49:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1hisNS9aNuRq8+RYrg4SzmnPKueUgxWvbkjpW2Wpaf3Q@mail.gmail.com>
Message-ID: <CAK8P3a1hisNS9aNuRq8+RYrg4SzmnPKueUgxWvbkjpW2Wpaf3Q@mail.gmail.com>
Subject: [GIT PULL 4/5] ARM: SoC driver updates for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hC6X/+cHfAwnpIMCKN8YmscC5J896CFejUB0MhkbOuRNnwBfy2q
 bNnJNdLtXff/2r9/vSzzLPbRia9R/X9DkLYG1cXbLFbYZLY/7GTVJxGsYDtyg9rMHk01dh2
 YHqbdxehj2Y2lC8xoWKOOj617QmOaH+rkQuy8N56TjGMAwwShQ9QEXiKx2y/5SDmuylyKqe
 iWagA+U2igggl52fmF+JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NEiUtGJwnY=:SsVkAiMykBHEswlTaTfBl1
 xNyLNpNtf686Eu4wLHvCDzQUX1ta7RB/PIK86PflXi7P/bG3cFYtELqYMhZK0zjiRFVrORGMT
 AQJjDdKKoBDgX7y6WFTKsZWtP7XYUP4q0/XElAW7m3bCd0voR86Z/M8HWWS3FO20jnPztJ8Nz
 66Uie87KHKqyt46SfmLOvMS603r5VeU8RMTHfYkGdE217q8Y8LSyOzxD3Zu7lZpfMlljoc/8V
 vE+Vr+atZjj/spQ+mEp6W000uBJLBSZ+Ah5BuWrq7JyvjU3cHpB/0IoCan3TpbjmeP1JlU+Wk
 gbOOSMV9ulJUdvVjLSUxbhvkL7vnwocWjMQTKLu2QQ0L15Vwga20y7Pd9DT+b/8DmR88giqKJ
 TF5cpXs7jKPyCiOZ7UyDCCvPkAyU+9oMrLrShdEwT4JEpdi9CVVHDgJtveLfd0pcfZtZVUHfp
 uYTk/dhBD9NSeUkaRPO+aEtKtIQz/IhPtqvBrNqIKTrGGcky5VUrQXkrvGy+VMgQLE3FVphAa
 zMk52XS1W5dFuQI3HpD773pBvAw0LFdZT7/IpuU/gpBpWkgyygIH9nRdEM9YZscI0hgi7mD8a
 6ZgJnRPET2wq1yqxQMRTl3D4sMp70o72LdiRVEReIjEpSgpGy7YwLt1faQCcGufjNdxDbLAAX
 4eSVCsJstUVDFDE4het6KqjzGMHuxA/fGn+wBljDsoqLK8aJ4C/+DMsXOBBLe47bOmsTrGbu+
 ZP7ualvy0+0JjprHlHCepb1FG0+mCiM5ONxf4nTyKXk3qsN225NxyFwvoCsyKuCnzVEnvM35f
 UGQWvMkGpfMwK0sqtn6ImOV9D51XQubZwL0sk5KINdPr0vP3euQQ52lo7rC4wKRGarPQc94Qe
 aXlMthDD3IzWmGMuHxHeTmr51s5jTBFsIbsdKtiwuM0yZVygQvrgqUBa+dZmKcft1lbcAtyzR
 4E5x8wImVu4Z1o5c2k5loGOrSufnYrlfSx7WssB03MFYoCbFseyIz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-drivers-5.9

for you to fetch changes up to d76cfc7c3ad23a79eaf348a1b483e89f8ac3041a:

  Merge tag 'qcom-drivers-for-5.9-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into
arm/drivers (2020-07-31 10:38:36 +0200)

----------------------------------------------------------------
ARM: SoC driver updates for v5.9

A couple of subsystems have their own subsystem maintainers but choose
to have the code merged through the soc tree as upstream, as the code
tends to be used across multiple SoCs or has SoC specific drivers itself:

 - memory controllers:
     Krzysztof Kozlowski takes ownership of the drivers/memory
     subsystem and its drivers, starting out with a set of cleanup
     patches.
     A larger driver for the Tegra memory controller that was accidentally
     missed for v5.8 is now added.

 - reset controllers:
     Only minor updates to drivers/reset this time

 - firmware:
     The "turris mox" firmware driver gains support for signed firmware blobs
     The tegra firmware driver gets extended to export some debug information
     Various updates to i.MX firmware drivers, mostly cosmetic

 - ARM SCMI/SCPI:
     A new mechanism for platform notifications is added, among a number
     of minor changes.

 - optee:
     Probing of the TEE bus is rewritten to better support detection of
     devices that depend on the tee-supplicant user space.
     A new firmware based trusted platform module (fTPM) driver is added
     based on OP-TEE

 - SoC attributes:
     A new driver is added to provide a generic soc_device for identifying
     a machine through the SMCCC ARCH_SOC_ID firmware interface rather than
     by probing SoC family specific registers.
     The series also contains some cleanups to the common soc_device code.

There are also a number of updates to SoC specific drivers,
the main ones are:

 - Mediatek cmdq driver gains a few in-kernel interfaces

 - Minor updates to Qualcomm RPMh, socinfo, rpm drivers, mostly adding
   support for additional SoC variants

 - The Qualcomm GENI core code gains interconnect path voting and
   performance level support, and integrating this into a number of
   device drivers.

 - A new driver for Samsung Exynos5800 voltage coupler for

 - Renesas RZ/G2H (R8A774E1) SoC support gets added to a couple of SoC
   specific device drivers

 - Updates to the TI K3 Ring Accelerator driver

----------------------------------------------------------------
Akash Asthana (7):
      soc: qcom: geni: Support for ICC voting
      soc: qcom-geni-se: Add interconnect support to fix earlycon crash
      i2c: i2c-qcom-geni: Add interconnect support
      tty: serial: qcom_geni_serial: Add interconnect support
      spi: spi-geni-qcom: Add interconnect support
      spi: spi-qcom-qspi: Add interconnect support
      soc: qcom: geni: Fix NULL pointer dereference

Alexander A. Klimov (2):
      reset: Replace HTTP links with HTTPS ones
      firmware: ti_sci: Replace HTTP links with HTTPS ones

Anson Huang (4):
      dt-bindings: reset: Convert i.MX reset to json-schema
      dt-bindings: reset: Convert i.MX7 reset to json-schema
      firmware: imx: make sure MU irq can wake up system from suspend mode
      firmware: imx: Move i.MX SCU soc driver into imx firmware folder

Arnd Bergmann (17):
      memory: tegra: Avoid unused function warnings
      Merge tag 'soc-attr-updates-5.9' of
git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'optee-bus-for-v5.9' of
git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'scmi-updates-5.9' of
git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'v5.8-next-soc' of
git://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'renesas-drivers-for-v5.9-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'tegra-for-5.9-firmware' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.9-memory' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.9-soc' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'reset-for-v5.9' of git://git.pengutronix.de/pza/linux
into arm/drivers
      Merge tag 'imx-drivers-5.9' of
git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.9' of
git://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'mvebu-drivers-5.9-1' of
git://git.kernel.org/.../gclement/mvebu into arm/drivers
      Merge tag 'memory-controller-drv-5.9' of
git://git.kernel.org/.../krzk/linux into arm/drivers
      Merge tag 'drivers_soc_for_5.9' of
git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge tag 'memory-controller-drv-5.9-2' of
git://git.kernel.org/.../krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'qcom-drivers-for-5.9-2' of
git://git.kernel.org/.../qcom/linux into arm/drivers

Christophe JAILLET (1):
      memory: tegra: Fix an error handling path in tegra186_emc_probe()

Cristian Marussi (13):
      firmware: arm_scmi: Fix SCMI genpd domain probing
      firmware: arm_scmi: Add notification protocol-registration
      firmware: arm_scmi: Add notification callbacks-registration
      firmware: arm_scmi: Add notification dispatch and delivery
      firmware: arm_scmi: Enable notification core
      firmware: arm_scmi: Add power notifications support
      firmware: arm_scmi: Add perf notifications support
      firmware: arm_scmi: Add sensor notifications support
      firmware: arm_scmi: Add reset notifications support
      firmware: arm_scmi: Add base notifications support
      firmware: arm_scmi: Remove zero-length array in SCMI notifications
      firmware: arm_scmi: Remove unneeded __packed attribute
      firmware: arm_scmi: Remove fixed size fields from
reports/scmi_event_header

Dan Carpenter (1):
      memory: tegra: Delete some dead code

Dejin Zheng (1):
      reset: intel: fix a compile warning about REG_OFFSET redefined

Dennis YC Hsieh (3):
      soc: mediatek: cmdq: add assign function
      soc: mediatek: cmdq: export finalize function
      soc: mediatek: cmdq: add set event function

Dmitry Baryshkov (4):
      soc: qcom: socinfo: add support for newer socinfo data
      soc: qcom: socinfo: fix printing of pmic_model
      soc: qcom: socinfo: add file with SoC info format version
      soc: qcom: socinfo: add SM8250 entry to soc_id array

Dmitry Osipenko (3):
      memory: tegra: Make debugfs permissions human-readable
      memory: tegra20-emc: Poll EMC-CaR handshake instead of waiting
for interrupt
      memory: tegra30-emc: Poll EMC-CaR handshake instead of waiting
for interrupt

Douglas Anderson (9):
      soc: qcom: rpmh-rsc: Don't use ktime for timeout in write_tcs_reg_sync()
      spi: spi-geni-qcom: Combine the clock setting code
      spi: spi-qcom-qspi: Avoid clock setting if not needed
      spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
      spi: spi-geni-qcom: Avoid clock setting if not needed
      spi: spi-geni-qcom: Set the clock properly at runtime resume
      spi: spi-geni-qcom: Get rid of most overhead in prepare_message()
      serial: qcom_geni_serial: Make kgdb work even if UART isn't console
      serial: qcom_geni_serial: Always use 4 bytes per TX FIFO word

Geert Uytterhoeven (2):
      memory: tegra: Drop <linux/clk-provider.h>
      Merge tag 'renesas-r8a774e1-dt-binding-defs-tag' into
renesas-drivers-for-v5.9

Gokul Sriram Palanisamy (1):
      dt-bindings: firmware: qcom: Add compatible for IPQ8074 SoC

Grygorii Strashko (5):
      dt-bindings: soc: ti: k3-ringacc: convert bindings to json-schema
      soc: ti: k3-ringacc: add ring's flags to dump
      soc: ti: k3-ringacc: add request pair of rings api.
      soc: ti: k3-ringacc: separate soc specific initialization
      soc: ti: k3-ringacc: fix: warn: variable dereferenced before check 'ring'

Jon Hunter (5):
      memory: tegra: Fix KCONFIG variables for Tegra186 and Tegra194
      firmware: tegra: Use consistent return variable name
      firmware: tegra: Prepare for supporting in-band debugfs
      firmware: tegra: Add support for in-band debug
      firmware: tegra: Update BPMP ABI

Jonathan McDowell (1):
      firmware: qcom_scm: Fix legacy convention SCM accessors

Joseph Lo (2):
      memory: tegra: Add EMC scaling support code for Tegra210
      memory: tegra: Add EMC scaling sequence code for Tegra210

Kathiravan T (3):
      dt-bindings: soc: qcom: smd-rpm: Add IPQ6018 compatible
      soc: qcom: smd-rpm: Add IPQ6018 compatible
      dt-bindings: soc: qcom: smd-rpm: Convert binding to YAML schema

Konrad Dybcio (4):
      soc: qcom: socinfo: Add socinfo entry for SDM630
      drivers: soc: Add MSM8936 SMD RPM compatible
      soc: qcom: smd-rpm: Add msm8994 compatible
      firmware: qcom_scm: Add msm8994 compatible

Krzysztof Kozlowski (37):
      memory: samsung: exynos5422-dmc: Do not ignore return code of
regmap_read()
      memory: of: Remove unused headers
      memory: of: Remove __func__ in device related messages
      memory: of: Correct indentation
      memory: of: Remove unneeded extern from function declarations
      memory: emif-asm-offsets: Add GPLv2 SPDX license header
      memory: emif: Put constant in comparison on the right side
      memory: emif: Fix whitespace coding style violations
      memory: emif: Silence platform_get_irq() error in driver
      memory: ti-aemif: Rename SS to SSTROBE to avoid name conflicts
      memory: ti-emif-pm: Fix cast to iomem pointer
      memory: brcmstb_dpfe: Constify the contents of string
      memory: brcmstb_dpfe: Remove unneeded braces
      memory: mtk-smi: Add argument to function pointer definition
      memory: omap-gpmc: Include <linux/sizes.h> for SZ_16M
      memory: omap-gpmc: Fix whitespace issue
      memory: pl172: Add GPLv2 SPDX license header
      memory: fsl_ifc: Fix whitespace issues
      memory: da8xx-ddrctl: Remove unused 'node' variable
      memory: Describe the MEMORY Kconfig entry
      memory: samsung: exynos-srom: Describe the Kconfig entry
      MAINTAINERS: Add Krzysztof Kozlowski as maintainer of memory controllers
      memory: bt1-l2-ctl: Add blank lines after declarations
      memory: mvebu-devbus: Add missing braces to all arms of if statement
      memory: mvebu-devbus: Align with open parenthesis
      memory: omap-gpmc: Correct kerneldoc
      memory: omap-gpmc: Enclose macro argument usage in parenthesis
      memory: omap-gpmc: Use 'unsigned int' for consistency
      memory: omap-gpmc: Correct white space issues
      memory: omap-gpmc: Fix language typo
      memory: of: Correct kerneldoc
      memory: pl172: Enclose macro argument usage in parenthesis
      memory: samsung: exynos-srom: Correct alignment
      memory: samsung: exynos5422-dmc: Correct white space issues
      memory: brcmstb_dpfe: Fix language typo
      MAINTAINERS: Add Git repository for memory controller drivers
      soc: qcom: smd-rpm: Fix kerneldoc

Lina Iyer (1):
      soc: qcom: rpmh: Allow RPMH on ARM SoC

Marek Behún (2):
      firmware: turris-mox-rwtm: support ECDSA signatures via debugfs
      firmware: turris-mox-rwtm: add debugfs documentation

Marek Szyprowski (1):
      soc: samsung: exynos-regulator-coupler: Add simple voltage
coupler for Exynos5800

Marian-Cristian Rotariu (6):
      dt-bindings: power: Add r8a774e1 SYSC power domain definitions
      clk: renesas: Add r8a774e1 CPG Core Clock Definitions
      soc: renesas: rcar-sysc: Add r8a774e1 support
      soc: renesas: Add Renesas R8A774E1 config option
      soc: renesas: Identify RZ/G2H
      soc: renesas: rcar-rst: Add support for RZ/G2H

Maulik Shah (2):
      soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
      soc: qcom: rpmh: Update rpmh_invalidate function to return void

Maxim Uvarov (3):
      optee: use uuid for sysfs driver entry
      optee: enable support for multi-stage bus enumeration
      tpm_ftpm_tee: register driver on TEE bus

Maxime Ripard (2):
      reset: Move reset-simple header out of drivers/reset
      reset: simple: Add reset callback

Nicola Mazzucato (2):
      firmware: arm_scmi: Add fast_switch_possible() interface
      cpufreq: arm_scmi: Set fast_switch_possible conditionally

Paul Cercueil (1):
      memory: jz4780_nemc: Only request IO memory the driver will use

Peng Fan (5):
      soc: imx: scu: use devm_kasprintf
      firmware: imx: scu-pd: fix cm40 power domain
      firmware: imx: add resource management api
      firmware: imx: scu-pd: add more cm4 resources
      soc: imx: select ARM_GIC_V3 for i.MX8M

Peter Ujfalusi (2):
      soc: ti: k3-ringacc: Move state tracking variables under a struct
      dmaengine: ti: k3-udma: Switch to k3_ringacc_request_rings_pair

Rajendra Nayak (4):
      tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
      spi: spi-geni-qcom: Use OPP API to set clk/perf state
      spi: spi-qcom-qspi: Use OPP API to set clk/perf state
      tty: serial: qcom-geni-serial: Drop the icc bw votes in suspend
for console

Randy Dunlap (2):
      <linux/of.h>: add stub for of_get_next_parent() to fix qcom build error
      soc: ti/ti_sci_protocol.h: drop a duplicated word + clarify

Sandipan Patra (1):
      soc/tegra: fuse: Add Tegra186 and Tegra194 SoC IDs

Sibi Sankar (1):
      soc: qcom: pdr: Reorder the PD state indication ack

Sudeep Holla (15):
      firmware: arm_scmi: Use signed integer to report transfer status
      firmware: arm_scmi: Use HAVE_ARM_SMCCC_DISCOVERY instead of ARM_PSCI_FW
      soc: realview: Switch to use DEVICE_ATTR_RO()
      soc: realview: Use custom soc attribute group instead of
device_create_file
      soc: integrator: Switch to use DEVICE_ATTR_RO()
      soc: integrator: Use custom soc attribute group instead of
device_create_file
      soc: ux500: Switch to use DEVICE_ATTR_RO()
      soc: ux500: Use custom soc attribute group instead of device_create_file
      ARM: OMAP2: Switch to use DEVICE_ATTR_RO()
      ARM: OMAP2: Use custom soc attribute group instead of device_create_file
      firmware: smccc: Add ARCH_SOC_ID support
      firmware: arm_scmi: Keep the discrete clock rates sorted
      clk: scmi: Fix min and max rate when registering clocks with
discrete rates
      firmware: arm_scmi: Provide a missing function param description
      firmware: arm_scmi: Use NULL instead of integer 0 for rate pointer

Thierry Reding (3):
      memory: tegra: Support derated timings on Tegra210
      memory: tegra: Add Tegra132 compatible string match
      soc/tegra: fuse: Fix typo in APB MISC warning

Timo Alho (1):
      firmware: tegra: Add return code checks and increase debugfs size

Vincent Knecht (1):
      dt-bindings: soc: qcom: Document MSM8936 SMD RPM

Wei Yongjun (1):
      soc: TI knav_qmss: make symbol 'knav_acc_range_ops' static

YueHaibing (1):
      soc: qcom: geni: Fix unused label warning

kernel test robot (1):
      soc: ti: k3: fix semicolon.cocci warnings

 Documentation/ABI/testing/debugfs-turris-mox-rwtm  |    9 +
 Documentation/ABI/testing/sysfs-bus-optee-devices  |    8 +
 Documentation/ABI/testing/sysfs-devices-soc        |   30 +
 .../devicetree/bindings/firmware/qcom,scm.txt      |    2 +
 .../bindings/interrupt-controller/ti,sci-intr.txt  |    2 +-
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 -
 .../devicetree/bindings/reset/fsl,imx-src.yaml     |   82 +
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |   56 -
 .../devicetree/bindings/reset/fsl,imx7-src.yaml    |   58 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   62 -
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   87 +
 .../devicetree/bindings/soc/ti/k3-ringacc.txt      |   59 -
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |  102 +
 MAINTAINERS                                        |    9 +
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-omap2/id.c                           |   20 +-
 arch/arm64/configs/defconfig                       |    1 -
 drivers/char/tpm/tpm_ftpm_tee.c                    |   70 +-
 drivers/clk/clk-scmi.c                             |   22 +-
 drivers/cpufreq/scmi-cpufreq.c                     |    3 +-
 drivers/dma/ti/k3-udma-glue.c                      |   42 +-
 drivers/dma/ti/k3-udma.c                           |   34 +-
 drivers/firmware/arm_scmi/Makefile                 |    4 +-
 drivers/firmware/arm_scmi/base.c                   |  108 +-
 drivers/firmware/arm_scmi/clock.c                  |   20 +-
 drivers/firmware/arm_scmi/common.h                 |    4 +
 drivers/firmware/arm_scmi/driver.c                 |   15 +-
 drivers/firmware/arm_scmi/notify.c                 | 1526 ++++++++++++++
 drivers/firmware/arm_scmi/notify.h                 |   68 +
 drivers/firmware/arm_scmi/perf.c                   |  151 +-
 drivers/firmware/arm_scmi/power.c                  |   92 +-
 drivers/firmware/arm_scmi/reset.c                  |   96 +-
 drivers/firmware/arm_scmi/scmi_pm_domain.c         |   12 +-
 drivers/firmware/arm_scmi/sensors.c                |   69 +-
 drivers/firmware/arm_scmi/smc.c                    |    1 +
 drivers/firmware/imx/Makefile                      |    2 +-
 drivers/firmware/imx/imx-scu-irq.c                 |    2 +
 .../soc-imx-scu.c => firmware/imx/imx-scu-soc.c}   |   83 +-
 drivers/firmware/imx/imx-scu.c                     |    4 +
 drivers/firmware/imx/rm.c                          |   45 +
 drivers/firmware/imx/scu-pd.c                      |   14 +-
 drivers/firmware/qcom_scm.c                        |    8 +-
 drivers/firmware/smccc/Kconfig                     |    9 +
 drivers/firmware/smccc/Makefile                    |    1 +
 drivers/firmware/smccc/soc_id.c                    |  114 ++
 drivers/firmware/tegra/bpmp-debugfs.c              |  436 +++-
 drivers/firmware/tegra/bpmp.c                      |    6 +-
 drivers/firmware/ti_sci.c                          |    2 +-
 drivers/firmware/ti_sci.h                          |    2 +-
 drivers/firmware/turris-mox-rwtm.c                 |  166 ++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    1 +
 drivers/i2c/busses/i2c-qcom-geni.c                 |   26 +-
 drivers/interconnect/qcom/bcm-voter.c              |    6 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |    2 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |    2 +-
 drivers/memory/Kconfig                             |    6 +
 drivers/memory/brcmstb_dpfe.c                      |    7 +-
 drivers/memory/bt1-l2-ctl.c                        |    2 +
 drivers/memory/da8xx-ddrctl.c                      |    2 -
 drivers/memory/emif-asm-offsets.c                  |   10 +-
 drivers/memory/emif.c                              |   23 +-
 drivers/memory/fsl_ifc.c                           |   30 +-
 drivers/memory/jz4780-nemc.c                       |   17 +-
 drivers/memory/mtk-smi.c                           |    2 +-
 drivers/memory/mvebu-devbus.c                      |   20 +-
 drivers/memory/of_memory.c                         |   32 +-
 drivers/memory/of_memory.h                         |   21 +-
 drivers/memory/omap-gpmc.c                         |   66 +-
 drivers/memory/pl172.c                             |   19 +-
 drivers/memory/samsung/Kconfig                     |    7 +
 drivers/memory/samsung/exynos-srom.c               |   22 +-
 drivers/memory/samsung/exynos5422-dmc.c            |   15 +-
 drivers/memory/tegra/Kconfig                       |   14 +
 drivers/memory/tegra/Makefile                      |    4 +
 drivers/memory/tegra/mc.h                          |    1 +
 drivers/memory/tegra/tegra124-emc.c                |    7 +-
 drivers/memory/tegra/tegra186-emc.c                |   25 +-
 drivers/memory/tegra/tegra186.c                    |    4 +-
 drivers/memory/tegra/tegra20-emc.c                 |   34 +-
 drivers/memory/tegra/tegra210-emc-cc-r21021.c      | 1775 +++++++++++++++++
 drivers/memory/tegra/tegra210-emc-core.c           | 2100 ++++++++++++++++++++
 drivers/memory/tegra/tegra210-emc-table.c          |   90 +
 drivers/memory/tegra/tegra210-emc.h                | 1016 ++++++++++
 drivers/memory/tegra/tegra210-mc.h                 |   50 +
 drivers/memory/tegra/tegra30-emc.c                 |  122 +-
 drivers/memory/ti-aemif.c                          |   16 +-
 drivers/memory/ti-emif-pm.c                        |    2 +-
 drivers/reset/reset-intel-gw.c                     |   24 +-
 drivers/reset/reset-simple.c                       |   23 +-
 drivers/reset/reset-socfpga.c                      |    3 +-
 drivers/reset/reset-sunxi.c                        |    3 +-
 drivers/reset/reset-ti-sci.c                       |    2 +-
 drivers/reset/reset-ti-syscon.c                    |    2 +-
 drivers/reset/reset-uniphier-glue.c                |    3 +-
 drivers/soc/imx/Kconfig                            |   10 +-
 drivers/soc/imx/Makefile                           |    1 -
 drivers/soc/mediatek/mtk-cmdq-helper.c             |   46 +-
 drivers/soc/qcom/Kconfig                           |    2 +-
 drivers/soc/qcom/pdr_interface.c                   |    4 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  165 ++
 drivers/soc/qcom/rpmh-rsc.c                        |   19 +-
 drivers/soc/qcom/rpmh.c                            |    4 +-
 drivers/soc/qcom/smd-rpm.c                         |    5 +
 drivers/soc/qcom/socinfo.c                         |   65 +-
 drivers/soc/renesas/Kconfig                        |   11 +
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/r8a774e1-sysc.c                |   43 +
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 drivers/soc/renesas/rcar-sysc.c                    |    3 +
 drivers/soc/renesas/rcar-sysc.h                    |    1 +
 drivers/soc/renesas/renesas-soc.c                  |    8 +
 drivers/soc/samsung/Kconfig                        |    3 +
 drivers/soc/samsung/Makefile                       |    1 +
 drivers/soc/samsung/exynos-regulator-coupler.c     |  221 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |    2 +-
 drivers/soc/ti/k3-ringacc.c                        |  200 +-
 drivers/soc/ti/knav_qmss_acc.c                     |    2 +-
 drivers/soc/ux500/ux500-soc-id.c                   |   22 +-
 drivers/soc/versatile/soc-integrator.c             |   48 +-
 drivers/soc/versatile/soc-realview.c               |   48 +-
 drivers/spi/spi-geni-qcom.c                        |  193 +-
 drivers/spi/spi-qcom-qspi.c                        |  117 +-
 drivers/tee/optee/core.c                           |   27 +-
 drivers/tee/optee/device.c                         |   38 +-
 drivers/tee/optee/optee_private.h                  |   10 +-
 drivers/tty/serial/qcom_geni_serial.c              |  210 +-
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h      |   59 +
 include/dt-bindings/power/r8a774e1-sysc.h          |   36 +
 include/dt-bindings/reset/ti-syscon.h              |    2 +-
 include/linux/arm-smccc.h                          |    5 +
 include/linux/firmware/imx/sci.h                   |    2 +
 include/linux/firmware/imx/svc/rm.h                |   69 +
 include/linux/mailbox/mtk-cmdq-mailbox.h           |    2 +
 include/linux/of.h                                 |    5 +
 include/linux/qcom-geni-se.h                       |   45 +
 {drivers => include/linux}/reset/reset-simple.h    |    7 +
 include/linux/scmi_protocol.h                      |  110 +-
 include/linux/soc/mediatek/mtk-cmdq.h              |   31 +
 include/linux/soc/ti/k3-ringacc.h                  |    4 +
 include/linux/soc/ti/ti_sci_inta_msi.h             |    2 +-
 include/linux/soc/ti/ti_sci_protocol.h             |    6 +-
 include/soc/qcom/rpmh.h                            |    7 +-
 include/soc/tegra/bpmp-abi.h                       |  913 ++++++---
 include/soc/tegra/fuse.h                           |    2 +
 include/trace/events/scmi.h                        |    6 +-
 145 files changed, 11020 insertions(+), 1350 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-turris-mox-rwtm
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
 delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml
 create mode 100644 drivers/firmware/arm_scmi/notify.c
 create mode 100644 drivers/firmware/arm_scmi/notify.h
 rename drivers/{soc/imx/soc-imx-scu.c => firmware/imx/imx-scu-soc.c} (57%)
 create mode 100644 drivers/firmware/imx/rm.c
 create mode 100644 drivers/firmware/smccc/soc_id.c
 create mode 100644 drivers/memory/tegra/tegra210-emc-cc-r21021.c
 create mode 100644 drivers/memory/tegra/tegra210-emc-core.c
 create mode 100644 drivers/memory/tegra/tegra210-emc-table.c
 create mode 100644 drivers/memory/tegra/tegra210-emc.h
 create mode 100644 drivers/memory/tegra/tegra210-mc.h
 create mode 100644 drivers/soc/renesas/r8a774e1-sysc.c
 create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
 create mode 100644 include/linux/firmware/imx/svc/rm.h
 rename {drivers => include/linux}/reset/reset-simple.h (74%)
