Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815DEC352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D162253D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="t7uGHIi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBHVZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45384 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgBHVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1605360pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIB9Z+olyDcWgfIcaVm0rYVCLKOoH5qXm6hX6pZXGLc=;
        b=t7uGHIi6bYlLF/Mjgo5aajnQw0FqEkkysDZScmXcheZ4dGt6n3NA6yQxO52jp1i4aT
         S9d4YoLoTgfqaDRTNbEOVKmsG1/b0c9JdFPhaiW1jdl9wFC+MQHRv610IcG/jSVFXtiP
         daiVxq3gWE3Ghud7tyRKTUSc7ZcDU+kym5pCxTgktAfJCEd9tDM7n6jVb1XKub9bRYyO
         WplMqW5HuQ8duoBjKgOdTCjls7nGIdQkKUO4jlNWlYlYwacyYSPvnyyJeJVcuN2n43rt
         E8CqDp3XFFnyjiDNCDPKr9SsILaxPPknUx5wfaoP4urYqaoHSVMIVs37CjTc/e1xiWaS
         hNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIB9Z+olyDcWgfIcaVm0rYVCLKOoH5qXm6hX6pZXGLc=;
        b=XCB/UYzyPFAiW5XQ8msgxo6eDLbvcG3U91BzWbQKf+OharyvYC/QSf3xP+l4hxFdvF
         NrZuJCyKiNTw+le9F7U43m1Ey/vIdP6/WLcN7D5N9DHTAECfkPhAJyRt/2DQ74wZPahf
         34zJvZzXZcYouMHxgjUzOM+5/R4BCPZv8EDdlkaYSy/nA2kYkpxSESvHHD20FL+gWG9D
         KwPK6iBk9DG0jClBtOgib7H0gv8HPCGjKCO6oM7d3fJ14aYu37SgRKZ9n6K47+SDRL/6
         UWQIgsAO24bNFZ73mXRLMYbRFMrXbhm7DShZSQyd/W9mQ3hBiWprUQTJGvV/nv4d2vWf
         cWhQ==
X-Gm-Message-State: APjAAAW3gfAfX20ncUlLfPjysPrgWiJ3Gb0QlXotZLJ8hrhAic3XukDG
        v10OUFaXz8SMlOJsDj0r3/+lww==
X-Google-Smtp-Source: APXvYqylNDUMVrqA6bOfZxLulk05Ti6FUumkrNfVkIn2scRWgPXmXA6a7b1HCaGLZ8qpaED2gRKIaQ==
X-Received: by 2002:a65:420c:: with SMTP id c12mr6212303pgq.270.1581197144335;
        Sat, 08 Feb 2020 13:25:44 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:43 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/5 v2] ARM: SoC-related driver updates
Date:   Sat,  8 Feb 2020 13:25:31 -0800
Message-Id: <20200208212533.30744-4-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208212533.30744-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208212533.30744-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various driver updates for platforms:

- Nvidia: Fuse support for Tegra194, continued memory controller pieces
for Tegra30

- NXP/FSL: Refactorings of QuickEngine drivers to support ARM/ARM64/PPC

- NXP/FSL: i.MX8MP SoC driver pieces

- TI Keystone: ring accelerator driver

- Qualcomm: SCM driver cleanup/refactoring + support for new SoCs.

- Xilinx ZynqMP: feature checking interface for firmware. Mailbox
communication for power management

- Overall support patch set for cpuidle on more complex hierarchies
(PSCI-based)

+ Misc cleanups, refactorings of Marvell, TI, other platforms.


Conflicts:

drivers/soc/tegra/fuse/tegra-apbmisc.c:

This branch has one conflict due to ioremap_nocache() removal touching
same lines as some error path fixes for tegra.  Keep the ioremap()
version of the call, but the rest from this side.

----------------------------------------------------------------

The following changes since commit 64893b7ecc44c647c36d211c1d86fa97da1a91c6:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 88b4750151a2739761bb1af7fedeae1ff5d9aed9:

  Merge tag 'zynqmp-soc-for-v5.6' of https://github.com/Xilinx/linux-xlnx into arm/drivers

----------------------------------------------------------------

Amol Grover (1):
      drivers: soc: ti: knav_qmss_queue: Pass lockdep expression to RCU lists

Anson Huang (1):
      soc: imx: Add i.MX8MP SoC driver support

Ard Biesheuvel (1):
      optee: model OP-TEE as a platform device/driver

