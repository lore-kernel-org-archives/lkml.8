Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5214420724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgHTR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:28:59 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:52202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730609AbgHTR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:28:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6709B837F27E;
        Thu, 20 Aug 2020 17:28:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch76_130f73727032
X-Filterd-Recvd-Size: 18997
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 17:28:47 +0000 (UTC)
Message-ID: <a3bd371fd0697d87ca099f212f0ec5c205e6b930.camel@perches.com>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>, Xu Wang <vulab@iscas.ac.cn>
Date:   Thu, 20 Aug 2020 10:28:46 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
          <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
          <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
          <alpine.DEB.2.22.394.2008201021400.2524@hadrien>
         <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com>
         <alpine.DEB.2.22.394.2008201856110.2524@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 19:03 +0200, Julia Lawall wrote:
> > > I have a bunch of variations of this that are more complicated than I
> > > would have expected.  One shorter variant that I have is:
> > > 
> > > @@
> > > expression e1,e2;
> > > statement S;
> > > @@
> > > 
> > >  S
> > >  e1
> > > -,
> > > +;
> > >   (<+... e2 ...+>);
> > > 
> > > This will miss cases where the first statement is the comma thing.  But I
> > > think it is possible to improve this now.  I will check.
> > 
> > Hi Julia.
> > 
> > Right, thanks, this adds a dependency on a statement
> > before the expression.  Any stragglers would be easily
> > found using slightly different form.
> > There are not very many of these in linux kernel.
> > 
> > Another nicety would be to allow the s/,/;/ conversion to
> > find both b and c in this sequence:
> > 	a = 1;
> > 	b = 2,
> > 	c = 3,
> > 	d = 4;
> > without running the script multiple times.
> > There are many dozen uses of this style in linux kernel.
> > 
> > I tried variants of adding a comma after the e2 expression,
> > but cocci seems to have parsing problems with:
> > 
> > @@
> > expression e1;
> > expression e2;
> > @@
> > 	e1
> > -	,
> > +	;
> > 	e2,
> 
> This doesn't work because it's not a valid expression.
> 
> The problem is solved by doing:
> 
>   e1
> - ,
> + ;
>   e2
>   ... when any
> 
> But that doesn't work in the current version of Coccinelle.  I have fixed
> the problem, though and it will work shortly.

Great, thanks.

> > I do appreciate that coccinelle adds braces for multiple
> > expression comma use after an if.
> > 
> > i.e.:
> > 	if (foo)
> > 		a = 1, b = 2;
> > becomes
> > 	if (foo) {
> > 		a = 1; b = 2;
> > 	}
> 
> I wasn't sure what was wanted for such things.  Should b = 2 now be on a
> separate line?

Ideally for linux kernel style, yes.

> I took the strategy of avoiding the problem and leaving those cases as is.
> That also solves the LIST_HEAD problem.  But if it is wanted to change
> these commas under ifs, then that is probably possible too.

I would probably just do those by hand, I believe
there are only a few dozen and they are easily found
using the original script.

> My current complete solution is as follows.  The first rule avoids changing
> commas in macros, where thebody of the macro is just an expression.  The
> second rule uses position variables to ensure that the two expression are
> on different lines.
> 
> @r@
> expression e1,e2;
> statement S;
> position p;
> @@
> 
> e1 ,@S@p e2;
> 
> @@
> expression e1,e2;
> position p1;
> position p2 :
>     script:ocaml(p1) { not((List.hd p1).line_end = (List.hd p2).line) };
> statement S;
> position r.p;
> @@
> 
> e1@p1
> -,@S@p
> +;
> e2@p2
> ... when any
> 
> The generated patch is below.

(150kb patch removed)

There sure are a bunch of these...

This output patch is very difficult to read as it's unordered.
Perhaps it'd be simpler using --in-place and git diff --stat -p

Thanks again,  Joe

btw: the ordered diffstat for Julia's removed patch is:

