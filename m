Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 06:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CCF24840
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 06:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgFUGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 02:38:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:48607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgFUGir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 02:38:47 -0400
IronPort-SDR: qqEF10rSPmjD4tC5sSxzmNRvdOXtNakiiRYKrDtr2SkeGJhnM1/dwwnevbA2aQBr80VBQoJDHH
 p2cyZzb87ypA==
X-IronPort-AV: E=McAfee;i="6000,8403,9658"; a="228188608"
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="228188608"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2020 23:38:43 -0700
IronPort-SDR: uCuLjHDD1MgPAqBupPv+1SubnjhdIgm0wK3HXAhofNN5gIIw2TKUSP4r5AzK+h4jdc2VPrMipt
 QMCg5FOcAePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,262,1589266800"; 
   d="scan'208";a="278437610"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2020 23:38:40 -0700
Date:   Sun, 21 Jun 2020 14:38:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Heinz Mauelshagen <heinzm@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Damien Le Moal <DamienLeMoal@wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [kbuild-all] ERROR: modpost: "__mulsi3" undefined!
Message-ID: <20200621063822.GA11122@intel.com>
References: <202006211342.FwGYiCkt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006211342.FwGYiCkt%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 01:49:44PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b6ddd10d678bebec32381f71b6b420bafc43ad0
> commit: d3c7b35c20d60650bac8b55c17b194adda03a979 dm: add emulated block size target
> date:   5 weeks ago
> config: openrisc-randconfig-r035-20200621 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d3c7b35c20d60650bac8b55c17b194adda03a979
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
Sorry, this is a wrong report, kindly ignore it. We will fix the issue
in earliest time.

> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm85.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm80.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm75.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm63.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lochnagar-hwmon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lineage-pem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/jc42.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ina2xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/iio_hwmon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ibmaem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gpio-fan.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gl520sm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/g760a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f75375s.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f71882fg.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f71805f.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc6w201.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc1403.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds1621.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds620.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/da9052-hwmon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/aspeed-pwm-tacho.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7470.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7x10.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ads7828.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1031.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1029.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1026.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adcxx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adc128d818.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ad7414.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ad7314.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83795.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83793.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83792d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83773g.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83627hf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/hwmon-vid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/pps/pps_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/gameport/lightning.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/gameport/gameport.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/uio/uio_dmem_genirq.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hsi/hsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hsi/clients/hsi_char.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ubi/gluebi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ubi/ubi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/spi-nor/spi-nor.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtdswap.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtdoops.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/sm_ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ssfdc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/inftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtdblock.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtd_blkdevs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_nandecctest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_torturetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_subpagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_stresstest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_speedtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_pagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_oobtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/nandcore.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/raw/cadence-nand-controller.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/raw/nandsim.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/raw/nand.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/sst25l.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/block2mtd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/slram.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/devices/docg3.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/lpddr/lpddr_cmds.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/lpddr/qinfo_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/gen_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_util.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/parsers/redboot.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/greybus/gb-light.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/greybus/gb-hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/most/dim2/most_dim2.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/iio/impedance-analyzer/ad5933.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/vhost/vhost_vdpa.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/crypto/virtio/virtio_crypto.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/crypto/ccree/ccree.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-dac124s085.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-pca963x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-pca9532.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-mt6323.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-lm3697.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/leds/leds-is31fl32xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/memstick/core/ms_block.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/core/mmc_test.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/core/mmc_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/cqhci.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/mtk-sd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mmc/host/sdhci.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/dm-writecache.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/dm-era.ko] undefined!
> >> ERROR: modpost: "__mulsi3" [drivers/md/dm-ebs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/dm-cache-smq.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/dm-raid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/md-mod.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/raid456.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/raid10.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/raid1.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/md/raid0.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/i2c/i2c-stub.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/joydev.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/input/ff-memless.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/auxdisplay/panel.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/auxdisplay/charlcd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/cdrom/cdrom.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/spi/spi-loopback-test.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/target_core_pscsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/ata/libahci.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/nvme/target/nvme-fcloop.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/nvme/target/nvmet-fc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/nvme/target/nvme-loop.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/nvme/target/nvmet.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/scsi/sr_mod.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/scsi/sd_mod.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/scsi/virtio_scsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/echo/echo.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/c2port/core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/tsl2550.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/isl29020.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/isl29003.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/bh1770glc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/ics932s401.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/lis3lv02d/lis3lv02d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/misc/eeprom/at25.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/block/virtio_blk.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/block/pktcdvd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/vgem/vgem.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/tiny/st7586.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/ti-sn65dsi86.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/bridge/sil-sii8620.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpu/drm/i2c/ch7006.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/tpm/tpm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/hw_random/timeriomem-rng.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/hw_random/rng-core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/virtio_console.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/goldfish.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/xilinx_uartps.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/tty/serial/altera_jtaguart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/wm8994-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/wm8400-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/twl6030-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/twl-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/tps65132-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/tps80031-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/tps6586x-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/s2mps11.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/pcf50633-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/qcom_spmi-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/mp886x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/max77693-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/max8660.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/ltc3589.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/lp87565-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/lp872x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/hi6421-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/bd71828-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/as3711-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/regulator/aat2870-regulator.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/dma/idma64.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/dma/fsl-edma-common.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/dma/dw/dw_dmac_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/dma/dmatest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/char/ipmi/ipmi_si.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/fbdev/ssd1307fb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/video/fbdev/ocfb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/gpio/gpio-max3191x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/pinctrl/pinctrl-single.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/phy/cadence/phy-cadence-torrent.ko] undefined!
> ERROR: modpost: "__mulsi3" [block/bfq.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/tcrypt.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/aegis128.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/async_tx/async_raid6_recov.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/async_tx/async_pq.ko] undefined!
> ERROR: modpost: "__mulsi3" [crypto/async_tx/async_memcpy.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/btrfs/btrfs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/befs/befs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/overlayfs/overlay.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/romfs/romfs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/ufs/ufs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/ntfs/ntfs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/cifs/cifs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/hfs/hfs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/hfsplus/hfsplus.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/isofs/isofs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fat/vfat.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fat/fat.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fuse/virtiofs.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/fuse/cuse.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/nls/nls_euc-jp.ko] undefined!
> ERROR: modpost: "__mulsi3" [fs/nfs/nfsv4.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

