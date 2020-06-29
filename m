Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23A2520760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgF2Xz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:55:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:22326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgF2Xz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:55:56 -0400
IronPort-SDR: FEJTXM986ANjj2Em1JNVqtCcmRGRPq7lWr3xy+65hnsh0vAhlLEyrO6BMBDXB8/jW3qZOCBg9j
 +IPrDJHqjIUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164119288"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="164119288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:55:55 -0700
IronPort-SDR: lw6/O9l5NVcmLcwzjZrBVsiOaHAMD0Cyf2htX0ulR3pXUwtEy5h3494wNgo6wu8nNp3SITTgK7
 Yu9rRTbrDcCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480967388"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2020 16:55:53 -0700
Date:   Tue, 30 Jun 2020 07:55:51 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Dragos Bogdan <dragos.bogdan@analog.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [kbuild-all] ERROR: "__mulsi3" undefined!
Message-ID: <20200629235551.GA15089@intel.com>
References: <202006300219.m1VHHe5d%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006300219.m1VHHe5d%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:46:22AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
> commit: f26e433185cb2830b933df3a4d378558fe2fccd9 arch: nios2: Enable the common clk subsystem on Nios2
> date:   3 months ago
> config: nios2-randconfig-r033-20200629 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f26e433185cb2830b933df3a4d378558fe2fccd9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
Sorry for the noise, kindly ignore this false positive report.

> 
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9v011.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9t001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9m032.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/mt9m001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov13858.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov9650.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov8856.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov7740.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov772x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov7670.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov7251.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov5675.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov5645.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/ov2680.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/sony-btf-mpx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/wm8739.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tvp514x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tvp5150.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/bt819.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv7842.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv7604.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/adv748x/adv748x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/saa6752hs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/saa717x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/tvaudio.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/aptina-pll.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/m5mols/m5mols.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/cx25840/cx25840.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/smiapp/smiapp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/media/i2c/msp3400.ko] undefined!
>    ERROR: "__mulsi3" [drivers/i2c/i2c-stub.ko] undefined!
>    ERROR: "__mulsi3" [drivers/i2c/busses/i2c-xiic.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/misc/max8997_haptic.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/turbografx.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/tmdc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/interact.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/grip_mp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/input/joystick/gamecon.ko] undefined!
>    ERROR: "__mulsi3" [drivers/auxdisplay/panel.ko] undefined!
>    ERROR: "__mulsi3" [drivers/auxdisplay/charlcd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/cdrom/cdrom.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/rfd_ftl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/inftl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_torturetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_subpagetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_stresstest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_speedtest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_pagetest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/tests/mtd_oobtest.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/nand/raw/nandsim.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/nand/raw/diskonchip.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/lpddr/lpddr_cmds.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/lpddr/qinfo_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/jedec_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/gen_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_util.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mtd/chips/cfi_probe.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvmet-fc.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvme-loop.ko] undefined!
>    ERROR: "__mulsi3" [drivers/nvme/target/nvmet.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/ses.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/ch.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/virtio_scsi.ko] undefined!
>    ERROR: "__mulsi3" [drivers/scsi/libsas/libsas.ko] undefined!
>    ERROR: "__mulsi3" [drivers/mfd/si476x-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/misc/echo/echo.ko] undefined!
>    ERROR: "__mulsi3" [drivers/block/virtio_blk.ko] undefined!
>    ERROR: "__mulsi3" [drivers/block/pktcdvd.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/xillybus/xillybus_core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/tpm/tpm.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/pcmcia/synclink_cs.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/ppdev.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/hw_random/rng-core.ko] undefined!
>    ERROR: "__mulsi3" [drivers/char/lp.ko] undefined!
>    ERROR: "__mulsi3" [drivers/tty/serial/altera_uart.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/wm8994-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/twl6030-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/twl-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/s5m8767.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/pv88090-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/pv88080-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/qcom_spmi-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/mcp16502.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max77693-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max8907-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max8660.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/max1586.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp8788-ldo.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp8788-buck.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp873x-regulator.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/lp872x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/regulator/88pg86x.ko] undefined!
>    ERROR: "__mulsi3" [drivers/soc/xilinx/xlnx_vcu.ko] undefined!
>    ERROR: "__mulsi3" [drivers/dma/idma64.ko] undefined!
>    ERROR: "__mulsi3" [drivers/clk/clk-si570.ko] undefined!
>    ERROR: "__mulsi3" [drivers/clk/clk-si5351.ko] undefined!
> >> ERROR: "__mulsi3" [drivers/clk/clk-lochnagar.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/fbdev/ocfb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/fbdev/metronomefb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/pwm_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/lp8788_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/video/backlight/lm3630a_bl.ko] undefined!
>    ERROR: "__mulsi3" [drivers/gpio/gpio-dwapb.ko] undefined!
>    ERROR: "__mulsi3" [drivers/pinctrl/pinctrl-single.ko] undefined!
>    ERROR: "__mulsi3" [drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.ko] undefined!
>    ERROR: "__mulsi3" [block/kyber-iosched.ko] undefined!
>    ERROR: "__mulsi3" [crypto/tcrypt.ko] undefined!
>    ERROR: "__mulsi3" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
>    ERROR: "__mulsi3" [fs/gfs2/gfs2.ko] undefined!
>    ERROR: "__mulsi3" [fs/befs/befs.ko] undefined!
>    ERROR: "__mulsi3" [fs/nilfs2/nilfs2.ko] undefined!
>    ERROR: "__mulsi3" [fs/orangefs/orangefs.ko] undefined!
>    ERROR: "__mulsi3" [fs/overlayfs/overlay.ko] undefined!
>    ERROR: "__mulsi3" [fs/fuse/fuse.ko] undefined!
>    ERROR: "__mulsi3" [fs/cifs/cifs.ko] undefined!
>    ERROR: "__mulsi3" [fs/sysv/sysv.ko] undefined!
>    ERROR: "__mulsi3" [fs/fat/vfat.ko] undefined!
>    ERROR: "__mulsi3" [fs/fat/fat.ko] undefined!
>    ERROR: "__mulsi3" [fs/nls/nls_euc-jp.ko] undefined!
>    ERROR: "__mulsi3" [fs/nfs/nfsv4.ko] undefined!
>    ERROR: "__mulsi3" [fs/quota/quota_tree.ko] undefined!
>    ERROR: "__mulsi3" [mm/zsmalloc.ko] undefined!
>    ERROR: "__mulsi3" [mm/zpool.ko] undefined!
>    ERROR: "__mulsi3" [kernel/rcu/rcutorture.ko] undefined!
>    ERROR: "__mulsi3" [kernel/locking/locktorture.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