Ben Dooks (Codethink) (1):
      soc: renesas: rcar-rst: Fix __iomem on configure call

Dan Carpenter (1):
      firmware: turris-mox-rwtm: small white space cleanup

Daniel Baluta (1):
      firmware: imx: Allow IMX DSP to be selected as module

Dilip Kota (2):
      dt-bindings: reset: Add YAML schemas for the Intel Reset controller
      reset: intel: Add system reset controller driver

Dmitry Osipenko (9):
      soc/tegra: fuse: Add APB DMA dependency for Tegra20
      soc/tegra: regulators: Do nothing if voltage is unchanged
      memory: tegra30-emc: Firm up suspend/resume sequence
      memory: tegra30-emc: Firm up hardware programming sequence
      memory: tegra30-emc: Correct error message for timed out auto calibration
      soc/tegra: fuse: Cache values of straps and Chip ID registers
      soc/tegra: fuse: Warn if straps are not ready
      soc/tegra: fuse: Correct straps' address for older Tegra124 device trees
      soc/tegra: fuse: Unmap registers once they are not needed anymore

Douglas Anderson (1):
      soc: qcom: rpmhpd: Set 'active_only' for active only power domains

Elliot Berman (17):
      firmware: qcom_scm: Rename macros and structures
      firmware: qcom_scm: Apply consistent naming scheme to command IDs
      firmware: qcom_scm: Remove unused qcom_scm_get_version
      firmware: qcom_scm-64: Make SMC macros less magical
      firmware: qcom_scm-64: Move svc/cmd/owner into qcom_scm_desc
      firmware: qcom_scm-64: Add SCM results struct
      firmware: qcom_scm-64: Move SMC register filling to qcom_scm_call_smccc
      firmware: qcom_scm-64: Improve SMC convention detection
      firmware: qcom_scm-32: Use SMC arch wrappers
      firmware: qcom_scm-32: Add funcnum IDs
      firmware: qcom_scm-32: Use qcom_scm_desc in non-atomic calls
      firmware: qcom_scm-32: Move SMCCC register filling to qcom_scm_call
      firmware: qcom_scm-32: Create common legacy atomic call
      firmware: qcom_scm-32: Add device argument to atomic calls
      firmware: qcom_scm: Order functions, definitions by service/command
      firmware: qcom_scm: Remove thin wrappers
      firmware: qcom_scm: Dynamically support SMCCC and legacy conventions

Florian Fainelli (4):
      soc: bcm: brcmstb: biuctrl: Tune 7260 BIU interface
      soc: bcm: brcmstb: biuctrl: Tune interface for 7255 and 7216
      soc: bcm: brcmstb: biuctrl: Update layout for A72 on 7211
      soc: bcm: brcmstb: biuctrl: Update programming for 7211

Geert Uytterhoeven (3):
      soc: renesas: Remove ARCH_R8A7796
      reset: Align logic and flow in managed helpers
      soc: renesas: Add ARCH_R8A7795[01] for existing R-Car H3

JC Kuo (1):
      soc/tegra: fuse: Add Tegra194 support

Jeffrey Hugo (1):
      soc: qcom: qmi: Return EPROBE_DEFER if no address family

Jim Quinlan (2):
      dt-bindings: reset: Document BCM7216 RESCAL reset controller
      reset: Add Broadcom STB RESCAL reset controller

John Stultz (1):
      reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be a tristate

Krzysztof Kozlowski (5):
      soc: qcom: Fix Kconfig indentation
      firmware: scm: Add stubs for OCMEM and restore_sec_cfg_available
      soc: samsung: Rename Samsung and Exynos to lowercase
      memory: samsung: Rename Exynos to lowercase
      soc: imx: Enable compile testing of IMX_SCU_SOC

Kunihiko Hayashi (1):
      reset: uniphier: Add SCSSI reset control for each channel

Lina Iyer (1):
      cpuidle: dt: Support hierarchical CPU idle states

Lucas Stach (1):
      soc: imx8: print SoC type and revision

Lukasz Luba (2):
      include: trace: Add SCMI header with trace events
      drivers: firmware: scmi: Extend SCMI transport layer by trace events

Marek Behún (1):
      bus: moxtet: declare moxtet_bus_type as static

Mars Cheng (1):
      dt-bindings: mediatek: add MT6765 power dt-bindings

Matthias Brugger (2):
      soc: mediatek: cmdq: delete not used define
      Merge branch 'v5.5-next/cmdq-stable' into v5.5-next/soc

