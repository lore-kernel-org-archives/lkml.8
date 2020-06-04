Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E06CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4660E207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgFDUyy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:54:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgFDUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:54:54 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6UqP-1ja2zZ0u53-006tDp for <linux-kernel@vger.kernel.org>; Thu, 04 Jun
 2020 22:54:48 +0200
Received: by mail-qv1-f48.google.com with SMTP id e2so3653060qvw.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:54:48 -0700 (PDT)
X-Gm-Message-State: AOAM532obFigeUmGhbsS3HGaOssthhAgg6+VBMFGFiKsgU4okP9zBKgx
        Dy2B/536/eSks976+BgJGFH6dfllbAVsXrsLuQs=
X-Google-Smtp-Source: ABdhPJzJFOXj2XzAOaURHbASJ3tNAa8l56JQI0SzhnelYGEIBYgkzTohh61SRnPExQo+BXbPHzlD/e053L0gKapK5uA=
X-Received: by 2002:a0c:c1cf:: with SMTP id v15mr6834415qvh.4.1591304086897;
 Thu, 04 Jun 2020 13:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
 <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com> <CAK8P3a3w4euZfDQPt7wqWg9w4uf7SM4NLeA2CyOMmgNGPAdQaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3w4euZfDQPt7wqWg9w4uf7SM4NLeA2CyOMmgNGPAdQaQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jun 2020 22:54:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fCyYgoexi6NiAY2cch5C-7EEkNGy6PJGxjJ-2yMndLA@mail.gmail.com>
Message-ID: <CAK8P3a2fCyYgoexi6NiAY2cch5C-7EEkNGy6PJGxjJ-2yMndLA@mail.gmail.com>
Subject: [GIT PULL 3/4] ARM: driver updates for v5.8
List-Id: <soc.lore.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:DMpq7S802CcBoYKxKDQ24RjTKc3l3hLTb8iKvYMdrR30x+CxuYv
 dDS3oZzlAI1ZbP4FvFjgJqcTrrxKbBcvnKTZeMVWUZ2QGc8lRq9KEiwXDxz84Z/hrsITXPy
 Uzemn3Yz42XTqHCZsGU6ixK0ugyAFdxwioJjYLojtT3/qM3gOhnYnXwArZf05nICM1D540K
 haSmkBj8X7ntOO/OwG0Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iQzPPtAGXw=:DwVVC9qYRPXY5eN7GBoLvp
 Kp+w81CDdFbIVpgV17Ga+erZQtlkVxyJjW9wLhSyivew1Y5XteARiG/Bssrn7YbhEQ7OiDdRD
 CXamKMbQswj37aDqrdLfa7H6C5Ke1P067ZdD58sMwnNU8Q60RDA4dfQD9dnYivFNV8IwDdLP0
 fxNifw/Fa2q6zvNp3Ks29T7z2UaQrERuzpuD18/N+Mi3bWBj4pY7QuvfK5YJycENldmuJ8P7Z
 ehFfbSuI49ptmePXmwes60kPVCwV9YFUbTp+KgctAXpzkSNnAKtMOAdTXxk2YT3H2x32STiRh
 pAqKebApWNEGcwVv25Z//cbCm4LQSKetiBtF9s7jLuQutkLuPqUqLlWlxhpZGKAoXrkBBl2kX
 FIJNmAzUpgm+NiDl1MKnYQfPp5pKTMPGrH7VLUuXDz0tV4CtGDO/6iMZdWWCO6ELhJcPNcROI
 62haJqCEpIeJ6jkssu/ad5Dw+GS7kBNtKfXVAbn9Uco886P0dztraSG0y6B052LPOtBzTkVdp
 pJhUWgqTCpdUASs9yYX1d1IILBDaXwDQ/VAdGUJF9NEI+nhawj6XOQwh7fR6emBPLRvM14f+Q
 TLi3ykxDLMHtLbh85yqToYfPGrZ8xLVVgALaWMJvSWl8mhwkixEn4r9QCzRgmrvXXJcC3xemM
 oTPm/pPe6/ZPZdQOmfprluixVtJ2a2ZiJQaTraRhJbYqHFzJBIAadG6SboyZg83bHHQpPPnyt
 Oyc3ZtRuHQOIREoL/GAJx7rONFOtDL8zPXNTG89JVUKe6t0/4T1G/+FIvi/wZ8k5d/Ibw2eg+
 AITpj3fbsh+enZ7gm0Llefgsie/CE/Y4YnvzAfFZGac46fKr0s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-drivers-5.8

