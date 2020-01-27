Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E43214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hEbTLg4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgA0SSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:18:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgA0SSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dFtMBY12zC0SyDGACZJh8ph9v1E6gqRBVsm/DeMk0C4=; b=hEbTLg4dMathzjxYHgPNNnPieZ
        5zGnirzf2oPEPICiqU2eSjBPO65pMx/kuNdmKQnrNvVEaCOqNBSmvfkSE5p8EvVJvOXTzw9E5ZfUa
        reQPo9gywZaYm73a3htchCe99L2LZUxIAJUaWSsoM60NujKj2fSkh/hYb+V/dC04gy+lIAqo3kIpO
        6ePwTHfKGQ2zlgDCAXVRGzAMyRn7PIWztOtltaFO2tJILSt2JxSv/3zphmMgunvXVyti1dT1af24F
        MljElVlwB1fW0F3Ss1gfwXC3zkR9I4pyvUzbPg62k7qAdgLmm6YYa2NwLKUUe42jD/Mnwz7h8I5Px
        JU4N+3Tw==;
Received: from [2001:4bb8:18c:3335:9dfd:2c3b:6769:45dc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iw8xx-0001As-RS; Mon, 27 Jan 2020 18:18:30 +0000
Date:   Mon, 27 Jan 2020 19:18:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] ioremap changes for 5.6
Message-ID: <20200127181827.GA929837@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this pull requests removes the ioremap_nocache API (plus wrappers)
that are always identical to ioremap.  As of 5.5 final there are
no conflicts, but there are lots of subsystem trees that move or
change code using ioremap in linux-next.  In all these cases you
want to take the version from that other tree and do a manual
s/ioremap_nocache/ioremap/ on the result.


The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/ioremap.git tags/ioremap-5.6

for you to fetch changes up to 4bdc0d676a643140bdf17dbf7eafedee3d496a3c:

  remove ioremap_nocache and devm_ioremap_nocache (2020-01-06 09:45:59 +0100)

----------------------------------------------------------------
ioremap changes for 5.6

 - remove ioremap_nocache given that is is equivalent to
   ioremap everywhere