Nicolas Saenz Julienne (1):
      MAINTAINERS: Add brcmstb PCIe controller entry

Nicolin Chen (1):
      memory: tegra: Correct reset value of xusb_hostr

Olof Johansson (19):
      Merge tag 'scmi-updates-5.6' of git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'tee-optee-pldrv-for-5.6' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'renesas-drivers-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'cpuidle_psci-v5.5-rc4' of git://git.linaro.org/people/ulf.hansson/linux-pm into arm/drivers
      Merge tag 'arm-soc/for-5.6/drivers' of https://github.com/Broadcom/stblinux into arm/drivers
      Merge tag 'reset-for-5.6' of git://git.pengutronix.de/pza/linux into arm/drivers
      Merge tag 'samsung-drivers-5.6' of https://git.kernel.org/.../krzk/linux into arm/drivers
      Merge tag 'tegra-for-5.6-bus' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.6-memory' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.6-soc' of git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'mvebu-drivers-5.6-1' of git://git.infradead.org/linux-mvebu into arm/drivers
      Merge tag 'imx-driver-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'soc-fsl-next-v5.6' of git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.6' of https://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'omap-for-v5.6/ti-sysc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/drivers
      Merge tag 'drivers_soc_for_5.6' of git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge tag 'arm-soc/for-5.6/maintainers' of https://github.com/Broadcom/stblinux into arm/drivers
      Merge tag 'v5.5-next-soc' of https://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'zynqmp-soc-for-v5.6' of https://github.com/Xilinx/linux-xlnx into arm/drivers

Rajan Vaja (1):
      dt-bindings: power: reset: xilinx: Add bindings for ipi mailbox

Rasmus Villemoes (48):
      soc: fsl: qe: remove space-before-tab
      soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
      soc: fsl: qe: rename qe_(clr/set/clrset)bit* helpers
      soc: fsl: qe: introduce qe_io{read,write}* wrappers
      soc: fsl: qe: avoid ppc-specific io accessors
      soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
      soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
      soc: fsl: qe: drop unneeded #includes
      soc: fsl: qe: drop assign-only high_active in qe_ic_init
      soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
      soc: fsl: qe: use qe_ic_cascade_{low, high}_mpic also on 83xx
      soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
      powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
      soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
      soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
      soc: fsl: qe: remove unused qe_ic_set_* functions
      soc: fsl: qe: don't use NO_IRQ in qe_ic.c
      soc: fsl: qe: make qe_ic_get_{low,high}_irq static
      soc: fsl: qe: simplify qe_ic_init()
      soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
      soc: fsl: qe: qe.c: use of_property_read_* helpers
      soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
      soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
      soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
      soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
      soc/fsl/qe/qe.h: update include path for cpm.h
      serial: ucc_uart: explicitly include soc/fsl/cpm.h
      serial: ucc_uart: replace ppc-specific IO accessors
      serial: ucc_uart: factor out soft_uart initialization
      serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
      serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
      serial: ucc_uart: limit brg-frequency workaround to PPC32
      serial: ucc_uart: access __be32 field using be32_to_cpu
      soc: fsl: qe: change return type of cpm_muram_alloc() to s32
      soc: fsl: qe: make cpm_muram_free() return void
      soc: fsl: qe: make cpm_muram_free() ignore a negative offset
      soc: fsl: qe: drop broken lazy call of cpm_muram_init()
      soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error path
      soc: fsl: qe: avoid IS_ERR_VALUE in ucc_slow.c
      soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
      soc: fsl: qe: drop pointless check in qe_sdma_init()
      soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
      net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
      net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
      net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
      net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
      soc: fsl: qe: remove unused #include of asm/irq.h from ucc.c
      soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE

Ravi Patel (1):
      drivers: firmware: xilinx: Add support for feature check

Sai Prakash Ranjan (1):
      dt-bindings: msm: Rename cache-controller to system-cache-controller

Sameer Pujar (1):
      bus: tegra-aconnect: Remove PM_CLK dependency

Sibi Sankar (5):
      dt-bindings: power: Add rpmh power-domain bindings for SM8150
      soc: qcom: rpmhpd: Add SM8150 RPMH power-domains
      dt-bindings: power: Add rpmh power-domain bindings for sc7180
      soc: qcom: rpmhpd: Add SC7180 RPMH power-domains
      dt-bindings: power: rpmpd: Convert rpmpd bindings to yaml