for you to fetch changes up to b5f73d47f34b238221ac771b5fe4907df621d7cb:

  clk: sprd: fix compile-testing (2020-06-03 12:57:28 +0200)

----------------------------------------------------------------
ARM/SoC: drivers for v5.7

These are updates to SoC specific drivers that did not have
another subsystem maintainer tree to go through for some
reason:

- Some bus and memory drivers for the MIPS P5600 based
  Baikal-T1 SoC that is getting added through the MIPS tree.

- There are new soc_device identification drivers for TI K3,
  Qualcomm MSM8939

- New reset controller drivers for NXP i.MX8MP, Renesas
  RZ/G1H, and Hisilicon hi6220

- The SCMI firmware interface can now work across ARM SMC/HVC
  as a transport.

- Mediatek platforms now use a new driver for their "MMSYS"
  hardware block that controls clocks and some other aspects
  in behalf of the media and gpu drivers.

- Some Tegra processors have improved power management
  support, including getting woken up by the PMIC and cluster
  power down during idle.

- A new v4l staging driver for Tegra is added.

- Cleanups and minor bugfixes for TI, NXP, Hisilicon,
  Mediatek, and Tegra.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (4):
      soc: imx8m: No need to put node when of_find_compatible_node() failed
      dt-bindings: reset: imx7: Add support for i.MX8MN
      dt-bindings: reset: imx7: Document usage on i.MX8MP SoC
      reset: imx7: Add support for i.MX8MP SoC

Arnd Bergmann (28):
      soc: tegra: Fix tegra_pmc_get_suspend_mode definition
      Merge tag 'scmi-updates-5.8' of
git://git.kernel.org/.../sudeep.holla/linux into arm/drivers
      Merge tag 'renesas-drivers-for-v5.8-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'tee-subsys-for-5.8' of
git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'renesas-drivers-for-v5.8-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'tegra-for-5.8-firmware-v2' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'v5.7-next-soc' of
git://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'tee-smatch-for-5.8' of
git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'amlogic-drivers' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'reset-for-v5.8' of git://git.pengutronix.de/pza/linux
into arm/drivers
      Merge tag 'tee-login-for-5.8' of
git://git.linaro.org/people/jens.wiklander/linux-tee into arm/drivers
      Merge tag 'v5.7-next-soc.2' of
git://git.kernel.org/.../matthias.bgg/linux into arm/drivers
      Merge tag 'qcom-drivers-for-5.8' of
git://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'samsung-drivers-5.8' of
git://git.kernel.org/.../krzk/linux into arm/drivers
      Merge tag 'tegra-for-5.8-cpufreq' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.8-cpuidle' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.8-of' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.8-media' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.8-soc-v2' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'imx-drivers-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'hisi-drivers-for-5.8' of
git://github.com/hisilicon/linux-hisi into arm/drivers
      tee: fix crypto select
      Merge tag 'soc-fsl-next-v5.8' of
git://git.kernel.org/.../leo/linux into arm/drivers
      staging: tegra-video: fix V4L2 dependency
      Merge tag 'drivers_soc_for_5.8' of
git://git.kernel.org/.../ssantosh/linux-keystone into arm/drivers
      Merge branch 'baikal/drivers' into arm/drivers
      Merge branch 'baikal/drivers' into arm/drivers
      clk: sprd: fix compile-testing