$ git diff --stat
 arch/alpha/kernel/process.c                        |  2 +-
 arch/arm/mach-davinci/pm.c                         |  2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |  2 +-
 arch/arm/mach-pxa/eseries.c                        |  6 +--
 arch/arm/mach-pxa/palm27x.c                        |  4 +-
 arch/arm/mach-pxa/z2.c                             |  2 +-
 arch/arm/vfp/vfp.h                                 |  2 +-
 arch/ia64/kernel/setup.c                           |  2 +-
 arch/m68k/lib/muldi3.c                             |  2 +-
 arch/mips/bcm63xx/dev-spi.c                        |  4 +-
 arch/mips/kernel/cevt-txx9.c                       |  2 +-
 arch/mips/kernel/vpe-cmp.c                         |  4 +-
 arch/mips/kernel/vpe-mt.c                          |  4 +-
 arch/mips/pci/pci-ar2315.c                         |  6 +--
 arch/openrisc/kernel/time.c                        |  8 ++--
 arch/powerpc/kexec/core.c                          |  2 +-
 arch/powerpc/lib/feature-fixups.c                  |  8 ++--
 arch/sparc/kernel/pci_sun4v.c                      |  2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |  4 +-
 .../platform/intel-mid/device_libs/platform_bt.c   |  4 +-
 block/bsg-lib.c                                    |  2 +-
 drivers/base/regmap/regmap-debugfs.c               |  2 +-
 drivers/bcma/driver_pci_host.c                     |  4 +-
 drivers/char/agp/amd-k7-agp.c                      |  2 +-
 drivers/char/agp/nvidia-agp.c                      |  2 +-
 drivers/char/agp/sworks-agp.c                      |  2 +-
 drivers/char/hw_random/iproc-rng200.c              |  8 ++--
 drivers/char/hw_random/mxc-rnga.c                  |  6 +--
 drivers/char/hw_random/stm32-rng.c                 |  8 ++--
 drivers/char/ipmi/bt-bmc.c                         |  6 +--
 drivers/clk/meson/meson-aoclk.c                    |  2 +-
 drivers/clk/mvebu/ap-cpu-clk.c                     |  2 +-
 drivers/clk/uniphier/clk-uniphier-cpugear.c        |  2 +-
 drivers/clk/uniphier/clk-uniphier-mux.c            |  2 +-
 drivers/clocksource/mps2-timer.c                   |  6 +--
 drivers/clocksource/timer-armada-370-xp.c          |  8 ++--
 drivers/counter/ti-eqep.c                          |  2 +-
 drivers/crypto/amcc/crypto4xx_alg.c                |  2 +-
 drivers/crypto/atmel-tdes.c                        |  2 +-
 drivers/crypto/hifn_795x.c                         |  4 +-
 drivers/crypto/talitos.c                           |  8 ++--
 drivers/edac/ppc4xx_edac.c                         |  2 +-
 drivers/firmware/arm_scmi/base.c                   |  2 +-
 drivers/gpio/gpio-max77620.c                       |  2 +-
 drivers/gpio/gpio-mc33880.c                        |  2 +-
 drivers/gpio/gpio-omap.c                           | 18 ++++-----
 drivers/gpio/gpio-rc5t583.c                        | 20 +++++-----
 drivers/gpio/gpio-rda.c                            | 12 +++---
 drivers/gpio/gpio-sama5d2-piobu.c                  | 18 ++++-----
 drivers/gpio/gpio-tegra186.c                       |  2 +-
 drivers/gpio/gpio-vx855.c                          |  2 +-
 drivers/gpio/gpio-wcove.c                          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |  2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  4 +-
 drivers/gpu/drm/i915/intel_region_lmem.c           |  2 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |  2 +-
 drivers/gpu/drm/imx/parallel-display.c             |  2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.c    |  2 +-
 drivers/gpu/drm/radeon/radeon_sa.c                 |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  2 +-
 drivers/hid/hid-sensor-custom.c                    |  2 +-
 drivers/hwmon/pc87360.c                            |  4 +-
 drivers/i2c/busses/i2c-imx.c                       |  2 +-
 drivers/iio/chemical/pms7003.c                     |  2 +-
 drivers/infiniband/hw/hfi1/qsfp.c                  |  4 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |  2 +-
 drivers/infiniband/sw/siw/siw_main.c               |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |  2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |  2 +-
 drivers/input/input.c                              |  2 +-
 drivers/input/misc/ixp4xx-beeper.c                 |  2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  2 +-
 drivers/input/serio/parkbd.c                       |  2 +-
 drivers/iommu/amd/init.c                           |  4 +-
 drivers/irqchip/irq-renesas-rza1.c                 | 12 +++---
 drivers/leds/leds-ariel.c                          |  6 +--
 drivers/leds/leds-lm3533.c                         |  2 +-
 drivers/leds/leds-lm3642.c                         |  4 +-
 drivers/md/bcache/sysfs.c                          |  2 +-
 drivers/md/raid10.c                                |  2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |  6 +--
 drivers/media/dvb-frontends/rtl2832.c              | 14 +++----
 drivers/media/dvb-frontends/ts2020.c               | 10 ++---
 drivers/media/platform/coda/coda-common.c          |  2 +-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |  2 +-
 .../media/platform/sunxi/sun4i-csi/sun4i_v4l2.c    |  2 +-
 drivers/media/radio/radio-sf16fmr2.c               |  2 +-
 drivers/media/tuners/mt2060.c                      |  2 +-
 drivers/media/usb/au0828/au0828-video.c            |  2 +-
 drivers/media/usb/dvb-usb-v2/dvbsky.c              | 22 +++++------
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |  2 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |  4 +-
 drivers/media/usb/dvb-usb/dib0700_devices.c        |  4 +-
 drivers/media/usb/em28xx/em28xx-audio.c            | 14 +++----
 drivers/media/usb/gspca/ov534.c                    | 12 +++---
 drivers/media/usb/pvrusb2/pvrusb2-devattr.c        |  2 +-
 drivers/mfd/88pm860x-core.c                        | 10 ++---
 drivers/mfd/atmel-flexcom.c                        |  2 +-
 drivers/mfd/rave-sp.c                              |  2 +-
 drivers/mfd/rk808.c                                |  2 +-
 drivers/misc/pci_endpoint_test.c                   |  2 +-
 drivers/mmc/core/core.c                            |  8 ++--
 drivers/mmc/host/sdhci-pci-core.c                  |  2 +-
 drivers/mtd/devices/st_spi_fsm.c                   |  2 +-
 drivers/mtd/maps/pci.c                             |  8 ++--
 drivers/mtd/nand/raw/marvell_nand.c                |  2 +-
 drivers/mtd/nand/raw/mxc_nand.c                    |  2 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |  2 +-
 drivers/net/ethernet/8390/axnet_cs.c               |  2 +-
 drivers/net/ethernet/8390/lib8390.c                |  2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  6 +--
 .../net/ethernet/freescale/fs_enet/mii-bitbang.c   |  2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 12 +++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/chains.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  2 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |  2 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c | 28 ++++++-------
 drivers/net/ethernet/sfc/ptp.c                     |  2 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |  6 +--
 drivers/net/ipa/ipa_qmi.c                          |  2 +-
 drivers/net/thunderbolt.c                          |  2 +-
 drivers/net/usb/cdc-phonet.c                       |  2 +-
 drivers/net/wan/sbni.c                             | 46 +++++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |  6 +--
 .../net/wireless/mediatek/mt76/mt7615/sdio_mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_mcu.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  6 +--
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |  2 +-
 drivers/net/wireless/st/cw1200/txrx.c              |  2 +-
 drivers/nfc/pn533/usb.c                            |  2 +-
 drivers/nvmem/imx-iim.c                            | 10 ++---
 drivers/nvmem/qcom-spmi-sdam.c                     |  2 +-
 drivers/nvmem/snvs_lpgpr.c                         |  2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |  4 +-
 drivers/pinctrl/berlin/berlin-bg4ct.c              |  6 +--
 drivers/pinctrl/berlin/pinctrl-as370.c             |  6 +--
 drivers/pinctrl/intel/pinctrl-baytrail.c           | 12 +++---
 drivers/pinctrl/intel/pinctrl-merrifield.c         |  2 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |  4 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  4 +-
 drivers/pinctrl/pinctrl-at91.c                     |  2 +-
 drivers/pinctrl/pinctrl-digicolor.c                |  8 ++--
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           | 14 +++----
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |  2 +-
 .../x86/intel_speed_select_if/isst_if_common.c     |  6 +--
 drivers/power/supply/ab8500_fg.c                   |  2 +-
 drivers/power/supply/bq24190_charger.c             |  2 +-
 drivers/power/supply/wm831x_power.c                |  2 +-
 drivers/regulator/mc13892-regulator.c              |  4 +-
 drivers/regulator/wm831x-isink.c                   |  8 ++--
 drivers/remoteproc/remoteproc_virtio.c             |  4 +-
 drivers/reset/hisilicon/reset-hi3660.c             |  2 +-
 drivers/reset/reset-lpc18xx.c                      |  4 +-
 drivers/reset/reset-npcm.c                         |  4 +-
 drivers/reset/sti/reset-syscfg.c                   |  2 +-
 drivers/s390/crypto/zcrypt_cex2a.c                 |  2 +-
 drivers/s390/crypto/zcrypt_cex4.c                  |  2 +-
 drivers/s390/crypto/zcrypt_msgtype6.h              |  4 +-
 drivers/scsi/arm/cumana_2.c                        |  8 ++--
 drivers/scsi/arm/eesox.c                           |  4 +-
 drivers/scsi/arm/powertec.c                        |  4 +-
 drivers/scsi/hpsa.c                                |  2 +-
 drivers/scsi/isci/host.c                           |  2 +-
 drivers/scsi/pmcraid.c                             |  2 +-
 drivers/spi/spi-meson-spicc.c                      | 22 +++++------
 drivers/staging/media/hantro/hantro_v4l2.c         |  2 +-
 drivers/staging/media/ipu3/ipu3-css-params.c       |  2 +-
 drivers/staging/media/rkvdec/rkvdec.c              |  2 +-
 drivers/tty/hvc/hvsi_lib.c                         |  2 +-
 drivers/tty/moxa.c                                 |  8 ++--
 drivers/tty/mxser.c                                | 18 ++++-----
 drivers/tty/serial/imx.c                           |  2 +-
 drivers/tty/serial/lantiq.c                        |  2 +-
 drivers/usb/class/cdc-acm.c                        | 12 +++---
 drivers/usb/gadget/udc/net2280.c                   |  4 +-
 drivers/usb/host/isp1362-hcd.c                     |  2 +-
 drivers/usb/phy/phy-isp1301-omap.c                 | 10 ++---
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |  6 +--
 drivers/usb/typec/tcpm/tcpm.c                      | 12 +++---
 drivers/usb/typec/ucsi/psy.c                       |  6 +--
 drivers/video/backlight/sky81452-backlight.c       |  2 +-
 drivers/video/fbdev/imsttfb.c                      |  4 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |  4 +-
 drivers/video/fbdev/s3c2410fb.c                    |  2 +-
 drivers/watchdog/iTCO_wdt.c                        |  4 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |  4 +-
 drivers/watchdog/pm8916_wdt.c                      |  2 +-
 drivers/watchdog/rza_wdt.c                         |  4 +-
 fs/afs/inode.c                                     |  4 +-
 fs/ceph/dir.c                                      |  2 +-
 fs/lockd/host.c                                    |  2 +-
 fs/nfs/nfs42proc.c                                 |  2 +-
 fs/omfs/file.c                                     |  4 +-
 fs/reiserfs/do_balan.c                             |  4 +-
 fs/xfs/libxfs/xfs_attr_remote.c                    |  2 +-
 fs/xfs/libxfs/xfs_btree.c                          |  2 +-
 kernel/audit.c                                     |  2 +-
 kernel/dma/debug.c                                 |  4 +-
 kernel/sched/fair.c                                |  2 +-
 kernel/time/alarmtimer.c                           |  2 +-
 lib/test_rhashtable.c                              |  2 +-
 mm/hugetlb_cgroup.c                                |  4 +-
 net/ipv4/tcp_vegas.c                               |  8 ++--
 net/ipv6/calipso.c                                 |  2 +-
 net/ipv6/route.c                                   |  2 +-
 net/mac80211/debugfs_sta.c                         |  2 +-
 net/rxrpc/recvmsg.c                                |  2 +-
 net/smc/smc_clc.c                                  |  2 +-
 net/tls/tls_main.c                                 |  2 +-
 samples/v4l/v4l2-pci-skeleton.c                    |  4 +-
 sound/firewire/fireworks/fireworks_pcm.c           |  2 +-
 sound/pci/hda/patch_ca0132.c                       |  2 +-
 sound/pci/hda/patch_hdmi.c                         |  2 +-
 sound/soc/codecs/madera.c                          |  4 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |  2 +-
 sound/soc/samsung/snow.c                           |  2 +-
 sound/soc/soc-dapm.c                               |  2 +-
 sound/soc/sof/intel/hda-dsp.c                      |  2 +-
 tools/perf/builtin-diff.c                          |  4 +-
 tools/perf/builtin-inject.c                        |  2 +-
 tools/perf/ui/browsers/annotate.c                  |  2 +-
 tools/perf/ui/tui/util.c                           |  2 +-
 tools/perf/util/annotate.c                         |  2 +-
 tools/perf/util/evsel.c                            |  2 +-
 tools/testing/nvdimm/test/nfit.c                   |  2 +-
 .../testing/selftests/bpf/benchs/bench_ringbufs.c  |  2 +-
 tools/testing/selftests/bpf/test_verifier.c        |  4 +-
 tools/testing/selftests/net/psock_fanout.c         |  6 +--
 tools/testing/selftests/vm/userfaultfd.c           | 12 +++---
 234 files changed, 509 insertions(+), 509 deletions(-)