Sudeep Holla (12):
      firmware: arm_scmi: Add support for multiple device per protocol
      firmware: arm_scmi: Skip scmi mbox channel setup for addtional devices
      firmware: arm_scmi: Add names to scmi devices created
      firmware: arm_scmi: Add versions and identifier attributes using dev_groups
      firmware: arm_scmi: Match scmi device by both name and protocol id
      firmware: arm_scmi: Stash version in protocol init functions
      firmware: arm_scmi: Skip protocol initialisation for additional devices
      clk: scmi: Match scmi device by both name and protocol id
      cpufreq: scmi: Match scmi device by both name and protocol id
      hwmon: (scmi-hwmon) Match scmi device by both name and protocol id
      reset: reset-scmi: Match scmi device by both name and protocol id
      cpuidle: psci: Align psci_power_state count with idle state count

Suman Anna (1):
      bus: ti-sysc: Drop MMU quirks

Tejas Patel (1):
      drivers: soc: xilinx: Use mailbox IPI callback

Thierry Reding (10):
      memory: tegra: Refashion EMC debugfs interface on Tegra124
      memory: tegra: Implement EMC debugfs interface on Tegra20
      memory: tegra: Implement EMC debugfs interface on Tegra30
      memory: tegra: Rename tegra_mc to tegra186_mc on Tegra186
      memory: tegra: Add per-SoC data for Tegra186
      memory: tegra: Extract memory client SID programming
      memory: tegra: Add system sleep support
      memory: tegra: Support DVFS on Tegra186 and later
      memory: tegra: Only include support for enabled SoCs
      memory: tegra: Add support for the Tegra194 memory controller

Tomer Maimon (3):
      dt-bindings: reset: add NPCM reset controller documentation
      dt-bindings: reset: Add binding constants for NPCM7xx reset controller
      reset: npcm: add NPCM reset controller driver

Tony Lindgren (1):
      bus: ti-sysc: Implement quirk handling for CLKDM_NOAUTO

Ulf Hansson (13):
      dt: psci: Update DT bindings to support hierarchical PSCI states
      firmware: psci: Export functions to manage the OSI mode
      of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
      cpuidle: psci: Simplify OF parsing of CPU idle state nodes
      cpuidle: psci: Support hierarchical CPU idle states
      cpuidle: psci: Add a helper to attach a CPU to its PM domain
      cpuidle: psci: Attach CPU devices to their PM domains
      cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
      cpuidle: psci: Manage runtime PM in the idle path
      cpuidle: psci: Support CPU hotplug for the hierarchical model
      PM / Domains: Introduce a genpd OF helper that removes a subdomain
      cpuidle: psci: Add support for PM domains by using genpd
      arm64: dts: Convert to the hierarchical CPU topology layout for MSM8916

Yangtao Li (4):
      soc: samsung: exynos-pmu: Convert to devm_platform_ioremap_resource
      memory: samsung: exynos5422-dmc: Convert to devm_platform_ioremap_resource
      memory: mvebu-devbus: convert to devm_platform_ioremap_resource
      mailbox: armada-37xx-rwtm: convert to devm_platform_ioremap_resource

YueHaibing (1):
      soc: fsl: qe: remove set but not used variable 'mm_gc'