Bernard Zhao (2):
      memory: samsung: exynos5422-dmc: Fix tFAW timings alignment
      memory: samsung: exynos5422-dmc: Reduce protected code area in IRQ handler

Bjorn Andersson (3):
      soc: qcom: rpmhpd: Add SM8250 power domains
      soc: qcom: aoss: Add SM8250 compatible
      Revert "soc: qcom: rpmh: Allow RPMH driver to be loaded as a module"

Christoph Hellwig (1):
      firmware: qcom_scm: fix bogous abuse of dma-direct internals

Colin Ian King (1):
      soc: fsl: qe: clean up an indentation issue

Corentin Labbe (1):
      soc/tegra: pmc: Select GENERIC_PINCONF

Cristian Marussi (5):
      firmware: arm_scmi: Add notifications support in transport layer
      firmware: arm_scmi: Rename .clear_notification() transport_ops
      firmware: arm_scmi: Clear channel on reception of unexpected responses
      firmware: arm_scmi: Clear channel for delayed responses
      firmware: arm_scmi: Fix handling of unexpected delayed responses

Dan Carpenter (1):
      tee: remove unnecessary NULL check in tee_shm_alloc()

Dmitry Osipenko (6):
      firmware: tf: Different way of L2 cache enabling after LP2 suspend
      ARM: tegra: Initialize r0 register for firmware wake-up
      ARM: tegra: Do not fully reinitialize L2 on resume
      cpuidle: tegra: Support CPU cluster power-down state on Tegra30
      cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported now)
      dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30

Dong Aisheng (2):
      dt-bindings: firmware: imx: Move system control into dt-binding headfile
      dt-bindings: firmware: imx: Add more system controls and PM clock types

Douglas Anderson (18):
      soc: qcom: rpmh-rsc: Clean code reading/writing TCS regs/cmds
      soc: qcom: rpmh-rsc: Document the register layout better
      soc: qcom: rpmh-rsc: Fold tcs_ctrl_write() into its single caller
      soc: qcom: rpmh-rsc: Remove get_tcs_of_type() abstraction
      soc: qcom: rpmh-rsc: Kill cmd_cache and find_match() with fire
      soc: qcom: rpmh-rsc: A lot of comments
      soc: qcom: rpmh-rsc: tcs_is_free() can just check tcs_in_use
      soc: qcom: rpmh-rsc: Don't double-check rpmh payload
      soc: qcom: rpmh-rsc: Caller handles tcs_invalidate() exclusivity
      soc: qcom: rpmh-rsc: read_tcs_reg()/write_tcs_reg() are not for IRQ
      soc: qcom: rpmh: Dirt can only make you dirtier, not cleaner
      soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and "tcs_cmd_addr" calculation
      soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()
      soc: qcom: rpmh-rsc: Correctly ignore CPU_CLUSTER_PM notifications
      soc: qcom: rpmh-rsc: We aren't notified of our own failure w/ NOTIFY_BAD
      kernel/cpu_pm: Fix uninitted local in cpu_pm
      soc: qcom: rpmh-rsc: Simplify locking by eliminating the per-TCS lock
      soc: qcom: rpmh-rsc: Remove the pm_lock

Enric Balletbo i Serra (6):
      dt-bindings: mediatek: Update mmsys binding to reflect it is a
system controller
      soc / drm: mediatek: Move routing control to mmsys device
      soc / drm: mediatek: Fix mediatek-drm device probing
      soc: mediatek: Enable mmsys driver by default if Mediatek arch is selected
      clk / soc: mediatek: Bind clock and gpu driver for mt2712
      clk / soc: mediatek: Bind clock and gpu driver for mt2701

Franck LENORMAND (1):
      firmware: imx: scu: Fix corruption of header

Geert Uytterhoeven (4):
      Merge tag 'renesas-r8a7742-dt-binding-defs-tag' into