----------------------------------------------------------------
Christoph Hellwig (2):
      MIPS: define ioremap_nocache to ioremap
      remove ioremap_nocache and devm_ioremap_nocache

 Documentation/driver-api/driver-model/devres.rst   |  1 -
 .../sound/kernel-api/writing-an-alsa-driver.rst    |  2 +-
 Documentation/x86/pat.rst                          |  2 --
 arch/alpha/include/asm/io.h                        | 10 ++-------
 arch/arm/include/asm/io.h                          |  8 --------
 arch/arm/mach-bcm/platsmp.c                        |  4 ++--
 arch/arm/mach-davinci/devices.c                    |  2 +-
 arch/arm/mach-pxa/magician.c                       |  2 +-
 arch/arm/mach-shmobile/platsmp-apmu.c              |  2 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  8 ++++----
 arch/arm/mach-shmobile/setup-r8a7778.c             |  2 +-
 arch/hexagon/include/asm/io.h                      |  1 -
 arch/ia64/include/asm/vga.h                        |  2 +-
 arch/ia64/kernel/cyclone.c                         |  8 ++++----
 arch/m68k/include/asm/kmap.h                       |  1 -
 arch/mips/ar7/clock.c                              |  8 ++++----
 arch/mips/ar7/gpio.c                               |  2 +-
 arch/mips/ar7/platform.c                           |  2 +-
 arch/mips/ath25/ar2315.c                           |  4 ++--
 arch/mips/ath25/ar5312.c                           |  6 +++---
 arch/mips/ath25/board.c                            |  2 +-
 arch/mips/ath79/common.c                           |  2 +-
 arch/mips/ath79/setup.c                            |  4 ++--
 arch/mips/cavium-octeon/setup.c                    |  2 +-
 arch/mips/generic/board-ocelot.c                   |  2 +-
 arch/mips/include/asm/io.h                         | 24 +---------------------
 arch/mips/kernel/mips-cm.c                         |  4 ++--
 arch/mips/kernel/mips-cpc.c                        |  2 +-
 arch/mips/lantiq/falcon/sysctrl.c                  |  6 +++---
 arch/mips/lantiq/irq.c                             |  4 ++--
 arch/mips/lantiq/xway/sysctrl.c                    |  6 +++---
 arch/mips/loongson2ef/common/reset.c               |  4 ++--
 arch/mips/loongson32/common/prom.c                 |  8 ++++----
 arch/mips/loongson32/common/reset.c                |  2 +-
 arch/mips/loongson32/common/time.c                 |  2 +-
 arch/mips/loongson64/reset.c                       |  2 +-
 arch/mips/mti-malta/malta-dtshim.c                 |  2 +-
 arch/mips/pci/pci-alchemy.c                        |  2 +-
 arch/mips/pci/pci-ar2315.c                         |  2 +-
 arch/mips/pci/pci-bcm63xx.c                        |  2 +-
 arch/mips/pci/pci-rt2880.c                         |  2 +-
 arch/mips/pic32/pic32mzda/early_console.c          |  2 +-
 arch/mips/pic32/pic32mzda/early_pin.c              |  4 ++--
 arch/mips/pmcs-msp71xx/msp_serial.c                |  4 ++--
 arch/mips/ralink/irq.c                             |  2 +-
 arch/mips/ralink/of.c                              |  2 +-
 arch/mips/rb532/devices.c                          |  2 +-
 arch/mips/rb532/gpio.c                             |  2 +-
 arch/mips/rb532/prom.c                             |  2 +-
 arch/mips/rb532/setup.c                            |  2 +-
 arch/mips/sni/rm200.c                              |  4 ++--
 arch/parisc/include/asm/io.h                       |  5 ++---
 arch/parisc/kernel/perf.c                          |  2 +-
 arch/powerpc/include/asm/io.h                      |  3 ---
 arch/sh/boards/board-sh7785lcr.c                   |  2 +-
 arch/sh/boards/mach-cayman/irq.c                   |  2 +-
 arch/sh/boards/mach-cayman/setup.c                 |  2 +-
 arch/sh/boards/mach-sdk7786/fpga.c                 |  2 +-
 arch/sh/drivers/heartbeat.c                        |  2 +-
 arch/sh/drivers/pci/pci-sh5.c                      |  4 ++--
 arch/sh/include/asm/io.h                           |  1 -
 arch/sh/kernel/cpu/irq/intc-sh5.c                  |  2 +-
 arch/sh/kernel/cpu/sh2/smp-j2.c                    |  4 ++--
 arch/sh/kernel/cpu/sh5/clock-sh5.c                 |  2 +-
 arch/sh/kernel/dma-coherent.c                      |  2 +-
 arch/sparc/include/asm/io_64.h                     |  1 -
 arch/unicore32/include/asm/io.h                    |  1 -
 arch/x86/kernel/apb_timer.c                        |  2 +-
 arch/x86/kernel/hpet.c                             |  2 +-
 arch/x86/kernel/quirks.c                           |  2 +-
 arch/x86/kernel/tboot.c                            |  2 +-
 arch/x86/mm/testmmiotrace.c                        |  4 ++--
 arch/x86/pci/mmconfig_64.c                         |  2 +-
 drivers/acpi/acpi_lpit.c                           |  2 +-
 drivers/ata/pata_arasan_cf.c                       |  2 +-
 drivers/ata/pata_octeon_cf.c                       |  6 +++---
 drivers/ata/pata_rb532_cf.c                        |  2 +-
 drivers/atm/eni.c                                  |  8 +-------
 drivers/bcma/driver_chipcommon_b.c                 |  2 +-
 drivers/bcma/driver_pci_host.c                     |  6 +++---
 drivers/bcma/host_soc.c                            |  2 +-
 drivers/bcma/scan.c                                |  6 +++---
 drivers/block/umem.c                               |  2 +-
 drivers/bus/fsl-mc/mc-io.c                         |  4 ++--
 drivers/char/agp/generic.c                         |  2 +-
 drivers/char/agp/intel-gtt.c                       |  2 +-
 drivers/char/applicom.c                            |  4 ++--
 drivers/char/hw_random/intel-rng.c                 |  2 +-
 drivers/char/hw_random/octeon-rng.c                |  4 ++--
 drivers/clk/renesas/clk-rz.c                       |  4 ++--
 drivers/clocksource/sh_cmt.c                       |  2 +-
 drivers/clocksource/sh_mtu2.c                      |  2 +-
 drivers/clocksource/sh_tmu.c                       |  2 +-
 drivers/cpufreq/pcc-cpufreq.c                      |  2 +-
 drivers/crypto/hifn_795x.c                         |  2 +-
 drivers/dma/altera-msgdma.c                        |  4 ++--
 drivers/edac/i3000_edac.c                          |  2 +-
 drivers/edac/i3200_edac.c                          |  2 +-
 drivers/edac/i82975x_edac.c                        |  2 +-
 drivers/edac/ie31200_edac.c                        |  2 +-
 drivers/edac/x38_edac.c                            |  2 +-
 drivers/firewire/nosy.c                            |  2 +-
 drivers/firmware/broadcom/bcm47xx_nvram.c          |  2 +-
 drivers/gpu/drm/gma500/gtt.c                       |  2 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  4 ++--
 drivers/gpu/drm/sti/sti_hdmi.c                     |  2 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |  2 +-
 drivers/gpu/drm/sti/sti_vtg.c                      |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  2 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |  4 ++--
 drivers/hwmon/i5k_amb.c                            |  2 +-
 drivers/i2c/busses/i2c-highlander.c                |  2 +-
 drivers/i2c/busses/i2c-pmcmsp.c                    |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  4 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  2 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |  4 ++--
 drivers/infiniband/hw/qib/qib_iba7322.c            |  2 +-
 drivers/infiniband/hw/qib/qib_init.c               |  4 ++--
 drivers/infiniband/hw/qib/qib_pcie.c               |  2 +-
 drivers/input/keyboard/pxa930_rotary.c             |  2 +-
 drivers/input/keyboard/sh_keysc.c                  |  2 +-
 drivers/input/mouse/pxa930_trkball.c               |  2 +-
 drivers/input/serio/gscps2.c                       |  2 +-
 drivers/iommu/amd_iommu_init.c                     |  2 +-
 drivers/ipack/carriers/tpci200.c                   |  4 ++--
 drivers/ipack/devices/ipoctal.c                    |  6 +++---
 drivers/irqchip/irq-mips-gic.c                     |  2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  2 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |  2 +-
 drivers/media/pci/cx18/cx18-driver.c               |  2 +-
 drivers/media/pci/ivtv/ivtv-driver.c               |  6 +++---
 drivers/media/platform/davinci/dm355_ccdc.c        |  2 +-
 drivers/media/platform/davinci/dm644x_ccdc.c       |  2 +-
 drivers/media/platform/davinci/isif.c              |  2 +-
 drivers/media/platform/tegra-cec/tegra_cec.c       |  2 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |  2 +-
 drivers/misc/mic/scif/scif_nodeqp.c                |  2 +-
 drivers/misc/pti.c                                 |  2 +-
 drivers/mmc/host/sdhci-acpi.c                      |  2 +-
 drivers/mmc/host/via-sdmmc.c                       |  2 +-
 drivers/mtd/devices/bcm47xxsflash.c                |  2 +-
 drivers/mtd/maps/amd76xrom.c                       |  2 +-
 drivers/mtd/maps/ck804xrom.c                       |  2 +-
 drivers/mtd/maps/esb2rom.c                         |  2 +-
 drivers/mtd/maps/ichxrom.c                         |  2 +-
 drivers/mtd/maps/intel_vr_nor.c                    |  4 ++--
 drivers/mtd/maps/l440gx.c                          |  2 +-
 drivers/mtd/maps/netsc520.c                        |  4 ++--
 drivers/mtd/maps/nettel.c                          |  8 ++++----
 drivers/mtd/maps/pci.c                             |  4 ++--
 drivers/mtd/maps/sc520cdp.c                        |  8 ++++----
 drivers/mtd/maps/scb2_flash.c                      |  2 +-
 drivers/mtd/maps/ts5500_flash.c                    |  4 ++--
 drivers/mtd/nand/raw/au1550nd.c                    |  2 +-
 drivers/mtd/nand/raw/denali_pci.c                  |  6 +++---
 drivers/mtd/nand/raw/fsl_upm.c                     |  2 +-
 drivers/net/can/at91_can.c                         |  2 +-
 drivers/net/can/cc770/cc770_isa.c                  |  2 +-
 drivers/net/can/sja1000/sja1000_isa.c              |  2 +-
 drivers/net/can/sja1000/sja1000_platform.c         |  2 +-
 drivers/net/can/softing/softing_main.c             |  2 +-
 drivers/net/ethernet/alacritech/slicoss.c          |  2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |  4 ++--
 drivers/net/ethernet/amd/au1000_eth.c              |  6 +++---
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |  2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |  3 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  2 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |  2 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  2 +-
 drivers/net/ethernet/dec/tulip/de2104x.c           |  2 +-
 drivers/net/ethernet/ethoc.c                       |  4 ++--
 drivers/net/ethernet/i825xx/sni_82596.c            |  6 +++---
 drivers/net/ethernet/korina.c                      |  6 +++---
 drivers/net/ethernet/lantiq_etop.c                 |  2 +-
 drivers/net/ethernet/marvell/skge.c                |  2 +-
 drivers/net/ethernet/marvell/sky2.c                |  2 +-
 drivers/net/ethernet/natsemi/ns83820.c             |  2 +-
 .../net/ethernet/netronome/nfp/nfp_netvf_main.c    |  8 ++++----
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |  6 +++---
 drivers/net/ethernet/sfc/ef10.c                    |  2 +-
 drivers/net/ethernet/sfc/efx.c                     |  2 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |  2 +-
 drivers/net/ethernet/smsc/smsc911x.c               |  2 +-
 drivers/net/ethernet/ti/netcp_core.c               |  2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  4 ++--
 drivers/net/fddi/defxx.c                           |  2 +-
 drivers/net/fddi/defza.c                           |  2 +-
 drivers/net/fjes/fjes_hw.c                         |  2 +-
 drivers/net/wan/wanxl.c                            |  4 ++--
 drivers/net/wireless/ath/ath10k/ahb.c              |  4 ++--
 drivers/net/wireless/ath/ath5k/ahb.c               |  2 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |  2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  4 ++--
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |  2 +-
 drivers/opp/ti-opp-supply.c                        |  2 +-
 drivers/parisc/ccio-dma.c                          |  2 +-
 drivers/parisc/dino.c                              |  2 +-
 drivers/parisc/eisa.c                              |  4 ++--
 drivers/parisc/iosapic.c                           |  2 +-
 drivers/parisc/lba_pci.c                           |  8 ++++----
 drivers/parisc/sba_iommu.c                         |  4 ++--
 drivers/pci/controller/dwc/pci-dra7xx.c            |  2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  2 +-
 drivers/pci/msi.c                                  |  2 +-
 drivers/pci/pci.c                                  |  2 +-
 drivers/pci/quirks.c                               |  4 ++--
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c              |  2 +-
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c              |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |  2 +-
 drivers/pinctrl/pinctrl-amd.c                      |  2 +-
 drivers/platform/x86/intel_scu_ipc.c               |  2 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  4 ++--
 drivers/platform/x86/pmc_atom.c                    |  2 +-
 drivers/platform/x86/samsung-laptop.c              |  4 ++--
 drivers/regulator/ti-abb-regulator.c               |  4 ++--
 drivers/rtc/rtc-sh.c                               |  2 +-
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c             |  2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c             |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |  2 +-
 drivers/scsi/be2iscsi/be_main.c                    |  6 +++---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  4 ++--
 drivers/scsi/csiostor/csio_init.c                  |  2 +-
 drivers/scsi/hpsa.c                                |  2 +-
 drivers/scsi/lasi700.c                             |  2 +-
 drivers/scsi/megaraid/megaraid_mbox.c              |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  2 +-
 drivers/scsi/myrb.c                                |  2 +-
 drivers/scsi/myrs.c                                |  2 +-
 drivers/scsi/pcmcia/nsp_cs.c                       |  2 +-
 drivers/scsi/qla2xxx/qla_mr.c                      |  4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c              |  2 +-
 drivers/scsi/sni_53c710.c                          |  2 +-
 drivers/scsi/sun3x_esp.c                           |  4 ++--
 drivers/scsi/zalon.c                               |  2 +-
 drivers/scsi/zorro_esp.c                           |  6 +++---
 drivers/sh/clk/core.c                              |  2 +-
 drivers/sh/intc/core.c                             |  2 +-
 drivers/sh/intc/userimask.c                        |  2 +-
 drivers/soc/tegra/flowctrl.c                       |  2 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |  2 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |  4 ++--
 drivers/soc/tegra/pmc.c                            |  4 ++--
 drivers/soc/xilinx/xlnx_vcu.c                      |  4 ++--
 drivers/spi/spi-dw-mid.c                           |  2 +-
 drivers/spi/spi-jcore.c                            |  2 +-
 drivers/spi/spi-npcm-fiu.c                         |  2 +-
 drivers/ssb/driver_extif.c                         |  2 +-
 drivers/ssb/driver_pcicore.c                       |  6 +++---
 drivers/staging/gasket/gasket_core.c               |  2 +-
 drivers/staging/kpc2000/kpc2000/core.c             |  4 ++--
 drivers/staging/kpc2000/kpc2000_i2c.c              |  2 +-
 drivers/staging/kpc2000/kpc2000_spi.c              |  2 +-
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c   |  2 +-
 drivers/staging/media/allegro-dvt/allegro-core.c   |  4 ++--
 drivers/staging/qlge/qlge_main.c                   |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  2 +-
 drivers/staging/rts5208/rtsx.c                     |  2 +-
 drivers/staging/sm750fb/sm750_hw.c                 |  2 +-
 drivers/staging/uwb/whc-rc.c                       |  6 +++---
 drivers/tc/tc.c                                    |  2 +-
 drivers/tty/cyclades.c                             | 10 ++++-----
 drivers/tty/mips_ejtag_fdc.c                       |  2 +-
 drivers/tty/moxa.c                                 |  4 ++--
 drivers/tty/serial/8250/8250_gsc.c                 |  2 +-
 drivers/tty/serial/8250/8250_omap.c                |  2 +-
 drivers/tty/serial/8250/8250_pci.c                 |  6 +++---
 drivers/tty/serial/8250/8250_port.c                |  2 +-
 drivers/tty/serial/dz.c                            |  2 +-
 drivers/tty/serial/lantiq.c                        |  2 +-
 drivers/tty/serial/meson_uart.c                    |  2 +-
 drivers/tty/serial/mux.c                           |  2 +-
 drivers/tty/serial/owl-uart.c                      |  2 +-
 drivers/tty/serial/pic32_uart.c                    |  2 +-
 drivers/tty/serial/rda-uart.c                      |  2 +-
 drivers/tty/serial/sb1250-duart.c                  |  4 ++--
 drivers/tty/serial/sh-sci.c                        |  2 +-
 drivers/tty/serial/zs.c                            |  2 +-
 drivers/tty/synclink.c                             |  4 ++--
 drivers/tty/synclink_gt.c                          |  2 +-
 drivers/tty/synclinkmp.c                           |  8 ++++----
 drivers/usb/core/hcd-pci.c                         |  2 +-
 drivers/usb/early/xhci-dbc.c                       |  2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |  2 +-
 drivers/usb/gadget/udc/goku_udc.c                  |  2 +-
 drivers/usb/gadget/udc/net2272.c                   |  6 +++---
 drivers/usb/gadget/udc/net2280.c                   |  2 +-
 drivers/usb/host/ehci-pmcmsp.c                     |  6 +++---
 drivers/usb/host/pci-quirks.c                      |  2 +-
 drivers/usb/isp1760/isp1760-if.c                   |  4 ++--
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |  2 +-
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |  4 ++--
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  |  2 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |  2 +-
 drivers/vfio/platform/vfio_platform_common.c       |  4 ++--
 drivers/video/fbdev/carminefb.c                    |  4 ++--
 drivers/video/fbdev/i810/i810_main.c               |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |  2 +-
 drivers/video/fbdev/kyro/fbdev.c                   |  2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |  2 +-
 drivers/video/fbdev/mbx/mbxfb.c                    |  4 ++--
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |  2 +-
 drivers/video/fbdev/pm2fb.c                        |  2 +-
 drivers/video/fbdev/pm3fb.c                        |  4 ++--
 drivers/video/fbdev/pmag-aa-fb.c                   |  4 ++--
 drivers/video/fbdev/pmag-ba-fb.c                   |  4 ++--
 drivers/video/fbdev/pmagb-b-fb.c                   |  4 ++--
 drivers/video/fbdev/pvr2fb.c                       |  4 ++--
 drivers/video/fbdev/pxa168fb.c                     |  2 +-
 drivers/video/fbdev/s1d13xxxfb.c                   |  4 ++--
 drivers/video/fbdev/sh7760fb.c                     |  2 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |  2 +-
 drivers/video/fbdev/sstfb.c                        |  4 ++--
 drivers/video/fbdev/stifb.c                        |  4 ++--
 drivers/video/fbdev/tdfxfb.c                       |  2 +-
 drivers/video/fbdev/tgafb.c                        |  2 +-
 drivers/video/fbdev/tridentfb.c                    |  4 ++--
 drivers/video/fbdev/valkyriefb.c                   |  2 +-
 drivers/video/fbdev/vermilion/cr_pll.c             |  2 +-
 drivers/video/fbdev/vermilion/vermilion.c          |  4 ++--
 drivers/video/fbdev/via/via-core.c                 |  2 +-
 drivers/video/fbdev/w100fb.c                       |  6 +++---
 drivers/vme/boards/vme_vmivme7805.c                |  2 +-
 drivers/vme/bridges/vme_ca91cx42.c                 |  4 ++--
 drivers/vme/bridges/vme_tsi148.c                   |  4 ++--
 drivers/w1/masters/matrox_w1.c                     |  2 +-
 drivers/watchdog/bcm63xx_wdt.c                     |  2 +-
 drivers/watchdog/intel_scu_watchdog.c              |  2 +-
 drivers/watchdog/rc32434_wdt.c                     |  4 ++--
 include/asm-generic/io.h                           |  4 ----
 include/asm-generic/iomap.h                        |  4 ++--
 include/linux/io.h                                 |  6 ++----
 lib/devres.c                                       | 20 ------------------
 scripts/coccinelle/free/devm_free.cocci            |  4 ----
 scripts/coccinelle/free/iounmap.cocci              |  2 +-
 sound/drivers/ml403-ac97cr.c                       |  2 +-
 sound/isa/msnd/msnd_pinnacle.c                     |  2 +-
 sound/parisc/harmony.c                             |  2 +-
 sound/pci/aw2/aw2-alsa.c                           |  2 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |  2 +-
 sound/pci/echoaudio/echoaudio.c                    |  2 +-
 sound/pci/nm256/nm256.c                            |  6 +++---
 sound/pci/rme32.c                                  |  2 +-
 sound/pci/rme96.c                                  |  2 +-
 sound/pci/rme9652/hdsp.c                           |  2 +-
 sound/pci/rme9652/hdspm.c                          |  2 +-
 sound/pci/rme9652/rme9652.c                        |  2 +-
 sound/pci/sis7019.c                                |  2 +-
 sound/pci/ymfpci/ymfpci_main.c                     |  2 +-
 sound/soc/au1x/ac97c.c                             |  2 +-
 sound/soc/au1x/i2sc.c                              |  2 +-
 sound/soc/intel/atom/sst/sst_acpi.c                | 10 ++++-----
 sound/soc/sh/fsi.c                                 |  2 +-
 sound/x86/intel_hdmi_audio.c                       |  2 +-
 tools/testing/nvdimm/Kbuild                        |  3 +--
 tools/testing/nvdimm/test/iomap.c                  | 12 +++--------
 tools/testing/nvdimm/test/nfit_test.h              |  2 --
 368 files changed, 509 insertions(+), 603 deletions(-)