zhengbin (1):
      bus: ti-sysc: Use PTR_ERR_OR_ZERO() to simplify code


 Documentation/devicetree/bindings/arm/cpus.yaml |   15 +
 .../devicetree/bindings/arm/msm/qcom,llcc.yaml  |    2 +-
 Documentation/devicetree/bindings/arm/psci.yaml |  104 ++
 .../devicetree/bindings/power/qcom,rpmpd.txt    |  148 ---
 .../devicetree/bindings/power/qcom,rpmpd.yaml   |  170 +++
 .../bindings/power/reset/xlnx,zynqmp-power.txt  |   42 +-
 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml    |   37 +
 .../devicetree/bindings/reset/intel,rcu-gw.yaml |   63 +
 .../bindings/reset/nuvoton,npcm-reset.txt       |   32 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt |    6 +
 MAINTAINERS                                     |    5 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   57 +-
 arch/powerpc/include/asm/cpm.h                  |  172 +--
 arch/powerpc/platforms/83xx/km83xx.c            |    3 +-
 arch/powerpc/platforms/83xx/misc.c              |   23 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c       |    3 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c       |    3 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c       |    3 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c       |    3 +-
 arch/powerpc/platforms/83xx/mpc83xx.h           |    7 -
 arch/powerpc/platforms/85xx/corenet_generic.c   |   10 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c       |   27 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c       |   17 -
 arch/powerpc/platforms/85xx/twr_p102x.c         |   15 -
 drivers/base/power/domain.c                     |   38 +
 drivers/bus/Kconfig                             |    1 -
 drivers/bus/moxtet.c                            |    3 +-
 drivers/bus/ti-sysc.c                           |   18 +-
 drivers/clk/clk-scmi.c                          |    2 +-
 drivers/cpufreq/scmi-cpufreq.c                  |    2 +-
 drivers/cpuidle/Makefile                        |    4 +-
 drivers/cpuidle/cpuidle-psci-domain.c           |  308 +++++
 drivers/cpuidle/cpuidle-psci.c                  |  161 ++-
 drivers/cpuidle/cpuidle-psci.h                  |   17 +
 drivers/cpuidle/dt_idle_states.c                |    5 +-
 drivers/firmware/Kconfig                        |    8 -
 drivers/firmware/Makefile                       |    5 +-
 drivers/firmware/arm_scmi/bus.c                 |   29 +-
 drivers/firmware/arm_scmi/clock.c               |    2 +
 drivers/firmware/arm_scmi/common.h              |    2 +
 drivers/firmware/arm_scmi/driver.c              |  110 +-
 drivers/firmware/arm_scmi/perf.c                |    2 +
 drivers/firmware/arm_scmi/power.c               |    2 +
 drivers/firmware/arm_scmi/reset.c               |    2 +
 drivers/firmware/arm_scmi/scmi_pm_domain.c      |    2 +-
 drivers/firmware/arm_scmi/sensors.c             |    2 +
 drivers/firmware/imx/Kconfig                    |    2 +-
 drivers/firmware/psci/psci.c                    |   18 +-
 drivers/firmware/qcom_scm-32.c                  |  671 -----------
 drivers/firmware/qcom_scm-64.c                  |  579 ---------
 drivers/firmware/qcom_scm-legacy.c              |  242 ++++
 drivers/firmware/qcom_scm-smc.c                 |  151 +++
 drivers/firmware/qcom_scm.c                     |  854 ++++++++++---
 drivers/firmware/qcom_scm.h                     |  178 +--
 drivers/firmware/turris-mox-rwtm.c              |    2 +-
 drivers/firmware/xilinx/zynqmp.c                |   43 +
 drivers/hwmon/scmi-hwmon.c                      |    2 +-
 drivers/mailbox/armada-37xx-rwtm-mailbox.c      |    5 +-
 drivers/memory/mvebu-devbus.c                   |    4 +-
 drivers/memory/samsung/Kconfig                  |    2 +-
 drivers/memory/samsung/exynos-srom.c            |    2 +-
 drivers/memory/samsung/exynos5422-dmc.c         |    7 +-
 drivers/memory/tegra/Makefile                   |    3 +-
 drivers/memory/tegra/tegra124-emc.c             |  185 ++-
 drivers/memory/tegra/tegra186-emc.c             |  293 +++++
 drivers/memory/tegra/tegra186.c                 | 1117 +++++++++++++++++-
 drivers/memory/tegra/tegra20-emc.c              |  175 +++
 drivers/memory/tegra/tegra210.c                 |    2 +-
 drivers/memory/tegra/tegra30-emc.c              |  352 ++++--
 drivers/net/ethernet/freescale/Kconfig          |    2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                  |   23 +-
 drivers/net/wan/fsl_ucc_hdlc.h                  |    2 +-
 drivers/of/base.c                               |   36 +
 drivers/reset/Kconfig                           |   25 +-
 drivers/reset/Makefile                          |    3 +
 drivers/reset/core.c                            |   33 +-
 drivers/reset/reset-brcmstb-rescal.c            |  107 ++
 drivers/reset/reset-intel-gw.c                  |  262 ++++
 drivers/reset/reset-npcm.c                      |  291 +++++
 drivers/reset/reset-qcom-aoss.c                 |    3 +-
 drivers/reset/reset-scmi.c                      |    2 +-
 drivers/reset/reset-uniphier.c                  |   13 +-
 drivers/soc/bcm/brcmstb/biuctrl.c               |   30 +-
 drivers/soc/fsl/qe/Kconfig                      |    3 +-
 drivers/soc/fsl/qe/gpio.c                       |   36 +-
 drivers/soc/fsl/qe/qe.c                         |  104 +-
 drivers/soc/fsl/qe/qe_common.c                  |   50 +-
 drivers/soc/fsl/qe/qe_ic.c                      |  285 ++---
 drivers/soc/fsl/qe/qe_ic.h                      |   99 --
 drivers/soc/fsl/qe/qe_io.c                      |   70 +-
 drivers/soc/fsl/qe/qe_tdm.c                     |    8 +-
 drivers/soc/fsl/qe/ucc.c                        |   27 +-
 drivers/soc/fsl/qe/ucc_fast.c                   |   86 +-
 drivers/soc/fsl/qe/ucc_slow.c                   |   60 +-
 drivers/soc/fsl/qe/usb.c                        |    2 +-
 drivers/soc/imx/Kconfig                         |    2 +-
 drivers/soc/imx/soc-imx8.c                      |    9 +
 drivers/soc/mediatek/mtk-cmdq-helper.c          |    2 -
 drivers/soc/qcom/Kconfig                        |   30 +-
 drivers/soc/qcom/qmi_interface.c                |    8 +-
 drivers/soc/qcom/rpmhpd.c                       |   56 +
 drivers/soc/renesas/Kconfig                     |   14 +-
 drivers/soc/renesas/rcar-rst.c                  |    2 +-
 drivers/soc/samsung/Kconfig                     |    2 +-
 drivers/soc/samsung/exynos-chipid.c             |    2 +-
 drivers/soc/samsung/exynos-pmu.c                |    6 +-
 drivers/soc/samsung/exynos-pmu.h                |    2 +-
 drivers/soc/samsung/exynos3250-pmu.c            |    2 +-
 drivers/soc/samsung/exynos4-pmu.c               |    2 +-
 drivers/soc/samsung/exynos5250-pmu.c            |    2 +-
 drivers/soc/samsung/exynos5420-pmu.c            |    2 +-
 drivers/soc/tegra/Kconfig                       |    1 +
 drivers/soc/tegra/fuse/fuse-tegra.c             |    3 +
 drivers/soc/tegra/fuse/fuse-tegra30.c           |   29 +
 drivers/soc/tegra/fuse/fuse.h                   |    4 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c          |   34 +-
 drivers/soc/tegra/regulators-tegra20.c          |    8 +-
 drivers/soc/tegra/regulators-tegra30.c          |    6 +
 drivers/soc/ti/knav_qmss_queue.c                |    7 +-
 drivers/soc/xilinx/Kconfig                      |    6 +-
 drivers/soc/xilinx/zynqmp_power.c               |  120 +-
 drivers/tee/optee/core.c                        |  153 +--
 drivers/tty/serial/ucc_uart.c                   |  385 +++---
 include/dt-bindings/power/mt6765-power.h        |   14 +
 include/dt-bindings/power/qcom-rpmpd.h          |   24 +
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h   |   91 ++
 include/linux/cpuhotplug.h                      |    1 +
 include/linux/firmware/xlnx-zynqmp.h            |    7 +
 include/linux/of.h                              |    8 +
 include/linux/platform_data/ti-sysc.h           |    1 +
 include/linux/pm_domain.h                       |    8 +
 include/linux/psci.h                            |    2 +
 include/linux/qcom_scm.h                        |  119 +-
 include/linux/scmi_protocol.h                   |    5 +-
 include/linux/soc/samsung/exynos-pmu.h          |    2 +-
 include/linux/soc/samsung/exynos-regs-pmu.h     |   16 +-
 include/soc/fsl/cpm.h                           |  171 +++
 include/soc/fsl/qe/qe.h                         |   59 +-
 include/soc/fsl/qe/qe_ic.h                      |  135 ---
 include/soc/fsl/qe/ucc_fast.h                   |    4 +-
 include/soc/fsl/qe/ucc_slow.h                   |    6 +-
 include/trace/events/scmi.h                     |   90 ++
 142 files changed, 6604 insertions(+), 3301 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h
 delete mode 100644 drivers/firmware/qcom_scm-32.c
 delete mode 100644 drivers/firmware/qcom_scm-64.c
 create mode 100644 drivers/firmware/qcom_scm-legacy.c
 create mode 100644 drivers/firmware/qcom_scm-smc.c
 create mode 100644 drivers/memory/tegra/tegra186-emc.c
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c
 create mode 100644 drivers/reset/reset-intel-gw.c
 create mode 100644 drivers/reset/reset-npcm.c
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 create mode 100644 include/dt-bindings/power/mt6765-power.h
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
 create mode 100644 include/soc/fsl/cpm.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h
 create mode 100644 include/trace/events/scmi.h