renesas-drivers-for-v5.8
      of: Make <linux/of_reserved_mem.h> self-contained
      soc: mediatek: mmsys: Drop <linux/clk-provider.h>
      ARM: mediatek: Replace <linux/clk-provider.h> by <linux/of_clk.h>

Grygorii Strashko (2):
      dt-bindings: soc: ti: add binding for k3 platforms chipid module
      soc: ti: add k3 platforms chipid module driver

Gustavo A. R. Silva (3):
      firmware: qcom_scm-legacy: Replace zero-length array with flexible-array
      treewide: Replace zero-length array with flexible-array
      soc: fsl: qe: Replace one-element array and use struct_size() helper

Jason Yan (1):
      firmware: qcom_scm: Remove unneeded conversion to bool

Jerome Brunet (1):
      dt-bindings: reset: meson: add gxl internal dac reset

John Garry (3):
      io: Provide _inX() and _outX()
      logic_pio: Improve macro argument name
      logic_pio: Use _inX() and _outX()

John Stultz (3):
      soc: qcom: rpmh: Allow RPMH driver to be loaded as a module
      soc: qcom: rpmhpd: Allow RPMHPD driver to be loaded as a module
      soc: qcom: rpmpd: Allow RPMPD driver to be loaded as a module

Jon Hunter (6):
      soc/tegra: fuse: Add custom SoC attributes
      soc/tegra: fuse: Trivial clean-up of tegra_init_revision()
      soc/tegra: fuse: Update the SoC revision attribute to display a name
      soc/tegra: pmc: Enable PMIC wake event on Tegra194
      soc/tegra: pmc: Enable PMIC wake event on Tegra210
      firmware: tegra: Defer BPMP probe if shared memory not available

Joseph Lo (1):
      dt-bindings: memory: tegra: Add external memory controller
binding for Tegra210

Lad Prabhakar (5):
      dt-bindings: power: rcar-sysc: Add r8a7742 power domain index macros
      clk: renesas: Add r8a7742 CPG Core Clock Definitions
      soc: renesas: rcar-sysc: Add R8A7742 support
      soc: renesas: rcar-rst: Add support for RZ/G1H
      soc: renesas: Add Renesas R8A7742 config option

Lukas Bulwahn (1):
      MAINTAINERS: correct path in TEGRA VIDEO DRIVER

Markus Elfring (1):
      soc: qcom: smp2p: Delete an error message in qcom_smp2p_probe()

Martin Blumenstingl (4):
      dt-bindings: power: meson-ee-pwrc: add support for Meson8/8b/8m2
      dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
      soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
      soc: amlogic: meson-ee-pwrc: add support for the Meson GX SoCs

Matthias Brugger (5):
      drm/mediatek: Omit warning on probe defers
      clk / soc: mediatek: Move mt8173 MMSYS to platform driver
      clk/soc: mediatek: mt8183: Bind clock driver from platform device
      clk/soc: mediatek: mt6797: Bind clock driver from platform device
      clk/soc: mediatek: mt6779: Bind clock driver from platform device

Maulik Shah (4):
      soc: qcom: rpmh: Update dirty flag only when data changes
      soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
      soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
      soc: qcom: rpmh-rsc: Allow using free WAKE TCS for active request

Peng Fan (3):
      dt-bindings: arm: Add smc/hvc transport for SCMI
      firmware: arm_scmi: Add smc/hvc transport
      firmware: imx-scu: Support one TX and one RX

Peter Griffin (1):
      reset: hi6220: Add support for AO reset controller

Raju P.L.S.S.S.N (1):
      soc: qcom: rpmh-rsc: Clear active mode configuration for wake TCS

Roy Pledge (1):
      soc: fsl: dpio: Prefer the CPU affine DPIO

Samuel Zou (2):
      media: tegra-video: Make tegra210_video_formats static
      drivers: soc: ti: knav_qmss_queue: Make knav_gp_range_ops static

