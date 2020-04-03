Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D2D206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDCVfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:35:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:35:30 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MAORp-1jUcK545c3-00BvF0 for <linux-kernel@vger.kernel.org>; Fri, 03 Apr
 2020 23:35:27 +0200
Received: by mail-qv1-f52.google.com with SMTP id v38so4382778qvf.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:35:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuZoKZhSSyJqRwg5MaMMEQbaypob+H2hEKWOOkZ3Tc38LiWYozQT
        qYXG46p6Q8AekoH7+Wa59cHAspZCKTjKCBfijSo=
X-Google-Smtp-Source: APiQypKuSl73lVJtADJSwHMirPnVIrpUbge7bKeeDmUqQVP2gryUkv3FPgZFAFc537SRr8QmargpKqzJp5W6h6MBOkI=
X-Received: by 2002:a0c:9e2f:: with SMTP id p47mr9812907qve.211.1585949725814;
 Fri, 03 Apr 2020 14:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Apr 2020 23:35:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Z7yj0wgMkT2YsWBU56557O66rLGLzGSJSuC+8nWx1zA@mail.gmail.com>
Message-ID: <CAK8P3a0Z7yj0wgMkT2YsWBU56557O66rLGLzGSJSuC+8nWx1zA@mail.gmail.com>
Subject: [GIT PULL 2/4] ARM: driver updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:shy4fN6bahdtA/ewnfD2M/OYVvRImnUZfLdHchrJlOF8GuDddzF
 hp1nAFyHs6zf6r9m2NEAjVtJn5+Jbe2vXiWi7KBQQt7msCRsBbGIK7mLS/jZkXDr3oV0A1p
 tihvWmy5t+OFo12V2Vue9Mk1QJOgjTGfc2gQCQFuTsLXKtyZSYEv2ufm49u1nu+Nrc8CPER
 DsvogeJKZxfSK2C8R2mXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sd6ZUVslQCU=:0cnhOueZ9jaUwmnVKPRJow
 UPEnhWoJpqwnfa1bRevW97kGZ7A1YtKsxqQA+TeqKwjV/lVot3GuYJFTqKs7Q9PegXi6Mqo/5
 NFgVsWxs5IMdTIKqfk2NmGlccNcY2V/SDx2FvXwtHNF54K+dlmjYBncT2LUykkwn2Nx3/+ql0
 SJmCUFdKfUjlwDFoEPccZc5eTaBqRLGAENLLY2ulXJPCaPknr98vC3A9qUmTxaq0Bt+kyFrQd
 sBoMMmqScxRzsoBPGLe7KnhstiZTLFhA2RHjTrSe7HZPwA92VPCcnfZb/LRx1C99TYLYVYhvz
 1cF3+Luip8nFiwwpeuu2RjGR5l2L3a+Oj5huG/wz/l0d9sGedA/gwG41zNePFhRkdos3/EhWO
 OVCCeOf/BrzEMOsulnJXI7C6zChk7yG02iLCZqV3xr/cZz4vkOb84JZH6ZZaSywYxkBCFHZzB
 MPVX+rhMpQVjBx+mcLCO7C8B8DIJUNOfRDp2aMBLYAgiE7ZuK6QOW1pF09//pc9prOiWaLb24
 W0KDa7z0ZA2z1epLllAxGLgCHugQ/5gy9D3c38uLvNwoCbEzVZm9kvXnBivZJPfhVjvvIrX0h
 cGAGhouHyrgMqTAkLEKaBpz5DMQL4DzQjMrBr01WiU04DGIyXD+XrTkHBHftkfknQsvU6tp/6
 V0Od2F2YiUl2gPPjPn/9QgUfTf6Thek4JTudwA5PB0bREbMnCXtMzSs7O9/UZhQ9MeYK9RXo7
 FA8hK51kkm0PPvKcclvJhmyYhsw9BfTC2MaIwRmKdVBwfXxG1hwikyY6AuzFsVkWes70QSNV8
 RrRcn2VGSrpUGgwyKi7yG3bIfBVb/oIrDFMNIccKW/GcdBIg7k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cfaf6051eccc7b8b2354f68c5125d2497b046052:

  bus: ti-sysc: Fix quirk flags for lcdc on am335x (2020-03-09 09:41:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-drivers-5.7

for you to fetch changes up to cedb414aa8c31ce2f178ea9dc29b6c0200b9893f:

  Merge tag 'scmi-updates-5.7' of
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into
arm/drivers (2020-03-27 14:26:14 +0100)

----------------------------------------------------------------
ARM: driver updates

These are the usual updates for SoC specific device drivers and related
subsystems that don't have their own top-level maintainers:

- ARM SCMI/SCPI updates to allow pluggable transport layers

- TEE subsystem cleanups

- A new driver for the Amlogic secure power domain controller

- Various driver updates for the NXP Layerscape DPAA2, NXP i.MX SCU and
  TI OMAP2+ sysc drivers.

- Qualcomm SoC driver updates, including a new library module for
  "protection domain" notifications

- Lots of smaller bugfixes and cleanups in other drivers

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (1):
      firmware: imx: add COMPILE_TEST for IMX_SCU driver

Ansuel Smith (1):
      devicetree: bindings: firmware: add ipq806x to qcom_scm

Arnd Bergmann (12):
      Merge tag 'renesas-drivers-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/drivers
      Merge tag 'hisi-drivers-for-5.7' of
git://github.com/hisilicon/linux-hisi into arm/drivers
      Merge tag 'omap-for-v5.7/ti-sysc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/drivers
      Merge tag 'amlogic-drivers' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/drivers
      Merge tag 'qcom-drivers-for-5.7' of
git://git.kernel.org/.../qcom/linux into arm/drivers
      Merge tag 'imx-drivers-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/drivers
      Merge tag 'omap-for-v5.7/ti-sysc-fix-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/drivers
      Merge tag 'tegra-for-5.7-firmware' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'tegra-for-5.7-memory' of
git://git.kernel.org/.../tegra/linux into arm/drivers
      Merge tag 'soc-fsl-next-v5.7' of
git://git.kernel.org/.../leo/linux into arm/drivers
      Merge tag 'tee-cleanup-for-5.7' of
https://git.linaro.org/people/jens.wiklander/linux-tee into
arm/drivers
      Merge tag 'scmi-updates-5.7' of
git://git.kernel.org/.../sudeep.holla/linux into arm/drivers

Arun Kumar Neelakantam (2):
      soc: qcom: aoss: Use wake_up_all() instead of wake_up_interruptible_all()
      soc: qcom: aoss: Read back before triggering the IRQ

Bjorn Andersson (1):
      soc: qcom: Fix QCOM_APR dependencies

Christophe JAILLET (1):
      firmware: tegra: Fix a typo in Kconfig

Colin Ian King (1):
      soc: fsl: dpio: fix dereference of pointer p before null check

Daniel Baluta (1):
      firmware: imx: scu-pd: Add missing audio PD ranges

Dmitry Osipenko (3):
      memory: tegra: Correct debugfs clk rate-range on Tegra20
      memory: tegra: Correct debugfs clk rate-range on Tegra30
      memory: tegra: Correct debugfs clk rate-range on Tegra124

Geert Uytterhoeven (1):
      soc: renesas: Remove ARCH_R8A7795

Gustavo A. R. Silva (4):
      firmware: arm_scmi: Replace zero-length array with flexible-array member
      firmware: arm_scmi/perf: Replace zero-length array with
flexible-array member
      firmware: arm_scpi: Replace zero-length array with flexible-array member
      misc: vexpress: Replace zero-length array with flexible-array member

Jens Wiklander (5):
      tee: remove linked list of struct tee_shm
      tee: remove unused tee_shm_priv_alloc()
      tee: don't assign shm id for private shms
      tee: remove redundant teedev in struct tee_shm
      tee: tee_shm_op_mmap(): use TEE_SHM_USER_MAPPED

Jianxin Pan (5):
      firmware: meson_sm: Add secure power domain support
      dt-bindings: power: add Amlogic secure power domains bindings
      soc: amlogic: Add support for Secure power domains controller
      soc: amlogic: fix compile failure with MESON_SECURE_PM_DOMAINS & !MESON_SM
      dt-bindings: power: Fix dt_binding_check error

Joakim Zhang (1):
      firmware: imx: scu-pd: add power domain for I2C and INTMUX in CM40 SS

John Garry (1):
      bus: hisi_lpc: Fixup IO ports addresses to avoid use-after-free
in host removal

Leonard Crestez (2):
      soc: imx: gpcv2: include linux/sizes.h
      firmware: imx: Remove IMX_SC_RPC_SVC_ABORT

Li Yang (7):
      soc: fsl: qe: fix sparse warnings for qe.c
      soc: fsl: qe: fix sparse warning for qe_common.c
      soc: fsl: qe: fix sparse warnings for ucc.c
      soc: fsl: qe: fix sparse warnings for qe_ic.c
      soc: fsl: qe: fix sparse warnings for ucc_fast.c
      soc: fsl: qe: ucc_slow: remove 0 assignment for kzalloc'ed structure
      soc: fsl: qe: fix sparse warnings for ucc_slow.c

Lucas Stach (1):
      soc: imx: gpc: fix power up sequencing

Manivannan Sadhasivam (1):
      soc: qcom: Do not depend on ARCH_QCOM for QMI helpers

Maulik Shah (2):
      drivers: qcom: rpmh: fix macro to accept NULL argument
      drivers: qcom: rpmh: remove rpmh_flush export

Nathan Chancellor (1):
      soc: qcom: pdr: Avoid uninitialized use of found in pdr_indication_cb

Nishad Kamdar (1):
      soc: renesas: rcar-sysc: Use the correct style for SPDX License Identifier

Peng Fan (2):
      soc: imx: increase build coverage for imx8m soc driver
      soc: imx: drop COMPILE_TEST for IMX_SCU_SOC

Roger Quadros (1):
      dt-bindings: bus: ti-sysc: Add support for PRUSS SYSC type

Sebastien Fagard (1):
      firmware: imx: scu-pd: enlarge PD range for mu_b

Sibi Sankar (3):
      soc: qcom: Introduce Protection Domain Restart helpers
      dt-bindings: soc: qcom: apr: Add protection domain bindings
      soc: qcom: apr: Add avs/audio tracking functionality

Stephen Boyd (2):
      drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
      soc: qcom: socinfo: Use seq_putc() if possible

Suman Anna (1):
      bus: ti-sysc: Add support for PRUSS SYSC type

Tony Lindgren (13):
      drm/omap: Prepare DSS for probing without legacy platform data
      bus: ti-sysc: Rename clk related quirks to pre_reset and post_reset quirks
      bus: ti-sysc: Improve reset to work with modules with no sysconfig
      bus: ti-sysc: Consider non-existing registers too when matching quirks
      bus: ti-sysc: Don't warn about legacy property for nested ti-sysc devices
      bus: ti-sysc: Implement SoC revision handling
      bus: ti-sysc: Handle module unlock quirk needed for some RTC
      bus: ti-sysc: Detect display subsystem related devices
      bus: ti-sysc: Implement display subsystem reset quirk
      Merge branch 'omap-for-v5.7/dss-probe' into omap-for-v5.7/ti-sysc
      bus: ti-sysc: Fix wrong offset for display subsystem reset quirk
      bus: ti-sysc: Detect EDMA and set quirk flags for tptc
      Merge branch 'fix-lcdc-quirk' into omap-for-v5.7/ti-sysc

Viresh Kumar (3):
      firmware: arm_scmi: Update doc style comments
      firmware: arm_scmi: Move macros and helpers to common.h
      firmware: arm_scmi: Make scmi core independent of the transport type

Youri Querry (3):
      soc: fsl: dpio: Adding QMAN multiple enqueue interface
      soc: fsl: dpio: QMAN performance improvement with function
pointer indirection
      soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue


 Documentation/devicetree/bindings/bus/ti-sysc.txt  |   1 +
 .../devicetree/bindings/firmware/qcom,scm.txt      |   1 +
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  40 ++
 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |  50 ++
 arch/arm/mach-omap2/pdata-quirks.c                 |   6 +
 drivers/bus/hisi_lpc.c                             |  27 +-
 drivers/bus/ti-sysc.c                              | 607 +++++++++++++---
 drivers/firmware/arm_scmi/Makefile                 |   3 +-
 drivers/firmware/arm_scmi/common.h                 | 115 ++-
 drivers/firmware/arm_scmi/driver.c                 | 293 +-------
 drivers/firmware/arm_scmi/mailbox.c                | 184 +++++
 drivers/firmware/arm_scmi/perf.c                   |   2 +-
 drivers/firmware/arm_scmi/shmem.c                  |  83 +++
 drivers/firmware/arm_scpi.c                        |   4 +-
 drivers/firmware/imx/Kconfig                       |   2 +-
 drivers/firmware/imx/scu-pd.c                      |  13 +-
 drivers/firmware/meson/meson_sm.c                  |   2 +
 drivers/firmware/tegra/Kconfig                     |   2 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |  25 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |  25 +-
 drivers/memory/tegra/tegra124-emc.c                |   5 +
 drivers/memory/tegra/tegra20-emc.c                 |   5 +
 drivers/memory/tegra/tegra30-emc.c                 |   5 +
 drivers/misc/vexpress-syscfg.c                     |   2 +-
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/amlogic/Kconfig                        |  13 +
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-secure-pwrc.c            | 204 ++++++
 drivers/soc/fsl/dpio/dpio-service.c                |  69 +-
 drivers/soc/fsl/dpio/qbman-portal.c                | 767 ++++++++++++++++++---
 drivers/soc/fsl/dpio/qbman-portal.h                | 158 ++++-
 drivers/soc/fsl/qe/qe.c                            |   4 +-
 drivers/soc/fsl/qe/qe_common.c                     |   2 +-
 drivers/soc/fsl/qe/qe_ic.c                         |   2 +-
 drivers/soc/fsl/qe/ucc.c                           |   2 +-
 drivers/soc/fsl/qe/ucc_slow.c                      |  33 +-
 drivers/soc/imx/Kconfig                            |  11 +-
 drivers/soc/imx/Makefile                           |   2 +-
 drivers/soc/imx/gpc.c                              |  24 +-
 drivers/soc/imx/gpcv2.c                            |   1 +
 drivers/soc/imx/{soc-imx8.c => soc-imx8m.c}        |   0
 drivers/soc/qcom/Kconfig                           |   7 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/apr.c                             | 123 +++-
 drivers/soc/qcom/pdr_interface.c                   | 757 ++++++++++++++++++++
 drivers/soc/qcom/pdr_internal.h                    | 379 ++++++++++
 drivers/soc/qcom/qcom_aoss.c                       |   6 +-
 drivers/soc/qcom/rpmh-internal.h                   |   1 +
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +-
 drivers/soc/qcom/rpmh.c                            |  22 +-
 drivers/soc/qcom/socinfo.c                         |   2 +-
 drivers/soc/renesas/Kconfig                        |  16 +-
 drivers/soc/renesas/rcar-sysc.h                    |   4 +-
 drivers/soc/renesas/renesas-soc.c                  |   2 +-
 drivers/tee/tee_core.c                             |   1 -
 drivers/tee/tee_private.h                          |   3 +-
 drivers/tee/tee_shm.c                              |  85 +--
 include/dt-bindings/bus/ti-sysc.h                  |   4 +
 include/dt-bindings/power/meson-a1-power.h         |  32 +
 include/linux/firmware/imx/ipc.h                   |   1 -
 include/linux/firmware/meson/meson_sm.h            |   2 +
 include/linux/platform_data/ti-sysc.h              |   5 +
 include/linux/soc/qcom/apr.h                       |   1 +
 include/linux/soc/qcom/pdr.h                       |  29 +
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/tee_drv.h                            |  19 +-
 include/soc/fsl/dpaa2-io.h                         |   6 +-
 include/soc/fsl/qe/ucc_fast.h                      |   6 +-
 include/soc/fsl/qe/ucc_slow.h                      |  13 +-
 include/soc/qcom/rpmh.h                            |   5 -
 70 files changed, 3696 insertions(+), 636 deletions(-)