Serge Semin (14):
      dt-bindings: bus: Add Baikal-T1 AXI-bus binding
      dt-bindings: bus: Add Baikal-T1 APB-bus binding
      bus: Add Baikal-T1 AXI-bus driver
      bus: Add Baikal-T1 APB-bus driver
      memory: Add Baikal-T1 L2-cache Control Block driver
      dt-bindings: memory: Add Baikal-T1 L2-cache Control Block binding
      bus: bt1-apb: Include linux/io.h
      bus: bt1-apb: Fix show/store callback identations
      bus: bt1-apb: Use PTR_ERR_OR_ZERO to return from request-regs method
      bus: bt1-apb: Use sysfs_streq instead of strncmp
      bus: bt1-axi: Optimize the return points in the driver
      bus: bt1-axi: Use sysfs_streq instead of strncmp
      bus: bt1-apb: Build the driver into the kernel
      bus: bt1-axi: Build the driver into the kernel

Sibi Sankar (2):
      soc: qcom: cmd-db: Fix compilation error when CMD_DB is disabled
      soc: qcom: pdr: Remove impossible error condition

Sowjanya Komatineni (5):
      dt-bindings: clock: tegra: Add clock ID for CSI TPG clock
      dt-bindings: clock: tegra: Remove PMC clock IDs
      dt-bindings: tegra: Add VI and CSI bindings
      media: tegra-video: Add Tegra210 Video input driver
      MAINTAINERS: Add Tegra Video driver section

Srinivas Kandagatla (1):
      soc: qcom: socinfo: add missing soc_id sysfs entry

Stephan Gerhold (1):
      dt-bindings: soc: qcom: apr: Use generic node names for APR services

Stephen Boyd (4):
      soc: qcom: cmd-db: Add debugfs dumping file
      soc: qcom: cmd-db: Cast sizeof() to int to silence field width warning
      soc: qcom: cmd-db: Use 5 digits for printing address
      soc: qcom: cmd-db: Properly endian swap the slv_id for debugfs

Sudeep Holla (11):
      firmware: arm_scmi: Make mutex channel specific
      firmware: arm_scmi: Drop empty stub for smc_mark_txdone
      firmware: arm_scmi: Check shmem property for channel availablity
      firmware: arm_scmi: Drop checking for shmem property in parent node
      firmware: arm_scmi: Add include guard to linux/scmi_protocol.h
      firmware: arm_scpi: Add include guard to linux/scpi_protocol.h
      firmware: arm_scmi: Add receive buffer support for notifications
      firmware: arm_scmi: Update protocol commands and notification list
      firmware: arm_scmi: Add support for notifications message processing
      firmware: arm_scmi: Fix return error code in smc_send_message
      firmware: arm_scmi: fix psci dependency

Sumit Garg (2):
      tee: enable support to register kernel memory
      tee: add private login method for kernel clients

Thierry Reding (9):
      firmware: tegra: Make BPMP a regular driver
      soc/tegra: pmc: Enable PMIC wake event on Tegra186
      of: reserved-memory: Support lookup of regions by name
      of: reserved-memory: Support multiple regions per device
      Merge branch 'for-5.8/firmware' into for-5.8/arm/core
      Merge branch 'for-5.8/arm/core' into for-5.8/cpuidle
      dt-bindings: i2c: tegra: Document Tegra210 VI I2C
      Merge branch 'for-5.8/dt-bindings' into for-5.8/media
      media: tegra-video: Do not enable COMPILE_TEST

Vesa Jääskeläinen (2):
      tee: add support for session's client UUID generation
      tee: optee: Add support for session login client UUID generation

Vincent Knecht (1):
      soc: qcom: socinfo: add msm8936/39 and apq8036/39 soc ids

Wei Yongjun (2):
      soc: mediatek: Missing platform_device_unregister() on error in
mtk_mmsys_probe()
      firmware: imx: scu: Fix possible memory leak in imx_scu_probe()

YueHaibing (2):
      soc: fsl: qbman: Remove unused inline function qm_eqcr_get_ci_stashing
      soc: fsl: dpio: Remove unused inline function
qbman_write_eqcr_am_rt_register

 Documentation/devicetree/bindings/arm/arm,scmi.txt |    3 +-
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    7 +-
 .../devicetree/bindings/bus/baikal,bt1-apb.yaml    |   90 ++
 .../devicetree/bindings/bus/baikal,bt1-axi.yaml    |  107 ++
 .../bindings/cpufreq/nvidia,tegra20-cpufreq.txt    |   56 +
 .../display/tegra/nvidia,tegra20-host1x.txt        |   73 +-
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |    6 +
 .../memory-controllers/baikal,bt1-l2-ctl.yaml      |   63 ++
 .../memory-controllers/nvidia,tegra210-emc.yaml    |   82 ++
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |  102 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../devicetree/bindings/reset/fsl,imx7-src.txt     |    6 +-
 .../devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt |    1 +
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   20 +-
 .../devicetree/bindings/soc/ti/k3-socinfo.yaml     |   40 +
 MAINTAINERS                                        |   10 +
 arch/arm/mach-mediatek/mediatek.c                  |    2 +-
 arch/arm/mach-tegra/pm.c                           |    4 +
 arch/arm/mach-tegra/reset-handler.S                |    7 +-
 arch/arm64/Kconfig.platforms                       |    2 +-
 drivers/bus/Kconfig                                |   30 +
 drivers/bus/Makefile                               |    2 +
 drivers/bus/bt1-apb.c                              |  421 ++++++++
 drivers/bus/bt1-axi.c                              |  314 ++++++
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/mediatek/Kconfig                       |    7 +
 drivers/clk/mediatek/Makefile                      |    1 +
 drivers/clk/mediatek/clk-mt2701-mm.c               |    9 +-
 drivers/clk/mediatek/clk-mt2712-mm.c               |    9 +-
 drivers/clk/mediatek/clk-mt6779-mm.c               |    9 +-
 drivers/clk/mediatek/clk-mt6797-mm.c               |    9 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |  146 +++
 drivers/clk/mediatek/clk-mt8173.c                  |  104 --
 drivers/clk/mediatek/clk-mt8183-mm.c               |    9 +-
 drivers/cpufreq/Kconfig.arm                        |    6 +-
 drivers/cpufreq/tegra20-cpufreq.c                  |  217 +---
 drivers/cpuidle/cpuidle-tegra.c                    |    1 -
 drivers/firmware/arm_scmi/Makefile                 |    4 +-
 drivers/firmware/arm_scmi/base.c                   |    7 +
 drivers/firmware/arm_scmi/common.h                 |   11 +
 drivers/firmware/arm_scmi/driver.c                 |  133 ++-
 drivers/firmware/arm_scmi/mailbox.c                |   17 +
 drivers/firmware/arm_scmi/perf.c                   |    5 +
 drivers/firmware/arm_scmi/power.c                  |    6 +
 drivers/firmware/arm_scmi/sensors.c                |    4 +
 drivers/firmware/arm_scmi/shmem.c                  |   15 +
 drivers/firmware/arm_scmi/smc.c                    |  153 +++
 drivers/firmware/imx/imx-scu.c                     |   64 +-
 drivers/firmware/qcom_scm-legacy.c                 |    2 +-
 drivers/firmware/qcom_scm.c                        |   11 +-
 drivers/firmware/tegra/bpmp-tegra186.c             |    4 +-
 drivers/firmware/tegra/bpmp.c                      |    9 +-
 drivers/firmware/trusted_foundations.c             |   21 +-
 drivers/gpu/drm/mediatek/Kconfig                   |    1 +
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |    5 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |    5 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |    5 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   12 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   19 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  259 +----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |    7 -
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   45 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |    2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    8 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    4 +-
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/bt1-l2-ctl.c                        |  322 ++++++
 drivers/memory/samsung/exynos5422-dmc.c            |    8 +-
 drivers/of/of_reserved_mem.c                       |   41 +-
 drivers/reset/hisilicon/hi6220_reset.c             |   69 +-
 drivers/reset/reset-imx7.c                         |  101 ++
 drivers/soc/amlogic/meson-ee-pwrc.c                |  112 +-
 drivers/soc/fsl/dpio/dpio-service.c                |    6 +-
 drivers/soc/fsl/dpio/qbman-portal.c                |   12 -
 drivers/soc/fsl/qbman/qman.c                       |    5 -
 drivers/soc/fsl/qe/qe.c                            |    4 +-
 drivers/soc/fsl/qe/ucc.c                           |    2 +-
 drivers/soc/imx/soc-imx8m.c                        |    7 +-
 drivers/soc/mediatek/Kconfig                       |    7 +
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mtk-mmsys.c                   |  378 +++++++
 drivers/soc/qcom/Kconfig                           |    6 +-
 drivers/soc/qcom/cmd-db.c                          |   78 +-
 drivers/soc/qcom/pdr_interface.c                   |    4 -
 drivers/soc/qcom/qcom_aoss.c                       |    1 +
 drivers/soc/qcom/rpmh-internal.h                   |   59 +-
 drivers/soc/qcom/rpmh-rsc.c                        |  746 ++++++++++----
 drivers/soc/qcom/rpmh.c                            |   97 +-
 drivers/soc/qcom/rpmhpd.c                          |   24 +
 drivers/soc/qcom/rpmpd.c                           |    5 +
 drivers/soc/qcom/smp2p.c                           |    4 +-
 drivers/soc/qcom/socinfo.c                         |    6 +
 drivers/soc/renesas/Kconfig                        |   11 +
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/r8a7742-sysc.c                 |   42 +
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 drivers/soc/renesas/rcar-sysc.c                    |    3 +
 drivers/soc/renesas/rcar-sysc.h                    |    1 +
 drivers/soc/tegra/Kconfig                          |    1 +
 drivers/soc/tegra/fuse/fuse-tegra.c                |   57 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c              |    1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c              |    6 +
 drivers/soc/tegra/fuse/fuse.h                      |    8 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   32 +-
 drivers/soc/tegra/pmc.c                            |    3 +
 drivers/soc/ti/Kconfig                             |   10 +
 drivers/soc/ti/Makefile                            |    1 +
 drivers/soc/ti/k3-socinfo.c                        |  152 +++
 drivers/soc/ti/knav_qmss_queue.c                   |    2 +-
 drivers/staging/media/Kconfig                      |    2 +
 drivers/staging/media/Makefile                     |    1 +
 drivers/staging/media/tegra-video/Kconfig          |   12 +
 drivers/staging/media/tegra-video/Makefile         |    8 +
 drivers/staging/media/tegra-video/TODO             |   11 +
 drivers/staging/media/tegra-video/csi.c            |  539 ++++++++++
 drivers/staging/media/tegra-video/csi.h            |  147 +++
 drivers/staging/media/tegra-video/tegra210.c       |  978 ++++++++++++++++++
 drivers/staging/media/tegra-video/vi.c             | 1074 ++++++++++++++++++++
 drivers/staging/media/tegra-video/vi.h             |  257 +++++
 drivers/staging/media/tegra-video/video.c          |  155 +++
 drivers/staging/media/tegra-video/video.h          |   29 +
 drivers/tee/Kconfig                                |    2 +
 drivers/tee/optee/call.c                           |    6 +-
 drivers/tee/tee_core.c                             |  159 +++
 drivers/tee/tee_shm.c                              |   31 +-
 drivers/thermal/imx_sc_thermal.c                   |    2 +-
 include/asm-generic/io.h                           |   64 +-
 include/dt-bindings/clock/r8a7742-cpg-mssr.h       |   42 +
 include/dt-bindings/clock/tegra114-car.h           |   14 +-
 include/dt-bindings/clock/tegra124-car-common.h    |   14 +-
 include/dt-bindings/clock/tegra20-car.h            |    2 +-
 include/dt-bindings/clock/tegra210-car.h           |   16 +-
 include/dt-bindings/clock/tegra30-car.h            |   14 +-
 include/dt-bindings/firmware/imx/rsrc.h            |   84 ++
 include/dt-bindings/power/meson-gxbb-power.h       |   13 +
 include/dt-bindings/power/meson8-power.h           |   13 +
 include/dt-bindings/power/qcom-rpmpd.h             |   12 +
 include/dt-bindings/power/r8a7742-sysc.h           |   29 +
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |    2 +-
 include/dt-bindings/reset/imx8mp-reset.h           |   50 +
 include/dt-bindings/reset/imx8mq-reset.h           |   56 +-
 include/linux/firmware/imx/sci.h                   |    1 -
 include/linux/firmware/imx/types.h                 |   65 --
 include/linux/firmware/trusted_foundations.h       |    1 +
 include/linux/fsl/bestcomm/bestcomm.h              |    2 +-
 include/linux/of_reserved_mem.h                    |   12 +
 include/linux/scmi_protocol.h                      |    6 +
 include/linux/scpi_protocol.h                      |    6 +
 include/linux/soc/mediatek/mtk-mmsys.h             |   20 +
 include/linux/tee_drv.h                            |   17 +
 include/soc/fsl/qe/qe.h                            |    2 +-
 include/soc/qcom/cmd-db.h                          |    1 +
 include/uapi/linux/tee.h                           |    9 +
 kernel/cpu_pm.c                                    |    4 +-
 lib/logic_pio.c                                    |   22 +-
 156 files changed, 8030 insertions(+), 1241 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/baikal,bt1-apb.yaml
 create mode 100644 Documentation/devicetree/bindings/bus/baikal,bt1-axi.yaml
 create mode 100644
Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
 create mode 100644
Documentation/devicetree/bindings/memory-controllers/baikal,bt1-l2-ctl.yaml
 create mode 100644
Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
 create mode 100644 drivers/bus/bt1-apb.c
 create mode 100644 drivers/bus/bt1-axi.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-mm.c
 create mode 100644 drivers/firmware/arm_scmi/smc.c
 create mode 100644 drivers/memory/bt1-l2-ctl.c
 create mode 100644 drivers/soc/mediatek/mtk-mmsys.c
 create mode 100644 drivers/soc/renesas/r8a7742-sysc.c
 create mode 100644 drivers/soc/ti/k3-socinfo.c
 create mode 100644 drivers/staging/media/tegra-video/Kconfig
 create mode 100644 drivers/staging/media/tegra-video/Makefile
 create mode 100644 drivers/staging/media/tegra-video/TODO
 create mode 100644 drivers/staging/media/tegra-video/csi.c
 create mode 100644 drivers/staging/media/tegra-video/csi.h
 create mode 100644 drivers/staging/media/tegra-video/tegra210.c
 create mode 100644 drivers/staging/media/tegra-video/vi.c
 create mode 100644 drivers/staging/media/tegra-video/vi.h
 create mode 100644 drivers/staging/media/tegra-video/video.c
 create mode 100644 drivers/staging/media/tegra-video/video.h
 create mode 100644 include/dt-bindings/clock/r8a7742-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h
 create mode 100644 include/dt-bindings/power/meson8-power.h
 create mode 100644 include/dt-bindings/power/r8a7742-sysc.h
 create mode 100644 include/dt-bindings/reset/imx8mp-reset.h
 delete mode 100644 include/linux/firmware/imx/types.h
 create mode 100644 include/linux/soc/mediatek/mtk-mmsys.h
